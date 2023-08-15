--//Durotar - Razormane Lua Script//Made by LASP - Yerney// Thank you for using our scripts.
--If you find / see any bugs, please report by contacting one of our scripters.
--                           luaprojectleader@hotmail.com

--RazorMane Battleguard
function RMB_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("RMB_Buff", 13000, 1)
end

function RMB_Buff(pUnit, Event)
	pUnit:CastSpell(3248)
end

function RMB_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RMB_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3114, 1, "RMB_OnCombat")
RegisterUnitEvent(3114, 2, "RMB_LeaveCombat")
RegisterUnitEvent(3114, 4, "RMB_Dead")


--RazorMane Quilboar
function RMQ_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("RMQ_Buff", 7500, 1)
end

function RMQ_Buff(pUnit, Event)
	pUnit:CastSpell(5280)
end

function RMQ_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RMQ_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3111, 1, "RMQ_OnCombat")
RegisterUnitEvent(3111, 2, "RMQ_LeaveCombat")
RegisterUnitEvent(3111, 4, "RMQ_Dead")


--Razormane Dustrunner
function RMD_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("RMD_Heal", 15000, 1)
	pUnit:RegisterEvent("RMD_Fair", 5800, 1)
end

function RMD_Heal(pUnit, Event)
	pUnit:CastSpell(774)
end

function RMD_Fair(pUnit, Event)
	pUnit:CastSpellOnTarget(6950, 	pUnit:GetClosestPlayer())
end

function RMD_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RMD_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3113, 1, "RMD_OnCombat")
RegisterUnitEvent(3113, 2, "RMD_LeaveCombat")
RegisterUnitEvent(3113, 4, "RMD_Dead")


--RazorMane Scout
function RMS_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("RMS_Shoot", 5000, 0)
end

function RMS_Shoot(pUnit, Event)
	pUnit:CastSpellOnTarget(6660, 	pUnit:GetClosestPlayer())
end

function RMS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RMS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3112, 1, "RMS_OnCombat")
RegisterUnitEvent(3112, 2, "RMS_LeaveCombat")
RegisterUnitEvent(3112, 4, "RMS_Dead")
