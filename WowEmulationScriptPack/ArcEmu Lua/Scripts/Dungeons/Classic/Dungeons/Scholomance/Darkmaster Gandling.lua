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
-- % Complete: 90
-- Comments: Missing: Player-Teleport | Second Creature Spawns are 20k + rand (1,15k)

-- [[Spells ]] --
local ARCANEMISSILES = 22272
local SHADOWSHIELD = 22417
local CURSE = 18702

-- [[ Timers ]] --
local T_ARCANEMISSILES = 4500
local T_SHADOWSHIELD = 12000
local T_CURSE = 2000
local T_TELEPORT = 16000

function Darkmaster_OnCombat(Unit, Event)
	Unit:RegisterEvent("Darkmaster_Arcane", T_ARCANEMISSILES, 1)
	Unit:RegisterEvent("Darkmaster_Shadowshield", T_SHADOWSHIELD, 0)
	Unit:RegisterEvent("Darkmaster_Curse", T_CURSE, 0)
	Unit:RegisterEvent("Darkmaster_Teleport", T_TELEPORT, 0)
end

function Darkmaster_Arcane(Unit, Event)
	ArcaneTarget=Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(ARCANEMISSILES, ArcaneTarget)
	Unit:RegisterEvent("Darkmaster_ArcaneSecond", 8000, 0)
end

function Darkmaster_ArcaneSecond(Unit, Event)
	ArcaneTarget=Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(ARCANEMISSILES, ArcaneTarget)
end

function Darkmaster_Shadowshield(Unit, Event)
	Unit:CastSpell(SHADOWSHIELD)
	arcane_timer=14000+math.random(1, 14000)
	Unit:RegisterEvent("Darkmaster_ShadowshieldSecond", arcane_timer, 0)
end

function Darkmaster_ShadowshieldSecond(Unit, Event)
	Unit:CastSpell(SHADOWSHIELD)
end

function Darkmaster_Curse(Unit, Event)
	CurseTarget=Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(CURSE, CurseTarget)
	curse_timer=15000+math.random(1, 12000)
	Unit:RegisterEvent("Darkmaster_CurseSecond", curse_timer, 0)
end

function Darkmaster_CurseSecond(Unit, Event)
	CurseTarget=Unit:GetRandomPlayer()
	Unit:FullCastSpellOnTarget(CURSE, CurseTarget)
end

function Darkmaster_Teleport(Unit, Event)
		Unit:ClearThreatList()
		target=Unit:GetRandomPlayer()
		Unit:ChangeTarget(target)
		target:SendBroadcastMessage("You are now the target of"..Unit:GetName().."!") -- not blizzlike but nice ;)
		rand = math.random(1,6)
	if (rand == 1) then
		Unit:SpawnCreature(16119,254.2325,0.3417,84.8407,0,10000)
		Unit:SpawnCreature(16119,257.7133,4.0226,84.8407,0,10000)
		Unit:SpawnCreature(16119,258.6702,-2.60656,84.8407,0,10000)
	end
	if (rand == 2) then
		Unit:SpawnCreature(16119,184.0519,-73.5649,84.8407,0,10000)
		Unit:SpawnCreature(16119,179.5951,-73.7045,84.8407,0,10000)
		Unit:SpawnCreature(16119,180.6452,-78.2143,84.8407,0,10000)
		Unit:SpawnCreature(16119,283.2274,-78.1518,84.8407,0,10000)
	end
	if (rand == 3) then
		Unit:SpawnCreature(16119,100.9404,-1.8016,85.2289,0,10000)
		Unit:SpawnCreature(16119,101.3729,0.4882,85.2289,0,10000)
		Unit:SpawnCreature(16119,101.4596,-4.4740,85.2289,0,10000)
	end
	if (rand == 4) then
		Unit:SpawnCreature(16119,240.34481,0.7368,72.6722,0,10000)
		Unit:SpawnCreature(16119,240.3633,-2.9520,72.6722,0,10000)
		Unit:SpawnCreature(16119,240.6702,3.34949,72.6722,0,10000)
	end
	if (rand == 5) then
		Unit:SpawnCreature(16119,184.0519,-73.5649,70.7734,0,10000)
		Unit:SpawnCreature(16119,179.5951,-73.7045,70.7734,0,10000)
		Unit:SpawnCreature(16119,180.6452,-78.2143,70.7734,0,10000)
		Unit:SpawnCreature(16119,283.2274,-78.1518,70.7734,0,10000)
	end
	if (rand == 6) then
		Unit:SpawnCreature(16119,115.3945,-1.5555,75.3663,0,10000)
		Unit:SpawnCreature(16119,257.7133,1.8066,75.3663,0,10000)
		Unit:SpawnCreature(16119,258.6702,-5.1001,75.3663,0,10000)
	end
end

function Darkmaster_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function Darkmaster_OnKilledTarget(Unit, Event)
end

function Darkmaster_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1853, 1, "Darkmaster_OnCombat")
RegisterUnitEvent(1853, 2, "Darkmaster_OnLeaveCombat")
RegisterUnitEvent(1853, 3, "Darkmaster_OnKilledTarget")
RegisterUnitEvent(1853, 4, "Darkmaster_OnDied")