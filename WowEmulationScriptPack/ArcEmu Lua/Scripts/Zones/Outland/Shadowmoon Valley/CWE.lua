function CWE_OnEnterCombat(Unit,Event)
	Unit:CastSpell(35194)
	Unit:RegisterEvent("CWE_FBolt", 5000, 0)
end

function CWE_Fbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9672,Unit:GetClosestPlayer())
end

function CWE_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CWE_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21428, 1, "CWE_OnEnterCombat")
RegisterUnitEvent(21428, 2, "CWE_OnLeaveCombat")
RegisterUnitEvent(21428, 4, "CWE_OnDied")