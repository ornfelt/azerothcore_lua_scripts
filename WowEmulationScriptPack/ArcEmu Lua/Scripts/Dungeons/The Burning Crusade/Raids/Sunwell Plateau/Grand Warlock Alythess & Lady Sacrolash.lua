--LadySacrolash

function LadySacrolash_OnCombat(pUnit, Event)
   pUnit:RegisterEvent("Confounding_Blow",20000,0)
   pUnit:RegisterEvent("ShadowNova",30000,0)
   pUnit:RegisterEvent("ShadowBlades",10000,0)
   pUnit:RegisterEvent("summonShadowImage",40000,0)
   pUnit:RegisterEvent("LadySacrolash_Enrage", 360000, 0)
end

function summonShadowImage(pUnit, Event)
local x = pUnit:GetX()
local y = pUnit:GetY()
local z = pUnit:GetZ()
local o = pUnit:GetO()
pUnit:SpawnCreature(25214, x+5, y, z, o, 16, 0)
pUnit:SpawnCreature(25214, x-5, y, z, o, 16, 0)
end

--??? ??
function ConfoundingBlow(pUnit, Event)
   pUnit:FullCastSpellOnTarget(45256, pUnit:GetMainTank())
end

function ShadowNova(pUnit, Event)
   pUnit:FullCastSpellOnTarget(45329, pUnit:GetMainTank())
end

--??? ??
function ShadowBlades(pUnit, Event)
   pUnit:CastSpell(45248)
end

--??
function LadySacrolash_Enrage(pUnit, event)
   pUnit:CastSpell(26662)
end      

function LadySacrolash_OnLeaveCombat(pUnit, Event)
   pUnit:RemoveEvents()   
end

function LadySacrolash_OnKilledTarget(pUnit, Event)
   pUnit:SendChatMessage(14, 0, "??? ? ???!")
   pUnit:PlaySoundToSet(12486)
end

function LadySacrolash_OnDied(pUnit, Event)
   pUnit:RemoveEvents()
   end

RegisterUnitEvent(25165, 1, "LadySacrolash_OnCombat")
RegisterUnitEvent(25165, 2, "LadySacrolash_OnLeaveCombat")
RegisterUnitEvent(25165, 3, "LadySacrolash_OnKilledTarget")
RegisterUnitEvent(25165, 4, "LadySacrolash_OnDied")

--??? ?? ??

function ShadowImage_OnCombat(Unit, Event)
Unit:RegisterEvent("ShadowFury",4000,0)
Unit:RegisterEvent("DarkStrike",2000,0)
Unit:SetCombatCapable(0)
Unit:Despawn(10000, 0)
end

--???? ??? ??? ??
function ShadowFury(Unit, Event)
   Unit:FullCastSpellOnTarget(45270, Unit:GetMainTank())   
end

--??? ??
function DarkStrike(Unit, Event)
   Unit:FullCastSpellOnTarget(45271, Unit:GetMainTank())      
end

function ShadowImage_LeaveCombat(Unit, Event)
    Unit:RemoveEvents()
end

function ShadowImage_Died(Unit, Event)
    Unit:RemoveEvents()
end

RegisterUnitEvent(25214, 1, "ShadowImage_OnCombat")
RegisterUnitEvent(25214, 2, "ShadowImage_LeaveCombat")
RegisterUnitEvent(25214, 4, "ShadowImage_Died")

--????? ????

function WarlockAlythess_OnCombat(pUnit, Event)
   pUnit:RegisterEvent("Pyrogenics", 25000,0)
   pUnit:RegisterEvent("FlameSear", 20000,0)
   pUnit:RegisterEvent("Conflagration", 30000,0)
   pUnit:RegisterEvent("AlyEnrage", 360000, 0)
        pUnit:StopMovement(360000)
end

--??
function Pyrogenics(pUnit, Event)
   pUnit:CastSpell(45230)   
end

--??? ??
function FlameSear(pUnit, Event)
   pUnit:CastSpell(46771)
end

--??? ??
function Conflagration(pUnit, Event)
   pUnit:PlaySoundToSet(12489)
   pUnit:SendChatMessage(14, 0, "??? ??? ????!")
   pUnit:FullCastSpellOnTarget(45342, pUnit:GetMainTank())   
end

--function AlyShadowNova(pUnit, Event)
--   pUnit:FullCastSpellOnTarget(45329, pUnit:GetMainTank())   
--end

function AlyEnrage(pUnit, event)
   pUnit:CastSpell(26662) -- Same as Brutallus for now
end

function WarlockAlythess_OnKilledTarget(pUnit, Event)
   pUnit:SendChatMessage(14, 0, "??? ? ???!")   
end

function WarlockAlythess_OnLeaveCombat(pUnit, Event)
   pUnit:RemoveEvents()   
end

function WarlockAlythess_OnDied(pUnit, Event)
   pUnit:RemoveEvents()
   pUnit:PlaySoundToSet(12494)
end

RegisterUnitEvent(25166, 1, "WarlockAlythess_OnCombat")
RegisterUnitEvent(25166, 2, "WarlockAlythess_OnLeaveCombat")
RegisterUnitEvent(25166, 3, "WarlockAlythess_OnKilledTarget")
RegisterUnitEvent(25166, 4, "WarlockAlythess_OnDied")