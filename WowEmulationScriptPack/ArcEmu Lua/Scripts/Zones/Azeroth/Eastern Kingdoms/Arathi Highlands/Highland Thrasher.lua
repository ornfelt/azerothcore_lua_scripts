--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function HighlandThrasher_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("Thrash", 7000, 0)
end

function Thrash(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(3391,plr)
end

function HighlandThrasher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function HighlandThrasher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2560,1,"HighlandThrasher_OnEnterCombat")
RegisterUnitEvent(2560,1,"HighlandThrasher_OnLeaveCombat")
RegisterUnitEvent(2560,1,"HighlandThrasher_OnDied")