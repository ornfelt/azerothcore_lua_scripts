function MoArgWeaponsmith_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("MoArgWeaponsmith_ChemicalFlames", 13000, 0)
	Unit:RegisterEvent("MoArgWeaponsmith_DrillArmor", 18000, 0)
end

function MoArgWeaponsmith_ChemicalFlames(Unit,Event)
	Unit:FullCastSpellOnTarget(36253,Unit:GetClosestPlayer())
end

function MoArgWeaponsmith_DrillArmor(Unit,Event)
	Unit:FullCastSpellOnTarget(37580,Unit:GetClosestPlayer())
end

function MoArgWeaponsmith_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function MoArgWeaponsmith_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19755, 1, "MoArgWeaponsmith_OnEnterCombat")
RegisterUnitEvent(19755, 2, "MoArgWeaponsmith_OnLeaveCombat")
RegisterUnitEvent(19755, 4, "MoArgWeaponsmith_OnDied")