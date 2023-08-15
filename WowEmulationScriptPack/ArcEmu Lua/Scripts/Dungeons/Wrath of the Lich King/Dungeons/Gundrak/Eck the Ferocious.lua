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

function EcktheFerocious_OnCombat(Unit, Event)
Unit:SendChatMessage(14, 0, "Grrrrrr")
Unit:RegisterEvent("EcktheFerocious_EckBerserk",20000, 0)
Unit:RegisterEvent("EcktheFerocious_EckBite",45000, 0)
Unit:RegisterEvent("EcktheFerocious_EckSpit",65000, 0)
Unit:RegisterEvent("EcktheFerocious_EckSpring",95000, 0)
end

function EcktheFerocious_EckBerserk(pUnit, Event)
pUnit:CastSpellOnTarget(55816, pUnit:GetRandomPlayer(0))
end

function EcktheFerocious_EckBite(pUnit, Event)
pUnit:FullCastSpellOnTarget(55813, pUnit:GetRandomPlayer(0))
end


function EcktheFerocious_EckSpit(pUnit, Event)
pUnit:CastSpellOnTarget(55814, pUnit:GetRandomPlayer(0))
end


function EcktheFerocious_EckSpring(pUnit, Event)
pUnit:FullCastSpellOnTarget(55815, pUnit:GetRandomPlayer(0))
end

function EcktheFerocious_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents() 
end

function EcktheFerocious_OnKilledTarget(Unit, Event)
end

function EcktheFerocious_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(29932, 1, "EcktheFerocious_OnCombat")
RegisterUnitEvent(29932, 2, "EcktheFerocious_OnLeaveCombat")
RegisterUnitEvent(29932, 3, "EcktheFerocious_OnKilledTarget")
RegisterUnitEvent(29932, 4, "EcktheFerocious_OnDied")