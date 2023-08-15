--[[  Mobs - All-In-One.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, November 07 2008. ]]

-- Sunblade Arch Mage.
function SunbladeArchMage_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeArchMage_Arcane", 6000, 0)
	pUnit:RegisterEvent("SunbladeArchMage_FrostNova", 12000, 0)
end

function SunbladeArchMage_Arcane(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46553,pUnit:GetClosestPlayer())
end

function SunbladeArchMage_FrostNova(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46555,pUnit:GetClosestPlayer())
end

function SunbladeArchMage_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeArchMage_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25367, 1, "SunbladeArchMage_OnEnterCombat")
RegisterUnitEvent(25367, 2, "SunbladeArchMage_OnLeaveCombat")
RegisterUnitEvent(25367, 4, "SunbladeArchMage_OnDied")

-- Sunblade Cabalist.
function SunbladeCabalist_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeCabalist_Shadow", 2000, 0)
	pUnit:RegisterEvent("SunbladeCabalist_Ignite", 7000, 0)
	pUnit:RegisterEvent("SunbladeCabalist_Imp", 80000, 0)
end

function SunbladeCabalist_Shadow(pUnit,Event)
	pUnit:FullCastSpellOnTarget(47248,pUnit:GetClosestPlayer())
end

function SunbladeCabalist_Ignite(pUnit,Event)
	pUnit:FullCastSpellOnTarget(47248,pUnit:GetRandomPlayer(0))
end

function SunbladeCabalist_Imp(pUnit,Event)
	pUnit:CastSpell(46544)
end

function SunbladeCabalist_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeCabalist_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25363, 1, "SunbladeCabalist_OnEnterCombat")
RegisterUnitEvent(25363, 2, "SunbladeCabalist_OnLeaveCombat")
RegisterUnitEvent(25363, 4, "SunbladeCabalist_OnDied")

-- Sunblade Dawn Priest.
function SunbladeDawnPriest_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(46565) -- Holy Form
	pUnit:RegisterEvent("SunbladeDawnPriest_Holynova", 2000, 0)
	pUnit:RegisterEvent("SunbladeDawnPriest_Renew", 2000, 0)
end

function SunbladeDawnPriest_Holynova(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46564,pUnit:GetClosestPlayer())
end

function SunbladeDawnPriest_Renew(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46563,pUnit:GetRandomFriend())
	pUnit:CastSpell(46563)
end

function SunbladeDawnPriest_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeDawnPriest_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25371, 1, "SunbladeDawnPriest_OnEnterCombat")
RegisterUnitEvent(25371, 2, "SunbladeDawnPriest_OnLeaveCombat")
RegisterUnitEvent(25371, 4, "SunbladeDawnPriest_OnDied")

-- Sunblade Dragonhawk.
function SunbladeDragonHawk_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeDragonHawk_Breath", 3500, 0)
end

function SunbladeDragonHawk_Breath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(47251,pUnit:GetClosestPlayer())
end

function SunbladeDragonHawk_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeDragonHawk_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25867, 1, "SunbladeDragonHawk_OnEnterCombat")
RegisterUnitEvent(25867, 2, "SunbladeDragonHawk_OnLeaveCombat")
RegisterUnitEvent(25867, 4, "SunbladeDragonHawk_OnDied")

-- Sunblade Dusk Priest.
function SunbladeDuskPriest_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeDuskPriest_SWP", 30000, 0)
	pUnit:RegisterEvent("SunbladeDuskPriest_MindFlay", 20000, 0)
	pUnit:RegisterEvent("SunbladeDuskPriest_Fear", 60000, 0)
end

function SunbladeDuskPriest_SWP(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46560,pUnit:GetClosestPlayer())
end

function SunbladeDuskPriest_MindFlay(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46562,pUnit:GetClosestPlayer())
end

function SunbladeDuskPriest_Fear(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46561,pUnit:GetClosestPlayer())
end

function SunbladeDuskPriest_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeDuskPriest_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25370, 1, "SunbladeDuskPriest_OnEnterCombat")
RegisterUnitEvent(25370, 2, "SunbladeDuskPriest_OnLeaveCombat")
RegisterUnitEvent(25370, 4, "SunbladeDuskPriest_OnDied")

