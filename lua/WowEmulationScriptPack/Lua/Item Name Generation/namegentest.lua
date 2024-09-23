--[[ 
it is required to pre-fill the item.dbc as well as the custom table ItemGen EMPTY DISPALY IN ITEM.DBC(USE ADDON TO FIX ?S)
ItemGen is just the Open IDs in the item.dbc that was made
2 custom functions
AddItemToItemStore(adds fresh to ItemStore)(slightly more intensive, and still requires ReloadItem to be called) and ReloadItem(reloads updated stats)

TODO
write tool to auto-generate item.dbc entries and make the sql for the ItemGen table &&  item_template has preset display/class/subclass
remove randomizing the display here, tool above to random the display and this script to get it from ItemGen
More Abstraction
--]]

local requiredMap = 0

local RandomValueAmount = 10
local maxRandomValueRequired = 10 
--iLvl Variables
local ItemLevelVarianceValue = 250
local MinimumItemLevelID = 950
--Quality Variables
local QualityChance = 2000
local BoAChance = 10
local ArtifactChance = 50
local LegendaryChance = 100
local EpicChance = 200
local RareChance = 300
local UncommonChance = 500
local CommonChance = 1000
--Stat Variables
local LowestStat = 90000
local StatDivisor = 6000
local StatRandValue = 70000
--DMG Variables
local dmgRandom = 60000
local dmgDivisor = 8000
local dmgMin = 30000
--all creatures that can roll
local Creatures = {
12323,1233,23245,235676
}
--Tester's Domain Below
local namegen = require("namegen")
--[[
print(namegen.generate("1hAxe"))
print(namegen.generate("2hAxe"))
print(namegen.generate("Bow"))
print(namegen.generate("Gun"))
print(namegen.generate("1hMace"))
print(namegen.generate("2hMace"))
print(namegen.generate("Polearm"))
print(namegen.generate("1hSword"))
print(namegen.generate("2hSword"))
print(namegen.generate("Stave"))
print(namegen.generate("FistWep"))
print(namegen.generate("Dagger"))
print(namegen.generate("Thrown"))
print(namegen.generate("Crossbow"))
print(namegen.generate("Wand"))
print(namegen.generate("Head"))
print(namegen.generate("Shoulder"))
print(namegen.generate("Chest"))
print(namegen.generate("Waist"))
print(namegen.generate("Legs"))
print(namegen.generate("Wrists"))
print(namegen.generate("Hands"))
print(namegen.generate("Feet"))
print(namegen.generate("Plate"))
print(namegen.generate("Mail"))
print(namegen.generate("Leather"))
print(namegen.generate("Cloth"))
print(namegen.generate("Ring"))
print(namegen.generate("Trinket"))
print(namegen.generate("Neck"))
--]]

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local ItemClassSubClassFromDef = {--names come from the itemdefinitions.cfg
	["Neck"] = {4,0},
	["1hAxe"] = {2,0},
	["2hAxe"] = {2,1},
	["Bow"] = {2,2},
	["Gun"] = {2,3},
	["1hMace"] = {2,4},
	["2hMace"] = {2,5},
	["Polearm"] = {2,6},
	["1hSword"] = {2,7},
	["2hSword"] = {2,8},
	["Stave"] = {2,10},
	["FistWep"] = {2,13},
	["Dagger"] = {2,15},
	["Thrown"] = {2,16},
	["Crossbow"] = {2,18},
	["Wand"] = {2,19},
	["PlateHead"] = {4,4},
	["PlateShoulder"] = {4,4},
	["PlateChest"] = {4,4},
	["PlateWaist"] = {4,4},
	["PlateLegs"] = {4,4},
	["PlateFeet"] = {4,4},
	["PlateWrists"] = {4,4},
	["PlateHands"] = {4,4},
	["MailHead"] = {4,3},
	["MailShoulder"] = {4,3},
	["MailChest"] = {4,3},
	["MailWaist"] = {4,3},
	["MailLegs"] = {4,3},
	["MailFeet"] = {4,3},
	["MailWrists"] = {4,3},
	["MailHands"] = {4,3},
	["LeatherHead"] = {4,2},
	["LeatherShoulder"] = {4,2},
	["LeatherChest"] = {4,2},
	["LeatherWaist"] = {4,2},
	["LeatherLegs"] = {4,2},
	["LeatherFeet"] = {4,2},
	["LeatherWrists"] = {4,2},
	["LeatherHands"] = {4,2},
	["ClothHead"] = {4,1},
	["ClothShoulder"] = {4,1},
	["ClothChest"] = {4,1},
	["ClothWaist"] = {4,1},
	["ClothLegs"] = {4,1},
	["ClothFeet"] = {4,1},
	["ClothWrists"] = {4,1},
	["ClothHands"] = {4,1},
	["Ring"] = {4,0},
	["Trinket"] = {4,0},
	["Cloak"] = {4,0},	
}

