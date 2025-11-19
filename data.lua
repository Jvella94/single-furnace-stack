-- Helpers
require("util")

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
