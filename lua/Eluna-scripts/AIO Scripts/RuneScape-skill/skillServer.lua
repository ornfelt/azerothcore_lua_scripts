local AIO = AIO or require("AIO")

local skillHandler = AIO.AddHandlers("RuneScapeSkillSystem", {})

local XP_TABLE = {}
local SKILL_META_CACHE = {} -- Cache for skill metadata
local MILESTONE_CACHE = {} -- Cache for milestone data
local PLAYER_SKILL_CACHE = {} -- Cache for player skill data (key: player_guid..skill_id)
local PENDING_PLAYER_SAVES = {} -- Cache for pending database updates [guid][skillId] = {level=L, experience=XP}

local SkillSystem = {}

local levelUpEffect = 24312 -- effect visual for level up now its normal levelup thing

-- Handler for client request to send skill data
function skillHandler.RequestSkillData(player)
	SkillSystem.SendSkillDataToClient(player)
end

-- Function to load all skill metadata into cache
function SkillSystem.LoadSkillMetaCache()
	local result = WorldDBQuery(
		"SELECT id, name, icon, max_level, description, display_order FROM custom_skills_rs ORDER BY display_order, id"
	)
	if not result then
		print("Warning: No skills found in custom_skills_rs table")
		return
	end

	repeat
		local id = result:GetUInt32(0)
		SKILL_META_CACHE[id] = {
			id = id,
			name = result:GetString(1),
			icon = result:GetString(2),
			max_level = result:GetUInt32(3),
			description = result:GetString(4),
			display_order = result:GetUInt32(5),
		}
	until not result:NextRow()

	print("Loaded " .. #SKILL_META_CACHE .. " skills into cache")
end

-- Function to load all milestone data into cache
function SkillSystem.LoadMilestoneCache()
	local result = WorldDBQuery(
		"SELECT skill_id, level, milestone_type, description, reward_type, reward_id, reward_amount, reward_data FROM custom_skill_milestones_rs"
	)
	if not result then
		print("Warning: No milestones found in custom_skill_milestones_rs table")
		return
	end

	repeat
		local skillId = result:GetUInt32(0)
		local level = result:GetUInt32(1)

		MILESTONE_CACHE[skillId] = MILESTONE_CACHE[skillId] or {}
		MILESTONE_CACHE[skillId][level] = {
			milestone_type = result:GetString(2),
			description = result:GetString(3),
			reward_type = result:GetString(4),
			reward_id = result:GetUInt32(5),
			reward_amount = result:GetUInt32(6),
			reward_data = result:GetString(7),
		}
	until not result:NextRow()
end

-- This function calculates the total experience required to reach a given level in RuneScape.
function SkillSystem.GetTotalXPForLevel(level)
	local totalXP = 0
	for lvl = 1, level - 1 do
		totalXP = totalXP + math.floor(lvl + 300 * 2 ^ (lvl / 7))
	end
	return math.floor(totalXP / 4)
end

function SkillSystem.InitializeXPTable()
	for level = 1, 100 do
		XP_TABLE[level] = SkillSystem.GetTotalXPForLevel(level)
	end
end

SkillSystem.InitializeXPTable()

-- Initialize caches on startup
SkillSystem.LoadSkillMetaCache()
SkillSystem.LoadMilestoneCache()

-- Helper function to send XP updates to client (separate from full skill data updates)
function SkillSystem.SendXPUpdate(player, skillId, skillName, level, experience)
	-- Calculate XP for current level and next level
	local currentLevelXP = XP_TABLE[level] or 0
	local nextLevelXP = XP_TABLE[level + 1] or (currentLevelXP + 1000)

	-- Get max level from cache
	local maxLevel = 99
	if SKILL_META_CACHE[skillId] then
		maxLevel = SKILL_META_CACHE[skillId].max_level
	end

	-- Create XP info package
	local xpInfo = {
		skillId = skillId,
		skillName = skillName,
		level = level,
		currentExp = experience,
		currentLevelExp = currentLevelXP,
		nextLevelExp = nextLevelXP,
		isMaxLevel = level >= maxLevel,
	}

	-- Send just the XP update (lighter than full milestone update)
	AIO.Handle(player, "RuneScapeSkillSystem", "UpdateSkillXP", xpInfo)
end

function SkillSystem.AddExperience(player, skillName, amount)
	local guid = player:GetGUIDLow()

	-- Find skill ID from cache by name
	local skillId = nil
	local skillData = nil

	-- Ensure cache is loaded
	if next(SKILL_META_CACHE) == nil then
		SkillSystem.LoadSkillMetaCache()
	end

	-- Look up skill by name using cache
	for id, data in pairs(SKILL_META_CACHE) do
		if data.name == skillName then
			skillId = id
			skillData = data
			break
		end
	end

	if not skillId then
		-- Fallback to database lookup if not in cache
		local skillIdResult =
			WorldDBQuery(string.format("SELECT id FROM custom_skills_rs WHERE name = '%s'", skillName))
		if not skillIdResult then
			print(string.format("SkillSystem.AddExperience: Skill '%s' not found in custom_skills_rs.", skillName))
			return
		end
		skillId = skillIdResult:GetUInt32(0)

		-- Since we had to query, reload skill cache
		SkillSystem.LoadSkillMetaCache()
		skillData = SKILL_META_CACHE[skillId]
	end

	-- Check if we have cached player skill data
	local cacheKey = guid .. "_" .. skillId
	local level, experience

	if PLAYER_SKILL_CACHE[cacheKey] then
		-- Use cached data
		level = PLAYER_SKILL_CACHE[cacheKey].level
		experience = PLAYER_SKILL_CACHE[cacheKey].experience
	else
		-- Query from database only if cache is empty
		local result = CharDBQuery(
			string.format(
				"SELECT skill_level, skill_experience FROM custom_player_skills_rs WHERE player_guid = %d AND skill_id = %d",
				guid,
				skillId
			)
		)

		if result then
			level = result:GetUInt32(0)
			experience = result:GetUInt32(1)
		else
			level = 1
			experience = 0
			CharDBExecute(
				string.format(
					"INSERT INTO custom_player_skills_rs (player_guid, skill_id, skill_level, skill_experience) VALUES (%d, %d, %d, %d)",
					guid,
					skillId,
					level,
					experience
				)
			)
		end

		-- Cache the result
		PLAYER_SKILL_CACHE[cacheKey] = {
			level = level,
			experience = experience,
		}
	end

	-- Store original values to check if update is needed
	local originalLevel = level
	local originalExp = experience

	-- Add experience
	experience = experience + amount

	-- Get max level from cached skill data
	local maxLevel = skillData and skillData.max_level or 99 -- Default to 99 if not found

	local leveledUp = false
	while level < maxLevel and experience >= XP_TABLE[level + 1] do
		level = level + 1
		player:SendBroadcastMessage(string.format("Your %s skill has increased to level %d!", skillName, level))
		SkillSystem.CheckSkillMilestone(player, skillId, level)
		leveledUp = true
	end

	-- Update the cache
	PLAYER_SKILL_CACHE[cacheKey] = {
		level = level,
		experience = experience,
	}

	-- *** Defer database update ***
	-- Instead of CharDBExecute here, add to pending saves
	PENDING_PLAYER_SAVES[guid] = PENDING_PLAYER_SAVES[guid] or {}
	PENDING_PLAYER_SAVES[guid][skillId] = {
		level = level,
		experience = experience,
	}
	-- Mark that this player has pending saves (optional, could check table size)
	-- PLAYER_HAS_PENDING_SAVE[guid] = true

	-- Send light XP update first for immediate feedback
	SkillSystem.SendXPUpdate(player, skillId, skillName, level, experience)

	-- If leveled up, send full skill data update and milestone information
	if leveledUp then
		-- Send updated skill data to client
		SkillSystem.SendSkillDataToClient(player)
		-- Send updated milestones for this skill to client
		SkillSystem.SendSkillMilestonesToClient(player, skillId)
	end
end

-- Add this helper to send milestones for a skill
function SkillSystem.SendSkillMilestonesToClient(player, skillId)
	local milestones = {}
	local guid = player:GetGUIDLow()

	-- Get player's level for this skill from cache only
	local level = 1
	local cacheKey = guid .. "_" .. skillId

	if PLAYER_SKILL_CACHE[cacheKey] then
		level = PLAYER_SKILL_CACHE[cacheKey].level
	end

	-- Get milestone data from cache
	if not MILESTONE_CACHE[skillId] then
		-- Fallback to database query if not in cache
		SkillSystem.LoadMilestoneCache()
	end

	-- Build milestone data
	if MILESTONE_CACHE[skillId] then
		-- Sort milestone levels
		local milestoneLevels = {}
		for milestoneLevel, _ in pairs(MILESTONE_CACHE[skillId]) do
			table.insert(milestoneLevels, milestoneLevel)
		end
		table.sort(milestoneLevels)

		-- Build milestone info list in order
		for _, milestoneLevel in ipairs(milestoneLevels) do
			local milestoneData = MILESTONE_CACHE[skillId][milestoneLevel]
			table.insert(milestones, {
				level = milestoneLevel,
				milestone_type = milestoneData.milestone_type,
				description = milestoneData.description,
				unlocked = milestoneLevel <= level,
			})
		end
	end

	AIO.Handle(player, "RuneScapeSkillSystem", "UpdateSkillMilestones", skillId, milestones)
end

function skillHandler.RequestSkillMilestones(player, skillId)
	local milestones = {}
	-- Get player's current level for this skill from cache only
	local guid = player:GetGUIDLow()
	local level = 1
	local experience = 0
	local cacheKey = guid .. "_" .. skillId
	if PLAYER_SKILL_CACHE[cacheKey] then
		level = PLAYER_SKILL_CACHE[cacheKey].level
		experience = PLAYER_SKILL_CACHE[cacheKey].experience
	end

	-- Calculate XP for current level and next level
	local currentLevelXP = XP_TABLE[level]
	local nextLevelXP = XP_TABLE[level + 1]

	-- Fetch max level for this skill
	local maxLevel = 99
	if SKILL_META_CACHE[skillId] then
		maxLevel = SKILL_META_CACHE[skillId].max_level
	end

	local milestoneResult = WorldDBQuery(
		string.format(
			"SELECT level, milestone_type, description FROM custom_skill_milestones_rs WHERE skill_id = %d ORDER BY level ASC",
			skillId
		)
	)
	if milestoneResult then
		repeat
			local milestoneLevel = milestoneResult:GetUInt32(0)
			table.insert(milestones, {
				level = milestoneLevel,
				milestone_type = milestoneResult:GetString(1),
				description = milestoneResult:GetString(2),
				unlocked = milestoneLevel <= level, -- true if player has reached this milestone
			})
		until not milestoneResult:NextRow()
	end

	-- Create experience info table
	local expInfo = {
		currentExp = experience,
		currentLevelExp = currentLevelXP or 0,
		nextLevelExp = nextLevelXP or 0,
		isMaxLevel = level >= maxLevel,
	}

	AIO.Handle(player, "RuneScapeSkillSystem", "UpdateSkillMilestones", skillId, milestones, expInfo)
end

local function GetPlayerSkillsData(player)
	local guid = player:GetGUIDLow()
	local orderedSkills = {}
	local playerSkills = {}

	-- Use the cached skill metadata instead of querying
	if next(SKILL_META_CACHE) == nil then
		SkillSystem.LoadSkillMetaCache() -- Reload cache if empty
	end

	-- Build player skills hash for quick lookups from cache only
	for id, data in pairs(SKILL_META_CACHE) do
		local cacheKey = guid .. "_" .. id
		if PLAYER_SKILL_CACHE[cacheKey] then
			playerSkills[id] = {
				level = PLAYER_SKILL_CACHE[cacheKey].level,
				experience = PLAYER_SKILL_CACHE[cacheKey].experience,
			}
		end
	end

	-- Get skill order from cache (already ordered by display_order)
	local skillOrder = {}
	for id, _ in pairs(SKILL_META_CACHE) do
		table.insert(skillOrder, id)
	end
	table.sort(skillOrder, function(a, b)
		return SKILL_META_CACHE[a].display_order < SKILL_META_CACHE[b].display_order
	end)

	-- Populate the orderedSkills array with merged data
	for _, id in ipairs(skillOrder) do
		local skillData = SKILL_META_CACHE[id]
		if skillData then
			-- Clone the metadata
			local skillInfo = {
				id = skillData.id,
				name = skillData.name,
				icon = skillData.icon,
				max_level = skillData.max_level,
				description = skillData.description,
				display_order = skillData.display_order,
				level = 1, -- Default level
				experience = 0, -- Default experience
			}

			-- Merge with player data if exists
			if playerSkills[id] then
				skillInfo.level = playerSkills[id].level
				skillInfo.experience = playerSkills[id].experience
			end

			table.insert(orderedSkills, skillInfo)
		end
	end

	return orderedSkills
end

function SkillSystem.SendSkillDataToClient(player)
	print("Sending skill data to player " .. player:GetName())
	local skills = GetPlayerSkillsData(player)
	-- AIO.Handle(player, "RuneScapeSkillSystem", "UpdateSkills", skills)
	AIO.Handle(player, "RuneScapeSkillSystem", "UpdateSkills", skills) -- Send the skills data to the client
	print("Skill data sent to player " .. player:GetName())
end

-- Grant milestone reward to player based on reward_type
local function GrantMilestoneReward(player, rewardType, rewardId, rewardAmount, rewardData)
	if not rewardType or not rewardId then
		return
	end
	rewardAmount = rewardAmount or 1

	if rewardType == "spell" then
		player:LearnSpell(rewardId)
	elseif rewardType == "item" then
		player:AddItem(rewardId, rewardAmount)
	elseif rewardType == "currency" then
		player:ModifyMoney(rewardAmount)
	elseif rewardType == "custom" and rewardData then
		-- Implement custom reward logic here, e.g. parse rewardData as JSON
		-- Example: local data = ParseJson(rewardData)
		-- Custom handling...
	end
end

function SkillSystem.CheckSkillMilestone(player, skillId, level)
	-- Get milestone data from cache
	local milestone = nil

	if MILESTONE_CACHE[skillId] and MILESTONE_CACHE[skillId][level] then
		milestone = MILESTONE_CACHE[skillId][level]
	else
		-- Fallback to database if not in cache
		local result = WorldDBQuery(
			string.format(
				"SELECT milestone_type, description, reward_type, reward_id, reward_amount, reward_data FROM custom_skill_milestones_rs WHERE skill_id = %d AND level = %d",
				skillId,
				level
			)
		)
		if result then
			milestone = {
				milestone_type = result:GetString(0),
				description = result:GetString(1) or "",
				reward_type = result:GetString(2),
				reward_id = result:GetUInt32(3),
				reward_amount = result:GetUInt32(4),
				reward_data = result:GetString(5),
			}

			-- Add to cache
			MILESTONE_CACHE[skillId] = MILESTONE_CACHE[skillId] or {}
			MILESTONE_CACHE[skillId][level] = milestone
		end
	end

	if milestone then
		-- Get skill name from cache
		local skillName = "Unknown Skill"
		if SKILL_META_CACHE[skillId] then
			skillName = SKILL_META_CACHE[skillId].name
		end

		if milestone.milestone_type == "major" then
			player:SendBroadcastMessage(
				string.format(
					"Congratulations! You've reached a major milestone in %s: Level %d. %s",
					skillName,
					level,
					milestone.description
				)
			)
		else
			player:SendBroadcastMessage(
				string.format("You've reached Level %d in %s. %s Keep it up!", level, skillName, milestone.description)
			)
		end

		-- Grant the reward if defined
		GrantMilestoneReward(
			player,
			milestone.reward_type,
			milestone.reward_id,
			milestone.reward_amount,
			milestone.reward_data
		)
	end
end

-- Send skill data on player login
local function LoadPlayerSkillsToCache(player)
	local guid = player:GetGUIDLow()
	local result = CharDBQuery(
		string.format(
			"SELECT skill_id, skill_level, skill_experience FROM custom_player_skills_rs WHERE player_guid = %d",
			guid
		)
	)
	if result then
		repeat
			local skillId = result:GetUInt32(0)
			local level = result:GetUInt32(1)
			local experience = result:GetUInt32(2)
			local cacheKey = guid .. "_" .. skillId
			PLAYER_SKILL_CACHE[cacheKey] = {
				level = level,
				experience = experience,
			}
		until not result:NextRow()
	end
end

local function OnPlayerLogin(event, player)
	LoadPlayerSkillsToCache(player)
	SkillSystem.SendSkillDataToClient(player)
end
local PLAYER_EVENT_ON_LOGIN = 3 --  this is the correct event ID for player login
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnPlayerLogin)

