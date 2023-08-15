--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorruptedStomper_OnCombat(Unit, Event)
	Unit:RegisterEvent("CorruptedStomper_Stomp", 8000, 0)
end

function CorruptedStomper_Stomp(pUnit, Event) 
	pUnit:CastSpell(31277) 
end

function CorruptedStomper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CorruptedStomper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17353, 1, "CorruptedStomper_OnCombat")
RegisterUnitEvent(17353, 2, "CorruptedStomper_OnLeaveCombat")
RegisterUnitEvent(17353, 4, "CorruptedStomper_OnDied")