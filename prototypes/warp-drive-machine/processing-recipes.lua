local wdm_processing_recipes = { {
    name_root = "warponium-processing-wdm",
    icon = "__Warp-Drive-Machine__/graphics/icon/warponium-plate.png",
    order_name = "a[smelting]-a[alumina-plate]",
    ingredients = { {
        type = "item",
        name = "wdm-ore-warponium",
        amount = 15
    } },
    results = { {
        type = "item",
        name = "warponium-plate",
        amount_min = 7,
        amount_max = 8
    } }
} }
debugLog("Adding warp drive machine processing recipes")
for _, recipe in ipairs(wdm_processing_recipes) do
    table.insert(processing_recipes, recipe)
end