-- Clean up player cache on logout to prevent memory bloat
local function OnPlayerLogout(event, player)
	local guid = player:GetGUIDLow()

	-- *** Save any pending updates for this player before clearing cache ***
	SkillSystem.SavePlayerUpdates(player)

	-- Clean up player's skill cache entries
	local keysToRemove = {}
	for key, _ in pairs(PLAYER_SKILL_CACHE) do
		if key:find("^" .. guid .. "_") then
			table.insert(keysToRemove, key)
		end
	end

	for _, key in ipairs(keysToRemove) do
		PLAYER_SKILL_CACHE[key] = nil
	end
end

-- Register player logout event
local PLAYER_EVENT_ON_LOGOUT = 4 -- 4 is the event ID for player logout
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGOUT, OnPlayerLogout) -- 4 is the event ID for player logout

-- Periodically clean up old cache entries (every hour)
local function CleanupCache()
	-- This would be more effective with timestamps, but for simplicity
	-- we'll just limit the size of the cache

	-- If cache exceeds 1000 entries, clear old entries
	if table.getn(PLAYER_SKILL_CACHE) > 1000 then
		print("Player skill cache exceeded 1000 entries, cleaning up...")
		PLAYER_SKILL_CACHE = {}
		collectgarbage("collect")
	end

	-- Re-register the timer
	CreateLuaEvent(CleanupCache, 3600000, 1) -- 3600000ms = 1 hour
