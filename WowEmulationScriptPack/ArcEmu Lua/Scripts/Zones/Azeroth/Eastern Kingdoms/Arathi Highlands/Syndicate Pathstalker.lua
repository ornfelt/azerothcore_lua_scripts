--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function SyndicatePathstalker_OnEnterCombat(Unit,Event)
local plr =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(6660,plr)
end

RegisterUnitEvent(2587,1,"SyndicatePathstalker_OnEnterCombat")