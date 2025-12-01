local muluna_processing_recipes = {{
    name_root = "aluminum-processing-muluna",
    icon = "__muluna-graphics__/graphics/icons/metal-plate-aluminium.png",
    order_name = "a[smelting]-a[alumina-plate]",
    ingredients = {{
        type = "item",
        name = "alumina",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "aluminum-plate",
        amount = 15
    }}
}, {
    name_root = "crushed-stone-processing-muluna",
    icon = "__muluna-graphics__/graphics/icons/crushed-stone.png",
    order_name = "a[stone-crushed]",
    ingredients = {{
        type = "item",
        name = "stone-crushed",
        amount = 30
    }},
    results = {{
        type = "item",
        name = "stone-brick",
        amount = 15
    }}
}}
debugLog("Adding muluna industry processing recipes")
for _, recipe in ipairs(muluna_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
