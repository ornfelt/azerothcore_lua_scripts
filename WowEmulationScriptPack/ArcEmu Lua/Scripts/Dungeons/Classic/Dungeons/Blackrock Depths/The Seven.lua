-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--Suppose to have a timer for each boss, for example while your trying to kill the first boss
--and the boss is not dead you will have 2 bosses that you gotta deal with if the first boss is 
--NOT dead.


--------------
--			--
-- Hate'rel --
--			--
--------------
--[[
----Quotes
----Spells-ID
Flurry-17687
Shadow Bolt-15232
Shadow Shield-12040
Strike-15580
]]--
function HREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function HREL_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pUnit:SendChatMessage(11, 0, "The death of our flesh marked the birth of our spirit and our sacred task.")
	pUnit:GossipComplete()
	end
end

function HREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("HREL_ShadowShield", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("HREL_Strike", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("HREL_ShadowBolt", 15000, 0) --Time could be wrong
	pUnit:RegisterEvent("HREL_Flurry", 20000, 0) --Time could be wrong
end

function HREL_ShadowShield(pUnit, Event)
	pUnit:CastSpell(12040)
end

function HREL_Strike(pUnit, Event)
	pUnit:CastSpellOnTarget(15580)
end

function HREL_ShadowBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15232)
end

function HREL_Flurry(pUnit, Event)
	pUnit:CastSpell(17687)
end

function HREL_OnLeaveCombat(pUnit, Event)
    pUnit:RemoveEvents()
end

function HREL_OnDeath(pUnit, Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(9034, 1, "HREL_OnCombat")
RegisterUnitEvent(9034, 2, "HREL_OnLeaveCombat")
RegisterUnitEvent(9034, 4, "HREL_OnDeath")
RegisterUnitGossipEvent(9034, 1, "HREL_OnGossipTalk")
RegisterUnitGossipEvent(9034, 2, "HREL_OnGossipSelect")


---------------
--			 --
-- Anger'rel --
--			 --
---------------
--[[
----Quotes
----Spells-ID
Enrage-15061
Shield Block-12169
Shield Wall-15062
Strike-15580
Sunder Armor-11971
]]--
function AREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function AREL_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pUnit:SendChatMessage(11, 0, "Our leader, Doom'rel, has ears for the challenge.")
	pUnit:GossipComplete()
	end
end

function AREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("AREL_SunderArmor", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("AREL_ShieldBlock", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("AREL_Enrage", 15000, 0) --Time could be wrong
	pUnit:RegisterEvent("AREL_ShieldWall", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("AREL_Strike", 25000, 0) --Time could be wrong
end

function AREL_SunderArmor(pUnit, Event)
	pUnit:CastSpellOnTarget(11971)
end

function AREL_ShieldBlock(pUnit, Event)
	pUnit:CastSpell(12169)
end

function AREL_Enrage(pUnit, Event)
	pUnit:CastSpell(15061)
end

function AREL_ShieldWall(pUnit, Event)
	pUnit:CastSpell(15062)
end

function AREL_Strike(pUnit, Event)
	pUnit:CastSpellOnTarget(15580)
end

function AREL_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function AREL_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9035, 1, "AREL_OnCombat")
RegisterUnitEvent(9035, 2, "AREL_OnLeaveCombat")
RegisterUnitEvent(9035, 4, "AREL_OnDeath")
RegisterUnitGossipEvent(9035, 1, "AREL_OnGossipTalk")
RegisterUnitGossipEvent(9035, 2, "AREL_OnGossipSelect")


--------------
--			--
-- Vile'rel --
--			--
--------------
--[[
----Quotes
----Spells-ID
Heal-1556
Mind Blast-15587
Power Word: Shield-11974
Prayer of Healing-15585
]]--
function VREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function VREL_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pUnit:SendChatMessage(11, 0, "Our leader, Doom'rel, has ears for the challenge.")
	pUnit:GossipComplete()
	end
end

function VREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("VREL_Heal", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("VREL_PowerWShield", 25000, 0) --Time could be wrong
	pUnit:RegisterEvent("VREL_PrayerOfHealing", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("VREL_MindBlast", 15000, 0) --Time could be wrong
end

function VREL_Heal(pUnit, Event)
	pUnit:FullCastSpell(15586)
end

function VREL_PowerWShield(pUnit, Event)
	pUnit:CastSpell(11974)
end

function VREL_PrayerOfHealing(pUnit, Event)
	pUnit:FullCastSpell(15585)
end

function VREL_MindBlast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15587)
end

function VREL_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function VREL_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9036, 1, "VREL_OnCombat")
RegisterUnitEvent(9036, 2, "VREL_OnLeaveCombat")
RegisterUnitEvent(9036, 4, "VREL_OnDeath")
RegisterUnitGossipEvent(9036, 1, "VREL_OnGossipTalk")
RegisterUnitGossipEvent(9036, 2, "VREL_OnGossipSelect")


---------------
--			 --
-- Gloom'rel --
--			 --
---------------
--[[
----Quotes
----Spells-ID
Cleave-40504
Hamstring-9080
Mortal Strike-13737
Recklessness-13847
]]--
function GREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function GREL_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pUnit:SendChatMessage(11, 0, "I am forever denied the touch of stone. I will never again know the glory of shaped iron...")
	pUnit:GossipComplete()
	end
end

function GREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("GREL_Rechlessness", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("GREL_Cleave", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("GREL_Hamstring", 5000, 0) --Time could be wrong
	pUnit:RegisterEvent("GREL_MortalStrike", 15000, 0) --Time could be wrong
end

function GREL_Rechlessness(pUnit, Event)
	pUnit:CastSpell(13847)
end

function GREL_Cleave(pUnit, Event)
	pUnit:CastSpell(40504)
end

function GREL_Hamstring(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9080)
end

function GREL_MortalStrike(pUnit, Event)
	pUnit:CastSpellOnTarget(13737)
end

function GREL_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function GREL_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9037, 1, "VREL_OnCombat")
RegisterUnitEvent(9037, 2, "VREL_OnLeaveCombat")
RegisterUnitEvent(9037, 4, "VREL_OnDeath")
RegisterUnitGossipEvent(9037, 1, "VREL_OnGossipTalk")
RegisterUnitGossipEvent(9037, 2, "VREL_OnGossipSelect")


---------------
--			 --
-- Seeth'rel --
--			 --
---------------
--[[
----Quotes
----Spells-ID
Blizzard-8364
Chilled-6136
Cone of Cold-15244
Frost Armor-12544
Frost Nova-12674
Frost Ward-15044
Frostbolt-12675
]]--
function SREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function SREL_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pUnit:SendChatMessage(11, 0, "You may not pass. You are not our kin, nor have you issued the challenge.")
	pUnit:GossipComplete()
	end
end

function SREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("SREL_FrostArmor", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("SREL_ConeOfCold", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("SREL_FrostWard", 5000, 0) --Time could be wrong
	pUnit:RegisterEvent("SREL_Blizzard", 15000, 0) --Time could be wrong
	pUnit:RegisterEvent("SREL_FrostNova", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("SREL_Frostbolt", 25000, 0) --Time could be wrong
	pUnit:RegisterEvent("SREL_Chilled", 30000, 0) --Time could be wrong
end

function SREL_FrostArmor(pUnit, Event)
	pUnit:CastSpell(12544)
end

function SREL_ConeOfCold(pUnit, Event)
	pUnit:CastSpellOnTarget(15244)
end

function SREL_FrostWard(pUnit, Event)
	pUnit:CastSpell(15044)
end

function SREL_Blizzard(pUnit, Event)
	pUnit:CastSpellOnTarget(8364)
end

function SREL_FrostNova(pUnit, Event)
	pUnit:CastSpell(12674)
end

function SREL_FrostBolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(12675)
end

function SREL_Chilled(pUnit, Event)
	pUnit:CastSpellOnTarget(6136)
end

function SREL_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function SREL_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9038, 1, "SREL_OnCombat")
RegisterUnitEvent(9038, 2, "SREL_OnLeaveCombat")
RegisterUnitEvent(9038, 4, "SREL_OnDeath")
RegisterUnitGossipEvent(9038, 1, "SREL_OnGossipTalk")
RegisterUnitGossipEvent(9038, 2, "SREL_OnGossipSelect")


--------------
--			--
-- Doom'rel --
--			--
--------------
--[[
----Quotes
Doom'rel yells: Your challenge has failed!
Doom'rel says: You have challenged the Seven, and now you will die!
----Spells-ID
Banish-8994
Curse of Weakness-12493
Demon Armor-13787
Immolate-12742
Shadow Bolt Volley-15245
Summon Voidwalkers-15092
]]--
function DOREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function DOREL_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pPlayer:SendChatMessage(5, 0, "Your bondage is at the end, Doom'rel. I challenge you!")
	pUnit:SendChatMessage(11, 0, "You have challenged the Seven, and now you will die!")
	pUnit:GossipComplete()
	end
end

function DOREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("DOREL_Banish", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("DOREL_CurseOfWeak", 15000, 0) --Time could be wrong
	pUnit:RegisterEvent("DOREL_DemonArmor", 5000, 0) --Time could be wrong
	pUnit:RegisterEvent("DOREL_Immolate", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("DOREL_ShadowBoltValley", 25000, 0) --Time could be wrong
	pUnit:RegisterEvent("DOREL_SummonVoidwalkers", 1000, 0) --Time could be wrong
end

function DOREL_Banish(pUnit, Event)
	pUnit:FullCastSpellOnTarget(8994)
end

function DOREL_CurseOfWeak(pUnit, Event)
	pUnit:CastSpellOnTarget(12493)
end

function DOREL_DemonArmor(pUnit, Event)
	pUnit:CastSpell(13787)
end

function DOREL_Immolate(pUnit, Event)
	pUnit:FullCastSpellOnTarget(12742)
end

function DOREL_ShadowBoltValley(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15245)
end

function DOREL_SummonVoidwalkers(pUnit, Event)
	pUnit:CastSpell(15092)
end

function DOREL_OnLeaveCombat(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Your challenge has failed!")
	pUnit:RemoveEvents()
end

function DOREL_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9039, 1, "DOREL_OnCombat")
RegisterUnitEvent(9039, 2, "DOREL_OnLeaveCombat")
RegisterUnitEvent(9039, 4, "DOREL_OnDeath")
RegisterUnitGossipEvent(9039, 1, "DOREL_OnGossipTalk")
RegisterUnitGossipEvent(9039, 2, "DOREL_OnGossipSelect")


--------------
--			--
-- Dope'rel --
--			--
--------------
--[[
----Quotes
----Spells-ID
Backstab-15582
Evasion-15087
Gouge-12540
Rupture-15583
Sinister Strike-15581
]]--
function DREL_OnGossipTalk(pUnit, Event)
	pUnit:GossipCreateMenu(100, player, 1)
	pUnit:GossipMenuAddItem(0, "Let's fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end

function DREL_OnGossipSelect(pUnit, event, pPlayer, id, intid, code, pMisc)
	if (intid == 1) then
	pUnit:SetFaction(14)
	pUnit:SendChatMessage(11, 0, "Our punishment is also our blessing.")
	pUnit:GossipComplete()
	end
end

function DREL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("DREL_Backstab", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("DREL_Evasion", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("DREL_Gouge", 5000, 0) --Time could be wrong
	pUnit:RegisterEvent("DREL_Rupture", 15000, 0) --Time could be wrong
	pUnit:RegisterEvent("DREL_SinisterStrike", 20000, 0) --Time could be wrong
end

function DREL_Backstab(pUnit, Event)
	pUnit:CastSpellOnTarget(15582)
end

function DREL_Evasion(pUnit, Event)
	pUnit:CastSpell(15087)
end

function DREL_Gouge(pUnit, Event)
	pUnit:CastSpellOnTarget(12540)
end

function DREL_Rupture(pUnit, Event)
	pUnit:CastSpellOnTarget(15583)
end

function DREL_SinisterStrike(pUnit, Event)
	pUnit:CastSpellOnTarget(15581)
end

function DREL_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function DREL_OnDeath(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(9040, 1, "DREL_OnCombat")
RegisterUnitEvent(9040, 2, "DREL_OnLeaveCombat")
RegisterUnitEvent(9040, 4, "DREL_OnDeath")
RegisterUnitGossipEvent(9040, 1, "DREL_OnGossipTalk")
RegisterUnitGossipEvent(9040, 2, "DREL_OnGossipSelect")