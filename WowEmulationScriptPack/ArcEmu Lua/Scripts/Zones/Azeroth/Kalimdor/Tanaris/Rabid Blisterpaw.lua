--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RabidBlisterpaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("RabidBlisterpaw_Rabies", 10000, 1)
end

function RabidBlisterpaw_Rabies(Unit, Event) 
	Unit:FullCastSpellOnTarget(3150, 	Unit:GetMainTank()) 
end

function RabidBlisterpaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RabidBlisterpaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RabidBlisterpaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5427, 1, "RabidBlisterpaw_OnCombat")
RegisterUnitEvent(5427, 2, "RabidBlisterpaw_OnLeaveCombat")
RegisterUnitEvent(5427, 3, "RabidBlisterpaw_OnKilledTarget")
RegisterUnitEvent(5427, 4, "RabidBlisterpaw_OnDied")