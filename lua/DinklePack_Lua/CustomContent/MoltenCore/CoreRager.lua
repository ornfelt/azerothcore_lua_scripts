local CoreRager = {}

CoreRager.NPC_ID = 11672
CoreRager.SPELL_IDS = {
    MANGLE = 19820,
    HEAL = 17683,
    SUICIDE = 13520
}

function CoreRager.CastMangle(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CoreRager.SPELL_IDS.MANGLE, true)
end

function CoreRager.OnDamageTaken(event, creature, attacker, damage)
    if creature:GetHealthPct() < 50 then
        creature:CastSpell(creature, CoreRager.SPELL_IDS.HEAL, true)
        creature:SendUnitEmote("Core Rager refuses to die while its master is in trouble.", 0)
    end
end

function CoreRager.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CoreRager.CastMangle, 7000, 0)
end

function CoreRager.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function CoreRager.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function CoreRager.OnSpawn(event, creature)
    creature:SetMaxHealth(200000)
end

function CoreRager.OnGolemaggDeath(event, creature, boss)
    local coreRagers = creature:GetCreaturesInRange(1000, CoreRager.NPC_ID)
    for _, coreRager in pairs(coreRagers) do
        coreRager:CastSpell(coreRager, CoreRager.SPELL_IDS.SUICIDE, true)
    end
end

RegisterCreatureEvent(CoreRager.NPC_ID, 1, CoreRager.OnEnterCombat)
RegisterCreatureEvent(CoreRager.NPC_ID, 2, CoreRager.OnLeaveCombat)
RegisterCreatureEvent(CoreRager.NPC_ID, 4, CoreRager.OnDied)
RegisterCreatureEvent(CoreRager.NPC_ID, 5, CoreRager.OnSpawn)
RegisterCreatureEvent(CoreRager.NPC_ID, 9, CoreRager.OnDamageTaken)

RegisterCreatureEvent(11988, 4, CoreRager.OnGolemaggDeath)
