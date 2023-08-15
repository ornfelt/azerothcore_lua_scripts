--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LadyMoongazer_OnCombat(Unit, Event)
	Unit:RegisterEvent("LadyMoongazer_Net", 10000, 0)
	Unit:RegisterEvent("LadyMoongazer_Shoot", 6000, 0)
end

function LadyMoongazer_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6533, 	pUnit:GetMainTank()) 
end

function LadyMoongazer_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function LadyMoongazer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LadyMoongazer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2184, 1, "LadyMoongazer_OnCombat")
RegisterUnitEvent(2184, 2, "LadyMoongazer_OnLeaveCombat")
RegisterUnitEvent(2184, 4, "LadyMoongazer_OnDied")