--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Krellack_OnCombat(Unit, Event)
	Unit:RegisterEvent("Krellack_FatalSting", 8000, 0)
end

function Krellack_FatalSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(17170, 	Unit:GetMainTank()) 
end

function Krellack_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Krellack_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Krellack_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14476, 1, "Krellack_OnCombat")
RegisterUnitEvent(14476, 2, "Krellack_OnLeaveCombat")
RegisterUnitEvent(14476, 3, "Krellack_OnKilledTarget")
RegisterUnitEvent(14476, 4, "Krellack_OnDied")