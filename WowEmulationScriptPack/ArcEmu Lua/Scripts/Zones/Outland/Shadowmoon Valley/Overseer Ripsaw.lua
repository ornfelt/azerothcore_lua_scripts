function OverseerRipsaw_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("OverseerRipsaw_GushingWound", 25000, 0)
	Unit:RegisterEvent("OverseerRipsaw_SawBlade", 2500, 0)
end

function OverseerRipsaw_GushingWound(Unit,Event)
	Unit:FullCastSpellOnTarget(35321,Unit:GetClosestPlayer())
end

function OverseerRipsaw_SawBlade(Unit,Event)
	Unit:FullCastSpellOnTarget(32735,Unit:GetClosestPlayer())
end

function OverseerRipsaw_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function OverseerRipsaw_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21499, 1, "OverseerRipsaw_OnEnterCombat")
RegisterUnitEvent(21499, 2, "OverseerRipsaw_OnLeaveCombat")
RegisterUnitEvent(21499, 4, "OverseerRipsaw_OnDied")