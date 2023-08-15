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

function Moorabi_OnCombat(Unit, Event)
Unit:SendChatMessage(14, 0, "Hmmm...It sucomes to this?")
Unit:RegisterEvent("Moorabi_DeterminedGore",20000, 0)
Unit:RegisterEvent("Moorabi_GroundTremor",45000, 0)
Unit:RegisterEvent("Moorabi_MojoFrenzy",65000, 0)
Unit:RegisterEvent("Moorabi_NumbingShout",95000, 0)
Unit:RegisterEvent("Moorabi_Transformation",100000, 0)
end

function Moorabi_DeterminedGore(pUnit, Event)
pUnit:CastSpellOnTarget(59444, pUnit:GetRandomPlayer(0))
end

function Moorabi_GroundTremor(pUnit, Event)
pUnit:FullCastSpellOnTarget(55142, pUnit:GetRandomPlayer(0))
end


function Moorabi_MojoFrenzy(pUnit, Event)
pUnit:CastSpellOnTarget(55163, pUnit:GetRandomPlayer(0))
end


function Moorabi_NumbingShout(pUnit, Event)
pUnit:FullCastSpellOnTarget(55106, pUnit:GetRandomPlayer(0))
end

function Moorabi_Transformation(pUnit, Event)
pUnit:FullCastSpellOnTarget(55098, pUnit:GetRandomPlayer(0))
end

function Moorabi_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents() 
end

function Moorabi_OnKilledTarget(Unit, Event)
end

function Moorabi_OnDied(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(29305, 1, "Moorabi_OnCombat")
RegisterUnitEvent(29305, 2, "Moorabi_OnLeaveCombat")
RegisterUnitEvent(29305, 3, "Moorabi_OnKilledTarget")
RegisterUnitEvent(29305, 4, "Moorabi_OnDied")