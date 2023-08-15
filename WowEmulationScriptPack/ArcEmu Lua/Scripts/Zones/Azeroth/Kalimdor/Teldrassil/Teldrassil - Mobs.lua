--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]



-- Bloodfeather Harpy
function BFH_OnCombat(Unit, Event)
	Unit:RegisterEvent("BFH_BLeech", 10000, 0)
end

function BFH_BLeech(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(6958, plr)
end
end

function BFH_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BFH_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2015, 1, "BFH_OnCombat")
RegisterUnitEvent(2015, 2, "BFH_OnLeaveCombat")
RegisterUnitEvent(2015, 4, "BFH_OnDied")


-- Bloodfeather Fury
function BFF_OnCombat(Unit, Event)
	Unit:RegisterEvent("BFF_Savagery", 10000, 1)
end

function BFF_Savagery(Unit, Event)
	Unit:CastSpell(5515)
end

function BFF_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BFF_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2019, 1, "BFF_OnCombat")
RegisterUnitEvent(2019, 2, "BFF_OnLeaveCombat")
RegisterUnitEvent(2019, 4, "BFF_OnDied")


-- Bloodfeather Matriarch
function BFM_OnCombat(Unit, Event)
	Unit:RegisterEvent("BFM_LBot", 3000, 0)
	Unit:RegisterEvent("BFM_HWave", 18000, 1)
end

function BFM_LBot(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(9532, plr)
end
end

function BFM_HWave(Unit, Event)
	Unit:CastSpell(332)
end

function BFM_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BFM_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2021, 1, "BFM_OnCombat")
RegisterUnitEvent(2021, 2, "BFM_OnLeaveCombat")
RegisterUnitEvent(2021, 4, "BFM_OnDied")


-- Bloodfeather Sorceress
function BFS_OnCombat(Unit, Event)
	Unit:RegisterEvent("BFS_FBall", 3000, 0)
	Unit:RegisterEvent("BFS_FArmorThree", 10000, 1)
end

function BFS_FBall(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(20793, plr)
end
end

function BFS_FArmorThree(Unit, Event)
	Unit:CastSpell(12544)
end

function BFS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BFS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2018, 1, "BFS_OnCombat")
RegisterUnitEvent(2018, 2, "BFS_OnLeaveCombat")
RegisterUnitEvent(2018, 4, "BFS_OnDied")


-- Bloodfeather Wind Witch
function BFWW_OnCombat(Unit, Event)
	Unit:RegisterEvent("BFWW_GOWnd", 30000, 0)
end

function BFWW_GOWnd(Unit, Event)
	Unit:CastSpell(6982)
end

function BFWW_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BFWW_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2020, 1, "BFWW_OnCombat")
RegisterUnitEvent(2020, 2, "BFWW_OnLeaveCombat")
RegisterUnitEvent(2020, 4, "BFWW_OnDied")


-- Dark Sprite
function DPE_OnCombat(Unit, Event)
	Unit:RegisterEvent("DPE_DarV", 15000, 1)
end

function DPE_DarV(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(5514, plr)
end
end

function DPE_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function DPE_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2004, 1, "DPE_OnCombat")
RegisterUnitEvent(2004, 2, "DPE_OnLeaveCombat")
RegisterUnitEvent(2004, 4, "DPE_OnDied")


-- Elder Timberling
function ETB_OnCombat(Unit, Event)
	Unit:RegisterEvent("ETB_THW", 18000, 1)
	Unit:RegisterEvent("ETB_LSeel", 1000, 1)
end

function ETB_LSeel(Unit, Event)
	Unit:CastSpell(324)
end

function ETB_THW(Unit, Event)
	Unit:CastSpell(332)
end

function ETB_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function ETB_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2030, 1, "ETB_OnCombat")
RegisterUnitEvent(2030, 2, "ETB_OnLeaveCombat")
RegisterUnitEvent(2030, 4, "ETB_OnDied")


-- Feral Nightsaber
function FNS_OnCombat(Unit, Event)
	Unit:RegisterEvent("FNS_Spellname", 9000, 0)
end

function FNS_Event(Unit, Event)
local plr = 	Unit:GetRandomPlayer(0)
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(12166, plr)
end
end

function FNS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function FNS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2034, 1, "FNS_OnCombat")
RegisterUnitEvent(2034, 2, "FNS_OnLeaveCombat")
RegisterUnitEvent(2034, 4, "FNS_OnDied")


-- Ferocitas the Dream Eater
function FTDE_OnCombat(Unit, Event)
	Unit:RegisterEvent("FTDE_Thrash", 20000, 0)
end

function FTDE_Thrash(Unit, Event)
	Unit:CastSpell(3391)
end

function FTDE_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function FTDE_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(7234, 1, "FTDE_OnCombat")
RegisterUnitEvent(7234, 2, "FTDE_OnLeaveCombat")
RegisterUnitEvent(7234, 4, "FTDE_OnDied")


-- Gnarlpine Mystic
function GMT_OnCombat(Unit, Event)
	Unit:RegisterEvent("GMT_Wrathone", 5000, 0)
