--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Brokespear_OnCombat(Unit, Event)
	Unit:RegisterEvent("Brokespear_SlowingPoison", 15000, 0)
	Unit:RegisterEvent("Brokespear_Throw", 5000, 0)
end

function Brokespear_SlowingPoison(Unit, Event) 
	Unit:FullCastSpellOnTarget(7992, 	Unit:GetMainTank()) 
end

function Brokespear_Throw(Unit, Event) 
	Unit:FullCastSpellOnTarget(10277, 	Unit:GetMainTank()) 
end

function Brokespear_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Brokespear_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Brokespear_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5838, 1, "Brokespear_OnCombat")
RegisterUnitEvent(5838, 2, "Brokespear_OnLeaveCombat")
RegisterUnitEvent(5838, 3, "Brokespear_OnKilledTarget")
RegisterUnitEvent(5838, 4, "Brokespear_OnDied")