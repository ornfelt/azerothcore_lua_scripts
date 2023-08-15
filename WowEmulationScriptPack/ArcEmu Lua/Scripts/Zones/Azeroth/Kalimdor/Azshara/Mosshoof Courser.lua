--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MosshoofCourser_OnCombat(Unit, Event)
	Unit:RegisterEvent("MosshoofCourser_Enrage", 10000, 0)
end

function MosshoofCourser_Enrage(pUnit, Event) 
	pUnit:CastSpell(8599) 
end

function MosshoofCourser_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MosshoofCourser_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8761, 1, "MosshoofCourser_OnCombat")
RegisterUnitEvent(8761, 2, "MosshoofCourser_OnLeaveCombat")
RegisterUnitEvent(8761, 4, "MosshoofCourser_OnDied")