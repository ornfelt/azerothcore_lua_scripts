function DCTalonite_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DCTalonite_ColdTouch", 18000, 0)
	Unit:RegisterEvent("DCTalonite_TalonOfJustice", 15000, 0)
end

function DCTalonite_ColdTouch(Unit,Event)
	Unit:FullCastSpellOnTarget(39230,Unit:GetClosestPlayer())
end


function DCTalonite_TalonOfJustice(Unit,Event)
	Unit:FullCastSpellOnTarget(39229,Unit:GetClosestPlayer())
end

function DCTalonite_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function DCTalonite_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19825, 1, "DCTalonite_OnEnterCombat")
RegisterUnitEvent(19825, 4, "DCTalonite_OnDied")
RegisterUnitEvent(19825, 2, "DCTalonite_OnLeaveCombat")