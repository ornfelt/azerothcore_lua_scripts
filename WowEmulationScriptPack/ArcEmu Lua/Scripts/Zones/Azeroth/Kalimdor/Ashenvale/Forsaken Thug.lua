--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ForsakenThug_OnCombat(Unit, Event)
	Unit:RegisterEvent("ForsakenThug_Backhand", 7000, 0)
end

function ForsakenThug_Backhand(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6253, 	pUnit:GetMainTank()) 
end

function ForsakenThug_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ForsakenThug_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3734, 1, "ForsakenThug_OnCombat")
RegisterUnitEvent(3734, 2, "ForsakenThug_OnLeaveCombat")
RegisterUnitEvent(3734, 4, "ForsakenThug_OnDied")