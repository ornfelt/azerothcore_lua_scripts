local PlatformTransportTwo = {}

PlatformTransportTwo.NPC_ID = 90003
PlatformTransportTwo.DESTINATIONS = {
    {x = -5166.45, y = -877.49, z = 507.39},
    {x = -4028.206, y = -1415.7199, z = 156.94}
}
PlatformTransportTwo.CHECK_LOCATION_DELAY = 500 -- Adjust the delay time based on how long it takes to reach the destination

local function CheckLocationAndResetDisplayId(eventId, delay, repeats, player, destination)
    local x, y, z = player:GetLocation()
    if math.abs(x - destination.x) <= 1 and math.abs(y - destination.y) <= 1 and math.abs(z - destination.z) <= 1 then
        -- The player has reached the destination, reset their display and cancel the event
        player:SetDisplayId(player:GetNativeDisplayId())
        player:RemoveEventById(eventId)
    end
end

function PlatformTransportTwo.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "Take me to Ironforge!", 0, 1)
    player:GossipMenuAddItem(0, "Take me to Wetland Highlands!", 0, 2)
    player:GossipSendMenu(1, creature)
end

function PlatformTransportTwo.OnGossipSelect(event, player, creature, sender, intid, code)
    local destination = PlatformTransportTwo.DESTINATIONS[intid]
    if destination then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(destination.x, destination.y, destination.z, 2000, (intid == 1) and 115 or 70)
        player:RegisterEvent(CheckLocationAndResetDisplayId, PlatformTransportTwo.CHECK_LOCATION_DELAY, 200, destination) 
    end
end

RegisterCreatureGossipEvent(PlatformTransportTwo.NPC_ID, 1, PlatformTransportTwo.OnGossipHello)
RegisterCreatureGossipEvent(PlatformTransportTwo.NPC_ID, 2, PlatformTransportTwo.OnGossipSelect)
