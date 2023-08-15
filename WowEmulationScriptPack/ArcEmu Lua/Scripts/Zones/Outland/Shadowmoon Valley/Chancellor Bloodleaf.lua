function ChancellorBloodleaf_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ChancellorBloodleaf_Spell1", 4000, 0)
	Unit:RegisterEvent("ChancellorBloodleaf_Spell2", 10000, 0)
end

function ChancellorBloodleaf_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(34517,Unit:GetClosestPlayer())
end

function ChancellorBloodleaf_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(15791,Unit:GetClosestPlayer())
end

function ChancellorBloodleaf_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ChancellorBloodleaf_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22012, 1, "ChancellorBloodleaf_OnEnterCombat")
RegisterUnitEvent(22012, 2, "ChancellorBloodleaf_OnLeaveCombat")
RegisterUnitEvent(22012, 4, "ChancellorBloodleaf_OnDied")