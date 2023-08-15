function Corok_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Corok_Spell1", 11000, 0)
	Unit:RegisterEvent("Corok_Spell2", 26000, 0)
end

function Corok_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(12612,Unit:GetClosestPlayer())
end

function Corok_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(15550,Unit:GetClosestPlayer())
end

function Corok_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Corok_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22011, 1, "Corok_OnEnterCombat")
RegisterUnitEvent(22011, 2, "Corok_OnLeaveCombat")
RegisterUnitEvent(22011, 4, "Corok_OnDied")