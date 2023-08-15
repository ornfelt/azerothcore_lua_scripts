function ProphetessCavrylin_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(36656,Unit:GetClosestPlayer())
	Unit:CastSpell(37997)
	Unit:RegisterEvent("ProphetessCavrylin_MeltFlesh", 15000, 0)
end

function ProphetessCavrylin_MeltFlesh(Unit,Event)
	Unit:FullCastSpellOnTarget(37629,Unit:GetClosestPlayer())
end

function ProphetessCavrylin_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ProphetessCavrylin_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(20683, 1, "ProphetessCavrylin_OnEnterCombat")
RegisterUnitEvent(20683, 2, "ProphetessCavrylin_OnLeaveCombat")
RegisterUnitEvent(20683, 4, "ProphetessCavrylin_OnDied")