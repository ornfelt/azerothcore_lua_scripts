--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


-- Bellygrub
function B_OnCombat(Unit, Event)
	Unit:castspell(6268)
	Unit:RegisterEvent("B_Tra", 5000, 0)
end

function B_Tra(Unit, Event)
	Unit:CastSpell(5568)
end

function B_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function B_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(345, 1, "B_OnCombat")
RegisterUnitEvent(345, 2, "B_OnLeaveCombat")
RegisterUnitEvent(345, 4, "B_OnDied")


-- Black Dragon Whelp
function BDW_OnCombat(Unit, Event)
	Unit:RegisterEvent("BDW_FB", 3000, 0)
end

function BDW_FB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20793, plr)
	end
end

function BDW_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BDW_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(441, 1, "BDW_OnCombat")
RegisterUnitEvent(441, 2, "BDW_OnLeaveCombat")
RegisterUnitEvent(441, 4, "BDW_OnDied")


-- Blackrock Champion
function BC_OnCombat(Unit, Event)
	Unit:RegisterEvent("BC_DS", 30000, 0)
	Unit:RegisterEvent("BC_DA", 1000, 1)
	Unit:RegisterEvent("BC_E", 40000, 0)
end

function BC_DS(Unit, Event)
	Unit:CastSpell(13730)
end

function BC_DA(Unit, Event)
	Unit:CastSpell(8258)
end

function BC_E(Unit, Event)
	Unit:CastSpell(3019)
end

function BC_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BC_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(435, 1, "BC_OnCombat")
RegisterUnitEvent(435, 2, "BC_OnLeaveCombat")
RegisterUnitEvent(435, 4, "BC_OnDied")


-- Blackrock Gladiator
function BG_OnCombat(Unit, Event)
	Unit:RegisterEvent("BG_BS", 30000, 0)
	Unit:RegisterEvent("BG_EN", 40000, 0)
	Unit:RegisterEvent("BG_D", 18000, 0)
end

function BG_BS(Unit, Event)
	Unit:CastSpell(32064)
end

function BG_EN(Unit, Event)
	Unit:CastSpell(3019)
end

function BG_D(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6713, plr)
	end
end

function BG_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BG_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4464, 1, "BG_OnCombat")
RegisterUnitEvent(4464, 2, "BG_OnLeaveCombat")
RegisterUnitEvent(4464, 4, "BG_OnDied")


-- Blackrock Grunt
function BGR_OnCombat(Unit, Event)
	Unit:RegisterEvent("BGR_ENR", 40000, 0)
end

function BGR_ENR(Unit, Event)
	Unit:CastSpell(3019)
end

function BGR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BGR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(440, 1, "BGR_OnCombat")
RegisterUnitEvent(440, 2, "BGR_OnLeaveCombat")
RegisterUnitEvent(440, 4, "BGR_OnDied")


-- Blackrock Hunter
function BH_OnCombat(Unit, Event)
	Unit:RegisterEvent("BH_T", 3000, 0)
	Unit:RegisterEvent("BH_ENRA", 40000, 0)
end

function BH_ENRA(Unit, Event)
	Unit:CastSpell(3019)
end

function BH_T(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(10277, plr)
	end
end

function BH_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BH_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4462, 1, "BH_OnCombat")
RegisterUnitEvent(4462, 2, "BH_OnLeaveCombat")
RegisterUnitEvent(4462, 4, "BH_OnDied")


-- Blackrock Outrunner
function BO_OnCombat(Unit, Event)
	Unit:RegisterEvent("BO_N", 12000, 0)
	Unit:RegisterEvent("BO_ENRAG", 40000, 0)
end

function BO_ENRAG(Unit, Event)
	Unit:CastSpell(3019)
end

function BO_N(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6533 , plr)
	end
end

function BO_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BO_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(485, 1, "BO_OnCombat")
RegisterUnitEvent(485, 2, "BO_OnLeaveCombat")
RegisterUnitEvent(485, 4, "BO_OnDied")


-- Blackrock Renegade
function BR_OnCombat(Unit, Event)
	Unit:RegisterEvent("BR_SL", 12000, 1)
	Unit:RegisterEvent("BR_ENRAGE", 40000, 0)
end

function BR_ENRAGE(Unit, Event)
	Unit:CastSpell(3019)
end

