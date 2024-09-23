local ArcherusDK = {};
local hasCastIceboundFortitude = false;

local function CastIcyTouch(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 49896, true)
end

local function CastPlagueStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 49917, true)
end

local function CastBloodBoil(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 48721, true)
end

local function CastDnD(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 43265, true)
end

local function CastDeathstrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 49999, true)
end


local function CastAntiMagicShield(eventId, delay, calls, creature)
creature:CastSpell(creature, 24021, true)
end

local function CastAntiMagicZone(eventId, delay, calls, creature)
creature:CastSpell(creature, 51052, true)
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


local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastIcyTouch, 5000, 0)
creature:RegisterEvent(CastPlagueStrike, 6000, 0)
creature:RegisterEvent(CastDeathstrike, 25000, 0)
creature:RegisterEvent(CastBloodBoil, math.random(12000, 18000), 0)
creature:RegisterEvent(CastDnD, 100, 1)
creature:RegisterEvent(CastSpecialSpell, 1000, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
creature:RegisterEvent(CastAntiMagicShield, 18000, 0)
creature:RegisterEvent(CastAntiMagicZone, 18000, 0)
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:RegisterEvent(CastAntiMagicShield, 18000, 0)
creature:RegisterEvent(CastAntiMagicZone, 36000, 0)
end

local function CastBloodBoil(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 48721, true)
end

local function OnHealthCheck(event, creature, victim, health)
if (creature:GetHealthPct() <= 20 and not hasCastIceboundFortitude) then
creature:CastSpell(creature, 48792, true)
hasCastIceboundFortitude = true
end
end

RegisterCreatureEvent(400046, 1, OnEnterCombat)
RegisterCreatureEvent(400046, 2, OnLeaveCombat)
RegisterCreatureEvent(400046, 4, OnDied)
RegisterCreatureEvent(400046, 5, OnSpawn)
RegisterCreatureEvent(400046, 9, OnHealthCheck)