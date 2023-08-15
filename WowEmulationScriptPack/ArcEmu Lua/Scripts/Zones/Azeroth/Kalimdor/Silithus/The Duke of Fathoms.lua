--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TheDukeofFathoms_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheDukeofFathoms_KnockAway", 6000, 0)
	Unit:RegisterEvent("TheDukeofFathoms_Knockdown", 8000, 0)
	Unit:RegisterEvent("TheDukeofFathoms_Thrash", 5000, 0)
end

function TheDukeofFathoms_KnockAway(Unit, Event) 
	Unit:FullCastSpellOnTarget(18670, 	Unit:GetMainTank()) 
end

function TheDukeofFathoms_Knockdown(Unit, Event) 
	Unit:FullCastSpellOnTarget(16790, 	Unit:GetMainTank()) 
end

function TheDukeofFathoms_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function TheDukeofFathoms_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheDukeofFathoms_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheDukeofFathoms_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15207, 1, "TheDukeofFathoms_OnCombat")
RegisterUnitEvent(15207, 2, "TheDukeofFathoms_OnLeaveCombat")
RegisterUnitEvent(15207, 3, "TheDukeofFathoms_OnKilledTarget")
RegisterUnitEvent(15207, 4, "TheDukeofFathoms_OnDied")