--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightLordEverun_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightLordEverun_Fireball", 8000, 0)
	Unit:RegisterEvent("TwilightLordEverun_ShadowShock", 6000, 0)
end

function TwilightLordEverun_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(19816, 	Unit:GetMainTank()) 
end

function TwilightLordEverun_ShadowShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(17439, 	Unit:GetMainTank()) 
end

function TwilightLordEverun_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightLordEverun_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightLordEverun_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14479, 1, "TwilightLordEverun_OnCombat")
RegisterUnitEvent(14479, 2, "TwilightLordEverun_OnLeaveCombat")
RegisterUnitEvent(14479, 3, "TwilightLordEverun_OnKilledTarget")
RegisterUnitEvent(14479, 4, "TwilightLordEverun_OnDied")