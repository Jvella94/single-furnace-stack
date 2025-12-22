require("settingsutil")

-- Vanilla Settings
data.extend({{
    type = "string-setting",
    name = "furnace-power-level-setting",
    setting_type = "startup",
    default_value = vanilla_Name,
    allowed_values = returnTableKeys(furnace_power_level_amounts),
    order = "a"
}, {
    type = "bool-setting",
    name = "enable-debug-messages",
    setting_type = "startup",
    default_value = false,
    order = "b"
}, {
    type = "string-setting",
    name = "ingredient-amount-multiplier",
    setting_type = "startup",
    default_value = returnVanillaNameWithValue(ingredient_multipliers),
    allowed_values = returnTableKeysWithValue(ingredient_multipliers),
    order = "c"
}, {
    type = "bool-setting",
    name = "furnace-to-assembling-machine-conversion",
    setting_type = "startup",
    default_value = false,
    order = "d"
}})

-- Krastorio 2 Spaced Out Settings
data:extend({{
    type = "bool-setting",
    name = "k2-remove-vanilla-smelting-recipes",
    setting_type = "startup",
    default_value = true,
    hidden = mods["Krastorio2-spaced-out"] == nil and mods["Krastorio2"] == nil,
    order = "ka"
}, {
    type = "bool-setting",
    name = "k2-remove-krastorio-smelting-recipes",
    setting_type = "startup",
    default_value = false,
    hidden = mods["Krastorio2-spaced-out"] == nil and mods["Krastorio2"] == nil,
    order = "kb"
}})

