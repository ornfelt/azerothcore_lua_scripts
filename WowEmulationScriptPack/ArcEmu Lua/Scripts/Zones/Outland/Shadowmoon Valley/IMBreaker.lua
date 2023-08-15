function IMBreaker_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IMBreaker_Spell1", 34000, 0)
	Unit:RegisterEvent("IMBreaker_Spell2", 10000, 0)
	Unit:RegisterEvent("IMBreaker_Spell3", 41000, 0)
end

function IMBreaker_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(38985,Unit:GetClosestPlayer())
end

function IMBreaker_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(17194,Unit:GetClosestPlayer())
end

function IMBreaker_Spell3(Unit,Event)
	Unit:FullCastSpellOnTarget(22884,Unit:GetClosestPlayer())
end

function IMBreaker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IMBreaker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(22074, 1, "IMBreaker_OnEnterCombat")
RegisterUnitEvent(22074, 2, "IMBreaker_OnLeaveCombat")
RegisterUnitEvent(22074, 4, "IMBreaker_OnDied")