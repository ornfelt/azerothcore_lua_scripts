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

Area - Dun Morogh - Mobs.lua by Wartick
Report Bugs at www.lasp.forumotion.com
-- ]]

-- Crag Boar
function CragBoar_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function CragBoar_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function CragBoar_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1125, 1, "CragBoar_OnCombat")
RegisterUnitEvent(1125, 2, "CragBoar_LeaveCombat")
RegisterUnitEvent(1125, 4, "CragBoar_Dead")

-- Elder Crag Boar
function ECragBoar_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function ECragBoar_LeaveCombat(pUnit, Event)
	pUnit::RemoveEvents()
end

function ECragBoar_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1127, 1, "ECragBoar_OnCombat")
RegisterUnitEvent(1127, 2, "ECragBoar_LeaveCombat")
RegisterUnitEvent(1127, 4, "ECragBoar_Dead")


-- Frostmane Headhunter
function FHH_OnCombat(Unit, Event)
	Unit:RegisterEvent("FHH_Throw", 7000, 0)
end

function FHH_Throw(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(10277, plr)
	end
end

function FHH_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function FHH_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1123, 1, "FHH_OnCombat")
RegisterUnitEvent(1123, 2, "FHH_LeaveCombat")
RegisterUnitEvent(1123, 4, "FHH_Dead")

-- Frostmane Hideskinner
function FHS_OnCombat(Unit, Event)
	Unit:RegisterEvent("FHS_BS", 50, 1)
end

function FHS_BS(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7159, plr)
	end
end


function FHS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function FHS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1122, 1, "FHS_OnCombat")
RegisterUnitEvent(1122, 2, "FHS_LeaveCombat")
RegisterUnitEvent(1122, 4, "FHS_Dead")


-- Frostmane Novice
function FN_OnCombat(Unit, Event)
	Unit:RegisterEvent("FN_WF", 9000, 0)
end

function FN_WF(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6949, plr)
	end
end


function FN_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function FN_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(946, 1, "FN_OnCombat")
RegisterUnitEvent(946, 2, "FN_LeaveCombat")
RegisterUnitEvent(946, 4, "FN_Dead")

-- Frostmane Seer
function FS_OnCombat(Unit, Event)
	Unit:RegisterEvent("FS_LB", 9000, 0)
	Unit:RegisterEvent("FS_LS", 50, 1)
end

function FS_LB(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(9532, plr)
	end
end

function FS_LS(Unit, Event)
	Unit:CastSpell(324)
end

function FS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function FS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1397, 1, "FS_OnCombat")
RegisterUnitEvent(1397, 2, "FS_LeaveCombat")
RegisterUnitEvent(1397, 4, "FS_Dead")


-- Frostmane Shadowcaster
function FSC_OnCombat(Unit, Event)
	Unit:RegisterEvent("FSC_COW", 19000, 1)
	Unit:RegisterEvent("FSC_SHB", 9600, 0)
	Unit:CastSpell(20798)
end

function FSC_COW(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11980, plr)
	end
end

function FSC_SHB(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20791, plr)
	end
end

function FSC_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function FSC_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1124, 1, "FSC_OnCombat")
RegisterUnitEvent(1124, 2, "FSC_LeaveCombat")
RegisterUnitEvent(1124, 4, "FSC_Dead")

-- Frostmane Snowstrider
function FSCI_OnCombat(Unit, Event)
	Unit:RegisterEvent("FSCI_FF", 5000, 1)
	Unit:CastSpell(467)
end

function FSCI_FF(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6950, plr)
	end
end

function FSCI_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function FSCI_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1121, 1, "FSCI_OnCombat")
RegisterUnitEvent(1121, 2, "FSCI_LeaveCombat")
RegisterUnitEvent(1121, 4, "FSCI_Dead")


-- Gibblewilt
function Gib_OnCombat(Unit, Event)
	Unit:RegisterEvent("Gib_FB", 8700, 0)
