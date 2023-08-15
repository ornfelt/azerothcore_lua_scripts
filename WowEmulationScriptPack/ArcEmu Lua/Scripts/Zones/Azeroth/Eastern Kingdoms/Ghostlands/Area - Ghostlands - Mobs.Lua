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
-- ]]
--Ghostlands Lua script written by Ramor

--Nerubis Guard
function NGuard_OnCombat(Unit, Event)
	Unit:RegisterEvent("NGuard_Poison", 3000, 1)
end

function NGuard_Poison(pUnit, Event)
target = pUnit:GetMainTank()
pUnit:FullCastSpellOnTarget(744, target)
pUnit:RegisterEvent("NGuard_Strike", 5000, 2)
end

function NGuard_Strike(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(13584, target)
 pUnit:RegisterEvent("NGuard_Wither", 5000, 3)
end

function NGuard_Wither(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(28887, target)
end

function NGuard_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function NGuard_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function NGuard_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16313, 1, "NGuard_OnCombat")
RegisterUnitEvent(16313, 2, "NGuard_OnLeaveCombat")
RegisterUnitEvent(16313, 3, "NGuard_OnKilledTarget")
RegisterUnitEvent(16313, 4, "NGuard_OnDied")

--Anok'suten
function Anok_OnCombat(Unit, Event)
	Unit:RegisterEvent("NGuard_Poison", 3000, 1)
end

function Anok_Poison(pUnit, Event)
target = pUnit:GetMainTank()
pUnit:FullCastSpellOnTarget(744, target)
pUnit:RegisterEvent("NGuard_Strike", 5000, 2)
end

function Anok_Strike(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(13584, target)
 pUnit:RegisterEvent("NGuard_Wither", 5000, 3)
end

function Anok_Wither(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(28887, target)
end

function Anok_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Anok_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Anok_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16357, 1, "Anok_OnCombat")
RegisterUnitEvent(16357, 2, "Anok_OnLeaveCombat")
RegisterUnitEvent(16357, 3, "Anok_OnKilledTarget")
RegisterUnitEvent(16357, 4, "Anok_OnDied")


--Shadowpine Ripper
function Ripper_OnCombat(Unit, Event)
	Unit:RegisterEvent("Ripper_Pummel", 6000, 2)
end

function Ripper_Pummel(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(12555, target)
end

function Ripper_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Ripper_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Ripper_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16340, 1, "Ripper_OnCombat")
RegisterUnitEvent(16340, 2, "Ripper_OnLeaveCombat")
RegisterUnitEvent(16340, 3, "Ripper_OnKilledTarget")
RegisterUnitEvent(16340, 4, "Ripper_OnDied")

--Shadowpine Witch
function Witch_OnCombat(Unit, Event)
	Unit:RegisterEvent("Witch_LShield", 0001, 1)
end

function Witch_LShield(Unit, Event)
	Unit:CastSpell(12550)
end

function Witch_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Witch_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Witch_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16341, 1, "Witch_OnCombat")
RegisterUnitEvent(16341, 2, "Witch_OnLeaveCombat")
RegisterUnitEvent(16341, 3, "Witch_OnKilledTarget")
RegisterUnitEvent(16341, 4, "Witch_OnDied")

--Arcane Reaver
function Reaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("Reaver_Knockdown", 5000, 1)
end

function Reaver_Knockdown(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(31390, target)
end

function Reaver_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Reaver_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Reaver_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16339, 1, "Reaver_OnCombat")
RegisterUnitEvent(16339, 2, "Reaver_OnLeaveCombat")
RegisterUnitEvent(16339, 3, "Reaver_OnKilledTarget")
RegisterUnitEvent(16339, 4, "Reaver_OnDied")

--Shadowpine Shadowcaster
function ShadowCaster_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadowCaster_Mark", 1500, 1)
end

function ShadowCaster_Mark(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(31394, target)
 pUnit:RegisterEvent("ShadowCaster_Flay", 500, 3)
end

function ShadowCaster_Mark(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(16568, target)
end

function ShadowCaster_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function ShadowCaster_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function ShadowCaster_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16469, 1, "ShadowCaster_OnCombat")
RegisterUnitEvent(16469, 2, "ShadowCaster_OnLeaveCombat")
RegisterUnitEvent(16469, 3, "ShadowCaster_OnKilledTarget")
RegisterUnitEvent(16469, 4, "ShadowCaster_OnDied")

--Shadowpine Headhunter
function HHunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("HHunter_Throw", 1, 1)
end

function HHunter_Throw(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(10277, target)
end

function HHunter_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function HHunter_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function HHunter_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16344, 1, "HHunter_OnCombat")
RegisterUnitEvent(16344, 2, "HHunter_OnLeaveCombat")
RegisterUnitEvent(16344, 3, "HHunter_OnKilledTarget")
RegisterUnitEvent(16344, 4, "HHunter_OnDied")

--Shadowpine Catlord
function Catlord_OnCombat(Unit, Event)
	Unit:RegisterEvent("Catlord_BL", 10000, 2)
end

function Catlord_BL(Unit, Event)
	Unit:CastSpell(289020)
	Unit:RegisterEvent("Catlord_Summon", 10000, 1)
end

function Catlord_Summon(Unit, Event)
	Unit:CastSpell(28904)
end

function Catlord_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Catlord_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Catlord_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16345, 1, "Catlord_OnCombat")
RegisterUnitEvent(16345, 2, "Catlord_OnLeaveCombat")
RegisterUnitEvent(16345, 3, "Catlord_OnKilledTarget")
RegisterUnitEvent(16345, 4, "Catlord_OnDied")

--Shadowpine Hexxer
function Hexxer_OnCombat(Unit, Event)
	Unit:RegisterEvent("Hexxer_Dispel", 4000, 0)
end

function Hexxer_Dispel(Unit, Event)
	Unit:CastSpell(17201)
	Unit:RegisterEvent("Hexxer_Hex", 10000, 2)
end

function Hexxer_Hex(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(29044)
end

function Hexxer_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Hexxer_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Hexxer_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16346, 1, "Hexxer_OnCombat")
RegisterUnitEvent(16346, 2, "Hexxer_OnLeaveCombat")
RegisterUnitEvent(16346, 3, "Hexxer_OnKilledTarget")
RegisterUnitEvent(16346, 4, "Hexxer_OnDied")

--Quel'Dorei Ghost
function QDGhost_OnCombat(Unit, Event)
	Unit:RegisterEvent("QDGhost_Evasion", 10000, 1)
end

function QDGhost_Evasion(Unit, Event)
	Unit:CastSpell(31379)
end

function QDGhost_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function QDGhost_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function QDGhost_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16325, 1, "QDGhost_OnCombat")
RegisterUnitEvent(16325, 2, "QDGhost_OnLeaveCombat")
RegisterUnitEvent(16325, 3, "QDGhost_OnKilledTarget")
RegisterUnitEvent(16325, 4, "QDGhost_OnDied")