-- Sunblade Protector
function SunbladeProtector_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeProtector_Fel", 3000, 0)
end

function SunbladeProtector_Fel(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46480,pUnit:GetClosestPlayer())
end

function SunbladeProtector_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeProtector_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25507, 1, "SunbladeProtector_OnEnterCombat")
RegisterUnitEvent(25507, 2, "SunbladeProtector_OnLeaveCombat")
RegisterUnitEvent(25507, 4, "SunbladeProtector_OnDied")

-- Sunblade Scout
function SunbladeScout_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeScout_Strike", 6000, 0)
end

function SunbladeScout_Strike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46558,pUnit:GetClosestPlayer())
end

function SunbladeScout_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeScout_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25372, 1, "SunbladeScout_OnEnterCombat")
RegisterUnitEvent(25372, 2, "SunbladeScout_OnLeaveCombat")
RegisterUnitEvent(25372, 4, "SunbladeScout_OnDied")

-- Sunblade Slayer
function SunbladeSlayer_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(47001,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("SunbladeSlayer_SlayShot", 11000, 0)
end

function SunbladeSlayer_SlayShot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46557,pUnit:GetClosestPlayer())
end

function SunbladeSlayer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeSlayer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25368, 1, "SunbladeSlayer_OnEnterCombat")
RegisterUnitEvent(25368, 2, "SunbladeSlayer_OnLeaveCombat")
RegisterUnitEvent(25368, 4, "SunbladeSlayer_OnDied")

-- Sunblade Vindicator
function SunbladeVindicator_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunbladeVindicator_Strike", 120000, 0)
	pUnit:RegisterEvent("SunbladeVindicator_Cleave", 9000, 0)
end

function SunbladeVindicator_Strike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39171,pUnit:GetClosestPlayer())
end

function SunbladeVindicator_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46559,pUnit:GetClosestPlayer())
end

function SunbladeVindicator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunbladeVindicator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25369, 1, "SunbladeVindicator_OnEnterCombat")
RegisterUnitEvent(25369, 2, "SunbladeVindicator_OnLeaveCombat")
RegisterUnitEvent(25369, 4, "SunbladeVindicator_OnDied")

-- Shadowsword Assassin
function ShadowswordAssassin_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46463,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(25484, 1, "ShadowswordAssassin_OnEnterCombat")

-- Shadowsword Lifeshaper
function ShadowswordLifeshaper_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswordLifeshaper_HealthF", 60000, 0)
	pUnit:RegisterEvent("ShadowswordLifeshaper_Drain", 40000, 0)
end

function ShadowswordLifeshaper_HealthF(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46467,pUnit:GetRandomFriend())
end

function ShadowswordLifeshaper_Drain(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46466,pUnit:GetClosestPlayer())
end

function ShadowswordLifeshaper_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordLifeshaper_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25506, 1, "ShadowswordLifeshaper_OnEnterCombat")
RegisterUnitEvent(25506, 2, "ShadowswordLifeshaper_OnLeaveCombat")
RegisterUnitEvent(25506, 4, "ShadowswordLifeshaper_OnDied")

-- Shadowsword Manafiend
function ShadowswordManafiend_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswordManafiend_ArcExplosion", 9000, 0)
	pUnit:RegisterEvent("ShadowswordManafiend_DrainMana", 60000, 0)
end

function ShadowswordManafiend_ArcExplosion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46457,pUnit:GetClosestPlayer())
end

function ShadowswordManafiend_DrainMana(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46453,pUnit:GetClosestPlayer())
end

function ShadowswordManafiend_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordManafiend_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25483, 1, "ShadowswordManafiend_OnEnterCombat")
RegisterUnitEvent(25483, 2, "ShadowswordManafiend_OnLeaveCombat")
RegisterUnitEvent(25483, 4, "ShadowswordManafiend_OnDied")

