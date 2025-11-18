data.extend({{
    type = "string-setting",
    name = "furnace-power-level-setting",
    setting_type = "startup",
    default_value = "Vanilla & Space Age",
    allowed_values = {"Vanilla & Space Age", "Krastorio 2", "Krastorio 2 Doubled"},
    order = "a"
}})
if mods["Krastorio2-spaced-out"] then
    data:extend({{
        type = "bool-setting",
        name = "krastorio-found",
        setting_type = "startup",
        default_value = true,
        forced_value = true,
        hidden = true,
        order = "ka"
    }, {
        type = "bool-setting",
        name = "k2-remove-vanilla-smelting-recipes",
        setting_type = "startup",
        default_value = true,
        order = "kb"
    }, {
        type = "bool-setting",
        name = "k2-remove-krastorio-smelting-recipes",
        setting_type = "startup",
        default_value = false,
        order = "kc"
    }})
end
if mods["space-age"] then
    data:extend({{
        type = "bool-setting",
        name = "space-age-found",
        setting_type = "startup",
        default_value = true,
        forced_value = true,
        hidden = true,
        order = "z"
    }})
end

