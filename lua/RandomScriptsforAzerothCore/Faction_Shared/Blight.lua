local NPC_CUSTOM = 400119
local WANDER_RADIUS = 5

function CustomNPC_OnSpawn(event, creature)
    creature:SetDefaultMovementType(1)
    creature:SetWanderRadius(WANDER_RADIUS)
    creature:MoveRandom(WANDER_RADIUS)
end

RegisterCreatureEvent(NPC_CUSTOM, 5, CustomNPC_OnSpawn)
