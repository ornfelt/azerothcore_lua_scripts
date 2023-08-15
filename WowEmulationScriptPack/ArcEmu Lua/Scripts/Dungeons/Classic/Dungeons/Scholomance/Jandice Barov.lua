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
-- % Completed: 20
-- Comments: Missing Whole Script

-- [[Spells ]] --
local CURSEOFBLOOD = 24673
local ILLUSION = 17773
local CLEAVE = 15584

function Jandice_OnCombat(Unit, Event)
end

function Jandice_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Jandice_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(10503, 1, "Jandice_OnCombat")
RegisterUnitEvent(10503, 2, "Jandice_OnLeaveCombat")
RegisterUnitEvent(10503, 4, "Jandice_OnDied")