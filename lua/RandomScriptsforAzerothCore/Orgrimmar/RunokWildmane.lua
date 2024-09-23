local function CastFlameShock(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 8050, true)
end

local function CastLightningBolt(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 403, false)
end

local function CastLavaBurst(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 51505, false)
end

local function CastChainLightning(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 421, true)
end

local function OnEnterCombat(event, creature, target)
if not creature:IsCasting() then
creature:RegisterEvent(CastFlameShock, 5000, 0)
creature:RegisterEvent(CastLightningBolt, 6500, 0)
creature:RegisterEvent(CastLavaBurst, 9000, 0)
creature:RegisterEvent(CastChainLightning, 11700, 0)
end
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(400070, 1, OnEnterCombat)
RegisterCreatureEvent(400070, 2, OnLeaveCombat)
RegisterCreatureEvent(400070, 4, OnDied)
RegisterCreatureEvent(400070, 5, OnSpawn)