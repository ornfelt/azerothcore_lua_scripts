--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function Enforcer_OnCombat(Unit, Event)
	Unit:RegisterEvent("Enforcer_Crack", 8000, 0)
end

function Enforcer_Crack(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9791, pUnit:GetMainTank()) 
end

function Enforcer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Enforcer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2256, 1, "Enforcer_OnCombat")
RegisterUnitEvent(2256, 2, "Enforcer_OnLeaveCombat")
RegisterUnitEvent(2256, 4, "Enforcer_OnDied")