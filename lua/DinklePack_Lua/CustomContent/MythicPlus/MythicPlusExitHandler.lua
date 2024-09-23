--[[local ResetDungeon = {}
local ResetSpellIds = {107081, 107082, 107083, 107084, 107085, 107086, 107087, 107088, 107089, 107090, 107091}
local DIFFICULTIES = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10} -- All difficulties

-- Check if spellId is in ResetSpellIds
local function IsResetSpell(spellId)
    for _, id in ipairs(ResetSpellIds) do
        if id == spellId then
            return true
        end
    end
    return false
end

-- Event handler for player casting spell
local function OnPlayerCastSpell(event, player, spell)
    local spellId = spell:GetEntry()

    if IsResetSpell(spellId) then
        local map = player:GetMap()
        if map and map:IsDungeon() then
            local mapId = map:GetMapId()
            ResetDungeon[player:GetGUIDLow()] = mapId
        end
    end
end

-- Event handler for player map change
local function OnPlayerMapChange(event, player)
    local playerGUID = player:GetGUIDLow()

    if ResetDungeon[playerGUID] then
        local currentMap = player:GetMap()

        if currentMap then
            local currentMapId = currentMap:GetMapId()
            local storedMapId = ResetDungeon[playerGUID]

            if currentMapId ~= storedMapId then
                for _, difficulty in ipairs(DIFFICULTIES) do
                player:UnbindInstance(storedMapId, difficulty) -- Unbind for all difficulties
                end
                ResetDungeon[playerGUID] = nil
                for _, spellId in ipairs(ResetSpellIds) do
                    if player:HasAura(spellId) then
                        player:RemoveAura(spellId)
                    end
                end
                player:SendNotification("Abandoning the instance has resulted in a reset of your dungeon. All progress has been lost.")
            end
        end
    end
end

RegisterPlayerEvent(5, OnPlayerCastSpell) -- PLAYER_EVENT_ON_CAST_SPELL
RegisterPlayerEvent(28, OnPlayerMapChange) -- PLAYER_EVENT_ON_MAP_CHANGE
]]