--Quel'Dorei Wraith
function QDWraith_OnCombat(Unit, Event)
	Unit:RegisterEvent("QDGhost_Evasion", 1000, 1)
end

function QDWraith_Evasion(Unit, Event)
 	Unit:CastSpell(31379)
end

function QDWraith_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function QDWraith_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function QDWraith_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16326, 1, "QDWraith_OnCombat")
RegisterUnitEvent(16326, 2, "QDWraith_OnLeaveCombat")
RegisterUnitEvent(16326, 3, "QDWraith_OnKilledTarget")
RegisterUnitEvent(16326, 4, "QDWraith_OnDied")

--Spindleweb Spider
function SWSpider_OnCombat(Unit, Event)
	Unit:RegisterEvent("SWSpider_Poison", 3000, 1)
end

function SWSpider_Poison(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11918, target)
end

function SWSpider_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SWSpider_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SWSpider_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16350, 1, "SWSpider_OnCombat")
RegisterUnitEvent(16350, 2, "SWSpider_OnLeaveCombat")
RegisterUnitEvent(16350, 3, "SWSpider_OnKilledTarget")
RegisterUnitEvent(16350, 4, "SWSpider_OnDied")

--Spindleweb Lurker
function SWLurker_OnCombat(Unit, Event)
	Unit:RegisterEvent("SWLurker_Poison", 3000, 1)
end

function SWLurker_Poison(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11918, target)
end

function SWLurker_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SWLurker_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SWLurker_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16351, 1, "SWLurker_OnCombat")
RegisterUnitEvent(16351, 2, "SWLurker_OnLeaveCombat")
RegisterUnitEvent(16351, 3, "SWLurker_OnKilledTarget")
RegisterUnitEvent(16351, 4, "SWLurker_OnDied")

