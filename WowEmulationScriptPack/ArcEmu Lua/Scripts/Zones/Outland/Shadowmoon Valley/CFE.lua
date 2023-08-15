function CFE_OnEnterCombat(Unit,Event)
	Unit:CastSpell(35194)
	Unit:RegisterEvent("CFE_Fball", 5000, 0)
end

function CFE_Fball(Unit,Event)
	Unit:FullCastSpellOnTarget(9053,Unit:GetClosestPlayer())
end

function CFE_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CFE_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21706, 1, "CFE_OnEnterCombat")
RegisterUnitEvent(21706, 2, "CFE_OnLeaveCombat")
RegisterUnitEvent(21706, 4, "CFE_OnDied")