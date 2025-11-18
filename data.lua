local use_krastorio = settings.startup["use-krastorio-smelting-recipes"].value
local use_space_age = settings.startup["use-space-age-smelting-recipes"].value

require("prototypes.vanilla.recipe-categories")
if (use_space_age) then
    require("prototypes.space-age.recipe-categories")
end
require("prototypes.entities")
require("prototypes.items")
require("prototypes.recipes")
