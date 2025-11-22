krastorio_found = mods["Krastorio2-spaced-out"] ~= nil
space_age_found = mods["space-age"] ~= nil
k2_remove_vanilla_smelting = settings.startup["k2-remove-vanilla-smelting-recipes"].value
k2_remove_krastorio_smelting = settings.startup["k2-remove-krastorio-smelting-recipes"].value
furnace_power_level = settings.startup["furnace-power-level-setting"].value
debug_enabled = settings.startup["enable-debug-messages"].value

base_belt_speed = 15
belt_tiers = {}
processing_recipes = {}

function makeLayeredIcon(primary_icon, secondary_icon)
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

function getBaseKeyFromCombinedString(combinedString)
    if type(combinedString) ~= "string" then
        debugLog("Expected string but got " .. type(combinedString))
        printTable(combinedString)
    end
    local trimmed = combinedString:match("^(.-) %(")
    debugLog("Trimmed '" .. combinedString .. "' to '" .. tostring(trimmed) .. "'")
    return trimmed or combinedString
end

function findBeltTierIndexBySuffix(suffix)
    for i, tier in ipairs(belt_tiers) do
        if tier.suffix == suffix then
            return i
        end
    end
    return nil
end
