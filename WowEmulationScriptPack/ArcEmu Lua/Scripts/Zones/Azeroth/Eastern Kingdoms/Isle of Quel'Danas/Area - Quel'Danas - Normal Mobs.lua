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

Area - Quel'Danas - Normal Mobs.lua by Yerney
Report Bugs at www.lasp.forumotion.com
-- ]]

--Darkspine Myrmidon
function DSM_OnCombat(pUnit, Event)
pUnit:RegisterEvent("DSM_Shout", 8000, 1)
pUnit:RegisterEvent("DSM_Sunder", 14000, 1)
end

function DSM_Shout(pUnit, Event)
pUnit:FullCastSpell(13730)
end

function DSM_Sunder(pUnit, Event)
pUnit:FullCastSpellOnTarget(11971, pUnit:GetClosestPlayer())
end

function DSM_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DSM_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25060, 1, "DSM_OnCombat")
RegisterUnitEvent(25060, 2, "DSM_LeaveCombat")
RegisterUnitEvent(25060, 4, "DSM_Dead")

--DarkSpine Siren
function DSS_OnCombat(pUnit, Event)
pUnit:CastSpell(12544)
pUnit:RegisterEvent("DSS_Scr", 12000, 1)
pUnit:RegisterEvent("DSS_FrNo", 24000, 1)
pUnit:RegisterEvent("DSS_FrB", 7000, 0)
end

function DSS_Scr(pUnit, Event)
pUnit:FullCastSpell(3589)
end

function DSS_FrNo(pUnit, Event)
pUnit:FullCastSpell(38033)
end

function DSS_FrB(pUnit, Event)
pUnit:FullCastSpellOnTarget(9672, pUnit:GetClosestPlayer())
end

function DSS_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DSS_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25073, 1, "DSS_OnCombat")
RegisterUnitEvent(25073, 2, "DSS_LeaveCombat")
RegisterUnitEvent(25073, 4, "DSS_Dead")

--DawnBlade Blood Knight
function DBBK_OnCombat(pUnit, Event)
pUnit:FullCastSpellOnTarget(45105, pUnit:GetClosestPlayer())
pUnit:RegisterEvent("DBBK_Heal", 26000, 1)
pUnit:RegisterEvent("DBBK_SoW", 8000, 4)
pUnit:RegisterEvent("DBBK_JoW", 13000, 4)
end

function DBBK_Heal(pUnit, Event)
pUnit:CastSpell(13952)
end

function DBBK_SoW(pUnit, Event)
pUnit:CastSpellOnTarget(45095, pUnit:GetClosestPlayer())
end

function DBBK_JoW(pUnit, Event)
pUnit:CastSpellOnTarget(45337, pUnit:GetClosestPlayer())
end

function DBBK_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DBBK_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(24976, 1, "DBBK_OnCombat")
RegisterUnitEvent(24976, 2, "DBBK_LeaveCombat")
RegisterUnitEvent(24976, 4, "DBBK_Dead")

--[[DawnBlade MarksMan
-- His Skills don't Got Core support so they don't Work well!
function DBM_OnCombat(pUnit, Event)
pUnit:RegisterEvent("DBM_Shoot", 4000, 0)
pUnit:RegisterEvent("DBM_Flame", 8000, 0)
pUnit:RegisterEvent("DBM_Immo", 16000, 0)
end

function DBM_Shoot(pUnit, Event)
pUnit:FullCastSpellOnTarget(6660, pUnit:GetClosestPlayer())
end

function DBM_Flame(pUnit, Event)
pUnit:CastSpellOnTarget(45101, pUnit:GetClosestPlayer())
end

function DBM_Immo(pUnit, Event)
pUnit:CastSpellOnTarget(37847, pUnit:GetClosestPlayer())
end

function DBM_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DBM_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(24979, 1, "DBM_OnCombat")
RegisterUnitEvent(24979, 2, "DBM_LeaveCombat")
RegisterUnitEvent(24979, 4, "DBM_Dead")
--]]


--DawnBlade Reservist
-- Only Raptor Strike for now!
function DBR_OnCombat(pUnit, Event)
pUnit:RegisterEvent("DBR_Strike", 9000, 0)
end

function DBR_Strike(pUnit, Event)
pUnit:CastSpellOnTarget(32915, pUnit:GetClosestPlayer())
end

