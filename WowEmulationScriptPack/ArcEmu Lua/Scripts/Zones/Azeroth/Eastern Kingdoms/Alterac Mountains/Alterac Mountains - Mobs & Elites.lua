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
--Alterac Mountains Lua script written by DarkRavenMixage

-- Argus Shadow Mage
function argusshadowmage_shadowbolt(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20816, plr)
	end
end

function argusshadowmage_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("argusshadowmage_shadowbolt", math.random(4000,7000), 0)
end

function argusshadowmage_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2318, 1, "argusshadowmage_OnCombat")
RegisterUnitEvent(2318, 2, "argusshadowmage_OnLeaveCombat")

-- Baron Vardus

function baronvardus_frostbolt(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20822, plr)
	end
end

function baronvardus_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("baronvardus_frostbolt", math.random(4000,7000), 0)
end

function baronvardus_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2306, 1, "baronvardus_OnCombat")
RegisterUnitEvent(2306, 2, "baronvardus_OnLeaveCombat")

-- Crushridge Enforcer

function crushridgeenforcerhead_crack(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(9791, plr)
	end
end

function crushridgeenforcer_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("crushridgeenforcerhead_crack", 20000, 0)
end

function crushridgeenforcer_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2256, 1, "crushridgeenforcer_OnCombat")
RegisterUnitEvent(2256, 2, "crushridgeenforcer_OnLeaveCombat")

-- Crushridge Mage
function crushridgemage_frostbolt(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(9672, plr)
	end
end

function crushridgemage_bloodlust(pUnit, Event)
	pUnit:CastSpell(6742)
end

function crushridgemage_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("crushridgemage_frostbolt", 4000, 0)
	pUnit:RegisterEvent("crushridgemage_bloodlust", 16000, 1)
end

function crushridgemage_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2255, 1, "crushridgemage_OnCombat")
RegisterUnitEvent(2255, 2, "crushridgemage_OnLeaveCombat")

-- Crushridge Mauler
function crushridgemauler_backhand(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6253, plr)
	end
end

function crushridgemauler_strike(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11976, plr)
	end
end

function crushridgemauler_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("crushridgemauler_backhand", 15000, 0)
	pUnit:RegisterEvent("crushridgemauler_strike", 8000, 6)
end

function crushridgemauler_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2254, 1, "crushridgemauler_OnCombat")
RegisterUnitEvent(2254, 2, "crushridgemauler_OnLeaveCombat")

-- Crushridge Plunderer
function crushridgeplunderer_Cleave(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
		if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(15496, plr)
		end
end

function crushridgeplunderer_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("crushridgeplunderer_Cleave", math.random(7500,20000), 0)
end

function crushridgeplunderer_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2416, 1, "crushridgeplunderer_OnCombat")
RegisterUnitEvent(2416, 2, "crushridgeplunderer_OnLeaveCombat")

-- Crushridge Warmonger
function crushridgewarmonger_enrage(pUnit, Event)
	pUnit:CastSpell(8269)
end

function crushridgewarmonger_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("crushridgewarmonger_enrage", 30000, 0)
end

function crushridgewarmonger_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2287, 1, "crushridgewarmonger_OnCombat")
RegisterUnitEvent(2287, 2, "crushridgewarmonger_OnLeaveCombat")

-- Cyclonian

function cyclonian_gustofwind(pUnit, Event)
	pUnit:CastSpell(6982)
end

function cyclonian_whirlwind(pUnit, Event)
	pUnit:CastSpell(15576)
end

function cyclonianknock_away(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(18670, plr)
	end
end

function cyclonian_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("cyclonian_gustofwind", 20000, 0)
	pUnit:RegisterEvent("cyclonian_whirlwind", 30000, 0)
	pUnit:RegisterEvent("cyclonianknock_away", 15000, 0)
end

function cyclonian_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(6239, 1, "cyclonian_OnCombat")
RegisterUnitEvent(6239, 2, "cyclonian_OnLeaveCombat")

-- Drunken Footpad
function drunkenfootpad_strike(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(13584, plr)
	end
end

function drunkenfootpad_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("drunkenfootpad_strike", 20000, 0)
end

function drunkenfootpad_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2440, 1, "drunkenfootpad_OnCombat")
RegisterUnitEvent(2440, 2, "drunkenfootpad_OnLeaveCombat")

-- Giant Moss Creeper
function giantmosscreeper_poison(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3396, plr)
	end
end

function giantmosscreeper_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("giantmosscreeper_poison", 20000, 0)
end

function giantmosscreeper_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2349, 1, "giantmosscreeper_OnCombat")
RegisterUnitEvent(2349, 2, "giantmosscreeper_OnLeaveCombat")

-- Giant Yeti
function giantyetifrost_breath(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3131, plr)
	end
end

function giantyeti_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("giantyetifrost_breath", 14000, 5)
end

