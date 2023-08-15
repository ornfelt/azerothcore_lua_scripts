--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodElfSurveyor_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodElfSurveyor_FireNova", 6000, 0)
end

function BloodElfSurveyor_FireNova(pUnit, Event) 
	pUnit:CastSpell(11969) 
end

function BloodElfSurveyor_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodElfSurveyor_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6198, 1, "BloodElfSurveyor_OnCombat")
RegisterUnitEvent(6198, 2, "BloodElfSurveyor_OnLeaveCombat")
RegisterUnitEvent(6198, 4, "BloodElfSurveyor_OnDied")