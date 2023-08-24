local Scorn = {};

local function LichSlap(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 28873, true)
end
end

local function Enrage(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature, 15716, true)
end
end

local function FrostboltVolley(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature, 22643, true)
end
end

local function FrostNova(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature, 15531, true)
end
end

function MindFlay(eventId, delay, calls, creature)
if not creature:IsCasting() then
local targets = creature:GetAITargets(5)
if #targets == 0 then
return
end
local target = targets[math.random(#targets)]
creature:CastSpell(target, 17318, true)
end
end

function ManaBurn(eventId, delay, calls, creature)
if not creature:IsCasting() then
local targets = creature:GetAITargets(5)
if #targets == 0 then
return
end
local target = targets[math.random(#targets)]
creature:CastSpell(target, 8129, true)
end
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(LichSlap, math.random(8000,12000), 0)
creature:RegisterEvent(MindFlay, math.random(14000,18000), 0)
creature:RegisterEvent(FrostboltVolley, math.random(7000,11000), 0)
creature:RegisterEvent(FrostNova, 1000, 1)
creature:RegisterEvent(FrostNova, math.random(6000,9000), 0)
creature:RegisterEvent(ManaBurn, math.random(17000,24000), 0)
end

local function OnHealthUpdate(event, creature, value)
if (creature:GetHealthPct() <= 20) then
creature:RemoveEvents()
creature:RegisterEvent(Enrage, 100, 1)
end
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

RegisterCreatureEvent(400075, 1, OnEnterCombat)
RegisterCreatureEvent(400075, 9, OnHealthUpdate)
RegisterCreatureEvent(400075, 2, OnLeaveCombat)
RegisterCreatureEvent(400075, 4, OnDied)