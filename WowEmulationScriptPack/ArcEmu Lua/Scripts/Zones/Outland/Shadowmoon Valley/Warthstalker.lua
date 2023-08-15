function Wrathstalker_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Wrathstalker_Cleave", 11000, 0)
end

function Wrathstalker_Cleave(Unit,Event)
	Unit:FullCastSpellOnTarget(33805,Unit:GetClosestPlayer())
end

function Wrathstalker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Wrathstalker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21249, 1, "Wrathstalker_OnEnterCombat")
RegisterUnitEvent(21249, 2, "Wrathstalker_OnLeaveCombat")
RegisterUnitEvent(21249, 4, "Wrathstalker_OnDied")