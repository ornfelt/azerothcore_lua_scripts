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
   kurinaxx.lua
   Original Code by DARKI
   Version 1
========================================]]--
--[[Actually SandTrap is bugged. It doesn't do any damage and stay tooooooo long. For about 2 minutes. Original one stays 2 seconds. 
Oh, and it doesnt appear near the target but near the caster xX  (and yes, I tested all SandTrap spells) But I will include it anyways, just commented out. 
Feel free to test it and tell me your ideas. I could spawn a dummy near the player that casts it and despawns? That'd actually be an idea!]]--

local cleave = 0

function KuriOnCombat(Unit, event)
	--Unit:RegisterEvent("KuriSandTrap", 8000, 0)
	Unit:RegisterEvent("KuriCleave", 3500, 0)
end

function KuriCleave(Unit, event)
	if cleave == 3 then
		Unit:ClearThreatList()
	else
	end
	--Mortal wound... 28467 should be the right one. Its not a real cleave but this one deals damage and afflicts the "Mortal Wound" debuff to the target
	Unit:FullCastSpellOnTarget(28467, Unit:GetClosestPlayer())
	cleave = cleave+1
end

function KuriSandTrap(Unit, event)
local player = Unit:GetRandomPlayer(0)
local Xpos = player:GetX()
local Ypos = player:GetY()
local Zpos = player:GetZ()
	if(player ~= nil) then
		Unit:SpawnCreature(90007, Xpos, Ypos, Zpos, 0, 168, 10000)
	else
	end
end

function DummySandTrap(Unit, event)
	Unit:CastSpell(25648)
	sleep(2000)
	FullCastSpellOnTarget(25656, Unit:GetClosestPlayer())
	Unit:Despawn(100, 0)
	Unit:RegisterEvent("DummyTimerCheck", 1, 1)
end
--[[
function DummyTimerCheck(Unit, event)
	time = Timer:time()
	if(time > 1999) then
	print "TimeCheckSuccessful"
	--distance = Unit:GetDistance(target)
	--if(distance < 15) then
	print "DistanceCheckSuccessful"
	FullCastSpellOnTarget(25656, Unit:GetClosestPlayer())
	--end
	end
	Unit:Despawn(100, 0)
end
]]
function KuriOnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function KuriOnDied(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(90007, 6, "DummySandTrap")
RegisterUnitEvent(15348, 1, "KuriOnCombat")
RegisterUnitEvent(15348, 3, "KuriOnLeaveCombat")
RegisterUnitEvent(15348, 4, "KuriOnDied")