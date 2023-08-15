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
local SUMMON = 23261

function Deathknight_OnCombat(Unit, Event)
end

function Deathknight_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Deathknight_OnKilledTarget(Unit, Event)
	Unit:CastSpell(SUMMON)
end

function Deathknight_OnDied(Unit, Event)
	Unit:RemoveEvents()
end 

RegisterUnitEvent(14516, 1, "Deathknight_OnCombat")
RegisterUnitEvent(14516, 2, "Deathknight_OnLeaveCombat")
RegisterUnitEvent(14516, 3, "Deathknight_OnKilledTarget")
RegisterUnitEvent(14516, 4, "Deathknight_OnDied")