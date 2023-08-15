--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function SyndicateThief_OnEnterCombat(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:RegisterEvent("Backstab", 1000, 1)
	Unit:RegisterEvent("Disarm", 13000, 1)
	Unit:RegisterEvent("Poison", 20000, 1)
end

function Backstab(Unit,Event)
	Unit:FullCastSpellOnTarget(7159,plr)
end

function Disarm(Unit,Event)
	Unit:FullCastSpellOnTarget(6713,plr)
end

function Poison(Unit,Event)
	Unit:FullCastSpellOnTarget(744,plr)
end

function SyndicateThief_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SyndicateThief_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2241,1,"SyndicateThief_OnEnterCombat")
RegisterUnitEvent(2241,2,"SyndicateThief_OnLeaveCombat")
RegisterUnitEvent(2241,4,"SyndicateThief_OnDied")