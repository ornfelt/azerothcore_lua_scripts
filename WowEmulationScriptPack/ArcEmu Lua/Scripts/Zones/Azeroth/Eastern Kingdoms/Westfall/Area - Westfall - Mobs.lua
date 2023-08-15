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

Area - Westfall - Mobs.lua by Wartick
Report Bugs at www.lasp.forumotion.com
-- ]]

-- Brack
function Brack_OnCombat(Unit, Event)
Unit:RegisterEvent("Brack_PA", 12000, 1)
end

function Brack_PA(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(6016, plr)
end
end

function Brack_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function Brack_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(520, 1, "Brack_OnCombat")
RegisterUnitEvent(520, 2, "Brack_OnLeaveCombat")
RegisterUnitEvent(520, 4, "Brack_OnDied")


-- Coyote Packleader
function CP_OnCombat(Unit, Event)
Unit:RegisterEvent("CP_FH", 20000, 5)
end

function CP_FH(Unit, Event)
Unit:CastSpell(3149)
end

function CP_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function CP_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(833, 1, "CP_OnCombat")
RegisterUnitEvent(833, 2, "CP_OnLeaveCombat")
RegisterUnitEvent(833, 4, "CP_OnDied")


-- Defias Conjurer
function DC_OnCombat(Unit, Event)
Unit:RegisterEvent("DC_FB", 3000, 0)
end

function DC_FB(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(9053, plr)
end
end

function DC_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DC_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(619, 1, "DC_OnCombat")
RegisterUnitEvent(619, 2, "DC_OnLeaveCombat")
RegisterUnitEvent(619, 4, "DC_OnDied")


-- Defias Footpad
function DF_OnCombat(Unit, Event)
Unit:RegisterEvent("DF_BS", 6000, 0)
end

function DF_BS(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(7159, plr)
end
end

function DF_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DF_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(481, 1, "DF_OnCombat")
RegisterUnitEvent(481, 2, "DF_OnLeaveCombat")
RegisterUnitEvent(481, 4, "DF_OnDied")


-- Defias Henchman
function DH_OnCombat(Unit, Event)
Unit:RegisterEvent("DH_SS", 9000, 0)
end

function DH_SS(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(8242, plr)
end
end

function DH_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DH_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(594, 1, "DH_OnCombat")
RegisterUnitEvent(594, 2, "DH_OnLeaveCombat")
RegisterUnitEvent(594, 4, "DH_OnDied")


-- Defias Highwayman
function DHW_OnCombat(Unit, Event)
Unit:RegisterEvent("DHW_Backstab", 6000, 0)
end

function DHW_Backstab(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(53, plr)
end
end

function DHW_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DHW_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(594, 1, "DHW_OnCombat")
RegisterUnitEvent(594, 2, "DHW_OnLeaveCombat")
RegisterUnitEvent(594, 4, "DHW_OnDied")


-- Defias Knuckleduster
function DK_OnCombat(Unit, Event)
Unit:RegisterEvent("DK_Pummel", 6000, 0)
end

function DK_Pummel(Unit, Event)
local plr =	Unit:GetClosestPlayer()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(12555, plr)
end
end

function DK_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DK_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(449, 1, "DK_OnCombat")
RegisterUnitEvent(449, 2, "DK_OnLeaveCombat")
RegisterUnitEvent(449, 4, "DK_OnDied")


-- Defias Looter
function DLO_OnCombat(Unit, Event)
Unit:RegisterEvent("DLO_Backstabtwo", 6000, 0)
Unit:RegisterEvent("DLO_Disarm", 12500, 1)
end

function DLO_Backstabtwo(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(7159, plr)
end
end

function DLO_Disarm(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(6713, plr)
end
end

function DLO_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DLO_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(590, 1, "DLO_OnCombat")
RegisterUnitEvent(590, 2, "DLO_OnLeaveCombat")
RegisterUnitEvent(590, 4, "DLO_OnDied")


-- Defias Pathstalker
function DPS_OnCombat(Unit, Event)
Unit:RegisterEvent("DPS_SBash", 12000, 0)
end

function DPS_SBash(Unit, Event)
local plr =	Unit:GetRandomPlayer(4)
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(11972, plr)
end
end

function DPS_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DPS_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(121, 1, "DPS_OnCombat")
RegisterUnitEvent(121, 2, "DPS_OnLeaveCombat")
RegisterUnitEvent(121, 4, "DPS_OnDied")


-- Defias Pillager
function DPP_OnCombat(Unit, Event)
Unit:RegisterEvent("DPP_Fireballone", 3000, 0)
Unit:RegisterEvent("DPP_FrostA", 1000, 1)
end

function DPP_Fireballone(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(20793, plr)
end
end

function DPP_FrostA(Unit, Event)
Unit:CastSpell(12544)
end

function DPP_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DPP_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(589, 1, "DPP_OnCombat")
RegisterUnitEvent(589, 2, "DPP_OnLeaveCombat")
RegisterUnitEvent(589, 4, "DPP_OnDied")


-- Defias Renegade Mage
function DRM_OnCombat(Unit, Event)
Unit:RegisterEvent("DRM_FireballTwo", 3000, 0)
end

function DRM_FireballTwo(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(20793, plr)
end
end

function DRM_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DRM_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(450, 1, "DRM_OnCombat")
RegisterUnitEvent(450, 2, "DRM_OnLeaveCombat")
RegisterUnitEvent(450, 4, "DRM_OnDied")


-- Defias Smuggler
function DSG_OnCombat(Unit, Event)
Unit:SendChatMessage(11, 0, "Brotherhood will not tolerate your actions")
Unit:RegisterEvent("DSG_Throw", 3000, 0)
end

function DSG_Throw(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(10277, plr)
end
end

function DSG_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DSG_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(95, 1, "DSG_OnCombat")
RegisterUnitEvent(95, 2, "DSG_OnLeaveCombat")
RegisterUnitEvent(95, 4, "DSG_OnDied")


-- Defias Trapper
function DTR_OnCombat(Unit, Event)
Unit:SendChatMessage(11, 0, "Ah , a chance to use this freshly sharpened blade")
Unit:RegisterEvent("DTR_BSone", 3000, 0)
Unit:RegisterEvent("DTR_Net", 10000, 0)
end

function DTR_BSone(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(2589, plr)
end
end

function DTR_Net(Unit, Event)
local plr =	Unit:GetClosestPlayer()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(12024, plr)
end
end

function DTR_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DTR_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(504, 1, "DTR_OnCombat")
RegisterUnitEvent(504, 2, "DTR_OnLeaveCombat")
RegisterUnitEvent(504, 4, "DTR_OnDied")


-- Dust Devil
function DDD_OnCombat(Unit, Event)
Unit:RegisterEvent("DDD_GOW", 14000, 1)
end

function DDD_GOW(Unit, Event)
Unit:CastSpell(6982)
end

function DDD_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function DDD_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(832, 1, "DDD_OnCombat")
RegisterUnitEvent(832, 2, "DDD_OnLeaveCombat")
RegisterUnitEvent(832, 4, "DDD_OnDied")


-- Fleshripper
function FHR_OnCombat(Unit, Event)
Unit:RegisterEvent("FHR_MTear", 12000, 0)
end

function FHR_MTear(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(12166, plr)
end
end

function FHR_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function FHR_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(1109, 1, "FHR_OnCombat")
RegisterUnitEvent(1109, 2, "FHR_OnLeaveCombat")
RegisterUnitEvent(1109, 4, "FHR_OnDied")


-- Forlorn Spirit
function FLS_OnCombat(Unit, Event)
Unit:RegisterEvent("FLS_COS", 13000, 1)
Unit:RegisterEvent("FLS_PolySheep", 17000, 1)
end

function FLS_COS(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(3105, plr)
end
end

function FLS_PolySheep(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(118, plr)
end
end

function FLS_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function FLS_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2044, 1, "FLS_OnCombat")
RegisterUnitEvent(2044, 2, "FLS_OnLeaveCombat")
RegisterUnitEvent(2044, 4, "FLS_OnDied")


-- Goretusk
function Gore_OnCombat(Unit, Event)
Unit:CastSpell(6268)
end

function Gore_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Gore_Dead(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(157, 1, "Gore_OnCombat")
RegisterUnitEvent(157, 2, "Gore_LeaveCombat")
RegisterUnitEvent(157, 4, "Gore_Dead")


-- Great Goretusk
function GGore_OnCombat(Unit, Event)
Unit:CastSpell(6268)
end

function GGore_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function GGore_Dead(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(547, 1, "GGore_OnCombat")
RegisterUnitEvent(547, 2, "GGore_LeaveCombat")
RegisterUnitEvent(547, 4, "GGore_Dead")


-- Greater Fleshripper
function GFHR_OnCombat(Unit, Event)
Unit:RegisterEvent("GFHR_MMTear", 11000, 1)
end

function GFHR_MMTear(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(12166, plr)
end
end

function GFHR_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function GFHR_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(154, 1, "GFHR_OnCombat")
RegisterUnitEvent(154, 2, "GFHR_OnLeaveCombat")
RegisterUnitEvent(154, 4, "GFHR_OnDied")


-- Harvest Reaper
function Har_OnCombat(Unit, Event)
Unit:RegisterEvent("Har_WSlashh", 11000, 0)
end

function Har_WSlashh(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(7342, plr)
end
end

function Har_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function Har_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(115, 1, "Har_OnCombat")
RegisterUnitEvent(115, 2, "Har_OnLeaveCombat")
RegisterUnitEvent(115, 4, "Har_OnDied")


-- Kobold Digger
function KDI_OnCombat(Unit, Event)
Unit:RegisterEvent("KDI_PAA", 13000, 1)
Unit:SendChatMessage(12, 0, "Grr...More bones to gnaw on!")
end

function KDI_PAA(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(6016, plr)
end
end

function KDI_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function KDI_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(1236, 1, "KDI_OnCombat")
RegisterUnitEvent(1236, 2, "KDI_OnLeaveCombat")
RegisterUnitEvent(1236, 4, "KDI_OnDied")


-- Murloc Coastrunner
function MCT_OnCombat(Unit, Event)
Unit:RegisterEvent("MCT_PStab", 15000, 1)
end

function MCT_PStab(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(7357, plr)
end
end

function MCT_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MCT_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(126, 1, "MCT_OnCombat")
RegisterUnitEvent(126, 2, "MCT_OnLeaveCombat")
RegisterUnitEvent(126, 4, "MCT_OnDied")


-- Murloc Hunter
function MHU_OnCombat(Unit, Event)
Unit:RegisterEvent("MHU_Throwone", 3000, 0)
Unit:RegisterEvent("MHU_SumCrab", 50, 1)
end

function MHU_Throwone(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(10277, plr)
end
end

function MHU_SumCrab(Unit, Event)
Unit:CastSpell(8656)
end

function MHU_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MHU_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(458, 1, "MHU_OnCombat")
RegisterUnitEvent(458, 2, "MHU_OnLeaveCombat")
RegisterUnitEvent(458, 4, "MHU_OnDied")


-- Murloc Minor Oracle
function MCO_OnCombat(Unit, Event)
Unit:RegisterEvent("MCO_LBO", 3000, 0)
Unit:RegisterEvent("MCO_HW", 10000, 1)
end

function MCO_LBO(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(9532, plr)
end
end

function MCO_HW(Unit, Event)
Unit:CastSpell(332)
end

function MCO_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MCO_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(456, 1, "MCO_OnCombat")
RegisterUnitEvent(456, 2, "MCO_OnLeaveCombat")
RegisterUnitEvent(456, 4, "MCO_OnDied")


-- Murloc Tidehunter
function MTH_OnCombat(Unit, Event)
Unit:RegisterEvent("MTH_FNO", 15000, 0)
end

function MTH_FNO(Unit, Event)
Unit:CastSpell(11831)
end

function MTH_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MTH_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(127, 1, "MTH_OnCombat")
RegisterUnitEvent(127, 2, "MTH_OnLeaveCombat")
RegisterUnitEvent(127, 4, "MTH_OnDied")


-- Old Murk-Eye
function MOE_OnCombat(Unit, Event)
Unit:RegisterEvent("MOE_VIC", 12000, 1)
end

function MOE_VIC(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(3584, plr)
end
end

function MOE_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MOE_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(391, 1, "MOE_OnCombat")
RegisterUnitEvent(391, 2, "MOE_OnLeaveCombat")
RegisterUnitEvent(391, 4, "MOE_OnDied")


-- Murloc Netter
function MN_OnCombat(Unit, Event)
Unit:RegisterEvent("MN_Nett", 14000, 1)
Unit:RegisterEvent("MN_SArmor", 5000, 0)
end

function MN_Nett(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(12024, plr)
end
end

function MN_SArmor(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(11971, plr)
end
end

function MN_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MN_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(513, 1, "MN_OnCombat")
RegisterUnitEvent(513, 2, "MN_OnLeaveCombat")
RegisterUnitEvent(513, 4, "MN_OnDied")


-- Murloc Oracle
function MCOC_OnCombat(Unit, Event)
Unit:RegisterEvent("MCOC_HSmite", 2500, 0)
Unit:RegisterEvent("MCOC_Renew", 19000, 1)
end

function MCOC_HSmite(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(9734, plr)
end
end

function MCOC_Renew(Unit, Event)
Unit:CastSpell(6074)
end

function MCOC_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function MCOC_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(517, 1, "MCOC_OnCombat")
RegisterUnitEvent(517, 2, "MCOC_OnLeaveCombat")
RegisterUnitEvent(517, 4, "MCOC_OnDied")


-- Riverpaw Bandit
function RPB_OnCombat(Unit, Event)
Unit:RegisterEvent("RPB_BSThree", 3000, 0)
Unit:RegisterEvent("RPB_PStabTwo", 15000, 1)
end

function RPB_BSThree(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(53, plr)
end
end

function RPB_PStabTwo(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(7357, plr)
end
end

function RPB_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPB_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(452, 1, "RPB_OnCombat")
RegisterUnitEvent(452, 2, "RPB_OnLeaveCombat")
RegisterUnitEvent(452, 4, "RPB_OnDied")


-- Riverpaw Brute
function RPP_OnCombat(Unit, Event)
Unit:RegisterEvent("RPP_DemoS", 16000, 1)
end

function RPP_DemoS(Unit, Event)
Unit:CastSpell(13730)
end

function RPP_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPP_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(124, 1, "RPP_OnCombat")
RegisterUnitEvent(124, 2, "RPP_OnLeaveCombat")
RegisterUnitEvent(124, 4, "RPP_OnDied")


-- Piverpaw Herbalist
function RPH_OnCombat(Unit, Event)
Unit:RegisterEvent("RPH_DMPotion", 17000, 1)
Unit:RegisterEvent("RPH_PSTwo", 5000, 1)
end

function RPH_DMPotion(Unit, Event)
Unit:CastSpell(3368)
end

function RPH_PSTwo(Unit, Event)
Unit:CastSpell(3369)
end

function RPH_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPH_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(501, 1, "RPH_OnCombat")
RegisterUnitEvent(501, 2, "RPH_OnLeaveCombat")
RegisterUnitEvent(501, 4, "RPH_OnDied")


-- Riverpaw Miner
function RPM_OnCombat(Unit, Event)
Unit:RegisterEvent("RPM_SArmorTwo", 3000, 0)
end

function RPM_SArmorTwo(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(11971, plr)
end
end

function RPM_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPM_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(1426, 1, "RPM_OnCombat")
RegisterUnitEvent(1426, 2, "RPM_OnLeaveCombat")
RegisterUnitEvent(1426, 4, "RPM_OnDied")


-- Riverpaw Mongrel
function RPMM_OnCombat(Unit, Event)
Unit:RegisterEvent("RPMM_SDcay", 17000, 1)
end

function RPMM_SDcay(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(8016, plr)
end
end

function RPMM_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPMM_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(123, 1, "RPMM_OnCombat")
RegisterUnitEvent(123, 2, "RPMM_OnLeaveCombat")
RegisterUnitEvent(123, 4, "RPMM_OnDied")


-- Riverpaw Mystic
function RPMMM_OnCombat(Unit, Event)
Unit:RegisterEvent("RPMMM_LBot", 3000, 0)
end

function RPMMM_LBot(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(9532, plr)
end
end

function RPMMM_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPMMM_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(453, 1, "RPMMM_OnCombat")
RegisterUnitEvent(453, 2, "RPMMM_OnLeaveCombat")
RegisterUnitEvent(453, 4, "RPMMM_OnDied")


-- Riverpaw Scout
function RPSS_OnCombat(Unit, Event)
Unit:RegisterEvent("RPSS_RPShoot", 3000, 0)
end

function RPSS_RPShoot(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(6660, plr)
end
end

function RPSS_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPSS_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(500, 1, "RPSS_OnCombat")
RegisterUnitEvent(500, 2, "RPSS_OnLeaveCombat")
RegisterUnitEvent(500, 4, "RPSS_OnDied")


-- Piverpaw Taskmaster
function RPT_OnCombat(Unit, Event)
Unit:RegisterEvent("RPT_QBlu", 7000, 0)
end

function RPT_QBlu(Unit, Event)
Unit:CastSpell(3229)
end

function RPT_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RPT_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(98, 1, "RPT_OnCombat")
RegisterUnitEvent(98, 2, "RPT_OnLeaveCombat")
RegisterUnitEvent(98, 4, "RPT_OnDied")


-- Rusty Harvest Golem
function RHG_OnCombat(Unit, Event)
Unit:RegisterEvent("RHG_Tetanus", 15000, 1)
end

function RHG_Tetanus(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(8014, plr)
end
end

function RHG_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function RHG_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(480, 1, "RHG_OnCombat")
RegisterUnitEvent(480, 2, "RHG_OnLeaveCombat")
RegisterUnitEvent(480, 4, "RHG_OnDied")


-- Sergeant Brashclaw
function SBlaw_OnCombat(Unit, Event)
Unit:RegisterEvent("SBlaw_Kck", 10000, 0)
Unit:RegisterEvent("SBlaw_FCnd", 30000, 5)
end

function SBlaw_Kck(Unit, Event)
local plr =	Unit:GetMainTank()
if (plr ~= nil) then
Unit:FullCastSpellOnTarget(5164, plr)
end
end

function SBlaw_FCnd(Unit, Event)
Unit:CastSpell(3136)
end

function SBlaw_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function SBlaw_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(506, 1, "SBlaw_OnCombat")
RegisterUnitEvent(506, 2, "SBlaw_OnLeaveCombat")
RegisterUnitEvent(506, 4, "SBlaw_OnDied")


-- Young Goretusk
function YGore_OnCombat(Unit, Event)
Unit:CastSpell(6268)
end

function YGore_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function YGore_Dead(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(454, 1, "YGore_OnCombat")
RegisterUnitEvent(454, 2, "YGore_LeaveCombat")
RegisterUnitEvent(454, 4, "YGore_Dead")