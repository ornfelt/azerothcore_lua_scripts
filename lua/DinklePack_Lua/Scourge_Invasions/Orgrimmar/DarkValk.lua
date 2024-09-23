local DarkValk = {}

DarkValk.NPC_ID = 400049
DarkValk.SPELL_IDS = {
    SHADOW_BOLT = 21077,
    SPECIAL_SPELL = 5,
    SHADOW_BOLT_VOLLEY = 33841,
    RAIN_OF_FIRE = 24669,
    CURSE_OF_PAIN = 38048,
    SHADOW_MEND = 33325,
    SHADOW_STRIKE = 50581
}

function DarkValk.CastShadowBolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkValk.SPELL_IDS.SHADOW_BOLT, true)
end

function DarkValk.CastSpecialSpell(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    if not victim then
        return
    end
    if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
        creature:CastSpell(victim, DarkValk.SPELL_IDS.SPECIAL_SPELL, true)
    end
end

function DarkValk.CastShadowBoltVolley(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkValk.SPELL_IDS.SHADOW_BOLT_VOLLEY, true)
end

function DarkValk.CastRainOfFire(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets > 0 then
        local target = targets[math.random(#targets)]
        creature:CastSpell(target, DarkValk.SPELL_IDS.RAIN_OF_FIRE, true)
    end
end

function DarkValk.CastCurseOfPain(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkValk.SPELL_IDS.CURSE_OF_PAIN, true)
end

function DarkValk.CastShadowMend(eventId, delay, calls, creature)
    creature:CastSpell(creature, DarkValk.SPELL_IDS.SHADOW_MEND, true)
end

function DarkValk.CastShadowStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DarkValk.SPELL_IDS.SHADOW_STRIKE, true)
end

function DarkValk.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DarkValk.CastShadowBolt, math.random(8000, 12000), 0)
    creature:RegisterEvent(DarkValk.CastShadowBoltVolley, math.random(11000, 18000), 0)
    creature:RegisterEvent(DarkValk.CastRainOfFire, math.random(12000, 31000), 0)
    creature:RegisterEvent(DarkValk.CastCurseOfPain, math.random(13000, 18000), 0)
    creature:RegisterEvent(DarkValk.CastShadowMend, math.random(11000, 20000), 0)
    creature:RegisterEvent(DarkValk.CastShadowStrike, math.random(2000, 5000), 0)
    creature:RegisterEvent(DarkValk.CastSpecialSpell, 1000, 0)
end

function DarkValk.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DarkValk.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function DarkValk.OnSpawn(event, creature)
    creature:SendUnitYell("You will submit to the power of the Lich King.", 0)
    creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(DarkValk.NPC_ID, 1, DarkValk.OnEnterCombat)
RegisterCreatureEvent(DarkValk.NPC_ID, 2, DarkValk.OnLeaveCombat)
RegisterCreatureEvent(DarkValk.NPC_ID, 4, DarkValk.OnDied)
RegisterCreatureEvent(DarkValk.NPC_ID, 5, DarkValk.OnSpawn)
