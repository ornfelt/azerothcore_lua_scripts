function FRSentinel_OnEnterCombat(Unit,Event)
	Unit:CastSpell(38022)
	Unit:RegisterEvent("FRSentinel_Boom", 000, 0)
	Unit:RegisterEvent("FRSentinel_WorldBreaker", 16000, 0)
end

function FRSentinel_Boom(Unit,Event)
	Unit:FullCastSpellOnTarget(38052,Unit:GetClosestPlayer())
end

function FRSentinel_WorldBreaker(Unit,Event)
	Unit:FullCastSpellOnTarget(38052,Unit:GetClosestPlayer())
end

function FRSentinel_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function FRSentinel_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21949, 1, "FRSentinel_OnEnterCombat")
RegisterUnitEvent(21949, 1, "FRSentinel_OnLeaveCombat")
RegisterUnitEvent(21949, 1, "FRSentinel_OnDeath")