function DFelboar_OnEnterCombat(Unit,Event)
	Unit:CastSpell(36462)
	Unit:FullCastSpellOnTarget(22120,Unit:GetClosestPlayer())
end

function DFelboar_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function DFelboar_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21195, 1, "DFelboar_OnEnterCombat")
RegisterUnitEvent(21195, 2, "DFelboar_LeaveCombat")
RegisterUnitEvent(21195, 4, "DFelboar_OnDied")