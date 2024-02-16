local HippogryphTransport = {}

HippogryphTransport.NPC_ID = 3838
HippogryphTransport.QUEST_ID = 6342
HippogryphTransport.MOUNT_ID = 31992
HippogryphTransport.DESTINATION = { X = 6344.46, Y = 557.44, Z = 16 }
HippogryphTransport.Z_SPEED = 1850
HippogryphTransport.MAX_HEIGHT = 30
HippogryphTransport.CHECK_LOCATION_DELAY = 500

function HippogryphTransport.CheckLocationAndDismount(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - HippogryphTransport.DESTINATION.X) <= 1 
        and math.abs(y - HippogryphTransport.DESTINATION.Y) <= 1 
        and math.abs(z - HippogryphTransport.DESTINATION.Z) <= 1 then
        -- The player has reached the destination, dismount them and cancel the event
        player:Dismount()
        player:RemoveEventById(eventId)
    end
end

function HippogryphTransport.OnGossipHello(event, player, object)
    -- Check if the player has the quest
    if player:HasQuest(HippogryphTransport.QUEST_ID) then
        -- Mount the player
        player:Mount(HippogryphTransport.MOUNT_ID)
        -- Move jump to the specified location
        player:MoveJump(
            HippogryphTransport.DESTINATION.X, 
            HippogryphTransport.DESTINATION.Y, 
            HippogryphTransport.DESTINATION.Z, 
            HippogryphTransport.Z_SPEED, 
            HippogryphTransport.MAX_HEIGHT
        )
        -- Check if the player has reached the destination every half second, and dismount them when they have
        player:RegisterEvent(HippogryphTransport.CheckLocationAndDismount, HippogryphTransport.CHECK_LOCATION_DELAY, 200)
        return true
    end
    -- If the player doesn't have the quest, allow the default gossip window to open
    return false
end

RegisterCreatureGossipEvent(HippogryphTransport.NPC_ID, 1, HippogryphTransport.OnGossipHello)