--Arcane Devourer
function AD_OnCombat(Unit, Event)
	Unit:RegisterEvent("AD_Devour", 5000, 3)
end

function AD_Devour(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(29054, target)
end

function AD_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function AD_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function AD_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16304, 1, "AD_OnCombat")
RegisterUnitEvent(16304, 2, "AD_OnLeaveCombat")
RegisterUnitEvent(16304, 3, "AD_OnKilledTarget")
RegisterUnitEvent(16304, 4, "AD_OnDied")

--Mana Shifter
function MS_OnCombat(Unit, Event)
	Unit:RegisterEvent("MS_Drain", 5000, 3)
end

function MS_Drain(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(29058, target)
end

function MS_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function MS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function MS_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16310, 1, "MS_OnCombat")
RegisterUnitEvent(16310, 2, "MS_OnLeaveCombat")
RegisterUnitEvent(16310, 3, "MS_OnKilledTarget")
RegisterUnitEvent(16310, 4, "MS_OnDied")

--Deatholme Darkmage
function DDark_OnCombat(Unit, Event)
	Unit:RegisterEvent("DDark_Curse", 3000, 1)
end

function DDark_Curse(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(18267, target)
 pUnit:RegisterEvent("DDark_SBolt", 6000, 3)
end

function DDark_SBolt(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(9613, target)
end

function DDark_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function DDark_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function DDark_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16318, 1, "DDark_OnCombat")
RegisterUnitEvent(16318, 2, "DDark_OnLeaveCombat")
RegisterUnitEvent(16318, 3, "DDark_OnKilledTarget")
RegisterUnitEvent(16318, 4, "DDark_OnDied")

--Stonewing Tracker
function STracker_OnCombat(Unit, Event)
	Unit:RegisterEvent("STracker_Stone", 5000, 1)
end

function STracker_Stone(Unit, Event)
	Unit:CastSpell(5810)
end

function STracker_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function STracker_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function STracker_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16316, 1, "STracker_OnCombat")
RegisterUnitEvent(16316, 2, "STracker_OnLeaveCombat")
RegisterUnitEvent(16316, 3, "STracker_OnKilledTarget")
RegisterUnitEvent(16316, 4, "STracker_OnDied")

--Stonewing Slayer
function SSlayer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SSlayer_Rend", 5000, 1)
end

function SSlayer_Rend(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(3147, target)
end

function SSlayer_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SSlayer_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SSlayer_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16324, 1, "SSlayer_OnCombat")
RegisterUnitEvent(16324, 2, "SSlayer_OnLeaveCombat")
RegisterUnitEvent(16324, 3, "SSlayer_OnKilledTarget")
RegisterUnitEvent(16324, 4, "SSlayer_OnDied")

-- Luzran
function Luzran_OnCombat(Unit, Event)
	Unit:RegisterEvent("Luzran_Sunder", 5000, 5)
end

function Luzran_Sunder(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(13444, target)
 pUnit:RegisterEvent("Luzran_Cleave", 5000, 2)
end

function Luzran_Cleave(Unit, Event)
	Unit:CastSpell(40504)
end

function Luzran_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Luzran_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Luzran_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16245, 1, "Luzran_OnCombat")
RegisterUnitEvent(16245, 2, "Luzran_OnLeaveCombat")
RegisterUnitEvent(16245, 3, "Luzran_OnKilledTarget")
RegisterUnitEvent(16245, 4, "Luzran_OnDied")

--Dreadbone Sentinel
function DBSent_OnCombat(Unit, Event)
	Unit:RegisterEvent("DBSent_Sunder", 5000, 3)
end

function DBSent_Sunder(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11971, target)
 pUnit:RegisterEvent("DBSent_Bash", 5000, 2)
end

function DBSent_Bash(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11972, target)
end

function DBSent_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function DBSent_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function DBSent_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16305, 1, "DBSent_OnCombat")
RegisterUnitEvent(16305, 2, "DBSent_OnLeaveCombat")
RegisterUnitEvent(16305, 3, "DBSent_OnKilledTarget")
RegisterUnitEvent(16305, 4, "DBSent_OnDied")

--Risen Hungerer
function Hunger_OnCombat(Unit, Event)
	Unit:RegisterEvent("Hunger_Leech", 5000, 2)
end

