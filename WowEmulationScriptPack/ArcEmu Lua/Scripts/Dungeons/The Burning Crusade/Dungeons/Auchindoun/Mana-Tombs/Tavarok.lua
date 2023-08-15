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
   SCRIPT NAME
   Original Code by DARKI
   Version 1
========================================]]--
--Recon from Hungary :)

function Tavarok_Earthquake(pUnit, Event)
	print "Tavarok Earthquake"
	pUnit:CastSpell(33919)
	pUnit:SendChatMessage(11, 0, "Do you feel my Earthquake...")
end

function Tavarok_Crystal_Poison(pUnit, Event)
	print "Tavarok Crystal Poison"
	pUnit:FullCastSpellOnTarget(32361,Unit:GetRandomPlayer(0))
	pUnit:SendChatMessage(11, 0, "Some poison...")
end
--  Heroic spell --
function Tavarok_smash(pUnit, Event)
	print "Tavarok_smash"
	pUnit:CastSpellOnTarget(38761,pUnit:GetClosestPlayer(0))
end

function Tavarok_OnCombat(pUnit, Event)
	print "Tavarok"
	pUnit:RegisterEvent("Tavarok_Earthquake",10000,0)
	pUnit:RegisterEvent("Tavarok_Crystal_Poison",13000,0)
	pUnit:RegisterEvent("Tavarok_smash",13000,0)
end

function Tavarok_OnKilledTarget (pUnit, Event)
	
end

function Tavarok_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Tavarok_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(18343, 1, "Tavarok_OnCombat")
RegisterUnitEvent(18343, 2, "Tavarok_OnLeaveCombat")
RegisterUnitEvent(18343, 3, "Tavarok_OnKilledTarget")
RegisterUnitEvent(18343, 4, "Tavarok_OnDied")