--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightMaster_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightMaster_ChainLightning", 10000, 0)
	Unit:RegisterEvent("TwilightMaster_Frostbolt", 7000, 0)
end

function TwilightMaster_ChainLightning(Unit, Event) 
	Unit:FullCastSpellOnTarget(12058, 	Unit:GetMainTank()) 
end

function TwilightMaster_Frostbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9672, 	Unit:GetMainTank()) 
end

function TwilightMaster_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightMaster_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightMaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11883, 1, "TwilightMaster_OnCombat")
RegisterUnitEvent(11883, 2, "TwilightMaster_OnLeaveCombat")
RegisterUnitEvent(11883, 3, "TwilightMaster_OnKilledTarget")
RegisterUnitEvent(11883, 4, "TwilightMaster_OnDied")