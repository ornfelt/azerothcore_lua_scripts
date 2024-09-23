local AvatarOfCthun = {}

AvatarOfCthun.CREATURE_ID = 400159
AvatarOfCthun.SPELL_TO_CAST = 80082
AvatarOfCthun.TARGET_CREATURE_ID = 15727
AvatarOfCthun.SPAWN_CREATURE_ID = 400160
AvatarOfCthun.SPELL_ON_SPAWN = 61456 
AvatarOfCthun.DESPAWN_TIME = 300000 -- 5 minutes in milliseconds
AvatarOfCthun.SEARCH_RANGE = 100 -- Search range in yards

AvatarOfCthun.SPAWN_LOCATIONS = {
    {x = -8626, y = 1972, z = 100.5, o = 0.34},
    {x = -8529, y = 1997, z = 100.5, o = 3.5}
}

function AvatarOfCthun.castSpellOnTarget(creature)
    local creaturesInRange = creature:GetCreaturesInRange(AvatarOfCthun.SEARCH_RANGE, AvatarOfCthun.TARGET_CREATURE_ID)
    
    if #creaturesInRange > 0 then
        local target = creaturesInRange[1]
        creature:CastSpell(target, AvatarOfCthun.SPELL_TO_CAST, false)
    end
end

function AvatarOfCthun.OnCreatureSpawn(event, creature)
    creature:SetReactState(0)
    creature:CastSpell(creature, AvatarOfCthun.SPELL_ON_SPAWN, true)
    AvatarOfCthun.castSpellOnTarget(creature)

    for _, location in ipairs(AvatarOfCthun.SPAWN_LOCATIONS) do
        creature:SpawnCreature(AvatarOfCthun.SPAWN_CREATURE_ID, location.x, location.y, location.z, location.o, 3, AvatarOfCthun.DESPAWN_TIME)
    end
end

function AvatarOfCthun.OnEnterCombat(event, creature, target)
    creature:SetReactState(0)
    AvatarOfCthun.castSpellOnTarget(creature)
end

RegisterCreatureEvent(AvatarOfCthun.CREATURE_ID, 5, AvatarOfCthun.OnCreatureSpawn)
RegisterCreatureEvent(AvatarOfCthun.CREATURE_ID, 1, AvatarOfCthun.OnEnterCombat)
