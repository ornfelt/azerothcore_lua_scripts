--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Highborne_OnCombat(Unit, Event)
	Unit:RegisterEvent("Highborne_Blast", 6000, 0)
end

function Highborne_Blast(Unit, Event) 
	Unit:FullCastSpellOnTarget(13860, 	Unit:GetMainTank()) 
end

function Highborne_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Highborne_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(7524, 1, "Highborne_OnCombat")
RegisterUnitEvent(7524, 2, "Highborne_OnLeaveCombat")
RegisterUnitEvent(7524, 4, "Highborne_OnDied")