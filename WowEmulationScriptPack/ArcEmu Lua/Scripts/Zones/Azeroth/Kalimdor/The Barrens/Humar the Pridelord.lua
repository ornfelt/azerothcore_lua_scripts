--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HumarthePridelord_OnCombat(Unit, Event)
	Unit:RegisterEvent("HumarthePridelord_AgonizingPain", 10000, 0)
end

function HumarthePridelord_AgonizingPain(Unit, Event) 
	Unit:FullCastSpellOnTarget(3247, 	Unit:GetMainTank()) 
end

function HumarthePridelord_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HumarthePridelord_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HumarthePridelord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5828, 1, "HumarthePridelord_OnCombat")
RegisterUnitEvent(5828, 2, "HumarthePridelord_OnLeaveCombat")
RegisterUnitEvent(5828, 3, "HumarthePridelord_OnKilledTarget")
RegisterUnitEvent(5828, 4, "HumarthePridelord_OnDied")