function magiofold_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Taste the wrath of the creator's will!")
	Unit:RegisterEvent("FireBall", 10000, 0)
	Unit:RegisterEvent("Polymorph", 15000, 0)
	Unit:RegisterEvent("ArcaneBarrage", 16000, 0)	
end

function FireBall(Unit, Event)
	Unit:FullCastSpellOnTarget(69583, Unit:GetClosestPlayer(0))
end

function Polymorph(Unit, Event)
	Unit:FullCastSpellOnTarget(29848, Unit:GetRandomPlayer(0))
end

function ArcaneBarrage(Unit, Event)
	Unit:FullCastSpellOnTarget(67996, Unit:GetRandomPlayer(0))
end

function magiofold_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function magiofold_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "More than I expected from a "..player:GetName()..".")
end

function magiofold_OnDied(Unit, Event)
		Unit:RemoveEvents()
end

RegisterUnitEvent(700007,1,"magiofold_OnCombat")
RegisterUnitEvent(700007,2,"magiofold_OnLeaveCombat")
RegisterUnitEvent(700007,3,"magiofold_OnKilledTarget")
RegisterUnitEvent(700007,4,"magiofold_OnDied")