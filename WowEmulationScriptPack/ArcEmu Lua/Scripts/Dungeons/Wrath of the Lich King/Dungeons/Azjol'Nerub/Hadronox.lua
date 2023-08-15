--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   SCRIPT NAME
   Original Code by DARKI
   Version 1
========================================]]--

function Hadronox_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Hadronox_WebGrab",15000, 0)
	pUnit:RegisterEvent("Hadronox_PierceArmor",12000, 0)
	pUnit:RegisterEvent("Hadronox_LeechPoison",10000, 0)
	pUnit:RegisterEvent("Hadronox_Acidcloud",20000, 0)	
end

function Hadronox_WebGrab(pUnit,Event)
	pUnit:FullCastSpellOnTarget(53406,pUnit:GetClosestPlayer(0))
end

function Hadronox_PierceArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(53418,pUnit:GetClosestPlayer(0))
end

function Hadronox_LeechPoison(pUnit,Event)
	pUnit:FullCastSpell(53030)
end

function Hadronox_Acidcloud(pUnit,Event)
	pUnit:FullCastSpellOnTarget(53400,pUnit:GetClosestPlayer(0))
end

function Hadronox_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Hadronox_OnDied(pUnit, event, player)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(28921, 1, "Hadronox_OnEnterCombat")
RegisterUnitEvent(28921, 2, "Hadronox_OnLeaveCombat")
RegisterUnitEvent(28921, 4, "Hadronox_OnDied")