krastorio2SO_found = mods["Krastorio2-spaced-out"] ~= nil
krastorio2_found = mods["Krastorio2"] ~= nil
space_age_found = mods["space-age"] ~= nil
turbo_belt_found = mods["TurboBelt"] ~= nil
crushing_industry_found = mods["crushing-industry"] ~= nil
planet_muluna_found = mods["planet-muluna"] ~= nil
lignumis_found = mods["lignumis"] ~= nil

k2_remove_vanilla_smelting = settings.startup["k2-remove-vanilla-smelting-recipes"].value
k2_remove_krastorio_smelting = settings.startup["k2-remove-krastorio-smelting-recipes"].value

furnace_power_level = settings.startup["furnace-power-level-setting"].value
debug_enabled = settings.startup["enable-debug-messages"].value
conversion_to_assembling_machine = settings.startup["furnace-to-assembling-machine-conversion"].value

base_belt_speed = 15
belt_tiers = {}
processing_recipes = {}

function makeLayeredIcon(icontable, secondary_icon, manyicons)
    if manyicons then
        local newicontable = {}
        for _, icon in ipairs(icontable) do
            table.insert(newicontable, icon)
        end
        table.insert(newicontable, {
            icon = secondary_icon,
            scale = 0.25,
            shift = {-8, 8}
        })
        return newicontable
    else
        return {{
            icon = icontable
        }, {
            icon = secondary_icon,
            scale = 0.25,
            shift = {-8, -8}
        }}
    end
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

--- Converts a furnace prototype into an assembling machine prototype.
--- @param furnace_name data.EntityID
--- @return data.AssemblingMachinePrototype?
function furnace_to_assembler(furnace_name)
    local furnace = data.raw.furnace[furnace_name]
    if not furnace then
        error("Furnace " .. furnace_name .. " does not exist.")
        return
    end

    local assembler = table.deepcopy(furnace) --[[@as data.AssemblingMachinePrototype]]
    assembler.type = "assembling-machine"
    assembler.source_inventory_size = nil --- @diagnostic disable-line
    data.raw.furnace[furnace_name] = nil
    data:extend({assembler})
    return assembler
end
