--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function Runeweaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("Runeweaver_AoE", 6000, 0)
end

function Runeweaver_AoE(pUnit, Event) 
	pUnit:CastSpell(3659) 
end

function Runeweaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Runeweaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2543, 1, "Runeweaver_OnCombat")
RegisterUnitEvent(2543, 2, "Runeweaver_OnLeaveCombat")
RegisterUnitEvent(2543, 4, "Runeweaver_OnDied")