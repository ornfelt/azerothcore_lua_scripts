--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VyraltheVile_OnCombat(Unit, Event)
	Unit:RegisterEvent("VyraltheVile_Fireball", 8000, 0)
	Unit:RegisterEvent("VyraltheVile_ShadowShock", 6000, 0)
end

function VyraltheVile_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(19816, 	Unit:GetMainTank()) 
end

function VyraltheVile_ShadowShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(17439, 	Unit:GetMainTank()) 
end

function VyraltheVile_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function VyraltheVile_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function VyraltheVile_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15202, 1, "VyraltheVile_OnCombat")
RegisterUnitEvent(15202, 2, "VyraltheVile_OnLeaveCombat")
RegisterUnitEvent(15202, 3, "VyraltheVile_OnKilledTarget")
RegisterUnitEvent(15202, 4, "VyraltheVile_OnDied")