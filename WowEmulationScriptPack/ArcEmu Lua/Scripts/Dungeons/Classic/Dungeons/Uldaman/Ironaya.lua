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
   Boss_Ironaya.lua
   Original Code by DARKI
   Version 1
========================================]]--
-- % Completed: 5
-- Comments: This script will be ready soon

-- [[ Global Variables ]] --
local knocked = 0
local wstomp = 0

-- [[ Spells ]] --
local ARCINGSMASH = 39144
local KNOCKAWAY = 22893
local WSTOMP = 16727

function Ironaya_OnCombat(Unit, Event)
local arcing = 3000+math.random(1,10000)
	Unit:SendChatMessage(12, 0, "Nobody steals the secrets of the Creator!") 
	Unit:PlaySoundToSet(5851)	
	Unit:RegisterEvent("Ironaya_Knockaway", 1000, 0)	
	Unit:RegisterEvent("Ironaya_Arcing", 3000, 1)
end

function Ironaya_Knockaway(Unit, Event)
	if(Unit:GetHealthPct() < 50 and knocked == 0) then
		Target=Unit:GetRandomPlayer()
		Unit:FullCastSpellOnTarget(KNOCKAWAY, Target)
		local knocked = 1
	end
end

function Ironaya_Arcing(Unit, Event)	
	Unit:CastSpell(ARCINGSMASH)
end

function Ironaya_Wstomp(Unit, Event)	
	if(Unit:GetHealthPct() < 25 and wstomp == 0) then
		Unit:CastSpell(WSTOMP)
		local wstomp = 1
	end
end

function Ironaya_OnLeaveCombat(Unit, Event)	
	Unit:RemoveEvents()
end

function Ironaya_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(7228, 1, "Ironaya_OnCombat")
RegisterUnitEvent(7228, 2, "Ironaya_OnLeaveCombat")
RegisterUnitEvent(7228, 4, "Ironaya_OnDied")