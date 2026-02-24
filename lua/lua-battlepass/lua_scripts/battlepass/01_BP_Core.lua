--[[
    Battle Pass System - Core Module
    01_BP_Core.lua

    System initialization and global configuration management.
    This module must be loaded first as it defines the global namespace.
]]

-- ============================================================================
-- Global Namespace
-- ============================================================================

BattlePass = BattlePass or {}

BattlePass.VERSION = "1.0.0"
BattlePass.Config = {}              -- Configuration cache (from battlepass_config)
BattlePass.PlayerCache = {}         -- Player data cache (guid -> data)
BattlePass.LevelCache = {}          -- Level cache (level -> reward_data)
BattlePass.SourceCache = {}         -- Progress source cache (source_type -> config)
BattlePass.RewardTypeCache = {}     -- Reward type cache (type_id -> handler_info)
BattlePass.TablesExist = false      -- Flag indicating if DB tables exist

-- ============================================================================
-- Default Configuration
-- ============================================================================

local DEFAULT_CONFIG = {
    enabled = "0",
    max_level = "100",
    exp_per_level = "1000",
    exp_scaling = "1.1",
    npc_entry = "90100",
    debug_mode = "1"
}

-- ============================================================================
-- Utility Functions
-- ============================================================================

function BattlePass.Debug(message)
    if BattlePass.GetConfig("debug_mode", "0") == "1" then
        print("[BattlePass] " .. tostring(message))
    end
end

function BattlePass.Error(message)
    print("[BattlePass ERROR] " .. tostring(message))
end

function BattlePass.Info(message)
    print("[BattlePass] " .. tostring(message))
end

-- ============================================================================
-- Configuration Management
-- ============================================================================

function BattlePass.GetConfig(key, default)
    if BattlePass.Config[key] ~= nil then
        return BattlePass.Config[key]
    end
    return default or DEFAULT_CONFIG[key] or ""
end

function BattlePass.GetConfigNumber(key, default)
    local value = BattlePass.GetConfig(key, tostring(default))
    return tonumber(value) or default
end

function BattlePass.GetConfigBool(key, default)
    local value = BattlePass.GetConfig(key, default and "1" or "0")
    return value == "1" or value == "true"
end

function BattlePass.IsEnabled()
    if not BattlePass.TablesExist then
        return false
    end
    return BattlePass.GetConfigBool("enabled", true)
end

-- ============================================================================
-- Table Verification
-- ============================================================================

function BattlePass.CheckTablesExist()
    local query = WorldDBQuery("SHOW TABLES LIKE 'battlepass_config'")
    return query ~= nil
end

-- ============================================================================
-- Data Loading
-- ============================================================================

function BattlePass.LoadConfig()
    BattlePass.Config = {}

    if not BattlePass.TablesExist then
        for key, value in pairs(DEFAULT_CONFIG) do
            BattlePass.Config[key] = value
        end
        return
    end

    local query = WorldDBQuery("SELECT config_key, config_value FROM battlepass_config")
    if query then
        repeat
            local key = query:GetString(0)
            local value = query:GetString(1)
            BattlePass.Config[key] = value
            BattlePass.Debug("Config loaded: " .. key .. " = " .. value)
        until not query:NextRow()
    end

    -- Apply default values for missing keys
    for key, value in pairs(DEFAULT_CONFIG) do
        if BattlePass.Config[key] == nil then
            BattlePass.Config[key] = value
            BattlePass.Debug("Config default: " .. key .. " = " .. value)
        end
    end

    BattlePass.Info("Configuration loaded (" .. BattlePass.TableCount(BattlePass.Config) .. " entries)")
end

function BattlePass.LoadRewardTypes()
    BattlePass.RewardTypeCache = {}

    if not BattlePass.TablesExist then return end

    local query = WorldDBQuery("SELECT type_id, type_name, handler_func, description FROM battlepass_reward_types")
    if query then
        repeat
            local typeId = query:GetUInt32(0)
            BattlePass.RewardTypeCache[typeId] = {
                id = typeId,
                name = query:GetString(1),
                handler = query:GetString(2),
                description = query:GetString(3)
            }
        until not query:NextRow()
    end

    BattlePass.Info("Reward types loaded (" .. BattlePass.TableCount(BattlePass.RewardTypeCache) .. " types)")
end

