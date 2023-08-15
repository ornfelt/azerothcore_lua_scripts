function CAE_OnEnterCombat(Unit,Event)
	Unit:CastSpell(35194)
	Unit:RegisterEvent("CAE_LBolt", 5000, 0)
end

function CAE_LBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9532,Unit:GetClosestPlayer())
end


function CAE_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end


function CAE_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21707, 1, "CAE_OnEnterCombat")
RegisterUnitEvent(21707, 2, "CAE_OnLeaveCombat")
RegisterUnitEvent(21707, 4, "CAE_OnDied")