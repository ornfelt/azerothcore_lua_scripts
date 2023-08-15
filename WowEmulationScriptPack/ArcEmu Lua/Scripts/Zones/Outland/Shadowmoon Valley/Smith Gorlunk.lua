function SmithGorlunk_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("SmithGorlunk_Rend", 15000, 0)
	Unit:RegisterEvent("SmithGorlunk_SunderArmor", 12000, 0)
end

function SmithGorlunk_Rend(Unit,Event)
	Unit:FullCastSpellOnTarget(13445,Unit:GetClosestPlayer())
end

function SmithGorlunk_SunderArmor(Unit,Event)
	Unit:FullCastSpellOnTarget(13444,Unit:GetClosestPlayer())
end

function SmithGorlunk_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SmithGorlunk_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22037, 1, "SmithGorlunk_OnEnterCombat")
RegisterUnitEvent(22037, 2, "SmithGorlunk_OnLeaveCombat")
RegisterUnitEvent(22037, 4, "SmithGorlunk_OnDied")