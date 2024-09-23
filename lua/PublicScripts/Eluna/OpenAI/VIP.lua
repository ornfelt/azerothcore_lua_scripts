-[[
VIP Status Management Script for Eluna

This script facilitates the management of VIP statuses for players. It provides functionality to set, get, 
and display the remaining time of VIP statuses. VIP statuses are tracked using a database table named `vip_status`.

The script includes functions to:
- Load VIP statuses from the database and cache them on server startup for efficient access.
- Set VIP status for a player with a specified duration.
- Get the remaining time of a player's VIP status in seconds.
- Format and display the remaining VIP status time in a human-readable format (e.g., "1 day", "12 hours").
- Periodically refresh the VIP status cache to account for changes made directly to the database.

The cache refresh interval can be configured by modifying the `CACHE_REFRESH_INTERVAL_MINUTES` value.

Usage:
- Call player:SetVIPStatus(duration) to set a player's VIP status for a specific duration in seconds.
- Call player:GetVIPStatus() to retrieve the remaining VIP status duration in seconds.
- Call player:GetVIPStatusFormatted() to get the VIP status duration as a formatted string.
]]

-- Configuration: Set the cache refresh interval in minutes
local CACHE_REFRESH_INTERVAL_MINUTES = 5

local VIPCache = {}

-- Function to load VIP statuses from the database into the cache on server startup
local function LoadVIPStatuses()
    -- Ensure the vip_status table exists
    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS `vip_status` (
            `player_guid` INT UNSIGNED NOT NULL,
            `expiration` TIMESTAMP NOT NULL,
            PRIMARY KEY (`player_guid`),
            INDEX `idx_expiration` (`expiration`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='VIP status tracking for players';
    ]])

    -- Clear the current cache before reloading data
    VIPCache = {}

    local VIPQuery = CharDBQuery("SELECT player_guid, UNIX_TIMESTAMP(expiration) AS expiration FROM vip_status WHERE expiration > NOW();")
    if VIPQuery then
        repeat
            local playerGuid = VIPQuery:GetUInt32(0)
            local expiration = VIPQuery:GetUInt32(1)
            VIPCache[playerGuid] = expiration
        until not VIPQuery:NextRow()
    end
end

-- Set the VIP status for a Player and update it in the database
function Player:SetVIPStatus(duration)
    local currentTime = os.time()
    local expirationTime = currentTime + duration
    VIPCache[self:GetGUIDLow()] = expirationTime
    
    CharDBExecute(string.format(
        "INSERT INTO vip_status (player_guid, expiration) VALUES (%d, FROM_UNIXTIME(%d)) ON DUPLICATE KEY UPDATE expiration = FROM_UNIXTIME(%d)",
        self:GetGUIDLow(),
        expirationTime,
        expirationTime
    ))
end

-- Get the VIP status for a Player from the cache
function Player:GetVIPStatus()
    local expirationTime = VIPCache[self:GetGUIDLow()]
    local currentTime = os.time()

    if expirationTime and currentTime < expirationTime then
        -- VIP status is active
        return expirationTime - currentTime
    elseif expirationTime then
        -- VIP status has expired, clear it from the cache and the database
        VIPCache[self:GetGUIDLow()] = nil
        CharDBExecute(string.format(
            "DELETE FROM vip_status WHERE player_guid = %d",
            self:GetGUIDLow()
        ))
    end

    -- No VIP status or VIP has expired
    return 0
end

-- Get the VIP status for a Player as a formatted string (e.g., "1 day", "12 hours")
function Player:GetVIPStatusFormatted()
    local seconds = self:GetVIPStatus()
    if seconds <= 0 then
        return "No VIP status"
    end

    local days = math.floor(seconds / 86400)
    seconds = seconds - (days * 86400)
    local hours = math.floor(seconds / 3600)
    seconds = seconds - (hours * 3600)
    local minutes = math.ceil(seconds / 60)

    if days > 0 then
        return days .. (days == 1 and " day" or " days")
    elseif hours > 0 then
        return hours .. (hours == 1 and " hour" or " hours")
    else
        return minutes .. (minutes == 1 and " minute" or " minutes")
    end
end

-- Function to set up a repeating timed event to refresh the VIP cache
local function CreateRefreshVIPCacheEvent()
    -- Convert minutes to milliseconds for the interval
    local eventInterval = CACHE_REFRESH_INTERVAL_MINUTES * 60 * 1000
    CreateLuaEvent(LoadVIPStatuses, eventInterval, 0)
end

-- Call this function when the server starts to load VIP statuses and start the refresh event
LoadVIPStatuses()
CreateRefreshVIPCacheEvent()
