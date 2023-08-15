--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

-- CaptainMelrache
function CaptainMelrache_OnCombat(Unit, Event)
	Unit:RegisterEvent("CaptainMelrache_Strike", 5000, 0)
	Unit:RegisterEvent("CaptainMelrache_DevotationAura", 1000, 1)
end

function CaptainMelrache_Strike(pUnit, Event)
	pUnit:CastSpellOnTarget(11976, p	Unit:GetClosestPlayer())
end

function CaptainMelrache_DevotationAura(Unit, Event)
	Unit:CastSpell(8258)
end

function CaptainMelrache_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function CaptainMelrache_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1665, 1, "CaptainMelrache_OnCombat")
RegisterUnitEvent(1665, 2, "CaptainMelrache_OnLeaveCombat")
RegisterUnitEvent(1665, 4, "CaptainMelrache_OnDead")

-- DarkeyeBonecaster
function DarkeyeBonecaster_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkeyeBonecaster_FrostBolt", 4000, 0)
end

function DarkeyeBonecaster_FrostBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(13322, p	Unit:GetClosestPlayer())
end

function DarkeyeBonecaster_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function DarkeyeBonecaster_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1522, 1, "DarkeyeBonecaster_OnCombat")
RegisterUnitEvent(1522, 2, "DarkeyeBonecaster_OnLeaveCombat")
RegisterUnitEvent(1522, 4, "DarkeyeBonecaster_OnDead")

-- FallenHero                   - A level 58 - 60 elite that is in 3 different zones... 
function FallenHero_OnCombat(Unit, Event)
	Unit:RegisterEvent("FallenHero_Shout", 15000, 1)
	Unit:RegisterEvent("FallenHero_MortalStrike", 8000, 0)
	Unit:RegisterEvent("FallenHero_SnapKick", 21000, 0)
end

function FallenHero_Shout(pUnit, Event)
	pUnit:FullCastSpell(18328)
end

function FallenHero_MortalStrike(pUnit, Event)
	pUnit:FullCastSpellOnTarget(19643, p	Unit:GetClosestPlayer())
end

function FallenHero_SnapKick(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15618, p	Unit:GetClosestPlayer())
end

function FallenHero_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function FallenHero_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(10996, 1, "FallenHero_OnCombat")
RegisterUnitEvent(10996, 2, "FallenHero_OnLeaveCombat")
RegisterUnitEvent(10996, 4, "FallenHero_OnDead")

-- FarmerSolliden
function FarmerSolliden_OnCombat(Unit, Event)
	Unit:RegisterEvent("FarmerSolliden_Strike", 5000, 0)
end

function FarmerSolliden_Strike(pUnit, Event)
	pUnit:CastSpellOnTarget(11976, p	Unit:GetClosestPlayer())
end

function FarmerSolliden_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function FarmerSolliden_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1936, 1, "FarmerSolliden_OnCombat")
RegisterUnitEvent(1936, 2, "FarmerSolliden_OnLeaveCombat")
RegisterUnitEvent(1936, 4, "FarmerSolliden_OnDead")

-- HungeringDead / RavagedCorpse / RottingDead
function HungeringDead_OnCombat(Unit, Event)
	Unit:RegisterEvent("HungeringDead_DiseaseTouch", math.random(8000,42000), 1)
end

function HungeringDead_DiseaseTouch(pUnit, Event)
	pUnit:CastSpellOnTarget(3234, p	Unit:GetClosestPlayer())
end

function HungeringDead_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function HungeringDead_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1527, 1, "HungeringDead_OnCombat")
RegisterUnitEvent(1527, 2, "HungeringDead_OnLeaveCombat")
RegisterUnitEvent(1527, 4, "HungeringDead_OnDead")
RegisterUnitEvent(1526, 1, "HungeringDead_OnCombat")
RegisterUnitEvent(1526, 2, "HungeringDead_OnLeaveCombat")
RegisterUnitEvent(1526, 4, "HungeringDead_OnDead")
RegisterUnitEvent(1525, 1, "HungeringDead_OnCombat")
RegisterUnitEvent(1525, 2, "HungeringDead_OnLeaveCombat")
RegisterUnitEvent(1525, 4, "HungeringDead_OnDead")

--[[
SCARLET PEOPLE:
--]]
-- Scarlet Augur
function ScarletAugur_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletAugur_ShadowBolt", 3000, 1)
end

function ScarletAugur_ShadowBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9613, p	Unit:GetClosestPlayer())
end

function ScarletAugur_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletAugur_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4284, 1, "ScarletAugur_OnCombat")
RegisterUnitEvent(4284, 2, "ScarletAugur_OnLeaveCombat")
RegisterUnitEvent(4284, 4, "ScarletAugur_OnDead")

-- Scarlet BodyGuard
function ScarletBodyGuard_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletBodyGuard_ShieldBlock", 7000, 1)
end

function ScarletBodyGuard_ShieldBlock(Unit, Event)
	pUnit:FullCastSpell(12169)
end

function ScarletBodyGuard_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletBodyGuard_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1660, 1, "ScarletBodyGuard_OnCombat")
RegisterUnitEvent(1660, 2, "ScarletBodyGuard_OnLeaveCombat")
RegisterUnitEvent(1660, 4, "ScarletBodyGuard_OnDead")

