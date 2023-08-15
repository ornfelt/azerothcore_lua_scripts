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
   Shadowfang Keep Units.lua
   Original Code by DARKI
   Version 1
========================================]]--
-- % Complete: 1%
-- Comments: Only ChatMessages

-- [[ Functions ]] --
function Nandos_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "I can't believe it! You've destroyed my pack... Now face my wrath!")
end

function Nandos_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Nandos_OnDied(Unit, Event)
	Unit:RemoveEvents()
end 

RegisterUnitEvent(3927, 1, "Nandos_OnCombat")
RegisterUnitEvent(3927, 2, "Nandos_OnLeaveCombat")
RegisterUnitEvent(3927, 4, "Nandos_OnDied")