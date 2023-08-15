--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MavorisCloudsbreak_OnCombat(Unit, Event)
	Unit:RegisterEvent("MavorisCloudsbreak_LightningCloud", 10000, 0)
end

function MavorisCloudsbreak_LightningCloud(pUnit, Event) 
	pUnit:CastSpell(6535) 
end

function MavorisCloudsbreak_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MavorisCloudsbreak_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3942, 1, "MavorisCloudsbreak_OnCombat")
RegisterUnitEvent(3942, 2, "MavorisCloudsbreak_OnLeaveCombat")
RegisterUnitEvent(3942, 4, "MavorisCloudsbreak_OnDied")