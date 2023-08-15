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

function Radioactive_VF_OnCombat(pUnit, event, miscpUnit, misc)
	pUnit:RegisterEvent("Corrosive_Ooze",10000,0)
	pUnit:RegisterEvent("Radiation_Cloud",20000,0)
end

function Corrosive_Ooze(pUnit, event, miscpUnit, misc)
	pUnit:FullCastSpellOnTarget(9459, pUnit:GetClosestPlayer(1))
end

function Radiation_Cloud(pUnit, event, miscpUnit, misc)
	pUnit:FullCastSpellOnTarget(10341, pUnit:GetClosestPlayer(1))
end

function Radioactive_VF_saw_blade(pUnit)
	pUnit:FullCastSpell(35318)
end

function Radioactive_VF_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function Radioactive_VF_OnDied(pUnit)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(7079, 1, "Radioactive_VF_OnCombat")
RegisterUnitEvent(7079, 2, "Radioactive_VF_OnLeaveCombat")
RegisterUnitEvent(7079, 4, "Radioactive_VF_OnDied")