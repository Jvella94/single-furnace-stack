local use_krastorio = settings.startup["use-krastorio-smelting-recipes"].value
local use_space_age = settings.startup["use-space-age-smelting-recipes"].value
local techs = data.raw["technology"]

local vanilla_belt_tiers = {"basic", "fast", "express"}
if (use_space_age) then
    table.insert(vanilla_belt_tiers, "turbo")
end

local function make_recipe_names(name_root, is_kr)
    local suffix = is_kr and "kr" or "vanilla"
    local recipes = {}
    for _, tier in ipairs(belt_tiers) do
        table.insert(recipes, name_root .. "-" .. tier .. "-" .. suffix)
    end
    return recipes
end

local vanilla_ore_processing = make_recipe_names("iron-ore-processing", false)
local vanilla_copper_processing = make_recipe_names("copper-ore-processing", false)
local vanilla_stone_brick = make_recipe_names("stone-to-stone-brick", false)
local vanilla_steel = make_recipe_names("iron-plate-to-steel", false)

local kr_ore_processing = make_recipe_names("iron-ore-processing", true)
local kr_copper_processing = make_recipe_names("copper-ore-processing", true)
local kr_stone_brick = make_recipe_names("stone-to-stone-brick", true)
local kr_steel = make_recipe_names("iron-plate-to-steel", true)

local function add_unlocks(tech_name, recipe_list)
    if techs[tech_name] then
        for _, recipe_name in ipairs(recipe_list) do
            table.insert(techs[tech_name].effects, {
                type = "unlock-recipe",
                recipe = recipe_name
            })
        end
    end
end

if use_krastorio then
    for _, recipe_name in ipairs(kr_ore_processing) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    for _, recipe_name in ipairs(kr_copper_processing) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    for _, recipe_name in ipairs(kr_stone_brick) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    for _, recipe_name in ipairs(kr_steel) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    add_unlocks("logistics", {kr_ore_processing[1], kr_copper_processing[1], kr_stone_brick[1], kr_steel[1]})
    add_unlocks("logistics-2", {kr_ore_processing[2], kr_copper_processing[2], kr_stone_brick[2], kr_steel[2]})
    add_unlocks("logistics-3", {kr_ore_processing[3], kr_copper_processing[3], kr_stone_brick[3], kr_steel[3]})
    if (use_space_age) then
        add_unlocks("turbo-transport-belt",
            {kr_ore_processing[4], kr_copper_processing[4], kr_stone_brick[4], kr_steel[4]})
    end

else
    for _, recipe_name in ipairs(vanilla_ore_processing) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    for _, recipe_name in ipairs(vanilla_copper_processing) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    for _, recipe_name in ipairs(vanilla_stone_brick) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    for _, recipe_name in ipairs(vanilla_steel) do
        if data.raw.recipe[recipe_name] then
            data.raw.recipe[recipe_name].hidden = false
        end
    end

    add_unlocks("logistics",
        {vanilla_ore_processing[1], vanilla_copper_processing[1], vanilla_stone_brick[1], vanilla_steel[1]})
    add_unlocks("logistics-2",
        {vanilla_ore_processing[2], vanilla_copper_processing[2], vanilla_stone_brick[2], vanilla_steel[2]})
    add_unlocks("logistics-3",
        {vanilla_ore_processing[3], vanilla_copper_processing[3], vanilla_stone_brick[3], vanilla_steel[3]})
    if (use_space_age) then
        add_unlocks("turbo-transport-belt",
            {vanilla_ore_processing[4], vanilla_copper_processing[4], vanilla_stone_brick[4], vanilla_steel[4]})
    end
end
