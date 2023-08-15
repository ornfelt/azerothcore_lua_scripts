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
   Boss_Darkmaster_Gandling.lua
   Original Code by DARKI
   Version 1
========================================]]--
-- % Completed: 50%
-- Comments: Summoning Mages & Minion is missing

local SHADOWBOLTVOLLEY = 20741
local BONESHIELD = 27688

function Kormok_OnCombat(Unit, Event)
	shadow = 10000+math.random(1, 5000)
	bone = 2000+math.random(1, 43000)
	Unit:RegisterEvent("Kormok_Shadow", shadow, 0)
	Unit:RegisterEvent("Kormok_Bone", bone, 0)
end

function Kormok_Shadow(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(SHADOWBOLTVOLLEY, RandomPlayer)
end

function Kormok_Bone(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(BONESHIELD, RandomPlayer)
end

function Kormok_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Kormok_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(16118, 1, "Kormok_OnCombat")
RegisterUnitEvent(16118, 2, "Kormok_OnLeaveCombat")
RegisterUnitEvent(16118, 4, "Kormok_OnDied")