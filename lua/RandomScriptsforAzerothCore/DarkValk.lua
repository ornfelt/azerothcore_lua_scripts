local DarkValk = {};
DarkValk.npcId = 400049

local function CastShadowBolt(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 21077, true)
end

local function CastSpecialSpell(eventId, delay, calls, creature)
  local victim = creature:GetVictim()
  if not victim then
    return
  end
  if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
    creature:CastSpell(victim, 5, true)
  end
end


local function CastShadowBoltVolley(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 33841, true)
end

local function CastRainOfFire(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
if #targets > 0 then
local target = targets[math.random(#targets)]
creature:CastSpell(target, 24669, true)
end
end

local function CastCurseOfPain(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 38048, true)
end

local function CastShadowMend(eventId, delay, calls, creature)
creature:CastSpell(creature, 33325, true)
end

local function CastShadowStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 50581, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastShadowBolt, math.random(8000, 12000), 0)
creature:RegisterEvent(CastShadowBoltVolley, math.random(11000, 18000), 0)
creature:RegisterEvent(CastRainOfFire, math.random(12000, 31000), 0)
creature:RegisterEvent(CastCurseOfPain, math.random(13000, 18000), 0)
creature:RegisterEvent(CastShadowMend, math.random(11000, 20000), 0)
creature:RegisterEvent(CastShadowStrike, math.random(2000, 5000), 0)
creature:RegisterEvent(CastSpecialSpell, 1000, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:SendUnitYell("You will submit to the power of the Lich King.", 0)
creature:SetMaxHealth(1812760)
creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(DarkValk.npcId, 1, OnEnterCombat)
RegisterCreatureEvent(DarkValk.npcId, 2, OnLeaveCombat)
RegisterCreatureEvent(DarkValk.npcId, 4, OnDied)
RegisterCreatureEvent(DarkValk.npcId, 5, OnSpawn)



