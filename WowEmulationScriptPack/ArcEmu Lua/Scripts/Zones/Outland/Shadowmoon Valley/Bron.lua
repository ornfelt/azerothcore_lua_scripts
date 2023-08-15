function Bron_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Bron_ThrowHammer", 15000, 0)
end

function Bron_ThrowHammer(Unit,Event)
	Unit:FullCastSpellOnTarget(33822,Unit:GetClosestPlayer())
end

function Bron_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Bron_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19395, 1, "Bron_OnEnterCombat")
RegisterUnitEvent(19395, 2, "Bron_OnLeaveCombat")
RegisterUnitEvent(19395, 4, "Bron_OnDied")