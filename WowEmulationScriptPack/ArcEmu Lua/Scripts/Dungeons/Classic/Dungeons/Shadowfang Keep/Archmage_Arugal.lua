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
   Archmage_Arugal.lua
   Original Code by DARKI
   Version 1
========================================]]--
-- % Complete: 100%
-- Comments: Only ChatMessages

-- [[ Functions ]] --
function Arugal_OnCombat(Unit, Event)
local random = math.random(1,2)
	if(random == 1) then
		Unit:SendChatMessage("Who dares interfere with the Sons of Arugal?")
	elseif(random == 2) then
		Unit:SendChatMessage("You too, shall serve!")
	end
end

function Arugal_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Arugal_OnKilledTarget(Unit, Event)
    Unit:SendChatMessage("Another falls!")
end

function Arugal_OnDied(Unit, Event)
	Unit:RemoveEvents()
end 

RegisterUnitEvent(4275, 1, "Arugal_OnCombat")
RegisterUnitEvent(4275, 2, "Arugal_OnLeaveCombat")
RegisterUnitEvent(4275, 3, "Arugal_OnKilledTarget")
RegisterUnitEvent(4275, 4, "Arugal_OnDied")