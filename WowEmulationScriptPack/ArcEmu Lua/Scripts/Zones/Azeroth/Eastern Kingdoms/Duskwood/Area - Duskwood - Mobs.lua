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
-- Duskwood//LASP - Gnoppy//v1

-- Black Ravager
function BlackRavager_OnCombat(Unit, Event)
Unit:RegisterEvent("blRav_Spellname", 7000, 0)
end

function blRav_Spellname(pUnit, Event)
pUnit:CastSpellOnTarget(13443, pUnit:GetClosestPlayer()) 
end

function blRav_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function blRav_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(628, 1, "BlackRavager_OnCombat")
RegisterUnitEvent(628, 2, "blRav_OnLeaveCombat")
RegisterUnitEvent(638, 4, "blRav_OnDied")

-- Black Ravager Mastiff
function brm_OnCombat(Unit, Event)
Unit:RegisterEvent("brm_Rend", 7500, 0)
Unit:RegisterEvent("brm_Furious", 12000, 1)
end

function brm_Rend(pUnit, Event)
pUnit:CastSpellOnTarget(13443, pUnit:GetClosestPlayer()) 
end

function brm_Furious(pUnit, Event)
pUnit:CastSpell(3149)
end

function brm_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function brm_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(1258, 1, "brm_OnCombat")
RegisterUnitEvent(1258, 2, "brm_OnLeaveCombat")
RegisterUnitEvent(1258, 4, "brm_OnDied")

--Black Widow HatchLing
function bvh_OnCombat(Unit, Event)
Unit:RegisterEvent("bvh_Bite", 8000, 1)
Unit:RegisterEvent("bvh_Poison", 14000, 1)
end

function bvh_Bite(pUnit, Event)
pUnit:CastSpellOnTarget(7367, pUnit:GetClosestPlayer()) 
end

function bvh_Poison(pUnit, Event)
pUnit:CastSpellOnTarget(744, pUnit:GetClosestPlayer())
end

function bvh_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function bvh_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(930, 1, "bvh_OnCombat")
RegisterUnitEvent(930, 2, "bvh_OnLeaveCombat")
RegisterUnitEvent(930, 4, "bvh_OnDied")

--Bone Chewer
function bec_OnCombat(Unit, Event)
Unit:RegisterEvent("bec_Armor", 7000, 1)
end

function bec_Armor(pUnit, Event)
pUnit:CastSpellOnTarget(6016, pUnit:GetClosestPlayer()) 
end

function bec_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function bec_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(210, 1, "bec_OnCombat")
RegisterUnitEvent(210, 2, "bec_OnLeaveCombat")
RegisterUnitEvent(210, 4, "bec_OnDied")

--Brain Eater
function bre_OnCombat(Unit, Event)
Unit:RegisterEvent("bre_Plague", 7500, 1)
end

function bre_Plague(pUnit, Event)
pUnit:FullCastSpellOnTarget(3429, pUnit:GetClosestPlayer()) 
end

function bre_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function bre_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

-- Carrion Recluse
RegisterUnitEvent(570, 1, "bre_OnCombat")
RegisterUnitEvent(570, 2, "bre_OnLeaveCombat")
RegisterUnitEvent(570, 4, "bre_OnDied")

function crr_OnCombat(Unit, Event)
Unit:RegisterEvent("crr_Paral", 9000, 1)
end

function crr_Paral(pUnit, Event)
pUnit:CastSpellOnTarget(3609, pUnit:GetClosestPlayer()) 
end

function crr_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function crr_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(949, 1, "crr_OnCombat")
RegisterUnitEvent(949, 2, "crr_OnLeaveCombat")
RegisterUnitEvent(949, 4, "crr_OnDied")

--Commander Felstrom
function cmf_OnCombat(Unit, Event)
Unit:RegisterEvent("cmf_Ress", 1000, 0)
end

function cmf_Ress(pUnit, Event)
if pUnit:GetHealthPct() < 10 then
pUnit:CastSpell(3488)
end
end

function cmf_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function cmf_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(771, 1, "cmf_OnCombat")
RegisterUnitEvent(771, 2, "cmf_OnLeaveCombat")
RegisterUnitEvent(711, 4, "cmf_OnDied")

--Defias Enchanter
function dse_OnCombat(Unit, Event)
Unit:RegisterEvent("dse_Enchanted", 9000, 1)
Unit:RegisterEvent("dse_FireBall", 3000, 0)
end

function dse_Enchantend(pUnit, Event)
pUnit:FullCastSpell(3443) 
end

function dse_FireBall(pUnit, Event)
pUnit:FullCastSpellOnTarget(20811, pUnit:GetClosestPlayer())
end

function dse_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function dse_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(910, 1, "dse_OnCombat")
RegisterUnitEvent(910, 2, "dse_OnLeaveCombat")
RegisterUnitEvent(910, 4, "dse_OnDied")

