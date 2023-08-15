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

Area - Mulgore - Mobs.lua by Yerney
Report Bugs at www.lasp.forummotion.com
-- ]]

--Bael'dun Appraiser
function BaelApp_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "Gor eft mitta ta gor-skalf")
if	Unit:GetHealthPct() < 15 then
Unit:FullCastSpell(2052)
end
end

function BaelApp_OnDead(Unit, Event)
Unit:RemoveEvents()
end

function BaelApp_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2990, 1, "BaelApp_OnCombat")
RegisterUnitEvent(2990, 2, "BaelApp_LeaveCombat")
RegisterUnitEvent(2990, 4, "BaelApp_OnDead")

--Bristleback Battleboar
function Battleboar_OnCombat(pUnit, Event)
pUnit:FullCastSpell(3385)
end

function Battleboar_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent (2954, 1, "Battleboar_OnCombat")
RegisterUnitEvent (2954, 2, "Battleboar_LeaveCombat")

--Bristleback Interloper
function Bristleback_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Bristleback_Spell", 3500, 0)
end

function Bristleback_Spell(pUnit, Event)
pUnit:FullCastSpellOnTarget(12166, pUnit:GetClosestPlayer())
end

RegisterUnitEvent (3566, 1, "Bristleback_OnCombat")

--Bristleback Shaman
function BristleSha_OnCombat(Unit, Event)
Unit:RegisterEvent("BristleSha_Spell", 3500, 0)
end

function BristleSha_Spell(pUnit, Event)
pUnit:FullCastSpellOnTarget(13482, pUnit:GetClosestPlayer())
end

function BristleSha_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2953, 1, "BristleSha_OnCombat")
RegisterUnitEvent(2953, 2, "BristleSha_LeaveCombat")

--Galak Outrunner
function GalakOut_OnCombat(pUnit, Event)
pUnit:RegisterEvent("GalakOut_Spell", 3500, 0)
end

function GalakOut_Spell(pUnit, Event)
pUnit:FullCastSpellOnTarget(6660, pUnit:GetClosestPlayer())
end

function GalakOut_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2968, 1, "GalakOut_OnCombat")
RegisterUnitEvent(2968, 2, "GalakOut_LeaveCombat")

--Mazzranach -> Elite
function Mazz_OnCombat(pUnit, Event)
pUnit:CastSpell(6268)
pUnit:RegisterEvent("Mazz_Spell", 5000, 1)
end

function Mazz_Spell(pUnit, Event)
pUnit:FullCastSpellOnTarget(3583, pUnit:GetClosestPlayer())
end

function Mazz_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(3068, 1, "Mazz_OnCombat")
RegisterUnitEvent(3068, 2, "Mazz_LeaveCombat")

--Palemane Poacher
function PalemanePoacher_OnCombat(pUnit, Event)
pUnit:RegisterEvent("PalemanePoacher_Shoot", 3500, 0)
pUnit:RegisterEvent("PalemanePoacher_Shot", 5000, 0)
end

function PalemanePoacher_Shoot(pUnit, Event)
pUnit:FullCastSpellOnTarget(6660, pUnit:GetClosestPlayer())
end

function PalemanePoacher_Shot(pUnit, Event)
pUnit:FullCastSpellOnTarget(1516, pUnit:GetClosestPlayer())
end

function PalemanePoacher_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2951, 1, "PalemanePoacher_OnCombat")
RegisterUnitEvent(2951, 2, "PalemanePoacher_LeaveCombat")

--Palemane Skinner
function PalemaneSkinner_OnCombat(pUnit, Event)
local sayflip=math.random(1,2)
if sayflip==1 then
pUnit:SendChatMessage(12, 0, "Grr... fresh meat!")
elseif sayflip==2 then
pUnit:SendChatMessage(12, 0, "More bones to gnaw on...")
end
pUnit:RegisterEvent("PalemaneSkinner_Spell", 8000, 1)
end

function PalemaneSkinner_Spell(pUnit, Event)
pUnit:FullCastSpell(774)
end

function PalemaneSkinner_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2950, 1, "PalemaneSkinner_OnCombat")
RegisterUnitEvent(2950, 2, "PalemaneSkinner_LeaveCombat")

--Palemane Tanner
function PalemaneTanner_OnCombat(pUnit, Event)
local sayflip=math.random(1,2)
if sayflip==1 then
pUnit:SendChatMessage(12, 0, "Grr... fresh meat!")
elseif sayflip==2 then
pUnit:SendChatMessage(12, 0, "More bones to gnaw on...")
end
pUnit:RegisterEvent("PalemaneTanner_Wrath", 3500, 0)
end

