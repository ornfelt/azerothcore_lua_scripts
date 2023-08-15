--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MoonPriestessAmara_OnCombat(Unit, Event)
	Unit:RegisterEvent("MoonPriestessAmara_Shoot", 6000, 0)
end

function MoonPriestessAmara_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(18561, 	Unit:GetMainTank()) 
end

function MoonPriestessAmara_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MoonPriestessAmara_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function MoonPriestessAmara_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2151, 1, "MoonPriestessAmara_OnCombat")
RegisterUnitEvent(2151, 2, "MoonPriestessAmara_OnLeaveCombat")
RegisterUnitEvent(2151, 3, "MoonPriestessAmara_OnKilledTarget")
RegisterUnitEvent(2151, 4, "MoonPriestessAmara_OnDied")