--[[ Boss - Priestess Delrissa Adds AI.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, August 29, 2008. ]]

--Fizzle-Warlocks Pet-Imp
function Fizzle_OnCombat(Unit, Event)
   Unit:RegisterEvent("Fizzle_Fireball", 5000, 0)
end

function Fizzle_Fireball(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44164, pUnit:GetRandomPlayer(0))
end

function Fizzle_LeaveCombat(Unit, Event)
   Unit:RemoveEvents()
end

function Fizzle_Died(Unit, Event)
   Unit:RemoveEvents()
end

RegisterUnitEvent(24656, 1, "Fizzle_OnCombat")
RegisterUnitEvent(24656, 2, "Fizzle_LeaveCombat")
RegisterUnitEvent(24656, 4, "Fizzle_Died")

--Ellrys Duskhallow-warlock
function warlockadd_OnCombat(Unit, Event)
   Unit:RegisterEvent("warlockadd_Fear", 7500, 0)
   Unit:RegisterEvent("warlockadd_ShadowBolt", 4500, 0)
   Unit:RegisterEvent("warlockadd_Curse", 10000, 0)
end

function warlockadd_Fear(pUnit, Event)
   pUnit:FullCastSpellOnTarget(38595, pUnit:GetRandomPlayer(0))
end

function warlockadd_ShadowBolt(pUnit, Event)
   pUnit:FullCastSpellOnTarget(15232, pUnit:GetRandomPlayer(0))
end

function warlockadd_Curse(pUnit, Event)
   pUnit:FullCastSpellOnTarget(46190, pUnit:GetRandomPlayer(0))
end

function warlockadd_LeaveCombat(Unit, Event)
   Unit:RemoveEvents()
end

function warlockadd_Died(Unit, Event)
   Unit:RemoveEvents()
end

RegisterUnitEvent(24558, 1, "warlockadd_OnCombat")
RegisterUnitEvent(24558, 2, "warlockadd_LeaveCombat")
RegisterUnitEvent(24558, 4, "warlockadd_Died")

--Yazzai-Mage
function MageAdd_OnCombat(Unit, Event)
   Unit:RegisterEvent("MageAdd_Polymorph", 10000, 0)
   Unit:RegisterEvent("MageAdd_FrostBolt", 4500, 0)
   Unit:RegisterEvent("MageAdd_ConeOfCold", 10000, 0)
end

function MageAdd_Polymorph(pUnit, Event)
   pUnit:FullCastSpellOnTarget(13323, pUnit:GetRandomPlayer(0))
end

function MageAdd_FrostBolt(pUnit, Event)
   pUnit:FullCastSpellOnTarget(15043, pUnit:GetRandomPlayer(0))
end

function MageAdd_ConeOfCold(pUnit, Event)
   pUnit:FullCastSpell(38384)
end

function MageAdd_LeaveCombat(Unit, Event)
   Unit:RemoveEvents()
end

function MageAdd_Died(Unit, Event)
   Unit:RemoveEvents()
end

RegisterUnitEvent(24561, 1, "MageAdd_OnCombat")
RegisterUnitEvent(24561, 2, "MageAdd_LeaveCombat")
RegisterUnitEvent(24561, 4, "MageAdd_Died")

--Warlord Salaris-Warrior
function WarriorAdd_OnCombat(Unit, Event)
   Unit:RegisterEvent("WarriorAdd_MortalStrike", 10000, 0)
   Unit:RegisterEvent("WarriorAdd_Hamstring", 5000, 0)
   Unit:RegisterEvent("WarriorAdd_Daze", 21000, 0)
   Unit:RegisterEvent("WarriorAdd_FrighteningShout", 1, 0)
end

function WarriorAdd_MortalStrike(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44268, pUnit:GetMainTank())
end

function WarriorAdd_Hamstring(pUnit, Event)
   pUnit:FullCastSpellOnTarget(27584, pUnit:GetRandomPlayer(0))
end

function WarriorAdd_Daze(pUnit, Event)
   pUnit:FullCastSpell(23600)
end

function WarriorAdd_FrighteningShout(pUnit, Event)
   if pUnit:GetHealthPct() == 20 then
   pUnit:FullCastSpell(19134)
end
end

function WarriorAdd_LeaveCombat(Unit, Event)
   Unit:RemoveEvents()
end

function WarriorAdd_Died(Unit, Event)
   Unit:RemoveEvents()
end

RegisterUnitEvent(24559, 1, "WarriorAdd_OnCombat")
RegisterUnitEvent(24559, 2, "WarriorAdd_LeaveCombat")
RegisterUnitEvent(24559, 4, "WarriorAdd_Died")

--Garaxxas-Hunter
function HunterAdd_OnCombat(Unit, Event)
   Unit:RegisterEvent("HunterAdd_AutoShoot", 2200, 0)
   Unit:RegisterEvent("HunterAdd_MultiShoot", 8000, 0)
   Unit:RegisterEvent("HunterAdd_Trap", 18000, 0)
   Unit:RegisterEvent("HunterAdd_AimedShoot", 1, 0)
   Unit:RegisterEvent("HunterAdd_Clip", 14000, 0)
end

function HunterAdd_AutoShoot(pUnit, Event)
   pUnit:FullCastSpellOnTarget(15620, pUnit:GetRandomPlayer(0))
end

function HunterAdd_MultiShoot(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44285, pUnit:GetRandomPlayer(0))
end

function HunterAdd_Trap(pUnit, Event)
   pUnit:FullCastSpell(44136)
end

function HunterAdd_AimedShoot(pUnit, Event)
   if pUnit:GetHealthPct() == 32 then
   pUnit:FullCastSpellOnTarget(44271, pUnit:GetRandomPlayer(0))
end
end

function WarriorAdd_Clip(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44286, pUnit:GetMainTank())
end

function HunterAdd_LeaveCombat(Unit, Event)
   Unit:RemoveEvents()
end

function HunterAdd_Died(Unit, Event)
   Unit:RemoveEvents()
end

RegisterUnitEvent(24555, 1, "HunterAdd_OnCombat")
RegisterUnitEvent(24555, 2, "HunterAdd_LeaveCombat")
RegisterUnitEvent(24555, 4, "HunterAdd_Died")

--Eramas Brightblaze-Monk
function Monkadd_OnCombat(Unit, Event)
   Unit:RegisterEvent("Monkadd_Stun", 9500, 0)
   Unit:RegisterEvent("Monkadd_Kick", 7200, 0)
end

function Monkadd_Stun(pUnit, Event)
   pUnit:FullCastSpellOnTarget(46183, pUnit:GetRandomPlayer(1))
end

function Monkadd_Kick(pUnit, Event)
   pUnit:FullCastSpellOnTarget(46182, pUnit:GetRandomPlayer(1))
end

function Monkadd_LeaveCombat(Unit, Event)
   Unit:RemoveEvents()
end

function Monkadd_Died(Unit, Event)
   Unit:RemoveEvents()
end

RegisterUnitEvent(24554, 1, "Monkadd_OnCombat")
RegisterUnitEvent(24554, 2, "Monkadd_LeaveCombat")
RegisterUnitEvent(24554, 4, "Monkadd_Died")