-- Helpers
require("settingsutil")
require("datautil")
local flib_table = require("__flib__.table")

require("prototypes.vanilla.belt-tiers")
if (space_age_found or turbo_belt_found) then
    require("prototypes.space-age.belt-tiers")
end
if (krastorio2SO_found or krastorio2_found) then
    require("prototypes.krastorio.belt-tiers")
end
-- Create the recipes and furnaces
require("prototypes.smelting-recipe-creation")

require("prototypes.create-furnaces")

-- Convert furnaces to assembling machines if the setting is enabled or Krastorio2 is installed
if conversion_to_assembling_machine or krastorio2SO_found or krastorio2_found then
    for _, furnace in pairs(data.raw["furnace"]) do
        for _, tier in ipairs(belt_tiers) do
            if flib_table.find(furnace.crafting_categories, tier.category) then
                furnace_to_assembler(furnace.name)
            end
        end
    end
end
