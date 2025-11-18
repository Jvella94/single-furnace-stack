local belt_tiers = {{
    suffix = "basic-belt",
    icon = "__base__/graphics/icons/transport-belt.png",
    multiplier = 15,
    category = "smelting-basic-belt"
}, {
    suffix = "fast-belt",
    icon = "__base__/graphics/icons/fast-transport-belt.png",
    multiplier = 30,
    category = "smelting-fast-belt"
}, {
    suffix = "express-belt",
    icon = "__base__/graphics/icons/express-transport-belt.png",
    multiplier = 45,
    category = "smelting-express-belt"
}, {
    suffix = "turbo-belt",
    icon = "__space-age__/graphics/icons/turbo-transport-belt.png",
    multiplier = 60,
    category = "smelting-turbo-belt"
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

        -- Multiply energy usage
        local energy_val = tonumber(furnace.energy_usage:match("(%d+)"))
        local energy_unit = furnace.energy_usage:match("%d+(%a+)")
        furnace.energy_usage = tostring(energy_val * tier.multiplier) .. energy_unit

        -- Assign crafting category for tier
        furnace.crafting_categories = {tier.category}

        -- Update minable result to new entity name
        furnace.minable.result = furnace.name

        -- Layer base icon with belt icon overlay
        furnace.icons = make_layered_icon(base_icon_path, tier.icon)

        data:extend{furnace}
    end
end

-- Usage example, duplicate stone, steel, and electric furnaces:
duplicate_furnaces("stone-furnace", "__base__/graphics/icons/stone-furnace.png")
duplicate_furnaces("steel-furnace", "__base__/graphics/icons/steel-furnace.png")
duplicate_furnaces("electric-furnace", "__base__/graphics/icons/electric-furnace.png")