local InventoryTypeFromDef = {
	["1hAxe"] = 13,
	["2hAxe"] = 17,
	["Bow"] = 26,
	["Gun"] = 26,
	["1hMace"] = 13,
	["2hMace"] = 17,
	["Polearm"] = 17,
	["1hSword"] = 13,
	["2hSword"] = 17,
	["Stave"] = 17,
	["FistWep"] = 13,
	["Dagger"] = 13,
	["Thrown"] = 25,
	["Crossbow"] = 26,
	["Wand"] = 26,
	["PlateHead"] = 1,
	["PlateShoulder"] = 3,
	["PlateChest"] = 5,
	["PlateWaist"] = 6,
	["PlateLegs"] = 7,
	["PlateFeet"] = 8,
	["PlateWrists"] = 9,
	["PlateHands"] = 10,
	["MailHead"] = 1,
	["MailShoulder"] = 3,
	["MailChest"] = 5,
	["MailWaist"] = 6,
	["MailLegs"] = 7,
	["MailFeet"] = 8,
	["MailWrists"] = 6,
	["MailHands"] = 10,
	["LeatherHead"] = 1,
	["LeatherShoulder"] = 3,
	["LeatherChest"] = 5,
	["LeatherWaist"] = 6,
	["LeatherLegs"] = 7,
	["LeatherFeet"] = 8,
	["LeatherWrists"] = 9,
	["LeatherHands"] = 10,
	["ClothHead"] = 1,
	["ClothShoulder"] = 3,
	["ClothChest"] = 5,
	["ClothWaist"] = 6,
	["ClothLegs"] = 7,
	["ClothFeet"] = 8,
	["ClothWrists"] = 9,
	["ClothHands"] = 10,
	["Ring"] = 11,
	["Trinket"] = 12,
	["Neck"] = 2,
	["Cloak"] = 16,
}

local NamingArmorSet = {
[4] = 	{ --armor
		{--Cloth
			[1] = {"Cloth","Head"},
			[3] = {"Cloth","Shoulder"},
			[5] = {"Cloth","Chest"},
			[6] = {"Cloth","Waist"},
			[7] = {"Cloth","Legs"},
			[8] = {"Cloth","Feet"},
			[9] = {"Cloth","Wrists"},
			[10] = {"Cloth","Hands"},
		},
		{--Leather
			[1] = {"Leather","Head"},
			[3] = {"Leather","Shoulder"},
			[5] = {"Leather","Chest"},
			[6] = {"Leather","Waist"},
			[7] = {"Leather","Legs"},
			[8] = {"Leather","Feet"},
			[9] = {"Leather","Wrists"},
			[10] = {"Leather","Hands"},
		},
		{--Mail
			[1] = {"Mail","Head"},
			[3] = {"Mail","Shoulder"},
			[5] = {"Mail","Chest"},
			[6] = {"Mail","Waist"},
			[7] = {"Mail","Legs"},
			[8] = {"Mail","Feet"},
			[9] = {"Mail","Wrists"},
			[10] = {"Mail","Hands"},
		},
		{--Plate
			[1] = {"Plate","Head"},
			[3] = {"Plate","Shoulder"},
			[5] = {"Plate","Chest"},
			[6] = {"Plate","Waist"},
			[7] = {"Plate","Legs"},
			[8] = {"Plate","Feet"},
			[9] = {"Plate","Wrists"},
			[10] = {"Plate","Hands"},
		},
		{--Jewlery
			[11] = {"Misc","Ring"},
			[12] = {"Misc","Trinket"},
			[2] = {"Misc","Neck"},
			[16] = {"Misc","Cloak"},
		},
	},

}