function giantyeti_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2251, 1, "giantyeti_OnCombat")
RegisterUnitEvent(2251, 2, "giantyeti_OnLeaveCombat")

-- Glommus
function glommus_knockdown(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11428, plr)
	end
end

function glommus_battle(pUnit, Event)
	pUnit:CastSpell(9128)
end

function glommus_demoralizing(pUnit, Event)
	pUnit:CastSpell(13730)
end

function glommus_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("glommus_battle", 2000, 1)
	pUnit:RegisterEvent("glommus_demoralizing", 3500, 1)
	pUnit:RegisterEvent("glommus_knockdown", 15000, 0)
end

function glommus_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2422, 1, "glommus_OnCombat")
RegisterUnitEvent(2422, 2, "glommus_OnLeaveCombat")

-- Grelborg
function grelborg_rof(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11990, plr)
	end
end

function grelborg_flameward(pUnit, Event)
	pUnit:CastSpell(4979)
end

function grelborg_bloodlust(pUnit, Event)
	pUnit:CastSpell(6742)
end

function grelborg_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("grelborg_rof", 25000, 0)
	pUnit:RegisterEvent("grelborg_flameward", 10000, 0)
	pUnit:RegisterEvent("grelborg_bloodlust", 20000, 1)
end

function grelborg_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2417, 1, "grelborg_OnCombat")
RegisterUnitEvent(2417, 2, "grelborg_OnLeaveCombat")

-- Borhuin
function borhuin_disarm(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(8379, plr)
	end
end

function borhuin_net(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6533, plr)
	end
end

function borhuin_pummel(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(12555, plr)
	end
end

function borhuin_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("borhuin_disarm", 20000, 0)
	pUnit:RegisterEvent("borhuin_net", 38000, 0)
	pUnit:RegisterEvent("borhuin_pummel", 25000, 2)
end

function borhuin_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2431, 1, "borhuin_OnCombat")
RegisterUnitEvent(2431, 2, "borhuin_OnLeaveCombat")

-- Lo'Grosh
function logrosh_bloodlust(pUnit, Event)
	pUnit:CastSpell(6742)
end

function logrosh_fireshield(pUnit, Event)
	pUnit:CastSpell(2601)
end

function logrosh_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("logrosh_bloodlust", 30000, 0)
	pUnit:RegisterEvent("logrosh_fireshield", 2000, 1)
end

function logrosh_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2453, 1, "logrosh_OnCombat")
RegisterUnitEvent(2453, 2, "logrosh_OnLeaveCombat")

-- Lord Alyden Perenolde
function perenolde_pws(pUnit, Event)
	pUnit:CastSpell(11974)
end

function perenolde_renew(pUnit, Event)
	pUnit:CastSpell(8362)
end

function perenolde_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("perenolde_pws", 2000, 1)
	pUnit:RegisterEvent("perenolde_renew", 20000, 1)
end

function perenolde_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2423, 1, "perenolde_OnCombat")
RegisterUnitEvent(2423, 2, "perenolde_OnLeaveCombat")

-- Mountain Yeti
function mountainyetifrost_breath(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(3131, plr)
	end
end

function mountainyeti_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("mountainyetifrost_breath", 15000, 6)
end

function mountainyeti_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2250, 1, "mountainyeti_OnCombat")
RegisterUnitEvent(2250, 2, "mountainyeti_OnLeaveCombat")

-- Muckrake
function muckrake_disarm(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(8379, plr)
	end
end

function muckrake_pummel(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(12555, plr)
	end
end

function muckrake_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("muckrake_disarm", 15000, 4)
	pUnit:RegisterEvent("muckrake_pummel", 30000, 0)
end

function muckrake_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2421, 1, "muckrake_OnCombat")
RegisterUnitEvent(2421, 2, "muckrake_OnLeaveCombat")

-- Mug'Thol
function mugthol_strike(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11976, plr)
	end
end

function mugthol_demoralizing(pUnit, Event)
	pUnit:CastSpell(13730)
end

function mugthol_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("mugthol_demoralizing", 2000, 1)
	pUnit:RegisterEvent("mugthol_strike", 20000, 0)
end

function mugthol_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2257, 1, "mugthol_OnCombat")
RegisterUnitEvent(2257, 2, "mugthol_OnLeaveCombat")

-- NarillaSanz
function narillasanz_fb(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(9573, plr)
	end
end

function narillasanz_renew(pUnit, Event)
	pUnit:CastSpell(8362)
end

function narillasanz_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("narillasanz_fb", 15000, 0)
	pUnit:RegisterEvent("narillasanz_renew", 30000, 1)
end

function narillasanz_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2447, 1, "narillasanz_OnCombat")
RegisterUnitEvent(2447, 2, "narillasanz_OnLeaveCombat")

-- Skhowl
function skhowl_demo(pUnit, Event)
	pUnit:CastSpell(15971)