end

function Gib_FB(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20793, plr)
	end
end

function Gib_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Gib_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(8503, 1, "Gib_OnCombat")
RegisterUnitEvent(8503, 2, "Gib_LeaveCombat")
RegisterUnitEvent(8503, 4, "Gib_Dead")

-- Gri'knir The Cold
function GTG_OnCombat(Unit, Event)
	Unit:RegisterEvent("GTG_FSH", 14000, 1)
	Unit:RegisterEvent("GTG_FSTR", 5000, 0)
end

function GTG_FSH(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(21030, plr)
	end
end

function GTG_FSTR(Unit, Event)
	Unit:CastSpell(6957)
end

function GTG_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function GTG_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(808, 1, "GTG_OnCombat")
RegisterUnitEvent(808, 2, "GTG_LeaveCombat")
RegisterUnitEvent(808, 4, "GTG_Dead")

-- Holdout Warrior
function HW_OnCombat(Unit, Event)
	Unit:RegisterEvent("HW_Pummel", 16000, 0)
	Unit:RegisterEvent("HW_Strike", 9500, 0)
end

function HW_Pummel(pUnit, Event)
local plr = 	pUnit:GetRandomPlayer(4)
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(12555, plr)
	end
end

function HW_Strike(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11976, plr)
	end
end

function HW_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function HW_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(6391, 1, "HW_OnCombat")
RegisterUnitEvent(6391, 2, "HW_LeaveCombat")
RegisterUnitEvent(6391, 4, "HW_Dead")

-- Ice Claw Bear
function ICB_OnCombat(Unit, Event)
	Unit:RegisterEvent("ICB_IClaw", 8500, 0)
end

function ICB_IClaw(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3130, plr)
	end
end

function ICB_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function ICB_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1196, 1, "ICB_OnCombat")
RegisterUnitEvent(1196, 2, "ICB_LeaveCombat")
RegisterUnitEvent(1196, 4, "ICB_Dead")

-- Ironforge Guard
function IG_OnCombat(Unit, Event)
	Unit:RegisterEvent("IG_SA", 200, 0)
	Unit:RegisterEvent("IG_TC", 2000, 1)
end

function IG_SA(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11971, plr)
	end
end

function IG_TC(Unit, Event)
	Unit:CastSpell(8078)
end

function IG_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function IG_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(5595, 1, "IG_OnCombat")
RegisterUnitEvent(5595, 2, "IG_LeaveCombat")
RegisterUnitEvent(5595, 4, "IG_Dead")

-- Ironforge Mountaineer
function IM_OnCombat(Unit, Event)
	Unit:RegisterEvent("IM_Shoot", 500, 0)
end

function IM_Shoot(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6660, plr)
	end
end

function IM_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function IM_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(727, 1, "IM_OnCombat")
RegisterUnitEvent(727, 2, "IM_LeaveCombat")
RegisterUnitEvent(727, 4, "IM_Dead")

-- Large Crag Boar
function LCragBoar_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function LCragBoar_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LCragBoar_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1126, 1, "LCragBoar_OnCombat")
RegisterUnitEvent(1126, 2, "LCragBoar_LeaveCombat")
RegisterUnitEvent(1126, 4, "LCragBoar_Dead")


-- Leper Gnome
function LG_OnCombat(Unit, Event)
	Unit:RegisterEvent("LG_DCS", 7000, 1)
end

function LG_DCS(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6951, plr)
	end
end

function LG_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LG_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1211, 1, "LG_OnCombat")
RegisterUnitEvent(1211, 2, "LG_LeaveCombat")
RegisterUnitEvent(1211, 4, "LG_Dead")

-- Mangedaw
function MG_OnCombat(Unit, Event)
	Unit:RegisterEvent("MG_Ravage", 10000, 0)
end

function MG_Ravage(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3242, plr)
	end
end

