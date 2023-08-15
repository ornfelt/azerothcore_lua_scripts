function Borak_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Borak_SliceAndDice", 15000, 0)
	Unit:RegisterEvent("Borak_Eviscerate", 5000, 0)
end

function Borak_SliceAndDice(Unit,Event)
	Unit:FullCastSpellOnTarget(30470,Unit:GetClosestPlayer())
end

function Borak_Eviscerate(Unit,Event)
	Unit:FullCastSpellOnTarget(27611,Unit:GetClosestPlayer())
end

function Borak_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Borak_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21293, 1, "Borak_OnEnterCombat")
RegisterUnitEvent(21293, 2, "Borak_OnLeaveCombat")
RegisterUnitEvent(21293, 4, "Borak_OnDied")