function BR_SL(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(8242 , plr)
	end
end

function BR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(437, 1, "BR_OnCombat")
RegisterUnitEvent(437, 2, "BR_OnLeaveCombat")
RegisterUnitEvent(437, 4, "BR_OnDied")


-- Blackrock Scout
function BST_OnCombat(Unit, Event)
	Unit:RegisterEvent("BST_SH", 3000, 0)
	Unit:RegisterEvent("BST_ENRAGEA", 40000, 0)
end

function BST_ENRAGEA(Unit, Event)
	Unit:CastSpell(3019)
end

function BST_SH(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6660 , plr)
	end
end

function BST_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BST_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4064, 1, "BST_OnCombat")
RegisterUnitEvent(4064, 2, "BST_OnLeaveCombat")
RegisterUnitEvent(4064, 4, "BST_OnDied")


-- Blackrock Sentry
function BSY_OnCombat(Unit, Event)
	Unit:RegisterEvent("BSY_ENRAGEB", 40000, 0)
end

function BSY_ENRAGEB(Unit, Event)
	Unit:CastSpell(3019)
end

function BSY_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BSY_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4065, 1, "BSY_OnCombat")
RegisterUnitEvent(4065, 2, "BSY_OnLeaveCombat")
RegisterUnitEvent(4065, 4, "BSY_OnDied")


-- Blackrock Shadowcaster
function BSC_OnCombat(Unit, Event)
	Unit:RegisterEvent("BSC_BA", 3000, 1)
	Unit:RegisterEvent("BSC_ENRAGEC", 40000, 0)
	Unit:RegisterEvent("BSC_DA", 1, 1)
	Unit:RegisterEvent("BSC_SB", 4000, 0)
	Unit:RegisterEvent("BSC_SWP", 12000, 0)
end

function BSC_ENRAGEC(Unit, Event)
	Unit:CastSpell(3019)
end

function BSC_DA(Unit, Event)
	Unit:CastSpell(13787)
end

function BSC_BA(Unit, Event)
local plr = 	pUnit:GetRandomPlayer(7)
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(8994 , plr)
	end
end

function BSC_SB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(9613 , plr)
	end
end

function BSC_SWP(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11639 , plr)
	end
end

function BSC_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BSC_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(436, 1, "BSC_OnCombat")
RegisterUnitEvent(436, 2, "BSC_OnLeaveCombat")
RegisterUnitEvent(436, 4, "BSC_OnDied")


-- Blackrock Summoner
function BSU_OnCombat(Unit, Event)
	Unit:RegisterEvent("BSU_FSII", 100, 1)
	Unit:RegisterEvent("BSU_ENRAGED", 40000, 0)
	Unit:RegisterEvent("BSU_FBA", 4000, 0)
	Unit:RegisterEvent("BSU_SI", 100, 1)
end

function BSU_ENRAGED(Unit, Event)
	Unit:CastSpell(3019)
end

function BSU_FSII(Unit, Event)
	Unit:CastSpell(184)
end

function BSU_SI(Unit, Event)
	Unit:CastSpell(11939)
end

function BSU_SBA(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20793 , plr)
	end
end

function BSU_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BSU_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4463, 1, "BSU_OnCombat")
RegisterUnitEvent(4463, 2, "BSU_OnLeaveCombat")
RegisterUnitEvent(4463, 4, "BSU_OnDied")


-- Blackrock Tracker
function BTT_OnCombat(Unit, Event)
	Unit:RegisterEvent("BTT_ENRAGEE", 40000, 0)
end

function BTT_ENRAGEE(Unit, Event)
	Unit:CastSpell(3019)
end

function BTT_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BTT_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(615, 1, "BTT_OnCombat")
RegisterUnitEvent(615, 2, "BTT_OnLeaveCombat")
RegisterUnitEvent(615, 4, "BTT_OnDied")


-- Gath'llzogg
function GL_OnCombat(Unit, Event)
	Unit:RegisterEvent("GL_IW", 20000, 0)
	Unit:RegisterEvent("GL_SBAA", 8000, 1)
end

function GL_IW(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3427 , plr)
	end
end

function GL_SBAA(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11972 , plr)
	end
end

function GL_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GL_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(334, 1, "GL_OnCombat")
RegisterUnitEvent(334, 2, "GL_OnLeaveCombat")
RegisterUnitEvent(334, 4, "GL_OnDied")


-- Great Goretusk
function GG_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function GG_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GG_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(547, 1, "GG_OnCombat")
RegisterUnitEvent(547, 2, "GG_OnLeaveCombat")
RegisterUnitEvent(547, 4, "GG_OnDied")


