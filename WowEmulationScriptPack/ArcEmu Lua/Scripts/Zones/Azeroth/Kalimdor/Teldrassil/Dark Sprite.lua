--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DarkSprite_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkSprite_DarkenVision", 8000, 0)
end

function DarkSprite_DarkenVision(Unit, Event) 
	Unit:FullCastSpellOnTarget(5514, 	Unit:GetMainTank()) 
end

function DarkSprite_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkSprite_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DarkSprite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2004, 1, "DarkSprite_OnCombat")
RegisterUnitEvent(2004, 2, "DarkSprite_OnLeaveCombat")
RegisterUnitEvent(2004, 3, "DarkSprite_OnKilledTarget")
RegisterUnitEvent(2004, 4, "DarkSprite_OnDied")