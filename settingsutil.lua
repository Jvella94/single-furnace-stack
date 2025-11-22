vanilla_Name = "Vanilla"

furnace_power_level_amounts = {
    [vanilla_Name] = {
        energy = 1,
        fixed_value = false,
        multiplier = 1
    },
    ["Krastorio 2"] = {
        energy = 200,
        fixed_value = true,
        multiplier = 0.5
    },
    ["Krastorio 2 Doubled"] = {
        energy = 400,
        fixed_value = true,
        multiplier = 0.5
    }
}

ingredient_multipliers = {
    [vanilla_Name] = 48,
    Cheat = 1,
    Half = 24
}

function returnTableKeys(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

function returnTableKeysWithValue(tbl)
    local keys = {}
    for k, v in pairs(tbl) do
        if v then
            table.insert(keys, k .. " (" .. tostring(v) .. ")")
        end
    end
    return keys
end

function returnVanillaNameWithValue(tbl)
    for k, v in pairs(tbl) do
        if k == vanilla_Name then
            return k .. " (" .. tostring(v) .. ")"
        end
    end
end

