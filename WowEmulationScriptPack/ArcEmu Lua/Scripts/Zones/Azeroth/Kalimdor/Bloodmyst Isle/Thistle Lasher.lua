--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThistleLasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistleLasher_Lash", 8000, 0)
end

function ThistleLasher_Lash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31286, 	pUnit:GetMainTank()) 
end

function ThistleLasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistleLasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17343, 1, "ThistleLasher_OnCombat")
RegisterUnitEvent(17343, 2, "ThistleLasher_OnLeaveCombat")
RegisterUnitEvent(17343, 4, "ThistleLasher_OnDied")