--[[
*******************************************************
*          LASP - LUA AREA SCRIPTING PROJECT          *
*                      License                        *
*******************************************************
This software is provided as free and open source by the
staff of The Lua Area Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

Area - Durotar - Important Mobs.lua by Yerney
Report Bugs at www.lasp.forumotion.com
-- ]]

--Sarkoth
function Sarkoth_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Sarkoth_Claw", 1000, 2)
end

function Sarkoth_Claw(pUnit, Event)
	pUnit:FullCastSpellOnTarget(16827, 	pUnit:GetClosestPlayer())
end

RegisterUnitEvent(3281, 1, "Sarkoth_OnCombat")

--Yarrog BaneShadow
function Yarrog_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Yarrog_Fire", 7500, 2)
	pUnit:RegisterEvent("Yarrog_Curse", 20000, 1)
end

function Yarrog_Fire(pUnit, Event)
	pUnit:FullCastSpellOnTarget(348, 	pUnit:GetClosestPlayer())
end

function Yarrog_Curse(pUnit, Event)
	pUnit:FullCastSpellOnTarget(172, 	pUnit:GetClosestPlayer())
end

function Yarrog_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Yarrog_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3183, 1, "Yarrog_OnCombat")
RegisterUnitEvent(3183, 2, "Yarrog_LeaveCombat")
RegisterUnitEvent(3183, 4, "Yarrog_Dead")

--Zalazane
function Zala_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Zala_Heal", 18000, 1)
	pUnit:RegisterEvent("Zala_Shrink", 9000, 1)
end

function Zala_Heal(Unit, Event)
	Unit:CastSpell(332)
end

function Zala_Shrink(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7289, 	pUnit:GetClosestPlayer())
end

function Zala_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Zala_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3205, 1, "Zala_OnCombat")
RegisterUnitEvent(3205, 2, "Zala_LeaveCombat")
RegisterUnitEvent(3205, 4, "Zala_Dead")

-- Gazz'uz, Burnin Blade Boss
function Gaz_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Gaz_Shadow", 12000, 0)
	pUnit:RegisterEvent("Gaz_Corr", 15000, 1)
	pUnit:RegisterEvent("Gaz_Armor", 1000,1)
end

function Gaz_Shadow(pUnit, Event)
	pUnit:FullCastSpellOnTarget(20791, 	pUnit:GetClosestPlayer())
end

function Gaz_Armor(Unit, Event)
	Unit:CastSpell(20798)
end

function Gaz_Corr(pUnit, Event)
	pUnit:FullCastSpellOnTarget(172, 	pUnit:GetClosestPlayer())
end

function Gaz_OnSpawn(Unit, Event)
	Unit:CastSpell(5108)
end

function Gaz_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Gaz_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3204, 1, "Gaz_OnCombat")
RegisterUnitEvent(3204, 2, "Gaz_LeaveCombat")
RegisterUnitEvent(3204, 4, "Gaz_Dead")
RegisterUnitEvent(3204, 6, "Gaz_OnSpawn")

--fizzle Darkstorm
function Fiz_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Fiz_Shadow", 9000, 0)
	pUnit:RegisterEvent("Fiz_Soul", 15000, 1)
end

function Fiz_Shadow(pUnit, Event)
	pUnit:FullCastSpellOnTarget(20791, 	pUnit:GetClosestPlayer())
end

function Fiz_Soul(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7290, 	pUnit:GetClosestPlayer())
end

function Fiz_OnSpawn(Unit, Event)
	Unit:CastSpell(11939)
end

function Fiz_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Fiz_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3203, 1, "Fiz_OnCombat")
RegisterUnitEvent(3203, 2, "Fiz_LeaveCombat")
RegisterUnitEvent(3203, 4, "Fiz_Dead")
RegisterUnitEvent(3203, 6, "Fiz_OnSpawn")