if mods["Krastorio2-spaced-out"] then
    data:extend({{
        type = "bool-setting",
        name = "use-krastorio-smelting-recipes",
        setting_type = "startup",
        default_value = true,
        forced_value = true,
        order = "a"
    }, {
        type = "bool-setting",
        name = "k2-remove-vanilla-smelting-recipes",
        setting_type = "startup",
        default_value = true,
        order = "b"
    }})
end
if mods["space-age"] then
    data:extend({{
        type = "bool-setting",
        name = "use-space-age-smelting-recipes",
        setting_type = "startup",
        default_value = true,
        forced_value = true,
        order = "c"
    }})
end

