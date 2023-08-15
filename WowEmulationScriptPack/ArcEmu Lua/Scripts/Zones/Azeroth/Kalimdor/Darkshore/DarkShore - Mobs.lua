--[[
*******************************************************
*          LASP - LUA AREA SCRIPTING PROJECT                         *
*                                     License                                                        *
*******************************************************
This software is provided as free and open source by the
staff of The Lua Area Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

Area - DarkShore - Mobs.lua by Yerney
Report Bugs at www.lasp.forumotion.com
Based off: http://www.wowhead.com/?npcs&filter=ra=-1;rh=-1;cr=6;crs=148;crv=0
Enjoy :)

NPC's that I won't do:
- BlackWood Warrior; Battle Stance is kinda useless imo..
- Reef Shark - No Abilities
- Moon..... Stalker - Spawns a little friend to help him, doesn't work

NPC´s that I will do later:
-Twilight Disciple 16 - 17 Darkshore A H Humanoid 
-Twilight Thug 17 - 18 Darkshore A H Humanoid 
-Wailing Highborne 12 - 13 Darkshore A H Undead 
-Wild Grell 11 - 12 Darkshore A H Humanoid 
-Writhing Highborne 11 - 12 Darkshore A H Undead 
-Young Moonkin 

--]]     

--  BlackWoodPathFinder
function BlackWoodPathFinder_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BlackWoodPathFinder_Faerie", math.random(6500, 9000), 1)
	pUnit:RegisterEvent("BlackWoodPathFinder_Thrash", math.random(4000, 6000), 2)
end

function BlackWoodPathFinder_Faerie(pUnit, Event)
	pUnit:FullCastSpellOnTarget(6950, pUnit:GetClosestPlayer())
end

function BlackWoodPathFinder_Thrash(pUnit, Event)
	pUnit:CastSpell(3391)
end

function BlackWoodPathFinder_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function BlackWoodPathFinder_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2167, 1, "BlackWoodPathFinder_OnCombat")
RegisterUnitEvent(2167, 2, "BlackWoodPathFinder_OnLeaveCombat")
RegisterUnitEvent(2167, 4, "BlackWoodPathFinder_OnDead")

--  BlackWoodTotemic
function BlackWoodTotemic_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BlackWoodTotemic_Totem", math.random(6500, 9000), 1)
end

function BlackWoodTotemic_Totem(pUnit, Event)  -- Could be that this one needs core support tho,..
	pUnit:FullCastSpell(5605)
end

function BlackWoodTotemic_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function BlackWoodTotemic_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2169, 1, "BlackWoodTotemic_OnCombat")
RegisterUnitEvent(2169, 2, "BlackWoodTotemic_OnLeaveCombat")
RegisterUnitEvent(2169, 4, "BlackWoodTotemic_OnDead")

--  BlackWoodUrsa
function BlackWoodUrsa_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BlackWoodUrsa_Heal", 1000, 0)
end

function BlackWoodUrsa_Heal(pUnit, Event)
	if (pUnit:GetHealthPct() < 15) then
		pUnit:FullCastSpell(1058)
	end
end

function BlackWoodUrsa_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function BlackWoodUrsa_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2170, 1, "BlackWoodUrsa_OnCombat")
RegisterUnitEvent(2170, 2, "BlackWoodUrsa_OnLeaveCombat")
RegisterUnitEvent(2170, 4, "BlackWoodUrsa_OnDead")

--  BlackWoodWindTalker
function BlackWoodWindTalker_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BlackWoodWindTalker_Wind", 7500, 1)
end

function BlackWoodWindTalker_Wind(pUnit, Event)
	pUnit:FullCastSpell(6982)
end

function BlackWoodWindTalker_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function BlackWoodWindTalker_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2324, 1, "BlackWoodWindTalker_OnCombat")
RegisterUnitEvent(2324, 2, "BlackWoodWindTalker_OnLeaveCombat")
RegisterUnitEvent(2324, 4, "BlackWoodWindTalker_OnDead")

--  DarkStrandFanatic
function DarkStrandFanatic_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("DarkStrandFanaticr_Mending", math.random(6000,20000), 1)
end

function DarkStrandFanaticr_Mending(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7098, pUnit:GetClosestPlayer())
end

