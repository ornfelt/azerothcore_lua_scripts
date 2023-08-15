function Umberhowl_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Umberhowl_ChillingHowl", 30000, 0)
	Unit:RegisterEvent("Umberhowl_Snarl", 7000, 0)
end

function Umberhowl_ChillingHowl(Unit,Event)
	Unit:FullCastSpellOnTarget(32918,Unit:GetClosestPlayer())
end

function Umberhowl_Snarl(Unit,Event)
	Unit:FullCastSpellOnTarget(32919,Unit:GetClosestPlayer())
end

function Umberhowl_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Umberhowl_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21255, 1, "Umberhowl_OnEnterCombat")
RegisterUnitEvent(21255, 2, "Umberhowl_OnLeaveCombat")
RegisterUnitEvent(21255, 4, "Umberhowl_OnDied")