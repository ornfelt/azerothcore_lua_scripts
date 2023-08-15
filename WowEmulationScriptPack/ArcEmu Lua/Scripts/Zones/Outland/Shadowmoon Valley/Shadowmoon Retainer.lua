function ShadowmoonRetainer_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ShadowmoonRetainer_Shoot", 4000, 0)
end

function ShadowmoonRetainer_Shoot(Unit,Event)
	Unit:FullCastSpellOnTarget(15547,Unit:GetRandomPlayer(3))
end

function ShadowmoonRetainer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ShadowmoonRetainer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22102, 1, "ShadowmoonRetainer_OnEnterCombat")
RegisterUnitEvent(22102, 2, "ShadowmoonRetainer_OnLeaveCombat")
RegisterUnitEvent(22102, 4, "ShadowmoonRetainer_OnDied")