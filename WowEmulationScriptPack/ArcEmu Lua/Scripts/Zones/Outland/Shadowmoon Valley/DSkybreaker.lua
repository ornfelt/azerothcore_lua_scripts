function DSkybreaker_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(38858,Unit:GetClosestPlayer())
	Unit:RegisterEvent("DSkybreaker_Spell1", 24000, 0)
	Unit:RegisterEvent("DSkybreaker_Spell2", 11000, 0)
end

function DSkybreaker_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(38861,Unit:GetClosestPlayer())
end

function DSkybreaker_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(41448,Unit:GetClosestPlayer())
end

function DSkybreaker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DSkybreaker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22274, 1, "DSkybreaker_OnEnterCombat")
RegisterUnitEvent(22274, 2, "DSkybreaker_OnLeaveCombat")
RegisterUnitEvent(22274, 4, "DSkybreaker_OnDied")