-- Shadowsword Soulbinder
function ShadowswordSoulbinder_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswordSoulbinder_FoD", 11000, 0)
	pUnit:RegisterEvent("ShadowswordSoulbinder_CoE", 30000, 0)
end

function ShadowswordSoulbinder_FoD(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46442,pUnit:GetClosestPlayer())
end

function ShadowswordSoulbinder_CoE(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46434,pUnit:GetClosestPlayer())
end

function ShadowswordSoulbinder_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordSoulbinder_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25373, 1, "ShadowswordSoulbinder_OnEnterCombat")
RegisterUnitEvent(25373, 2, "ShadowswordSoulbinder_OnLeaveCombat")
RegisterUnitEvent(25373, 4, "ShadowswordSoulbinder_OnDied")


-- Shadowsword Vanquisher
function ShadowswordVanquisher_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswordVanquisher_Cleave", 15000, 0)
	pUnit:RegisterEvent("ShadowswordVanquisher_Melt", 60000, 0)
end

function ShadowswordVanquisher_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46468,pUnit:GetClosestPlayer())
end

function ShadowswordVanquisher_Melt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46469,pUnit:GetClosestPlayer())
end

function ShadowswordVanquisher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordVanquisher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25486, 1, "ShadowswordVanquisher_OnEnterCombat")
RegisterUnitEvent(25486, 2, "ShadowswordVanquisher_OnLeaveCombat")
RegisterUnitEvent(25486, 4, "ShadowswordVanquisher_OnDied")

-- Apocalypse Guard
function ApocalypseGuard_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("ApocalypseGuard_Cleave",5000,0)
    pUnit:RegisterEvent("ApocalypseGuard_Strike",3000,0)
    pUnit:RegisterEvent("ApocalypseGuard_Coil",15000,0)
    pUnit:RegisterEvent("ApocalypseGuard_Defense",1000,(1))
end

function ApocalypseGuard_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(40504,pUnit:GetClosestPlayer())
end

function ApocalypseGuard_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(45029,pUnit:GetClosestPlayer())
end

function ApocalypseGuard_Coil(pUnit,Event)
    pUnit:FullCastSpellOnTarget(46283,pUnit:GetClosestPlayer())
end

function ApocalypseGuard_Defense(pUnit,Event)
    pUnit:CastSpell(46287)
end

function ApocalypseGuard_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

function ApocalypseGuard_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent (25593, 1, "ApocalypseGuard_OnEnterCombat")
RegisterUnitEvent (25593, 2, "ApocalypseGuard_OnLeaveCombat")
RegisterUnitEvent (25593, 4, "ApocalypseGuard_OnDied")

-- Cataclysm Hound
function CataclysmHound_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CataclysmHound_Frenzy", 1000, 0)
	pUnit:RegisterEvent("CataclysmHound_CataBreath", 8000, 0)
end

function CataclysmHound_Frenzy(pUnit,Event)
	pUnit:FullCastSpellOnTarget(47399,pUnit:GetClosestPlayer())
end

function CataclysmHound_CataBreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46292,pUnit:GetClosestPlayer())
end

function CataclysmHound_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CataclysmHound_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25599, 1, "CataclysmHound_OnEnterCombat")
RegisterUnitEvent(25599, 2, "CataclysmHound_OnEnterCombat")
RegisterUnitEvent(25599, 4, "CataclysmHound_OnEnterCombat")

-- Chaos Gazer
function ChaosGazer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ChaosGazer_Petrify", 11000, 0)
	pUnit:RegisterEvent("ChaosGazer_TentacleSweep", 1000, 0)
end

function ChaosGazer_Petrify(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46288,pUnit:GetClosestPlayer())
end

function ChaosGazer_TentacleSweep(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46290,pUnit:GetClosestPlayer())
end

function ChaosGazer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ChaosGazer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25595, 1, "ChaosGazer_OnEnterCombat")
RegisterUnitEvent(25595, 2, "ChaosGazer_OnLeaveCombat")
RegisterUnitEvent(25595, 4, "ChaosGazer_OnDied")

-- Doomfire Destroyer
function DoomfireDestroyer_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(25592)
end

