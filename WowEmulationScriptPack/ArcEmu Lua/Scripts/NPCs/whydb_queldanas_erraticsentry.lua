--[[ Erratic Sentry ]]--
function SelfRepair(pUnit)
      pUnit:CastSpell(44994)
end

function SetHP(pUnit, Event)
      pUnit:SetHealthPct(80)
	  pUnit:RegisterEvent("RepairEffect", 1200, 1)
end

function RepairEffect(pUnit, Event)
      pUnit:CastSpell(45000)
	  if pUnit:GetHealthPct() < 100 then
		pUnit:RegisterEvent("SelfRepair", 1200, 1)
	  end
end

function ErraticSentryCapacitorOverload(pUnit, Event)
	pUnit:RegisterEvent("SetHP", math.random(16000,36000), 0)
end

function ErraticSentryCapacitorOverload_OnEnterCombat(pUnit, Event)
pUnit:RemoveEvents()	
end

function ErraticSentryCapacitorOverload_OnLeaveCombat(pUnit, Event)
	pUnit:RegisterEvent("SetHP", math.random(16000,36000), 0)	
end



RegisterUnitEvent(24972, 6, "ErraticSentryCapacitorOverload")
RegisterUnitEvent(24972, 1, "ErraticSentryCapacitorOverload_OnEnterCombat")
RegisterUnitEvent(24972, 2, "ErraticSentryCapacitorOverload_OnLeaveCombat")