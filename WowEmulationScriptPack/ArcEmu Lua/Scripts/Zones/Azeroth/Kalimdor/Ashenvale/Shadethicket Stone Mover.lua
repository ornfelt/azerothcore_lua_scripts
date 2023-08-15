--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadethicketStoneMover_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadethicketStoneMover_StrengthofStone", 10000, 0)
end

function ShadethicketStoneMover_StrengthofStone(pUnit, Event) 
	pUnit:CastSpell(6864) 
end

function ShadethicketStoneMover_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ShadethicketStoneMover_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3782, 1, "ShadethicketStoneMover_OnCombat")
RegisterUnitEvent(3782, 2, "ShadethicketStoneMover_OnLeaveCombat")
RegisterUnitEvent(3782, 4, "ShadethicketStoneMover_OnDied")