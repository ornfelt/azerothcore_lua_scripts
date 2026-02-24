--[[
    Battle Pass System - Database Module
    BP_Database.lua

    Database operations for the Battle Pass system.
    Handles loading, saving, and updating player data.
]]

-- Namespace
BattlePass = BattlePass or {}
BattlePass.DB = BattlePass.DB or {}

-- Creates an empty player data structure
local function CreateEmptyPlayerData()
    return {
        guid = 0,
        current_level = 0,
        current_exp = 0,
        total_exp = 0,
        claimed_levels = "",
        last_daily_login = nil,
        dirty = false
    }
end

-- Read Operations

-- Loads player data from the database
function BattlePass.DB.LoadPlayerProgress(guid)
    local query = CharDBQuery(string.format([[
        SELECT current_level, current_exp, total_exp, claimed_levels, last_daily_login
        FROM character_battlepass
        WHERE guid = %d
    ]], guid))

    if not query then
        return nil
    end

    local data = CreateEmptyPlayerData()
    data.guid = guid
    data.current_level = query:GetUInt32(0)
    data.current_exp = query:GetUInt32(1)
    data.total_exp = query:GetUInt32(2)
    data.claimed_levels = query:GetString(3) or ""
    data.last_daily_login = query:GetString(4)
    data.dirty = false

    BattlePass.Debug("Loaded player data for GUID " .. guid ..
        " (Level: " .. data.current_level ..
        ", XP: " .. data.current_exp .. ")")

    return data
end

-- Creates a new player entry
function BattlePass.DB.CreatePlayerEntry(guid)
    CharDBExecute(string.format([[
        INSERT INTO character_battlepass (guid, current_level, current_exp, total_exp, claimed_levels)
        VALUES (%d, 0, 0, 0, '')
        ON DUPLICATE KEY UPDATE guid = guid
    ]], guid))

    local data = CreateEmptyPlayerData()
    data.guid = guid
    data.dirty = false

    BattlePass.Debug("Created new player entry for GUID " .. guid)
    return data
end

-- Retrieves or creates player data
function BattlePass.DB.GetOrCreatePlayerData(player)
    local guid = player:GetGUIDLow()

    -- Check cache first
    if BattlePass.PlayerCache[guid] then
        return BattlePass.PlayerCache[guid]
    end

    -- Load from DB
    local data = BattlePass.DB.LoadPlayerProgress(guid)

    -- Create if doesn't exist
    if not data then
        data = BattlePass.DB.CreatePlayerEntry(guid)
    end

    -- Cache the data
    BattlePass.PlayerCache[guid] = data
    return data
end

-- Write Operations

-- Saves player data to the database
function BattlePass.DB.SavePlayerProgress(guid, data)
    if not data then
        BattlePass.Error("Cannot save nil data for GUID " .. guid)
        return
    end

    local claimedLevels = data.claimed_levels or ""

    CharDBExecute(string.format([[
        UPDATE character_battlepass
        SET current_level = %d,
            current_exp = %d,
            total_exp = %d,
            claimed_levels = '%s'
        WHERE guid = %d
    ]], data.current_level, data.current_exp, data.total_exp, claimedLevels, guid))

    data.dirty = false
    BattlePass.Debug("Saved player data for GUID " .. guid)
end

-- Saves player data if modified
function BattlePass.DB.SaveIfDirty(player)
    local guid = player:GetGUIDLow()
    local data = BattlePass.PlayerCache[guid]

    if data and data.dirty then
        BattlePass.DB.SavePlayerProgress(guid, data)
    end
end

-- Saves all cached data (for shutdown)
function BattlePass.DB.SaveAllCached()
    local count = 0
    for guid, data in pairs(BattlePass.PlayerCache) do
        if data.dirty then
            BattlePass.DB.SavePlayerProgress(guid, data)
            count = count + 1
        end
    end
    if count > 0 then
        BattlePass.Info("Saved " .. count .. " dirty player records")
    end
end

-- Update Operations

-- Marks a level as claimed
function BattlePass.DB.MarkLevelClaimed(guid, level)
    local data = BattlePass.PlayerCache[guid]
    if not data then
        BattlePass.Error("No cached data for GUID " .. guid)
        return
    end

    if BattlePass.IsInCSV(data.claimed_levels, level) then
        BattlePass.Debug("Level " .. level .. " already claimed for GUID " .. guid)
        return
    end

    data.claimed_levels = BattlePass.AddToCSV(data.claimed_levels, level)
    data.dirty = true

    BattlePass.Debug("Marked level " .. level .. " as claimed for GUID " .. guid)

    -- Save to database immediately
    BattlePass.DB.SavePlayerProgress(guid, data)
