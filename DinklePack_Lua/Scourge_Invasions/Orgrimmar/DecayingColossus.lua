local DecayingColossus = {}

DecayingColossus.NPC_ID = 400048
DecayingColossus.SPELL_IDS = {
    MIGHTY_BLOW = 14099,
    DISARM = 6713,
    STOMP = 55196,
    THUNDERCLAP = 55635,
    ENRAGE = 8599
}

function DecayingColossus.CastMightyBlow(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DecayingColossus.SPELL_IDS.MIGHTY_BLOW, true)
end

function DecayingColossus.CastDisarm(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DecayingColossus.SPELL_IDS.DISARM, true)
end

function DecayingColossus.CastStomp(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets > 0 then
        local target = targets[math.random(#targets)]
        creature:CastSpell(target, DecayingColossus.SPELL_IDS.STOMP, true)
    end
end

function DecayingColossus.CastThunderclap(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DecayingColossus.SPELL_IDS.THUNDERCLAP, true)
end

function DecayingColossus.CastEnrage(eventId, delay, calls, creature)
    creature:CastSpell(creature, DecayingColossus.SPELL_IDS.ENRAGE, true)
end

function DecayingColossus.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DecayingColossus.CastMightyBlow, math.random(4000, 7000), 0)
    creature:RegisterEvent(DecayingColossus.CastDisarm, math.random(15000, 19000), 0)
    creature:RegisterEvent(DecayingColossus.CastStomp, math.random(12000, 25000), 0)
    creature:RegisterEvent(DecayingColossus.CastThunderclap, math.random(13000, 18000), 0)
    creature:RegisterEvent(DecayingColossus.CastEnrage, math.random(45000, 60000), 0)
end

function DecayingColossus.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DecayingColossus.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function DecayingColossus.OnSpawn(event, creature)
    creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(DecayingColossus.NPC_ID, 1, DecayingColossus.OnEnterCombat)
RegisterCreatureEvent(DecayingColossus.NPC_ID, 2, DecayingColossus.OnLeaveCombat)
RegisterCreatureEvent(DecayingColossus.NPC_ID, 4, DecayingColossus.OnDied)
RegisterCreatureEvent(DecayingColossus.NPC_ID, 5, DecayingColossus.OnSpawn)
