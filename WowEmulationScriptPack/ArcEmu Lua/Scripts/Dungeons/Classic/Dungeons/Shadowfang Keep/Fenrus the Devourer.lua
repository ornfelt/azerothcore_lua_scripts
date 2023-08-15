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
   Puppy.lua
   Original Code by DARKI
   Version 1
========================================]]--

function Puppy_Chill(Unit, Player, Event)
	Unit:CastSpell(21098)
end

function Puppy_Volly(Unit, Player, Event)
	Unit:CastSpell(38837)
end

function Puppy_Armor(Unit, Player, Event)
	Unit:CastSpell(27134)
end

function Puppy_IceNova(Unit, Player, Event)
	Unit:CastSpell(31250)
end

function Puppy_OnCombat(Unit, Player, Event)
	Unit:RegisterEvent("Puppy_Chill",80000, 0)
	Unit:RegisterEvent("Puppy_Volly",40000, 0)
	Unit:RegisterEvent("Puppy_Armor",20000, 0)
	Unit:RegisterEvent("Puppy_IceNova",90000, 0)
end

function Puppy_OnLeaveCombat(Unit, Player, Event)
	Unit:RemoveEvents()
end

function Puppy_OnKilledTarget(Unit, Player, Event)
	Unit:CastSpell(37669)
	Unit:RemoveEvents()
end

function Puppy_OnDied(Unit, Player, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4274, 1, "Puppy_OnCombat")
RegisterUnitEvent(4274, 2, "Puppy_OnLeaveCombat")
RegisterUnitEvent(4274, 3, "Puppy_OnKilledTarget")
RegisterUnitEvent(4274, 4, "Puppy_OnDied") 