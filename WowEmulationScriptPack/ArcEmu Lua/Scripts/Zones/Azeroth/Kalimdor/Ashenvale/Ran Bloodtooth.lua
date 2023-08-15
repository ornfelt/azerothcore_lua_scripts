--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RanBloodtooth_OnCombat(Unit, Event)
	Unit:RegisterEvent("RanBloodtooth_MultiShot", 10000, 0)
	Unit:RegisterEvent("RanBloodtooth_Shoot", 6000, 0)
end

function RanBloodtooth_MultiShot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(14443, 	pUnit:GetMainTank()) 
end

function RanBloodtooth_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function RanBloodtooth_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RanBloodtooth_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3696, 1, "RanBloodtooth_OnCombat")
RegisterUnitEvent(3696, 2, "RanBloodtooth_OnLeaveCombat")
RegisterUnitEvent(3696, 4, "RanBloodtooth_OnDied")