local GryphonMasterH = {}

GryphonMasterH.NPC_ID = 18931
GryphonMasterH.MOUNT_ID = 31992
GryphonMasterH.DESTINATION = {x = -669.166, y = 2715.216, z = 94.44}
GryphonMasterH.Z_SPEED = 1850
GryphonMasterH.MAX_HEIGHT = 72
GryphonMasterH.CHECK_LOCATION_DELAY = 500
GryphonMasterH.REPUTATION = {FACTION = 946, AMOUNT = 10}
GryphonMasterH.TEAM_ALLIANCE = 0

function GryphonMasterH.CheckLocationAndDismount(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - GryphonMasterH.DESTINATION.x) <= 1 and math.abs(y - GryphonMasterH.DESTINATION.y) <= 1 and math.abs(z - GryphonMasterH.DESTINATION.z) <= 1 then
        player:Dismount()
        player:RemoveEventById(eventId)
        local currentReputation = player:GetReputation(GryphonMasterH.REPUTATION.FACTION)
        player:SetReputation(GryphonMasterH.REPUTATION.FACTION, currentReputation + GryphonMasterH.REPUTATION.AMOUNT)
    end
end

function GryphonMasterH.OnGossipHello(event, player, object)
    if player:GetTeam() == GryphonMasterH.TEAM_ALLIANCE then
        player:GossipMenuAddItem(0, "Take me to Honor Hold!", 0, 1)
        player:GossipSendMenu(1, object)
        return true
    end
    return false
end

function GryphonMasterH.OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    if intid == 1 then
        player:GossipComplete()
        player:Mount(GryphonMasterH.MOUNT_ID)
        player:MoveJump(GryphonMasterH.DESTINATION.x, GryphonMasterH.DESTINATION.y, GryphonMasterH.DESTINATION.z, GryphonMasterH.Z_SPEED, GryphonMasterH.MAX_HEIGHT)
        player:RegisterEvent(GryphonMasterH.CheckLocationAndDismount, GryphonMasterH.CHECK_LOCATION_DELAY, 150)
    end
end

RegisterCreatureGossipEvent(GryphonMasterH.NPC_ID, 1, GryphonMasterH.OnGossipHello)
RegisterCreatureGossipEvent(GryphonMasterH.NPC_ID, 2, GryphonMasterH.OnGossipSelect)
