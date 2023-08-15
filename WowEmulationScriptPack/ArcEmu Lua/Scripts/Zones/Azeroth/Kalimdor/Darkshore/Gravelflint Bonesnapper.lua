--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GravelflintBonesnapper_OnCombat(Unit, Event)
	Unit:RegisterEvent("GravelflintBonesnapper_HeadCrack", 8000, 0)
end

function GravelflintBonesnapper_HeadCrack(pUnit, Event) 
	pUnit:CastSpell(3148, 	pUnit:GetMainTank()) 
end

function GravelflintBonesnapper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GravelflintBonesnapper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2159, 1, "GravelflintBonesnapper_OnCombat")
RegisterUnitEvent(2159, 2, "GravelflintBonesnapper_OnLeaveCombat")
RegisterUnitEvent(2159, 4, "GravelflintBonesnapper_OnDied")