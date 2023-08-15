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

Area - Azuremyst Isle - Mobs.lua by Justin 
Area - Azuremyst Isle - MobsV2.lua by Yerney
-- ]]


--Blood Elf Bandit
function BloodElfBandit_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodElfBandit_Spellname", 3000, 0)
	Unit:RegisterEvent("BloodElfBandit_Spellnamq", 6000, 0)
end

function BloodElfBandit_Spellname(pUnit, Event)
	pUnit:CastSpellOnTarget(14873, pUnit:GetClosestPlayer()) 
end

function BloodElfBandit_Spellnamq(pUnit, Event)
	pUnit:CastSpellOnTarget(15691, pUnit:GetClosestPlayer())
end

function BloodElfBandit_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BloodElfBandit_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17591, 1, "BloodElfBandit_OnCombat")
RegisterUnitEvent(17591, 2, "BloodElfBandit_OnLeaveCombat")
RegisterUnitEvent(17591, 4, "BloodElfBandit_OnDied")

--Abberant Owlbeast
function AbberantOwlBeast_OnCombat(Unit, Event)
	Unit:RegisterEvent("AbberantOwlBeast_Spellname", 12000, 0)
end

function AbberantOwlBeast_Spellname(pUnit, Event)
	pUnit:FullCastSpellOnTarget(31270, pUnit:GetClosestPlayer()) 
end

function AbberantOwlBeast_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function AbberantOwlBeast_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17187, 1, "AbberantOwlBeast_OnCombat")
RegisterUnitEvent(17187, 2, "AbberantOwlBeast_OnLeaveCombat")
RegisterUnitEvent(17187, 4, "AbberantOwlBeast_OnDied")

--Blood Elf Scout
function BloodElfScout_OnCombat(Unit, Event)
	Unit:SendChatMessage(12, 0, "We won't allow you to leave this valley!")
	Unit:RegisterEvent("BloodElfScout_Spellname", 12000, 0)
end

function BloodElfScout_Spellname(pUnit, Event)
	pUnit:CastSpellOnTarget(25602, pUnit:GetRandomPlayer(0))
end

function BloodElfScout_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function BloodElfScout_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(16521, 1, "BloodElfScout_OnCombat")
RegisterUnitEvent(16521, 2, "BloodElfScout_OnLeaveCombat")
RegisterUnitEvent(16521, 4, "BloodElfScout_OnDied")

--Chieftain
function Chieftain_OnCombat(Unit, Event)
	Unit:SendChatMessage(12, 0, "We won't allow you to leave this valley!")
	Unit:RegisterEvent("Chieftain_Spellname", 9000, 0)
	Unit:RegisterEvent("Chieftain_enrage", 16000, 1)
end

function Chieftain_Spellname(pUnit, Event)
	pUnit:CastSpellOnTarget(13446, pUnit:GetClosestPlayer())
end

function Chieftain_enrage(pUnit, Event)
	pUnit:CastSpell(18501) 
end

function Chieftain_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function Chieftain_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17448, 1, "Chieftain_OnCombat")
RegisterUnitEvent(17448, 2, "Chieftain_OnLeaveCombat")
RegisterUnitEvent(17448, 4, "Chieftain_OnDied")

--Hauteur
function Hauteur_OnCombat(Unit, Event)
	Unit:RegisterEvent("Hauteur_Spellname", 12000, 1)
	Unit:RegisterEvent("Hauteur_enrage", 6000, 1)
end

function Hauteur_Spellname(pUnit, Event)
	pUnit:CastSpellOnTarget(8050, pUnit:GetClosestPlayer())
end

function Hauteur_enrage(pUnit, Event)
	pUnit:CastSpell(134) 
end

function Hauteur_OnDied(Unit, Event) --F3--
	Unit:RemoveEvents()
end

function Hauteur_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17206, 1, "Hauteur_OnCombat")
RegisterUnitEvent(17206, 2, "Hauteur_OnLeaveCombat")
RegisterUnitEvent(17206, 4, "Hauteur_OnDied")

--Ravager Specimen
function RavagerSpecimen_OnCombat(Unit, Event)
	Unit:RegisterEvent("RavagerSpecimen_Spellname", 4000, 0)
