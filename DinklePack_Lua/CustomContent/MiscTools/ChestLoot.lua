local MainGameObjectId = 600010
local SecondaryGameObjectIds = {2883, 3705, 3662, 3658, 106318, 2843, 3719, 2849, 3660, 3702, 3703, 3690, 3691, 3693, 3694, 3695, 3707, 3710, 1731, 2055, 3763, 103713, 181248, 1618, 3724, 1617, 3725, 106318, 106319, 1619, 3726}
local SpellId1 = 100273
local SpellId2 = 100124
local SpellId3 = 100218

local function isInTable(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

local MaxXP = {
    1000, 1500, 2000, 2900, 3500, 4500, 4850, 5400, 6500, 7600,
    8800, 10100, 11400, 12900, 14400, 16000, 17700, 19400, 21300, 23200,
    25200, 27300, 29400, 31700, 34000, 36400, 38900, 41400, 44300, 47400,
    50800, 54500, 58600, 62800, 67100, 71600, 76100, 80800, 85700, 90700,
    95800, 101000, 106300, 111800, 117500, 123200, 129100, 135100, 141200, 147500,
    153900, 160400, 167100, 173900, 180800, 187900, 195000, 202300, 209800, 217400
}

local function Chesticles_One_OnGameObjectUse(event, go, player)
    local gameObjectId = go:GetEntry()
    local guid = go:GetGUIDLow()
    local playerGuid = player:GetGUIDLow()
    local playerLevel = player:GetLevel()
    local queryResult = CharDBQuery(string.format("SELECT * FROM custom_chest_loots WHERE PlayerGUID = %d AND ChestGUID = %d", playerGuid, guid))

    -- Add a multiplier for experience points based on whether the player has the specific item.
    local experienceMultiplier = 1
    if player:HasItem(800048) then
        experienceMultiplier = 0.5
    end

    if gameObjectId == MainGameObjectId then
        if not queryResult then
            CharDBExecute(string.format("INSERT INTO custom_chest_loots (PlayerGUID, ChestGUID) VALUES (%d, %d)", playerGuid, guid))
            CharDBExecute(string.format("INSERT INTO custom_player_chest_count (PlayerGUID, ChestsCount) VALUES (%d, 1) ON DUPLICATE KEY UPDATE ChestsCount = ChestsCount + 1", playerGuid))

            if playerLevel < 60 then
                local ExperienceIncrease = MaxXP[playerLevel] * 0.05 * experienceMultiplier
                player:GiveXP(ExperienceIncrease)
                player:SendBroadcastMessage("You've gained an additional " .. ExperienceIncrease .. " experience!")
            else
                player:SendBroadcastMessage("You can't receive experience from chests at level 60.")
            end
        else
            player:SendBroadcastMessage("You can't receive experience from this chest again.")
        end
    elseif isInTable(SecondaryGameObjectIds, gameObjectId) and playerLevel <= 10 then
        local queryResult = CharDBQuery(string.format("SELECT * FROM custom_chest_loots WHERE PlayerGUID = %d AND ChestGUID = %d", playerGuid, guid))

        if not queryResult then
            CharDBExecute(string.format("INSERT INTO custom_chest_loots (PlayerGUID, ChestGUID) VALUES (%d, %d)", playerGuid, guid))
            local ExperienceIncrease = MaxXP[playerLevel] * 0.025 * experienceMultiplier
            player:GiveXP(ExperienceIncrease)
        else
            player:SendBroadcastMessage("You've already received experience from this secondary game object.")
        end
    end

 if gameObjectId == MainGameObjectId then
    local chestCountResult = CharDBQuery(string.format("SELECT ChestsCount FROM custom_player_chest_count WHERE PlayerGUID = %d", playerGuid))

    if chestCountResult then
        local chestsCount = chestCountResult:GetUInt32(0)

        if chestsCount == 500 then
            player:CastSpell(player, 799999, true)
            player:LearnSpell(SpellId3)
            player:SendBroadcastMessage("Congratulations! You've looted 500 chests and learned a new Skyburst rank!")
        elseif chestsCount == 1000 then
            player:CastSpell(player, 799999, true)
            player:LearnSpell(SpellId1)
            player:SendBroadcastMessage("Congratulations! You've looted 1000 chests and learned a new spell!")
        elseif chestsCount == 5000 then
            player:CastSpell(player, 799999, true)
            player:LearnSpell(SpellId2)
            player:SendBroadcastMessage("Congratulations! You've looted 5000 Inconspicuous Chests! Congratulations, you've gained a new mount!")
        end

        -- Casting spell 47004 five times
        for i = 1, 4 do
            player:CastSpell(player, 46847, true)
        end

        player:SendBroadcastMessage("You have looted " .. chestsCount .. " unique inconspicuous chests so far!")
    end
end
end

RegisterGameObjectEvent(MainGameObjectId, 14, Chesticles_One_OnGameObjectUse)

for _, objectID in ipairs(SecondaryGameObjectIds) do
    RegisterGameObjectEvent(objectID, 14, Chesticles_One_OnGameObjectUse)
end


local function createChestLootsTable()
    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS custom_chest_loots (
            PlayerGUID INT,
            ChestGUID INT,
            PRIMARY KEY (PlayerGUID, ChestGUID)
        );
    ]])

    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS custom_player_chest_count (
            PlayerGUID INT PRIMARY KEY,
            ChestsCount INT DEFAULT 0
        );
    ]])
end

createChestLootsTable()