local StatTypes = {
	0,1,3,4,5,7,16,17,18,22,23,24,25,26,27,31,32,33,34,38,39,41,42,43,45,46,48,
}

local SocketColors = {
	[1] = 1,
	[2] = 2,
	[3] = 4,
	[4] = 8,
}

local function getItemName(Class,SubClass,ItemTypeDef)
	if(Class == 4) then--armor
		if(InventoryTypeFromDef[ItemTypeDef] ~= 2 and InventoryTypeFromDef[ItemTypeDef] ~= 4 and InventoryTypeFromDef[ItemTypeDef] < 11 and InventoryTypeFromDef[ItemTypeDef] < 16) then--main set
			return namegen.generate(NamingArmorSet[Class][SubClass][InventoryTypeFromDef[ItemTypeDef]][1]) .. " " .. namegen.generate(NamingArmorSet[Class][SubClass][InventoryTypeFromDef[ItemTypeDef]][2])
		else--jewelry
			return namegen.generate(NamingArmorSet[Class][SubClass+5][InventoryTypeFromDef[ItemTypeDef]][1]) .. " " .. namegen.generate(NamingArmorSet[Class][SubClass+5][InventoryTypeFromDef[ItemTypeDef]][2])
		end
	elseif (Class == 2) then--weapon
		return namegen.generate(ItemTypeDef)
	end
end

local function GetQuality()
	local chance = math.random(QualityChance)
	if(chance < BoAChance) then
		return 7 --BoA
	elseif(chance < ArtifactChance) then
		return 6 --Artifact
	elseif(chance < LegendaryChance) then
		return 5 --Legendary
	elseif(chance < EpicChance) then
		return 4 --Epic
	elseif(chance < RareChance) then
		return 3 --Rare
	elseif(chance < UncommonChance) then
		return 2 --Uncommon
	elseif(chance < CommonChance) then
		return 1 --common
	else
		return 0 --Poor
	end
end

local function GetFlags(Quality)
	if(Quality == 7) then --BoA
		return 134221824
	else
		return 0
	end
end

