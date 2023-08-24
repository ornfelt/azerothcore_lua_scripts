local PatchWorkHorror = {};

local function AcidSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 61597, true)
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


function CastBludgeoningStrike(eventId, delay, calls, creature)
  local targets = creature:GetAITargets(10)
  if #targets == 0 then
    return
  end
  local target = targets[math.random(#targets)]
  creature:CastSpell(target, 60870, true)
end


local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(AcidSpit, 7000, 0)
		creature:RegisterEvent(CastBludgeoningStrike, 13000, 0)
		creature:RegisterEvent(CastSpecialSpell, 1000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400054, 1, OnEnterCombat)
RegisterCreatureEvent(400054, 2, OnLeaveCombat)
RegisterCreatureEvent(400054, 4, OnDied)

