--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 27, 2009. ]]

--// Crimson Hammersmith
function Crimson_speak (unit, event)
	unit:SendChatMessage(5, 0, "Who Dares Disturb Me?")
end
RegisterUnitEvent (11120, 1, "Crimson_speak")

--// Lazy Peon
function Lazypeon_sleep (unit, event)
	unit:CastSpell(18975)
	unit:RegisterEvent("Lazypeon_sleep", math.random(180000,185000), 1)
end
RegisterUnitEvent (10556, 1, "Lazypeon_sleep")

--// SavannahProwler ... 180000 = 3 minutes
function Prowler_sleep (unit, event)
	unit:Emote(12)
	unit:RegisterEvent("Prowler_sleep", math.random(180000,185000), 1)
end

function Prowler_onCombat(unit, event)
	unit:RemoveEvents()
end


RegisterUnitEvent (3425, 6, "Prowler_sleep")
RegisterUnitEvent (3425, 1, "Prowler_onCombat")

--// Biletoad
function Biletoad_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(10251,Unit:GetClosestPlayer())
end

RegisterUnitEvent(2835, 1, "Biletoad_OnEnterCombat")

--// Cat
function Cat_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(16828,Unit:GetClosestPlayer())
	Unit:FullCastSpellOnTarget(14916,Unit:GetClosestPlayer())
end

RegisterUnitEvent(6368, 1, "Cat_OnEnterCombat")

--// Cow
function Cow_OnDied(Unit,Event)
	Unit:SendChatMessage(12, 0, "Moo!")
end

RegisterUnitEvent(2442, 4, "Cow_OnDied")

--// Effsee
function Effsee_OnSpawn(Unit,Event)
	Unit:RegisterEvent("Effsee_Meow", 50000, 0)
end

function Effsee_Meow(Unit,Event)
	Unit:SendChatMessage(11, 0, "Meow")
end

function Effsee_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function Effsee_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(8963, 6, "Effsee_OnSpawn")
RegisterUnitEvent(8963, 2, "Effsee_OnLeaveCombat")
RegisterUnitEvent(8963, 4, "Effsee_OnDied")
--// Plagued Insect
function PlaguedInsect_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(16460,Unit:GetClosestPlayer())
end

RegisterUnitEvent(10461, 1, "PlaguedInsect_OnEnterCombat")
--// Plagued Maggot
function PlaguedMaggot_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(16449,Unit:GetClosestPlayer())
end

RegisterUnitEvent(10536, 1, "PlaguedMaggot_OnEnterCombat")
--// Plagued Rat
function PlaguedRat_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(16448,Unit:GetClosestPlayer())
end

RegisterUnitEvent(10441, 1, "PlaguedRat_OnEnterCombat")
--// Sickly Deer
function SicklyDeer_OnSpawn(Unit,Event)
	Unit:RegisterEvent("SicklyDeer_Die", 180000, 0)
end

function SicklyDeer_Die(Unit,Event)
	Unit:CastSpell(5)
end

function SicklyDeer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function SicklyDeer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(12298, 6, "SicklyDeer_OnSpawn")
--// Soot
function Soot_OnSpawn(Unit,Event)
	Unit:CastSpell(35112)
end

RegisterUnitEvent(19154, 6, "Soot_OnSpawn")
--// Spider
function Spider_OnEnterCombat(Unit,Event)
	Unit:FullCastSpellOnTarget(27138,Unit:GetClosestPlayer())
end

RegisterUnitEvent(14881, 1, "Spider_OnEnterCombat")
--// Dummy
--// Somebody had to do this sooner, or later.
function Dummy_OnSpawn(Unit,Event)
	Unit:SetCombatCapable(1)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatRangedCapable(1)
	Unit:SetCombatSpellCapable(1)
	Unit:SetCombatTargetingCapable(1)
end

RegisterUnitEvent(32545, 18, "Dummy_OnSpawn")
RegisterUnitEvent(31146, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32546, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32543, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32667, 18, "Dummy_OnSpawn")
RegisterUnitEvent(31144, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32666, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32541, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32545, 18, "Dummy_OnSpawn")
RegisterUnitEvent(32542, 18, "Dummy_OnSpawn")
RegisterUnitEvent(30527, 18, "Dummy_OnSpawn")
RegisterUnitEvent(25225, 18, "Dummy_OnSpawn")
RegisterUnitEvent(25297, 18, "Dummy_OnSpawn")
RegisterUnitEvent(17578, 18, "Dummy_OnSpawn")
RegisterUnitEvent(19139, 18, "Dummy_OnSpawn")
RegisterUnitEvent(18504, 18, "Dummy_OnSpawn")
RegisterUnitEvent(16897, 18, "Dummy_OnSpawn")
RegisterUnitEvent(17059, 18, "Dummy_OnSpawn")
RegisterUnitEvent(5652, 18, "Dummy_OnSpawn")
RegisterUnitEvent(1921, 18, "Dummy_OnSpawn")
RegisterUnitEvent(4952, 18, "Dummy_OnSpawn")
RegisterUnitEvent(5723, 18, "Dummy_OnSpawn")