function Hunger_Leech(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(6958, target)
end

function Hunger_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Hunger_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Hunger_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16301, 1, "Hunger_OnCombat")
RegisterUnitEvent(16301, 2, "Hunger_OnLeaveCombat")
RegisterUnitEvent(16301, 3, "Hunger_OnKilledTarget")
RegisterUnitEvent(16301, 4, "Hunger_OnDied")

--Gangled Cannibal
function GCan_OnCombat(Unit, Event)
	Unit:RegisterEvent("GCan_Enrage", 2000, 1)
end

function GCan_Enrage(Unit, Event)
	Unit:CastSpell(8599)
end

function GCan_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GCan_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GCan_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16309, 1, "GCan_OnCombat")
RegisterUnitEvent(16309, 2, "GCan_OnLeaveCombat")
RegisterUnitEvent(16309, 3, "GCan_OnKilledTarget")
RegisterUnitEvent(16309, 4, "GCan_OnDied")

--Deathcage Sorcerer
function DSor_OnCombat(Unit, Event)
	Unit:RegisterEvent("DSor_Frostbolt", 6000, 3)
end

function DSor_Frostbolt(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(20792, target)
end

function DSor_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function DSor_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function DSor_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16308, 1, "DSor_OnCombat")
RegisterUnitEvent(16308, 2, "DSor_OnLeaveCombat")
RegisterUnitEvent(16308, 3, "DSor_OnKilledTarget")
RegisterUnitEvent(16308, 4, "DSor_OnDied")

--Phantasmal Watcher
function NPCWatcher_OnCombat(Unit, Event)
	Unit:RegisterEvent("NPCWatcher_Bolt", 6000, 0)
end

function NPCWatcher_Bolt(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(9613, target)
end

function NPCWatcher_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function NPCWatcher_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function NPCWatcher_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16311, 1, "NPCWatcher_OnCombat")
RegisterUnitEvent(16311, 2, "NPCWatcher_OnLeaveCombat")
RegisterUnitEvent(16311, 3, "NPCWatcher_OnKilledTarget")
RegisterUnitEvent(16311, 4, "NPCWatcher_OnDied")

--Risen Creeper
function NPCrc_OnCombat(Unit, Event)
	Unit:RegisterEvent("NPCrc_Spell", 8500, 2)
end

function NPCrc_Spell(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(6951, target)
end

function NPCrc_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function NPCrc_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

function NPCrc_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end


RegisterUnitEvent(16300, 1, "NPCrc_OnCombat")
RegisterUnitEvent(16300, 2, "NPCrc_OnLeaveCombat")
RegisterUnitEvent(16300, 3, "NPCrc_OnKilledTarget")
RegisterUnitEvent(16300, 4, "NPCrc_OnDied")

--Deathcage Scryer
function NPCDScryer_OnCombat(Unit, Event)
	Unit:RegisterEvent("NPCDScryer_Fireball", 3500, 5)
end

function NPCDScryer_Fireball(Unit, EVent)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(20793, target)
end

function NPCDScryer_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function NPCDScryer_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function NPCDScryer_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16307, 1, "NPCDScryer_OnCombat")
RegisterUnitEvent(16307, 2, "NPCDScryer_OnLeaveCombat")
RegisterUnitEvent(16307, 3, "NPCDScryer_OnKilledTarget")
RegisterUnitEvent(16307, 4, "NPCDScryer_OnDied")


--Lesser Scourgebat
function SBat_OnCombat(Unit, Event)
	Unit:RegisterEvent("SBat_Disease", 5000, 3)
end

function SBat_Disease(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(3234, target)
end

function SBat_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SBat_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SBat_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16355, 1, "SBat_OnCombat")
RegisterUnitEvent(16355, 2, "SBat_OnLeaveCombat")
RegisterUnitEvent(16355, 3, "SBat_OnKilledTarget")
RegisterUnitEvent(16355, 4, "SBat_OnDied")

--Greater Spindleweb
function GSpindle_OnCombat(Unit, Event)
	Unit:RegisterEvent("GSpindle_Poison", 5000, 1)
end

function GSpindle_Poison(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11918, target)
end

function GSpindle_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GSpindle_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GSpindle_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16352, 1, "GSpindle_OnCombat")
RegisterUnitEvent(16352, 2, "GSpindle_OnLeaveCombat")
RegisterUnitEvent(16352, 3, "GSpindle_OnKilledTarget")
RegisterUnitEvent(16352, 4, "GSpindle_OnDied")