-- Murloc Minor Tidecaller
function MMT_OnCombat(Unit, Event)
	Unit:RegisterEvent("MMT_FRB", 3000, 0)
	Unit:RegisterEvent("MMT_HW", 15000, 0)
end

function MMT_FRB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(9672 , plr)
	end
end

function MMT_HW(Unit, Event)
	Unit:CastSpell(547)
end

function MMT_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function MMT_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(548, 1, "MMT_OnCombat")
RegisterUnitEvent(548, 2, "MMT_OnLeaveCombat")
RegisterUnitEvent(548, 4, "MMT_OnDied")


-- Murloc Shorestriker
function MSTR_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function MSTR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function MSTR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1083, 1, "MSTR_OnCombat")
RegisterUnitEvent(1083, 2, "MSTR_OnLeaveCombat")
RegisterUnitEvent(1083, 4, "MSTR_OnDied")


-- Murloc Tidecaller
function MTC_OnCombat(Unit, Event)
	Unit:RegisterEvent("MTC_HWA", 15000, 0)
end

function MTC_HWA(Unit, Event)
	Unit:CastSpell(913)
end

function MTC_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function MTC_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(545, 1, "MTC_OnCombat")
RegisterUnitEvent(545, 2, "MTC_OnLeaveCombat")
RegisterUnitEvent(545, 4, "MTC_OnDied")


-- Rabid Shadowhide Gnoll
function RSG_OnCombat(Unit, Event)
	Unit:RegisterEvent("RSG_P", 3000, 1)
	Unit:RegisterEvent("RSG_RB", 15000, 1)
end

function RSG_P(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(744 , plr)
	end
end

function RSG_RB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3150 , plr)
	end
end

function RSG_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RSG_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(434, 1, "RSG_OnCombat")
RegisterUnitEvent(434, 2, "RSG_OnLeaveCombat")
RegisterUnitEvent(434, 4, "RSG_OnDied")


-- Redridge Alpha
function RA_OnCombat(Unit, Event)
	Unit:RegisterEvent("RA_Strike", 4000, 0)
end

function RA_Strike(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11976 , plr)
	end
end

function RA_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RA_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(445, 1, "RA_OnCombat")
RegisterUnitEvent(445, 2, "RA_OnLeaveCombat")
RegisterUnitEvent(445, 4, "RA_OnDied")


-- Redridge Basher
function RBSH_OnCombat(Unit, Event)
	Unit:RegisterEvent("RBSH_KD", 10000, 0)
	Unit:RegisterEvent("RBSH_REND", 12000, 0)
end

