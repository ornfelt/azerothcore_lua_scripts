--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function HighlandFleshstalker_OnEnterCombat(Unit,Event)
local plr =	Unit:GetMainTank()
 if	Unit:GetHealthPct() <= 29 then
	Unit:FullCastSpellOnTarget(3393,plr)
end
end

RegisterUnitEvent(2561,1,"HighlandFleshstalker_OnEnterCombat")