function DarkStrandFanatic_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function DarkStrandFanatic_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2336, 1, "DarkStrandFanatic_OnCombat")
RegisterUnitEvent(2336, 2, "DarkStrandFanatic_OnLeaveCombat")
RegisterUnitEvent(2336, 4, "DarkStrandFanatic_OnDead")

--  DarkStrandVoidCaller - Summon Voidwalker doesn´t work
function DarkStrandVoidCaller_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("DarkStrandVoidCaller_ShadowBolt", math.random(3000,6000), 0)
end

function DarkStrandVoidCaller_ShadowBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(20807, pUnit:GetClosestPlayer())
end

function DarkStrandVoidCaller_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function DarkStrandVoidCaller_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2337, 1, "DarkStrandVoidCaller_OnCombat")
RegisterUnitEvent(2337, 2, "DarkStrandVoidCaller_OnLeaveCombat")
RegisterUnitEvent(2337, 4, "DarkStrandVoidCaller_OnDead")

-- Delmanis the Hated
function Delmanis_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Delmanis_FrostBolt", math.random(3000,6000), 0)
	pUnit:RegisterEvent("Delmanis_FireBlast", math.random(8000,15000), 2)
end

function Delmanis_FrostBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(20972, pUnit:GetClosestPlayer())
end

function Delmanis_FireBlast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7101, pUnit:GetClosestPlayer())
end

function Delmanis_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function Delmanis_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3662, 1, "Delmanis_OnCombat")
RegisterUnitEvent(3662, 2, "Delmanis_OnLeaveCombat")
RegisterUnitEvent(3662, 4, "Delmanis_OnDead")

--Elder DarkShore Thrasher
function ElderDarkshoreThrasher_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("ElderDarkshoreThrasher_PierceArmor", math.random(8000,15000), 2)
end

function ElderDarkshoreThrasher_PierceArmor(pUnit, Event)
	pUnit:FullCastSpellOnTarget(6016, pUnit:GetClosestPlayer())
end

function ElderDarkshoreThrasher_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function ElderDarkshoreThrasher_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2187, 1, "ElderDarkshoreThrasher_OnCombat")
RegisterUnitEvent(2187, 2, "ElderDarkshoreThrasher_OnLeaveCombat")
RegisterUnitEvent(2187, 4, "ElderDarkshoreThrasher_OnDead")

--GreyMistSeer
function GreyMistSeer_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("GreyMistSeer_LightningBolt", math.random(3000,5000), 10)
	pUnit:RegisterEvent("GreyMistSeer_HealingWave", 1000, 0)
	pUnit:RegisterEvent("GreyMistSeer_LightningShield", 500, 1)
end

function GreyMistSeer_LightningBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(26364, pUnit:GetClosestPlayer())
end

function GreyMistSeer_HealingWave(pUnit, Event)
	if (pUnit:GetHealthPct() < 15) then
		pUnit:FullCastSpell(547)
	end
end

function GreyMistSeer_LightningShield(pUnit, Event)
	pUnit:FullCastSpell(324)
end

function GreyMistSeer_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function GreyMistSeer_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2203, 1, "GreyMistSeer_OnCombat")
RegisterUnitEvent(2203, 2, "GreyMistSeer_OnLeaveCombat")
RegisterUnitEvent(2203, 4, "GreyMistSeer_OnDead")

--GrizzledThistleBear
function GrizzledThistleBear_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("GrizzledThistleBear_Ravage", math.random(6000,9000), 10)
end

function GrizzledThistleBear_Ravage(pUnit, Event)
	pUnit:FullCastSpellOnTarget(3242, pUnit:GetClosestPlayer())
end

function GrizzledThistleBear_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function GrizzledThistleBear_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2165, 1, "GrizzledThistleBear_OnCombat")
RegisterUnitEvent(2165, 2, "GrizzledThistleBear_OnLeaveCombat")
RegisterUnitEvent(2165, 4, "GrizzledThistleBear_OnDead")
RegisterUnitEvent(2163, 1, "GrizzledThistleBear_OnCombat")
RegisterUnitEvent(2163, 2, "GrizzledThistleBear_OnLeaveCombat")
RegisterUnitEvent(2163, 4, "GrizzledThistleBear_OnDead")

--LadyVespira
function LadyVespira_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("LadyVespira_Fork", math.random(12000,15000), 4)
end

