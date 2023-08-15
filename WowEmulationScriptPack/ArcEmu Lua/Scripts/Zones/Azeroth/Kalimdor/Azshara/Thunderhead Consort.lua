--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThunderheadConsort_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderheadConsort_LightningBreath", 8000, 0)
end

function ThunderheadConsort_LightningBreath(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(36594, 	pUnit:GetMainTank()) 
end

function ThunderheadConsort_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderheadConsort_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6380, 1, "ThunderheadConsort_OnCombat")
RegisterUnitEvent(6380, 2, "ThunderheadConsort_OnLeaveCombat")
RegisterUnitEvent(6380, 4, "ThunderheadConsort_OnDied")