end

function RavagerSpecimen_Spellname(pUnit, Event)
	pUnit:CastSpellOnTarget(13443, pUnit:GetClosestPlayer())
end

function RavagerSpecimen_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

function RavagerSpecimen_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(17199, 1, "RavagerSpecimen_OnCombat")
RegisterUnitEvent(17199, 2, "RavagerSpecimen_OnLeaveCombat")
RegisterUnitEvent(17199, 4, "RavagerSpecimen_OnDied")

-- BristleLimb WindCaller
function BristleLimbWindCaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristleLimbWindCaller_Reju", 1000, 0)
	Unit:RegisterEvent("BristleLimbWindCaller_WindShock", 7000, 1)
end

function BristleLimbWindCaller_Reju(Unit, Event)
	if Unit:GetHealthPct() < 15 then
		Unit:CastSpell(32131)
	end
end

function BristleLimbWindCaller_WindShock(pUnit, Event)
	pUnit:FullCastSpellOnTarget(31272, pUnit:GetClosestPlayer())
end

function BristleLimbWindCaller_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function BristleLimbWindCaller_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17184, 1, "BristleLimbWindCaller_OnCombat")
RegisterUnitEvent(17184, 2, "BristleLimbWindCaller_OnLeaveCombat")
RegisterUnitEvent(17184, 4, "BristleLimbWindCaller_OnDead")

-- WrathScaleMyrmidon
function WrathScaleMyrmidon_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathScaleMyrmidon_Strike", 5000, 0)
end

function WrathScaleMyrmidon_Strike(pUnit, Event)
	pUnit:FullCastSpellOnTarget(31272, pUnit:GetClosestPlayer())
end

function WrathScaleMyrmidon_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function WrathScaleMyrmidon_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17194, 1, "WrathScaleMyrmidon_OnCombat")
RegisterUnitEvent(17194, 2, "WrathScaleMyrmidon_OnLeaveCombat")
RegisterUnitEvent(17194, 4, "WrathScaleMyrmidon_OnDead")

-- WrathScaleNage
function WrathScaleNage_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathScaleNage_Strike", 12000, 1)
end

function WrathScaleNage_Strike(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9080, pUnit:GetClosestPlayer())
end

function WrathScaleNage_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function WrathScaleNage_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17193, 1, "WrathScaleNage_OnCombat")
RegisterUnitEvent(17193, 2, "WrathScaleNage_OnLeaveCombat")
RegisterUnitEvent(17193, 4, "WrathScaleNage_OnDead")

-- WrathScaleSiren
function WrathScaleSiren_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathScaleSiren_Scream", 12000, 1)
end

function WrathScaleSiren_Scream(pUnit, Event)
	pUnit:CastSpell(31273)
end

function WrathScaleSiren_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()
end

function WrathScaleSiren_OnDead(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(17195, 1, "WrathScaleSiren_OnCombat")
RegisterUnitEvent(17195, 2, "WrathScaleSiren_OnLeaveCombat")
RegisterUnitEvent(17195, 4, "WrathScaleSiren_OnDead")

-- Injured Draenei 
function InjuredDraenei_OnSpawn(pUnit, event)
InjuredDraeneiChance = math.random(1, 2)
	if (InjuredDraeneiChance == 1) then
		pUnit:SetStandState(3)
	end
	if (InjuredDraeneiChance == 2) then
		pUnit:SetStandState(1)
		pUnit:SetCombatCapable(0)
	end
end

RegisterUnitEvent(16971, 6, "InjuredDraenei_OnSpawn")

-- DraeneiSurvivor
function DraeneiSurvivor_OnSpawn(pUnit, event)
SurvivorDraeneiChance = math.random(1, 3)
	if (SurvivorDraeneiChance == 1) then
		pUnit:SetStandState(3)
	end
	if (SurvivorDraeneiChance == 2) then
		pUnit:CastSpell(28630)
		pUnit:SetStandState(1)
	end
	if (SurvivorDraeneiChance == 3) then
		pUnit:CastSpell(28630)
		pUnit:SetCombatCapable(0)
	end
end

RegisterUnitEvent(16483, 6, "DraeneiSurvivor_OnSpawn")