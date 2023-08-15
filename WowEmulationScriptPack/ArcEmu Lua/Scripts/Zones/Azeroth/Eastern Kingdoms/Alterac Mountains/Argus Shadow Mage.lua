--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function Mage_OnCombat(Unit, Event)
	Unit:RegisterEvent("Mage_Bolt", 6000, 0)
end

function Mage_Bolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20816, pUnit:GetMainTank()) 
end

function Mage_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Mage_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2318, 1, "Mage_OnCombat")
RegisterUnitEvent(2318, 2, "Mage_OnLeaveCombat")
RegisterUnitEvent(2318, 4, "Mage_OnDied")