local belt_tiers = {{
    name = "basic",
    icon = "__base__/graphics/icons/transport-belt.png",
    speed = 15,
    category = "smelting-basic-belt"
}, {
    name = "fast",
    icon = "__base__/graphics/icons/fast-transport-belt.png",
    speed = 30,
    category = "smelting-fast-belt"
}, {
    name = "express",
    icon = "__base__/graphics/icons/express-transport-belt.png",
    speed = 45,
    category = "smelting-express-belt"
}, {
    name = "turbo",
    icon = "__space-age__/graphics/icons/turbo-transport-belt.png",
    speed = 60,
    category = "smelting-turbo-belt"
}}

local recipes_data = {{
    name_root = "iron-ore-processing",
    ingredients = {{"iron-ore", 15}},
    results = {{
        name = "iron-plate",
        amount = 15
    }}
}, {
    name_root = "copper-ore-processing",
    ingredients = {{"copper-ore", 15}},
    results = {{
        name = "copper-plate",
        amount = 15
    }}
}, {
    name_root = "stone-to-stone-brick",
    ingredients = {{"stone", 15}},
    results = {{
        name = "stone-brick",
        amount = 15
    }}
}, {
    name_root = "iron-plate-to-steel",
    ingredients = {{"iron-plate", 5}},
    results = {{
        name = "steel-plate",
        amount = 1
    }},
    kr_extra_ingredients = {{"kr-coke", 3}}
}}

local function round_to_min_max(value)
    local floor_val = math.floor(value)
    local ceil_val = math.ceil(value)
    if floor_val == ceil_val then
        return floor_val, floor_val
    else
        return floor_val, ceil_val
    end
end

local function make_recipe(name_root, tier, ingredients, results, energy_base, is_krastorio, extra_krastorio_ingredients)
    local mult = tier.speed / 15
    local ingr = {}
    for _, ing in pairs(ingredients) do
        table.insert(ingr, {
            type = "item",
            name = ing[1],
            amount = ing[2] * mult
        })
    end
    if is_krastorio and extra_krastorio_ingredients then
        for _, ing in pairs(extra_krastorio_ingredients) do
            table.insert(ingr, {
                type = "item",
                name = ing[1],
                amount = ing[2] * mult
            })
        end
    end

    local ress = {}
    for _, res in pairs(results) do
        if is_krastorio then
            -- Halve the product amounts and round to min/max if necessary
            if res.amount_min and res.amount_max then
                local half_min, half_max = round_to_min_max(res.amount_min * mult / 2),
                    round_to_min_max(res.amount_max * mult / 2)
                table.insert(ress, {
                    type = "item",
                    name = res.name,
                    amount_min = half_min,
                    amount_max = half_max
                })
            else
                local half = res.amount * mult / 2
                local half_min, half_max = round_to_min_max(half)
                table.insert(ress, {
                    type = "item",
                    name = res.name,
                    amount_min = half_min,
                    amount_max = half_max
                })
            end
        else
            if res.amount_min and res.amount_max then
                table.insert(ress, {
                    type = "item",
                    name = res.name,
                    amount_min = res.amount_min * mult,
                    amount_max = res.amount_max * mult
                })
            else
                table.insert(ress, {
                    type = "item",
                    name = res.name,
                    amount = res.amount * mult
                })
            end
        end
    end

    return {
        type = "recipe",
        name = name_root .. "-" .. tier.name .. "-" .. (is_krastorio and "kr" or "vanilla"),
        localised_name = {"recipe-name." .. name_root .. "-" .. tier.name .. "-" .. (is_krastorio and "kr" or "vanilla")},
        category = tier.category,
        enabled = false,
        hidden = true,
        energy_required = 1,
        ingredients = ingr,
        results = ress,
        icons = make_layered_icon("__base__/graphics/icons/" .. results[1].name:gsub("_", "-") .. ".png", tier.icon)
    }
end

local recipes_to_add = {}

for _, rec in pairs(recipes_data) do
    for _, tier in ipairs(belt_tiers) do
        table.insert(recipes_to_add,
            make_recipe(rec.name_root, tier, rec.ingredients, rec.results, 1, false, rec.kr_extra_ingredients))
        table.insert(recipes_to_add,
            make_recipe(rec.name_root, tier, rec.ingredients, rec.results, 1, true, rec.kr_extra_ingredients))
    end
end

data:extend(recipes_to_add)