end

-- Start the cleanup timer
CreateLuaEvent(CleanupCache, 3600000, 1) -- First cleanup after 1 hour

function SkillSystem.SavePendingUpdates()
	for guid, skills in pairs(PENDING_PLAYER_SAVES) do
		for skillId, data in pairs(skills) do
			-- Save to database
			CharDBExecute(
				string.format(
					"REPLACE INTO custom_player_skills_rs (player_guid, skill_id, skill_level, skill_experience) VALUES (%d, %d, %d, %d)",
					guid,
					skillId,
					data.level,
					data.experience
				)
			)
		end
		-- Clear after saving
		PENDING_PLAYER_SAVES[guid] = nil
	end
end

-- Schedule periodic saving of pending XP updates (e.g., every 5 minutes = 300000 ms)
local SAVE_INTERVAL_MS = 300000
CreateLuaEvent(SkillSystem.SavePendingUpdates, SAVE_INTERVAL_MS, 0) -- 0 means repeat indefinitely
print("Scheduled periodic skill update saving every " .. (SAVE_INTERVAL_MS / 1000) .. " seconds.")

-- DEBUG: Add a command to force-save pending XP updates immediately
function SkillSystem.SavePlayerUpdates(player)
	local guid = player:GetGUIDLow()
	local skills = PENDING_PLAYER_SAVES[guid]
	if not skills then
		player:SendBroadcastMessage("No pending skill XP to save.")
		return
	end
	for skillId, data in pairs(skills) do
		CharDBExecute(
			string.format(
				"REPLACE INTO custom_player_skills_rs (player_guid, skill_id, skill_level, skill_experience) VALUES (%d, %d, %d, %d)",
				guid,
				skillId,
				data.level,
				data.experience
			)
		)
	end
	PENDING_PLAYER_SAVES[guid] = nil
	player:SendBroadcastMessage("Your pending skill XP has been saved.")