--Defias NightBlade
function dnb_OnCombat(Unit, Event)
Unit:RegisterEvent("dnb_Backstab", 5000, 2)
Unit:RegisterEvent("dnb_Poison", 10000, 1)
end

function dnb_Backstab(pUnit, Event)
pUnit:CastSpellOnTarget(2589, pUnit:GetClosestPlayer()) 
end

function dnb_Poison(pUnit, Event)
pUnit:CastSpellOnTarget(744, pUnit:GetClosestPlayer())
end

function dnb_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function dnb_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(909, 1, "dnb_OnCombat")
RegisterUnitEvent(909, 2, "dnb_OnLeaveCombat")
RegisterUnitEvent(909, 4, "dnb_OnDied")

-- Defias NightRunner
function dnr_OnCombat(Unit, Event)
Unit:RegisterEvent("dnr_Spellname", 5000, 0)
end

function dnr_Spellname(pUnit, Event)
pUnit:FullCastSpellOnTarget(2589, pUnit:GetClosestPlayer()) 
end

function dnr_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function dnr_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(215, 1, "dnr_OnCombat")
RegisterUnitEvent(215, 2, "dnr_OnLeaveCombat")
RegisterUnitEvent(215, 4, "dnr_OnDied")

-- Eliza 
function eli_OnCombat(Unit, Event)
Unit:RegisterEvent("eli_FrostNova", 8000, 1)
Unit:RegisterEvent("eli_FrostBolt", 3000, 0)
Unit:RegisterEvent("eli_Summon", 14000, 1)
end

function eli_FrostNova(pUnit, Event)
pUnit:CastSpellOnTarget(11831, pUnit:GetClosestPlayer()) 
end

function eli_FrostBolt(pUnit, Event)
pUnit:CastSpellOnTarget(20819, pUnit:GetClosestPlayer())
end

function eli_Summon(pUnit, Event)
pUnit:FullCastSpell(3107)
end

function eli_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function eli_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(314, 1, "eli_OnCombat")
RegisterUnitEvent(314, 2, "eli_OnLeaveCombat")
RegisterUnitEvent(314, 4, "eli_OnDied")

-- Fetid Corpse
function fcp_OnCombat(Unit, Event)
Unit:RegisterEvent("fcp_Spellname", 8000, 1)
end

function fcp_Spellname(pUnit, Event)
pUnit:FullCastSpellOnTarget(7102, pUnit:GetClosestPlayer()) 
end

function fcp_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function fcp_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(1270, 1, "fcp_OnCombat")
RegisterUnitEvent(1270, 2, "fcp_OnLeaveCombat")
RegisterUnitEvent(1270, 4, "fcp_OnDied")

-- Grave Robber
function grb_OnCombat(Unit, Event)
Unit:RegisterEvent("grb_Backstab", 7000, 0)
end

function grb_Backstab(pUnit, Event)
pUnit:CastSpellOnTarget(6595, pUnit:GetClosestPlayer()) 
end

function grb_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function grb_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(218, 1, "grb_OnCombat")
RegisterUnitEvent(218, 2, "grb_OnLeaveCombat")
RegisterUnitEvent(218, 4, "grb_OnDied")

--Green recluse
function grr_OnCombat(Unit, Event)
Unit:RegisterEvent("grr_Poison", 7000, 1)
end

function grr_Poison(pUnit, Event)
pUnit:CastSpellOnTarget(744, pUnit:GetClosestPlayer()) 
end

function grr_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function grr_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(569, 1, "grr_OnCombat")
RegisterUnitEvent(569, 2, "grr_OnLeaveCombat")
RegisterUnitEvent(569, 4, "grr_OnDied")

-- Gutspill
function gsp_OnCombat(Unit, Event)
Unit:RegisterEvent("gsp_Spellname", 7000, 1)
end

function gsp_Spellname(pUnit, Event)
pUnit:CastSpell(3424) 
end

function gsp_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function gsp_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(6170, 1, "gsp_OnCombat")
RegisterUnitEvent(6170, 2, "gsp_OnLeaveCombat")
RegisterUnitEvent(6170, 4, "gsp_OnDied")

-- Rotten one 
function rte_OnDied(Unit, Event)
x =	Unit:GetX()
y =	Unit:GetY()
z =	Unit:GetZ()
o =	Unit:GetO()
Unit:SpawnCreature(2462, x, y, z, o, 14, 600000)
end

RegisterUnitEvent(948, 4, "rte_OnDied")

--Skeletal Fiend
function slf_OnCombat(Unit, Event)
Unit:RegisterEvent("slf_Spellname", 4000, 1)
end

function slf_Spellname(pUnit, Event)
pUnit:CastSpell(3416) 
end