function RBSH_KD(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(5164 , plr)
	end
end

function RBSH_REND(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11977 , plr)
	end
end

function RBSH_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RBSH_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(446, 1, "RBSH_OnCombat")
RegisterUnitEvent(446, 2, "RBSH_OnLeaveCombat")
RegisterUnitEvent(446, 4, "RBSH_OnDied")


-- Redridge Mongrel
function RMGG_OnCombat(Unit, Event)
	Unit:RegisterEvent("RMGG_IWDD", 1000, 1)
end

function RMGG_IWDD(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3427 , plr)
	end
end

function RMGG_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RMGG_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(423, 1, "RMGG_OnCombat")
RegisterUnitEvent(423, 2, "RMGG_OnLeaveCombat")
RegisterUnitEvent(423, 4, "RMGG_OnDied")


-- Redridge Mystic
function RRMM_OnCombat(Unit, Event)
	Unit:RegisterEvent("RRMM_HWK", 15000, 0)
	Unit:RegisterEvent("RRMM_LIB", 3000, 0)
end

function RRMM_HWK(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(547 , plr)
	end
end

function RRMM_LIB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20802 , plr)
	end
end

function RRMM_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RRMM_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(430, 1, "RRMM_OnCombat")
RegisterUnitEvent(430, 2, "RRMM_OnLeaveCombat")
RegisterUnitEvent(430, 4, "RRMM_OnDied")


-- Redridge Poacher
function RR_OnCombat(Unit, Event)
	Unit:RegisterEvent("RR_HWK", 3000, 0)
end

function RR_HWK(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6660 , plr)
	end
end

function RR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(424, 1, "RR_OnCombat")
RegisterUnitEvent(424, 2, "RR_OnLeaveCombat")
RegisterUnitEvent(424, 4, "RR_OnDied")


-- Servant of Ilgalar
function SOI_OnCombat(Unit, Event)
	Unit:RegisterEvent("SOI_MB", 7000, 0)
end

function SOI_MB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(8129 , plr)
	end
end

function SOI_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SOI_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(819, 1, "SOI_OnCombat")
RegisterUnitEvent(819, 2, "SOI_OnLeaveCombat")
RegisterUnitEvent(819, 4, "SOI_OnDied")


-- Shadowhide Assassin
function SHA_OnCombat(Unit, Event)
	Unit:RegisterEvent("SHA_BS", 4000, 0)
	Unit:RegisterEvent("SHA_PN", 10000, 1)
end

function SHA_BS(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(2590 , plr)
	end
end

function SHA_PN(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(744 , plr)
	end
end

function SHA_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SHA_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(579, 1, "SHA_OnCombat")
RegisterUnitEvent(579, 2, "SHA_OnLeaveCombat")
RegisterUnitEvent(579, 4, "SHA_OnDied")


-- Shadowhide Brute
function SHB_OnCombat(Unit, Event)
	Unit:RegisterEvent("SHB_EG", 15000, 0)
end

function SHB_EG(Unit, Event)
	Unit:CastSpell(8599)
end

function SHB_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SHB_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(432, 1, "SHB_OnCombat")
RegisterUnitEvent(432, 2, "SHB_OnLeaveCombat")
RegisterUnitEvent(432, 4, "SHB_OnDied")


-- Shadowhide Darkweaver
function SHDW_OnCombat(Unit, Event)
	Unit:RegisterEvent("SHDW_SBLT", 3000, 0)
end

function SHDW_SBLT(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(2590 , plr)
	end
end

function SHDW_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SHDW_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(429, 1, "SHDW_OnCombat")
RegisterUnitEvent(429, 2, "SHDW_OnLeaveCombat")
RegisterUnitEvent(429, 4, "SHDW_OnDied")


-- Shadowhide Slayer
function SHS_OnCombat(Unit, Event)
	Unit:RegisterEvent("SHS_EX", 30000, 0)
end

function SHS_EX(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7160 , plr)
	end
end

function SHS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SHS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(431, 1, "SHS_OnCombat")
RegisterUnitEvent(431, 2, "SHS_OnLeaveCombat")
RegisterUnitEvent(431, 4, "SHS_OnDied")


-- Shadowhide Warrior
function SHW_OnCombat(Unit, Event)
	Unit:RegisterEvent("SHW_SAR", 30000, 0)
end

function SHW_SAR(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7405 , plr)
	end
end

function SHW_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SHW_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(568, 1, "SHW_OnCombat")
RegisterUnitEvent(568, 2, "SHW_OnLeaveCombat")
RegisterUnitEvent(568, 4, "SHW_OnDied")


-- Singe
function Singe_OnCombat(Unit, Event)
	Unit:RegisterEvent("Singe_FIBB", 3000, 0)
	Unit:RegisterEvent("Singe_FS", 15000, 0)
end

function SHW_FIBB(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(13375 , plr)
	end
end

function Singe_FS(Unit, Event)
	Unit:CastSpell(12468)
end

function Singe_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Singe_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(335, 1, "Singe_OnCombat")
RegisterUnitEvent(335, 2, "Singe_OnLeaveCombat")
RegisterUnitEvent(335, 4, "Singe_OnDied")


-- Tarantula
function Tara_OnCombat(Unit, Event)
	Unit:RegisterEvent("Tara_PON", 3000, 0)
end

function SHW_PON(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(744 , plr)
	end
end

function Tara_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Tara_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(442, 1, "Tara_OnCombat")
RegisterUnitEvent(442, 2, "Tara_OnLeaveCombat")
RegisterUnitEvent(442, 4, "Tara_OnDied")


-- Tharil'zun
function THA_OnCombat(Unit, Event)
	Unit:RegisterEvent("THA_BFY", 20000, 0)
	Unit:RegisterEvent("THA_ERAG", 15000, 0)
	Unit:RegisterEvent("THA_NETTT", 11000, 0)
end

function SHW_NETTT(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6533 , plr)
	end
end

function THA_ERAG(Unit, Event)
	Unit:CastSpell(3019)
end

function THA_BFY(Unit, Event)
	Unit:CastSpell(3631)
end

function THA_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function THA_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(486, 1, "THA_OnCombat")
RegisterUnitEvent(486, 2, "THA_OnLeaveCombat")
RegisterUnitEvent(486, 4, "THA_OnDied")