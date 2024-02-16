local OnyxianWhelp = {}

OnyxianWhelp.NPC_ID = 301001
OnyxianWhelp.TELEPORT_LOCATIONS = {
    {x = -31.71, y = -170.55, z = -89.72, o = 0},
    {x = -32.086, y = -258.55, z = -89.72, o = 0},
}

function OnyxianWhelp.NearTeleportOnSpawn(event, creature)
    local location = OnyxianWhelp.TELEPORT_LOCATIONS[math.random(1, #OnyxianWhelp.TELEPORT_LOCATIONS)]
    local randomizedX = location.x + math.random(-5, 5)
    local randomizedY = location.y + math.random(-5, 5)
    creature:NearTeleport(randomizedX, randomizedY, location.z, location.o)

    local middleY = (OnyxianWhelp.TELEPORT_LOCATIONS[1].y + OnyxianWhelp.TELEPORT_LOCATIONS[2].y) / 2
    creature:MoveTo(1, randomizedX, middleY, location.z)
end

RegisterCreatureEvent(OnyxianWhelp.NPC_ID, 5, OnyxianWhelp.NearTeleportOnSpawn)
