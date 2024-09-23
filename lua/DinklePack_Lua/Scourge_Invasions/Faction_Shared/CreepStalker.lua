local CREEPY_NPC_ID = 400032

CreepStalker = {}

local function CastRake(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 9904, true)
end

local function CastStun(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 34510, true)
end

function CreepStalker.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastRake, 5000, 0)
    creature:RegisterEvent(CastStun, 12000, 0)
end

function CreepStalker.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function CreepStalker.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(CREEPY_NPC_ID, 1, CreepStalker.OnEnterCombat)
RegisterCreatureEvent(CREEPY_NPC_ID, 2, CreepStalker.OnLeaveCombat)
RegisterCreatureEvent(CREEPY_NPC_ID, 4, CreepStalker.OnDied)
