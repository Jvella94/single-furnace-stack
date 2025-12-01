local lignumis_processing_recipes = {{
    name_root = "gold-processing-lignumis",
    icon = "__lignumis-assets__/graphics/icons/gold-plate.png",
    order_name = "a[smelting]-0[gold-plate]",
    ingredients = {{
        type = "item",
        name = "gold-ore",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "gold-plate",
        amount = 15
    }}
}}
debugLog("Adding lignumis industry processing recipes")
for _, recipe in ipairs(lignumis_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
