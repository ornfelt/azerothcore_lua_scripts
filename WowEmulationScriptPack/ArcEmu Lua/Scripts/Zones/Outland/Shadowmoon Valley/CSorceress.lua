function CSorceress_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("CSiren_Spell1", 20000, 0)
	Unit:RegisterEvent("CSiren_Spell2", 6000, 0)
end

function CSorceress_Spell1(Unit,Event)
	Unit:FullCastSpellOnTarget(38026,Unit:GetClosestPlayer())
end

function CSorceress_Spell2(Unit,Event)
	Unit:FullCastSpellOnTarget(32011,Unit:GetClosestPlayer())
end

function CSorceress_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function CSorceress_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(19767,1,"CSorceress_OnEnterCombat")
RegisterUnitEvent(19767,2,"CSorceress_OnLeaveCombat")
RegisterUnitEvent(19767,4,"CSorceress_OnDied")