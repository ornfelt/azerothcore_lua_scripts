function DCScorncrow_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("DCScorncrow_FrostBolt", 12000, 0)
end

function DCScorncrow_Frostbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9672,Unit:GetClosestPlayer())
end


function DCScorncrow_LeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function DCScorncrow_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21385, 1, "DCScorncrow_OnEnterCombat")
RegisterUnitEvent(21385, 2, "DCScorncrow_LeaveCombat")
RegisterUnitEvent(21385, 4, "DCScorncrow_OnDied")