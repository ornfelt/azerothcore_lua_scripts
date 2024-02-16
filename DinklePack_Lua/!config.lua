---- Lua scripts preferences
local prefs = {
	-- Global Settings
	Item_RewardPoint = 37711,
	Item_HardcoreKey = 90000,
	NPC_CheckNear = false,
	
	-- Guild Invite Lua
	GI_debugOn = false,
	GI_enabled = true,
	GI_cmd = "guildinvite",
	GI_GuildName = "MadClownWorld",
	
	-- Binding Menu
	BM_debugOn = false,
	BM_enabled = true,
	BM_MenuMenus = true,
	BM_GossipID = 9901002,
	BM_MAP_IDS = {529, 489}, -- The map IDs to BAN
	BM_ZONE_IDS = {876}, -- The Zone IDs to BAN
	
	-- DinkleStone Menu
	
	-- Other Menu
	OM_debugOn = false,
	OM_enabled = true,
	OM_GossipID = 9920005,
	OM_minExpRate = 0,
	OM_maxExpRate = 10,
		
	-- NPC Summon Menu	
	NSM_debugON = false,
	NSM_enabled = true,
	NSM_GossipID = 9920001,
	NSM_NPC_Spawn = {
			--{ID, follow angle offset, "Icon", "Gossip Text"},
			{24939, 0, "|TInterface\\Icons\\Trade_blacksmithing:45:45:-40|t", "Summon Murky"},
			{70000, 20, "|TInterface\\Icons\\Inv_letter_18:45:45:-40|t", "Hire Bots"},
			{190012, 0, "|TInterface\\Icons\\inv_crate_06:45:45:-40|t", "Reagent Banker"},
			{50000, 40, "|TInterface\\Icons\\inv_g_fishingbobber_05:45:45:-40|t", "Individual Progression"},
			{400117, 80, "|TInterface\\Icons\\inv_potion_163:45:45:-40|t", "Buffer"},
			{190010, 60, "|TInterface\\Icons\\sanctum_features_transportationnetwork:45:45:-40|t", "Transmogrifier"},
			{1, 100, "|TInterface\\Icons\\inv_misc_book_07:45:45:-40|t", "Trainer"},
			{999991, 90, "|TInterface\\Icons\\achievement_legionpvp6tier3:45:45:-40|t", "1v1 Arena Master"},
	},
	NSM_NPC_Trainers = {
		[1] = {4594}, -- Warrior
		[2] = {35281}, -- Paladin
		[3] = {987}, -- Hunter
		[4] = {4215}, -- Rogue
		[5] = {17510}, -- Priest
		[6] = {28474}, -- Death Knight
		[7] = {3403}, -- Shaman
		[8] = {28958}, -- Mage
		[9] = {3172}, -- Warlock
		[10] = {3172}, -- Monk LoL
		[11] = {5506}, -- Druid

	},
	
	-- Reward Point Menu
	RPM_debugON = false,
	RPM_enabled = true,
	RPM_GossipID = 9800000,
	RPM_ItemEntry = 66000,
	RPM_ItemEntryPoint = 37711,
	RPM_ItemHardcoreKey = 90000,
	RPM_msgDelay = 6,
	RPM_NPC_Venders = {
			--{ID, follow angle offset, "Icon", "Gossip Text"},
			{401125, 0, "|TInterface\\Icons\\ability_warrior_rallyingcry:45:45:-40|t", "Main Reward Vendor"},
	},
	
	-- Reward Point Earn	
	RPE_debugOn = false,
	RPE_enabled_LvL_up = false,
	RPE_enabled_BG_win = true,
	RPE_points_WG_win = 3,
	RPE_points_AB_win = 5,
	RPE_points_Other_win = 3,
	
	-- Arena Menu
	AM_debugOn = false,
	AM_enabled = true,
	AM_GossipID = 9710000,
	AM_NpcId = 14508,
	
	-- Arena Gurubashi
	AG_debugOn = false,
	AG_range = 100,
	AG_maxSpawn = 5,
	AG_creatureEntries = {
			16423,
			16422,
			400011,
			400057,
	},
	
	-- Belt Menu
	Belt_debugOn = true,
	Belt_enabled = true,
	Belt_GossipID = 99005,
	Belt_ChatCommand = "belts",
}

---------------------------------
local config = {}

function config.get(index, debugON)
	if debugON then
		print("ECC: "..index.." "..tostring(prefs[index]))
	end
	return prefs[index]
end

function config.check(index)
    return prefs[index] ~= nil
end

print("ECC: Eluna Custom Configs Loaded")
return config



--[[
Copy below to make it work for other scripts

-- Settings
local config = require ('!config')-- Need Don't Remove

local luaName = "Binding Menu"
local luaNameShort = "BM_"

local debugON = config.get(luaNameShort.."debugOn")
local enabled = config.get(luaNameShort.."enabled", debugON)
local GossipID = config.get(luaNameShort.."GossipID", debugON)
local MAP_IDS = config.get(luaNameShort.."MAP_IDS", debugON)
local ZONE_IDS = config.get(luaNameShort.."ZONE_IDS", debugON)

if debugON then
	print("ECC: Configs for "..luaName.." Loaded") -- Finished Loading
end

]]