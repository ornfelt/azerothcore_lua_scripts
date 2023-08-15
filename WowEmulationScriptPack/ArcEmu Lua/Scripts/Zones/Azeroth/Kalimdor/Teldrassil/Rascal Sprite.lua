--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RascalSprite_OnCombat(Unit, Event)
	Unit:RegisterEvent("RascalSprite_FaerieFire", 1000, 1)
end

function RascalSprite_FaerieFire(Unit, Event) 
	Unit:FullCastSpellOnTarget(6950, 	Unit:GetMainTank()) 
end

function RascalSprite_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RascalSprite_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RascalSprite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2002, 1, "RascalSprite_OnCombat")
RegisterUnitEvent(2002, 2, "RascalSprite_OnLeaveCombat")
RegisterUnitEvent(2002, 3, "RascalSprite_OnKilledTarget")
RegisterUnitEvent(2002, 4, "RascalSprite_OnDied")