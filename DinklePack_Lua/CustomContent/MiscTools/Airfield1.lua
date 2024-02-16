local PlatformTransport = {}

PlatformTransport.NPC_ID = 90002
PlatformTransport.DESTINATION = {
    X = -4492,
    Y = -1588,
    Z = 509
}
PlatformTransport.CHECK_LOCATION_DELAY = 500 

local function CheckLocationAndResetDisplayId(eventId, delay, repeats, player)
    local x, y, z = player:GetLocation()
    if math.abs(x - PlatformTransport.DESTINATION.X) <= 1 and math.abs(y - PlatformTransport.DESTINATION.Y) <= 1 and math.abs(z - PlatformTransport.DESTINATION.Z) <= 1 then
        player:SetDisplayId(player:GetNativeDisplayId())
        player:RemoveEventById(eventId)
    end
end

function PlatformTransport.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "Take me to the Airfield!", 0, 1)
    player:GossipSendMenu(1, creature)
end

function PlatformTransport.OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
        creature:CastSpell(player, 32992, true)
        player:CastSpell(player, 24085, true)
        player:SetDisplayId(25144)
        player:MoveJump(PlatformTransport.DESTINATION.X, PlatformTransport.DESTINATION.Y, PlatformTransport.DESTINATION.Z, 2000, 115)
        player:RegisterEvent(CheckLocationAndResetDisplayId, PlatformTransport.CHECK_LOCATION_DELAY, 200)
    end
end

RegisterCreatureGossipEvent(PlatformTransport.NPC_ID, 1, PlatformTransport.OnGossipHello)
RegisterCreatureGossipEvent(PlatformTransport.NPC_ID, 2, PlatformTransport.OnGossipSelect)