-- Scarlet Disciple
function ScarletDisciple_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletDisciple_HolySmight", 5000, 5)
end

function ScarletDisciple_HolySmight(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9734, p	Unit:GetClosestPlayer())
end

function ScarletDisciple_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletDisciple_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4285, 1, "ScarletDisciple_OnCombat")
RegisterUnitEvent(4285, 2, "ScarletDisciple_OnLeaveCombat")
RegisterUnitEvent(4285, 4, "ScarletDisciple_OnDead")

-- Scarlet Magician
function ScarletMagician_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletMagician_Fireball", 3000, 0)
end

function ScarletMagician_Fireball(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9053, p	Unit:GetClosestPlayer())
end

function ScarletMagician_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletMagician_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4282, 1, "ScarletMagician_OnCombat")
RegisterUnitEvent(4282, 2, "ScarletMagician_OnLeaveCombat")
RegisterUnitEvent(4282, 4, "ScarletMagician_OnDead")

-- Scarlet Neophyte
function ScarletNeophyte_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletNeophyte_Frostbolt", 3000, 0)
	Unit:RegisterEvent("ScarletNeophyte_FrostArmor", 500, 1)
end

function ScarletNeophyte_Frostbolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(13322, pUnit:GetClosestPlayer())
end

function ScarletNeophyte_FrostArmor(pUnit, Event)
	pUnit:FullCastSpell(12544)
end

function ScarletNeophyte_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletNeophyte_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1539, 1, "ScarletNeophyte_OnCombat")
RegisterUnitEvent(1539, 2, "ScarletNeophyte_OnLeaveCombat")
RegisterUnitEvent(1539, 4, "ScarletNeophyte_OnDead")

-- Scarlet Preserver
function ScarletPreserver_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletPreserver_HolyStrike", 6000, 0)
	Unit:RegisterEvent("ScarletPreserver_HolyLight", 18000, 1)
end

function ScarletPreserver_HolyStrike(pUnit, Event)
	pUnit:FullCastSpellOnTarget(13953, pUnit:GetClosestPlayer())
end

function ScarletPreserver_HolyLight(pUnit, Event)
	pUnit:FullCastSpell(13952)
end

function ScarletPreserver_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletPreserver_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(4280, 1, "ScarletPreserver_OnCombat")
RegisterUnitEvent(4280, 2, "ScarletPreserver_OnLeaveCombat")
RegisterUnitEvent(4280, 4, "ScarletPreserver_OnDead")

-- Scarlet Vanguard
function ScarletVanguard_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletVanguard_ShieldBash", 9000, 5)
	Unit:RegisterEvent("ScarletVanguard_DefensiveStance", 500, 1)
end

function ScarletVanguard_ShieldBash(pUnit, Event)
	pUnit:FullCastSpellOnTarget(13953, pUnit:GetClosestPlayer())
end

function ScarletVanguard_DefensiveStance(pUnit, Event)
	pUnit:FullCastSpell(13952)
end

function ScarletVanguard_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletVanguard_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1540, 1, "ScarletVanguard_OnCombat")
RegisterUnitEvent(1540, 2, "ScarletVanguard_OnLeaveCombat")
RegisterUnitEvent(1540, 4, "ScarletVanguard_OnDead")

-- Scarlet Warrior
function ScarletWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("ScarletWarrior_Strike", 7000, 1)
end

function ScarletWarrior_Strike(pUnit, Event)
	pUnit:CastSpell(3238)
end

function ScarletWarrior_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ScarletWarrior_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1535, 1, "ScarletWarrior_OnCombat")
RegisterUnitEvent(1535, 2, "ScarletWarrior_OnLeaveCombat")
RegisterUnitEvent(1535, 4, "ScarletWarrior_OnDead")

--[[ 
Others:
--]]

-- VampiricDuskBat
function VampiricDuskBat_OnCombat(Unit, Event)
	Unit:RegisterEvent("VampiricDuskBat_Ravage", 8000, 0)
end

function VampiricDuskBat_Ravage(pUnit, Event)
	pUnit:FullCastSpellOnTarget(3242, pUnit:GetClosestPlayer())
end

function VampiricDuskBat_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function VampiricDuskBat_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1554, 1, "VampiricDuskBat_OnCombat")
RegisterUnitEvent(1554, 2, "VampiricDuskBat_OnLeaveCombat")
RegisterUnitEvent(1554, 4, "VampiricDuskBat_OnDead")

-- ViciousNightWebSpider
function ViciousNightWebSpider_OnCombat(Unit, Event)
	Unit:RegisterEvent("ViciousNightWebSpider_Poison", 8000, 1)
end

function ViciousNightWebSpider_Poison(pUnit, Event)
	pUnit:FullCastSpellOnTarget(744, pUnit:GetClosestPlayer())
end

function ViciousNightWebSpider_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function ViciousNightWebSpider_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(1555, 1, "ViciousNightWebSpider_OnCombat")
RegisterUnitEvent(1555, 2, "ViciousNightWebSpider_OnLeaveCombat")
RegisterUnitEvent(1555, 4, "ViciousNightWebSpider_OnDead")
