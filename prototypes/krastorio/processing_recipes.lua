local k2_processing_recipes = {{
    name_root = "iron-ore-processing-k2",
    icon = "__base__/graphics/icons/iron-plate.png",
    ingredients = {{
        type = "item",
        name = "iron-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "iron-plate",
        amount_min = 7,
        amount_max = 8
    }}
}, {
    name_root = "copper-ore-processing-k2",
    icon = "__base__/graphics/icons/copper-plate.png",
    ingredients = {{
        type = "item",
        name = "copper-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "copper-plate",
        amount_min = 7,
        amount_max = 8
    }}
}, {
    name_root = "stone-to-stone-brick-k2",
    icon = "__base__/graphics/icons/stone-brick.png",
    ingredients = {{
        type = "item",
        name = "stone",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "stone-brick",
        amount_min = 7,
        amount_max = 8
    }}
}, {
    name_root = "iron-plate-to-steel-k2",
    icon = "__base__/graphics/icons/steel-plate.png",
    ingredients = {{
        type = "item",
        name = "iron-plate",
        amount = 15
    }, {
        type = "item",
        name = "kr-coke",
        amount = 9
    }},
    results = {{
        type = "item",
        name = "steel-plate",
        amount = 3
    }}
}}
for _, recipe in ipairs(k2_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
