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
    local furnace_power_level_chosen = furnace_power_level_amounts[furnace_power_level]
    local base_entity = data.raw["furnace"][base_name]
    if not base_entity then
        error("Furnace prototype '" .. base_name .. "' not found")
    end
    for index, tier in ipairs(belt_tiers) do
        local furnace = table.deepcopy(base_entity)
        furnace.name = base_name .. "-" .. tier.suffix
        furnace.localised_name = {"entity-name." .. base_name .. "-" .. tier.suffix}

        -- Adjust energy usage
        local old_energy_val = tonumber(furnace.energy_usage:match("(%d+)"))
        local new_energy_val = furnace_power_level_chosen.fixed_value and furnace_power_level_chosen.energy or
                                   old_energy_val

        local energy_unit = furnace.energy_usage:match("%d+(%a+)")
        furnace.energy_usage = tostring(new_energy_val * (tier.speed / 15) *
                                            (48 * furnace_power_level_chosen.multiplier)) .. energy_unit

        furnace.energy_source.emissions_per_minute.pollution =
            furnace.energy_source.emissions_per_minute.pollution * (48 * index)

        -- Assign crafting category for tier
        furnace.crafting_categories = {tier.category}

        -- Update minable result to new entity name
        furnace.minable.result = furnace.name

        -- Layer base icon with belt icon overlay
        furnace.icons = makeLayeredIcon(base_icon_path, tier.icon)

        data:extend{furnace}
    end
end

local function create_furnace_items(base_item_name, base_icon_path, order_prefix)
    for index, tier in ipairs(belt_tiers) do
        local order_suffix
        if tier.previous_tier_suffix == nil then
            order_suffix = "a" -- first/baseline
        else
            order_suffix = string.char(96 + index) -- 'b', 'c', 'd', etc.
        end
        data:extend({{
            type = "item",
            name = base_item_name .. "-" .. tier.suffix,
            icons = makeLayeredIcon(base_icon_path, tier.icon),
            subgroup = "smelting-machine",
            order = order_prefix .. "[" .. base_item_name .. "]-" .. order_suffix,
            place_result = base_item_name .. "-" .. tier.suffix,
            stack_size = 50,
            enabled = false
        }})
    end
end

-- Calculates the ingredient amount multiplier based on tier speeds
local function calculateIngredientAmount(belt_tiers, current_suffix, previous_suffix)
    local current_index = findBeltTierIndexBySuffix(current_suffix)
    local previous_index = findBeltTierIndexBySuffix(previous_suffix)

    if not current_index or not previous_index then
        error("Invalid tier suffix provided")
    end

    local current_speed = belt_tiers[current_index].speed
    local previous_speed = belt_tiers[previous_index].speed

    local multiplier = math.floor(current_speed / previous_speed)
    local modulo = current_speed % previous_speed

    return multiplier, modulo
end

-- Constructs the ingredients list for the given tier info
local function buildIngredients(base_item_name, tier, multiplier_setting)
    local ingredients = {}
    local multiplier = multiplier_setting

    if tier.previous_tier_suffix == nil then
        -- Basic tier: just the base item with multiplier
        table.insert(ingredients, {
            type = "item",
            name = base_item_name,
            amount = multiplier
        })
    else
        local prevTierAmount, modulo = calculateIngredientAmount(belt_tiers, tier.suffix, tier.previous_tier_suffix)

        table.insert(ingredients, {
            type = "item",
            name = base_item_name .. "-" .. tier.previous_tier_suffix,
            amount = prevTierAmount
        })

        if modulo ~= 0 then
            table.insert(ingredients, {
                type = "item",
                name = base_item_name,
                amount = multiplier * (modulo / base_belt_speed)
            })
        end
    end

    return ingredients
end

local function create_furnace_recipes(base_item_name, order_prefix)
    for index, tier in ipairs(belt_tiers) do
        local ingredients = {}
        local multiplier_setting = ingredient_multipliers[getBaseKeyFromCombinedString(
            settings.startup["ingredient-amount-multiplier"].value)]
        local ingredients = buildIngredients(base_item_name, tier, multiplier_setting)
        local order_suffix = tier.previous_tier_suffix and string.char(96 + index) or "a"
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
