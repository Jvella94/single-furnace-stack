if mods["Krastorio2-spaced-out"] then
    data:extend({{
        type = "bool-setting",
        name = "use-krastorio-smelting-recipes",
        setting_type = "startup",
        defaukt__value = true,
        forced_value = true,
        order = "a"
    }})
end
if mods["space-age"] then
    data:extend({{
        type = "bool-setting",
        name = "use-space-age-smelting-recipes",
        setting_type = "startup",
        defaukt__value = true,
        forced_value = true,
        order = "b"
    }})
end

