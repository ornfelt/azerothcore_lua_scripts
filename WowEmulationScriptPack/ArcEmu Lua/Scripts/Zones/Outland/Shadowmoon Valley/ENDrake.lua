function ENDrake_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38775)
	Unit:RegisterEvent("ENDrake_Spell", 13000, 0)
end

function ENDrake_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(36513,Unit:GetClosestPlayer())
end

function ENDrake_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ENDrake_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21722, 1, "ENDrake_OnEnterCombat")
RegisterUnitEvent(21722, 2, "ENDrake_OnLeaveCombat")
RegisterUnitEvent(21722, 4, "ENDrake_OnDeath")