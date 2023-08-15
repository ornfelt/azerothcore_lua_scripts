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
   Mob_Jadespine_Basilisk.lua
   Original Code by DARKI
   Version 1
========================================]]--
-- % Complete: 100

-- [[ Spells ]] --
local CSLUMBER = 3636

function Basilisk_OnCombat(Unit, Event)
	local cslumber = 2000+math.random(1,26000) -- not exactly blizzlike, normal 1st 2000 then 28k
	Unit:RegisterEvent("Basilisk_Cslumber", cslumber, 0)
end

function Basilisk_Cslumber(Unit, Event)
	local Target=Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(CSLUMBER, Target)
end

function Basilisk_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Basilisk_OnDied(Unit, Event)
	Unit:RemoveEvents()
end 

RegisterUnitEvent(4863, 1, "Basilisk_OnCombat")
RegisterUnitEvent(4863, 2, "Basilisk_OnLeaveCombat")
RegisterUnitEvent(4863, 4, "Basilisk_OnDied")