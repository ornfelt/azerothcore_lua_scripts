--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadowSprite_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadowSprite_ShadowBolt", 8000, 0)
end

function ShadowSprite_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9613, 	Unit:GetMainTank()) 
end

function ShadowSprite_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ShadowSprite_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ShadowSprite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2003, 1, "ShadowSprite_OnCombat")
RegisterUnitEvent(2003, 2, "ShadowSprite_OnLeaveCombat")
RegisterUnitEvent(2003, 3, "ShadowSprite_OnKilledTarget")
RegisterUnitEvent(2003, 4, "ShadowSprite_OnDied")