local function GetStats(Quality, ItemLevel, StatCount)
	local i = 1
	local Stats = {}
	while i <= 10 do
		Stats[i] = {0,0}
		i = i +1
	end
	i = 1
	while i <= StatCount do
		Stats[i] = {StatTypes[math.random(#StatTypes)],math.floor(((math.random(StatRandValue)*Quality*ItemLevel)/StatDivisor)) + LowestStat}
		if(math.random(100) == 1)then
			Stats[i] = -1*Stats[i]
		end
		i = i + 1
	end
	return Stats
end

local function getDMG(Quality,ItemLevel,InventoryTypeFromDef)
	if(InventoryTypeFromDef == 13 or InventoryTypeFromDef == 17 or InventoryTypeFromDef == 25 or InventoryTypeFromDef == 26)then--weapons
		local DMGMin1 = math.floor(((math.random(dmgRandom)*Quality*ItemLevel)/dmgDivisor)) + dmgMin
		if(InventoryTypeFromDef == 13 or InventoryTypeFromDef == 25) then
			DMGMin1 = DMGMin1/2
		end
		local DMGMax1 = math.floor(DMGMin1*((math.random(20)/20)+1))
		local DMG_Type1 = 0
		local DMGMin2 = DMGMin1/2
		local DMGMax2 = DMGMax1/2
		local DMG_Type2 = math.random(6)
		return DMGMin1,DMGMax1,DMG_Type1,DMGMin2,DMGMax2,DMG_Type2
	else --armor
		return 0,0,0,0,0,0
	end
end

local function GetArmor(Quality,InventoryType)
	if(InventoryType == 13 or InventoryType == 17 or InventoryType == 25 or InventoryType == 26)then--weapons
		return 0
	else
		return math.floor(500*Quality/2)
	end
end

local function GetDelay(InventoryType)
	if(InventoryType == 13 or InventoryType == 17 or InventoryType == 25 or InventoryType == 26)then--weapons
		if(InventoryType == 13) then --1h
			return (math.random(10)/10) + 2
		else
			return (math.random(10)/10) + 3
		end
	else
		return 0
	end
end

local function getEnchant(Class,SubClass)
	local query = WorldDBQuery("SELECT enchantID FROM item_enchantment_random_tiers WHERE tier=1 AND exclusiveSubClass=NULL AND class='"..Class.."' OR exclusiveSubClass="..SubClass.." OR class='ANY' ORDER BY RAND() LIMIT 1")
		return query:GetUInt32(0)	
end

local function GetSockets()
	i = 1
	local Socket = {}
	while i <= 3 do
		Socket[i] = {0,0}
		i = i +1
	end
	if(math.random(10) <= 3) then
		local amount = math.random(3)
		i = 1
		while i <= amount do
			Socket[i] = {SocketColors[math.random(#SocketColors)],1}
			i = i +1
		end
	end
	return Socket
end

local function onCreatureKill(event, killer, killed)
	if (killer:GetMapId() == requiredMap and math.random(RandomValueAmount) <= maxRandomValueRequired) then-- and table.contains(Creatures,killed:GetEntry())
		createItem(killer)
	end
end

function createItem(player)
	local Q = WorldDBQuery("SELECT Entry,Definition,DisplayID FROM ItemGen ORDER BY rand() limit 1")
	local ItemID = Q:GetUInt32(0)
	local ItemTypeDef = Q:GetString(1)
	local DisplayID = Q:GetUInt32(2)
	local Class = ItemClassSubClassFromDef[ItemTypeDef][1]
	local SubClass = ItemClassSubClassFromDef[ItemTypeDef][2]
	local ItemName = getItemName(Class,SubClass,ItemTypeDef)
	local Quality = GetQuality()
	local Flags = GetFlags(Quality)
	local InventoryType = InventoryTypeFromDef[ItemTypeDef]
	local ItemLevel = math.random(ItemLevelVarianceValue) + MinimumItemLevelID
	local StatCount = Quality + math.random(3)
	local Stats = GetStats(Quality, ItemLevel,StatCount)
	local DMGMin1,DMGMax1,DMG_Type1,DMGMin2,DMGMax2,DMG_Type2 = getDMG(Quality,ItemLevel,InventoryTypeFromDef)
	local Armor = GetArmor(Quality,InventoryType)
	local Delay = GetDelay(InventoryType)
	local Bonding = 2
	local Description = namegen.generate("Desc")
	local Material = 1
	local RandomProperty = 0--getEnchant(Class,SubClass)
	local Sockets = GetSockets()
	ItemID = 25--TESTING ID
	--local g = WorldDBQuery("INSERT INTO `item_template`(`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`,`RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`,  `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`,  `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`,`spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`,  `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`,  `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`,  `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`)  VALUES (" .. ItemID .. ", " .. Class .. ", " .. SubClass .. ", -1, '" .. ItemName .."' ," .. DisplayID .. ", " .. Quality .. ", " .. Flags .. ", 0, 1, 1, 1, " .. InventoryType .. ", -1, -1, " .. ItemLevel .. ", 100, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, " .. StatCount .. ", " .. Stats[1][1] .. ", " .. Stats[1][2] .. ", " .. Stats[2][1] .. ", " .. Stats[2][2] .. ", " .. Stats[3][1] .. ", " .. Stats[3][2] .. ", " .. Stats[4][1] .. ", " .. Stats[4][2] .. ", " .. Stats[5][1] .. ", " .. Stats[5][2] .. ", " .. Stats[6][1] .. ", " .. Stats[6][2] .. ", " .. Stats[7][1] .. ", " .. Stats[7][2] .. ", " .. Stats[8][1] .. ", " .. Stats[8][2] .. ", " .. Stats[9][1] .. ", " .. Stats[9][2] .. ", " .. Stats[10][1] .. ", " .. Stats[10][2] .. ", 0, 0, " .. DMGMin1 .. ", " .. DMGMax1.. ", " .. DMG_Type1 .. ", " .. DMGMin2 .. ", " .. DMGMax2 .. ", " .. DMG_Type2 .. ", 0, 0, 0, 0, 0, 0, 0, " .. Delay .. ", 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, " .. Bonding .. ", '" .. Description .. "', 0, 1, 0, 0, 0, " .. Material .. ", " .. Sheath .. ", " .. RandomProperty .. ", 0, 0, 0, 0, 0, 0, 0, 0, " .. Sockets[1][1] .. ", " .. Sockets[1][2] .. ", " .. Sockets[2][1] .. ", " .. Sockets[2][2] .. ", " .. Sockets[3][1] .. ", " .. Sockets[3][2] .. ", 0, 0, -1, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 12340);")
	local g = WorldDBQuery("UPDATE `item_template` SET name = '" .. ItemName .. "', displayid = " .. DisplayID .. ", Quality = " .. Quality .. ", Flags = " .. Flags .. ", ItemLevel = " .. ItemLevel .. ", StatsCount = " .. StatCount .. ", stat_type1 = " .. Stats[1][1] .. ", stat_value1 = " .. Stats[1][2] .. ", stat_type2 = " .. Stats[2][1] .. ", stat_value2 = " .. Stats[2][2] .. ", stat_type3 = " .. Stats[3][1] .. ", stat_value3 = " .. Stats[3][2] .. ", stat_type4 = " .. Stats[4][1] .. ", stat_value4 = " .. Stats[4][2] .. ", stat_type5 = " .. Stats[5][1] .. ", stat_value5 = " .. Stats[5][2] .. ", stat_type6 = " .. Stats[6][1] .. ", stat_value6 = " .. Stats[6][2] .. ", stat_type7 = " .. Stats[7][1] .. ", stat_value7 = " .. Stats[7][2] .. ", stat_type8 = " .. Stats[8][1] .. ", stat_value8 = " .. Stats[8][2] .. ", stat_type9 = " .. Stats[9][1] .. ", stat_value9 = " .. Stats[9][2] .. ", stat_type10 = " .. Stats[10][1] .. ", stat_value10 = " .. Stats[10][2] .. ", dmg_min1 = " .. DMGMin1 ..", dmg_max1 = " .. DMGMax1 .. ",dmg_type1 = " .. DMG_Type1 .. ",dmg_min2 = " .. DMGMin2 .. ", dmg_max2 = " .. DMGMax2 .. ",dmg_type2 = " .. DMG_Type2 .. ", armor = " .. Armor .. ", delay = " .. Delay .. ", bonding = " .. Bonding .. ", description = '" .. Description .. "', Material = " .. Material .. ", RandomProperty = " .. RandomProperty .. ", socketColor_1 = " .. Sockets[1][1] .. ", socketContent_1 = " .. Sockets[1][2] .. ", socketColor_2 = " .. Sockets[2][1] .. ", socketContent_2 = " .. Sockets[2][2] .. ", socketColor_3 = " .. Sockets[3][1] .. ", socketContent_3 = " .. Sockets[3][2] .. " WHERE entry = ".. ItemID)
	WorldDBExecute("DELETE FROM ItemGen WHERE entry = " .. ItemID)
	player:ReloadItem(ItemID)
	player:AddItem(ItemID,1)
end

RegisterPlayerEvent(7,onCreatureKill)