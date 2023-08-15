--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function Vardus_OnCombat(Unit, Event)
	Unit:RegisterEvent("Vardus_Bolt", 6000, 0)
end

function Vardus_Bolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20822, pUnit:GetMainTank()) 
end

function Vardus_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Vardus_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2306, 1, "Vardus_OnCombat")
RegisterUnitEvent(2306, 2, "Vardus_OnLeaveCombat")
RegisterUnitEvent(2306, 4, "Vardus_OnDied")