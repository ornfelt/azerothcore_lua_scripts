local BGRefreshBuff = {}

BGRefreshBuff.ENABLE_SCRIPT = true
BGRefreshBuff.REFRESH_INTERVAL = 5000
BGRefreshBuff.MAP_IDS = {529, 489}
BGRefreshBuff.PLAYER_LEVEL = 60
BGRefreshBuff.REFRESH_AURA_ID = 80020
BGRefreshBuff.EVENT_KEY = "BG_REFRESH_EVENT_ID"

function BGRefreshBuff.IsMapIDValid(mapId)
    for _, validMapId in ipairs(BGRefreshBuff.MAP_IDS) do
        if mapId == validMapId then
            return true
        end
    end
    return false
end

function BGRefreshBuff.ApplyBuffToCreaturesInRange(player, apply)
    if not BGRefreshBuff.ENABLE_SCRIPT then
        return
    end
    local range = 1000
    local creaturesInRange = player:GetCreaturesInRange(range)

    for _, creature in ipairs(creaturesInRange) do
        if creature:GetInstanceId() == player:GetInstanceId() then
            if apply then
                if not creature:HasAura(BGRefreshBuff.REFRESH_AURA_ID) then
                    creature:AddAura(BGRefreshBuff.REFRESH_AURA_ID, creature)
                    creature:SetLevel(BGRefreshBuff.PLAYER_LEVEL)
                    print("Applying debuff to npcbot", creature:GetEntry())
                end
            else
                creature:RemoveAura(BGRefreshBuff.REFRESH_AURA_ID)
            end
        end
    end
end

function BGRefreshBuff.RefreshBuff(eventId, delay, repeats, player)
    if not BGRefreshBuff.ENABLE_SCRIPT or not BGRefreshBuff.IsMapIDValid(player:GetMapId()) then
        print("BG_RefreshBuff: Player is not in a valid map")
        player:RemoveEventById(player:GetData(BGRefreshBuff.EVENT_KEY))
        BGRefreshBuff.ApplyBuffToCreaturesInRange(player, false)
        player:SendBroadcastMessage("You have left the map. Event has been reset.")
        return
    end

    BGRefreshBuff.ApplyBuffToCreaturesInRange(player, true)
    print("Running BG_RefreshBuff")
end

function BGRefreshBuff.OnPlayerMapChange(event, player)
    if not BGRefreshBuff.ENABLE_SCRIPT then
        return
    end

    if player:GetLevel() == 60 then
        local mapId = player:GetMapId()
        print("Player mapId: ", mapId)

        if BGRefreshBuff.IsMapIDValid(mapId) then
            if not player:GetData(BGRefreshBuff.EVENT_KEY) then
                local eventId = player:RegisterEvent(BGRefreshBuff.RefreshBuff, BGRefreshBuff.REFRESH_INTERVAL, 0, player)
                player:SetData(BGRefreshBuff.EVENT_KEY, eventId)
                BGRefreshBuff.ApplyBuffToCreaturesInRange(player, true)
            end
        else
            local eventId = player:GetData(BGRefreshBuff.EVENT_KEY)
            if eventId then
                player:RemoveEventById(eventId)
                player:SetData(BGRefreshBuff.EVENT_KEY, nil)
                BGRefreshBuff.ApplyBuffToCreaturesInRange(player, false)
                player:SendBroadcastMessage("You have left the map. Event has been reset.")
            end
        end
    end
end

RegisterPlayerEvent(28, BGRefreshBuff.OnPlayerMapChange)
