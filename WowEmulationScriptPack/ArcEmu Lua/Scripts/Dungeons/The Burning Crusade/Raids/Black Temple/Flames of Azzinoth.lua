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
   Flames of Azzinoth.lua
   Original Code by DARKI
   Version 1
========================================]]--

function FlameOfAzzinoth_OnSpawn(pUnit,Event)
	pUnit:SetUInt64Value(UnitField.UNIT_FIELD_FLAGS, 0)
end

function FlameOfAzzinoth_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(40637)
	pUnit:RegisterEvent("FlameOfAzzinoth_FlameBlast", 15000, 0)
end

function FlameOfAzzinoth_FlameBlast(pUnit,Event)
local plr=pUnit:GetRandomPlayer(0)
 if ( type(plr) == "userdata") then
	pUnit:FullCastSpellOnTarget(40631,plr)
end
end

function FlameOfAzzinoth_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function FlameOfAzzinoth_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22997, 1, "FlameOfAzzinoth_OnEnterCombat")
RegisterUnitEvent(22997, 2, "FlameOfAzzinoth_OnLeaveCombat")
RegisterUnitEvent(22997, 4, "FlameOfAzzinoth_OnDied")

function FlameOfAzzinoth_FlameBlast(pUnit,Event)
local plr=pUnit:GetRandomPlayer(0)
 if ( type(plr) == "userdata") then
	pUnit:FullCastSpellOnTarget(40631,plr)
end
end