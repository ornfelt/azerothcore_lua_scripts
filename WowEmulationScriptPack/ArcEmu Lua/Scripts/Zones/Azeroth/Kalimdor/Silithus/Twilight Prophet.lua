--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightProphet_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightProphet_ChainLightning", 10000, 0)
	Unit:RegisterEvent("TwilightProphet_FireNova", 4000, 0)
	Unit:RegisterEvent("TwilightProphet_FrostNova", 8000, 0)
	Unit:RegisterEvent("TwilightProphet_PsychicScream", 12000, 0)
end

function TwilightProphet_ChainLightning(Unit, Event) 
	Unit:FullCastSpellOnTarget(15308, 	Unit:GetMainTank()) 
end

function TwilightProphet_FireNova(Unit, Event) 
	Unit:CastSpell(17366) 
end

function TwilightProphet_FrostNova(Unit, Event) 
	Unit:CastSpell(15531) 
end

function TwilightProphet_PsychicScream(Unit, Event) 
	Unit:CastSpell(22884) 
end

function TwilightProphet_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightProphet_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightProphet_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15308, 1, "TwilightProphet_OnCombat")
RegisterUnitEvent(15308, 2, "TwilightProphet_OnLeaveCombat")
RegisterUnitEvent(15308, 3, "TwilightProphet_OnKilledTarget")
RegisterUnitEvent(15308, 4, "TwilightProphet_OnDied")