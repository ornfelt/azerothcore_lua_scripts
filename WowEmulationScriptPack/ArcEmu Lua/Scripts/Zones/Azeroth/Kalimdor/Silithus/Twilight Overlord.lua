--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TwilightOverlord_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightOverlord_ChainLightning", 10000, 0)
	Unit:RegisterEvent("TwilightOverlord_FireBlast", 6000, 0)
	Unit:RegisterEvent("TwilightOverlord_Frostbolt", 8000, 0)
end

function TwilightOverlord_ChainLightning(Unit, Event) 
	Unit:FullCastSpellOnTarget(12058, 	Unit:GetMainTank()) 
end

function TwilightOverlord_FireBlast(Unit, Event) 
	Unit:FullCastSpellOnTarget(13339, 	Unit:GetMainTank()) 
end

function TwilightOverlord_Frostbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9672, 	Unit:GetMainTank()) 
end

function TwilightOverlord_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightOverlord_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightOverlord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15213, 1, "TwilightOverlord_OnCombat")
RegisterUnitEvent(15213, 2, "TwilightOverlord_OnLeaveCombat")
RegisterUnitEvent(15213, 3, "TwilightOverlord_OnKilledTarget")
RegisterUnitEvent(15213, 4, "TwilightOverlord_OnDied")