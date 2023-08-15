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

function DrakkariColossus_OnCombat(Unit, Event)
Unit:SendChatMessage(14, 0, "You will die!")
Unit:RegisterEvent("DrakkariColossus_Emerge",10000, 0)
Unit:RegisterEvent("DrakkariColossus_MightyBlow",25000, 0)
end

function DrakkariColossus_Emerge(pUnit, Event)
pUnit:CastSpellOnTarget(54850, pUnit:GetRandomPlayer(0))
end

function DrakkariColossus_MightyBlow(pUnit, Event)
pUnit:FullCastSpellOnTarget(54719, pUnit:GetRandomPlayer(0))
end

function DrakkariColossus_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents() 
end

function DrakkariColossus_OnKilledTarget(Unit, Event)
end

function DrakkariColossus_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(29307, 1, "DrakkariColossus_OnCombat")
RegisterUnitEvent(29307, 2, "DrakkariColossus_OnLeaveCombat")
RegisterUnitEvent(29307, 3, "DrakkariColossus_OnKilledTarget")
RegisterUnitEvent(29307, 4, "DrakkariColossus_OnDied")