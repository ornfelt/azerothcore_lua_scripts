--[[ Blade Edge -- BloodMaulPart1.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, August, 31th, 2008. ]]

-- Bloodmaul Warlock http://www.wowhead.com/?npc=19994

function BMWarlock_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("BMWarlock_DeamonArmor", 1, 1)
	pUnit:RegisterEvent("BMWarlock_ShadowB", 3100, 0)
	pUnit:RegisterEvent("BMWarlock_Enrage", 18000, 0)
end

function BMWarlock_DeamonArmor(pUnit,Event)
	pUnit:FullCastSpell(13787)
end

function BMWarlock_ShadowB(pUnit,Event)
	pUnit:FullCastSpellOnTarget(20825,pUnit:GetMainTank())
end

function BMWarlock_Enrage(pUnit,Event)
	pUnit:FullCastSpell(13787)
end

function BMWarlock_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMWarlock_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19994, 1, "BMWarlock_OnEnterCombat")
RegisterUnitEvent (19994, 2, "BMWarlock_OnLeaveCombat")
RegisterUnitEvent (19994, 4, "BMWarlock_OnDied")

--Bloodmaul Taskmaster http://www.wowhead.com/?npc=22160

function BMTask_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("BMTask_KnockDown", 8000, 0)
	pUnit:RegisterEvent("BMTask_Enrage", 18000, 1)
end

function BMTask_KnockDown(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37592,pUnit:GetMainTank())
end

function BMTask_Enrage(pUnit,Event)
	pUnit:FullCastSpell(37786)
end

function BMTask_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMTask_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22160, 1, "BMTask_OnEnterCombat")
RegisterUnitEvent (22160, 2, "BMTask_OnLeaveCombat")
RegisterUnitEvent (22160, 4, "BMTask_OnDied")

-- Bloodmaul Soothsayer http://www.wowhead.com/?npc=22384

function BMSoot_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("BMSoot_Bolt", 3100, 0)
end

function BMSoot_Bolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(20825,pUnit:GetMainTank()) -- Lol,WTF is with Damage :) does Only 100 lol and its only spell of his!
end

function BMSoot_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMSoot_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22384, 1, "BMSoot_OnEnterCombat")
RegisterUnitEvent (22384, 2, "BMSoot_OnLeaveCombat")
RegisterUnitEvent (22384, 4, "BMSoot_OnDied")

-- Bloodmaul Skirmisher http://www.wowhead.com/?npc=19948

function BMSkir_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("BMSkir_Bersek", 1000, 1)
	pUnit:RegisterEvent("BMSkir_Kick", 6000, 1)
	pUnit:RegisterEvent("BMSkir_Enrage", 1000, 1)
end

function BMSkir_Bersek(pUnit,Event)
     if pUnit:GetHealthPct() > 85 then
	pUnit:FullCastSpell(34932)
end
end

function BMSkir_Kick(pUnit,Event)
	pUnit:FullCastSpellOnTarget(20825,pUnit:GetMainTank())
end

function BMSkir_Enrage(pUnit,Event)
     if pUnit:GetHealthPct() > 25 then
	pUnit:FullCastSpell(37786)
end
end

function BMSkir_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMSkir_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19948, 1, "BMSkir_OnEnterCombat")
RegisterUnitEvent (19948, 2, "BMSkir_OnLeaveCombat")
RegisterUnitEvent (19948, 4, "BMSkir_OnDied")
