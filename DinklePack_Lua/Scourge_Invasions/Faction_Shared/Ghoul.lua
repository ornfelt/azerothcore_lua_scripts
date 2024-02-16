local Ghoul = {}
Ghoul.NPC_ID = 400047

local function CastLeap(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 47482, true)
end

local function CastPlague(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 52230, true)
end

local function CastExplode(eventId, delay, calls, creature)
    creature:CastSpell(creature, 47496, true)
end

function Ghoul.OnEnterCombat(event, creature, target)
    --creature:RegisterEvent(CastLeap, 100, 1)
    creature:RegisterEvent(CastPlague, 100, 1)
    creature:RegisterEvent(CastPlague, 20000, 0)
    creature:RegisterEvent(CastExplode, 23000, 0)
end

function Ghoul.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Ghoul.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(Ghoul.NPC_ID, 1, Ghoul.OnEnterCombat)
RegisterCreatureEvent(Ghoul.NPC_ID, 2, Ghoul.OnLeaveCombat)
RegisterCreatureEvent(Ghoul.NPC_ID, 4, Ghoul.OnDied)
