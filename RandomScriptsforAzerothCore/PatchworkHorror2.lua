local PatchWorkHorror2 = {};

local function AcidSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 61597, true)
end

local function KnockAway(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 10101, true)
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
		creature:RegisterEvent(KnockAway, 16000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(10414, 1, OnEnterCombat)
RegisterCreatureEvent(10414, 2, OnLeaveCombat)
RegisterCreatureEvent(10414, 4, OnDied)