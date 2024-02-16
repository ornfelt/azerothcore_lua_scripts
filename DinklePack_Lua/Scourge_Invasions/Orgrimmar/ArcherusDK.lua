local ArcherusDK = {}

ArcherusDK.NPC_ID = 400046
ArcherusDK.hasCastIceboundFortitude = false

ArcherusDK.spells = {
    ICY_TOUCH = 49896,
    PLAGUE_STRIKE = 49917,
    BLOOD_BOIL = 48721,
    DEATH_AND_DECAY = 43265,
    DEATH_STRIKE = 49999,
    ANTI_MAGIC_SHIELD = 24021,
    ANTI_MAGIC_ZONE = 51052,
    SPECIAL_SPELL = 5,
    ICEBOUND_FORTITUDE = 48792
}

function ArcherusDK.CastIcyTouch(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherusDK.spells.ICY_TOUCH, true)
end

function ArcherusDK.CastPlagueStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherusDK.spells.PLAGUE_STRIKE, true)
end

function ArcherusDK.CastBloodBoil(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherusDK.spells.BLOOD_BOIL, true)
end

function ArcherusDK.CastDnD(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherusDK.spells.DEATH_AND_DECAY, true)
end

function ArcherusDK.CastDeathstrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherusDK.spells.DEATH_STRIKE, true)
end

function ArcherusDK.CastAntiMagicShield(eventId, delay, calls, creature)
    creature:CastSpell(creature, ArcherusDK.spells.ANTI_MAGIC_SHIELD, true)
end

function ArcherusDK.CastAntiMagicZone(eventId, delay, calls, creature)
    creature:CastSpell(creature, ArcherusDK.spells.ANTI_MAGIC_ZONE, true)
end

function ArcherusDK.CastSpecialSpell(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    if not victim then
        return
    end
    if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
        creature:CastSpell(victim, ArcherusDK.spells.SPECIAL_SPELL, true)
    end
end

function ArcherusDK.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(ArcherusDK.CastIcyTouch, 5000, 0)
    creature:RegisterEvent(ArcherusDK.CastPlagueStrike, 6000, 0)
    creature:RegisterEvent(ArcherusDK.CastDeathstrike, 25000, 0)
    creature:RegisterEvent(ArcherusDK.CastBloodBoil, math.random(12000, 18000), 0)
    creature:RegisterEvent(ArcherusDK.CastDnD, 100, 1)
    creature:RegisterEvent(ArcherusDK.CastSpecialSpell, 1000, 0)
end

function ArcherusDK.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:RegisterEvent(ArcherusDK.CastAntiMagicShield, 18000, 0)
    creature:RegisterEvent(ArcherusDK.CastAntiMagicZone, 18000, 0)
end

function ArcherusDK.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function ArcherusDK.OnSpawn(event, creature)
    creature:RegisterEvent(ArcherusDK.CastAntiMagicShield, 18000, 0)
    creature:RegisterEvent(ArcherusDK.CastAntiMagicZone, 36000, 0)
end

function ArcherusDK.OnHealthCheck(event, creature, victim, health)
    if (creature:GetHealthPct() <= 20 and not ArcherusDK.hasCastIceboundFortitude) then
        creature:CastSpell(creature, ArcherusDK.spells.ICEBOUND_FORTITUDE, true)
        ArcherusDK.hasCastIceboundFortitude = true
    end
end

RegisterCreatureEvent(ArcherusDK.NPC_ID, 1, ArcherusDK.OnEnterCombat)
RegisterCreatureEvent(ArcherusDK.NPC_ID, 2, ArcherusDK.OnLeaveCombat)
RegisterCreatureEvent(ArcherusDK.NPC_ID, 4, ArcherusDK.OnDied)
RegisterCreatureEvent(ArcherusDK.NPC_ID, 5, ArcherusDK.OnSpawn)
RegisterCreatureEvent(ArcherusDK.NPC_ID, 9, ArcherusDK.OnHealthCheck)