function BattlePass.LoadLevels()
    BattlePass.LevelCache = {}

    if not BattlePass.TablesExist then return end

    local query = WorldDBQuery([[
        SELECT level, exp_required, reward_type, reward_id, reward_count,
               reward_name, reward_icon, description
        FROM battlepass_levels
        ORDER BY level ASC
    ]])

    if query then
        repeat
            local level = query:GetUInt32(0)
            BattlePass.LevelCache[level] = {
                level = level,
                exp_required = query:GetUInt32(1),
                reward_type = query:GetUInt32(2),
                reward_id = query:GetUInt32(3),
                reward_count = query:GetUInt32(4),
                reward_name = query:GetString(5),
                reward_icon = query:GetString(6),
                description = query:GetString(7)
            }
        until not query:NextRow()
    end

    BattlePass.Info("Levels loaded (" .. BattlePass.TableCount(BattlePass.LevelCache) .. " levels)")
end

function BattlePass.LoadProgressSources()
    BattlePass.SourceCache = {}

    if not BattlePass.TablesExist then return end

    local query = WorldDBQuery([[
        SELECT source_id, source_type, source_subtype, exp_value, multiplier,
               min_level, max_level, enabled, description
        FROM battlepass_progress_sources
        WHERE enabled = 1
    ]])

    if query then
        repeat
            local sourceType = query:GetString(1)
            local subtype = query:GetUInt32(2)

            -- Composite key for sources with specific subtype
            local key = sourceType
            if subtype > 0 then
                key = sourceType .. ":" .. subtype
            end

            BattlePass.SourceCache[key] = {
                id = query:GetUInt32(0),
                source_type = sourceType,
                subtype = subtype,
                exp_value = query:GetInt32(3),
                multiplier = query:GetFloat(4),
                min_level = query:GetUInt32(5),
                max_level = query:GetUInt32(6),
                enabled = query:GetUInt32(7) == 1,
                description = query:GetString(8)
            }
        until not query:NextRow()
    end

    BattlePass.Info("Progress sources loaded (" .. BattlePass.TableCount(BattlePass.SourceCache) .. " sources)")
end

-- ============================================================================
-- Table Utility Functions
-- ============================================================================

function BattlePass.TableCount(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

function BattlePass.IsInCSV(csv, value)
    if not csv or csv == "" then
        return false
    end
    local strValue = tostring(value)
    for item in string.gmatch(csv, "[^,]+") do
        if item == strValue then
            return true
        end
    end
    return false
end

function BattlePass.AddToCSV(csv, value)
    local strValue = tostring(value)
    if not csv or csv == "" then
        return strValue
    end
    return csv .. "," .. strValue
end

function BattlePass.RemoveFromCSV(csv, value)
    if not csv or csv == "" then
        return ""
    end

    local strValue = tostring(value)
    local values = {}

    for v in csv:gmatch("[^,]+") do
        if v ~= strValue then
            table.insert(values, v)
        end
    end

    return table.concat(values, ",")
end

-- ============================================================================
-- System Initialization
-- ============================================================================

function BattlePass.Initialize()
    BattlePass.Info("Initializing Battle Pass System v" .. BattlePass.VERSION .. "...")

    BattlePass.TablesExist = BattlePass.CheckTablesExist()

    if not BattlePass.TablesExist then
        BattlePass.Error("Database tables not found! Battle Pass System DISABLED.")
        BattlePass.Error("Please import the SQL files from data/sql/custom/")
        BattlePass.Error("  - db_world/battlepass_world_tables.sql")
        BattlePass.Error("  - db_characters/battlepass_characters_tables.sql")
        BattlePass.Error("  - db_world/battlepass_npc.sql")
        return
    end

    BattlePass.LoadConfig()
    BattlePass.LoadRewardTypes()
    BattlePass.LoadLevels()
    BattlePass.LoadProgressSources()

    if BattlePass.IsEnabled() then
        BattlePass.Info("Battle Pass System initialized and ENABLED")
        BattlePass.Info("  Max Level: " .. BattlePass.GetConfig("max_level"))
        BattlePass.Info("  Base XP/Level: " .. BattlePass.GetConfig("exp_per_level"))
        BattlePass.Info("  XP Scaling: " .. BattlePass.GetConfig("exp_scaling"))
    else
        BattlePass.Info("Battle Pass System initialized but DISABLED")
    end
end

function BattlePass.Reload()
    BattlePass.Info("Reloading Battle Pass configuration...")

    BattlePass.TablesExist = BattlePass.CheckTablesExist()

    if not BattlePass.TablesExist then
        BattlePass.Error("Database tables not found!")
        return
    end

    BattlePass.LoadConfig()
    BattlePass.LoadRewardTypes()
    BattlePass.LoadLevels()
    BattlePass.LoadProgressSources()
    BattlePass.Info("Battle Pass configuration reloaded")
end

-- ============================================================================
-- Server Startup Hook
-- ============================================================================

local function OnWorldInitialize(event)
    BattlePass.Initialize()
end

RegisterServerEvent(14, OnWorldInitialize) -- WORLD_EVENT_ON_STARTUP