end

-- Removes a level from the claimed list (admin command)
function BattlePass.DB.UnmarkLevelClaimed(guid, level)
    local data = BattlePass.PlayerCache[guid]
    if not data then
        BattlePass.Error("No cached data for GUID " .. guid)
        return false
    end

    if not BattlePass.IsInCSV(data.claimed_levels, level) then
        BattlePass.Debug("Level " .. level .. " not claimed for GUID " .. guid)
        return false
    end

    data.claimed_levels = BattlePass.RemoveFromCSV(data.claimed_levels, level)
    data.dirty = true

    BattlePass.Debug("Unmarked level " .. level .. " for GUID " .. guid)

    -- Save to database immediately
    BattlePass.DB.SavePlayerProgress(guid, data)
    return true
end

-- Checks if a level has been claimed
function BattlePass.DB.IsLevelClaimed(guid, level)
    local data = BattlePass.PlayerCache[guid]
    if not data then
        return false
    end
    return BattlePass.IsInCSV(data.claimed_levels, level)
end

-- Updates the last daily login date
function BattlePass.DB.UpdateDailyLogin(guid)
    CharDBExecute(string.format([[
        UPDATE character_battlepass
        SET last_daily_login = CURDATE()
        WHERE guid = %d
    ]], guid))

    local data = BattlePass.PlayerCache[guid]
    if data then
        data.last_daily_login = os.date("%Y-%m-%d")
    end

    BattlePass.Debug("Updated daily login for GUID " .. guid)
end

-- Checks if daily login bonus is available
function BattlePass.DB.IsDailyLoginAvailable(guid)
    local data = BattlePass.PlayerCache[guid]
    if not data then
        return true
    end

    if not data.last_daily_login or data.last_daily_login == "" then
        return true
    end

    local today = os.date("%Y-%m-%d")
    return data.last_daily_login ~= today
end

-- Administrative Operations

-- Resets player data
function BattlePass.DB.ResetPlayer(guid)
    CharDBExecute(string.format([[
        UPDATE character_battlepass
        SET current_level = 0,
            current_exp = 0,
            total_exp = 0,
            claimed_levels = '',
            last_daily_login = NULL
        WHERE guid = %d
    ]], guid))

    local data = BattlePass.PlayerCache[guid]
    if data then
        data.current_level = 0
        data.current_exp = 0
        data.total_exp = 0
        data.claimed_levels = ""
        data.last_daily_login = nil
        data.dirty = false
    end

    BattlePass.Info("Reset Battle Pass data for GUID " .. guid)
end

-- Sets player level (admin)
function BattlePass.DB.SetPlayerLevel(guid, level)
    local maxLevel = BattlePass.GetConfigNumber("max_level", 100)
    level = math.max(0, math.min(level, maxLevel))

    CharDBExecute(string.format([[
        UPDATE character_battlepass
        SET current_level = %d,
            current_exp = 0
        WHERE guid = %d
    ]], level, guid))

    local data = BattlePass.PlayerCache[guid]
    if data then
        data.current_level = level
        data.current_exp = 0
        data.dirty = false
    end

    BattlePass.Info("Set Battle Pass level to " .. level .. " for GUID " .. guid)
end

-- Adds XP to a player (admin, without triggering automatic level-ups)
function BattlePass.DB.AddPlayerExp(guid, amount)
    local data = BattlePass.PlayerCache[guid]
    if not data then
        BattlePass.Error("No cached data for GUID " .. guid)
        return
    end

    data.current_exp = data.current_exp + amount
    data.total_exp = data.total_exp + amount
    data.dirty = true

    BattlePass.Debug("Added " .. amount .. " XP to GUID " .. guid ..
        " (Total: " .. data.current_exp .. ")")
end

-- Cache Cleanup

-- Removes player data from cache
function BattlePass.DB.ClearFromCache(guid)
    BattlePass.PlayerCache[guid] = nil
    BattlePass.Debug("Cleared cache for GUID " .. guid)
end

-- Clears all cache (for reload)
function BattlePass.DB.ClearAllCache()
    BattlePass.DB.SaveAllCached()
    BattlePass.PlayerCache = {}
    BattlePass.Info("Cleared all player cache")
end
