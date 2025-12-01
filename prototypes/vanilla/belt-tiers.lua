-- Define crafting categories
data:extend({{
    type = "recipe-category",
    name = "smelting-basic-belt"
}, {
    type = "recipe-category",
    name = "smelting-fast-belt"
}, {
    type = "recipe-category",
    name = "smelting-express-belt"
}})

local vanilla_tiers = {{
    shortname = "basic",
    suffix = "basic-belt",
    icon = "__base__/graphics/icons/transport-belt.png",
    speed = 15,
    category = "smelting-basic-belt",
    belt_tech = "logistics",
    previous_tier_suffix = nil
}, {
    shortname = "fast",
    suffix = "fast-belt",
    icon = "__base__/graphics/icons/fast-transport-belt.png",
    speed = 30,
    category = "smelting-fast-belt",
    belt_tech = "logistics-2",
    previous_tier_suffix = "basic-belt"
}, {
    shortname = "express",
    suffix = "express-belt",
    icon = "__base__/graphics/icons/express-transport-belt.png",
    speed = 45,
    category = "smelting-express-belt",
    belt_tech = "logistics-3",
    previous_tier_suffix = "fast-belt"
}}

for _, tier in ipairs(vanilla_tiers) do
    table.insert(belt_tiers, tier)
end
