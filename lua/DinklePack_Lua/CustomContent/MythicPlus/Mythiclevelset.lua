--[[local SPELL_IDS = {
    107081, 107082, 107083, 107084, 107085, 107086,
    107087, 107088, 107089, 107090, 107091
}
local REFRESH_INTERVAL = 2000 
local RANGE = 100
local playerEvents = {}

local function RefreshCreatureLevels(eventId, delay, repeats, player)
    print("Refreshing Mythic creature levels for player "..player:GetName())
    local playerLevel = player:GetLevel()
    local creaturesInRange = player:GetCreaturesInRange(RANGE)

    for _, creature in ipairs(creaturesInRange) do
        local creatureID = creature:GetEntry()
        -- Don't adjust the level for creatures with ids between 60000 and 80000
        if creatureID < 60000 or creatureID > 83000 then
            creature:SetLevel(playerLevel + 3)
        end
    end
end

local function OnSpellCast(event, player, spell)
    for _, id in ipairs(SPELL_IDS) do
        if spell:GetEntry() == id then
            playerEvents[player:GetGUID()] = player:RegisterEvent(RefreshCreatureLevels, REFRESH_INTERVAL, 0, player)
            break
        end
    end
end

local function OnPlayerLeaveMap(event, player)
    for _, id in ipairs(SPELL_IDS) do
        if player:HasAura(id) then
            print("Removing Mythic Refresh event for player "..player:GetName())
            player:RemoveEvents(true)  -- Removes all events associated with the player
            player:RemoveAura(id)  -- Remove the specific spell aura
            break
        end
    end
end

RegisterPlayerEvent(28, OnPlayerLeaveMap)
RegisterPlayerEvent(5, OnSpellCast)
]]