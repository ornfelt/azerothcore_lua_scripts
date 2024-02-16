local LakeshireGuard = {}

LakeshireGuard.NPC_ID = 400013

function LakeshireGuard.CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 20605, true)
end

function LakeshireGuard.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(LakeshireGuard.CastCleave, 9000, 0)
end

function LakeshireGuard.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function LakeshireGuard.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function LakeshireGuard.OnSpawn(event, creature)
    creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(LakeshireGuard.NPC_ID, 1, LakeshireGuard.OnEnterCombat)
RegisterCreatureEvent(LakeshireGuard.NPC_ID, 2, LakeshireGuard.OnLeaveCombat)
RegisterCreatureEvent(LakeshireGuard.NPC_ID, 4, LakeshireGuard.OnDied)
RegisterCreatureEvent(LakeshireGuard.NPC_ID, 5, LakeshireGuard.OnSpawn)
