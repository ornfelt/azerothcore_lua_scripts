function IsItemAllowedForHouse(item, houseId)
    if houseId == 7 or item.race == 2147483647 or item.race == -1 then 
        return true
    elseif houseId == 2 then -- Alliance AH
        for _, race in ipairs(AllowedAllyRaces) do
            if (bitAnd(item.race, race) ~= 0) then 
                return true
            end
        end
    elseif houseId == 6 then -- Horde AH
        for _, race in ipairs(AllowedHordeRaces) do
            if (bitAnd(item.race, race) ~= 0) then
                return true
            end
        end
    end
    return false
end

function bitAnd(a, b)
    local result = 0
    local shift = 0
    while a > 0 or b > 0 do
        -- Check the least significant bit of both numbers
        if a % 2 == 1 and b % 2 == 1 then
            result = result + 2^shift
        end
        -- Right shift both numbers by 1 (essentially dividing by 2)
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        shift = shift + 1
    end
    return result
end

function getQualityString(Quality)
    local QualityStrings = {
        [0] = "Gray/Poor",
        [1] = "White/Common",
        [2] = "Green/Uncommon",
        [3] = "Blue/Rare",
        [4] = "Purple/Epic",
        [5] = "Orange/Legendary",
        [6] = "Red/Artifact",
        [7] = "Gold/Heirloom"
    }
    return QualityStrings[Quality]
end