function LadyVespira_Fork(pUnit, Event)
	pUnit:FullCastSpell(12549)
end

function LadyVespira_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function LadyVespira_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(7016, 1, "LadyVespira_OnCombat")
RegisterUnitEvent(7016, 2, "LadyVespira_OnLeaveCombat")
RegisterUnitEvent(7016, 4, "LadyVespira_OnDead")

--Moonkin
function Moonkin_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Moonkin_Thrash", math.random(12000,15000), 4)
end

function Moonkin_Thrash(pUnit, Event)
	pUnit:FullCastSpell(3391)
end

function Moonkin_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function Moonkin_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(10158, 1, "Moonkin_OnCombat")
RegisterUnitEvent(10158, 2, "Moonkin_OnLeaveCombat")
RegisterUnitEvent(10158, 4, "Moonkin_OnDead")

--MoonkinOracle
function MoonkinOracle_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("MoonkinOracle_Wrath", math.random(5000,8000), 0)
end

function MoonkinOracle_Wrath(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9739, pUnit:GetClosestPlayer())
end

function MoonkinOracle_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function MoonkinOracle_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(10157, 1, "MoonkinOracle_OnCombat")
RegisterUnitEvent(10157, 2, "MoonkinOracle_OnLeaveCombat")
RegisterUnitEvent(10157, 4, "MoonkinOracle_OnDead")

--RaginMoonkin
function RaginMoonkin_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("RaginMoonkin_Rend", math.random(5000,8000), 0)
	pUnit:RegisterEvent("RaginMoonkin_Enrage", 1000, 0)
end

function RaginMoonkin_Rend(pUnit, Event)
	pUnit:FullCastSpellOnTarget(13443, pUnit:GetClosestPlayer())
end

function RaginMoonkin_Enrage(Unit, Event)
	if Unit:GetHealthPct() < 15 then
	Unit:CastSpell(8599)
	end
end

function RaginMoonkin_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function RaginMoonkin_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(10160, 1, "RaginMoonkin_OnCombat")
RegisterUnitEvent(10160, 2, "RaginMoonkin_OnLeaveCombat")
RegisterUnitEvent(10160, 4, "RaginMoonkin_OnDead")

--StormScaLeMyrmidon
function StormScameMyrmidion_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("StormScameMyrmidion_KnockDown", 10000, 2)
end

function StormScameMyrmidion_KnockDown(pUnit, Event)
	pUnit:CastSpellOnTarget(5164, pUnit:GetClosestPlayer())
end

function StormScameMyrmidion_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function StormScameMyrmidion_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2181, 1, "StormScameMyrmidion_OnCombat")
RegisterUnitEvent(2181, 2, "StormScameMyrmidion_OnLeaveCombat")
RegisterUnitEvent(2181, 4, "StormScameMyrmidion_OnDead")

--StormScaleSorcerrer
function StormScaleSorcerrer_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("StormScaleSorcerrer_FrostBolt", math.random(3000,8000), 0)
	pUnit:RegisterEvent("StormScaleSorcerrer_FrostArmor", 1000, 1)
end

function StormScaleSorcerrer_FrostBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(20792, pUnit:GetClosestPlayer())
end

function StormScaleSorcerrer_FrostArmor(Unit, Event)
	Unit:CastSpell(12544)
end

function StormScaleSorcerrer_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function StormScaleSorcerrer_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2182, 1, "StormScaleSorcerrer_OnCombat")
RegisterUnitEvent(2182, 2, "StormScaleSorcerrer_OnLeaveCombat")
RegisterUnitEvent(2182, 4, "StormScaleSorcerrer_OnDead")

--StormScaleWarrior
function StormScaleWarrior_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("StormScaleWarrior_Blocking", 10000, 1)
end

function StormScaleWarrior_Blocking(pUnit, Event)
	pUnit:CastSpell(3248)
end

function StormScaleWarrior_OnDead(pUnit, Event)
	pUnit:RemoveEvents()
end

function StormScaleWarrior_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2183, 1, "StormScaleWarrior_OnCombat")
RegisterUnitEvent(2183, 2, "StormScaleWarrior_OnLeaveCombat")
RegisterUnitEvent(2183, 4, "StormScaleWarrior_OnDead")