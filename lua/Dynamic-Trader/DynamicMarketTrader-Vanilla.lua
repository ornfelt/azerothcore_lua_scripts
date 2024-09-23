--[[
DynamicMarketTrader
    This script was developed by Dinkledork and will be updated perioidcally. 
	
    Please support my work by visiting my Patreon page: https://www.patreon.com/Dinklepack5
	
	This script was created for smaller private servers as a means to allow players some semblance of an auctionhouse. In its current interation, the ah module for Acore leaves a lot to be desired.
	Prices are loosely based on authentic vanilla prices as this is for Individual Progression servers or servers that mimic vanilla via the 3.3.5 client. I will also be making scripts for TBC, Wrath, consumables, enchants, etc. 
	As a means to not create an infinite source of easy gold, I've adjusted some prices for crafted materials to be lower than usual to make the margins tighter.
	Please feel free to adjust any values you see fit.
	
	Features include:
	The script uses a dynamic pricing system for items, with prices changing based on several factors, including the day of the week, the time of day, and a global fluctuation value. This means that prices will vary from month to month, day to day, hour to hour.
	1. Inflation: The script includes an inflation system that increases prices over time, based on a defined monthly inflation rate. The inflation system can be enabled or disabled as needed.
	2. Price Caps: The script includes a maximum inflation multiplier that limits the amount prices can increase due to inflation.
	3. Price Fluctuations: The script includes a system for randomly fluctuating prices. This feature can be enabled or disabled as needed.
	4. Detailed Item Categories: The script allows for detailed item categorization, with support for item icons and colors based on item quality.
	5. Quantity Selection: The script allows players to select the quantity of an item they wish to buy or sell, with the price per unit displayed.
	6. Mail Delivery: Items bought from the trader are delivered to the player's mailbox.
	7. Customization: Many aspects of the script can be customized, including the NPC IDs, buy and sell multipliers, inflation rate, the time at which the server started, 
	the maximum inflation multiplier, the multipliers for different days of the week and times of the day, and the items and categories available.
	8. Supports Multiple Currencies: The script supports a system where it can convert prices into different types of currency (gold, silver, copper) for display purposes, all of which mimic auctionhouse structure.
	9. GM Commands: The script includes GM commands for checking multipliers and updating global fluctuations.
	
	GM Commands:
	.vprices 
	This command provides the GM with a detailed breakdown of the current state of the price multipliers and percentages. When a GM enters "vprices", they'll receive a series of messages that include:
	-The day of the week and its associated multiplier
	-The current hour and its associated multiplier
	-The global fluctuation multiplier
	-The inflation multiplier
	-The total price multiplier
	-The buy and sell global multipliers
	
	.vprices shuffle
	This command allows the GM to shuffle the global fluctuation, effectively randomizing the current state of the economy. After using this command, the GM receives a message stating the new global fluctuation.
	
	.vbp
	This command allows the GM to set a new buy multiplier. 
	The GM needs to input the command followed by the desired value (e.g., "vbp 0.5" would set the buy multiplier to 0.5). After setting the new buy multiplier, the GM receives a message confirming the change. 
	The GM is also informed that this change will be reset when the server restarts.
	
	.vsp 
	This command is similar to "vbp", but it adjusts the sell multiplier instead. 
	After the GM enters the command and the desired value, they receive a confirmation message and a reminder that the change will be reset when the server restarts.	
]]

