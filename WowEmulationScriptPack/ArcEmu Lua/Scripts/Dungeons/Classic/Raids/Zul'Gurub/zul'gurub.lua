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

--Parasitic Serpent AI
function Serpent_OneTimeBite(pUnit, event)
     pUnit:FullCastSpellOnTarget(23865, pUnit:GetClosestPlayer())
end

function Serpent_Bite(pUnit, event)
     pUnit:FullCastSpellOnTarget(23865, pUnit:GetClosestPlayer())
end

function Serpent_OnEnterCombat(pUnit, event)
     pUnit:RegisterEvent("Serpent_OneTimeBite", 2000, 1)
     pUnit:RegisterEvent("Serpent_Bite", 14000, 0)
end

RegisterUnitEvent(14884, 1, "Serpent_OnEnterCombat")

function Serpent_OnWipe(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(14884, 2, "Serpent_OnWipe")

function Serpent_OnDie(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(14884, 4, "Serpent_OnDie")