RegisterUnitEvent(25592, 1, "DoomfireDestroyer_OnEnterCombat")

-- Oblivion Mage
function OblivionMage_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("OblivionMage_FlameBuffet", 3000, 0)
	pUnit:RegisterEvent("OblivionMage_Poly", 70000, 0)
end

function OblivionMage_FlameBuffet(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46279,pUnit:GetClosestPlayer())
end

function OblivionMage_Poly(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46280,pUnit:GetClosestPlayer())
end

function OblivionMage_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function OblivionMage_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25597, 1, "OblivionMage_OnEnterCombat")
RegisterUnitEvent(25597, 2, "OblivionMage_OnEnterCombat")
RegisterUnitEvent(25597, 4, "OblivionMage_OnEnterCombat")

-- Priestess of Torment
function PriestessOfTorment_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46271,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("PriestessOfTorment_Whirlwind", 7000, 0)
end

function PriestessOfTorment_Whirlwind(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46270,pUnit:GetClosestPlayer())
end

function PriestessOfTorment_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function PriestessOfTorment_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25509, 1, "PriestessOfTorment_OnEnterCombat")
RegisterUnitEvent(25509, 2, "PriestessOfTorment_OnLeaveCombat")
RegisterUnitEvent(25509, 4, "PriestessOfTorment_OnDied")

-- Volatile Fiend
function VolatileFiend_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("VolatileFiend_FelFire", 7000, 0)
end

function VolatileFiend_FelFire(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45779,pUnit:GetClosestPlayer())
end

function VolatileFiend_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function VolatileFiend_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25851, 1, "VolatileFiend_OnEnterCombat")
RegisterUnitEvent(25851, 2, "VolatileFiend_OnLeaveCombat")
RegisterUnitEvent(25851, 4, "VolatileFiend_OnDied")

-- Volatile FelFire Fiend
function VolatileFelFireFiend_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("VolatileFelFireFiend_FelFire", 7000, 0)
end

function VolatileFelFireFiend_FelFire(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45779,pUnit:GetClosestPlayer())
end

function VolatileFelFireFiend_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function VolatileFelFireFiend_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25598, 1, "VolatileFelFireFiend_OnEnterCombat")
RegisterUnitEvent(25598, 2, "VolatileFelFireFiend_OnLeaveCombat")
RegisterUnitEvent(25598, 4, "VolatileFelFireFiend_OnDied")

-- Shadowsword Berserker
function ShadowswordBerserker_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46160,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(25798, 1, "ShadowswordBerserker_OnEnterCombat")

-- Shadowsword Fury Mage
function ShadowswordFuryMage_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(46102)
	pUnit:RegisterEvent("ShadowswordFuryMage_FelFireball", 7000, 0)
end

function ShadowswordFuryMage_FelFireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46101,pUnit:GetClosestPlayer())
end

function ShadowswordFuryMage_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordFuryMage_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25799, 1, "ShadowswordFuryMage_OnEnterCombat")
RegisterUnitEvent(25799, 2, "ShadowswordFuryMage_OnLeaveCombat")
RegisterUnitEvent(25799, 4, "ShadowswordFuryMage_OnDied")

-- Void Sentinel
function VoidSentinel_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(46087)
	pUnit:RegisterEvent("VoidSentinel_VoidBlast", 7000, 0)
end

function VoidSentinel_VoidBlast(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46161,pUnit:GetClosestPlayer())
end

function VoidSentinel_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function VoidSentinel_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25772, 1, "VoidSentinel_OnEnterCombat")
RegisterUnitEvent(25772, 2, "VoidSentinel_OnLeaveCombat")
RegisterUnitEvent(25772, 4, "VoidSentinel_OnDied")

-- Void Spawn
function VoidSpawn_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("VoidSpawn_ShadowBolt", 4000, 0)
end

function VoidSpawn_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46082,pUnit:GetClosestPlayer())
end

function VoidSpawn_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function VoidSpawn_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25824, 1, "VoidSpawn_OnEnterCombat")
RegisterUnitEvent(25824, 2, "VoidSpawn_OnLeaveCombat")
RegisterUnitEvent(25824, 4, "VoidSpawn_OnDied")

