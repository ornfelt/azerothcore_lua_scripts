function CDefender_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CDefender_Spell1", 7000, 0)
	Unit:RegisterEvent("CDefender_Spell2", 16000, 0)
end

function CDefender_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(38233,Unit:GetClosestPlayer())
end

function CDefender_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(38031,Unit:GetClosestPlayer())
end

function CDefender_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CDefender_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19762, 1, "CDefender_OnEnterCombat")
RegisterUnitEvent(19762, 2, "CDefender_OnLeaveCombat")
RegisterUnitEvent(19762, 4, "CDefender_OnDied")