--Eye of Dar'Khan
function DarkhanEye_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkhanEye_Befuddle", 5000, 1)
end

function DarkhanEye_Befuddle(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(8140, target)
 pUnit:RegisterEvent("DarkhanEye_Curse", 6000, 1)
end

function DarkhanEye_Curse(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(14868, target)
end

function DarkhanEye_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function DarkhanEye_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function DarkhanEye_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16320, 1, "DarkhanEye_OnCombat")
RegisterUnitEvent(16320, 2, "DarkhanEye_OnLeaveCombat")
RegisterUnitEvent(16320, 3, "DarkhanEye_OnKilledTarget")
RegisterUnitEvent(16320, 4, "DarkhanEye_OnDied")

--Wailer
function Wailer_OnCombat(Unit, Event)
	Unit:RegisterEvent("Wailer_Wail", 5000, 1)
end

function Wailer_Wail(Unit, Event)
	Unit:CastSpell(7713)
end

function Wailer_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Wailer_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Wailer_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16321, 1, "Wailer_OnCombat")
RegisterUnitEvent(16321, 2, "Wailer_OnLeaveCombat")
RegisterUnitEvent(16321, 3, "Wailer_OnKilledTarget")
RegisterUnitEvent(16321, 4, "Wailer_OnDied")

--Mirdoran the Fallen
function Mirdoran_OnCombat(Unit, Event)
	Unit:RegisterEvent("Mirdoran_Sunder", 5000, 5)
end

function Mirdoran_Sunder(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11971, target)
 pUnit:RegisterEvent("Mirdoran_Bash", 8000, 2)
end

function Mirdoran_Bash(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11972, target)
end

function Mirdoran_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Mirdoran_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Mirdoran_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16250, 1, "Mirdoran_OnCombat")
RegisterUnitEvent(16250, 2, "Mirdoran_OnLeaveCombat")
RegisterUnitEvent(16250, 3, "Mirdoran_OnKilledTarget")
RegisterUnitEvent(16250, 4, "Mirdoran_OnDied")

--Deatholme Acolyte
function DAcolyte_OnCombat(Unit, Event)
	Unit:RegisterEvent("DAcolyte_Skin", 1, 1)
end

function DAcolyte_Skin(Unit, Event)
	Unit:CastSpell(20798)
	Unit:RegisterEvent("DAcolyte_Pain", 8000, 1)
end

function DAcolyte_Pain(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(11639, target)
end

function DAcolyte_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function DAcolyte_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function DAcolyte_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16315, 1, "DAcolyte_OnCombat")
RegisterUnitEvent(16315, 2, "DAcolyte_OnLeaveCombat")
RegisterUnitEvent(16315, 3, "DAcolyte_OnKilledTarget")
RegisterUnitEvent(16315, 4, "DAcolyte_OnDied")

--Deatholme Necromancer
function DNecro_OnCombat(Unit, Event)
	Unit:RegisterEvent("DNecro_Bolt", 8000, 0)
end

function DNecro_Bolt(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(9613, target)
 pUnit:RegisterEvent("DNecro_Summon", 3000, 1)
end

function DNecro_Summon(Unit, Event)
	Unit:CastSpell(29066)
end

function DNecro_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function DNecro_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function DNecro_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16317, 1, "DNecro_OnCombat")
RegisterUnitEvent(16317, 2, "DNecro_OnLeaveCombat")
RegisterUnitEvent(16317, 3, "DNecro_OnKilledTarget")
RegisterUnitEvent(16317, 4, "DNecro_OnDied")

--Dar'Khan Drathir
function Drathir_OnCombat(Unit, Event)
	Unit:RegisterEvent("Drathir_Corruption", 5000, 1)
end

function Drathir_Corruption(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(21068, target)
 pUnit:RegisterEvent("Drathir_Bolt", 8000, 1)
end

function Drathir_Bolt(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(20791, target)
 pUnit:RegisterEvent("Drathir_Fear", 10000, 1)
end

function Drathir_Fear(pUnit, Event)
target = pUnit:GetMainTank()
 pUnit:FullCastSpellOnTarget(38660, target)
end

function Drathir_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Drathir_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Drathir_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(16329, 1, "Drathir_OnCombat")
RegisterUnitEvent(16329, 2, "Drathir_OnLeaveCombat")
RegisterUnitEvent(16329, 3, "Drathir_OnKilledTarget")
RegisterUnitEvent(16329, 4, "Drathir_OnDied")