--[[ Blade Edge -- BloodMaulPart1.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, August, 31th, 2008. ]]

-- Bloodmaul Shaman http://www.wowhead.com/?npc=19992

function BMShaman_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpell(12550)
	pUnit:RegisterEvent("BMWarlock_LShield", 15000, 1)
end

function BMShaman_LShield(pUnit,Event)
	pUnit:FullCastSpell(12550)
end

function BMShaman_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMShaman_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19992, 1, "BMShaman_OnEnterCombat")
RegisterUnitEvent (19992, 2, "BMShaman_OnLeaveCombat")
RegisterUnitEvent (19992, 4, "BMShaman_OnDied")

--Bloodmaul Geomancer http://www.wowhead.com/?npc=19952

function BMGeomancer_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpell(12544) --Frost armor :)
	pUnit:RegisterEvent("BMGeomancer_FireBolt", 9000, 2)
end

function BMGeomancer_KnockDown(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9053,pUnit:GetMainTank()) -- lol i dont understand Blizzard?
end

function BMGeomancer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMGeomancer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19952, 1, "BMGeomancer_OnEnterCombat")
RegisterUnitEvent (19952, 2, "BMGeomancer_OnLeaveCombat")
RegisterUnitEvent (19952, 4, "BMGeomancer_OnDied")

-- Bloodmaul Goon http://www.wowhead.com/?npc=21294

function BMGoon_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("BMGoon_KickFirst", 1000, 1)
	pUnit:RegisterEvent("BMGoon_KickSecond", 1000, 1)
end

function BMGoon_KickFirst(pUnit,Event)
     if pUnit:GetHealthPct() > 85 then
	pUnit:FullCastSpellOnTarget(10966,pUnit:GetMainTank())
end
end

function BMGoon_KickSecond(pUnit,Event)
     if pUnit:GetHealthPct() > 25 then
	pUnit:FullCastSpellOnTarget(10966,pUnit:GetMainTank())
end
end

function BMGoon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMGoon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21294, 1, "BMGoon_OnEnterCombat")
RegisterUnitEvent (21294, 2, "BMGoon_OnLeaveCombat")
RegisterUnitEvent (21294, 4, "BMGoon_OnDied")

-- Bloodmaul Mauler http://www.wowhead.com/?npc=19993

function BMMauler_OnEnterCombat(pUnit,Event)
    pUnit:FullCastSpell(34932)
	pUnit:RegisterEvent("BMMauler_Kick", 9000, 2)
	pUnit:RegisterEvent("BMMauler_Enrage", 1000, 1)
end

function BMMauler_Kick(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37592,pUnit:GetMainTank())
end

function BMMauler_Enrage(pUnit,Event)
     if pUnit:GetHealthPct() > 20 then
    pUnit:FullCastSpell(37786)
end
end

function BMMauler_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BMMauler_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19993, 1, "BMMauler_OnEnterCombat")
RegisterUnitEvent (19993, 2, "BMMauler_OnLeaveCombat")
RegisterUnitEvent (19993, 4, "BMMauler_OnDied")
