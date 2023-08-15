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
-- % Completed: 100
-- Comments: No Comments

-- [[Spells ]] --
local IMMOLATE = 20294
local VEILOFSHADOW = 17820

function Lord_OnCombat(Unit, Event)
	immolate = 7000+math.random(1, 5000)
	shadow = 15000+math.random(1, 5000)
	Unit:RegisterEvent("Lord_Immolate", immolate, 0)
	Unit:RegisterEvent("Lord_Shadow", shadow, 0)
end

function Lord_Immolate(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(IMMOLATE, RandomPlayer)
end

function Lord_Shadow(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(VEILOFSHADOW, RandomPlayer)
end

function Lord_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Lord_OnDied(Unit, Event)
	Unit:RemoveEvents()
	Unit:SpawnCreature(1853, 180.73, -9.43856, 75.507, 0, 0)
end 

RegisterUnitEvent(10504, 1, "Lord_OnCombat")
RegisterUnitEvent(10504, 2, "Lord_OnLeaveCombat")
RegisterUnitEvent(10504, 4, "Lord_OnDied")