function IPainlasher_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IPainlasher_LashOfPain", 4000, 0)
end

function IPainlasher_LashOfPain(Unit,Event)
	Unit:FullCastSpellOnTarget(15968,Unit:GetClosestPlayer())
end

function IPainlasher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IPainlasher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19800, 1, "IPainlasher_OnEnterCombat")
RegisterUnitEvent(19800, 2, "IPainlasher_OnLeaveCombat")
RegisterUnitEvent(19800, 4, "IPainlasher_OnDied")