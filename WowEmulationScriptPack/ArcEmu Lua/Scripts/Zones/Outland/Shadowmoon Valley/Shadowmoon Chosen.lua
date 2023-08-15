function ShadowmoonChosen_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ShadowmoonChosen_Uppercut", 5000, 0)
	Unit:RegisterEvent("ShadowmoonChosen_Whirlwind", 11000, 0)
end

function ShadowmoonChosen_Uppercut(Unit,Event)
	Unit:FullCastSpellOnTarget(10966,Unit:GetClosestPlayer())
end

function ShadowmoonChosen_Whirlwind(Unit,Event)
	Unit:FullCastSpellOnTarget(38619,Unit:GetClosestPlayer())
	Unit:FullCastSpellOnTarget(38618,Unit:GetClosestPlayer())
end

function ShadowmoonChosen_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ShadowmoonChosen_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22084, 1, "ShadowmoonChosen_OnEnterCombat")
RegisterUnitEvent(22084, 2, "ShadowmoonChosen_OnLeaveCombat")
RegisterUnitEvent(22084, 4, "ShadowmoonChosen_OnDied")