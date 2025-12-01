local sa_processing_recipes = {{
    name_root = "lithium-processing-sa",
    icon = "__space-age__/graphics/icons/lithium-plate.png",
    order_name = "c[lithium]-b[lithium-plate]",
    ingredients = {{
        type = "item",
        name = "lithium",
        amount = 15
    }},
    results = {{
        type = "item",
        name = "lithium-plate",
        amount = 15
    }}
}}
debugLog("Adding space age processing recipes")
for _, recipe in ipairs(sa_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
