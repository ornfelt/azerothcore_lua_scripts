local DecayingColossus = {};
DecayingColossus.npcId = 400048

local function CastMightyBlow(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 14099, true)
end

local function CastDisarm(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 6713, true)
end

local function CastStomp(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
local target = targets[math.random(#targets)]
creature:CastSpell(target, 55196, true)
end

local function CastThunderclap(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 55635, true)
end

local function CastEnrage(eventId, delay, calls, creature)
creature:CastSpell(creature, 8599, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastMightyBlow, math.random(4000, 7000), 0)
creature:RegisterEvent(CastDisarm, math.random(15000, 19000), 0)
creature:RegisterEvent(CastStomp, math.random(12000, 25000), 0)
creature:RegisterEvent(CastThunderclap, math.random(13000, 18000), 0)
creature:RegisterEvent(CastEnrage, math.random(45000, 60000), 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:SetMaxHealth(517720)
creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(DecayingColossus.npcId, 1, OnEnterCombat)
RegisterCreatureEvent(DecayingColossus.npcId, 2, OnLeaveCombat)
RegisterCreatureEvent(DecayingColossus.npcId, 4, OnDied)
RegisterCreatureEvent(DecayingColossus.npcId, 5, OnSpawn)