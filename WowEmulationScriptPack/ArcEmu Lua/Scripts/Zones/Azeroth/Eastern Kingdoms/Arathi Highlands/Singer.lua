--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function Singer_OnEnterCombat(Unit,Event)
	Unit:CastSpell(13730)
	Unit:RegisterEvent("DominateMind", 34000, 0)
end

function DominateMind(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(14515,plr)
end

function Singer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Singer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2600,1,"Singer_OnEnterCombat")
RegisterUnitEvent(2600,2,"Singer_OnLeaveCombat")
RegisterUnitEvent(2600,4,"Singer_OnDied")