function DBR_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DBR_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25087, 1, "DBR_OnCombat")
RegisterUnitEvent(25087, 2, "DBR_LeaveCombat")
RegisterUnitEvent(25087, 4, "DBR_Dead")

--DawnBlade Summoner
--Summoning is coming later
function DBS_OnCombat(pUnit, Event)
pUnit:CastSpell(44977)
pUnit:RegisterEvent("DBS_Flame",18000, 0)
pUnit:RegisterEvent("DBS_Immo", 16000, 0)
end

function DBS_Flame(pUnit, Event)
pUnit:FullCastSpellOnTarget(32707, pUnit:GetClosestPlayer())
end

function DBS_Immo(pUnit, Event)
pUnit:FullCastSpellOnTarget(11962, pUnit:GetClosestPlayer())
end

function DBS_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DBS_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(24978, 1, "DBS_OnCombat")
RegisterUnitEvent(24978, 2, "DBS_LeaveCombat")
RegisterUnitEvent(24978, 4, "DBS_Dead")


--Emissary of Hate
--A pretty Simple one :P
function EoH_OnCombat(pUnit, Event)
pUnit:RegisterEvent("EoH_Rend", 12000, 0)
end

function EoH_Rend(pUnit, Event)
pUnit:FullCastSpellOnTarget(12054, pUnit:GetClosestPlayer())
end

function EoH_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function EoH_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25003, 1, "EoH_OnCombat")
RegisterUnitEvent(25003, 2, "EoH_LeaveCombat")
RegisterUnitEvent(25003, 4, "EoH_Dead")


--unleashed Hellion
--One Skill atm, Rain of Fire doesn't Work
function UH_OnCombat(pUnit, Event)
pUnit:RegisterEvent("UH_Strike", 12000, 0)
end

function UH_Strike(pUnit, Event)
pUnit:CastSpell(11876)
end

function UH_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function UH_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(25002, 1, "UH_OnCombat")
RegisterUnitEvent(25002, 2, "UH_LeaveCombat")
RegisterUnitEvent(25002, 4, "UH_Dead")

--Wretched Devourer
--Another Simple one!
function WD_OnCombat(pUnit, Event)
pUnit:RegisterEvent("WD_Nether", 12000, 0)
end

function WD_Nether(pUnit, Event)
pUnit:FullCastSpellOnTarget(35334, pUnit:GetClosestPlayer())
end

function WD_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function WD_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(24960, 1, "WD_OnCombat")
RegisterUnitEvent(24960, 2, "WD_LeaveCombat")
RegisterUnitEvent(24960, 4, "WD_Dead")

--Wretched Fiend
--Also one skill, lazy Blizzard...
function WF_OnCombat(pUnit, Event)
pUnit:RegisterEvent("WF_Sunder", 14000, 1)
end

function WF_Sunder(pUnit, Event)
pUnit:FullCastSpellOnTarget(11971, pUnit:GetClosestPlayer())
end

function WF_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function WF_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(24966, 1, "WF_OnCombat")
RegisterUnitEvent(24966, 2, "WF_LeaveCombat")
RegisterUnitEvent(24966, 4, "WF_Dead")

--Erractic Sentry
function SelfRepair(pUnit, Event)
      pUnit:CastSpell(44994)
end

function SetHP(pUnit, Event)
      pUnit:SetHealthPct(80)
	  pUnit:RegisterEvent("RepairEffect", 1200, 1)
end

function RepairEffect(pUnit, Event)
      pUnit:CastSpell(45000)
	  if pUnit:GetHealthPct() < 100 then
	     pUnit:RegisterEvent("SelfRepair", 1200, 1)
	  end
end

function ErraticSentryCapacitorOverload(pUnit, Event)
	pUnit:RegisterEvent("SetHP", math.random(16000,36000), 0)
end

function ErraticSentryCapacitorOverload_OnEnterCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function ErraticSentryCapacitorOverload_OnLeaveCombat(pUnit, Event)
	pUnit:RegisterEvent("SetHP", math.random(16000,36000), 0)	
end

RegisterUnitEvent(24972, 6, "ErraticSentryCapacitorOverload")
RegisterUnitEvent(24972, 1, "ErraticSentryCapacitorOverload_OnEnterCombat")
RegisterUnitEvent(24972, 2, "ErraticSentryCapacitorOverload_OnLeaveCombat")