function PalemaneTanner_Wrath(pUnit, Event)
pUnit:FullCastSpellOnTarget(9739, pUnit:GetClosestPlayer())
end

function PalemaneTanner_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2949, 1, "PalemaneTanner_OnCombat")
RegisterUnitEvent(2949, 2, "PalemaneTanner_LeaveCombat")

--Wolves
function Wolves_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Wolves_Bite", 5000, 0)
pUnit:RegisterEvent("Wolves_Howl", 9000, 1)
end

function Wolves_Bite(pUnit, Event)
pUnit:FullCastSpellOnTarget(17255, pUnit:GetClosestPlayer())
end

function Wolves_Howl(pUnit, Event)
pUnit:FullCastSpellOnTarget(5781, pUnit:GetClosestPlayer())
end

function Wolves_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2959, 1, "Wolves_OnCombat")
RegisterUnitEvent(2959, 2, "Wolves_LeaveCombat")
RegisterUnitEvent(2958, 1, "Wolves_OnCombat")
RegisterUnitEvent(2958, 2, "Wolves_LeaveCombat")
RegisterUnitEvent(2960, 1, "Wolves_OnCombat")
RegisterUnitEvent(2960, 2, "Wolves_LeaveCombat")

--SnaggleSpear -> Elite
function SnaggleSpear_OnCombat(pUnit, Event)
pUnit:RegisterEvent("SnaggleSpear_Net", 6000, 1)
end

function SnaggleSpear_Net(pUnit, Event)
pUnit:FullCastSpellOnTarget(12024, pUnit:GetClosestPlayer())
end

function SnaggleSpear_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(5786, 1, "SnaggleSpear_OnCombat")
RegisterUnitEvent(5786, 2, "SnaggleSpear_LeaveCombat")

--Swoop
function Swoop_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Swoop_Swoop", 6000, 0)
end

function Swoop_Swoop(pUnit, Event)
pUnit:FullCastSpell(5708)
end

function Swoop_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2969, 1, "Swoop_OnCombat")
RegisterUnitEvent(2969, 2, "Swoop_LeaveCombat")
RegisterUnitEvent(2970, 1, "Swoop_OnCombat")
RegisterUnitEvent(2970, 2, "Swoop_LeaveCombat")
RegisterUnitEvent(2971, 1, "Swoop_OnCombat")
RegisterUnitEvent(2971, 2, "Swoop_LeaveCombat")

--The Rake -> Elite
function Rake_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Rake_Tear", 7000, 1)
end

function Rake_Tear(pUnit, Event)
pUnit:FullCastSpellOnTarget(12166, pUnit:GetClosestPlayer())
end

function Rake_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(5807, 1, "Rake_OnCombat")
RegisterUnitEvent(5807, 2, "Rake_LeaveCombat")

--Venture Co. Supervisor
function Supervisor_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Supervisor_shout", 7000, 1)
end

function Supervisor_shout(pUnit, Event)
pUnit:FullCastSpell(6673)
end

function Supervisor_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2979, 1, "Supervisor_OnCombat")
RegisterUnitEvent(2979, 2, "Supervisor_LeaveCombat")

--Windfury Matriach
function Matr_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Matr_Wave", 12000, 1)
pUnit:RegisterEvent("Matr_Bolt", 3000, 0)
end

function Matr_Wave(Unit, Event)
Unit:FullCastSpell(332)
end

function Matr_Bolt(pUnit, Event)
pUnit:FullCastSpellOnTarget(9532, pUnit:GetClosestPlayer())
end

function Matr_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2965, 1, "Matr_OnCombat")
RegisterUnitEvent(2965, 2, "Matr_LeaveCombat")

--Windfury Sorceress
function Sorceress_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Sorcer_Bolt", 3000, 0)
end

function Sorcer_Bolt(pUnit, Event)
pUnit:FullCastSpellOnTarget(13322, pUnit:GetClosestPlayer())
end

function Sorceress_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2964, 1, "Sorceress_OnCombat")
RegisterUnitEvent(2964, 2, "Sorceress_LeaveCombat")

--Windfury Wind Witch
function WindWitch_OnCombat(pUnit, Event)
pUnit:RegisterEvent("WindWitch_Wave", 12000, 1)
pUnit:RegisterEvent("Matr_Bolt", 3000, 0)
end

function WindWitch_Wave(pUnit, Event)
pUnit:FullCastSpell(6982)
end

function WindWitch_Bolt(pUnit, Event)
pUnit:FullCastSpellOnTarget(9532, pUnit:GetClosestPlayer())
end

function WindWitch_LeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(2963, 1, "WindWitch_OnCombat")
RegisterUnitEvent(2963, 2, "WindWitch_LeaveCombat")






