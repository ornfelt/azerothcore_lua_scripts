local FoeReaper = {}

FoeReaper.NPC_ID = 900003
FoeReaper.SPELL_IDS = {
    TRAMPLE = 5568,
    KNOCKBACK = 49398
}

function FoeReaper.CastTrample(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), FoeReaper.SPELL_IDS.TRAMPLE, true)
end

function FoeReaper.CastKnockback(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), FoeReaper.SPELL_IDS.KNOCKBACK, true)
end

function FoeReaper.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("You like me, you really like me!", 0)
    creature:RegisterEvent(FoeReaper.CastTrample, 5000, 0)
    creature:RegisterEvent(FoeReaper.CastKnockback, 15000, 0)
end

function FoeReaper.OnLeaveCombat(event, creature)
    creature:SendUnitYell("Haha, you lose!", 0)
    creature:RemoveEvents()
end

function FoeReaper.OnDied(event, creature, killer)
    if killer:GetObjectType() == "Player" then
        killer:SendBroadcastMessage("You killed " .. creature:GetName() .. "!")
    end
    creature:RemoveEvents()
end

function FoeReaper.OnSpawn(event, creature)
    creature:SendUnitYell("I'm baaaaaaaaack!!!", 0)
end

RegisterCreatureEvent(FoeReaper.NPC_ID, 1, FoeReaper.OnEnterCombat)
RegisterCreatureEvent(FoeReaper.NPC_ID, 2, FoeReaper.OnLeaveCombat)
RegisterCreatureEvent(FoeReaper.NPC_ID, 4, FoeReaper.OnDied)
RegisterCreatureEvent(FoeReaper.NPC_ID, 5, FoeReaper.OnSpawn)
