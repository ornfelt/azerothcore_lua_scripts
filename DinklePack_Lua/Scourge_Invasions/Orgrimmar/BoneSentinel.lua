local BoneSentinel = {}

BoneSentinel.NPC_ID = 400036

BoneSentinel.spells = {
    SHADOW_CLEAVE = 38226,
    EARTHQUAKE = 33919,
    SPECIAL_SPELL = 5
}

function BoneSentinel.CastShadowCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), BoneSentinel.spells.SHADOW_CLEAVE, true)
end

function BoneSentinel.CastEarthquake(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), BoneSentinel.spells.EARTHQUAKE, true)
end

function BoneSentinel.CastSpecialSpell(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    if not victim then
        return
    end
    if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
        creature:CastSpell(victim, BoneSentinel.spells.SPECIAL_SPELL, true)
    end
end

function BoneSentinel.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(BoneSentinel.CastShadowCleave, 5000, 0)
    creature:RegisterEvent(BoneSentinel.CastEarthquake, 12000, 0)
    creature:RegisterEvent(BoneSentinel.CastSpecialSpell, 1000, 0)
end

function BoneSentinel.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function BoneSentinel.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BoneSentinel.NPC_ID, 1, BoneSentinel.OnEnterCombat)
RegisterCreatureEvent(BoneSentinel.NPC_ID, 2, BoneSentinel.OnLeaveCombat)
RegisterCreatureEvent(BoneSentinel.NPC_ID, 4, BoneSentinel.OnDied)
