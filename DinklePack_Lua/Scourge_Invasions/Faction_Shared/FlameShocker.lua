local FlameShocker = {}
FlameShocker.NPC_ID = 16383 -- FlameShocker NPC ID

local function CastFlameShock(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 10448, true)
end

function FlameShocker.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastFlameShock, 100, 1)
    creature:RegisterEvent(CastFlameShock, 8000, 0)
end

function FlameShocker.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function FlameShocker.OnDied(event, creature, killer)
    creature:CastSpell(killer, 28323, true)
    creature:DespawnOrUnsummon(25000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(FlameShocker.NPC_ID, 1, FlameShocker.OnEnterCombat)
RegisterCreatureEvent(FlameShocker.NPC_ID, 2, FlameShocker.OnLeaveCombat)
RegisterCreatureEvent(FlameShocker.NPC_ID, 4, FlameShocker.OnDied)
