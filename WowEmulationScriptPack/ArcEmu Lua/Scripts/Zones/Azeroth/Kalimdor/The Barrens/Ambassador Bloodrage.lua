--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmbassadorBloodrage_OnCombat(Unit, Event)
	Unit:RegisterEvent("AmbassadorBloodrage_Shadowbolt", 8000, 0)
end

function AmbassadorBloodrage_Shadowbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9613, 	Unit:GetMainTank()) 
end

function AmbassadorBloodrage_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AmbassadorBloodrage_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AmbassadorBloodrage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7895, 1, "AmbassadorBloodrage_OnCombat")
RegisterUnitEvent(7895, 2, "AmbassadorBloodrage_OnLeaveCombat")
RegisterUnitEvent(7895, 3, "AmbassadorBloodrage_OnKilledTarget")
RegisterUnitEvent(7895, 4, "AmbassadorBloodrage_OnDied")