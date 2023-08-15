--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function CMage_OnCombat(Unit, Event)
	Unit:RegisterEvent("CMage_Bloodlust", 10000, 0)
	Unit:RegisterEvent("CMage_Bolt", 6000, 0)
end

function CMage_Bolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function CMage_Bloodlust(pUnit, Event) 
	pUnit:CastSpell(6742) 
end

function CMage_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CMage_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2255, 1, "CMage_OnCombat")
RegisterUnitEvent(2255, 2, "CMage_OnLeaveCombat")
RegisterUnitEvent(2255, 4, "CMage_OnDied")