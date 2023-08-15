function DSubjugator_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
	Unit:RegisterEvent("DSubjugator_Shadowbolt", 9000, 0)
end

function DSubjugator_Shadowbolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function DSubjugator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end
function DSubjugator_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(21718, 1, "DSubjugator_OnEnterCombat")
RegisterUnitEvent(21718, 2, "DSubjugator_OnLeaveCombat")
RegisterUnitEvent(21718, 4, "DSubjugator_OnDied")