local NPCIDs = {180000} -- add more npcids with commas as needed. .npc add 180000 in the world where desired (for my repack users, I've already done so).
local BUY_PERCENTAGE = 0.90  -- Define the buy constant multiplier. I have this set lower due to inflation. If disabled, maybe set it higher.
local SELL_PERCENTAGE = 0.80  -- Define the sell constant multiplier. Sell is lower to mimic auctionhouse cuts and to prevent cheating. Players can still make profit but they have to be more methodical. ah cut is 5% but I like 10% better.
local INFLATION_RATE = 0.033 -- monthly percentage increase in prices of 3.3% is default. Inflation increases in real time. Can change to be higher or lower.
local FLUCTUATION_ENABLED = true -- enable or disable hourly price fluctuations
local INFLATION_ENABLED = true -- enable or disable inflation
local ORIGINAL_TIMESTAMP = 1690504446 -- Time in unix, currently set to Sat Jun 27 2023. You'll want to set the time in unix for when your server started https://www.unixtimestamp.com/ Inflation will be calculated based on the time difference from this point.
local MAX_INFLATION_MULTIPLIER = 2.0  -- Maximum price multiplier due to inflation. 2.0 corresponds to 100% inflation. 3.0 would be 200%, etc. This ensures inflation never goes to rediculous amounts. You can adjust as necessary. Doubtful many will play for that length of time.


-- Mapping day of the week to the multiplier. Adjust as you see fit. See further below for time of day multipliers.
local DAY_MULTIPLIER = {
    [1] = 1.0,  -- Sunday (Quiet, weekend over)
    [2] = 1.03, -- Monday (Regular day, pre-reset prep)
    [3] = 1.12,  -- Tuesday (Server reset day, high demand)
    [4] = 1.09, -- Wednesday (Popular raid day)
    [5] = 1.07, -- Thursday (Popular raid day)
    [6] = 1.05, -- Friday (Beginning of the weekend, player count rises)
    [7] = 1.02, -- Saturday (Typical day, demand stabilizes)
}


local ITEM_QUALITY_COLORS = {
    [0] = "9d9d9d", -- Poor, Gray
    [1] = "ffffff", -- Common, White
    [2] = "1eff00", -- Uncommon, Green
    [3] = "0070dd", -- Rare, Blue
    [4] = "a335ee", -- Epic, Purple
    [5] = "ff8000", -- Legendary, Orange
    [6] = "e6cc80"  -- Artifact, Light Yellow
}

-- Constants for sender id
local BUY_SELL = 1
local BUY_CATEGORY = 2
local SELL_CATEGORY = 3
local BUY_SUBCATEGORY = 4
local SELL_SUBCATEGORY = 5
local BUY_QUANTITY = 6
local SELL_QUANTITY = 7

local GLOBAL_FLUCTUATION = 0 -- Don't change


-- Think long and hard about changing price values. Do you really want players to buy 2 items for 50 copper to immediately turn around and make 3 gold via crafting it into another item over and over again?
-- Feel free to disable any item by commenting it out.

local categories = {
  { name = "|TInterface\\Icons\\inv_misc_herb_frostlotus:40:40:-42|t|cff006400Herbs|r", intid = 100, items = {
        { name = "|TInterface\\Icons\\inv_misc_flower_02:36:36:-42|tPeacebloom", id = 2447, price = 39 },
        { name = "|TInterface\\Icons\\inv_misc_herb_10:36:36:-42|tSilverleaf", id = 765, price = 53 },
        { name = "|TInterface\\Icons\\inv_misc_herb_07:36:36:-42|tEarthroot", id = 2449, price = 105 },
		{ name = "|TInterface\\Icons\\inv_misc_root_01:36:36:-42|tBriarthorn", id = 2450, price = 133 },
        { name = "|TInterface\\Icons\\inv_jewelry_talisman_03:36:36:-42|tMageroyal", id = 785, price = 56 },
        { name = "|TInterface\\Icons\\inv_misc_herb_04:36:36:-42|tSwiftthistle", id = 2452, price = 1898 },
        { name = "|TInterface\\Icons\\inv_misc_herb_01:36:36:-42|tBruiseweed", id = 2453, price = 89 },
        { name = "|TInterface\\Icons\\inv_misc_herb_11:36:36:-42|tStranglekelp", id = 3820, price = 3400 },
        { name = "|TInterface\\Icons\\inv_misc_dust_02:36:36:-42|tGrave Moss", id = 3369, price = 5600 },
        { name = "|TInterface\\Icons\\inv_misc_flower_01:36:36:-42|tWild Steelbloom", id = 3355, price = 3698 },
        { name = "|TInterface\\Icons\\inv_misc_herb_03:36:36:-42|tKingsblood", id = 3356, price = 319 },
        { name = "|TInterface\\Icons\\inv_misc_root_02:36:36:-42|tLiferoot", id = 3357, price = 732 },       
        { name = "|TInterface\\Icons\\inv_misc_herb_15:36:36:-42|tGoldthorn", id = 3821, price = 1350 },
        { name = "|TInterface\\Icons\\inv_misc_herb_08:36:36:-42|tKhadgar's Whisker", id = 3358, price = 330 },
        { name = "|TInterface\\Icons\\inv_misc_flower_03:36:36:-42|tWintersbite", id = 3819, price = 744 },
        { name = "|TInterface\\Icons\\inv_misc_herb_19:36:36:-42|tFirebloom", id = 4625, price = 574 },
		{ name = "|TInterface\\Icons\\inv_misc_herb_08:36:36:-42|tHeart of the Wild", id = 10286, price = 1280 },
        { name = "|TInterface\\Icons\\inv_misc_herb_17:36:36:-42|tPurple Lotus", id = 8831, price = 599 },
        { name = "|TInterface\\Icons\\inv_misc_herb_13:36:36:-42|tArthas' Tears", id = 8836, price = 1520 },
        { name = "|TInterface\\Icons\\inv_misc_herb_18:36:36:-42|tSungrass", id = 8838, price = 2598 },
        { name = "|TInterface\\Icons\\inv_misc_herb_14:36:36:-42|tBlindweed", id = 8839, price = 1343 },
		{ name = "|TInterface\\Icons\\inv_misc_herb_sansamroot:36:36:-42|tGolden Sansam", id = 13464, price = 648 },
		{ name = "|TInterface\\Icons\\inv_misc_herb_12:36:36:-42|tFadeleaf", id = 3818, price = 10799 },
        { name = "|TInterface\\Icons\\inv_mushroom_08:36:36:-42|tGhost Mushroom", id = 8845, price = 3329 },
        { name = "|TInterface\\Icons\\inv_misc_herb_16:36:36:-42|tGromsblood", id = 8846, price = 21249 },
        { name = "|TInterface\\Icons\\inv_misc_herb_mountainsilversage:36:36:-42|tMountain Silversage", id = 13465, price = 12075 },
        { name = "|TInterface\\Icons\\inv_misc_herb_plaguebloom:36:36:-42|tPlaguebloom", id = 13466, price = 16344 },
        { name = "|TInterface\\Icons\\inv_misc_herb_icecap:36:36:-42|tIcecap", id = 13467, price = 6199 },
        { name = "|TInterface\\Icons\\inv_misc_herb_dreamfoil:36:36:-42|tDreamfoil", id = 13463, price = 12800 },
        { name = "|TInterface\\Icons\\inv_misc_herb_09:36:36:-42|tBloodvine", id = 19726, price = 285000 },
        { name = "|TInterface\\Icons\\inv_misc_herb_blacklotus:36:36:-42|tBlack Lotus", id = 13468, price = 899900 },
    }},
	{ name = "|TInterface\\Icons\\inv_inscription_pigment_grey:40:40:-42|t|cff483D8BPigments|r", intid = 900, items = { -- I Highly Suggest you decrease vendor buy prices of Pigments and Inks
        { name = "|TInterface\\Icons\\inv_inscription_pigment_white:36:36:-42|tAlabaster Pigment", id = 39151, price = 42 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_grey:36:36:-42|tDusky Pigment", id = 39334, price = 99 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_verdant:36:36:-42|tVerdant Pigment", id = 431031, price = 125 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_golden:36:36:-42|tGolden Pigment", id = 39338, price = 322 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_burnt:36:36:-42|tBurnt Pigment", id = 43104, price = 358 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_emerald:36:36:-42|tEmerald Pigment", id = 39339, price = 334 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_indigo:36:36:-42|tIndigo Pigment", id = 43105, price = 388 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_violet:36:36:-42|tViolet Pigment", id = 39340, price = 605 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_ruby:36:36:-42|tRuby Pigment", id = 39343, price = 690 },
        { name = "|TInterface\\Icons\\inv_inscription_pigment_silvery:36:36:-42|tSilvery Pigment", id = 39341, price = 699 },
		{ name = "|TInterface\\Icons\\inv_inscription_pigment_sapphire:36:36:-42|tSapphire Pigment", id = 39341, price = 789 },
    }},
	{ name = "|TInterface\\Icons\\inv_inscription_inkgreen02:40:40:-42|t|cff00008BInk|r", intid = 800, items = {
		{ name = "|TInterface\\Icons\\inv_inscription_inkwhite02:36:36:-42|tMoonglow Ink", id = 39469, price = 90 },       
		{ name = "|TInterface\\Icons\\inv_inscription_inkwhite03:36:36:-42|tIvory Ink", id = 37101, price = 46 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkgreen02:36:36:-42|tHunter's Ink", id = 43115, price = 145 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkblack01:36:36:-42|tMidnight Ink", id = 39774, price = 225 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkyellow04:36:36:-42|tDawnstar Ink", id = 43117, price = 400 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkyellow02:36:36:-42|tLion's Ink", id = 43116, price = 750 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkpurple04:36:36:-42|tRoyal Ink", id = 43119, price = 425 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkgreen03:36:36:-42|tJadefire Ink", id = 43118, price = 766 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkred01:36:36:-42|tFiery Ink", id = 43121, price = 725 },  
		{ name = "|TInterface\\Icons\\inv_inscription_inkpurple03:36:36:-42|tCelestial Ink", id = 43120, price = 1300 },
		{ name = "|TInterface\\Icons\\inv_inscription_inkbluewhite03:36:36:-42|tInk of the Sky", id = 43123, price = 855 },            
		{ name = "|TInterface\\Icons\\inv_inscription_inksilver01:36:36:-42|tShimmering Ink", id = 43122, price = 1520 },
    }},
    { name = "|TInterface\\Icons\\inv_fabric_moonrag_01:40:40:-42|t|cffFFFFFFCloth|r", intid = 200, items = {
        { name = "|TInterface\\Icons\\inv_fabric_linen_01:36:36:-42|tLinen Cloth", id = 2589, price = 41 }, 
        { name = "|TInterface\\Icons\\inv_fabric_linen_02:36:36:-42|tBolt of Linen Cloth", id = 2996, price = 184 }, 
        { name = "|TInterface\\Icons\\inv_fabric_wool_01:36:36:-42|tWool Cloth", id = 2592, price = 119 },
        { name = "|TInterface\\Icons\\inv_fabric_wool_03:36:36:-42|tBolt of Woolen Cloth", id = 2997, price = 357 },
        { name = "|TInterface\\Icons\\inv_fabric_silk_01:36:36:-42|tSilk Cloth", id = 4306, price = 295 },
        { name = "|TInterface\\Icons\\inv_fabric_silk_03:36:36:-42|tBolt of Silk Cloth", id = 4305, price = 1180 },
        { name = "|TInterface\\Icons\\inv_fabric_mageweave_01:36:36:-42|tMageweave Cloth", id = 4338, price = 2240 },
        { name = "|TInterface\\Icons\\inv_fabric_mageweave_03:36:36:-42|tBolt of Mageweave", id = 4339, price = 8960 },
        { name = "|TInterface\\Icons\\inv_fabric_purplefire_01:36:36:-42|tRunecloth", id = 14047, price = 8430 },
        { name = "|TInterface\\Icons\\inv_fabric_purplefire_02:36:36:-42|tBolt of Runecloth", id = 14048, price = 33720 },
        { name = "|TInterface\\Icons\\inv_fabric_felrag:36:36:-42|tFelcloth", id = 14256, price = 60600 },
        { name = "|TInterface\\Icons\\inv_fabric_moonrag_01:36:36:-42|tMooncloth", id = 14342, price = 23000 },
    }},
    { name = "|TInterface\\Icons\\inv_misc_leatherscrap_07:40:40:-42|t|cffFFFF00Skinning - Basic|r", intid = 300, items = {
        { name = "|TInterface\\Icons\\inv_misc_pelt_bear_ruin_05:36:36:-42|tRuined Leather Scraps", id = 2934, price = 13 },
        { name = "|TInterface\\Icons\\inv_misc_leatherscrap_03:36:36:-42|tLight Leather", id = 2318, price = 48 },
        { name = "|TInterface\\Icons\\inv_misc_leatherscrap_05:36:36:-42|tMedium Leather", id = 2319, price = 1399 }, 
        { name = "|TInterface\\Icons\\inv_misc_leatherscrap_07:36:36:-42|tHeavy Leather", id = 4234, price = 3100 },
        { name = "|TInterface\\Icons\\inv_misc_leatherscrap_08:36:36:-42|tThick Leather", id = 4304, price = 4500 },
        { name = "|TInterface\\Icons\\inv_misc_leatherscrap_02:36:36:-42|tRugged Leather", id = 8170, price = 9786 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_wolf_ruin_02:36:36:-42|tLight Hide", id = 783, price = 94 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_boar_ruin_02:36:36:-42|tMedium Hide", id = 4232, price = 3100 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_wolf_ruin_03:36:36:-42|tHeavy Hide", id = 4235, price = 1500 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_bear_ruin_01:36:36:-42|tThick Hide", id = 8169, price = 2250 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_bear_ruin_02:36:36:-42|tRugged Hide", id = 8171, price = 3890 },
    }},
	{ name = "|TInterface\\Icons\\inv_misc_leatherscrap_11:40:40:-42|t|cff333300Skinning - Advanced|r", intid = 400, items = {
	    { name = "|TInterface\\Icons\\inv_misc_pelt_wolf_01:36:36:-42|tCured Light Hide", id = 4231, price = 1800 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_bear_02:36:36:-42|tCured Medium Hide", id = 4233, price = 2400 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_wolf_02:36:36:-42|tCured Heavy Hide", id = 4236, price = 2688 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_bear_01:36:36:-42|tCured Thick Hide", id = 8172, price = 5500 },
        { name = "|TInterface\\Icons\\inv_misc_leatherscrap_06:36:36:-42|tThin Kodo Leather", id = 5082, price = 1200 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_02:36:36:-42|tDeviate Scale", id = 6470, price = 1700 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_01:36:36:-42|tPerfect Deviate Scale", id = 6471, price = 2800 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_01:36:36:-42|tShadowcat Hide", id = 7428, price = 3500 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_03:36:36:-42|tBlack Whelp Scale", id = 7286, price = 200 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_02:36:36:-42|tRed Whelp Scale", id = 7287, price = 3800 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_03:36:36:-42|tGreen Whelp Scale", id = 7392, price = 12200 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_09:36:36:-42|tBlue Dragonscale", id = 15415, price = 2300 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_11:36:36:-42|tGreen Dragonscale", id = 15412, price = 2400 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_15:36:36:-42|tRed Dragonscale", id = 15414, price = 9300 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_07:36:36:-42|tBlack Dragonscale", id = 15416, price = 10600 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_17:36:36:-42|tWorn Dragonscale", id = 8165, price = 1600 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_bear_ruin_05:36:36:-42|tWarbear Leather", id = 15419, price = 5800 },
        { name = "|TInterface\\Icons\\inv_misc_pelt_03:36:36:-42|tDevilsaur Leather", id = 15417, price = 195050 },
        { name = "|TInterface\\Icons\\inv_ammo_firetar:36:36:-42|tCore Leather", id = 17012, price = 83000 },
        { name = "|TInterface\\Icons\\inv_misc_monsterscales_15:36:36:-42|tPristine Hide of the Beast", id = 12731, price = 2797500 },
        { name = "|TInterface\\Icons\\inv_misc_rune_05:36:36:-42|tEnchanted Leather", id = 12810, price = 14000 },
	}},
    { name = "|TInterface\\Icons\\inv_misc_food_119_RhinoMeat:40:40:-42|t|cff8B0000Cooking Ingredients - Meat|r", intid = 500, items = {
        { name = "|TInterface\\Icons\\inv_misc_food_14:36:36:-42|tChunk of Boar Meat", id = 769, price = 420 }, 
        { name = "|TInterface\\Icons\\inv_misc_food_51:36:36:-42|tCrawler Meat", id = 2674, price = 387 },
        { name = "|TInterface\\Icons\\inv_misc_food_14:36:36:-42|tStringy Wolf Meat", id = 2672, price = 500 },
		{ name = "|TInterface\\Icons\\inv_misc_food_16:36:36:-42|tCrag Boar Rib", id = 2886, price = 192 },
		{ name = "|TInterface\\Icons\\inv_misc_organ_04:36:36:-42|tGoretusk Liver", id = 723, price = 550 },
		{ name = "|TInterface\\Icons\\inv_misc_food_71:36:36:-42|tSmall Spider Leg", id = 5465, price = 178 },
		{ name = "|TInterface\\Icons\\inv_egg_01:36:36:-42|tSmall Egg", id = 6889, price = 195 },
		{ name = "|TInterface\\Icons\\inv_misc_pelt_bear_ruin_05:36:36:-42|tMeaty Bat Wing", id = 12223, price = 202 },
		{ name = "|TInterface\\Icons\\inv_misc_monsterscales_02:36:36:-42|tMurloc Fin", id = 1468, price = 930 },
        { name = "|TInterface\\Icons\\inv_misc_eye_01:36:36:-42|tMurloc Eye", id = 730, price = 1000 },		
        { name = "|TInterface\\Icons\\inv_misc_food_71:36:36:-42|tBear Meat", id = 3173, price = 250 },
        { name = "|TInterface\\Icons\\inv_misc_food_14:36:36:-42|tLean Wolf Flank", id = 1015, price = 1450 },        
        { name = "|TInterface\\Icons\\inv_misc_food_72:36:36:-42|tTough Condor Meat", id = 1080, price = 1350 },
		{ name = "|TInterface\\Icons\\inv_misc_monsterspidercarapace_01:36:36:-42|tCrisp Spider Meat", id = 1081, price = 1247 },
		{ name = "|TInterface\\Icons\\inv_misc_food_71:36:36:-42|tRed Wolf Meat", id = 12203, price = 258 },
		{ name = "|TInterface\\Icons\\inv_misc_food_70:36:36:-42|tTurtle Meat", id = 3712, price = 875 },
		{ name = "|TInterface\\Icons\\inv_misc_food_14:36:36:-42|tBig Bear Meat", id = 3730, price = 1333 },
		{ name = "|TInterface\\Icons\\inv_misc_food_71:36:36:-42|tLion Meat", id = 3731, price = 2350 },
        { name = "|TInterface\\Icons\\inv_misc_food_51:36:36:-42|tTender Crab Meat", id = 12206, price = 2100 },
		{ name = "|TInterface\\Icons\\inv_misc_food_14:36:36:-42|tTender Crocolisk Meat", id = 3667, price = 435 },
        { name = "|TInterface\\Icons\\inv_misc_food_69:36:36:-42|tRaptor Flesh", id = 12184, price = 1076 },
        { name = "|TInterface\\Icons\\inv_misc_food_67:36:36:-42|tMystery Meat", id = 12037, price = 1233 },               
        { name = "|TInterface\\Icons\\inv_misc_food_14:36:36:-42|tTender Wolf Meat", id = 12208, price = 1197 },		
        { name = "|TInterface\\Icons\\inv_misc_food_13:36:36:-42|tBear Flank", id = 35562, price = 3420 },
        { name = "|TInterface\\Icons\\inv_misc_food_70:36:36:-42|tHeavy Kodo Meat", id = 12204, price =800 },
		{ name = "|TInterface\\Icons\\inv_misc_food_51:36:36:-42|tWhite Spider Meat", id = 12205, price = 1758 }, 
		{ name = "|TInterface\\Icons\\inv_misc_food_55:36:36:-42|tRunn Tum Tuber", id = 18255, price = 8600 },
    }},
    { name = "|TInterface\\Icons\\inv_misc_fish_51:40:40:-42|t|cff0000CDCooking Ingredients - Seafood|r", intid = 600, items = {
        { name = "|TInterface\\Icons\\inv_misc_fish_24:36:36:-42|tRaw Slitherskin Mackerel", id = 787, price = 1476 },
        { name = "|TInterface\\Icons\\inv_misc_fish_07:36:36:-42|tRaw Brilliant Smallfish", id = 6290, price = 1500 },
        { name = "|TInterface\\Icons\\inv_misc_fish_32:36:36:-42|tRaw Longjaw Mud Snapper", id = 6289, price = 67 },		
        { name = "|TInterface\\Icons\\inv_misc_fish_30:36:36:-42|tRaw Bristle Whisker Catfish", id = 6308, price = 1270 },
		{ name = "|TInterface\\Icons\\inv_misc_fish_20:36:36:-42|tRaw Sagefish", id = 21071, price = 325 },  
        { name = "|TInterface\\Icons\\inv_misc_fish_27:36:36:-42|tRaw Rainbow Fin Albacore", id = 5095, price = 198 },
        { name = "|TInterface\\Icons\\inv_misc_fish_03:36:36:-42|tRaw Loch Frenzy", id = 6317, price = 171 },
        { name = "|TInterface\\Icons\\inv_misc_fish_04:36:36:-42|tRaw Rockscale Cod", id = 4594, price = 3200 },
        { name = "|TInterface\\Icons\\inv_misc_fish_02:36:36:-42|tRaw Mithril Head Trout", id = 8364, price = 2140 },
        { name = "|TInterface\\Icons\\inv_misc_fish_06:36:36:-42|tRaw Redgill", id = 13758, price = 600 },
        { name = "|TInterface\\Icons\\inv_misc_fish_23:36:36:-42|tRaw Nightfin Snapper", id = 13759, price = 3500 },
        { name = "|TInterface\\Icons\\inv_misc_fish_19:36:36:-42|tRaw Sunscale Salmon", id = 13760, price = 4100 },
        { name = "|TInterface\\Icons\\inv_misc_monsterhead_03:36:36:-42|tRaw Glossy Mightfish", id = 13754, price = 4200 },
        { name = "|TInterface\\Icons\\inv_misc_fish_01:36:36:-42|tRaw Spotted Yellowtail", id = 4603, price = 400 },
        { name = "|TInterface\\Icons\\inv_misc_fish_14:36:36:-42|tDarkclaw Lobster", id = 13888, price = 1479 },
        { name = "|TInterface\\Icons\\inv_misc_monsterhead_02:36:36:-42|tLarge Raw Mightfish", id = 13893, price = 3420 },
        { name = "|TInterface\\Icons\\inv_misc_monsterhead_01:36:36:-42|tDeviate Fish", id = 6522, price = 4231 },
		{ name = "|TInterface\\Icons\\inv_misc_fish_13:36:36:-42|tWinter Squid", id = 13755, price = 4325 },  		
        { name = "|TInterface\\Icons\\inv_misc_fish_21:36:36:-42|tRaw Greater Sagefish", id = 21153, price = 7600 },
        { name = "|TInterface\\Icons\\inv_misc_monsterhead_01:36:36:-42|tFirefin Snapper", id = 6359, price = 2224 },
        { name = "|TInterface\\Icons\\inv_misc_monsterhead_04:36:36:-42|tOily Blackmouth", id = 6358, price = 12303 },
        { name = "|TInterface\\Icons\\inv_misc_fish_11:36:36:-42|tStonescale Eel", id = 13422, price = 18200 },
    }},
    { name = "|TInterface\\Icons\\inv_enchant_dustillusion:40:40:-42|t|cff9400D3Enchanting|r", intid = 700, items = {
        { name = "|TInterface\\Icons\\inv_enchant_duststrange:36:36:-42|tStrange Dust", id = 10940, price = 519 },
        { name = "|TInterface\\Icons\\inv_enchant_dustsoul:36:36:-42|tSoul Dust", id = 11083, price = 1538 },
        { name = "|TInterface\\Icons\\inv_enchant_dustvision:36:36:-42|tVision Dust", id = 11137, price = 1490 },
        { name = "|TInterface\\Icons\\inv_enchant_dustdream:36:36:-42|tDream Dust", id = 11176, price = 5198 },
        { name = "|TInterface\\Icons\\inv_enchant_dustillusion:36:36:-42|tIllusion Dust", id = 16204, price = 3799 },
        { name = "|TInterface\\Icons\\inv_enchant_essencemagicsmall:36:36:-42|tLesser Magic Essence", id = 10938, price = 1380 },
        { name = "|TInterface\\Icons\\inv_enchant_essencemagiclarge:36:36:-42|tGreater Magic Essence", id = 10939, price = 4140 },
        { name = "|TInterface\\Icons\\inv_enchant_essenceastralsmall:36:36:-42|tLesser Astral Essence", id = 10998, price = 898 },
        { name = "|TInterface\\Icons\\inv_enchant_essenceastrallarge:36:36:-42|tGreater Astral Essence", id = 11082, price = 2694 },
        { name = "|TInterface\\Icons\\inv_enchant_essencemysticalsmall:36:36:-42|tLesser Mystic Essence", id = 11134, price = 1549 },
        { name = "|TInterface\\Icons\\inv_enchant_essencemysticallarge:36:36:-42|tGreater Mystic Essence", id = 11135, price = 4647 },
        { name = "|TInterface\\Icons\\inv_enchant_essencenethersmall:36:36:-42|tLesser Nether Essence", id = 11174, price = 8970 },
        { name = "|TInterface\\Icons\\inv_enchant_essencenetherlarge:36:36:-42|tGreater Nether Essence", id = 11175, price = 26910 },
        { name = "|TInterface\\Icons\\inv_enchant_essenceeternalsmall:36:36:-42|tLesser Eternal Essence", id = 16202, price = 14436 },
        { name = "|TInterface\\Icons\\inv_enchant_essenceeternallarge:36:36:-42|tGreater Eternal Essence", id = 16203, price = 43308 },
        { name = "|TInterface\\Icons\\inv_enchant_shardglimmeringsmall:36:36:-42|tSmall Glimmering Shard", id = 10978, price = 255 },
        { name = "|TInterface\\Icons\\inv_enchant_shardglimmeringlarge:36:36:-42|tLarge Glimmering Shard", id = 11084, price = 1406 },
        { name = "|TInterface\\Icons\\inv_enchant_shardglowingsmall:36:36:-42|tSmall Glowing Shard", id = 11138, price = 8730 },
        { name = "|TInterface\\Icons\\inv_enchant_shardglowinglarge:36:36:-42|tLarge Glowing Shard", id = 11139, price = 7399 },
        { name = "|TInterface\\Icons\\inv_enchant_shardradientsmall:36:36:-42|tSmall Radiant Shard", id = 11177, price = 41888 },
        { name = "|TInterface\\Icons\\inv_enchant_shardradientlarge:36:36:-42|tLarge Radiant Shard", id = 11178, price = 38098 },
        { name = "|TInterface\\Icons\\inv_enchant_shardbrilliantsmall:36:36:-42|tSmall Brilliant Shard", id = 14343, price = 14795 },
        { name = "|TInterface\\Icons\\inv_enchant_shardbrilliantlarge:36:36:-42|tLarge Brilliant Shard", id = 14344, price = 100400 },
		{ name = "|TInterface\\Icons\\inv_misc_gem_pearl_03:36:36:-42|tRighteous Orb", id = 12811, price = 241099 },
        { name = "|TInterface\\Icons\\inv_enchant_shardnexuslarge:36:36:-42|tNexus Crystal", id = 20725, price = 15360 },
    }},
    { name = "|TInterface\\Icons\\inv_rod_adamantite:40:40:-42|t|cff006400Rods|r", intid = 1400, items = {
        { name = "|TInterface\\Icons\\inv_staff_01:36:36:-42|tSilver Rod", id = 6338, price = 11124 }, 
        { name = "|TInterface\\Icons\\inv_staff_10:36:36:-42|tGolden Rod", id = 11128, price = 11715 }, 
        { name = "|TInterface\\Icons\\inv_staff_11:36:36:-42|tTruesilver Rod", id = 11144, price = 11127 }, 
        { name = "|TInterface\\Icons\\inv_staff_19:36:36:-42|tArcanite Rod", id = 16206, price = 915840 }, 
    }},
    { name = "|TInterface\\Icons\\inv_ore_tin_01:40:40:-42|t|cff004C99Ore|r", intid = 1000, items = {
        { name = "|TInterface\\Icons\\inv_ore_copper_01:36:36:-42|tCopper Ore", id = 2770, price = 74 },
        { name = "|TInterface\\Icons\\inv_ore_tin_01:36:36:-42|tTin Ore", id = 2771, price = 186 },
        { name = "|TInterface\\Icons\\inv_ore_iron_01:36:36:-42|tIron Ore", id = 2772, price = 1000 },
        { name = "|TInterface\\Icons\\inv_stone_16:36:36:-42|tSilver Ore", id = 2775, price = 1369 },
        { name = "|TInterface\\Icons\\inv_ore_gold_01:36:36:-42|tGold Ore", id = 2776, price = 1408 },
        { name = "|TInterface\\Icons\\inv_ore_mithril_02:36:36:-42|tMithril Ore", id = 3858, price = 3800 }, 
        { name = "|TInterface\\Icons\\inv_ore_truesilver_01:36:36:-42|tTruesilver Ore", id = 7911, price = 5500 },
        { name = "|TInterface\\Icons\\inv_ore_thorium_02:36:36:-42|tThorium Ore", id = 10620, price = 7100 }, 
        { name = "|TInterface\\Icons\\inv_ore_mithril_01:36:36:-42|tDark Iron Ore", id = 11370, price = 2250 },
        { name = "|TInterface\\Icons\\inv_stone_sharpeningstone_01:36:36:-42|tElementium Ore", id = 18562, price = 890000 },
    }},
   { name = "|TInterface\\Icons\\inv_ingot_07:40:40:-42|t|cff2F4F4FIngots|r", intid = 1100, items = {
        { name = "|TInterface\\Icons\\inv_ingot_02:36:36:-42|tCopper Bar", id = 2840, price = 78 }, 
        { name = "|TInterface\\Icons\\inv_ingot_05:36:36:-42|tTin Bar", id = 3576, price = 191 },
        { name = "|TInterface\\Icons\\inv_ingot_01:36:36:-42|tSilver Bar", id = 2842, price = 1380 },
        { name = "|TInterface\\Icons\\inv_ingot_bronze:36:36:-42|tBronze Bar", id = 2841, price = 383 },
        { name = "|TInterface\\Icons\\inv_ingot_03:36:36:-42|tGold Bar", id = 3577, price = 1448 },
        { name = "|TInterface\\Icons\\inv_ingot_steel:36:36:-42|tSteel Bar", id = 3859, price = 6000 },
        { name = "|TInterface\\Icons\\inv_ingot_iron:36:36:-42|tIron Bar", id = 3575, price = 1100 },
        { name = "|TInterface\\Icons\\inv_ingot_06:36:36:-42|tMithril Bar", id = 3860, price = 3900 },
        { name = "|TInterface\\Icons\\inv_ingot_08:36:36:-42|tTruesilver Bar", id = 6037, price = 5800 },
        { name = "|TInterface\\Icons\\inv_ingot_07:36:36:-42|tThorium Bar", id = 12359, price = 7600 },
		{ name = "|TInterface\\Icons\\inv_ingot_eternium:36:36:-42|tEnchanted Thorium Bar", id = 12655, price = 24000 },
        { name = "|TInterface\\Icons\\inv_ingot_mithril:36:36:-42|tDark Iron Bar", id = 11371, price = 2350 },
        { name = "|TInterface\\Icons\\inv_misc_stonetablet_05:36:36:-42|tArcanite Bar", id = 12360, price = 275000 }, 
        { name = "|TInterface\\Icons\\inv_ingot_thorium:36:36:-42|tElementium Bar", id = 17771, price = 3806000 }, 
    }},
    { name = "|TInterface\\Icons\\inv_misc_gem_ruby_02:40:40:-42|t|cff800080Gems|r", intid = 1200, items = {
        { name = "|TInterface\\Icons\\inv_misc_gem_emerald_03:36:36:-42|tMalachite", id = 774, price = 74 },
        { name = "|TInterface\\Icons\\inv_misc_gem_pearl_03:36:36:-42|tSmall Lustrous Pearl", id = 5498, price = 320 },
        { name = "|TInterface\\Icons\\inv_misc_gem_opal_03:36:36:-42|tTigerseye", id = 818, price = 224 }, 
        { name = "|TInterface\\Icons\\inv_misc_gem_amethyst_01:36:36:-42|tShadowgem", id = 1210, price = 400 },
        { name = "|TInterface\\Icons\\inv_misc_gem_pearl_02:36:36:-42|tIridescent Pearl", id = 5500, price = 6664 },
        { name = "|TInterface\\Icons\\inv_misc_gem_emerald_02:36:36:-42|tMoss Agate", id = 1206, price = 1350 },
        { name = "|TInterface\\Icons\\inv_misc_gem_crystal_01:36:36:-42|tLesser Moonstone", id = 1705, price = 2499 },
        { name = "|TInterface\\Icons\\inv_misc_gem_stone_01:36:36:-42|tJade", id = 1529, price = 3374 },
        { name = "|TInterface\\Icons\\inv_misc_gem_pearl_01:36:36:-42|tBlack Pearl", id = 7971, price = 4400 },
		{ name = "|TInterface\\Icons\\inv_misc_gem_pearl_04:36:36:-42|tGolden Pearl", id = 13926, price = 45450 },
        { name = "|TInterface\\Icons\\inv_misc_gem_opal_02:36:36:-42|tCitrine", id = 3864, price = 1200 },    
		{ name = "|TInterface\\Icons\\inv_misc_gem_crystal_02:36:36:-42|tAquamarine", id = 7909, price = 1648 },   		
        { name = "|TInterface\\Icons\\inv_misc_gem_01:36:36:-42|tSouldarite", id = 19774, price = 77000 },
        { name = "|TInterface\\Icons\\inv_misc_gem_ruby_02:36:36:-42|tStar Ruby", id = 7910, price = 11100 },
		{ name = "|TInterface\\Icons\\inv_misc_gem_sapphire_02:36:36:-42|tSBlue Sapphire", id = 12361, price = 13150 },
        { name = "|TInterface\\Icons\\inv_misc_gem_opal_01:36:36:-42|tLarge Opal", id = 12799, price = 7000 },
        { name = "|TInterface\\Icons\\inv_misc_gem_diamond_01:36:36:-42|tAzerothian Diamond", id = 12800, price = 22089 },
        { name = "|TInterface\\Icons\\inv_misc_gem_emerald_01:36:36:-42|tHuge Emerald", id = 12364, price = 12000 },
		{ name = "|TInterface\\Icons\\inv_misc_gem_topaz_01:36:36:-42|tArcane Crystal", id = 12363, price = 179000 },
		{ name = "|TInterface\\Icons\\inv_misc_gem_bloodstone_03:36:36:-42|tBlood of the Mountain", id = 11382, price = 220000 },
    }},
	{ name = "|TInterface\\Icons\\inv_elemental_primal_shadow:40:40:-42|t|cff6600CCEssences & Elementals|r", intid = 1500, items = {
        { name = "|TInterface\\Icons\\inv_stone_05:36:36:-42|tCore of Earth", id = 7075, price = 4400 },
        { name = "|TInterface\\Icons\\inv_misc_orb_01:36:36:-42|tGlobe of Water", id = 7079, price = 12900 },
        { name = "|TInterface\\Icons\\spell_fire_lavaspawn:36:36:-42|tHeart of Fire", id = 7077, price = 1480 },
        { name = "|TInterface\\Icons\\spell_nature_cyclone:36:36:-42|tBreath of Wind", id = 7081, price = 3400 },
		{ name = "|TInterface\\Icons\\inv_misc_slime_01:36:36:-42|tIchor of Undeath", id = 7972, price = 1550 },
        { name = "|TInterface\\Icons\\spell_nature_tranquility:36:36:-42|tElemental Air", id = 7069, price = 6600 },
        { name = "|TInterface\\Icons\\spell_fire_fire:36:36:-42|tElemental Fire", id = 7068, price = 63630},
        { name = "|TInterface\\Icons\\inv_potion_03:36:36:-42|tElemental Water", id = 7070, price = 10000 },
        { name = "|TInterface\\Icons\\inv_ore_iron_01:36:36:-42|tElemental Earth", id = 7067, price = 42200 },
        { name = "|TInterface\\Icons\\spell_nature_abolishmagic:36:36:-42|tLiving Essence", id = 12803, price = 3100 },
        { name = "|TInterface\\Icons\\spell_fire_volcano:36:36:-42|tEssence of Fire", id = 7078, price = 15000 },
        { name = "|TInterface\\Icons\\spell_shadow_shadetruesight:36:36:-42|tEssence of Undeath", id = 12808, price = 10200 },
        { name = "|TInterface\\Icons\\spell_nature_acid_01:36:36:-42|tEssence of Water", id = 7080, price = 49999 },
        { name = "|TInterface\\Icons\\spell_nature_earthbind:36:36:-42|tEssence of Air", id = 7082, price = 124498 },
        { name = "|TInterface\\Icons\\spell_nature_strengthofearthtotem02:36:36:-42|tEssence of Earth", id = 7076, price = 18800 },
		{ name = "|TInterface\\Icons\\spell_fire_flamebolt:36:36:-42|tFiery Core", id = 17010, price = 156000 },
		{ name = "|TInterface\\Icons\\spell_nature_earthquake:36:36:-42|tLava Core", id = 17011, price = 319999 },
    }},
    { name = "|TInterface\\Icons\\trade_engineering:40:40:-42|t|cff8B008BParts|r", intid = 1300, items = {
        { name = "|TInterface\\Icons\\inv_drink_07:36:36:-42|tFlask of Oil", id = 814, price = 540 },
        { name = "|TInterface\\Icons\\inv_misc_gear_06:36:36:-42|tHandful of Copper Bolts", id = 4359, price = 90 }, 
        { name = "|TInterface\\Icons\\inv_gizmo_pipe_02:36:36:-42|tCopper Tube", id = 4361, price = 200 },
		{ name = "|TInterface\\Icons\\inv_misc_dust_01:36:36:-42|tRough Blasting Powder", id = 4357, price = 720 },
        { name = "|TInterface\\Icons\\inv_gizmo_03:36:36:-42|tCopper Modulator", id = 4363, price = 350 },
        { name = "|TInterface\\Icons\\inv_misc_dust_02:36:36:-42|tCoarse Blasting Powder", id = 4364, price = 2400 }, 
        { name = "|TInterface\\Icons\\inv_gizmo_pipe_01:36:36:-42|tBronze Tube", id = 4371, price = 820 },
        { name = "|TInterface\\Icons\\inv_gizmo_02:36:36:-42|tWhirring Bronze Gizmo", id = 4375, price = 540 }, 
        { name = "|TInterface\\Icons\\inv_gizmo_bronzeframework_01:36:36:-42|tBronze Framework", id = 4382, price = 4000 },
        { name = "|TInterface\\Icons\\inv_misc_dust_06:36:36:-42|tHeavy Blasting Powder", id = 4377, price = 2190 }, 
        { name = "|TInterface\\Icons\\inv_spear_05:36:36:-42|tIron Strut", id = 4387, price = 2350 },
		{ name = "|TInterface\\Icons\\inv_battery_02:36:36:-42|tGold Power Core", id = 4389, price = 1498 },
        { name = "|TInterface\\Icons\\inv_misc_pocketwatch_02:36:36:-42|tGyrochronatom", id = 4389, price = 2848 },
        { name = "|TInterface\\Icons\\inv_misc_powder_black:36:36:-42|tSolid Blasting Powder", id = 10505, price = 10270 }, 
        { name = "|TInterface\\Icons\\inv_musket_01:36:36:-42|tMithril Tube", id = 10559, price = 12100 },
        { name = "|TInterface\\Icons\\inv_battery_01:36:36:-42|tUnstable Trigger", id = 10560, price = 21718 },
        { name = "|TInterface\\Icons\\inv_gizmo_mithrilcasing_01:36:36:-42|tMithril Casing", id = 10561, price = 12150 },
        { name = "|TInterface\\Icons\\inv_misc_ammo_gunpowder_01:36:36:-42|tDense Blasting Powder", id = 15992, price = 23000 }, 
        { name = "|TInterface\\Icons\\inv_gizmo_04:36:36:-42|tThorium Widget", id = 15994, price = 32000 },
    }}, 
    { name = "|TInterface\\Icons\\inv_stone_10:40:40:-42|t|cff606060Stones and Misc|r", intid = 1600, items = {
        { name = "|TInterface\\Icons\\inv_stone_06:36:36:-42|tRough Stone", id = 2835, price = 699 },
        { name = "|TInterface\\Icons\\inv_stone_09:36:36:-42|tCoarse Stone", id = 2836, price = 2300 },
        { name = "|TInterface\\Icons\\inv_stone_12:36:36:-42|tHeavy Stone", id = 2838, price = 2130 },
        { name = "|TInterface\\Icons\\inv_stone_10:36:36:-42|tSolid Stone", id = 7912, price = 10100 },
        { name = "|TInterface\\Icons\\inv_misc_stonetablet_07:36:36:-42|tDense Stone", id = 12365, price = 22000 },
        { name = "|TInterface\\Icons\\inv_stone_grindingstone_01:36:36:-42|tRough Grinding Stone", id = 3470, price = 1555 },
        { name = "|TInterface\\Icons\\inv_stone_grindingstone_02:36:36:-42|tCoarse Grinding Stone", id = 3478, price = 4700 },
        { name = "|TInterface\\Icons\\inv_stone_grindingstone_03:36:36:-42|tHeavy Grinding Stone", id = 3486, price = 4500 },
        { name = "|TInterface\\Icons\\inv_stone_grindingstone_04:36:36:-42|tSolid Grinding Stone", id = 7944, price = 20300 },
        { name = "|TInterface\\Icons\\inv_stone_grindingstone_05:36:36:-42|tDense Grinding Stone", id = 12644, price = 23000 },
		{ name = "|TInterface\\Icons\\inv_jewelcrafting_delicatecopperwire:36:36:-42|tDelicate Copper Wire", id = 20816, price = 163 },
		{ name = "|TInterface\\Icons\\inv_jewelcrafting_bronzesetting:36:36:-42|tBronze Setting", id = 20817, price = 800 },
		{ name = "|TInterface\\Icons\\inv_jewelcrafting_mithrilfiligree:36:36:-42|tMithril Filigree", id = 20963, price = 800 },
		{ name = "|TInterface\\Icons\\inv_jewelcrafting_thoriumsetting:36:36:-42|tThorium Setting", id = 21752, price = 800 },
		{ name = "|TInterface\\Icons\\inv_misc_organ_06:36:36:-42|tSmall Flame Sac", id = 4402, price = 14000 },
		{ name = "|TInterface\\Icons\\inv_misc_monsterclaw_03:36:36:-42|tSharp Claw", id = 5635, price = 141 },
		{ name = "|TInterface\\Icons\\spell_shadow_sealofkings:36:36:-42|tDark Rune", id = 20520, price = 100005 },        
		{ name = "|TInterface\\Icons\\inv_potion_22:36:36:-42|tLarval Acid", id = 18512, price = 55000 },
        { name = "|TInterface\\Icons\\inv_stone_02|tGuardian Stone", id = 12809, price = 148500 },
    }},
}

local function UpdateFluctuation()
    if FLUCTUATION_ENABLED then
        GLOBAL_FLUCTUATION = math.random(-5, 5) / 100
    end
end

local function OnServerStartupVanillaFluctuation(event)
	print("Trader startup event triggered.")
    UpdateFluctuation()
end

local GOLD_ICON = "|TInterface\\MoneyFrame\\UI-GoldIcon:19:19:2:0|t"
local SILVER_ICON = "|TInterface\\MoneyFrame\\UI-SilverIcon:19:19:2:0|t"
local COPPER_ICON = "|TInterface\\MoneyFrame\\UI-CopperIcon:19:19:2:0|t"

local function convertMoney(copper)
    local gold = math.floor(copper / 10000)
    copper = copper - gold * 10000
    local silver = math.floor(copper / 100)
    copper = copper - silver * 100

    local moneyStr = ""

    if gold > 0 then
        moneyStr = moneyStr .. gold .. GOLD_ICON .. " "
    end

    if silver > 0 then
        moneyStr = moneyStr .. silver .. SILVER_ICON .. " "
    end

    if copper > 0 or moneyStr == "" then
        moneyStr = moneyStr .. math.floor(copper) .. COPPER_ICON
    end

    return moneyStr
end

local function GetItemColor(quality)
    return ITEM_QUALITY_COLORS[quality] or "ffffff" -- White color by default if no quality match
end

local function GetItemString(item)
    local itemTemplate = GetItemTemplate(item.id) -- Get the item template
    local quality = itemTemplate:GetQuality() -- Get the item quality from the item template
    local color = GetItemColor(quality)
    local itemName = string.match(item.name, "|t(.*)") -- Exclude the icon from the item name
    return "|cff" .. color .. " [" .. itemName .. "]|r"
end


local intidToEntity = {}
for _, category in ipairs(categories) do
    intidToEntity[category.intid] = category
    for i, item in ipairs(category.items) do
        intidToEntity[category.intid * 100 + i] = item
    end
end

local function getDayOfWeek()
    return os.date("*t").wday
end

local function getCurrentHour()
    return os.date("*t").hour
end

-- Get time of day multiplier. Adjust as you see fit.
local function getTimeMultiplier()
    local hour = getCurrentHour()
    local TIME_MULTIPLIER = {
        [0] = 0.96,   -- 12am
        [1] = 0.96,  -- 1am
        [2] = 0.96,  -- 2am
        [3] = 0.96,  -- 3am
        [4] = 0.96,   -- 4am
        [5] = 0.97,   -- 5am
        [6] = 0.97,  -- 6am
        [7] = 0.98,   -- 7am
        [8] = 0.98,  -- 8am
        [9] = 0.99,   -- 9am
        [10] = 1.00, -- 10am
        [11] = 1.01, -- 11am
        [12] = 1.02, -- 12pm
        [13] = 1.03,  -- 1pm
        [14] = 1.04,  -- 2pm
        [15] = 1.05, -- 3pm
        [16] = 1.05, -- 4pm
        [17] = 1.06,  -- 5pm (peak time start)
        [18] = 1.06,  -- 6pm
        [19] = 1.07,  -- 7pm
        [20] = 1.07,  -- 8pm
        [21] = 1.06, -- 9pm
        [22] = 1.05, -- 10pm (peak time end)
        [23] = 1.04  -- 11pm
    }
    return TIME_MULTIPLIER[hour]
end

local function getPriceMultiplier()
    local dayOfWeek = getDayOfWeek()
    local elapsedTimeInMonths = os.difftime(os.time(), ORIGINAL_TIMESTAMP) / (30 * 24 * 60 * 60)
    local inflationMultiplier = 1
    if INFLATION_ENABLED then
        inflationMultiplier = (1 + INFLATION_RATE) ^ elapsedTimeInMonths
        inflationMultiplier = math.min(inflationMultiplier, MAX_INFLATION_MULTIPLIER)
    end
    return DAY_MULTIPLIER[dayOfWeek] * getTimeMultiplier() * inflationMultiplier + GLOBAL_FLUCTUATION
end

local function ShowMainMenu(player, unit)
    player:GossipClearMenu()
    player:GossipMenuAddItem(1, "Buy", 1, 0)
    player:GossipMenuAddItem(1, "Sell", 1, 1)
    player:GossipSendMenu(1, unit)
end

local function ShowItemMenu(player, unit, items, intid)
    for i, item in ipairs(items) do
        player:GossipMenuAddItem(1, item.name .. " - " .. convertMoney(item.price * getPriceMultiplier()), intid, i)
    end
    player:GossipSendMenu(1, unit)
end

local function OnGossipHelloVanillaTrader(event, player, object)
    ShowMainMenu(player, object)
end

local function OnGossipSelectVanillaTrader(event, player, object, sender, intid, code, menu_id)
    player:GossipClearMenu()
    if sender == BUY_SELL then
        local buyOrSell = intid == 0 and "Buy" or "Sell"
        player:GossipMenuAddItem(3, "Current Page: |cff" .. (buyOrSell == "Buy" and "0000ff" or "006400") .. buyOrSell .. "|r | Switch to |cff" .. (buyOrSell == "Sell" and "0000ff" or "006400") .. (buyOrSell == "Buy" and "Sell" or "Buy") .. "|r Page", BUY_SELL, intid == 0 and 1 or 0)

        for _, category in ipairs(categories) do
            player:GossipMenuAddItem(0, category.name, buyOrSell == "Buy" and BUY_CATEGORY or SELL_CATEGORY, category.intid)
        end
        player:GossipMenuAddItem(3, "Current Page: |cff" .. (buyOrSell == "Buy" and "0000ff" or "006400") .. buyOrSell .. "|r | Switch to |cff" .. (buyOrSell == "Sell" and "0000ff" or "006400") .. (buyOrSell == "Buy" and "Sell" or "Buy") .. "|r Page", BUY_SELL, intid == 0 and 1 or 0)

        player:GossipSendMenu(1, object)
    elseif sender == BUY_CATEGORY or sender == SELL_CATEGORY then
        local category = intidToEntity[intid]
        if category then
            for i, item in ipairs(category.items) do
                local price = item.price * (sender == BUY_CATEGORY and BUY_PERCENTAGE or SELL_PERCENTAGE) * getPriceMultiplier()
                if sender == BUY_CATEGORY or (sender == SELL_CATEGORY and player:HasItem(item.id)) then
                    player:GossipMenuAddItem(1, item.name .. "\n       |cff006400Price:|r " .. convertMoney(price), sender == BUY_CATEGORY and BUY_QUANTITY or SELL_QUANTITY, intid * 100 + i, true, "How many do you want to " .. (sender == BUY_CATEGORY and "buy" or "sell") .. "? \nPrice per unit " .. convertMoney(price))
                end
            end
            player:GossipMenuAddItem(7, "|cff8b0000Back|r", BUY_SELL, sender == BUY_CATEGORY and 0 or 1)
        end
        player:GossipSendMenu(1, object)
    elseif sender == BUY_QUANTITY or sender == SELL_QUANTITY then
        local quantity = tonumber(code)
        local item = intidToEntity[intid]
        if quantity and item then
            local unitPrice = item.price * (sender == BUY_QUANTITY and BUY_PERCENTAGE or SELL_PERCENTAGE) * getPriceMultiplier()
            local totalPrice = unitPrice * quantity
            if sender == BUY_QUANTITY then 
                if player:GetCoinage() < totalPrice then
                    player:SendBroadcastMessage("You do not have enough money.")
                    ShowMainMenu(player, object)
                    return
                end
                player:ModifyMoney(-totalPrice)
                local maxStackSize = 20
                local numFullStacks = math.floor(quantity / maxStackSize)
                local remainder = quantity % maxStackSize
                for i = 1, numFullStacks do
                    SendMail("Your purchased item", "Here is a stack of items you purchased.", player:GetGUIDLow(), player:GetGUIDLow(), 62, 0, 0, 0, item.id, maxStackSize)
                end
                if remainder > 0 then
                    SendMail("Your purchased item", "Here is the remaining items you purchased.", player:GetGUIDLow(), player:GetGUIDLow(), 62, 0, 0, 0, item.id, remainder)
                end
                player:SendBroadcastMessage("You bought |cffffffff" .. quantity .. "x|r " .. GetItemString(item) .. " for |cffffffff" .. convertMoney(totalPrice) .. "|r. The items were sent to your mailbox.")
            else
                if not player:HasItem(item.id, quantity) then
                    player:SendBroadcastMessage("You do not have enough items.")
                    ShowMainMenu(player, object)
                    return
                end
                player:RemoveItem(item.id, quantity) 
                player:ModifyMoney(totalPrice) 
                player:SendBroadcastMessage("You sold |cffffffff" .. quantity .. "x|r " .. GetItemString(item) .. " for |cffffffff" .. convertMoney(totalPrice) .. "|r.")
            end
            player:GossipClearMenu()
            ShowMainMenu(player, object)
        else
            ShowMainMenu(player, object)
        end
    else
        ShowMainMenu(player, object)
    end
end



local eventId = CreateLuaEvent(UpdateFluctuation, 3600000, 0)

-- GM Commands for checking multipliers and updating the global fluctuation

local REQUIRED_GM_RANK = 3

local function HandleFluctuationsCommandVanillaTrader(event, player, command)
    if (command:lower() == "vprices") then
        if player:GetGMRank() < REQUIRED_GM_RANK then
            player:SendBroadcastMessage("You do not have permission to use this command.")
            return false
        end
        local dayOfWeek = getDayOfWeek()
        local dayMultiplier = DAY_MULTIPLIER[dayOfWeek]
        local timeMultiplier = getTimeMultiplier()
        local priceMultiplier = getPriceMultiplier()
        local currentTime = os.time()
        local elapsedTimeInMonths = os.difftime(currentTime, ORIGINAL_TIMESTAMP) / (30 * 24 * 60 * 60)
        local inflationMultiplier = 1
        if INFLATION_ENABLED then
            inflationMultiplier = (1 + INFLATION_RATE) ^ elapsedTimeInMonths
            inflationMultiplier = math.min(inflationMultiplier, MAX_INFLATION_MULTIPLIER)
        end
        player:SendBroadcastMessage("Day of the week Multiplier: " .. dayOfWeek .. " (multiplier: " .. dayMultiplier .. ")")
        player:SendBroadcastMessage("Current hour Multiplier: " .. getCurrentHour() .. " (multiplier: " .. timeMultiplier .. ")")
        player:SendBroadcastMessage("Global fluctuation Multiplier: " .. GLOBAL_FLUCTUATION)
        player:SendBroadcastMessage("Inflation Multiplier: " .. inflationMultiplier)
        player:SendBroadcastMessage("Total of Price multiplier: " .. priceMultiplier)
        player:SendBroadcastMessage("Buy percentage: " .. BUY_PERCENTAGE)
        player:SendBroadcastMessage("Sell percentage: " .. SELL_PERCENTAGE)
        player:SendBroadcastMessage("GMs can shuffle the Global Fluctuation with the '.vprices shuffle' command.")
        return false
    end
end

local function HandleShufflePricesCommandVanillaTrader(event, player, command)
    if (command:lower() == "vprices shuffle") then
        if player:GetGMRank() < REQUIRED_GM_RANK then
            player:SendBroadcastMessage("You do not have permission to use this command.")
            return false
        end
        UpdateFluctuation()
        player:SendBroadcastMessage("Prices have been shuffled. New global fluctuation: " .. GLOBAL_FLUCTUATION)
        return false
    end
end

local function HandleBuyPercentageCommandVanillaTrader(event, player, command)
    if command:find("vbp") then
        if player:GetGMRank() < REQUIRED_GM_RANK then
            player:SendBroadcastMessage("You do not have permission to use this command.")
            return false
        end
        local _, _, value = command:find("(%S+)$")
        if value then
            BUY_PERCENTAGE = tonumber(value)
            player:SendBroadcastMessage("Buy multiplier has been set to: " .. BUY_PERCENTAGE)
            player:SendBroadcastMessage("Please note that this change will be reset to script values on server restart.")
            return false
        end
    end
end

local function HandleSellPercentageCommandVanillaTrader(event, player, command)
    if command:find("vsp") then
        if player:GetGMRank() < REQUIRED_GM_RANK then
            player:SendBroadcastMessage("You do not have permission to use this command.")
            return false
        end
        local _, _, value = command:find("(%S+)$")
        if value then
            SELL_PERCENTAGE = tonumber(value)
            player:SendBroadcastMessage("Sell multiplier has been set to: " .. SELL_PERCENTAGE)
            player:SendBroadcastMessage("Please note that this change will be reset to script values on server restart.")
            return false
        end
    end
end

RegisterPlayerEvent(42, HandleBuyPercentageCommandVanillaTrader)
RegisterPlayerEvent(42, HandleSellPercentageCommandVanillaTrader)
RegisterPlayerEvent(42, HandleFluctuationsCommandVanillaTrader)
RegisterPlayerEvent(42, HandleShufflePricesCommandVanillaTrader)
RegisterServerEvent(14, OnServerStartupVanillaFluctuation)

for _, NPCID in ipairs(NPCIDs) do
    RegisterCreatureGossipEvent(NPCID, 1, OnGossipHelloVanillaTrader)
    RegisterCreatureGossipEvent(NPCID, 2, OnGossipSelectVanillaTrader)
end
