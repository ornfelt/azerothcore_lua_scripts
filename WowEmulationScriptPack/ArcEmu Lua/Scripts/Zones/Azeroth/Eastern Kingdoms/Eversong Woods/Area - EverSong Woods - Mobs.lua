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

-- // Eversong Woods by Yerney // --

-- Amani Axe Thrower --
function AmaniAxe_OnCombat(pUnit, Event)
pUnit:RegisterEvent("AmaniAxe_Throw", 3000, 0)
end

function AmaniAxe_Throw(pUnit, Event)
pUnit:FullCastSpellOnTarget(10277, pUnit:GetClosestPlayer())
end

function AmaniAxe_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function AmaniAxe_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15641, 1, "AmaniAxe_OnCombat")
RegisterUnitEvent(15641, 2, "AmaniAxe_LeaveCombat")
RegisterUnitEvent(15641, 4, "AmaniAxe_Dead")

-- Amani Berserker --
function AmaniBerserker_OnCombat(pUnit, Event)
pUnit:RegisterEvent("AmaniBerserker_Enrage", 7000, 1)
end

function AmaniBerserker_Enrage(pUnit, Event)
pUnit:FullCastSpell(8599)
end

function AmaniBerserker_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function AmaniBerserker_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15643, 1, "AmaniBerserker_OnCombat")
RegisterUnitEvent(15643, 2, "AmaniBerserker_LeaveCombat")
RegisterUnitEvent(15643, 4, "AmaniBerserker_Dead")

-- Amani ShadowPriest --
function AmaniPriest_OnCombat(pUnit, Event)
pUnit:RegisterEvent("AmaniPriest_Pain", 6000, 1)
end

function AmaniPriest_Pain(pUnit, Event)
pUnit:FullCastSpellOnTarget(11639, pUnit:GetClosestPlayer())
end

function AmaniPriest_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function AmaniPriest_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15642, 1, "AmaniPriest_OnCombat")
RegisterUnitEvent(15642, 2, "AmaniPriest_LeaveCombat")
RegisterUnitEvent(15642, 4, "AmaniPriest_Dead")

-- AngerShade --
function AngerShade_OnCombat(pUnit, Event)
pUnit:RegisterEvent("AngerShade_Enrage", 7000, 1)
end

function AngerShade_Enrage(pUnit, Event)
pUnit:FullCastSpell(8599)
end

function AngerShade_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function AngerShade_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15656, 1, "AngerShade_OnCombat")
RegisterUnitEvent(15656, 2, "AngerShade_LeaveCombat")
RegisterUnitEvent(15656, 4, "AngerShade_Dead")

-- Arcane Wraith --
function ArcaneWraith_OnCombat(pUnit, Event)
pUnit:RegisterEvent("ArcaneWraith_ArcaneBolt", 4000, 0)
end

function ArcaneWraith_ArcaneBolt(pUnit, Event)
pUnit:FullCastSpellOnTarget(37361, pUnit:GetClosestPlayer())
end

function ArcaneWraith_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function ArcaneWraith_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15273, 1, "ArcaneWraith_OnCombat")
RegisterUnitEvent(15273, 2, "ArcaneWraith_LeaveCombat")
RegisterUnitEvent(15273, 4, "ArcaneWraith_Dead")

-- DarkWraith --
function DarkWraith_OnCombat(pUnit, Event)
pUnit:RegisterEvent("DarkWraith_Enrage", 7000, 1)
end

function DarkWraith_Enrage(pUnit, Event)
pUnit:FullCastSpell(8599)
end

function DarkWraith_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function DarkWraith_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15657, 1, "DarkWraith_OnCombat")
RegisterUnitEvent(15657, 2, "DarkWraith_LeaveCombat")
RegisterUnitEvent(15657, 4, "DarkWraith_Dead")

-- Feral Tender --
function FeralTen_OnCombat(pUnit, Event)
pUnit:RegisterEvent("FeralTen_Renew", 9000, 1)
end

function FeralTen_Renew(pUnit, Event)
pUnit:FullCastSpell(31325)
end

function FeralTen_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function FeralTen_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15294, 1, "FeralTen_OnCombat")
RegisterUnitEvent(15294, 2, "FeralTen_LeaveCombat")
RegisterUnitEvent(15294, 4, "FeralTen_Dead")

-- ManaSerpent --
function ManaSerpent_OnCombat(pUnit, Event)
pUnit:RegisterEvent("ManaSerpent_FairieFire", 4000, 1)
end

function ManaSerpent_FairieFire(pUnit, Event)
pUnit:FullCastSpellOnTarget(25602, pUnit:GetClosestPlayer())
end

function ManaSerpent_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function ManaSerpent_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15966, 1, "ManaSerpent_OnCombat")
RegisterUnitEvent(15966, 2, "ManaSerpent_LeaveCombat")
RegisterUnitEvent(15966, 4, "ManaSerpent_Dead")

