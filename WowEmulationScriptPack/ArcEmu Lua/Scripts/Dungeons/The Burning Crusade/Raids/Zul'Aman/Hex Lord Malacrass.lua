--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   Original Code by DARKI
   Version 1
========================================]]--

function HexOnCombat(pUnit, event)
Hex = pUnit:GetCreatureNearestCoords(pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(), 24239)
Hex:RemoveEvents()
Hex:SendChatMessage(12, 0, "Da shadow gonna fall on you...")
Hex:PlaySoundToSet(12041)
Hex:RegisterEvent("SpiritBoltsFirst", 30000, 1)
Hex:RegisterEvent("DrainPowerCheck", 11000, 0)
Hex:RegisterEvent("RandomSpawns", 100, 4)
Hex:RegisterEvent("FirstCheck", 9000, 0)
Hex:RegisterEvent("DespawnAdds",500, 1)
end

function SpiritBoltsFirst(pUnit, event)
First = 1
Hex:StopMovement(10000)
Hex:FullCastSpell(43383)
end
function FirstCheck(pUnit, event)
if (First == 1) then
Hex:RegisterEvent("SoulDrain", 13000, 1)
else
end
end
function SpiritBolts(pUnit, event)
Hex:StopMovement(10000)
Hex:FullCastSpell(43383)
end
function DrainPowerCheck(pUnit, event)
if (Hex:GetHealthPct() <= 80) then
Hex:RegisterEvent("DrainPowerAI", 5000, 1)
else
end
end

function DrainPowerAI(pUnit, event)
MT = Hex:GetMainTank()
local x = MT:GetX()
local y = MT:GetY()
local z = MT:GetZ()
local radius = 20
local playersinrange = pUnit:GetPlayerCountInRadius(x, y, z ,radius)
print (playersinrange)
if (playersinrange == 1) then
Hex:RegisterEvent("DrainPower", 100, 1)
elseif (playersinrange == 2) then
Hex:RegisterEvent("DrainPower", 100, 2)
elseif (playersinrange == 3) then
Hex:RegisterEvent("DrainPower", 100, 3)
elseif (playersinrange == 4) then
Hex:RegisterEvent("DrainPower", 100, 4)
elseif (playersinrange == 5) then
Hex:RegisterEvent("DrainPower", 100, 5)
elseif (playersinrange == 6) then
Hex:RegisterEvent("DrainPower", 100, 6)
elseif (playersinrange == 7) then
Hex:RegisterEvent("DrainPower", 100, 7)
elseif (playersinrange == 8) then
Hex:RegisterEvent("DrainPower", 100, 8)
elseif (playersinrange == 9) then
Hex:RegisterEvent("DrainPower", 100, 9)
elseif (playersinrange == 10) then
Hex:RegisterEvent("DrainPower", 100, 10)
end
Hex:RegisterEvent("DrainPowerAI", 60000, 1)
end

function DrainPower(pUnit, event)
local plr = Hex:GetRandomPlayer(0)
if (plr ~= nil) then
Hex:CastSpellOnTarget(44131, plr)
Hex:CastSpellOnTarget(44132, Hex)
else
end
end

function SoulDrain(pUnit, event)
Hex:RemoveEvents()
print "Drain TIME!!!"
local plr = Hex:GetRandomPlayer(0)
local Class = plr:GetPlayerClass()
print (Class)
if (Class == 1) then
Hex:RegisterEvent("WarriorDrain", 100, 1)
end
if (Class == 2) then
Hex:RegisterEvent("PaladinDrain", 100, 1)
end
if (Class == 3) then
Hex:RegisterEvent("HunterDrain", 100, 1)
end
if (Class == 4) then
Hex:RegisterEvent("RogueDrain", 100, 1)
end
if (Class == 5) then
Hex:RegisterEvent("PriestDrain", 100, 1)
end
if (Class == 7) then
Hex:RegisterEvent("ShamanDrain", 100, 1)
end
if (Class == 8) then
Hex:RegisterEvent("MageDrain", 100, 1)
end
if (Class == 9) then
Hex:RegisterEvent("WarlockDrain", 100, 1)
end
if (Class == 11) then
Hex:RegisterEvent("DruidDrain", 100, 1)
end
Hex:RegisterEvent("DrainPowerCheck", 29000 ,0)
Hex:RegisterEvent("SpiritBolts", 32000, 0)
Hex:RegisterEvent("SoulDrain", 60000, 1)
end

