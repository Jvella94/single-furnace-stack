local belt_tiers = {{
    suffix = "basic-belt",
    icon = "__base__/graphics/icons/transport-belt.png",
    multiplier = 15,
    category = "smelting-basic-belt",
    belt_tech = nil,
    previous_tier_suffix = nil
}, {
    suffix = "fast-belt",
    icon = "__base__/graphics/icons/fast-transport-belt.png",
    multiplier = 30,
    category = "smelting-fast-belt",
    belt_tech = "logistics-2",
    previous_tier_suffix = "basic-belt"
}, {
    suffix = "express-belt",
    icon = "__base__/graphics/icons/express-transport-belt.png",
    multiplier = 45,
    category = "smelting-express-belt",
    belt_tech = "logistics-3",
    previous_tier_suffix = "fast-belt"
}, {
    suffix = "turbo-belt",
    icon = "__space-age__/graphics/icons/turbo-transport-belt.png",
    multiplier = 60,
    category = "smelting-turbo-belt",
    belt_tech = "turbo-transport-belt",
    previous_tier_suffix = "express-belt"
}}

local furnaces = {{
    name = "stone-furnace",
    icon = "__base__/graphics/icons/stone-furnace.png",
    tech = "stone-furnace",
    order_prefix = "a"
}, {
    name = "steel-furnace",
    icon = "__base__/graphics/icons/steel-furnace.png",
    tech = "advanced-material-processing",
    order_prefix = "b"
}, {
    name = "electric-furnace",
    icon = "__base__/graphics/icons/electric-furnace.png",
    tech = "advanced-material-processing-2",
    order_prefix = "c"
}}

local function duplicate_furnaces(base_name, base_icon_path)
    local base_entity = data.raw["furnace"][base_name]
    if not base_entity then
        error("Furnace prototype '" .. base_name .. "' not found")
    end

    for _, tier in ipairs(belt_tiers) do
        local furnace = table.deepcopy(base_entity)
        furnace.name = base_name .. "-" .. tier.suffix
        furnace.localised_name = {"entity-name." .. base_name .. "-" .. tier.suffix}

        local energy_val = tonumber(furnace.energy_usage:match("(%d+)"))
        local energy_unit = furnace.energy_usage:match("%d+(%a+)")
        furnace.energy_usage = tostring(energy_val * (tier.multiplier / 15) * 76.8) .. energy_unit

        furnace.crafting_categories = {tier.category}
        furnace.minable.result = furnace.name

        furnace.icons = make_layered_icon(base_icon_path, tier.icon)

        data:extend{furnace}
    end
end

local function create_furnace_items(base_item_name, base_icon_path, order_prefix)
    for index, tier in ipairs(belt_tiers) do
        local order_suffix
        if tier.previous_tier_suffix == nil then
            order_suffix = "a" -- first/baseline
        else
            order_suffix = string.char(97 + index) -- 'b', 'c', 'd', etc.
        end
        data:extend({{
            type = "item",
            name = base_item_name .. "-" .. tier.suffix,
            icons = make_layered_icon(base_icon_path, tier.icon),
            subgroup = "smelting-machine",
            order = order_prefix .. "[" .. base_item_name .. "]-" .. order_suffix,
            place_result = base_item_name .. "-" .. tier.suffix,
            stack_size = 50,
            enabled = false
        }})
    end
end

local function create_furnace_recipes(base_item_name, order_prefix)
    for index, tier in ipairs(belt_tiers) do
        local ingredients = {}

        if tier.previous_tier_suffix == nil then
            -- Basic tier: ingredient is just the original furnace
            table.insert(ingredients, {
                type = "item",
                name = base_item_name,
                amount = 1
            })
        else
            -- Higher tiers: ingredient is one furnace from previous tier
            table.insert(ingredients, {
                type = "item",
                name = base_item_name .. "-" .. tier.previous_tier_suffix,
                amount = 1
            })
        end

        local order_suffix
        if tier.previous_tier_suffix == nil then
            order_suffix = "a" -- first/baseline
        else
            order_suffix = string.char(97 + index) -- 'b', 'c', 'd', etc.
        end

        local recipe = {
            type = "recipe",
            name = base_item_name .. "-" .. tier.suffix,
            enabled = (tier.belt_tech == nil), -- Automatically enabled if no belt tech prerequisite
            ingredients = ingredients,
            results = {{
                type = "item",
                name = base_item_name .. "-" .. tier.suffix,
                amount = 1
            }},
            energy_required = 1,
            order = order_prefix .. "[" .. base_item_name .. "]" .. order_suffix
        }
        data:extend{recipe}
    end
end

local function add_unlocks_to_technology(base_item_name)
    for _, tier in ipairs(belt_tiers) do
        if tier.belt_tech then
            local tech = data.raw.technology[tier.belt_tech]
            if tech and tech.effects then
                table.insert(tech.effects, {
                    type = "unlock-recipe",
                    recipe = base_item_name .. "-" .. tier.suffix
                })
            else
                log("Warning: Technology '" .. tostring(tier.belt_tech) .. "' not found or missing effects field!")
            end
        end
    end
end

for _, furnace in ipairs(furnaces) do
    duplicate_furnaces(furnace.name, furnace.icon)
    create_furnace_items(furnace.name, furnace.icon, furnace.order_prefix)
    create_furnace_recipes(furnace.name, furnace.order_prefix)
    add_unlocks_to_technology(furnace.name)
end
