function FDiemetradon_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("FDiemetradon_Spell", 40000, 0)
end

function FDiemetradon_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(37941,Unit:GetClosestPlayer())
end

function FDiemetradon_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function FDiemetradon_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21408, 1, "FDiemetradon_OnEnterCombat")
RegisterUnitEvent(21408, 2, "FDiemetradon_OnLeaveCombat")
RegisterUnitEvent(21408, 4, "FDiemetradon_OnDeath")