end

function GMT_Wrathone(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(9739, plr)
end
end

function GMT_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GMT_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(7235, 1, "GMT_OnCombat")
RegisterUnitEvent(7235, 2, "GMT_OnLeaveCombat")
RegisterUnitEvent(7235, 4, "GMT_OnDied")


-- Fury Shelda
function FSda_OnCombat(Unit, Event)
	Unit:RegisterEvent("FSda_DSch", 16000, 1)
end

function FSda_DSch(Unit, Event)
	Unit:CastSpell(3589)
end

function FSda_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function FSda_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(14431, 1, "FSda_OnCombat")
RegisterUnitEvent(14431, 2, "FSda_OnLeaveCombat")
RegisterUnitEvent(14431, 4, "FSda_OnDied")


-- Gnarlpine Augur
function GAr_OnCombat(Unit, Event)
	Unit:RegisterEvent("GAr_GV", 19000, 0)
end

function GAr_GV(Unit, Event)
	Unit:CastSpell(5628)
end

function GAr_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GAr_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2011, 1, "GAr_OnCombat")
RegisterUnitEvent(2011, 2, "GAr_OnLeaveCombat")
RegisterUnitEvent(2011, 4, "GAr_OnDied")


-- Gnarlpine Avenger
function GAA_OnCombat(Unit, Event)
	Unit:RegisterEvent("GAA_GVV", 19000, 0)
end

function GAA_GVV(Unit, Event)
	Unit:CastSpell(5628)
end

function GAA_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GAA_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2013, 1, "GAA_OnCombat")
RegisterUnitEvent(2013, 2, "GAA_OnLeaveCombat")
RegisterUnitEvent(2013, 4, "GAA_OnDied")


-- Gnarlpine Pathfinder
function GP_OnCombat(Unit, Event)
	Unit:RegisterEvent("GP_Wrathtwo", 5000, 0)
	Unit:RegisterEvent("GP_GVVV", 15000, 0)
end

function GP_Wrathtwo(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(9739, plr)
end
end

function GP_GVVV(Unit, Event)
	Unit:CastSpell(5628)
end

function GP_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GP_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2012, 1, "GP_OnCombat")
RegisterUnitEvent(2012, 2, "GP_OnLeaveCombat")
RegisterUnitEvent(2012, 4, "GP_OnDied")


-- Gnarlpine Shaman
function GS_OnCombat(Unit, Event)
	Unit:RegisterEvent("GS_HWe", 14000, 1)
end

function GS_HWe(Unit, Event)
	Unit:CastSpell(332)
end

function GS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2009, 1, "GS_OnCombat")
RegisterUnitEvent(2009, 2, "GS_OnLeaveCombat")
RegisterUnitEvent(2009, 4, "GS_OnDied")


-- Gnarlpine Totemic
function GT_OnCombat(Unit, Event)
	Unit:RegisterEvent("GT_HWdd", 2000, 1)
	Unit:RegisterEvent("GT_GVVVV", 15000, 0)
end

function GT_HWdd(Unit, Event)
	Unit:CastSpell(5605)
end

function GT_GVVVV(Unit, Event)
	Unit:CastSpell(5628)
end

function GT_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GT_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2014, 1, "GT_OnCombat")
RegisterUnitEvent(2014, 2, "GT_OnLeaveCombat")
RegisterUnitEvent(2014, 4, "GT_OnDied")


-- Gnarlpine Warrior
function GWR_OnCombat(Unit, Event)
	Unit:RegisterEvent("GWR_Strike", 3000, 0)
end

function GWR_Strike(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(11976, plr)
end
end

function GWR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function GWR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2008, 1, "GWR_OnCombat")
RegisterUnitEvent(2008, 2, "GWR_OnLeaveCombat")
RegisterUnitEvent(2008, 4, "GWR_OnDied")


-- Greenpaw
function Gree_OnCombat(Unit, Event)
	Unit:RegisterEvent("Gree_Shock", 6000, 0)
	Unit:RegisterEvent("Gree_Rejuv", 7000, 2)
end

function Gree_Shock(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(2606, plr)
end
end

function Gree_Rejuv(Unit, Event)
	Unit:CastSpell(774)
end

function Gree_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Gree_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1993, 1, "Gree_OnCombat")
RegisterUnitEvent(1993, 2, "Gree_OnLeaveCombat")
RegisterUnitEvent(1993, 4, "Gree_OnDied")


-- Lord Melenas
function Mel_OnCombat(Unit, Event)
	Unit:RegisterEvent("Mel_Rake", 3000, 0)
	Unit:RegisterEvent("Mel_Cat", 15000, 0)
	Unit:RegisterEvent("Mel_Rejuv", 14000, 2)
end

function Mel_Rake(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(1822, plr)
end
end

function Mel_Cat(Unit, Event)
	Unit:CastSpell(5759)
end

function Mel_Rejuv(Unit, Event)
	Unit:CastSpell(774)
end

function Mel_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Mel_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2038, 1, "Mel_OnCombat")
RegisterUnitEvent(2038, 2, "Mel_OnLeaveCombat")
RegisterUnitEvent(2038, 4, "Mel_OnDied")


