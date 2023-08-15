--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function KorgreshColdrage_OnEnterCombat(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:RegisterEvent("FrostNova", 25000, 0)
	Unit:RegisterEvent("TrelanesFreezingTouch", 45000, 0)
end

function FrostNova(Unit,Event)
	Unit:FullCastSpellOnTarget(865,plr)
end

function TrelanesFreezingTouch(Unit,Event)
	Unit:FullCastSpellOnTarget(4320,plr)
end

function KorgreshColdrage_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function KorgreshColdrage_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2793,1,"KorgreshColdrage_OnEnterCombat")
RegisterUnitEvent(2793,2,"KorgreshColdrage_OnLeaveCombat")
RegisterUnitEvent(2793,4,"KorgreshColdrage_OnDied")