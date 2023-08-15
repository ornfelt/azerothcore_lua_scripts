--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Azurous_OnCombat(Unit, Event)
	Unit:RegisterEvent("Azurous_Breath", 8000, 0)
end

function Azurous_Breath(Unit, Event) 
	Unit:FullCastSpellOnTarget(16099, 	Unit:GetMainTank()) 
end

function Azurous_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Azurous_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10202, 1, "Azurous_OnCombat")
RegisterUnitEvent(10202, 2, "Azurous_OnLeaveCombat")
RegisterUnitEvent(10202, 4, "Azurous_OnDied")