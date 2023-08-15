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
   Boss_Illucia_Barov.lua
   Original Code by DARKI
   Version 1
========================================]]--
-- % Complete: 100
-- Comments: Spawning after Dead not tested

-- [[ Spells ]] --
local CURSEOFAGONY = 18671
local SHADOWSHOCK = 20603
local SILENCE = 15487
local FEAR = 6215

function Barov_OnCombat(Unit, Event)
	cursetimer = 18000+math.random(1, 12000)
	shocktimer = 9000+math.random(1, 3000)
	silencetimer = 5000+math.random(1, 9000)
	Unit:RegisterEvent("Barov_Curse", cursetimer, 0)
	Unit:RegisterEvent("Barov_Shock", shocktimer, 0)
	Unit:RegisterEvent("Barov_Silence", silencetimer, 0)
	Unit:RegisterEvent("Barov_Fear", 30000, 0)
end 

function Barov_Curse(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(CURSEOFAGONY, RandomPlayer)
end

function Barov_Shock(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(SHADOWSHOCK, RandomPlayer)
end

function Barov_Silence(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer(7) -- Random Not Maintank
	Unit:FullCastSpellOnTarget(SILENCE, RandomPlayer)
end

function Barov_Fear(Unit, Event)
	RandomPlayer = Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(FEAR, RandomPlayer)
end

function Barov_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Barov_OnDied(Unit, Event)
	Unit:RemoveEvents()
	Unit:SpawnCreature(1853, 180.73, -9.43856, 75.507, 0, 0) -- Spawning Darkmaster Gandling
end 

RegisterUnitEvent(10502, 1, "Barov_OnCombat")
RegisterUnitEvent(10502, 2, "Barov_OnLeaveCombat")
RegisterUnitEvent(10502, 4, "Barov_OnDied")