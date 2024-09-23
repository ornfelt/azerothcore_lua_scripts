local ThrallmarTransport = {}

ThrallmarTransport.NPC_ID = 18930
ThrallmarTransport.MOUNT_ID = 31992
ThrallmarTransport.DESTINATION = {X = 141.855, Y = 2673.81, Z = 85.7}
ThrallmarTransport.Z_SPEED = 1850
ThrallmarTransport.MAX_HEIGHT = 72
ThrallmarTransport.CHECK_LOCATION_DELAY = 500
ThrallmarTransport.REPUTATION = {FACTION = 947, AMOUNT = 10}
ThrallmarTransport.TEAM_ALLIANCE = 1

function ThrallmarTransport.CheckLocationAndDismount(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - ThrallmarTransport.DESTINATION.X) <= 1 and math.abs(y - ThrallmarTransport.DESTINATION.Y) <= 1 and math.abs(z - ThrallmarTransport.DESTINATION.Z) <= 1 then
        player:Dismount()
        player:RemoveEventById(eventId)
        local currentReputation = player:GetReputation(ThrallmarTransport.REPUTATION.FACTION)
        player:SetReputation(ThrallmarTransport.REPUTATION.FACTION, currentReputation + ThrallmarTransport.REPUTATION.AMOUNT)
    end
end

function ThrallmarTransport.OnGossipHello(event, player, object)
    if player:GetTeam() == ThrallmarTransport.TEAM_ALLIANCE then
        player:GossipMenuAddItem(0, "Take me to Thrallmar!", 0, 1)
        player:GossipSendMenu(1, object)
        return true
    end
    return false
end

function ThrallmarTransport.OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid == 1 then
        player:GossipComplete()       
        player:Mount(ThrallmarTransport.MOUNT_ID)       
        player:MoveJump(ThrallmarTransport.DESTINATION.X, ThrallmarTransport.DESTINATION.Y, ThrallmarTransport.DESTINATION.Z, ThrallmarTransport.Z_SPEED, ThrallmarTransport.MAX_HEIGHT)        
        player:RegisterEvent(ThrallmarTransport.CheckLocationAndDismount, ThrallmarTransport.CHECK_LOCATION_DELAY, 150) 
    end
end

RegisterCreatureGossipEvent(ThrallmarTransport.NPC_ID, 1, ThrallmarTransport.OnGossipHello)
RegisterCreatureGossipEvent(ThrallmarTransport.NPC_ID, 2, ThrallmarTransport.OnGossipSelect)
