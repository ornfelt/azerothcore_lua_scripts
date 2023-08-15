function Arcane_servent_OnCombat(Unit, Event) 
	Unit:SendChatMessage(11, 0, "Feel the arcane power!!!")
	Unit:RegisterEvent("Arcane_servent_arcane_blast", 5000, 100)
end

function Arcane_servent_arcane_blast(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(30451, pUnit:GetRandomPlayer(0)) 
end

RegisterUnitEvent(200004, 1, "Arcane_servent_OnCombat")