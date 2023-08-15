function AnchoriteCaalen_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("AnchoriteCaalen_HolySmite", 1540, 0)
	Unit:RegisterEvent("AnchoriteCaalen_HolySmite", 5000, 0)
end

function AnchoriteCaalen_HolySmite(Unit,Event)
	Unit:FullCastSpellOnTarget(36176,Unit:GetClosestPlayer())
end

function AnchoriteCaalen_GreaterHeal(Unit,Event)
	Unit:FullCastSpellOnTarget(35096,Unit:GetRandomFriend())
end

function AnchoriteCaalen_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function AnchoriteCaalen_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (22862, 1, "AnchoriteCaalen_OnEnterCombat")
RegisterUnitEvent (22862, 2, "AnchoriteCaalen_OnLeaveCombat")
RegisterUnitEvent (22862, 4, "AnchoriteCaalen_OnDied")