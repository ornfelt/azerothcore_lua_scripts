function Cobra_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Cobra_Spell", 11000, 0)
end

function Cobra_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(38030,Unit:GetClosestPlayer())
end

function Cobra_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Cobra_OnDied(Unit,Event)
	Unit:RemoveEvents()
end
RegisterUnitEvent(19784, 1, "Cobra_OnEnterCombat")
RegisterUnitEvent(19784, 2, "Cobra_OnLeaveCombat")
RegisterUnitEvent(19784, 4, "Cobra_OnDied")