--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function LandRager_OnCombat(Unit, Event)
	Unit:RegisterEvent("LandRager_Enrage", 120000, 0)
end

function LandRager_Enrage(Unit, Event) 
if 	Unit:GetHealthPct() < 25 then
	Unit:CastSpell(8599) 
end
end

function LandRager_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LandRager_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function LandRager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5465, 1, "LandRager_OnCombat")
RegisterUnitEvent(5465, 2, "LandRager_OnLeaveCombat")
RegisterUnitEvent(5465, 3, "LandRager_OnKilledTarget")
RegisterUnitEvent(5465, 4, "LandRager_OnDied")