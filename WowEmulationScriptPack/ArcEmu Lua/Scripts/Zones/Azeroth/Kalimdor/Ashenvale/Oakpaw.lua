--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Oakpaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("Oakpaw_Rejuvenation", 8000, 0)
end

function Oakpaw_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(12160) 
end

function Oakpaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Oakpaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10640, 1, "Oakpaw_OnCombat")
RegisterUnitEvent(10640, 2, "Oakpaw_OnLeaveCombat")
RegisterUnitEvent(10640, 4, "Oakpaw_OnDied")