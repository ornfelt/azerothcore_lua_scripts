--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ArcaneSerpent_OnCombat(Unit, Event)
	Unit:RegisterEvent("ArcaneSerpent_ArcaneJolt", 8000, 0)
end

function ArcaneSerpent_ArcaneJolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(50504, 	Unit:GetMainTank()) 
end

function ArcaneSerpent_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ArcaneSerpent_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ArcaneSerpent_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25721, 1, "ArcaneSerpent_OnCombat")
RegisterUnitEvent(25721, 2, "ArcaneSerpent_OnLeaveCombat")
RegisterUnitEvent(25721, 3, "ArcaneSerpent_OnKilledTarget")
RegisterUnitEvent(25721, 4, "ArcaneSerpent_OnDied")