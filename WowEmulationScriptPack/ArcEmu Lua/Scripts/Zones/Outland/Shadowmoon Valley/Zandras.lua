function Zandras_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Zandras_FelShackles", 11000, 0)
end

function Zandras_FelShackles(Unit,Event)
	Unit:FullCastSpellOnTarget(38051,Unit:GetClosestPlayer())
end

function Zandras_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Zandras_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21249, 1, "Zandras_OnEnterCombat")
RegisterUnitEvent(21249, 2, "Zandras_OnLeaveCombat")
RegisterUnitEvent(21249, 4, "Zandras_OnDied")