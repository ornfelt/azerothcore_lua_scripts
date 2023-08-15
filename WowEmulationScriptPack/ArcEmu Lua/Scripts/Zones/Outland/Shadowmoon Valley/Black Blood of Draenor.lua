function BBOD_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BBOD_Spell", 60000, 0)
end

function BBOD_Spell(Unit,Event)
	Unit:FullCastSpellOnTarget(7279,Unit:GetClosestPlayer())
end

function BBOD_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BBOD_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (23286, 1, "BBOD_OnEnterCombat")
RegisterUnitEvent (23286, 2, "BBOD_OnLeaveCombat")
RegisterUnitEvent (23286, 4, "BBOD_OnDied")