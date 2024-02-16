local FleshFlayer = {}
FleshFlayer.NPC_ID = 10407

local function CastLeap(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 47482, true)
end

local function CastPlague(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 52230, true)
end

local function CastExplode(eventId, delay, calls, creature)
    creature:CastSpell(creature, 47496, true)
end

local function CastRend(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 18106, true)
end

function FleshFlayer.OnEnterCombat(event, creature, target)
    --creature:RegisterEvent(CastLeap, 100, 1)
    creature:RegisterEvent(CastPlague, 500, 1)
    creature:RegisterEvent(CastRend, 2000, 1)
    creature:RegisterEvent(CastPlague, 20000, 0)
    creature:RegisterEvent(CastExplode, 30000, 0)
end

function FleshFlayer.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function FleshFlayer.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(FleshFlayer.NPC_ID, 1, FleshFlayer.OnEnterCombat)
RegisterCreatureEvent(FleshFlayer.NPC_ID, 2, FleshFlayer.OnLeaveCombat)
RegisterCreatureEvent(FleshFlayer.NPC_ID, 4, FleshFlayer.OnDied)
