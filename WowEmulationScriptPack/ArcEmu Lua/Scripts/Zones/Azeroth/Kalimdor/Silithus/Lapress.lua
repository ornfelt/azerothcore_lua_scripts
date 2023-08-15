--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Lapress_OnCombat(Unit, Event)
	Unit:RegisterEvent("Lapress_Rend", 8000, 0)
end

function Lapress_Rend(Unit, Event) 
	Unit:FullCastSpellOnTarget(13455, 	Unit:GetMainTank()) 
end

function Lapress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Lapress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Lapress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14473, 1, "Lapress_OnCombat")
RegisterUnitEvent(14473, 2, "Lapress_OnLeaveCombat")
RegisterUnitEvent(14473, 3, "Lapress_OnKilledTarget")
RegisterUnitEvent(14473, 4, "Lapress_OnDied")