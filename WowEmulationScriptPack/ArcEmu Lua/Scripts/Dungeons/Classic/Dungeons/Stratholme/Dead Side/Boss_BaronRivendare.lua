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
   Original Code by DARKI
   Version 1
========================================]]--
-- % Complete: 100
-- Comments:

-- [[ Spells ]] --
local SHADOWBOLT = 18164
local CLEAVE = 15584
local MORTALSTRIKE = 13737
local RAISEDEAD = 17475
local DEATHPACT = 17698
local SUMMONSKELETONS = 17274

function Baron_OnCombat(Unit, Event)
	local say = math.random(1, 6)
	if (say==1) then
		Unit:SendChatMessage(12, 0, "Invaders! Undoubtedly more henchmen Argentumd \ 195 \ 164mmerung. It is already one of them in my imprisonment. Pulls you out of my Dom \ 195 \ 164ne to \ 195 \ 188ck, executed before I leave!") -- blizzlike
	end
	if (say==2) then
		Unit:SendChatMessage(12, 0, "You're still here? Your stupidity is truly the \ 195 \ 188sant! The M \ 195 \ 164dchen the Argentumd \ 195 \ 164mmerung need not unn \ suffer 195 \ 182tig. Disappears immediately, and their lives will be spared!") -- blizzlike
	end
	if (say==3) then
		Unit:SendChatMessage(12, 0, "I shall take great pleasure in taking this poor wretch's life! It's not too late, she needn't suffer in vain. Turn back and her death shall be merciful!") -- German Translation is missing
	end
	if (say==4) then
		Unit:SendChatMessage(12, 0, "May this prisoner's death serve as a warning. None shall defy the Scourge and live!") -- German Translation is missing
	end
	if (say==5) then
		Unit:SendChatMessage(12, 0, "So you see fit to toy with the Lich King's creations? Ramstein, be sure to give the intruders a proper greeting.") -- German Translation is missing 
	end
	if (say==6) then
		Unit:SendChatMessage(12, 0, "Time to take matters into my own hands. Come. Enter my domain and challenge the might of the Scourge!") -- German Translation is missing
	end
	local shadowbolt = 5000+math.random(1,5000)
	local cleave = 8000+math.random(1,4000)
	local mortal = 12000+math.random(1,4000)
	local raise = 30000+math.random(1,15000)
	Unit:RegisterEvent("Baron_Shadowbolt", shadowbolt, 0)
	Unit:RegisterEvent("Baron_Cleave", cleave, 0)
	Unit:RegisterEvent("Baron_Mortalstrike", mortal, 0)
	Unit:RegisterEvent("Baron_Raise", raise, 0)
	Unit:RegisterEvent("Baron_Summon", 34000, 0)
end

function Baron_Shadowbolt(Unit, Event)
	local shadow_chance = math.random(1,100)
	if (shadow_chance < 70) then -- 70% Chance to cast
		local RandomPlayer = Unit:GetRandomPlayer()
		Unit:FullCastSpellOnTarget(SHADOWBOLT, RandomPlayer)
	end
end

function Baron_Cleave(Unit, Event)
	local cleave_chance = math.random(1,100)
	if (cleave_chance < 55) then -- 55% Chance to cast
		local RandomPlayer = Unit:GetRandomPlayer()
		Unit:FullCastSpellOnTarget(CLEAVE, RandomPlayer)
	end
end

function Baron_Mortalstrike(Unit, Event)
	local mortal_chance=math.random(1,100)
	if (mortal_chance < 30) then -- 30% Chance to cast
		local RandomPlayer = Unit:GetRandomPlayer()
		Unit:FullCastSpellOnTarget(MORTALSTRIKE, RandomPlayer)
	end
end

function Baron_Raise(Unit, Event)
	Unit:CastSpell(RAISEDEAD)
end

function Baron_Summon(Unit, Event)
	Unit:SpawnCreature(11197, 4017.403809, -3339.703369, 115.057655, 0, 29000)
	Unit:SpawnCreature(11197, 4013.189209, -3351.808350, 115.052254, 0, 29000)
	Unit:SpawnCreature(11197, 4017.738037, -3363.478016, 115.057274, 0, 29000)
	Unit:SpawnCreature(11197, 4048.877197, -3363.223633, 115.054253, 0, 29000)
	Unit:SpawnCreature(11197, 4051.777588, -3350.893311, 115.055351, 0, 29000)
	Unit:SpawnCreature(11197, 4048.375977, -3339.966309, 115.055222, 0, 29000)
end

function Baron_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Baron_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(10440, 1, "Baron_OnCombat")
RegisterUnitEvent(10440, 2, "Baron_OnLeaveCombat")
RegisterUnitEvent(10440, 4, "Baron_OnDied")