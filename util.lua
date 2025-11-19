krastorio_found = mods["Krastorio2-spaced-out"]
space_age_found = mods["space-age"]
k2_remove_vanilla_smelting = settings.startup["k2-remove-vanilla-smelting-recipes"].value
k2_remove_krastorio_smelting = settings.startup["k2-remove-krastorio-smelting-recipes"].value
furnace_power_level = settings.startup["furnace-power-level-setting"].value
debug_enabled = settings.startup["enable-debug-messages"].value

function make_layered_icon(primary_icon, secondary_icon)
    return {{
        icon = primary_icon
    }, {
        icon = secondary_icon,
        scale = 0.25,
        shift = {-8, -8}
    }}
end

function printTable(t, indent)
    indent = indent or 0
    for k, v in pairs(t) do
        local formatting = string.rep(" ", indent) .. tostring(k) .. ": "
        if type(v) == "table" then
            log(formatting)
            log(tostring(v) .. indent + 1)
        else
            log(formatting .. tostring(v))
        end
    end
end

function debugLog(logLine)
    if debug_enabled then
        log(logLine)
    end
end

belt_tiers = {}
processing_recipes = {}
furnace_power_level_amounts = {
    ["Vanilla & Space Age"] = 1,
    ["Krastorio 2"] = 200,
    ["Krastorio 2 Doubled"] = 400
}
