function AltarDefender_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("AltarDefender_Shoot", 11000, 0)
end

function AltarDefender_Shoot(Unit,Event)
	Unit:FullCastSpellOnTarget(41440,Unit:GetClosestPlayer())
end

function AltarDefender_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function AltarDefender_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (23453, 1, "AltarDefender_OnEnterCombat")
RegisterUnitEvent (23453, 2, "AltarDefender_OnLeaveCombat")
RegisterUnitEvent (23453, 4, "AltarDefender_OnDied")