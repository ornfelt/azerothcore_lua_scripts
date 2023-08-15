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

function Yor_Fire(pUnit, Event)
	print "Yor Double Breath"
	pUnit:FullCastSpellOnTarget(38361,Unit:GetClosestPlayer(0))
end

function Yor_stomp(pUnit, Event)
	print "Yor stomp"
	pUnit:CastSpell(36405)
end

function Yor_OnCombat(pUnit, Event)
	print "Yor"
	pUnit:RegisterEvent("Yor_Fire",10000,0)
	pUnit:RegisterEvent("Yor_stomp",13000,0)
end


function Yor_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Yor_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(22930, 1, "Yor_OnCombat")
RegisterUnitEvent(22930, 2, "Yor_OnLeaveCombat")
RegisterUnitEvent(22930, 3, "Yor_OnDied")