-- Vanilla Settings
data.extend({{
    type = "string-setting",
    name = "furnace-power-level-setting",
    setting_type = "startup",
    default_value = "Vanilla & Space Age",
    allowed_values = {"Vanilla & Space Age", "Krastorio 2", "Krastorio 2 Doubled"},
    order = "a"
}, {
    type = "bool-setting",
    name = "enable-debug-messages",
    setting_type = "startup",
    default_value = true,
    order = "b"
}})

-- Krastorio 2 Spaced Out Settings
data:extend({{
    type = "bool-setting",
    name = "k2-remove-vanilla-smelting-recipes",
    setting_type = "startup",
    default_value = mods["Krastorio2-spaced-out"],
    hidden = mods["Krastorio2-spaced-out"] == nil,
    order = "ka"
}, {
    type = "bool-setting",
    name = "k2-remove-krastorio-smelting-recipes",
    setting_type = "startup",
    default_value = false,
    hidden = mods["Krastorio2-spaced-out"] == nil,
    order = "ka"
}})

