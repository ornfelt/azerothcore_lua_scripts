local VenomBelcher = {};

local function VenomSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 24011, true)
end

local function SlowingPoison(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 14897, true)
end


function CastRetchingPlague(eventId, delay, calls, creature)
  local targets = creature:GetAITargets(10)
  if #targets == 0 then
    return
  end
  local target = targets[math.random(#targets)]
  creature:CastSpell(target, 30080, true)
end


local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(VenomSpit, 7000, 0)
		creature:RegisterEvent(CastRetchingPlague, 13000, 0)
		creature:RegisterEvent(SlowingPoison, 16000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(10417, 1, OnEnterCombat)
RegisterCreatureEvent(10417, 2, OnLeaveCombat)
RegisterCreatureEvent(10417, 4, OnDied)