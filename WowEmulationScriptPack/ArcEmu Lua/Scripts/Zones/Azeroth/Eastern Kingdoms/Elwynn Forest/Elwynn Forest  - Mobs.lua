--[[====================================
   Example.lua
   Original Code by zdroid9770
   Version 9
========================================]]--
-- % Complete: 90%

-- Defias Bandit
function DB_OnCombat(Unit, Event)
		Unit:RegisterEvent("DB_SKck", 10000, 0)
end

function DB_SKck(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		z	pUnit:FullCastSpellOnTarget(8646, plr)
	end
end

function DB_OnDied(Unit, Event)
		Unit:RemoveEvents()
end

function DB_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

RegisterUnitEvent(116, 1, "DB_OnCombat")
RegisterUnitEvent(116, 2, "DB_OnLeaveCombat")
RegisterUnitEvent(116, 4, "DB_OnDied")


-- Defias Bodyguard
function DB_OnCombat(Unit, Event)
	Unit:RegisterEvent("DB_BS", 5000, 0)
	Unit:RegisterEvent("DB_Dis", 15000, 0)
end

function DB_BS(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7159, plr)
	end
end

function DB_Dis(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6713, plr)
	end
end

function DB_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function DB_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(6866, 1, "DB_OnCombat")
RegisterUnitEvent(6866, 2, "DB_OnLeaveCombat")
RegisterUnitEvent(6866, 4, "DB_OnDied")


--[[ Defias Cutpurse
function DC_OnCombat(Unit, Event)
	Unit:RegisterEvent("DB_BSi", 5000, 0)
end

function DC_BSi(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7159, plr)
	end
end

function DC_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function DC_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(94, 1, "DC_OnCombat")
RegisterUnitEvent(94, 2, "DC_OnLeaveCombat")
RegisterUnitEvent(94, 4, "DC_OnDied")]]--


-- Defias Dockworker
function DD_OnCombat(Unit, Event)
	Unit:RegisterEvent("DD_SK", 10000, 0)
end

function DD_SK(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(8646, plr)
	end
end

function DD_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function DD_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(6927, 1, "DD_OnCombat")
RegisterUnitEvent(6927, 2, "DD_OnLeaveCombat")
RegisterUnitEvent(6927, 4, "DD_OnDied")


-- Defias Rogue Wizard
function DRW_OnCombat(Unit, Event)
	Unit:RegisterEvent("DRW_FBt", 3000, 0)
	Unit:RegisterEvent("DRW_FA", 10000, 1)
end

function DRW_FBt(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(13322, plr)
	end
end

function DRW_FA(Unit, Event)
	Unit:CastSpell(12544)
end

function DRW_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function DRW_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(474, 1, "DRW_OnCombat")
RegisterUnitEvent(474, 2, "DRW_OnLeaveCombat")
RegisterUnitEvent(474, 4, "DRW_OnDied")


-- Hogger
function Ho_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
	Unit:RegisterEvent("Ho_HBt", 20000, 0)
	Unit:RegisterEvent("Ho_PA", 45000, 0)
end

function Ho_HBt(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(13322, plr)
	end
end

function Ho_PA(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(13322, plr)
	end
end

function Ho_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function HO_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(448, 1, "Ho_OnCombat")
RegisterUnitEvent(448, 4, "Ho_OnDied")
RegisterUnitEvent(448, 2, "HO_OnLeaveCombat")


-- Kobold Geomancer
function KG_OnCombat(Unit, Event)
	Unit:RegisterEvent("KG_FBl", 3000, 0)
	Unit:RegisterEvent("KG_FAA", 10000, 1)
end

function KG_FBl(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20793, plr)
	end
end

function KG_FAA(Unit, Event)
	Unit:CastSpell(12544)
end

function KG_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function KG_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(476, 1, "KG_OnCombat")
RegisterUnitEvent(476, 2, "KG_OnLeaveCombat")
RegisterUnitEvent(476, 4, "KG_OnDied")


-- Kobold Miner
function KM_OnCombat(Unit, Event)
	Unit:RegisterEvent("KM_FBl", 45000, 0)
end

function KM_FBl(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6016, plr)
	end
end

function KM_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function KM_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(40, 1, "KM_OnCombat")
RegisterUnitEvent(40, 2, "KM_OnLeaveCombat")
RegisterUnitEvent(40, 4, "KM_OnDied")


-- Morgaine the Sly
function MTS_OnCombat(Unit, Event)
	Unit:RegisterEvent("MTS_Gouge", 10000, 0)
end

function MTS_Gouge(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(1776, plr)
	end
end

function MTS_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function MTS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(99, 1, "MTS_OnCombat")
RegisterUnitEvent(99, 2, "MTS_OnLeaveCombat")
RegisterUnitEvent(99, 4, "MTS_OnDied")


-- Morgan the Collector
function MTC_OnCombat(Unit, Event)
	Unit:RegisterEvent("MTC_Gougei", 10000, 0)
end

function MTC_Gougei(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(1776, plr)
	end
end

function MTC_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function MTC_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(473, 1, "MTC_OnCombat")
RegisterUnitEvent(473, 2, "MTC_OnLeaveCombat")
RegisterUnitEvent(473, 4, "MTC_OnDied")


-- Murloc Forager
function MF_OnCombat(Unit, Event)
	Unit:RegisterEvent("MF_DMPn", 30000, 1)
end

function MF_DMPn(Unit, Event)
	Unit:CastSpell(3368)
end

function MF_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function MF_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(46, 1, "MF_OnCombat")
RegisterUnitEvent(46, 2, "MF_OnLeaveCombat")
RegisterUnitEvent(46, 4, "MF_OnDied")


-- Murloc Lurker
function ML_OnCombat(Unit, Event)
	Unit:RegisterEvent("ML_BSu", 3000, 0)
end

function ML_BSu(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7159, plr)
	end
end

function ML_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function ML_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(732, 1, "ML_OnCombat")
RegisterUnitEvent(732, 2, "ML_OnLeaveCombat")
RegisterUnitEvent(732, 4, "ML_OnDied")



-- Narg the Taskmaster
function NTT_OnCombat(Unit, Event)
	Unit:RegisterEvent("NTT_DBS", 100, 1)
end

function NTT_DBS(Unit, Event)
	Unit:CastSpell(9128)
end

function NTT_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function NTT_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(79, 1, "NTT_OnCombat")
RegisterUnitEvent(79, 2, "NTT_OnLeaveCombat")
RegisterUnitEvent(79, 4, "NTT_OnDied")



-- Porcine Entourage
function PE_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function PE_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function PE_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(390, 1, "PE_OnCombat")
RegisterUnitEvent(390, 2, "PE_LeaveCombat")
RegisterUnitEvent(390, 4, "PE_Dead")



-- Princess
function Princess_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function Princess_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Princess_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(330, 1, "Princess_OnCombat")
RegisterUnitEvent(330, 2, "Princess_LeaveCombat")
RegisterUnitEvent(330, 4, "Princess_Dead")



-- Riverpaw Outrunner
function RPOR_OnCombat(Unit, Event)
	Unit:RegisterEvent("RPOR_Thsh", 15000, 1)
end

function RPOR_Thsh(Unit, Event)
	Unit:CastSpell(3391)
end

function RPOR_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RPOR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(478, 1, "RPOR_OnCombat")
RegisterUnitEvent(478, 2, "RPOR_OnLeaveCombat")
RegisterUnitEvent(478, 4, "RPOR_OnDied")


-- Rockhide Boar
function RB_OnCombat(Unit, Event)
	Unit:CastSpell(6268)
end

function RB_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function RB_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(524, 1, "RB_OnCombat")
RegisterUnitEvent(524, 2, "RB_LeaveCombat")
RegisterUnitEvent(524, 4, "RB_Dead")



-- Rogue Black Drake
function RBD_OnCombat(Unit, Event)
	Unit:RegisterEvent("RBD_FlameB", 15000, 0)
end

function RBD_FlameB(Unit, Event)
	Unit:FullCastSpell(8873)
end

function RBD_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RBD_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(14388, 1, "RBD_OnCombat")
RegisterUnitEvent(14388, 2, "RBD_OnLeaveCombat")
RegisterUnitEvent(14388, 4, "RBD_OnDied")



-- Surena Caledon
function SC_OnCombat(Unit, Event)
	Unit:RegisterEvent("SC_Fireball", 3000, 0)
	Unit:RegisterEvent("SC_FrostArmor", 10000, 1)
end

function SC_FrostArmor(Unit, Event)
	Unit:FullCastSpell(12544)
end

function ML_Fireball(pUnit, Event)
local plr = 	pUnit:GetMainTank()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20793, plr)
	end
end

function SC_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function SC_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(881, 1, "SC_OnCombat")
RegisterUnitEvent(881, 2, "SC_OnLeaveCombat")
RegisterUnitEvent(881, 4, "SC_OnDied")


--        ##### ##         ##### ##          ##### ##        ##### ##   
--     /#####  /##      ######  /###      /#####  /##     ######  /##   
--   //    /  / ###    /#   /  /  ###   //    /  / ###   /#   /  / ##   
--  /     /  /   ###  /    /  /    ### /     /  /   ### /    /  /  ##   
--       /  /     ###     /  /      ##      /  /     ###    /  /   /    
--      ## ##      ##    ## ##      ##     ## ##      ##   ## ##  /     
--      ## ##      ##    ## ##      ##     ## ##      ##   ## ## /      
--      ## ##      ##  /### ##      /      ## ##      ##   ## ##/       
--      ## ##      ## / ### ##     /       ## ##      ##   ## ## ###    
--      ## ##      ##    ## ######/        ## ##      ##   ## ##   ###  
--      #  ##      ##    ## ######         #  ##      ##   #  ##     ## 
--         /       /     ## ##                /       /       /      ## 
--    /###/       /      ## ##           /###/       /    /##/     ###  
--   /   ########/       ## ##          /   ########/    /  ########    
--  /       ####    ##   ## ##         /       ####     /     ####      
--  #              ###   #  /          #                #               
--   ##             ###    /            ##               ##             
--                  #####/                                             
--                    ###               www.DPS-DB.com         

-- Matt
MATT = {}

function MATT_onDied(Unit, event, player)
	Unit:RemoveEvents()
end

function MATT_onSpawn(Unit, event, player)
	Unit:RegisterEvent("MATT_Say",30000, 0)
end

function MATT_Say(Unit, event, player)
	Unit:SendChatMessage(12, 7, "Dang! Fish arent biting here either! Im gonna go back to my ol' fishin' hole" )
end

-- Matt
RegisterUnitEvent(794, 18, "MATT_onSpawn")
RegisterUnitEvent(794, 4, "MATT_onDied")