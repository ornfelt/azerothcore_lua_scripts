--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashRaider_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashRaider_FrostShock", 6000, 0)
end

function SpitelashRaider_FrostShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12548, 	pUnit:GetMainTank()) 
end

function SpitelashRaider_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashRaider_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12204, 1, "SpitelashRaider_OnCombat")
RegisterUnitEvent(12204, 2, "SpitelashRaider_OnLeaveCombat")
RegisterUnitEvent(12204, 4, "SpitelashRaider_OnDied")