function slf_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function slf_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(531, 1, "slf_OnCombat")
RegisterUnitEvent(531, 2, "slf_OnLeaveCombat")
RegisterUnitEvent(531, 4, "slf_OnDied")

--Skeletal Healer
function slh_OnCombat(Unit, Event)
Unit:RegisterEvent("slh_Heal", 15000, 1)
Unit:RegisterEvent("slh_Bolt", 3000, 0)
end

function slh_Heal(pUnit, Event)
pUnit:FullCastSpell(2054) 
end

function slh_Bolt(pUnit, Event)
pUnit:CastSpellOnTarget(9613, pUnit:GetClosestPlayer()) 
end

function slh_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function slh_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(787, 1, "slh_OnCombat")
RegisterUnitEvent(787, 2, "slh_OnLeaveCombat")
RegisterUnitEvent(787, 4, "slh_OnDied")

-- Skeletal Horror
function slo_OnCombat(Unit, Event)
Unit:RegisterEvent("slo_Fear", 7000, 2)
end

function slo_Fear(pUnit, Event)
pUnit:CastSpellOnTarget(7399, pUnit:GetClosestPlayer()) 
end

function slo_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function slo_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(202, 1, "slo_OnCombat")
RegisterUnitEvent(202, 2, "slo_OnLeaveCombat")
RegisterUnitEvent(202, 4, "slo_OnDied")

-- Skeletal Mage
function slm_OnCombat(Unit, Event)
Unit:RegisterEvent("slm_Armor", 1000, 1)
Unit:RegisterEvent("slm_FrostBolt", 3000, 0)
end

function slm_Armor(pUnit, Event)
pUnit:CastSpell(12544) 
end

function slm_FrostBolt(pUnit, Event)
pUnit:FullCastSpellOnTarget(20792, pUnit:GetClosestPlayer()) 
end

function slm_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function slm_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(203, 1, "slm_OnCombat")
RegisterUnitEvent(203, 2, "slm_OnLeaveCombat")
RegisterUnitEvent(203, 4, "slm_OnDied")

--Skeletal Warder
function slw_OnCombat(Unit, Event)
Unit:RegisterEvent("slw_Spellname", 6000, 1)
Unit:RegisterEvent("slw_Spelltwo", 12000, 1)
end

function slw_Spellname(pUnit, Event)
pUnit:CastSpell(4979) 
end

function slw_Spelltwo(pUnit, Event)
pUnit:CastSpell(8999) 
end

function slw_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function slw_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(785, 1, "slw_OnCombat")
RegisterUnitEvent(785, 2, "slw_OnLeaveCombat")
RegisterUnitEvent(785, 4, "slw_OnDied")

-- Skeletal Warrior
function sla_OnCombat(Unit, Event)
Unit:RegisterEvent("sla_Stance", 1000, 1)
Unit:RegisterEvent("sla_Hamstring", 10000, 3)
end

function sla_Stance(pUnit, Event)
pUnit:CastSpell(7165) 
end

function sla_Hamstring(pUnit, Event)
pUnit:FullCastSpellOnTarget(9080, pUnit:GetClosestPlayer()) 
end

function sla_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function sla_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(48, 1, "sla_OnCombat")
RegisterUnitEvent(48, 2, "sla_OnLeaveCombat")
RegisterUnitEvent(48, 4, "sla_OnDied")

--Splinter Fist Enslaver
function sfe_OnCombat(Unit, Event)
Unit:RegisterEvent("sfe_Net", 7000, 1)
Unit:RegisterEvent("sfe_Throw", 3000, 7)
end

function sfe_Net(pUnit, Event)
pUnit:CastSpellOnTarget(6533, pUnit:GetClosestPlayer()) 
end

function sfe_Throw(pUnit, Event)
pUnit:CastSpellOnTarget(10277, pUnit:GetClosestPlayer()) 
end

function sfe_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function sfe_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(1487, 1, "sfe_OnCombat")
RegisterUnitEvent(1487, 2, "sfe_OnLeaveCombat")
RegisterUnitEvent(1487, 4, "sfe_OnDied")

-- Splinter Fist Weaver
function sffw_OnCombat(Unit, Event)
Unit:RegisterEvent("sffw_Fireball", 3000, 0)
Unit:RegisterEvent("sffw_Flamestrike", 12000, 1)
end

function sffw_Fireball(pUnit, Event)
pUnit:CastSpellOnTarget(19816, pUnit:GetClosestPlayer()) 
end

function sffw_Spellname(pUnit, Event)
pUnit:FullCastSpell(20296) 
end

function sffw_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function sffw_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end


RegisterUnitEvent(891, 1, "sffw_OnCombat")
RegisterUnitEvent(891, 2, "sffw_OnLeaveCombat")
RegisterUnitEvent(891, 4, "sffw_OnDied")