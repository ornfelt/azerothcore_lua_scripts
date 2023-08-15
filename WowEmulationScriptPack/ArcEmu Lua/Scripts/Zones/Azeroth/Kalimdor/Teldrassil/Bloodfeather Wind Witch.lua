--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodfeatherWindWitch_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodfeatherWindWitch_GustofWind", 8000, 0)
end

function BloodfeatherWindWitch_GustofWind(Unit, Event) 
	Unit:FullCastSpellOnTarget(6982, 	Unit:GetMainTank()) 
end

function BloodfeatherWindWitch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodfeatherWindWitch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BloodfeatherWindWitch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2020, 1, "BloodfeatherWindWitch_OnCombat")
RegisterUnitEvent(2020, 2, "BloodfeatherWindWitch_OnLeaveCombat")
RegisterUnitEvent(2020, 3, "BloodfeatherWindWitch_OnKilledTarget")
RegisterUnitEvent(2020, 4, "BloodfeatherWindWitch_OnDied")