-- Shadowsword Commander
function ShadowswordCommander_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswordCommander_SheildSlam", 3000, 0)
	pUnit:RegisterEvent("ShadowswordCommander_BattleShout", 40000, 0)
end

function ShadowswordCommander_SheildSlam(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46762,pUnit:GetClosestPlayer())
end

function ShadowswordCommander_BattleShout(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46763,pUnit:GetClosestPlayer())
end

function ShadowswordCommander_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordCommander_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25837, 1, "ShadowswordCommander_OnEnterCombat")
RegisterUnitEvent(25837, 2, "ShadowswordCommander_OnLeaveCombat")
RegisterUnitEvent(25837, 4, "ShadowswordCommander_OnDied")

-- Shadowsword Deathbringer
function ShadowswordDeathbringer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswordDeathbringer_Spell", 6000, 0)
end

function ShadowswordDeathbringer_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46481,pUnit:GetClosestPlayer())
end

function ShadowswordDeathbringer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordDeathbringer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25485, 1, "ShadowswordDeathbringer_OnEnterCombat")
RegisterUnitEvent(25485, 2, "ShadowswordDeathbringer_OnLeaveCombat")
RegisterUnitEvent(25485, 4, "ShadowswordDeathbringer_OnDied")

-- Shadowsword Guardian
function ShadowswordGuardian_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46239,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("ShadowswordGuardian_Earthquake", 20000, 0)
end

function ShadowswordGuardian_Earthquake(pUnit,Event)
	pUnit:FullCastSpellOnTarget(46240,pUnit:GetClosestPlayer())
end

function ShadowswordGuardian_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswordGuardian_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(25508, 1, "ShadowswordGuardian_OnEnterCombat")
RegisterUnitEvent(25508, 2, "ShadowswordGuardian_OnLeaveCombat")
RegisterUnitEvent(25508, 4, "ShadowswordGuardian_OnDied")


-- Hand of The Deceiver
function HandOfTheDeceiver_OnEnterCombat(pUnit,Event)
	pUnit:SetUInt32Value(UNIT_FIELD_CHANNEL_OBJECT,0)
	pUnit:SetUInt32Value(UNIT_CHANNEL_SPELL,0)
	pUnit:RegisterEvent("HandOfTheDeceiver_ShadowInfusion", 1000,1)
	pUnit:RegisterEvent("HandOfTheDeceiver_FelfirePortal", 35000, 0)
	pUnit:RegisterEvent("HandOfTheDeceiver_Spell", 8000, 0)
end

function HandOfTheDeceiver_ShadowInfusion(pUnit,Event)
 if pUnit:GetHealthPct() == 20 then
	pUnit:CastSpell(45772)
end
end

function HandOfTheDeceiver_FelfirePortal(pUnit,Event)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:CastSpell(46875)
	pUnit:RegisterEvent("HandOfTheDeceiver_FelfirePortalCombat", 6000, 1)
end

function HandOfTheDeceiver_FelfirePortalCombat(pUnit,Event)
	pUnit:SetCombatMeleeCapable(0)
end

function HandOfTheDeceiver_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(45770,pUnit:GetClosestPlayer())
end

function HandOfTheDeceiver_OnLeaveCombat(pUnit,Event)
	pUnit:RegisterEvent("HandOfTheDeceiver_LeaveWorld", 5000, 0)
	pUnit:RemoveEvents()
end

function HandOfTheDeceiver_OnDied(pUnit,Event)
	pUnit:Root()
	pUnit:RegisterEvent("HandOfTheDeceiver_LeaveWorld", 5000, 0)
end

function HandOfTheDeceiver_LeaveWorld(pUnit,Event)
	pUnit:RemoveFromWorld()
end

RegisterUnitEvent(25588, 1, "HandOfTheDeceiver_OnEnterCombat")
RegisterUnitEvent(25588, 2, "HandOfTheDeceiver_OnLeaveCombat")
RegisterUnitEvent(25588, 4, "HandOfTheDeceiver_OnDied")