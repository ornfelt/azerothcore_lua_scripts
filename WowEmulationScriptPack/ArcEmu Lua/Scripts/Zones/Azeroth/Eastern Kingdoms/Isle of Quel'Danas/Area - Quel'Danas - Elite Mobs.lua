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

Area - Quel'Danas - Elite Mobs.lua by Yerney
Report Bugs at www.lasp.forumotion.com
-- ]]

--Eredar Sorcerer
function Eredar_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Eredar_Flames", 8900, 10)
end

function Eredar_Flames(pUnit, Event)
pUnit:FullCastSpellOnTarget(45046, pUnit:GetRandomPlayer(0))
end

function Eredar_leaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Eredar_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25033, 1, "Eredar_OnCombat")
RegisterUnitEvent(25033, 2, "Eredar_leaveCombat")
RegisterUnitEvent(25033, 4, "Eredar_Dead")

--Pit Overlord
function Pit_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Pit_Cleave", 4000, 0)
pUnit:RegisterEvent("Pit_Cone", 17000, 1)
pUnit:RegisterEvent("Pit_Coil", 8000, 3)
end

function Pit_Cleave(pUnit, Event)
pUnit:FullCastSpellOnTarget(15284, pUnit:GetClosestPlayer())
end

function Pit_Cone(pUnit, Event)
pUnit:FullCastSpell(19630)
end

function Pit_Coil(pUnit, Event)
pUnit:FullCastSpellOnTarget(32709, pUnit:GetRandomPlayer(0))
end

function Pit_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Pit_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25031, 1, "Pit_OnCombat")
RegisterUnitEvent(25031, 2, "Pit_LeaveCombat")
RegisterUnitEvent(25031, 4, "Pit_Dead")