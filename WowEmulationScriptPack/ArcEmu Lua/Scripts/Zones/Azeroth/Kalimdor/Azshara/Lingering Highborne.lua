--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LingeringHighborne_OnCombat(Unit, Event)
	Unit:RegisterEvent("LingeringHighborne_Enfeeble", 8000, 0)
end

function LingeringHighborne_Enfeeble(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11963, 	pUnit:GetMainTank()) 
end

function LingeringHighborne_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LingeringHighborne_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(7864, 1, "LingeringHighborne_OnCombat")
RegisterUnitEvent(7864, 2, "LingeringHighborne_OnLeaveCombat")
RegisterUnitEvent(7864, 4, "LingeringHighborne_OnDied")