local vanilla_processing_recipes = {{
    name_root = "iron-ore-processing-vanilla",
    icon = "__base__/graphics/icons/iron-plate.png",
    ingredients = {{
        type = "item",
        name = "iron-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "iron-plate",
        amount = 15
    }}
}, {
    name_root = "copper-ore-processing-vanilla",
    icon = "__base__/graphics/icons/copper-plate.png",
    ingredients = {{
        type = "item",
        name = "copper-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "copper-plate",
        amount = 15
    }}
}, {
    name_root = "stone-to-stone-brick-vanilla",
    icon = "__base__/graphics/icons/stone-brick.png",
    ingredients = {{
        type = "item",
        name = "stone",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "stone-brick",
        amount = 15
    }}
}, {
    name_root = "iron-plate-to-steel-vanilla",
    icon = "__base__/graphics/icons/steel-plate.png",
    ingredients = {{
        type = "item",
        name = "iron-plate",
        amount = 5
    }},
    results = {{
        type = "item",
        name = "steel-plate",
        amount = 1
    }}
}}
for _, recipe in ipairs(vanilla_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