-- Mana Stalker--
function ManaStalker_OnCombat(pUnit, Event)
pUnit:RegisterEvent("ManaStalker_MoonFire", 4000, 1)
end

function ManaStalker_MoonFire(pUnit, Event)
pUnit:FullCastSpellOnTarget(25602, pUnit:GetClosestPlayer())
end

function ManaStalker_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function ManaStalker_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15647, 1, "ManaStalker_OnCombat")
RegisterUnitEvent(15647, 2, "ManaStalker_LeaveCombat")
RegisterUnitEvent(15647, 4, "ManaStalker_Dead")

-- ManaWraith --
function ManaWraith_OnCombat(pUnit, Event)
pUnit:RegisterEvent("ManaWraith_FairieFire", 4000, 1)
end

function ManaWraith_FairieFire(pUnit, Event)
pUnit:FullCastSpellOnTarget(25602, pUnit:GetClosestPlayer())
end

function ManaWraith_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function ManaWraith_Dead(pUnit, Event)
pUnit:CastSpell(29109)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15648, 1, "ManaWraith_OnCombat")
RegisterUnitEvent(15648, 2, "ManaWraith_LeaveCombat")
RegisterUnitEvent(15648, 4, "ManaWraith_Dead")

-- PlagueBonePillager --
function PlagueBonePillager_OnCombat(pUnit, Event)
pUnit:RegisterEvent("PlagueBonePillager_Strike", 5000, 0)
end

function PlagueBonePillager_Strike(pUnit, Event)
pUnit:FullCastSpellOnTarget(11976, pUnit:GetClosestPlayer())
end

function PlagueBonePillager_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function PlagueBonePillager_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15654, 1, "PlagueBonePillager_OnCombat")
RegisterUnitEvent(15654, 2, "PlagueBonePillager_LeaveCombat")
RegisterUnitEvent(15654, 4, "PlagueBonePillager_Dead")

-- RotlimbMarauder --
function RotlimbMarauder_OnCombat(pUnit, Event)
pUnit:RegisterEvent("RotlimbMarauder_DiseaseTouch", 5000, 1)
end

function RotlimbMarauder_DiseaseTouch(pUnit, Event)
pUnit:FullCastSpellOnTarget(3234, pUnit:GetClosestPlayer())
end

function RotlimbMarauder_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function RotlimbMarauder_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15658, 1, "RotlimbMarauder_OnCombat")
RegisterUnitEvent(15658, 2, "RotlimbMarauder_LeaveCombat")
RegisterUnitEvent(15658, 4, "RotlimbMarauder_Dead")

-- WitheredGreenKeeper --
function WitheredGreenKeeper_OnCombat(pUnit, Event)
pUnit:RegisterEvent("WitheredGreenKeeper_Strike", 5000, 0)
end

function WitheredGreenKeeper_Strike(pUnit, Event)
pUnit:FullCastSpellOnTarget(13584, pUnit:GetClosestPlayer())
end

function WitheredGreenKeeper_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function WitheredGreenKeeper_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15637, 1, "WitheredGreenKeeper_OnCombat")
RegisterUnitEvent(15637, 2, "WitheredGreenKeeper_LeaveCombat")
RegisterUnitEvent(15637, 4, "WitheredGreenKeeper_Dead")

-- WrecthedHooligan --
function WrecthedHooligan_OnCombat(pUnit, Event)
pUnit:RegisterEvent("WrecthedHooligan_Strike", 5000, 0)
pUnit:RegisterEvent("WrecthedHooligan_Bitter", 12000, 1)
end

function WrecthedHooligan_Strike(pUnit, Event)
pUnit:FullCastSpellOnTarget(14873, pUnit:GetClosestPlayer())
end

function WrecthedHooligan_Bitter(pUnit, Event)
pUnit:FullCastSpellOnTarget(29098, pUnit:GetClosestPlayer())
end


function WrecthedHooligan_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function WrecthedHooligan_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(16162, 1, "WrecthedHooligan_OnCombat")
RegisterUnitEvent(16162, 2, "WrecthedHooligan_LeaveCombat")
RegisterUnitEvent(16162, 4, "WrecthedHooligan_Dead")

-- WrecthedThug --
function WrecthedThug_OnCombat(pUnit, Event)
pUnit:RegisterEvent("WrecthedHooligan_Strike", 5000, 0)
pUnit:RegisterEvent("WrecthedThug_Bitter", 12000, 1)
end

function WrecthedThug_Bitter(pUnit, Event)
pUnit:FullCastSpellOnTarget(29098, pUnit:GetClosestPlayer())
end

function WrecthedThug_LeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function WrecthedThug_Dead(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(15645, 1, "WrecthedThug_OnCombat")
RegisterUnitEvent(15645, 2, "WrecthedThug_LeaveCombat")
RegisterUnitEvent(15645, 4, "WrecthedThug_Dead")



