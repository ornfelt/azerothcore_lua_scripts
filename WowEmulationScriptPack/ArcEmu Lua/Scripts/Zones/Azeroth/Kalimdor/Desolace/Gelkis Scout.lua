--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GelkisScout_OnCombat(Unit, Event)
	Unit:RegisterEvent("GelkisScout_Shoot", 6000, 0)
end

function GelkisScout_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function GelkisScout_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GelkisScout_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GelkisScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4647, 1, "GelkisScout_OnCombat")
RegisterUnitEvent(4647, 2, "GelkisScout_OnLeaveCombat")
RegisterUnitEvent(4647, 3, "GelkisScout_OnKilledTarget")
RegisterUnitEvent(4647, 4, "GelkisScout_OnDied")