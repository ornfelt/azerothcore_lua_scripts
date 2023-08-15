function IAgonizer_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("IAgonizer_Firebolt", 6000, 0)
end

function IAgonizer_Firebolt(Unit,Event)
	Unit:FullCastSpellOnTarget(36227,Unit:GetClosestPlayer())
end

function IAgonizer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function IAgonizer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19801, 1, "IAgonizer_OnEnterCombat")
RegisterUnitEvent(19801, 2, "IAgonizer_OnLeaveCombat")
RegisterUnitEvent(19801, 4, "IAgonizer_OnDied")