-- Rageclaw
function Rag_OnCombat(Unit, Event)
	Unit:RegisterEvent("Rag_Maul", 3000, 0)
	Unit:CastSpell(7090)
end

function Rag_Maul(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(12161, plr)
end
end

function Rag_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Rag_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(7318, 1, "Rag_OnCombat")
RegisterUnitEvent(7318, 2, "Rag_OnLeaveCombat")
RegisterUnitEvent(7318, 4, "Rag_OnDied")


-- Rascal Sprite
function RS_OnCombat(Unit, Event)
	Unit:RegisterEvent("RS_FF", 30000, 0)
end

function RS_FF(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(6950, plr)
end
end

function RS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2002, 1, "RS_OnCombat")
RegisterUnitEvent(2002, 2, "RS_OnLeaveCombat")
RegisterUnitEvent(2002, 4, "RS_OnDied")


-- Shadow Sprite
function SS_OnCombat(Unit, Event)
	Unit:RegisterEvent("SS_ShB", 3000, 0)
end

function SS_ShB(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(9613, plr)
end
end

function SS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2003, 1, "SS_OnCombat")
RegisterUnitEvent(2003, 2, "SS_OnLeaveCombat")
RegisterUnitEvent(2003, 4, "SS_OnDied")


-- Threggil
function Gil_OnCombat(Unit, Event)
	Unit:RegisterEvent("Gil_Ske", 3000, 0)
end

function Gil_Ske(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(11976, plr)
end
end

function Gil_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Gil_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(14432, 1, "Gil_OnCombat")
RegisterUnitEvent(14432, 2, "Gil_OnLeaveCombat")
RegisterUnitEvent(14432, 4, "Gil_OnDied")


-- Timberling Bark Ripper
function TBR_OnCombat(Unit, Event)
	Unit:RegisterEvent("TBR_PieA", 20000, 0)
end

function TBR_PieA(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(6016, plr)
end
end

function TBR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function TBR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2025, 1, "TBR_OnCombat")
RegisterUnitEvent(2025, 2, "TBR_OnLeaveCombat")
RegisterUnitEvent(2025, 4, "TBR_OnDied")


-- Timberling Mire Beast
function TMB_OnCombat(Unit, Event)
	Unit:RegisterEvent("TMB_MM", 10000, 1)
end

function TMB_MM(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(5567, plr)
end
end

function TMB_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function TMB_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2029, 1, "TMB_OnCombat")
RegisterUnitEvent(2029, 2, "TMB_OnLeaveCombat")
RegisterUnitEvent(2029, 4, "TMB_OnDied")


-- Timberling Trampler
function TTM_OnCombat(Unit, Event)
	Unit:RegisterEvent("TTM_Trample", 5000, 0)
end

function TTM_Trample(Unit, Event)
	Unit:CastSpell(5568)
end

function TTM_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function TTM_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2027, 1, "TTM_OnCombat")
RegisterUnitEvent(2027, 2, "TTM_OnLeaveCombat")
RegisterUnitEvent(2027, 4, "TTM_OnDied")


-- Ursal The Mauler
function UTM_OnCombat(Unit, Event)
	Unit:RegisterEvent("UTM_Maa", 4000, 0)
end

function UTM_Maa(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(15793, plr)
end
end

function UTM_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function UTM_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2039, 1, "UTM_OnCombat")
RegisterUnitEvent(2039, 2, "UTM_OnLeaveCombat")
RegisterUnitEvent(2039, 4, "UTM_OnDied")


-- Uruson
function Uru_OnCombat(Unit, Event)
	Unit:RegisterEvent("Uru_DRo", 8000, 0)
end

function Uru_DRo(Unit, Event)
	Unit:CastSpell(5568)
end

function Uru_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Uru_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(14428, 1, "Uru_OnCombat")
RegisterUnitEvent(14428, 2, "Uru_OnLeaveCombat")
RegisterUnitEvent(14428, 4, "Uru_OnDied")


-- Vicious Grell
function VG_OnCombat(Unit, Event)
	Unit:RegisterEvent("VG_Sav", 15000, 0)
end

function VG_Sav(Unit, Event)
	Unit:CastSpell(5515)
end

function VG_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function VG_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2005, 1, "VG_OnCombat")
RegisterUnitEvent(2005, 2, "VG_OnLeaveCombat")
RegisterUnitEvent(2005, 4, "VG_OnDied")


-- Webwood Silkspinner
function WS_OnCombat(Unit, Event)
	Unit:RegisterEvent("WS_Web", 4000, 0)
end

function WS_Web(Unit, Event)
local plr = 	Unit:GetClosestPlayer()
if (plr ~= nil) then
	Unit:FullCastSpellOnTarget(12023, plr)
end
end

function WS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function WS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2000, 1, "WS_OnCombat")
RegisterUnitEvent(2000, 2, "WS_OnLeaveCombat")
RegisterUnitEvent(2000, 4, "WS_OnDied")
