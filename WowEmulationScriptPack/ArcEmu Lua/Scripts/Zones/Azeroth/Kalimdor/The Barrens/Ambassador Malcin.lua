--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmbassadorMalcin_OnCombat(Unit, Event)
	Unit:RegisterEvent("AmbassadorMalcin_Shadowbolt", 8000, 0)
end

function AmbassadorMalcin_Shadowbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9613, 	Unit:GetMainTank()) 
end

function AmbassadorMalcin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AmbassadorMalcin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AmbassadorMalcin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12865, 1, "AmbassadorMalcin_OnCombat")
RegisterUnitEvent(12865, 2, "AmbassadorMalcin_OnLeaveCombat")
RegisterUnitEvent(12865, 3, "AmbassadorMalcin_OnKilledTarget")
RegisterUnitEvent(12865, 4, "AmbassadorMalcin_OnDied")