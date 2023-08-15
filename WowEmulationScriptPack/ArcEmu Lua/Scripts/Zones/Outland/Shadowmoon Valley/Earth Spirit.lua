function EarthSpirit_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38365)
	Unit:RegisterEvent("EarthSpirit_Boulder", 8500, 0)
end

function EarthSpirit_Boulder(Unit,Event)
	Unit:FullCastSpellOnTarget(38498,Unit:GetClosestPlayer())
end

function EarthSpirit_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function EarthSpirit_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21050, 1, "EarthSpirit_OnEnterCombat")
RegisterUnitEvent(21050, 2, "EarthSpirit_OnLeaveCombat")
RegisterUnitEvent(21050, 4, "EarthSpirit_OnDeath")