function MG_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function MG_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1961, 1, "MG_OnCombat")
RegisterUnitEvent(1961, 2, "MG_LeaveCombat")
RegisterUnitEvent(1961, 4, "MG_Dead")

-- Old Icebeard
function OI_OnCombat(Unit, Event)
	Unit:RegisterEvent("OI_IcyG", 17000, 2)
	Unit:RegisterEvent("OI_DG", 13000, 1)
end

function OI_IcyG(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3145, plr)
	end
end

function OI_DG(Unit, Event)
	Unit:CastSpell(3146)
end

function OI_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function OI_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1271, 1, "OI_OnCombat")
RegisterUnitEvent(1271, 2, "OI_LeaveCombat")
RegisterUnitEvent(1271, 4, "OI_Dead")

-- Rockjaw Bonesnapper
function RBS_OnCombat(Unit, Event)
	Unit:RegisterEvent("RBS_KD", 8000, 2)
end

function RBS_KD(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(5164, plr)
	end
end

function RBS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RBS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1117, 1, "RBS_OnCombat")
RegisterUnitEvent(1117, 2, "RBS_LeaveCombat")
RegisterUnitEvent(1117, 4, "RBS_Dead")

-- Rockjaw Skullthumper
function RST_OnCombat(Unit, Event)
	Unit:RegisterEvent("RST_HC", 12000, 1)
end

function RST_HC(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3148, plr)
	end
end

function RST_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RST_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1115, 1, "RST_OnCombat")
RegisterUnitEvent(1115, 2, "RST_LeaveCombat")
RegisterUnitEvent(1115, 4, "RST_Dead")

-- Small Crag Boar
function SCragBoar_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function SCragBoar_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function SCragBoar_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1689, 1, "SCragBoar_OnCombat")


-- Starving Winter Wolf
function SWW_OnCombat(Unit, Event)
	Unit:RegisterEvent("SWW_CH", 12000, 1)
end

function SWW_CH(Unit, Event)
	Unit:CastSpell(3151)
end

function SWW_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function SWW_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1133, 1, "SWW_OnCombat")
RegisterUnitEvent(1133, 2, "SWW_LeaveCombat")
RegisterUnitEvent(1133, 4, "SWW_Dead")

-- Timber
function Timber_OnCombat(Unit, Event)
	Unit:RegisterEvent("Timber_Rabies", 17000, 1)
end

function Timber_Rabies(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3150, plr)
	end
end


function Timber_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Timber_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1132, 1, "Timber_OnCombat")
RegisterUnitEvent(1132, 2, "Timber_OnLeaveCombat")
RegisterUnitEvent(1132, 4, "Timber_OnDied")

-- Vegash
function Veg_OnCombat(Unit, Event)
	Unit:RegisterEvent("Veg_GR", 14000, 0)
end

function Veg_GR(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3143, plr)
	end
end


function Veg_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Veg_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1388, 1, "Veg_OnCombat")
RegisterUnitEvent(1388, 2, "Veg_OnLeaveCombat")
RegisterUnitEvent(1388, 4, "Veg_OnDied")

-- Wendigo
function Wen_OnCombat(Unit, Event)
	Unit:RegisterEvent("Wen_FB", 10000, 0)
end

function Wen_FB(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3131, plr)
	end
end


function Wen_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Wen_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1135, 1, "Wen_OnCombat")
RegisterUnitEvent(1135, 2, "Wen_OnLeaveCombat")
RegisterUnitEvent(1135, 4, "Wen_OnDied")

-- Young Wendigo
function YWen_OnCombat(Unit, Event)
	Unit:RegisterEvent("YWen_FB", 10000, 0)
end

function YWen_FB(pUnit, Event)
local plr = 	pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3131, plr)
	end
end


function YWen_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function YWen_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(1134, 1, "YWen_OnCombat")
RegisterUnitEvent(1134, 2, "YWen_OnLeaveCombat")
RegisterUnitEvent(1134, 4, "YWen_OnDied")