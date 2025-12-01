-- Define crafting categories
if krastorio2SO_found then
    local k2_superior = {
        shortname = "superior",
        suffix = "superior-belt",
        icon = "__Krastorio2Assets__/icons/entities/superior-transport-belt.png",
        speed = 90,
        category = "smelting-superior-belt",
        belt_tech = "kr-logistic-5",
        previous_tier_suffix = "turbo-belt"
    }
    table.insert(belt_tiers, k2_superior)
    data:extend({{
        type = "recipe-category",
        name = "smelting-superior-belt"
    }})
elseif krastorio2_found then
    local k2_advanced = {
        shortname = "advanced",
        suffix = "advanced-belt",
        icon = "__Krastorio2Assets__/icons/entities/advanced-transport-belt.png",
        speed = 80,
        category = "smelting-advanced-belt",
        belt_tech = "kr-logistic-4",
        previous_tier_suffix = "express-belt"
    }
    local k2_superior = {
        shortname = "superior",
        suffix = "superior-belt",
        icon = "__Krastorio2Assets__/icons/entities/superior-transport-belt.png",
        speed = 90,
        category = "smelting-superior-belt",
        belt_tech = "kr-logistic-5",
        previous_tier_suffix = "advanced-belt"
    }
    table.insert(belt_tiers, k2_advanced)
    table.insert(belt_tiers, k2_superior)
    data:extend({{
        type = "recipe-category",
        name = "smelting-advanced-belt"
    }, {
        type = "recipe-category",
        name = "smelting-superior-belt"
    }})
end
