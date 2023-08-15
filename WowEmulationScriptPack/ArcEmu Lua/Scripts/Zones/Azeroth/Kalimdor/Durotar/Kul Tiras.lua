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

Area - Durotar - Kul Tiras.lua by Yerney
Report Bugs at www.lasp.forumotion.com
-- ]]

--Kult Tiras Marine
function KTM_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("KTM_Bash", 5000, 1)
end

function KTM_Bash(pUnit, Event)
	pUnit:FullCastSpellOnTarget(11972, 	pUnit:GetClosestPlayer())
end

function KTM_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function KTM_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3129, 1, "KTM_OnCombat")
RegisterUnitEvent(3129, 2, "KTM_LeaveCombat")
RegisterUnitEvent(3129, 4, "KTM_Dead")

--Kult Tiras Sailor
function KTS_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("KTS_Charge", 500, 1)
end

function KTS_Charge(pUnit, Event)
	pUnit:CastSpell(6268)
end

function KTS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function KTS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3128, 1, "KTS_OnCombat")
RegisterUnitEvent(3128, 2, "KTS_LeaveCombat")
RegisterUnitEvent(3128, 4, "KTS_Dead")


--Benedict
function Benedict_OnCombat(pUnit, Event)
	pUnit:CastSpell(7164)
	pUnit:RegisterEvent("Benedict_Buff", 10000, 1)
	pUnit:RegisterEvent("Benedict_Bash", 14000, 2)
end

function Benedict_Buff(pUnit, Event)
	pUnit:CastSpell(3248)
end

function Benedict_Bash(pUnit, Event)
	pUnit:CastSpellOnTarget(72, 	pUnit:GetClosestPlayer())
end

function Benedict_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Benedict_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3192, 1, "Benedict_OnCombat")
RegisterUnitEvent(3192, 2, "Benedict_LeaveCombat")
RegisterUnitEvent(3192, 4, "Benedict_Dead")