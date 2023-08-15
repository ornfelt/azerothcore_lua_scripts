function Lothros_OnEnterCombat(Unit,Event)
	Unit:RegisterUnitEvent("Lothros_Spell", 60000, 0)
end

function Lothros_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(38167,Unit:GetClosestPlayer())
end

function Lothros_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Lothros_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21928, 1, "Lothros_OnEnterCombat")
RegisterUnitEvent(21928, 2, "Lothros_OnLeaveCombat")
RegisterUnitEvent(21928, 4, "Lothros_OnDied")