--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function LordFalconcrest_OnEnterCombat(Unit,Event)
	Unit:SendChatMessage(11, 0, "I presume you come with good news?")
	Unit:CastSpell()
	Unit:RegisterEvent("Disarm", 23000, 0)
end

function Disarm(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(6713,plr)
end

function LordFalconcrest_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function LordFalconcrest_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2597,1,"LordFalconcrest_OnEnterCombat")
RegisterUnitEvent(2597,1,"LordFalconcrest_OnLeaveCombat")
RegisterUnitEvent(2597,1,"LordFalconcrest_OnDied")