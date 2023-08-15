function WildhammerScout_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(33808,Unit:GetClosestPlayer())
	Unit:RegisterEvent("WildhammerScout_ThrowHammer", 6000, 0)
end

function WildhammerScout_ThrowHammer(Unit,Event)
	Unit:FullCastSpellOnTarget(33805,Unit:GetClosestPlayer())
	Unit:FullCastSpellOnTarget(33806,Unit:GetClosestPlayer())
end

function WildhammerScout_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function WildhammerScout_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19384, 1, "WildhammerScout_OnEnterCombat")
RegisterUnitEvent(19384, 2, "WildhammerScout_OnLeaveCombat")
RegisterUnitEvent(19384, 4, "WildhammerScout_OnDied")