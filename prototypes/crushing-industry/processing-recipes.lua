local crush_processing_recipes = {{
    name_root = "crushed-iron-ore-processing",
    icons = {{
        icon = "__crushing-industry__/graphics/icons/crushed-iron-ore.png",
        shift = {-12, -12},
        scale = 0.4
    }, {
        icon = "__base__/graphics/icons/iron-plate.png",
        draw_background = true
    }},
    order_name = "a[smelting]-a[iron-plate]-c[crushed]",
    ingredients = {{
        type = "item",
        name = "crushed-iron-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "iron-plate",
        amount = 15
    }}
}, {
    name_root = "crushed-copper-ore-processing",
    icons = {{
        icon = "__crushing-industry__/graphics/icons/crushed-copper-ore.png",
        shift = {-12, -12},
        scale = 0.4
    }, {
        icon = "__base__/graphics/icons/copper-plate.png",
        draw_background = true
    }},
    order_name = "a[smelting]-b[copper-plate]-c[crushed]",
    ingredients = {{
        type = "item",
        name = "crushed-copper-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "copper-plate",
        amount = 15
    }}
}}
debugLog("Adding crushing industry processing recipes")
for _, recipe in ipairs(crush_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
