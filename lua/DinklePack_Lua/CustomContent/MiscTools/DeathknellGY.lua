local DeathKnellRespawnManager = {}

DeathKnellRespawnManager.NEW_AREA_ID = 5692

DeathKnellRespawnManager.RESPAWN_LOCATIONS = {
    {map = 0, x = 1708.75, y = 1643.5, z = 124.831, o = 3.162}
}

local function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

local function TeleportAndRevive(player, location)
    player:Teleport(location.map, location.x, location.y, location.z, location.o)
    player:ResurrectPlayer(100, false)
end

function DeathKnellRespawnManager.PlayerReleasesSpirit(event, player)
    local playerMap = player:GetMap()
    local playerX, playerY, playerZ = player:GetX(), player:GetY(), player:GetZ()

    local playerAreaId = playerMap:GetAreaId(playerX, playerY, playerZ)

    local closestLocation = DeathKnellRespawnManager.RESPAWN_LOCATIONS[1]
    local closestDistance = distance(playerX, playerY, closestLocation.x, closestLocation.y)

    if playerAreaId == DeathKnellRespawnManager.NEW_AREA_ID then
        player:RegisterEvent(function(_, _, _, p) TeleportAndRevive(p, closestLocation) end, 2000, 1)
    end
end

RegisterPlayerEvent(6, DeathKnellRespawnManager.PlayerReleasesSpirit)
