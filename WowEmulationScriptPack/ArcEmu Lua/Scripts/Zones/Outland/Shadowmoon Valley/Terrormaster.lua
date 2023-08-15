function Terrormaster_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Terrormaster_Cleave", 9000, 0)
	Unit:RegisterEvent("Terrormaster_Fear", 24000, 0)
end

function Terrormaster_Cleave(Unit,Event)
	Unit:FullCastSpellOnTarget(15496,Unit:GetClosestPlayer())
end

function Terrormaster_Fear(Unit,Event)
	Unit:FullCastSpellOnTarget(38154,Unit:GetClosestPlayer())
end

function Terrormaster_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Terrormaster_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21314, 1, "Terrormaster_OnEnterCombat")
RegisterUnitEvent(21314, 2, "Terrormaster_OnLeaveCombat")
RegisterUnitEvent(21314, 4, "Terrormaster_OnDied")