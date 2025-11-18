require("util")
require("prototypes.vanilla.recipe-categories")
if (use_space_age) then
    require("prototypes.space-age.recipe-categories")
end
require("prototypes.vanilla.belt-tiers")
if (use_space_age) then
    require("prototypes.space-age.belt-tiers")
end
require("smelting_recipe_creation")

require("prototypes.create-furnaces")
