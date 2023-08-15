--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function Otto_OnEnterCombat(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:RegisterEvent("Pummel", 12000, 0)
	Unit:RegisterEvent("Backhand", 16000, 0)
end

function Pummel(Unit,Event)
	Unit:FullCastSpellOnTarget(12555,plr)
end

function Backhand(Unit,Event)
	Unit:FullCastSpellOnTarget(6253,plr)
end

function Otto_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Otto_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2599,1,"Otto_OnEnterCombat")
RegisterUnitEvent(2599,2,"Otto_OnLeaveCombat")
RegisterUnitEvent(2599,4,"Otto_OnDied")