-- Define crafting categories
data:extend({{
    type = "recipe-category",
    name = "smelting-wood-belt"
}})
local lignumis_wood = {
    shortname = "wood",
    suffix = "wood-belt",
    icon = "__mf-logistics-graphics-1__/graphics/belts/brown/transport-belt-icon.png",
    speed = 7.5,
    category = "smelting-wood-belt",
    belt_tech = "wood-logistics",
    previous_tier_suffix = nil
}
table.insert(belt_tiers, lignumis_wood)
