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

function Radioactive_mg_OnCombat(pUnit, event, miscpUnit, misc)
	pUnit:RegisterEvent("Dazed",1000,0)
	pUnit:RegisterEvent("Electrified_Net",15000,0)
end

function Dazed(pUnit, event, miscpUnit, misc)
	pUnit:CastSpellOnTarget(1604,pUnit:GetClosestPlayer(1))
end

function Electrified_Net(pUnit, event, miscpUnit, misc)
	pUnit:FullCastSpellOnTarget(11820, pUnit:GetClosestPlayer(1))
end

function Radioactive_mg_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function Radioactive_mg_OnDied(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(6234, 1, "Radioactive_mg_OnCombat")
RegisterUnitEvent(6234, 2, "Radioactive_mg_OnLeaveCombat")
RegisterUnitEvent(6234, 4, "Radioactive_mg_OnDied")