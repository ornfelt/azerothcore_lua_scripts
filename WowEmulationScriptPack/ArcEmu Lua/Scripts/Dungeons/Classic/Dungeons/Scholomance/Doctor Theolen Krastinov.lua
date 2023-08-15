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
-- % Completed: 90
-- Comments: Spawning after Died not tested, Textemote is missing

-- [[Spells ]] --
local REND = 18106
local CLEAVE = 15584
local FRENZY = 28371

function Doctor_OnCombat(Unit, Event)
	pUnit:SendChatMessage(11, 0, "The doctor is in!")
	rend = 8000+math.random(1, 2000)
	cleave = 9000+math.random(1, 1000)
	frenzy = math.random(1, 8000)
	Unit:RegisterEvent("Doctor_Rend", rend, 0)
	Unit:RegisterEvent("Doctor_Cleave", cleave, 0)
	Unit:RegisterEvent("Doctor_Frenzy", frenzy, 0)
end

function Doctor_Rend(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(REND, RandomPlayer)
end

function Doctor_Cleave(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(CLEAVE, RandomPlayer)
end

function Doctor_Frenzy(Unit, Event)
	Unit:CastSpell(FRENZY)
	-- Textemote: verwandelt sich in einen t\195\182dlichen Frenzy! -- Need translate
end

function Doctor_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Doctor_OnDied(Unit, Event)
	Unit:RemoveEvents()
	Unit:SpawnCreature(1853, 180.73, -9.43856, 75.507, 0, 0)
end

RegisterUnitEvent(11261, 1, "Doctor_OnCombat")
RegisterUnitEvent(11261, 2, "Doctor_OnLeaveCombat")
RegisterUnitEvent(11261, 4, "Doctor_OnDied")