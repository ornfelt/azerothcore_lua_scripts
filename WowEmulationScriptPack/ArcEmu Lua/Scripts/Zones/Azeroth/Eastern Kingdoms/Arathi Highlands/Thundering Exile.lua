--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function ThunderingExile_OnEnterCombat(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:RegsiterEvent("LightningBolt", 4000, 0)
	Unit:RegsiterEvent("Shock", 22000, 0)
end

function LightningBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9532,plr)
end

function Shock(Unit,Event)
	Unit:FullCastSPellOnTarget(11824,plr)
end

function ThunderingExile_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ThunderingExile_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2762,1,"ThunderingExile_OnEnterCombat")
RegisterUnitEvent(2762,2,"ThunderingExile_OnLeaveCombat")
RegisterUnitEvent(2762,4,"ThunderingExile_OnDied")