end

function skhowl_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("skhowl_demo", 20000, 0)
end

function skhowl_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2452, 1, "skhowl_OnCombat")
RegisterUnitEvent(2452, 2, "skhowl_OnLeaveCombat")

--  Stone Fury
function stonefury_gt(pUnit, Event)
	pUnit:CastSpell(6524)
end

function stonefury_trample(pUnit, Event)
	pUnit:CastSpell(5568)
end

function stonefury_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("stonefury_gt", 20000, 1)
	pUnit:RegisterEvent("stonefury_trample", 30000, 0)
end

function stonefury_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2258, 1, "stonefury_OnCombat")
RegisterUnitEvent(2258, 2, "stonefury_OnLeaveCombat")

-- Syndicate Assassin
function syndicateassassin_poison(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(744, plr)
	end
end

function syndicateassassin_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicateassassin_poison", 20000, 0)
end

function syndicateassassin_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2246, 1, "syndicateassassin_OnCombat")
RegisterUnitEvent(2246, 2, "syndicateassassin_OnLeaveCombat")

-- Syndicate Enforcer
function syndicateenforcer_whirlwind(pUnit, Event)
	pUnit:CastSpell(15576)
end

function syndicateenforcer_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicateenforcer_whirlwind", 20000, 0)
end

function syndicateenforcer_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2247, 1, "syndicateenforcer_OnCombat")
RegisterUnitEvent(2247, 2, "syndicateenforcer_OnLeaveCombat")

-- Syndicate Footpad
function syndicatefootpad_bs(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7159, plr)
	end
end

function syndicatefootpad_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicatefootpad_bs", 20000, 0)
end

function syndicatefootpad_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2240, 1, "syndicatefootpad_OnCombat")
RegisterUnitEvent(2240, 2, "syndicatefootpad_OnLeaveCombat")

-- Syndicate Saboteur
function syndicatesaboteur_shot(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6660, plr)
	end
end

function syndicatesaboteur_fshot(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6980, plr)
	end
end


function syndicatesaboteur_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicate_saboteur_shot", 10000, 0)
	pUnit:RegisterEvent("syndicate_saboteur_fshot", 20000, 0)
end

function syndicatesaboteur_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2245, 1, "syndicatesaboteur_OnCombat")
RegisterUnitEvent(2245, 2, "syndicatesaboteur_OnLeaveCombat")

-- Syndicate Sentry
function syndicatesentry_sb(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(11972, plr)
	end
end

function syndicatesentry_sw(pUnit, Event)
	pUnit:CastSpell(15062)
end

function syndicatesentry_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicatesentry_sb", 15000, 0)
	pUnit:RegisterEvent("syndicatesentry_sw", 20000, 1)
end

function syndicatesentry_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2243, 1, "syndicatesentry_OnCombat")
RegisterUnitEvent(2243, 2, "syndicatesentry_OnLeaveCombat")

-- Syndicate Spy
function syndicatespy_bs(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(7159, plr)
	end
end

function syndicatespy_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicatespy_bs", 20000, 0)
end

function syndicatespy_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2242, 1, "syndicatespy_OnCombat")
RegisterUnitEvent(2242, 2, "syndicatespy_OnLeaveCombat")

-- Syndicate Thief

function syndicatethief_disarm(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(6713, plr)
	end
end

function syndicatethief_poison(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(744, plr)
	end
end

function syndicatethief_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicatethief_poison", 30000, 1)
	pUnit:RegisterEvent("syndicatethief_disarm", 15000, 0)
end

function syndicatethief_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2241, 1, "syndicatethief_OnCombat")
RegisterUnitEvent(2241, 2, "syndicatethief_OnLeaveCombat")

-- Syndicate Wizard

function syndicatewizard_fireball(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(20815, plr)
	end
end

function syndicatewizard_frostarmor(pUnit, Event)
	pUnit:CastSpell(12544)
end

function syndicatewizard_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("syndicatewizard_fireball", 5000, 0)
	pUnit:RegisterEvent("syndicatewizard_frostarmor", 2000, 1)
end

function syndicatewizard_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2319, 1, "syndicatewizard_OnCombat")
RegisterUnitEvent(2319, 2, "syndicatewizard_OnLeaveCombat")

-- Targ
function targ_cleave(pUnit, Event)
local plr = pUnit:GetClosestPlayer()
	if (plr ~= nil) then
		pUnit:FullCastSpellOnTarget(15496, plr)
	end
end

function targ_thunderclap(pUnit, Event)
	pUnit:CastSpell(8147)
end

function targ_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("targ_cleave", 25000, 0)
	pUnit:RegisterEvent("targ_thunderclap", 10000, 0)
end

function targ_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(2420, 1, "targ_OnCombat")
RegisterUnitEvent(2420, 2, "targ_OnLeaveCombat")