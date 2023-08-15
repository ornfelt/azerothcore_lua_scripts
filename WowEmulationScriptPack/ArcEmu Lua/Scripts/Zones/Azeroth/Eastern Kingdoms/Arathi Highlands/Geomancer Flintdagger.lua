--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function GeomancerFlintdagger_OnSpawn(Unit,Event)
	Unit:CastSpell(2601)
end

function GeomancerFlintdagger_OnEnterCombat(Unit,Event)
local X,Y,Z =	Unit:GetX(),Unit:GetY(),Unit:GetZ()
local totem =	Unit:GetCreatureNearestCoords(X,Y,Z,6111)
local plr =	Unit:GetMainTank()
	Unit:RegisterEvent("FireNovaTotem", 15000, 1)
	Unit:RegisterEvent("Fireball", 3000, 1)
end

function FireNovaTotem(Unit,Event)
 if (totem ~= nil) then
	return
	else
	Unit:CastSpell(8499)
end
end

function Fireball(Unit,Event)
	Unit:FullCastSpellOnTarget(20823,plr)
end

function GeomancerFlintdagger_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function GeomancerFlintdagger_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2609,18,"GeomancerFlintdagger_OnSpawn")
RegisterUnitEvent(2609,1,"GeomancerFlintdagger_OnEnterCombat")
RegisterUnitEvent(2609,2,"GeomancerFlintdagger_OnLeaveCombat")
RegisterUnitEvent(2609,4,"GeomancerFlintdagger_OnDied")