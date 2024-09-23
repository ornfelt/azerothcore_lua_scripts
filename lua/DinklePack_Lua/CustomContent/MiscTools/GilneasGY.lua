local SpiritResurrect = {}

SpiritResurrect.Zone1 = 4714
SpiritResurrect.Zone2 = 5435
SpiritResurrect.Zone3 = 4706

SpiritResurrect.TargetLocations = {
    [1] = {map = 0, x = -1594.44, y = 1904.70, z = 12.98, o = 1.57},
    [2] = {map = 0, x = -1389.73, y = 1373.48, z = 35.75, o = 3.17},
    [3] = {map = 0, x = -1916.49, y = 2577.45, z = 1.635, o = 1.18},
    [4] = {map = 0, x = -1941.6, y = 970.86, z = 75.895, o = 0.4677},
    [5] = {map = 0, x = -2151.961, y = 1670.61, z = -38.0146, o = 4.626}
}

function SpiritResurrect.distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function SpiritResurrect.TeleportAndRevive(player, location)
    player:Teleport(location.map, location.x, location.y, location.z, location.o)
    player:ResurrectPlayer(100, false)
end

function SpiritResurrect.PlayerReleasesSpirit(event, player)
    local playerZone = player:GetZoneId()
    local playerX, playerY = player:GetX(), player:GetY()

    local closestLocation = 1
    local closestDistance = SpiritResurrect.distance(playerX, playerY, SpiritResurrect.TargetLocations[1].x, SpiritResurrect.TargetLocations[1].y)

    for i = 2, #SpiritResurrect.TargetLocations do
        local dist = SpiritResurrect.distance(playerX, playerY, SpiritResurrect.TargetLocations[i].x, SpiritResurrect.TargetLocations[i].y)
        if dist < closestDistance then
            closestLocation = i
            closestDistance = dist
        end
    end

    if playerZone == SpiritResurrect.Zone1 or playerZone == SpiritResurrect.Zone2 or playerZone == SpiritResurrect.Zone3 then
        player:RegisterEvent(function(_, _, _, p) SpiritResurrect.TeleportAndRevive(p, SpiritResurrect.TargetLocations[closestLocation]) end, 2000, 1)
    end
end

RegisterPlayerEvent(35, SpiritResurrect.PlayerReleasesSpirit)
