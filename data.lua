-- Helpers
require("settingsutil")
require("datautil")
local flib_table = require("__flib__.table")

-- Add categories first
require("prototypes.vanilla.recipe-categories")
if (space_age_found) then
    require("prototypes.space-age.recipe-categories")
end
if (krastorio_found) then
    require("prototypes.krastorio.recipe-categories")
end

-- Then belts
require("prototypes.vanilla.belt-tiers")
if (space_age_found) then
    require("prototypes.space-age.belt-tiers")
end
if (krastorio_found) then
    require("prototypes.krastorio.belt-tiers")
end

-- Finally, recipes and furnaces
require("prototypes.smelting-recipe-creation")

require("prototypes.create-furnaces")
if conversion_to_assembling_machine or krastorio_found then
    for _, furnace in pairs(data.raw["furnace"]) do
        for _, tier in ipairs(belt_tiers) do
            if flib_table.find(furnace.crafting_categories, tier.category) then
                furnace_to_assembler(furnace.name)
            end
        end
    end
end
