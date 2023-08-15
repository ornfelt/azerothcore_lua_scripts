function EBloodwarder_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38311)
	Unit:RegisterEvent("EBloodwarder_BloodLeech", 9000, 0)
end

function EBloodwarder_BloodLeech(Unit,Event)
	Unit:FullCastSpellOnTarget(37838,Unit:GetClosestPlayer())
end

function EBloodwarder_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function EBloodwarder_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19806, 1, "EBloodwarder_OnEnterCombat")
RegisterUnitEvent(19806, 2, "EBloodwarder_OnLeaveCombat")
RegisterUnitEvent(19806, 4, "EBloodwarder_OnDied")