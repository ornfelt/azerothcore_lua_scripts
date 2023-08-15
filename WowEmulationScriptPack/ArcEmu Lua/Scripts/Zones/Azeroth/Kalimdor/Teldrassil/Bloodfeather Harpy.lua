--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodfeatherHarpy_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodfeatherHarpy_BloodLeech", 6000, 0)
end

function BloodfeatherHarpy_BloodLeech(Unit, Event) 
	Unit:FullCastSpellOnTarget(6958, 	Unit:GetMainTank()) 
end

function BloodfeatherHarpy_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodfeatherHarpy_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BloodfeatherHarpy_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2015, 1, "BloodfeatherHarpy_OnCombat")
RegisterUnitEvent(2015, 2, "BloodfeatherHarpy_OnLeaveCombat")
RegisterUnitEvent(2015, 3, "BloodfeatherHarpy_OnKilledTarget")
RegisterUnitEvent(2015, 4, "BloodfeatherHarpy_OnDied")