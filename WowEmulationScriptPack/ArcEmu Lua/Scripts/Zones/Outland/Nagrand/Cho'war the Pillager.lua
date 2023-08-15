--[[ Nagrand - Cho'war the Pillager.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

Written for V.C.N By Performer/Tankgized

~~End of License Agreement
-- Performer, September 16th, 2008. ]]

function ChoWar_OnEnterCombat(Unit, event)
    Unit:RegisterUnitEvent("ChoWar_BattleShout", 200000, 0)
	Unit:RegisterUnitEvent("ChoWar_Charge", 40000, 0)
	Unit:RegisterUnitEvent("ChoWar_MortalStrike", 7000, 0)
	Unit:RegisterUnitEvent("ChoWar_SunderingCleave", 4000, 0)
end

function ChoWar_BattleShout(Unit, event)
    Unit:FullCastSpell(31403)
end

function ChoWar_Charge(Unit, event)
    Unit:FullCastSpellOnTarget(32323, Unit:GetClosestPlayer())
end

function ChoWar_MortalStrike(Unit, event)
    Unit:FullCastSpell(15708)
end

function ChoWar_SunderingCleave(Unit, event)
    Unit:FullCastSpell(17963)
end

function ChoWar_OnLeaveCombat(Unit, event)
    Unit:RemoveEvents()
end

function ChoWar_OnDied(Unit, event)
    Unit:RemoveEvents()
end

RegisterUnitEvent(18423, 1, "ChoWar_OnEnterCombat")
RegisterUnitEvent(18423, 2, "ChoWar_OnLeaveCombat")
RegisterUnitEvent(18423, 3, "ChoWar_OnDied")