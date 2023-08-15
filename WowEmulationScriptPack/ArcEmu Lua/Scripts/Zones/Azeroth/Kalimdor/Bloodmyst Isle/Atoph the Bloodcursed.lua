--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AtophtheBloodcursed_OnCombat(Unit, Event)
	Unit:RegisterEvent("AtophtheBloodcursed_Rend", 10000, 0)
	Unit:RegisterEvent("AtophtheBloodcursed_Strike", 6000, 0)
end

function AtophtheBloodcursed_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11977, 	pUnit:GetMainTank()) 
end

function AtophtheBloodcursed_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetClosestPlayer()) 
end

function AtophtheBloodcursed_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AtophtheBloodcursed_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17715, 1, "AtophtheBloodcursed_OnCombat")
RegisterUnitEvent(17715, 2, "AtophtheBloodcursed_OnLeaveCombat")
RegisterUnitEvent(17715, 4, "AtophtheBloodcursed_OnDied")