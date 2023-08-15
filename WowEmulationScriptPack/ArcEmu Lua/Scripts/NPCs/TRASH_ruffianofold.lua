function ruffianofold_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Get back here!")
	Unit:RegisterEvent("Net", 12000, 0)
	Unit:RegisterEvent("KnockDown", 8000, 0)
end

function Net(Unit, Event)
	Unit:FullCastSpellOnTarget(38661, Unit:GetClosestPlayer(0))
end

function KnockDown(Unit, Event)
	Unit:FullCastSpellOnTarget(29711, Unit:GetClosestPlayer(0))
end

function ruffianofold_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function ruffianofold_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(12, 0, "They were asking for it.")
end

function ruffianofold_OnDied(Unit, Event)
	Unit:SendChatMessage(12, 0, "Its just a flesh wound.")
		Unit:RemoveEvents()
end

RegisterUnitEvent(700008,1,"ruffianofold_OnCombat")
RegisterUnitEvent(700008,2,"ruffianofold_OnLeaveCombat")
RegisterUnitEvent(700008,3,"ruffianofold_OnKilledTarget")
RegisterUnitEvent(700008,4,"ruffianofold_OnDied")