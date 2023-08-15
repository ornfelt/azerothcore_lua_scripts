--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodElfScout_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodElfScout_FaerieFire", 8000, 0)
end

function BloodElfScout_FaerieFire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(25602, 	pUnit:GetMainTank()) 
end

function BloodElfScout_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodElfScout_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(16521, 1, "BloodElfScout_OnCombat")
RegisterUnitEvent(16521, 2, "BloodElfScout_OnLeaveCombat")
RegisterUnitEvent(16521, 4, "BloodElfScout_OnDied")