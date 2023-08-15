--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MagisterHawkhelm_OnCombat(Unit, Event)
	Unit:RegisterEvent("MagisterHawkhelm_Shoot", 6000, 0)
end

function MagisterHawkhelm_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function MagisterHawkhelm_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MagisterHawkhelm_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6647, 1, "MagisterHawkhelm_OnCombat")
RegisterUnitEvent(6647, 2, "MagisterHawkhelm_OnLeaveCombat")
RegisterUnitEvent(6647, 4, "MagisterHawkhelm_OnDied")