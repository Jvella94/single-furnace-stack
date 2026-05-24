require("prototypes.vanilla.processing-recipes")
if lignumis_found then
    require("prototypes.lignumis.processing-recipes")
end
if krastorio2SO_found or krastorio2_found then
    require("prototypes.krastorio.processing-recipes")
end
if crushing_industry_found then
    require("prototypes.crushing-industry.processing-recipes")
end
if planet_muluna_found then
    require("prototypes.planet-muluna.processing-recipes")
end
if space_age_found then
    require("prototypes.space-age.processing-recipes")
end
if warp_drive_machine_found then
    require("prototypes.warp-drive-machine.processing-recipes")
end

local techs = data.raw["technology"]

local function GetHiddenStatusForRecipe(recipe_name)
    if space_age_found == false and (recipe_name:sub(- #"-sa") == "-sa") then
        return true
    end
    if krastorio2SO_found or krastorio2_found then
        if k2_remove_vanilla_smelting and (recipe_name:sub(- #"-vanilla") == "-vanilla") then
            return true
        end
        if k2_remove_krastorio_smelting and (recipe_name:sub(- #"-k2") == "-k2") then
            return true
        end
    end
    return false
end

local function GetAverageResult(res, mult, recipe_name_root)
    if res.amount_min and res.amount_max then
        local average_amount = (mult * (res.amount_min + res.amount_max)) / 2
        if math.floor(average_amount) == average_amount then
            return {
                type = "item",
                name = res.name,
                amount = average_amount
            }
        else
            local lower_number = math.floor(average_amount)
            local higher_number = math.ceil(average_amount)
            return {
                type = "item",
                name = res.name,
                amount_min = lower_number,
                amount_max = higher_number
            }
        end
    end
end

local function GetMultipliedIngredients(recipe, mult)
    local ingredients = {}
    for _, ing in pairs(recipe.ingredients) do
        table.insert(ingredients, {
            type = "item",
            name = ing.name,
            amount = ing.amount * mult
        })
    end
    return ingredients
end

local function GetMultipliedResults(recipe, mult)
    local results = {}
    for _, res in pairs(recipe.results) do
        if res.amount_min and res.amount_max then
            table.insert(results, GetAverageResult(res, mult, recipe.name_root))
        else
            table.insert(results, {
                type = "item",
                name = res.name,
                amount = res.amount * mult
            })
        end
    end
    return results
end

local function MakeSmeltingRecipe(recipe, tier, index)
    local belt_speed_multiplier = tier.speed / base_belt_speed
    local multiplied_ingredients = GetMultipliedIngredients(recipe, belt_speed_multiplier)
    local multiplied_results = GetMultipliedResults(recipe, belt_speed_multiplier)
    local order_suffix = tier.previous_tier_suffix == nil and "a" or string.char(96 + index)
    local recipe_hidden = GetHiddenStatusForRecipe(recipe.name_root)

    -- Add recipe to technology effects if applicable
    if techs[tier.belt_tech] and recipe_hidden == false then
        table.insert(techs[tier.belt_tech].effects, {
            type = "unlock-recipe",
            recipe = recipe.name_root .. "-" .. tier.shortname
        })
    end
    local manyicons = false
    local icontable = {}
    if recipe.icons and #recipe.icons > 1 then
        icontable = recipe.icons
        manyicons = true
    else
        icontable = recipe.icon
    end
    return {
        type = "recipe",
        name = recipe.name_root .. "-" .. tier.shortname,
        localised_name = { "recipe-name." .. recipe.name_root .. "-" .. tier.shortname },
        category = tier.category,
        enabled = false,
        hidden = recipe_hidden,
        energy_required = 1,
        ingredients = multiplied_ingredients,
        results = multiplied_results,
        order = recipe.order_name .. order_suffix,
        icons = makeLayeredIcon(icontable, tier.icon, manyicons),
        allow_productivity = true,
        hide_from_player_crafting = true
    }
end

local function CreateTieredSmeltingRecipes(recipe)
    local tiered_recipes = {}
    for index, tier in ipairs(belt_tiers) do
        -- debugLog("Creating tiered smelting recipe for tier: " .. tier.shortname .. " for base recipe: " ..
        --              recipe.name_root .. " with index " .. index)
        local recipe_created = MakeSmeltingRecipe(recipe, tier, index)
        table.insert(tiered_recipes, recipe_created)
    end
    return tiered_recipes
end

local recipes_to_add = {}
for _, recipe in ipairs(processing_recipes) do
    local tiered_recipes = CreateTieredSmeltingRecipes(recipe)
    for _, t_recipe in ipairs(tiered_recipes) do
        table.insert(recipes_to_add, t_recipe)
    end
end
data:extend(recipes_to_add)
