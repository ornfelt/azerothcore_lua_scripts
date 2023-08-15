--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DarkStrandAdept_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkStrandAdept_SummonVoidwalker", 1000, 1)
	Unit:RegisterEvent("DarkStrandAdept_ShadowBolt", 8000, 0)
end

function DarkStrandAdept_SummonVoidwalker(pUnit, Event) 
	pUnit:CastSpell(12746) 
end

function DarkStrandAdept_ShadowBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20791, 	pUnit:GetMainTank()) 
end

function DarkStrandAdept_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkStrandAdept_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3728, 1, "DarkStrandAdept_OnCombat")
RegisterUnitEvent(3728, 2, "DarkStrandAdept_OnLeaveCombat")
RegisterUnitEvent(3728, 4, "DarkStrandAdept_OnDied")