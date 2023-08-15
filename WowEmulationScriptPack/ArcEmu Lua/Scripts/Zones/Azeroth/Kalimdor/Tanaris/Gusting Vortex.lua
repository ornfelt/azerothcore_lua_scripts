--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GustingVortex_OnCombat(Unit, Event)
	Unit:RegisterEvent("GustingVortex_GustofWind", 8000, 0)
end

function GustingVortex_GustofWind(Unit, Event) 
	Unit:CastSpell(6982) 
end

function GustingVortex_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GustingVortex_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GustingVortex_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8667, 1, "GustingVortex_OnCombat")
RegisterUnitEvent(8667, 2, "GustingVortex_OnLeaveCombat")
RegisterUnitEvent(8667, 3, "GustingVortex_OnKilledTarget")
RegisterUnitEvent(8667, 4, "GustingVortex_OnDied")