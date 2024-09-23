WanderingBlightCreatures = {}

WanderingBlightCreatures.NPC_CUSTOM = 400119
WanderingBlightCreatures.WANDER_RADIUS = 5

function WanderingBlightCreatures.CustomNPC_OnSpawn(event, creature)
    creature:SetDefaultMovementType(1)
    creature:SetWanderRadius(WanderingBlightCreatures.WANDER_RADIUS)
    creature:MoveRandom(WanderingBlightCreatures.WANDER_RADIUS)
end

RegisterCreatureEvent(WanderingBlightCreatures.NPC_CUSTOM, 5, WanderingBlightCreatures.CustomNPC_OnSpawn)