end

function SkillSystem.DebugForceSave(event, player, message, type, language)
	if message:lower() == "#forceskillxp" then
		SkillSystem.SavePlayerUpdates(player)
		return false
	end
end
RegisterPlayerEvent(18, SkillSystem.DebugForceSave)

-- Helper function to clear and reload all caches
function SkillSystem.ReloadCaches()
	-- Clear all caches
	SKILL_META_CACHE = {}
	MILESTONE_CACHE = {}
	-- Note: We don't clear player skill cache to avoid performance hit

	-- Reload core data
	SkillSystem.LoadSkillMetaCache()
	SkillSystem.LoadMilestoneCache()

	print("Skill system caches reloaded")
end

local function OnLuaStateOpen(event)
	-- Reload caches when Lua state opens to ensure data consistency
	SkillSystem.ReloadCaches()

	-- Get all players in the world
	local player = GetPlayersInWorld()
	for _, p in ipairs(player) do
		-- Check if the player is in the world
		if p:IsInWorld() then
			print("Lua state opened for player " .. p:GetName())
			SkillSystem.SendSkillDataToClient(p) -- Send skills to the player when Lua state opens
		end
	end
end

RegisterServerEvent(33, OnLuaStateOpen)

-- Function to handle the update XP command
function SkillSystem.HandleUpdateXPCommand(event, player, message, type, language)
	-- Early exit if not correct command
	if not message:lower():match("^#addrsxp") then
		return false
	end

	-- Parse command arguments, accounting for the leading #
	local skillName, amount = message:match("^#addrsxp%s+(%S+)%s+(%d+)")
	if not skillName or not amount then
		player:SendBroadcastMessage("Usage: #addrsxp <skill_name> <amount>")
		return false
	end
	-- Convert amount to number
	amount = tonumber(amount)
	if not amount then
		player:SendBroadcastMessage("Invalid amount. Please provide a number.")
		return false
	end
	-- Format skill name properly
	skillName = skillName:sub(1, 1):upper() .. skillName:sub(2):lower()
	-- Add experience and notify player
	SkillSystem.AddExperience(player, skillName, amount)
	player:SendBroadcastMessage(string.format("Added %d XP to %s skill.", amount, skillName))
	return false
end

-- Register the command handler for player chat (event 18)
RegisterPlayerEvent(18, SkillSystem.HandleUpdateXPCommand)

-- Reward XP for finishing Mining 5 (spell 50310)
local PLAYER_EVENT_ON_SPELL_CAST = 5 -- (event, player, spell, skipCheck)

local function OnMiningSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() == 50310 then
        -- Reward a fixed amount of XP for mining (adjust as needed)
        local miningXP = 25
        SkillSystem.AddExperience(player, "Mining", miningXP)
        player:SendBroadcastMessage("You gained " .. miningXP .. " Mining XP!")
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_SPELL_CAST, OnMiningSpellCast)
