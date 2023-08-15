--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WildthornLurker_OnCombat(Unit, Event)
	Unit:RegisterEvent("WildthornLurker_Hide", 1000, 1)
end

function WildthornLurker_Hide(pUnit, Event) 
	pUnit:CastSpell(6920) 
end

function WildthornLurker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WildthornLurker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3821, 1, "WildthornLurker_OnCombat")
RegisterUnitEvent(3821, 2, "WildthornLurker_OnLeaveCombat")
RegisterUnitEvent(3821, 4, "WildthornLurker_OnDied")