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

function Gahz_Frostbreath(pUnit, event)
     print "Gahz_Frostbreath initiated..."
     pUnit:FullCastSpell(16099)
     pUnit:RegisterEvent("Gahz_Frostbreath", math.random(22000, 26000), 1)
end

function Gahz_Slam(pUnit, event)
     print "Gahz_Slam initiated..."
     pUnit:FullCastSpell(24326)
end

function Gahz_OnEnterCombat(pUnit, event)
     print "Gahz_Aggro initiated..."
     pUnit:RegisterEvent("Gahz_Frostbreath", math.random(16000, 20000), 1)
     pUnit:RegisterEvent("Gahz_Slam", 25000, 0)
end

RegisterUnitEvent(15114, 1, "Gahz_OnEnterCombat")

function Gahz_OnWipe(pUnit, event)
     print "Gahz_Wipe initiated..."
     pUnit:RemoveEvents()
end

RegisterUnitEvent(15114, 2, "Gahz_OnWipe")

function Gahz_OnDie(pUnit, event)
     print "Gahz_Dies initiated..."
     pUnit:RemoveEvents()
end

RegisterUnitEvent(15114, 4, "Gahz_OnDie")