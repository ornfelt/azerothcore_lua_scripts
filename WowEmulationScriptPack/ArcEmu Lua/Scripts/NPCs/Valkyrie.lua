{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fswiss\fcharset0 Arial;}}
{\*\generator Msftedit 5.41.15.1515;}\viewkind4\uc1\pard\f0\fs20 function Valkyrie_onCombat(pUnit, event)\par
pUnit:SendChatMessage(12, 0, "May the secrets defile you!")\par
pUnit:CastSpell(42995)\par
pUnit:CastSpell(48161)\par
pUnit:CastSpell(47893)\par
pUnit:RegisterEvent("Phase1",1000,0)\par
end\par
\par
function Valkyrie_onLeaveCombat(pUnit, event)\par
pUnit:RemoveEvents()\par
pUnit:RemoveAura(42995)\par
pUnit:RemoveAura(48161)\par
pUnit:RemoveAura(47893)\par
end\par
\par
function Valkyrie_onDeath(pUnit, event)\par
pUnit:RemoveEvents()\par
pUnit:RemoveAura(42995)\par
pUnit:RemoveAura(48161)\par
pUnit:RemoveAura(47893)\par
pUnit:SendChatMessage(12, 0, "The secrets lie within")\par
end\par
\par
RegisterUnitEvent(, 1, "Valkyrie_onCombat")\par
RegisterUnitEvent(, 3, "Valkyrie_onLeaveCombat")\par
RegisterUnitEvent(, 4, "Valkyrie_onDeath")\par
\par
----------\par
-Phases-\par
----------\par
\par
function Phase1(pUnit, event)\par
if pUnit:GetHealthPct() <= 99 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("FrostShield",500,1)\par
pUnit:RegisterEvent("Blastwave",500,1)\par
pUnit:RegisterEvent("LivingBomb",500,1)\par
pUnit:RegisterEvent("Phase2",1000,0)\par
end\par
end\par
\par
function Phase2(pUnit, event)\par
if pUnit:GetHealthPct() <96 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("FrostBolt",2000,1)\par
pUnit:RegisterEvent("Renew",500,1)\par
pUnit:RegisterEvent("ConeOfCold",1000,1)\par
pUnit:RegisterEvent("Phase3",2000,0)\par
end\par
end\par
\par
function Phase3(pUnit, event)\par
if pUnit:GetHealthPct() < 91 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Fireball",1500,1)\par
pUnit:RegisterEvent("ArcaneNova",500,1)\par
pUnit:RegisterEvent("HolyShield",1000,1)\par
pUnit:RegisterEvent("Phase4",2000,0)\par
end\par
end\par
\par
function Phase4(pUnit, event)\par
if pUnit:GetHealthPct() < 87 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Frostfire",2000,1)\par
pUnit:RegisterEvent("DragonBreath",300,1)\par
pUnit:RegisterEvent("Phase5",2000,0)\par
end\par
end\par
\par
function Phase5(pUnit, event)\par
if pUnit:GetHealthPct() <= 81 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("ShadowBolt",2500,1)\par
pUnit:RegisterEvent("Fear",750,1)\par
pUnit:RegisterEvent("Phase6",2500,0)\par
end\par
end\par
\par
function Phase6(pUnit, event)\par
if pUnit:GetHealthPct() < 77 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("SoulFire",3000,1)\par
pUnit:RegisterEvent("Phase7",3000,0)\par
end\par
end\par
\par
function Phase7(pUnit, event)\par
if pUnit:GetHealthPct() < 72 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Smite",1500,1)\par
pUnit:RegisterEvent("ArcaneNova"300,1)\par
pUnit:RegisterEvent("Phase8",1500,0)\par
end\par
end\par
\par
function Phase8(pUnit, event)\par
if pUnit:GetHealthPct() < 67 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Unstable",1500,1)\par
pUnit:RegisterEvent("BlastWave",500,1)\par
pUnit:RegisterEvent("FrostShield",1000,1)\par
pUnit:RegisterEvent("Phase9",3000,0)\par
end\par
end\par
\par
function Phase9(pUnit, event)\par
if pUnit:GetHealthPct() < 63 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Pyroblast",3050,1)\par
pUnit:RegisterEvent("BlastWave",1000,1)\par
pUnit:RegisterEvent("Phase10",6100,0)\par
end\par
end\par
\par
function Phase10(pUnit, event)\par
if pUnit:GetHealthPct() < 58 then \par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Siphon",1000,1)\par
pUnit:RegisterEvent("ArcaneNova",750,1)\par
pUnit:RegisterEvent("Phase11",6000,0)\par
end\par
end\par
\par
function Phase11(pUnit, event)\par
if pUnit:GetHealthPct() <= 51 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Haunt",1550,1)\par
pUnit:RegisterEvent("ShadowFury",1000,1)\par
pUnit:RegisterEvent("Phase12",1500,0)\par
end\par
end\par
\par
function Phase12(pUnit, event)\par
if pUnit:GetHealthPct() < 47 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Renew",1500,1)\par
pUnit:RegisterEvent("ChaosBolt",1500,1)\par
pUnit:RegisterEvent(Phase13",1500,0)\par
end\par
end\par
\par
function Phase13(pUnit, event)\par
if pUnit:GetHealthPct() <= 42 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Heal",3000,1)\par
pUnit:RegisterEvent("ArcaneNova",250,1)\par
pUnit:RegisterEvent("Phase14",3000,1)\par
end\par
end\par
\par
function Phase14(pUnit, event)\par
if pUnit:GetHealthPct() <= 38 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("HolyFire",2000,1)\par
pUnit:RegisterEvent("Renew",700,1)\par
pUnit:RegisterEvent("Phase15",4000,0)\par
end\par
end\par
\par
function Phase15(pUnit, event)\par
if pUnit:GetHealthPct() < 33 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("MindBlast",1500,1)\par
pUnit:RegisterEvent("ArcaneNova",500,1)\par
pUnit:RegisterEvent("Phase16",1500,0)\par
end\par
end\par
\par
function Phase16(pUnit, event)\par
if pUnit:GetHealthPct() <= 27 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Barrage",1000,1)\par
pUnit:RegisterEvent("Sheep",1500,1)\par
pUnit:RegisterEvent("Phase17",4500,0)\par
end\par
end\par
\par
function Phase17(pUnit, event)\par
if pUnit:GetHealthPct() <= 20 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("Heal",3000,1)\par
pUnit:RegisterEvent("Renew",1500,1)\par
pUnit:RegisterEvent("BlastWave",750,1)\par
pUnit:RegisterEvent("Phase18",3000,0)\par
end\par
end\par
\par
function Phase18(pUnit, event)\par
if pUnit:GetHealthPct() < 10 then\par
pUnit:RemoveEvents()\par
pUnit:RegisterEvent("ArcaneNova",100,5)\par
pUnit:RegisterEvent("BlastWave",150,2)\par
end\par
end\par
\par
---------\par
-Spells-\par
---------\par
\par
function FrostShield(pUnit, event)\par
pUnit:CastSpell(43039)\par
end\par
\par
function BlastWave(pUnit, event)\par
pUnit:CastSpell(42945)\par
end\par
\par
function LivingBomb(pUnit, event)\par
pUnit:FullCastSpellOnTarget(55360, pUnit:GetRandomPlayer(0))\par
end\par
\par
function FrostBolt(pUnit, event)\par
pUnit:FullCastSpellOnTarget(42842, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Renew(pUnit, event)\par
pUnit:CastSpell(48068)\par
end\par
\par
function ConeOfCold(pUnit, event)\par
pUnit:CastSpell(42931)\par
end\par
\par
function Fireball(pUnit, event)\par
pUnit:FullCastSpellOnTarget(42833, pUnit:GetRandomPlayer(0))\par
end\par
\par
function ArcaneNova(pUnit, event)\par
pUnit:CastSpell(42921)\par
end\par
\par
function HolyShield(pUnit, event)\par
pUnit:CastSpell(48066)\par
end\par
\par
function Frostfire(pUnit, event)\par
pUnit:FullCastSpellOnTarget(47610, pUnit:GetRandomPlayer(0))\par
end\par
\par
function DragonBreath(pUnit, event)\par
pUnit:CastSpell(42950)\par
end\par
\par
function ShadowBolt(pUnit, event)\par
pUnit:FullCastSpellOnTarget(47809, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Fear(pUnit, event)\par
pUnit:FullCastSpellOnTarget(6215, pUnit:GetRandomPlayer(0))\par
end\par
\par
function SoulFire(pUnit, event)\par
pUnit:FullCastSpellOnTarget(47825, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Smite(pUnit, event)\par
pUnit:FullCastSpellOnTarget(48123, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Unstable(pUnit, event)\par
pUnit:FullCastSpellOnTarget(47843, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Pyroblast(pUnit, event)\par
pUnit:FullCastSpellOnTarget(42891, pUnit:GetRandonPlayer(0))\par
end\par
\par
function Siphon(pUnit, event)\par
pUnit:FullCastSpellOnTarget(47862, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Haunt(pUnit, event)\par
pUnit:FullCastSpellOnTarget(59164, pUnit:GetRandomPlayer(0))\par
end\par
\par
function ShadowFury(pUnit, event)\par
pUnit:CastSpell(47847)\par
end\par
\par
function Chaos(pUnit, event)\par
pUnit:FullCastSpellOnTarget(59172, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Heal(pUnit, event)\par
pUnit:FullCastSpell(48063)\par
end\par
\par
function HolyFire(pUnit, event)\par
pUnit:FullCastSpellOnTarget(48135, pUnit:GetRandomPlayer(0))\par
end\par
\par
function MindBlast(pUnit, event)\par
pUnit:FullCastSpellOnTarget(48127, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Barrage(pUnit, event)\par
pUnit:FullCastSpellOnTarget(44781, pUnit:GetRandomPlayer(0))\par
end\par
\par
function Sheep(pUnit, event)\par
pUnit:FullCastSpellOnTarget(12826, pUnit:GetRandomPlayer(0))\par
end\par
}
 