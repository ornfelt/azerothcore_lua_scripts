local AIO = AIO or require("AIO")

local skillHandler = AIO.AddHandlers("RuneScapeSkillSystem", {})

local XP_TABLE = {}
local SKILL_META_CACHE = {} -- Cache for skill metadata {skill_id = {id, name, icon, max_level, description, display_order}}
local MILESTONE_CACHE = {} -- Cache for milestone data {skill_id = {level = {milestone_type, description, reward_type, reward_id, reward_amount, reward_data}}}
local PLAYER_SKILL_CACHE = {} -- Cache for player skill data (key: player_guid..skill_id)
local PENDING_PLAYER_SAVES = {} -- Cache for pending database updates [guid][skillId] = {level=L, experience=XP}

local SkillSystem = {}

-- Table to store XP sources for different skills
SkillSystem.XPSources = {}

-- Hold spell effects right now its rockets cycle through these effects
local LEVEL_UP_EFFECTS = {

    6668,
    30161,
    11540,
    11544,

}

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
    -- Instead of a fixed cap, expand XP_TABLE dynamically as needed
    setmetatable(XP_TABLE, {
        __index = function(tbl, level)
            if level < 1 then
                return 0
            end
            local xp = SkillSystem.GetTotalXPForLevel(level)
            rawset(tbl, level, xp)
            return xp
        end
    })
    -- Optionally, prefill up to a reasonable default (e.g., 100)
    --for level = 1, 100 do
    --    XP_TABLE[level] = SkillSystem.GetTotalXPForLevel(level)
    --end
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
        -- Ensure experience is never less than currentLevelXP to prevent negative display values
        currentExp = math.max(experience, currentLevelXP),
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
    local skillId
    local skillData


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
        local skillIdResult = WorldDBQuery(string.format("SELECT id FROM custom_skills_rs WHERE name = '%s'", skillName))
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

    -- Get max level from cached skill data
    local maxLevel = skillData and skillData.max_level or 99 -- Default to 99 if not found
    -- Prevent XP gain if already at max level
    if level >= maxLevel then
        return
    end

    -- Make sure that experience value is at least equal to the minimum required for the current level
    -- This ensures that when adding XP, we're starting from a valid base for the current level
    local minRequiredXP = XP_TABLE[level] or 0
    if experience < minRequiredXP then
        experience = minRequiredXP
    end

    -- Add experience
    experience = experience + amount

    -- Get max level from cached skill data
    local maxLevel = skillData and skillData.max_level or 99 -- Default to 99 if not found

    local leveledUp = false
    while level < maxLevel and experience >= XP_TABLE[level + 1] do
        level = level + 1
        player:SendBroadcastMessage(string.format("Your %s skill has increased to level %d!", skillName, level))
        if LEVEL_UP_EFFECTS and #LEVEL_UP_EFFECTS > 0 then
            local effectIndex = ((level - 1) % #LEVEL_UP_EFFECTS) + 1 -- Cycle through effects
            local effectId = LEVEL_UP_EFFECTS[effectIndex] -- Get the effect ID
            player:CastSpell(player, effectId, true) -- Cast level-up visual effect
        end
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
    if leveledUp == true then
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
                reward_type = milestoneData.reward_type,
                reward_id = milestoneData.reward_id,
                reward_amount = milestoneData.reward_amount,
                reward_data = milestoneData.reward_data,
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

    -- Use milestone cache to get reward fields
    if not MILESTONE_CACHE[skillId] then
        SkillSystem.LoadMilestoneCache()
    end
    if MILESTONE_CACHE[skillId] then
        local milestoneLevels = {}
        for milestoneLevel, _ in pairs(MILESTONE_CACHE[skillId]) do
            table.insert(milestoneLevels, milestoneLevel)
        end
        table.sort(milestoneLevels)
        for _, milestoneLevel in ipairs(milestoneLevels) do
            local milestoneData = MILESTONE_CACHE[skillId][milestoneLevel]
            table.insert(milestones, {
                level = milestoneLevel,
                milestone_type = milestoneData.milestone_type,
                description = milestoneData.description,
                unlocked = milestoneLevel <= level,
                reward_type = milestoneData.reward_type,
                reward_id = milestoneData.reward_id,
                reward_amount = milestoneData.reward_amount,
                reward_data = milestoneData.reward_data,
            })
        end
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
    for id, _ in pairs(SKILL_META_CACHE) do
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
        --    TODO: Implement custom reward handling based on rewardData format
    else
        print(string.format("Unknown reward type '%s' for skill milestone %d", rewardType, rewardId))
    end


end

-- Check if a player has the appropriate milestone rewards for their current skill level
function SkillSystem.CheckAndUpdateMilestoneRewards(player)
    local guid = player:GetGUIDLow()

    -- For each skill, check current level and verify appropriate rewards
    for skillId, skillInfo in pairs(SKILL_META_CACHE) do
        -- Get player's current level in this skill
        local level = SkillSystem.GetSkillLevel(player, skillId)

        -- Skip if level is 0 (player doesn't have the skill yet)
        if level > 0 then
            -- Make sure milestone cache is loaded
            if not MILESTONE_CACHE[skillId] and next(MILESTONE_CACHE) == nil then
                SkillSystem.LoadMilestoneCache()
            end

            -- Process milestones for this skill
            if MILESTONE_CACHE[skillId] then
                for milestoneLevel, milestone in pairs(MILESTONE_CACHE[skillId]) do
                    local rewardType = milestone.reward_type
                    local rewardId = milestone.reward_id
                    local rewardAmount = milestone.reward_amount or 1
                    local rewardData = milestone.reward_data

                    -- Check if player meets level requirement for this milestone
                    if milestoneLevel <= level then
                        -- Player qualifies for this reward

                        -- Handle different reward types
                        if rewardType == "spell" and not player:HasSpell(rewardId) then
                            -- Player is missing a spell they should have
                            player:LearnSpell(rewardId)
                            player:SendBroadcastMessage(string.format(
                                    "You've been granted a spell reward for reaching level %d in %s!",
                                    milestoneLevel, skillInfo.name
                            ))
                            print(string.format(
                                    "Giving spell %d to player %s for %s level %d milestone",
                                    rewardId, player:GetName(), skillInfo.name, milestoneLevel
                            ))
                        elseif rewardType == "item" then
                            -- Check if player should have this item
                            -- Note: This is a simplified check - you might want to improve it
                            if not player:HasItem(rewardId, rewardAmount) then
                                player:AddItem(rewardId, rewardAmount)
                                player:SendBroadcastMessage(string.format(
                                        "You've been granted an item reward for reaching level %d in %s!",
                                        milestoneLevel, skillInfo.name
                                ))
                            end
                        elseif rewardType == "currency" then
                            -- Currency rewards are typically one-time things, handled by GrantMilestoneReward
                            -- We won't attempt to check if they already received it
                        elseif rewardType == "custom" and rewardData then
                            -- Custom rewards would need specific handling based on your implementation
                        end
                    else
                        -- Player doesn't meet the level requirement

                        -- Only handle removing spells - other reward types like items shouldn't be removed
                        if rewardType == "spell" and player:HasSpell(rewardId) then
                            player:RemoveSpell(rewardId)
                            player:SendBroadcastMessage(string.format(
                                    "A spell has been removed as you no longer meet the level %d requirement in %s.",
                                    milestoneLevel, skillInfo.name
                            ))
                            print(string.format(
                                    "Removing spell %d from player %s as they don't meet %s level %d requirement (current: %d)",
                                    rewardId, player:GetName(), skillInfo.name, milestoneLevel, level
                            ))
                        end
                    end
                end
            end
        end
    end
end
function SkillSystem.CheckSkillMilestone(player, skillId, level)
    -- Get milestone data from cache
    local milestone

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

        -- Define milestone message formatters
        local milestoneMessages = {
            major = function(milestoneSkillName, milestoneLevel, description)
                return string.format(
                        "Congratulations! You've reached a major milestone in %s: Level %d. %s",
                        milestoneSkillName, milestoneLevel, description
                )
            end,
            minor = function(milestoneSkillName, milestoneLevel, description)
                return string.format(
                        "You've reached Level %d in %s. %s Keep it up!",
                        milestoneLevel, milestoneSkillName, description
                )
            end,
            -- Add more milestone types here as needed
        }

        -- Send milestone message to player
        local messageFormatter = milestoneMessages[milestone.milestone_type]
        if messageFormatter then
            player:SendBroadcastMessage(messageFormatter(skillName, level, milestone.description))
        else
            -- Default message if type is unknown
            player:SendBroadcastMessage(
                    string.format("You've reached Level %d in %s. %s", level, skillName, milestone.description)
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

-- Helper function to get a player's skill level
function SkillSystem.GetSkillLevel(player, skillId)
    local guid = player:GetGUIDLow()
    local cacheKey = guid .. "_" .. skillId

    -- Try to get from cache first
    if PLAYER_SKILL_CACHE[cacheKey] then
        return PLAYER_SKILL_CACHE[cacheKey].level
    end

    -- If not in cache, query from database
    local result = CharDBQuery(
            string.format(
                    "SELECT skill_level FROM custom_player_skills_rs WHERE player_guid = %d AND skill_id = %d",
                    guid,
                    skillId
            )
    )

    if result then
        local level = result:GetUInt32(0)
        -- Store in cache for future use
        PLAYER_SKILL_CACHE[cacheKey] = PLAYER_SKILL_CACHE[cacheKey] or {}
        PLAYER_SKILL_CACHE[cacheKey].level = level
        return level
    end

    -- If not found in database, player doesn't have this skill yet
    return 0
end

local function OnPlayerLogin(_, player)
    LoadPlayerSkillsToCache(player)
    SkillSystem.SendSkillDataToClient(player)

    -- Check milestone rewards on login - ensure player has all appropriate spell rewards
    SkillSystem.CheckAndUpdateMilestoneRewards(player)
    print("Checked milestone rewards for " .. player:GetName() .. " on login")
end
local PLAYER_EVENT_ON_LOGIN = 3 --  this is the correct event ID for player login
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnPlayerLogin)

-- Clean up player cache on logout to prevent memory bloat
local function OnPlayerLogout(_, player)
    local guid = player:GetGUIDLow()

    -- *** Save any pending updates for this player before clearing cache ***
    SkillSystem.SavePlayerUpdates(player)

    -- Check milestone rewards on logout - ensure rewards are properly synchronized
    SkillSystem.CheckAndUpdateMilestoneRewards(player)
    print("Checked milestone rewards for " .. player:GetName() .. " on logout")

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
    if #PLAYER_SKILL_CACHE > 1000 then
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

function SkillSystem.DebugForceSave(_, player, message, _, _)
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

local function OnLuaStateOpen(_)
    -- Reload caches when Lua state opens to ensure data consistency
    SkillSystem.ReloadCaches()

    -- Get all players in the world
    local players = GetPlayersInWorld() -- Renamed 'player' to 'players' to avoid confusion in the loop
    for _, p in ipairs(players) do
        -- Check if the player is in the world
        if p:IsInWorld() then
            -- Save current user's data before fetching new data
            print("Lua state opened: Reloading skill data for player " .. p:GetName())
            LoadPlayerSkillsToCache(p) -- Load this player's skills from DB into PLAYER_SKILL_CACHE
            SkillSystem.SendSkillDataToClient(p) -- Send skills to the player
        end
    end
end

RegisterServerEvent(33, OnLuaStateOpen)

-- Function to handle the update XP command
function SkillSystem.HandleUpdateXPCommand(_, player, message, _, _)
    -- Only handle the command, let all other chat through
    if not message:lower():match("^#addrsxp") then
        return
    end

    -- Parse command arguments, accounting for the leading #
    local skillName, amount = message:match("^#addrsxp%s+(.+)%s+(%d+)%s*$")
    if not skillName or not amount then
        player:SendBroadcastMessage("Usage: #addrsxp <skill_name> <amount>")
        return false
    end
    -- Trim any extra whitespace from skill name
    skillName = skillName:match("^%s*(.-)%s*$")
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
    return false -- Only block the command, not all chat
end

-- Register the command handler for player chat (event 18)
RegisterPlayerEvent(18, SkillSystem.HandleUpdateXPCommand)

-- Constants for event types
local EVENT_TYPES = {
    PLAYER = "player",
    CREATURE = "creature",
    ITEM = "item",
}

-- Table to track active spell casts
local ACTIVE_SPELL_CASTS = {}

-- Function to register an XP source
function SkillSystem.RegisterXPSource(skillName, eventType, eventId, sourceId, xpAmount, condition, message, isPercentage)
    -- Initialize the skill's XP sources if not already done
    SkillSystem.XPSources[skillName] = SkillSystem.XPSources[skillName] or {}

    -- Create a unique key for this XP source
    local sourceKey = eventType .. "_" .. eventId .. "_" .. (sourceId or "all")

    -- Store the XP source information
    SkillSystem.XPSources[skillName][sourceKey] = {
        eventType = eventType,
        eventId = eventId,
        sourceId = sourceId,
        xpAmount = xpAmount,
        condition = condition,
        message = message or "You gained %d %s XP!",
        isPercentage = isPercentage or false
    }

    -- Register the appropriate event handler if not already registered
    if eventType == EVENT_TYPES.PLAYER then
        -- Check if we already have a handler for this player event
        if not SkillSystem["_playerEvent_" .. eventId .. "_registered"] then
            RegisterPlayerEvent(eventId, function(event, player, ...)
                SkillSystem.HandlePlayerEvent(event, player, eventId, ...)
                print(string.format("XP source registered for player event %d: %s", eventId, skillName))
            end)
            SkillSystem["_playerEvent_" .. eventId .. "_registered"] = true
        end
    elseif eventType == EVENT_TYPES.CREATURE then
        -- For creature events, we need to register for each specific creature
        if sourceId then
            RegisterCreatureEvent(sourceId, eventId, function(event, creature, ...)
                SkillSystem.HandleCreatureEvent(event, creature, eventId, sourceId, ...)
            end)
        end
    elseif eventType == EVENT_TYPES.ITEM then
        -- For item events, we need to register for each specific item
        if sourceId then
            RegisterItemEvent(sourceId, eventId, function(event, player, item, target, ...)
                SkillSystem.HandleItemEvent(event, player, item, eventId, sourceId, target, ...)
            end)
        end

    else
        print(string.format("SkillSystem.RegisterXPSource: Unknown event type '%s' for skill '%s'", eventType, skillName))
        return false
    end

    local xpType = isPercentage and "%" or ""
    print(string.format("Registered XP source for %s: %s event %d, source %s, XP %d%s",
            skillName, eventType, eventId, sourceId or "all", xpAmount, xpType))
end

-- Helper function to calculate XP amount based on XP required for next level if it's a percentage
function SkillSystem.CalculateXPAmount(player, skillName, xpAmount, isPercentage)
    if not isPercentage then
        return xpAmount -- Return fixed amount if not percentage-based
    end

    -- Find skill ID from cache by name
    local skillId

    -- Ensure cache is loaded
    if next(SKILL_META_CACHE) == nil then
        SkillSystem.LoadSkillMetaCache()
    end

    -- Look up skill by name using cache
    for id, data in pairs(SKILL_META_CACHE) do
        if data.name == skillName then
            skillId = id
            break
        end
    end

    if not skillId then
        -- Fallback to database lookup if not in cache
        local skillIdResult = WorldDBQuery(string.format("SELECT id FROM custom_skills_rs WHERE name = '%s'", skillName))
        if not skillIdResult then
            print(string.format("SkillSystem.CalculateXPAmount: Skill '%s' not found in custom_skills_rs.", skillName))
            return xpAmount -- Return fixed amount as fallback
        end
        skillId = skillIdResult:GetUInt32(0)
    end

    -- Get player's current level for this skill
    local guid = player:GetGUIDLow()
    local cacheKey = guid .. "_" .. skillId
    local level = 1

    if PLAYER_SKILL_CACHE[cacheKey] then
        level = PLAYER_SKILL_CACHE[cacheKey].level
    else
        -- Query from database only if cache is empty
        local result = CharDBQuery(
                string.format(
                        "SELECT skill_level FROM custom_player_skills_rs WHERE player_guid = %d AND skill_id = %d",
                        guid,
                        skillId
                )
        )

        if result then
            level = result:GetUInt32(0)
        end
    end

    -- Get max level from cache
    local maxLevel = 99
    if SKILL_META_CACHE[skillId] then
        maxLevel = SKILL_META_CACHE[skillId].max_level
    end

    -- If player is at max level, return a fixed amount
    if level >= maxLevel then
        return math.max(1, math.floor(xpAmount))
    end

    -- Calculate XP required for next level
    local currentLevelXP = XP_TABLE[level] or 0
    local nextLevelXP = XP_TABLE[level + 1] or (currentLevelXP + 1000)
    local xpForNextLevel = nextLevelXP - currentLevelXP

    -- Calculate XP amount as a percentage of the XP required for next level
    local calculatedXP = math.floor(xpForNextLevel * (xpAmount / 100))

    -- Ensure minimum XP of 1
    return math.max(1, calculatedXP)
end

-- Handler for player events
function SkillSystem.HandlePlayerEvent(event, player, eventId, ...)
    -- Check all skills for XP sources matching this event
    for skillName, sources in pairs(SkillSystem.XPSources) do
        -- Check for sources that match this event type and ID
        for sourceKey, source in pairs(sources) do
            if source.eventType == EVENT_TYPES.PLAYER and source.eventId == eventId then
                -- Check if there's a specific source ID to match
                local args = { ... }
                local sourceMatches = true

                -- If there's a source ID, check if it matches
                if source.sourceId then
                    sourceMatches = false
                    -- For spell cast events, check the spell ID
                    if eventId == 5 then
                        -- PLAYER_EVENT_ON_SPELL_CAST
                        local spell = args[1]
                        if spell and spell:GetEntry() == source.sourceId then
                            sourceMatches = true
                        end
                    end
                    -- Add more event-specific source ID checks here
                end

                -- If the source matches and the condition is met (if any), award XP
                if sourceMatches and (not source.condition or source.condition(player, ...)) then
                    -- Calculate XP amount based on whether it's percentage-based
                    local actualXP = SkillSystem.CalculateXPAmount(player, skillName, source.xpAmount, source.isPercentage)

                    SkillSystem.AddExperience(player, skillName, actualXP)
                    if source.message then
                        player:SendBroadcastMessage(string.format(source.message, actualXP, skillName))
                    end
                end
            end
        end
    end

    return true -- Continue event processing
end

-- Handler for creature events
function SkillSystem.HandleCreatureEvent(event, creature, eventId, creatureId, ...)
    -- Get the player involved in this event (if any)
    local player = nil

    -- For different creature events, get the player in different ways
    if eventId == 3 then
        -- CREATURE_EVENT_ON_KILLED
        player = select(1, ...)
    end

    -- If we couldn't find a player, return
    if not player or not player:IsPlayer() then
        return true
    end

    -- Check all skills for XP sources matching this event
    for skillName, sources in pairs(SkillSystem.XPSources) do
        -- Check for sources that match this event type, ID, and creature ID
        for sourceKey, source in pairs(sources) do
            if source.eventType == EVENT_TYPES.CREATURE and
                    source.eventId == eventId and
                    source.sourceId == creatureId then

                -- If the condition is met (if any), award XP
                if not source.condition or source.condition(player, creature, ...) then
                    -- Calculate XP amount based on whether it's percentage-based
                    local actualXP = SkillSystem.CalculateXPAmount(player, skillName, source.xpAmount, source.isPercentage)

                    SkillSystem.AddExperience(player, skillName, actualXP)
                    if source.message then
                        player:SendBroadcastMessage(string.format(source.message, actualXP, skillName))
                    end
                end
            end
        end
    end

    return true -- Continue event processing
end

-- Handler for item events
function SkillSystem.HandleItemEvent(event, player, item, eventId, itemId, target, ...)
    -- Check all skills for XP sources matching this event
    for skillName, sources in pairs(SkillSystem.XPSources) do
        -- Check for sources that match this event type, ID, and item ID
        for sourceKey, source in pairs(sources) do
            if source.eventType == EVENT_TYPES.ITEM and
                    source.eventId == eventId and
                    source.sourceId == itemId then

                -- If the condition is met (if any), award XP
                if not source.condition or source.condition(player, item, target, ...) then
                    -- Calculate XP amount based on whether it's percentage-based
                    local actualXP = SkillSystem.CalculateXPAmount(player, skillName, source.xpAmount, source.isPercentage)

                    SkillSystem.AddExperience(player, skillName, actualXP)
                    if source.message then
                        player:SendBroadcastMessage(string.format(source.message, actualXP, skillName))
                    end
                end
            end
        end
    end

    return true -- Continue event processing
end

-- Register XP sources for skills
function SkillSystem.RegisterDefaultXPSources()
    -- Mining XP from mining spell (fixed amount)
    SkillSystem.RegisterXPSource(
            "Mining", -- Skill name
            EVENT_TYPES.PLAYER, -- Event type
            5, -- Event ID (PLAYER_EVENT_ON_SPELL_CAST)
            50310, -- Source ID (spell ID)
            25, -- XP amount
            nil, -- Condition function (nil = always award XP)
            "You gained %d %s XP from mining!", -- Message
            false                          -- Not percentage-based (fixed amount)
    )

    -- Mining XP from mining spell (percentage-based - 2% of XP needed for next level)
    -- This will award 2% of the XP required to reach the next Mining level
    -- For example, if 5000 XP is needed to reach the next level, they will get 100 XP
    SkillSystem.RegisterXPSource(
            "Mining", -- Skill name
            EVENT_TYPES.PLAYER, -- Event type
            5, -- Event ID (PLAYER_EVENT_ON_SPELL_CAST)
            50310, -- Source ID (spell ID)
            2, -- XP percentage (2%)
            nil, -- Condition function (nil = always award XP)
            "You gained %d %s XP (2%% of XP needed for next level) from mining!", -- Message
            true                           -- Percentage-based
    )

    -- Add more default XP sources here
    -- These are examples that can be uncommented and modified as needed

    -- GATHERING SKILLS

    -- Herbalism: XP from gathering herbs (fixed amount)
    -- Note: Replace 12345 with actual herb item IDs
    -- SkillSystem.RegisterXPSource(
    --     "Herbalism",
    --     EVENT_TYPES.ITEM,
    --     2,                          -- ITEM_EVENT_ON_USE
    --     12345,                      -- Example herb item ID
    --     15,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from gathering herbs!"
    -- )

    -- Herbalism: XP from gathering herbs (percentage-based - 1.5% of XP needed for next level)
    -- Note: Replace 12345 with actual herb item IDs
    -- SkillSystem.RegisterXPSource(
    --     "Herbalism",
    --     EVENT_TYPES.ITEM,
    --     2,                          -- ITEM_EVENT_ON_USE
    --     118,                      -- Example herb item ID
    --     1.5,                        -- XP percentage (1.5%)
    --     nil,
    --     "You gained %d %s XP (1.5%% of XP needed for next level) from gathering herbs!",
    --     true                        -- Percentage-based
    -- )

    -- Skinning: XP from skinning creatures (fixed amount)
    -- Note: Replace 12345 with actual creature IDs that can be skinned
    -- SkillSystem.RegisterXPSource(
    --     "Skinning",
    --     EVENT_TYPES.CREATURE,
    --     3,                          -- CREATURE_EVENT_ON_KILLED
    --     12345,                      -- Example creature ID
    --     20,                         -- XP amount
    --     function(player, creature)  -- Condition: only if player has skinning skill
    --         return player:HasSkill(393) -- 393 is the skinning skill ID in WoW
    --     end,
    --     "You gained %d %s XP from skinning!"
    -- )

    -- Skinning: XP from skinning creatures (percentage-based - 3% of XP needed for next level)
    -- Note: Replace 12345 with actual creature IDs that can be skinned
    -- SkillSystem.RegisterXPSource(
    --     "Skinning",
    --     EVENT_TYPES.CREATURE,
    --     3,                          -- CREATURE_EVENT_ON_KILLED
    --     12345,                      -- Example creature ID
    --     3,                          -- XP percentage (3%)
    --     function(player, creature)  -- Condition: only if player has skinning skill
    --         return player:HasSkill(393) -- 393 is the skinning skill ID in WoW
    --     end,
    --     "You gained %d %s XP (3%% of XP needed for next level) from skinning!",
    --     true                        -- Percentage-based
    -- )

    -- Fishing: XP from fishing spell (fixed amount)
    -- Note: Replace 7620 with actual fishing spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Fishing",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     7620,                       -- Fishing spell ID
    --     10,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from fishing!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Fishing: XP from fishing spell (percentage-based - 5% of XP needed for next level)
    -- Note: Replace 7620 with actual fishing spell ID
    --SkillSystem.RegisterXPSource(
    --        "Fishing",
    --        EVENT_TYPES.PLAYER,
    --        5, -- PLAYER_EVENT_ON_SPELL_CAST
    --        7620, -- Fishing spell ID
    --        5, -- XP percentage (5%)
    --        nil,
    --        "You gained %d %s XP (5%% of XP needed for next level) from fishing!",
    --        true                        -- Percentage-based
    --)

    -- Fishing XP when finishing a fishing spell cast (percentage-based - 1.5% of XP needed for next level)

    SkillSystem.RegisterXPSource(
            "Fishing", -- Skill name
            EVENT_TYPES.PLAYER, -- Event type
            5, -- Event ID (PLAYER_EVENT_ON_SPELL_CAST)
            7620, -- Source ID (spell ID)
            50, -- XP percentage (1.5%)
            function(player, spell)
                local guid = player:GetGUIDLow()
                local spellId = spell:GetEntry()
                local delayMs = 5000 -- 5 seconds, adjust as needed

                -- Prevent duplicate timers for the same spell cast
                if not ACTIVE_SPELL_CASTS[guid] then
                    ACTIVE_SPELL_CASTS[guid] = {}
                end
                if ACTIVE_SPELL_CASTS[guid][spellId] then
                    return false
                end
                ACTIVE_SPELL_CASTS[guid][spellId] = true

                -- Delay XP award until after the channel
                CreateLuaEvent(function()
                    -- Award XP only if player is still online
                    if player and player:IsInWorld() then
                        local skillName = "Fishing"
                        local actualXP = SkillSystem.CalculateXPAmount(player, skillName, 50, true)
                        SkillSystem.AddExperience(player, skillName, actualXP)
                        player:SendBroadcastMessage(string.format("You gained %d %s XP (delayed) after fishing!", actualXP, skillName))
                    end
                    ACTIVE_SPELL_CASTS[guid][spellId] = nil
                end, delayMs, 1)

                return false -- Do not award XP instantly
            end,
            "You gained %d %s XP (1.5%% of XP needed for next level) when you finished fishing!", -- Message
            true                           -- Percentage-based
    )

    -- CRAFTING SKILLS

    -- Alchemy: XP from creating potions (fixed amount)
    -- Note: Replace 2259 with actual alchemy spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Alchemy",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2259,                       -- Alchemy spell ID
    --     30,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from brewing potions!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Alchemy: XP from creating potions (percentage-based - 2.5% of XP needed for next level)
    -- Note: Replace 2259 with actual alchemy spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Alchemy",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2259,                       -- Alchemy spell ID
    --     2.5,                        -- XP percentage (2.5%)
    --     nil,
    --     "You gained %d %s XP (2.5%% of XP needed for next level) from brewing potions!",
    --     true                        -- Percentage-based
    -- )

    -- Blacksmithing: XP from crafting items (fixed amount)
    -- Note: Replace 2018 with actual blacksmithing spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Blacksmith",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2018,                       -- Blacksmithing spell ID
    --     35,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from smithing!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Blacksmithing: XP from crafting items (percentage-based - 3% of XP needed for next level)
    -- Note: Replace 2018 with actual blacksmithing spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Blacksmith",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2018,                       -- Blacksmithing spell ID
    --     3,                          -- XP percentage (3%)
    --     nil,
    --     "You gained %d %s XP (3%% of XP needed for next level) from smithing!",
    --     true                        -- Percentage-based
    -- )

    -- Enchanting: XP from enchanting items (fixed amount)
    -- Note: Replace 7411 with actual enchanting spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Enchanting",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     7411,                       -- Enchanting spell ID
    --     40,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from enchanting!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Enchanting: XP from enchanting items (percentage-based - 4% of XP needed for next level)
    -- Note: Replace 7411 with actual enchanting spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Enchanting",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     7411,                       -- Enchanting spell ID
    --     4,                          -- XP percentage (4%)
    --     nil,
    --     "You gained %d %s XP (4%% of XP needed for next level) from enchanting!",
    --     true                        -- Percentage-based
    -- )

    -- Engineering: XP from crafting gadgets (fixed amount)
    -- Note: Replace 4036 with actual engineering spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Engineering",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     4036,                       -- Engineering spell ID
    --     35,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from engineering!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Engineering: XP from crafting gadgets (percentage-based - 3.5% of XP needed for next level)
    -- Note: Replace 4036 with actual engineering spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Engineering",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     4036,                       -- Engineering spell ID
    --     3.5,                        -- XP percentage (3.5%)
    --     nil,
    --     "You gained %d %s XP (3.5%% of XP needed for next level) from engineering!",
    --     true                        -- Percentage-based
    -- )

    -- Inscription: XP from creating glyphs (fixed amount)
    -- Note: Replace 45357 with actual inscription spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Inscription",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     45357,                      -- Inscription spell ID
    --     30,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from inscription!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Inscription: XP from creating glyphs (percentage-based - 2.5% of XP needed for next level)
    -- Note: Replace 45357 with actual inscription spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Inscription",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     45357,                      -- Inscription spell ID
    --     2.5,                        -- XP percentage (2.5%)
    --     nil,
    --     "You gained %d %s XP (2.5%% of XP needed for next level) from inscription!",
    --     true                        -- Percentage-based
    -- )

    -- Jewelcrafting: XP from cutting gems (fixed amount)
    -- Note: Replace 25229 with actual jewelcrafting spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Jewelcrafting",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     25229,                      -- Jewelcrafting spell ID
    --     35,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from jewelcrafting!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Jewelcrafting: XP from cutting gems (percentage-based - 3% of XP needed for next level)
    -- Note: Replace 25229 with actual jewelcrafting spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Jewelcrafting",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     25229,                      -- Jewelcrafting spell ID
    --     3,                          -- XP percentage (3%)
    --     nil,
    --     "You gained %d %s XP (3%% of XP needed for next level) from jewelcrafting!",
    --     true                        -- Percentage-based
    -- )

    -- Leatherworking: XP from crafting leather items (fixed amount)
    -- Note: Replace 2108 with actual leatherworking spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Leatherworking",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2108,                       -- Leatherworking spell ID
    --     35,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from leatherworking!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Leatherworking: XP from crafting leather items (percentage-based - 3% of XP needed for next level)
    -- Note: Replace 2108 with actual leatherworking spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Leatherworking",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2108,                       -- Leatherworking spell ID
    --     3,                          -- XP percentage (3%)
    --     nil,
    --     "You gained %d %s XP (3%% of XP needed for next level) from leatherworking!",
    --     true                        -- Percentage-based
    -- )

    -- Tailoring: XP from crafting cloth items (fixed amount)
    -- Note: Replace 3908 with actual tailoring spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Tailoring",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     3908,                       -- Tailoring spell ID
    --     35,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from tailoring!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Tailoring: XP from crafting cloth items (percentage-based - 3% of XP needed for next level)
    -- Note: Replace 3908 with actual tailoring spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Tailoring",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     3908,                       -- Tailoring spell ID
    --     3,                          -- XP percentage (3%)
    --     nil,
    --     "You gained %d %s XP (3%% of XP needed for next level) from tailoring!",
    --     true                        -- Percentage-based
    -- )

    -- Cooking: XP from cooking food (fixed amount)
    -- Note: Replace 2550 with actual cooking spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Cooking",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2550,                       -- Cooking spell ID
    --     20,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from cooking!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Cooking: XP from cooking food (percentage-based - 2% of XP needed for next level)
    -- Note: Replace 2550 with actual cooking spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Cooking",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     2550,                       -- Cooking spell ID
    --     2,                          -- XP percentage (2%)
    --     nil,
    --     "You gained %d %s XP (2%% of XP needed for next level) from cooking!",
    --     true                        -- Percentage-based
    -- )

    -- First Aid: XP from creating bandages (fixed amount)
    -- Note: Replace 3273 with actual first aid spell ID
    -- SkillSystem.RegisterXPSource(
    --     "First Aid",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     3273,                       -- First Aid spell ID
    --     20,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from first aid!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- First Aid: XP from creating bandages (percentage-based - 2% of XP needed for next level)
    -- Note: Replace 3273 with actual first aid spell ID
    -- SkillSystem.RegisterXPSource(
    --     "First Aid",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     3273,                       -- First Aid spell ID
    --     2,                          -- XP percentage (2%)
    --     nil,
    --     "You gained %d %s XP (2%% of XP needed for next level) from first aid!",
    --     true                        -- Percentage-based
    -- )

    -- Archaeology: XP from surveying (fixed amount)
    -- Note: Replace 80451 with actual archaeology survey spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Archaeology",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     80451,                      -- Archaeology survey spell ID
    --     25,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from archaeology!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- Archaeology: XP from surveying (percentage-based - 2.5% of XP needed for next level)
    -- Note: Replace 80451 with actual archaeology survey spell ID
    -- SkillSystem.RegisterXPSource(
    --     "Archaeology",
    --     EVENT_TYPES.PLAYER,
    --     5,                          -- PLAYER_EVENT_ON_SPELL_CAST
    --     80451,                      -- Archaeology survey spell ID
    --     2.5,                        -- XP percentage (2.5%)
    --     nil,
    --     "You gained %d %s XP (2.5%% of XP needed for next level) from archaeology!",
    --     true                        -- Percentage-based
    -- )

    -- ALTERNATIVE XP SOURCES

    -- XP from completing quests (fixed amount)
    -- SkillSystem.RegisterXPSource(
    --     "Mining",                   -- Can be any skill
    --     EVENT_TYPES.PLAYER,
    --     9,                          -- PLAYER_EVENT_ON_QUEST_COMPLETE
    --     12345,                      -- Quest ID
    --     100,                        -- XP amount
    --     nil,
    --     "You gained %d %s XP from completing the quest!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- XP from completing quests (percentage-based - 5% of XP needed for next level)
    -- SkillSystem.RegisterXPSource(
    --     "Mining",                   -- Can be any skill
    --     EVENT_TYPES.PLAYER,
    --     9,                          -- PLAYER_EVENT_ON_QUEST_COMPLETE
    --     12345,                      -- Quest ID
    --     5,                          -- XP percentage (5%)
    --     nil,
    --     "You gained %d %s XP (5%% of XP needed for next level) from completing the quest!",
    --     true                        -- Percentage-based
    -- )

    -- XP from killing specific creatures (fixed amount)
    -- SkillSystem.RegisterXPSource(
    --     "Combat",                   -- Example combat skill
    --     EVENT_TYPES.CREATURE,
    --     3,                          -- CREATURE_EVENT_ON_KILLED
    --     12345,                      -- Creature ID
    --     50,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from defeating the enemy!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- XP from killing specific creatures (percentage-based - 4% of XP needed for next level)
    -- SkillSystem.RegisterXPSource(
    --     "Combat",                   -- Example combat skill
    --     EVENT_TYPES.CREATURE,
    --     3,                          -- CREATURE_EVENT_ON_KILLED
    --     12345,                      -- Creature ID
    --     4,                          -- XP percentage (4%)
    --     nil,
    --     "You gained %d %s XP (4%% of XP needed for next level) from defeating the enemy!",
    --     true                        -- Percentage-based
    -- )

    -- XP from using specific items (fixed amount)
    -- SkillSystem.RegisterXPSource(
    --     "Alchemy",
    --     EVENT_TYPES.ITEM,
    --     2,                          -- ITEM_EVENT_ON_USE
    --     12345,                      -- Item ID
    --     30,                         -- XP amount
    --     nil,
    --     "You gained %d %s XP from using the item!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- XP from using specific items (percentage-based - 3% of XP needed for next level)
    -- SkillSystem.RegisterXPSource(
    --     "Alchemy",
    --     EVENT_TYPES.ITEM,
    --     2,                          -- ITEM_EVENT_ON_USE
    --     12345,                      -- Item ID
    --     3,                          -- XP percentage (3%)
    --     nil,
    --     "You gained %d %s XP (3%% of XP needed for next level) from using the item!",
    --     true                        -- Percentage-based
    -- )

    -- XP from entering specific areas (zones) (fixed amount)
    -- SkillSystem.RegisterXPSource(
    --     "Exploration",              -- Example exploration skill
    --     EVENT_TYPES.PLAYER,
    --     27,                         -- PLAYER_EVENT_ON_UPDATE_ZONE
    --     12345,                      -- Zone ID
    --     75,                         -- XP amount
    --     function(player, zoneId)    -- Only award XP once per zone
    --         local key = player:GetGUIDLow() .. "_zone_" .. zoneId
    --         if not player:GetData(key) then
    --             player:SetData(key, true)
    --             return true
    --         end
    --         return false
    --     end,
    --     "You gained %d %s XP from discovering a new area!",
    --     false                       -- Not percentage-based (fixed amount)
    -- )

    -- XP from entering specific areas (zones) (percentage-based - 10% of XP needed for next level)
    -- SkillSystem.RegisterXPSource(
    --     "Exploration",              -- Example exploration skill
    --     EVENT_TYPES.PLAYER,
    --     27,                         -- PLAYER_EVENT_ON_UPDATE_ZONE
    --     12345,                      -- Zone ID
    --     10,                         -- XP percentage (10%)
    --     function(player, zoneId)    -- Only award XP once per zone
    --         local key = player:GetGUIDLow() .. "_zone_" .. zoneId
    --         if not player:GetData(key) then
    --             player:SetData(key, true)
    --             return true
    --         end
    --         return false
    --     end,
    --     "You gained %d %s XP (10%% of XP needed for next level) from discovering a new area!",
    --     true                        -- Percentage-based
    -- )
end

-- Initialize default XP sources
SkillSystem.RegisterDefaultXPSources()
