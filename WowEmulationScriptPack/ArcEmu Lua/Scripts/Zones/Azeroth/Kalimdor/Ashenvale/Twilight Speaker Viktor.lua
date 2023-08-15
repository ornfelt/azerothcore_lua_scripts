--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightSpeakerViktor_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightSpeakerViktor_Fireball", 7000, 0)
end

function TwilightSpeakerViktor_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20793, 	pUnit:GetMainTank()) 
end

function TwilightSpeakerViktor_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightSpeakerViktor_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25924, 1, "TwilightSpeakerViktor_OnCombat")
RegisterUnitEvent(25924, 2, "TwilightSpeakerViktor_OnLeaveCombat")
RegisterUnitEvent(25924, 4, "TwilightSpeakerViktor_OnDied")