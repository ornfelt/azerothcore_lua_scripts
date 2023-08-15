--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightKeeperMayna_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightKeeperMayna_ShadowWordPain", 2000, 2)
	Unit:RegisterEvent("TwilightKeeperMayna_MindFlay", 6000, 0)
	Unit:RegisterEvent("TwilightKeeperMayna_PsychicScream", 10000, 0)
end

function TwilightKeeperMayna_ShadowWordPain(Unit, Event) 
	Unit:FullCastSpellOnTarget(15654, 	Unit:GetMainTank()) 
end

function TwilightKeeperMayna_MindFlay(Unit, Event) 
	Unit:FullCastSpellOnTarget(17165, 	Unit:GetMainTank()) 
end

function TwilightKeeperMayna_PsychicScream(Unit, Event) 
	Unit:FullCastSpellOnTarget(22884, 	Unit:GetMainTank()) 
end

function TwilightKeeperMayna_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightKeeperMayna_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightKeeperMayna_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15200, 1, "TwilightKeeperMayna_OnCombat")
RegisterUnitEvent(15200, 2, "TwilightKeeperMayna_OnLeaveCombat")
RegisterUnitEvent(15200, 3, "TwilightKeeperMayna_OnKilledTarget")
RegisterUnitEvent(15200, 4, "TwilightKeeperMayna_OnDied")