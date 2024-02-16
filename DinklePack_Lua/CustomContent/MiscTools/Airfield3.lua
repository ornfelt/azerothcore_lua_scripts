local PlatformTransportThree = {}

PlatformTransportThree.NPC_ID = 90004
PlatformTransportThree.DESTINATIONS = {
    [1] = {-5166.45, -877.49, 507.39},
    [2] = {-4492, -1588, 509}
}
PlatformTransportThree.CHECK_LOCATION_DELAY = 500 -- Adjust the delay time based on how long it takes to reach the destination

function PlatformTransportThree.CheckLocationAndResetDisplayId(eventId, delay, repeats, player, destination)
    local x, y, z = player:GetLocation()
    if math.abs(x - destination[1]) <= 1 and math.abs(y - destination[2]) <= 1 and math.abs(z - destination[3]) <= 1 then
        -- The player has reached the destination, reset their display and cancel the event
        player:SetDisplayId(player:GetNativeDisplayId())
        player:RemoveEventById(eventId)
    end
end

function PlatformTransportThree.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "Take me to Ironforge!", 0, 1)
    player:GossipMenuAddItem(0, "Take me to the Airfields!", 0, 2)
    player:GossipSendMenu(1, creature)
end

function PlatformTransportThree.OnGossipSelect(event, player, creature, sender, intid, code)
    local destination = PlatformTransportThree.DESTINATIONS[intid]
    if destination then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(unpack(destination), 2000, 165)
        player:RegisterEvent(PlatformTransportThree.CheckLocationAndResetDisplayId, PlatformTransportThree.CHECK_LOCATION_DELAY, 200, destination)
    end
end

RegisterCreatureGossipEvent(PlatformTransportThree.NPC_ID, 1, PlatformTransportThree.OnGossipHello)
RegisterCreatureGossipEvent(PlatformTransportThree.NPC_ID, 2, PlatformTransportThree.OnGossipSelect)
