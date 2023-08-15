--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function RuulOnestone_OnEnterCombat(Unit,Event)
	Unit:CastSpell(6742)
	Unit:RegisterEvent("LightningBolt", 5000, 0)
end

function LightningBolt(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(9532,plr)
end

function RuulOnestone_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function RuulOnestone_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2602,1,"RuulOnestone_OnEnterCombat")
RegisterUnitEvent(2602,2,"RuulOnestone_OnLeaveCombat")
RegisterUnitEvent(2602,4,"RuulOnestone_OnDied")