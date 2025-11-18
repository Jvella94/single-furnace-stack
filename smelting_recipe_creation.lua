require("prototypes.vanilla.processing_recipes")
require("prototypes.krastorio.processing_recipes")

local techs = data.raw["technology"]

local function GetHiddenStatusForRecipe(recipe_name)
    if k2_remove_vanilla_smelting and (string.find(recipe_name, "vanilla") ~= nil) then
        return true
    end
    if k2_remove_krastorio_smelting and krastorio_found and (string.find(recipe_name, "k2") ~= nil) then
        return true
    end
    return false
end

local function make_recipe(recipe, tier, index)
    local mult = tier.speed / 15
    local multiplied_ingredients = {}
    for _, ing in pairs(recipe.ingredients) do
        table.insert(multiplied_ingredients, {
            type = "item",
            name = ing.name,
            amount = ing.amount * mult
        })
    end
    local multiplied_results = {}
    for _, res in pairs(recipe.results) do
        if res.amount_min and res.amount_max then
            table.insert(multiplied_results, {
                type = "item",
                name = res.name,
                amount_min = res.amount_min * mult,
                amount_max = res.amount_max * mult
            })
        else
            table.insert(multiplied_results, {
                type = "item",
                name = res.name,
                amount = res.amount * mult
            })
        end
    end
    local order_suffix
    if tier.previous_tier_suffix == nil then
        order_suffix = "a" -- first/baseline
    else
        order_suffix = string.char(96 + index) -- 'b', 'c', 'd', etc.
    end
    local recipe_hidden = GetHiddenStatusForRecipe(recipe.name_root)
    return {
        type = "recipe",
        name = recipe.name_root .. "-" .. tier.shortname,
        localised_name = {"recipe-name." .. recipe.name_root .. "-" .. tier.shortname},
        category = tier.category,
        enabled = false,
        hidden = k2_remove_vanilla_smelting and (string.find(recipe.name_root, "vanilla") ~= nil),
        energy_required = 1,
        ingredients = multiplied_ingredients,
        results = multiplied_results,
        order = recipe.order_name .. order_suffix,
        icons = make_layered_icon(recipe.icon, tier.icon)
    }
end

local function create_smelting_recipes(recipe)
    local tiered_recipes = {}
    for index, tier in ipairs(belt_tiers) do
        if techs[tier.belt_tech] then
            table.insert(techs[tier.belt_tech].effects, {
                type = "unlock-recipe",
                recipe = recipe.name_root .. "-" .. tier.shortname
            })
        end
        local recipe_created = make_recipe(recipe, tier, index)
        if tier.previous_tier_suffix == nil then
            recipe_created.enabled = true
        end
        table.insert(tiered_recipes, recipe_created)
    end
    return tiered_recipes
end

local recipes_to_add = {}
for _, recipe in ipairs(processing_recipes) do
    local tiered_recipes = create_smelting_recipes(recipe)
    for _, recipe in ipairs(tiered_recipes) do
        table.insert(recipes_to_add, recipe)
    end
end
data:extend(recipes_to_add)