function HexOnDeath(pUnit, event)
Hex:RemoveEvents()
Hex:SendChatMessage(12, 0, "Dis not da end for me..")
Hex:PlaySoundToSet(12051)
end

function HexOnKilledTarget(pUnit, event)
local deathcheck = math.random(1, 2)
if (deathcheck == 1) then
Hex:SendChatMessage(12, 0, "Azzaga choogo zinn!")
Hex:PlaySoundToSet(12044)
elseif (deathcheck == 2) then
Hex:SendChatMessage(12, 0, "Dis a nightmare ya don' wake up from!")
Hex:PlaySoundToSet(12043)
end
end

function HexOnLeaveCombat(pUnit, event)
Hex:RemoveEvents()
end

RegisterUnitEvent(24239, 1, "HexOnCombat")
RegisterUnitEvent(24239, 2, "HexOnLeaveCombat")
RegisterUnitEvent(24239, 3, "HexOnKilledTarget")
RegisterUnitEvent(24239, 4, "HexOnDeath")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--------------------------DRAIN POWER AI------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Warrior Drain--
function WarriorDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("WarriorSpellReflect", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("WarriorWhirlwind", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("WarriorMortalStrike", 100, 1)
end
Hex:RegisterEvent("WarriorDrain", 5000, 1)
end
function WarriorSpellReflect(pUnit, event)
Hex:FullCastSpell(43443)
end
function WarriorWhirlwind(pUnit, event)
Hex:StopMovement(4000)
Hex:FullCastSpellOnTarget(43442, Hex:GetMainTank())
end
function WarriorMortalStrike(pUnit, event)
Hex:FullCastSpellOnTarget(43441, pUnit:GetMainTank())
end
-- Paladin Soul Drain --
function PaladinDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("PaladinConsecration", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("PaladinHolyLight", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("PaladinAvengingWrath", 100, 1)
end
Hex:RegisterEvent("PaladinDrain", 5000, 1)
end
function PaladinConsecration(pUnit, event)
Hex:FullCastSpell(43429)
end
function PaladinHolyLight(pUnit, event)
Hex:FullCastSpellOnTarget(43451, Hex)
end
function PaladinAvengingWrath(pUnit, event)
Hex:FullCastSpell(43430)
end
-- Hunter Soul Drain ---
function HunterDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("HunterExploTrap", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("HunterFreezeTrap", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("HunterSnakeTrap", 100, 1)
end
Hex:RegisterEvent("HunterDrain", 10000, 1)
end
function HunterExploTrap(pUnit, event)
Hex:FullCastSpell(43444)
end
function HunterFreezeTrap(pUnit, event)
Hex:FullCastSpell(43447)
end
function HunterSnakeTrap(pUnit, event)
Hex:FullCastSpell(43449)
end
-- Rogue Soul Drain --
function RogueDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("RogueBlind", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("RogueSlicenDice", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("RogueWoundPoison", 100, 1)
end
Hex:RegisterEvent("RogueDrain", 7000, 1)
end
function RogueBlind(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(43433, Hex:GetRandomPlayer(0))
else
end
end
function RogueSlicenDice(pUnit, event)
Hex:FullCastSpell(43547)
end
function RogueWoundPoison(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(39665, Hex:GetRandomPlayer(0))
else
end
end
-- Priest Soul Drain --
function PriestDrain(pUnit, event)
local Start = math.random(1,6)
if (Start == 1) then
Hex:RegisterEvent("PriestHeal", 100, 1)
elseif (Start == 2) then
elseif (Start == 3) then
Hex:RegisterEvent("PriestMindBlast", 100, 1)
elseif (Start == 4) then
Hex:RegisterEvent("PriestSWD", 100, 1)
elseif (Start == 5) then
Hex:RegisterEvent("PriestPsychicScream", 100, 1)
elseif (Start == 6) then
Hex:RegisterEvent("PainSuppression", 100, 1)
end
Hex:RegisterEvent("PriestDrain", 10000, 1)
end
function PriestHeal(pUnit, event)
Hex:FullCastSpellOnTarget(41372, Hex)
end
function PriestMindControl(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(43550, Hex:GetRandomPlayer(0))
else
end
end
function PriestMindBlast(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(41374, Hex:GetRandomPlayer(0))
else
end
end
function PriestSWD(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(41375, Hex:GetRandomPlayer(0))
else
end
end
function PriestPsychicScream(pUnit, event)
Hex:FullCastSpell(43442)
end
function PriestPainSuppression(pUnit, event)
Hex:FullCastSpellOnTarget(44416, Hex)
end
--Shaman Soul Drain --
function ShamanDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("ShamanFireNova", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("ShamanHealWave", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("ShamanChainLight", 100, 1)
end
Hex:RegisterEvent("ShamanDrain", 7000, 1)
end
function ShamanHealWave(pUnit, event)
Hex:FullCastSpell(43548)
end
function ShamanChainLight(pUnit, event)
Hex:FullCastSpell(43435)
end
function ShamanFireNova(pUnit, event)
Hex:CastSpell(43436)
end
-- Mage Soul Drain --
function MageDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("MageFireball", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("MageFrostbolt", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("MageFrostNova", 100, 1)
end
Hex:RegisterEvent("MageDrain", 7000, 1)
end
function MageFireball(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(41383, Hex:GetRandomPlayer(0))
else
end
end
function MageFrostbolt(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(43428, Hex:GetRandomPlayer(0))
else
end
end
function MageFrostNova(pUnit, event)
Hex:FullCastSpell(43426)
if math.random() > 0.1 then
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpell(43427)
else
end
end
end
-- Warlock Soul Drain --
function WarlockDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("WarlockCoD", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("WarlockRainoFire", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("WarlockUnstableAffliction", 100, 1)
end
Hex:RegisterEvent("WarlockDrain", 7000, 1)
end
function WarlockCoD(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(43439, Hex:GetRandomPlayer(0))
else
end
end
function WarlockRainoFire(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
local Rand = Hex:GetRandomPlayer(0)
local x = Rand:GetX()
local y = Rand:GetY()
local z = Rand:GetZ()
Hex:CastSpellAoF(x, y, z, 43440)
else
end
end
function WarlockUnstableAffliction(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(35183, Hex:GetRandomPlayer(0))
else
end
end
-- Druid Soul Drain --
function DruidDrain(pUnit, event)
local Start = math.random(1,3)
if (Start == 1) then
Hex:RegisterEvent("DruidLifeBloom", 100, 1)
elseif (Start == 2) then
Hex:RegisterEvent("DruidThorns", 100, 1)
elseif (Start == 3) then
Hex:RegisterEvent("DruidNoobFire", 100, 1)
end
Hex:RegisterEvent("DruidDrain", 6000, 1)
end
function DruidLifeBloom(pUnit, event)
Hex:FullCastSpell(43421)
end
function DruidThorns(pUnit, event)
Hex:FullCastSpell(43420)
end
function DruidNoobFire(pUnit, event)
if (Hex:GetRandomPlayer(0) ~= nil ) then
Hex:FullCastSpellOnTarget(43545, Hex:GetRandomPlayer(0))
else
end
end
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------Random Spawns on Combat Start------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

function RandomSpawns(pUnit, event)
local spawns = math.random(math.random(1,8))
if spawns == 1 then
Hex:SpawnCreature(24241, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) -- Thurg
elseif spawns == 2 then
Hex:SpawnCreature(24244, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) -- Gazakroth
elseif spawns == 3 then
Hex:SpawnCreature(24243, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) -- Lord Raandan
elseif spawns == 4 then
Hex:SpawnCreature(24246, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) -- Darkheart
elseif spawns == 5 then
Hex:SpawnCreature(24240, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) -- Alyson Antille
elseif spawns == 6 then
Hex:SpawnCreature(24242, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) --Slither
elseif spawns == 7 then
Hex:SpawnCreature(24245, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) --Fenstalker
elseif spawns == 8 then
Hex:SpawnCreature(24247, Hex:GetX(), Hex:GetY(), Hex:GetZ(), Hex:GetO(), 1890, 0) -- Koragg
end
end
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
------------------------------------DESPAWN ADDS-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function DespawnAdds(pUnit)
if (Hex:IsInCombat() == false) then
Fenstalker:Despawn(0,0)
Alyson:Despawn(0,0)
Koragg:Despawn(0,0)
Kroth:Despawn(0,0)
Slither:Despawn(0,0)
Thurg:Despawn(0,0)
Lord:Despawn(0,0)
Darkheart:Despawn(0,0)
else
end
Hex:RegisterEvent("DespawnAdds", 5000, 1)
end
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--------------------------------SLITHER'S AI------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function SlitherSpawn(pUnit)
Slither = pUnit
if(Slither:GetRandomPlayer(0) ~= nil) then
Slither:RegisterEvent("SlitherBolts", 500, 1)
end
end
function SlitherBolts(pUnit)
Slither:FullCastSpellOnTarget(38827, Slither:GetRandomPlayer(0))
Slither:RegisterEvent("SlitherBolts", 7000, 1)
end
function SlitherStop(pUnit)
Slither:RemoveEvents()
end

RegisterUnitEvent(24242, 2, "SlitherStop")
RegisterUnitEvent(24242, 3, "SlitherStop")
RegisterUnitEvent(24242, 4, "SlitherStop")
RegisterUnitEvent(24242, 6, "SlitherSpawn")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-----------------------------------FEN STALKER AI---------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function FenstalkerSpawn(pUnit)
Fenstalker = pUnit
if (Fenstalker:GetRandomPlayer(0) ~= nil) then
Fenstalker:RegisterEvent("Infection", 500, 1)
end
end
function Infection(pUnit)
local plr = pUnit:GetRandomPlayer(0)
Fenstalker:FullCastSpellOnTarget(43586, plr)
Fenstalker:RegisterEvent("Infection", 10000, 1)
end
function FenstalkerWipe(pUnit)
Fenstalker:RemoveEvents()
end

RegisterUnitEvent(24245, 2, "FenstalkerWipe")
RegisterUnitEvent(24245, 3, "FenstalkerWipe")
RegisterUnitEvent(24245, 4, "FenstalkerWipe")
RegisterUnitEvent(24245, 6, "FenstalkerSpawn")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-----------------------------KORAGG-------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function KoraggSpawn(pUnit)
Koragg = pUnit
end

RegisterUnitEvent(24247, 6, "KoraggSpawn")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
------------------------------THURG-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

function ThurgSpawn(pUnit)
Thurg = pUnit
end

RegisterUnitEvent(24241, 6, "ThurgSpawn")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
------------------------GAZAKROTH AI---------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function Gazakroth(pUnit, event)
Kroth = pUnit
if(Kroth:GetRandomPlayer(0) ~= nil) then
Kroth:SetCombatMeleeCapable(1)
Kroth:RegisterEvent("KrothFireballs", 100, 1)
else
end
end
function KrothFireballs(pUnit)
Kroth:FullCastSpellOnTarget(40877, Kroth:GetRandomPlayer(0))
Kroth:RegisterEvent("KrothFireballs", 2100, 1)
end
function KrothStop(pUnit)
Kroth:RemoveEvents()
end

RegisterUnitEvent(24244, 2, "KrothStop")
RegisterUnitEvent(24244, 3, "KrothStop")
RegisterUnitEvent(24244, 4, "KrothStop")
RegisterUnitEvent(24244, 1, "Gazakroth")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------LORD RAADAN AI------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function Lord_Raandan(pUnit, event)
Lord = pUnit
if(Lord:GetRandomPlayer(0) ~= nil) then
Lord:RegisterEvent("LordSpells", 100, 1)
else
end
end
function LordSpells(pUnit, event)
if math.random() < 0.2 then
Lord:FullCastSpell(23461)
elseif math.random() > 0.2 then
Lord:FullCastSpell(30633)
end
Lord:RegisterEvent("LordSpells", 7000, 1)
end
function LordStop(pUnit)
Lord:RemoveEvents()
end

RegisterUnitEvent(24243, 2, "LordStop")
RegisterUnitEvent(24243, 3, "LordStop")
RegisterUnitEvent(24243, 4, "LordStop")
RegisterUnitEvent(24243, 1, "Lord_Raandan")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-------------------------------DARK HEART AI------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function DarkheartSpawn(pUnit, event)
Darkheart = pUnit:GetCreatureNearestCoords(Hex:GetX(),Hex:GetY(),Hex:GetZ(), 24246)
if (Darkheart:GetRandomPlayer(0) ~= nil) then
Darkheart:RegisterEvent("Darkheartfear",100, 1)
end
end
function Darkheartfear(pUnit)
Darkheart:CastSpell(43590)
Darkheart:RegisterEvent("Darkheartfear", 10000, 1)
end
function Darkstop(pUnit)
Darkheart:RemoveEvents()
end

RegisterUnitEvent(24246, 2, "Darkstop")
RegisterUnitEvent(24246, 3, "Darkstop")
RegisterUnitEvent(24246, 4, "Darkstop")
RegisterUnitEvent(24246, 1, "DarkheartSpawn")

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-------------------------ALYSON AI----------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function Alyson(pUnit, event)
Alyson = pUnit:GetCreatureNearestCoords(Hex:GetX(),Hex:GetY(),Hex:GetZ(), 24240)
Alyson:SetCombatMeleeCapable(1)
Alyson:RegisterEvent("Alysonheals", 500, 1)
end
function HexHeal(pUnit, event)
local hexlives = Hex:IsInWorld()
if (Hex~=nil and hexlives ==true) then
    Alyson:FullCastSpellOnTarget(43575,Hex)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function AlysonHeal(pUnit, event)
local alysonlives = Alyson:IsInWorld()
if (Alyson~=nil and alysonlives == true) then
    Alyson:FullCastSpellOnTarget(43575, Alyson)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function LordHeal(pUnit, event)
local lordlives = Lord:IsInWorld()
if (Lord ~= nil and lordlives == true) then
    Alyson:FullCastSpellOnTarget(43575, Lord)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function KrothHeal(pUnit, event)
local krothlives = Kroth:IsInWorld()
if(Kroth ~= nil) and (krothlives == true) then
    Alyson:FullCastSpellOnTarget(43575, Kroth)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function DarkHeal(pUnit, event)
local darkheartlives = Darkheart:IsInWorld()
if (Darkheart~=nil and darkheartlives==true) then
    Alyson:FullCastSpellOnTarget(43575, Darkheart)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function ThurgHeal(pUnit, event)
local thurglives=Thurg:IsInWorld()
if (Thurg~=nil and thurglives==true) then
    Alyson:FullCastSpellOnTarget(43575, Thurg)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function KoraggHeal(pUnit, event)
local koragglives =Koragg:IsInWorld()
if (Koragg~=nil and koragglives==true) then
    Alyson:FullCastSpellOnTarget(43575, Koragg)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function FenstalkerHeal(pUnit, event)
local fenlives= Fenstalker:IsInWorld()
if (Fenstalker~= nil and fenlives==true) then
    Alyson:FullCastSpellOnTarget(43575, Fenstalker)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function SlitherHeal(pUnit, event)
local slitherlives = Slither:IsInWorld()
if (Slither~=nil and slitherlives==true) then
    Alyson:FullCastSpellOnTarget(43575, Slither)
    else
    Alyson:RegisterEvent("Alysonheals", 500, 1)
    end
    end
function Alysonheals(pUnit, event)
local friend = math.random((math.random(1,9)))
if (friend == 1) then
    Alyson:RegisterEvent("HexHeal", 500, 1)
elseif (friend == 2) then
    Alyson:RegisterEvent("AlysonHeal", 500, 1)
elseif (friend == 3) then
    Alyson:RegisterEvent("LordHeal", 500, 1)
elseif (friend == 4) then
    Alyson:RegisterEvent("KrothHeal", 500, 1)
elseif (friend == 5) then
    Alyson:RegisterEvent("DarkHeal", 500, 1)
elseif (friend == 6) then
    Alyson:RegisterEvent("ThurgHeal", 500, 1)
elseif (friend == 7) then
    Alyson:RegisterEvent("KoraggHeal", 500, 1)
elseif (friend == 8) then
    Alyson:RegisterEvent("SlitherHeal", 500, 1)
elseif (friend == 9) then
    Alyson:RegisterEvent("FenstalkerHeal", 500, 1)
end
Alyson:RegisterEvent("Alysonheals", 2500, 1)
end
function AlysonStop(pUnit)
Alyson:RemoveEvents()
end

RegisterUnitEvent(24240, 4, "AlysonStop")
RegisterUnitEvent(24240, 1, "Alyson")

