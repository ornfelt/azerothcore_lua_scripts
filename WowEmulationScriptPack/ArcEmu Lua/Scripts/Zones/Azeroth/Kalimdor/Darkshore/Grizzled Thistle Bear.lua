--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrizzledThistleBear_OnCombat(Unit, Event)
	Unit:RegisterEvent("GrizzledThistleBear_Ravage", 8000, 0)
end

function GrizzledThistleBear_Ravage(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3242, 	pUnit:GetMainTank()) 
end

function GrizzledThistleBear_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GrizzledThistleBear_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2165, 1, "GrizzledThistleBear_OnCombat")
RegisterUnitEvent(2165, 2, "GrizzledThistleBear_OnLeaveCombat")
RegisterUnitEvent(2165, 4, "GrizzledThistleBear_OnDied")