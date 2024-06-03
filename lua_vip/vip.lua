require "config_vip"
-- Events

ITEM_EVENT_ON_USE = 2
GOSSIP_EVENT_ON_SELECT = 2
PLAYER_EVENT_ON_SPELL_CAST = 5
ELUNA_EVENT_ON_LUA_STATE_CLOSE = 16
PLAYER_EVENT_ON_LOGOUT = 4


-- SpawnTypes
TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN = 2




local function checkVIP(player)
    local query = AuthDBQuery("SELECT * FROM premium WHERE active = 1 AND AccountId = "..player:GetAccountId())
    if query then
        return true
    else
        return false
    end
end

local function clearTempCreatures(player)
    local radiusCreatures = player:GetCreaturesInRange(6)
    for key, creature in pairs(radiusCreatures) do
        if creature:GetData("owner") == player:GetName() then
            creature:DespawnOrUnsummon(0)
        end
    end
end

local function cleanTempNPC(event)
    local worldPlayers = GetPlayersInWorld( 2 )
    for i, player in pairs(worldPlayers) do
        local radiusCreatures = player:GetCreaturesInRange(6)
        for key, creature in pairs(radiusCreatures) do
            if creature:GetData("owner") == player:GetName() then
                creature:DespawnOrUnsummon(0)
            end
        end
    end
end

local function clearPlayerCreatures(event, player)
    local radiusCreatures = player:GetCreaturesInRange(6)
    for key, creature in pairs(radiusCreatures) do
        if creature:GetData("owner") == player:GetName() then
            creature:DespawnOrUnsummon(0)
        end
    end
end


local function OnUseVIP(event, player, item, target)
    
    local isVIP = checkVIP(player)

    if isVIP then
        player:SendAreaTriggerMessage( VIP.Config.Texts.YesVIP )
        player:GossipClearMenu()
        for i, v in pairs(VIP.Config.Actions) do
            if v[1] then
                player:GossipMenuAddItem( 0, v[2], 0, v[3] )
            end
        end
        player:GossipSendMenu( 100, player, 0 )
    else
        player:SendAreaTriggerMessage( VIP.Config.Texts.NoVIP )
    end
    -- Cancel Spell
    return false

end


local function OnGossipSelect(event, player, object, sender, intid, code, menu_id)

    local x = player:GetX()
    local y = player:GetY()
    local z = player:GetZ()
    local o = player:GetO()
    local randomX = math.random(1,3)
    local randomY = math.random(1,3)
    if intid == 0 then
        player:SendShowBank(player)
        player:GossipComplete()
    elseif intid == 1 then
        local team = player:GetTeam()
        clearTempCreatures(player)

        if team == 0 then
            auctioneer = player:SpawnCreature(15659, x + randomX, y + randomY, z+1, o, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000)
        elseif team == 1 then
            auctioneer = player:SpawnCreature(8724, x + randomX, y + randomY, z+1, o, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000)
        else
            player:SendAreaTriggerMessage( VIP.Config.Texts.AuctioneerError )
        end
        auctioneer:SetFaction(player:GetFaction())
        auctioneer:SetData("owner", player:GetName())
        auctioneer:SetScale(0.5)
        auctioneer:MoveFollow( player, 1 )
        auctioneer = nil
    elseif intid == 2 then
        player:SendShowMailBox( player:GetGUIDLow() )
    elseif intid == 3 then

        clearTempCreatures(player)

        xmog = player:SpawnCreature(VIP.Config.TransmorgifierID, x + randomX, y + randomY, z+1, o, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 20000)
        xmog:SetData("owner", player:GetName())
        xmog:SetScale(0.5)
        xmog:MoveFollow( player, 1 )
    elseif intid == 4 then
        player:ResetSpellCooldown( 8690 )
        player:SendAreaTriggerMessage( VIP.Config.Texts.CDReset )
    elseif intid == 5 then
        player:DurabilityRepairAll(false)
        player:SendAreaTriggerMessage( VIP.Config.Texts.Repair )
    elseif intid == 6 then
        clearTempCreatures(player)
        auctioneer = player:SpawnCreature(15681, x + randomX, y + randomY, z+1, o, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000)
        auctioneer:SetFaction(player:GetFaction())
        auctioneer:SetData("owner", player:GetName())
        auctioneer:SetScale(0.5)
        auctioneer:MoveFollow( player, 1 )
        auctioneer = nil
    end
    player:GossipComplete()
end

RegisterPlayerGossipEvent( 0, GOSSIP_EVENT_ON_SELECT, OnGossipSelect )
RegisterItemEvent( VIP.Config.ItemID, ITEM_EVENT_ON_USE, OnUseVIP )
RegisterServerEvent(ELUNA_EVENT_ON_LUA_STATE_CLOSE, cleanTempNPC)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGOUT, clearPlayerCreatures)
