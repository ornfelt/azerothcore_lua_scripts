--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function SyndicateConjuror_OnSpawn(Unit,Event)
	Unit:FullCastSpell(43896)
	Unit:FullCastSpell(25085)
end

function SyndicateConjuror_OnEnterCombat(Unit,Event)
local X,Y,Z =	Unit:GetX(),Unit:GetY(),Unit:GetZ()
local plr =	Unit:GetMainTank()
local PX,PY,PZ = plr:GetX(),plr:GetY(),plr:GetZ()
local VoidWalker =	Unit:GetCreatureNearestCoords(X,Y,Z,24476)
	VoidWalker:MoveTo(PX,PY,PZ)
	Unit:RegsiterEvent("ShadowBolt", 4000, 0)
	Unit:RegsiterEvent("Sleep", 23000, 0)
end

function ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(9613,plr)
end

function Sleep(Unit,Event)
	Unit:FullCastSpellOnTarget(15970,plr)
end

function SyndicateConjuror_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function SyndicateConjuror_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2590,18,"SyndicateConjuror_OnSpawn")
RegisterUnitEvent(2590,1,"SyndicateConjuror_OnEnterCombat")
RegisterUnitEvent(2590,2,"SyndicateConjuror_OnLeaveCombat")
RegisterUnitEvent(2590,4,"SyndicateConjuror_OnDied")