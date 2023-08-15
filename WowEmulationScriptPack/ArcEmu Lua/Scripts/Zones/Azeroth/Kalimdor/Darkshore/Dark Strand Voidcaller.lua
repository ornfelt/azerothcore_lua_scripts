--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DarkStrandVoidcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkStrandVoidcaller_ShadowBolt", 8000, 0)
	Unit:RegisterEvent("DarkStrandVoidcaller_SummonVoidwalker", 2000, 1)
end

function DarkStrandVoidcaller_ShadowBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20807, 	pUnit:GetMainTank()) 
end

function DarkStrandVoidcaller_SummonVoidwalker(pUnit, Event) 
	pUnit:CastSpell(12746) 
end

function DarkStrandVoidcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkStrandVoidcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2337, 1, "DarkStrandVoidcaller_OnCombat")
RegisterUnitEvent(2337, 2, "DarkStrandVoidcaller_OnLeaveCombat")
RegisterUnitEvent(2337, 4, "DarkStrandVoidcaller_OnDied")