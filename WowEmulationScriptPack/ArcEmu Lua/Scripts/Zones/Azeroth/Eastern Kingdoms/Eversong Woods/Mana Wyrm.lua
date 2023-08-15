--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function ManaWyrm_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ManaWyrm_FaerieFire", 16000, 0)
end

function ManaWyrm_FaerieFire(Unit,Event)
local plr =	Unit:GetMainTank()
 if plr ~= nil then 
	return
	else
	Unit:FullCastSpellOnTarget(25602,plr)
end
end

function ManaWyrm_OnLeaveCombat(Unit,Event)
	Unit:CancelSpell()
	Unit:RemoveEvents()
end

function ManaWyrm_OnDied(Unit,Event)
	Unit:CancelSpell()
	Unit:RemoveEvents()
end

function ManaWyrm_OnKill(Unit,Event)
	Unit:CancelSpell()
	Unit:RemoveEvents()
end

RegisterUnitEvent(15274, 1, "ManaWyrm_OnEnterCombat")
RegisterUnitEvent(15274, 2, "ManaWyrm_OnLeaveCombat")
RegisterUnitEvent(15274, 3, "ManaWyrm_OnDied")
RegisterUnitEvent(15274, 4, "ManaWyrm_OnKill")