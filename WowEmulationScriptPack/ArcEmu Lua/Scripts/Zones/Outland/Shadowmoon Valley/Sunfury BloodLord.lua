function SunfuryBloodLord_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("SunfuryBloodLord_DebilitatingStrike", 15000, 0)
	Unit:RegisterEvent("SunfuryBloodLord_TorrentOfFlames", 5000, 0)
end

function SunfuryBloodLord_DebilitatingStrike(Unit,Event)
	Unit:FullCastSpellOnTarget(37577,Unit:GetClosestPlayer())
end

function SunfuryBloodLord_TorrentOfFlames(Unit,Event)
	Unit:FullCastSpellOnTarget(36104,Unit:GetClosestPlayer())
end

function SunfuryBloodLord_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SunfuryBloodLord_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21743, 1, "SunfuryBloodLord_OnEnterCombat")
RegisterUnitEvent(21743, 2, "SunfuryBloodLord_OnLeaveCombat")
RegisterUnitEvent(21743, 4, "SunfuryBloodLord_OnDied")