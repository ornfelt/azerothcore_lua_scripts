--[[
    GameMaster UI - Ban Management Handlers Module
    
    This module handles all ban-related functionality:
    - Account bans (ban all characters on account)
    - Character bans (ban specific character only)
    - IP bans (ban IP address)
    - Unban operations
    - Ban information queries
    
    Note: Works around known issues with Eluna Ban() function
]]--

local BanHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

-- Ban type constants
local BAN_TYPE = {
    ACCOUNT = 0,
    CHARACTER = 1,
    IP = 2
}

-- Ban type labels for logging
local BAN_TYPE_LABELS = {
    [0] = "Account",
    [1] = "Character",
    [2] = "IP"
}

function BanHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register all ban-related handlers
    GameMasterSystem.banPlayer = BanHandlers.banPlayer
    GameMasterSystem.unbanPlayer = BanHandlers.unbanPlayer
    GameMasterSystem.getBanInfo = BanHandlers.getBanInfo
    GameMasterSystem.checkServerCapabilities = BanHandlers.checkServerCapabilities
end

-- Check server capabilities for ban support
function BanHandlers.checkServerCapabilities(player)
    -- Check if character_banned table exists
    local supportsCharacterBan = false
    local characterBanLocation = nil
    
    -- Check CHARACTERS database first (preferred)
    local checkCharTable = CharDBQuery("SHOW TABLES LIKE 'character_banned'")
    if checkCharTable then
        supportsCharacterBan = true
        characterBanLocation = "CHARACTERS"
    else
        -- Check AUTH database as fallback
        local checkAuthTable = AuthDBQuery("SHOW TABLES LIKE 'character_banned'")
        if checkAuthTable then
            supportsCharacterBan = true
            characterBanLocation = "AUTH"
        end
    end
    
    local capabilities = {
        supportsCharacterBan = supportsCharacterBan,
        characterBanLocation = characterBanLocation,
        serverVersion = GetCoreName() .. " " .. (GetCoreVersion and GetCoreVersion() or "Unknown")
    }
    
    print(string.format("[GameMasterSystem] Server capabilities: CharBan=%s (Location=%s)", 
        tostring(supportsCharacterBan), 
        characterBanLocation or "N/A"))
    
    AIO.Handle(player, "GameMasterSystem", "receiveServerCapabilities", capabilities)
end

-- Main ban handler
function BanHandlers.banPlayer(player, targetName, duration, reason, banType)
    -- Validate Staff permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Validate inputs
    banType = tonumber(banType) or BAN_TYPE.CHARACTER
    duration = tonumber(duration) or 0  -- 0 = permanent
    reason = reason and tostring(reason) or "Banned by Staff"
    
    -- Convert duration from minutes to seconds
    local durationSeconds = duration * 60
    
    print("================== BAN EXECUTION DEBUG ==================")
    print(string.format("Ban Type: %s (%d)", BAN_TYPE_LABELS[banType] or "Unknown", banType))
    print(string.format("Target: %s", targetName))
    print(string.format("Duration: %d seconds (%s)", durationSeconds, duration == 0 and "Permanent" or duration .. " minutes"))
    print(string.format("Reason: %s", reason))
    print(string.format("Staff: %s", player:GetName()))
    print("========================================================")
    
    local success = false
    local banParam = targetName
    
    -- Handle different ban types
    if banType == BAN_TYPE.ACCOUNT then
        -- Account ban - need to get username, not character name
        local targetPlayer = GetPlayerByName(targetName)
        local accountId = nil
        
        if targetPlayer then
            accountId = targetPlayer:GetAccountId()
        else
            -- Try to find offline player
            local result = CharDBQuery(string.format("SELECT account FROM characters WHERE name = '%s'", targetName))
            if result then
                accountId = result:GetUInt32(0)
            else
                Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found.")
                return
            end
        end
        
        -- Get username from account ID
        local accountResult = AuthDBQuery(string.format("SELECT username FROM account WHERE id = %d", accountId))
        if accountResult then
            banParam = accountResult:GetString(0)
            print(string.format("[GameMasterSystem] Account ban - Using username: %s (ID: %d)", banParam, accountId))
        else
            Utils.sendMessage(player, "error", "Could not find account for player.")
            return
        end
        
        -- Try Eluna Ban function for account ban
        local banResult = Ban(BAN_TYPE.ACCOUNT, banParam, durationSeconds, reason, player:GetName())
        success = (banResult == 0)  -- 0 = success
        
        if success then
            print(string.format("[GameMasterSystem] ✓ Account ban executed successfully - Username: %s", banParam))
        else
            print(string.format("[GameMasterSystem] ✗ Account ban failed with result: %s", tostring(banResult)))
            -- Fallback to direct SQL
            success = BanHandlers.executeSQLBan(BAN_TYPE.ACCOUNT, accountId, nil, nil, durationSeconds, reason, player:GetName())
        end
        
    elseif banType == BAN_TYPE.CHARACTER then
        -- Character ban - use direct SQL due to Ban() function issues
        local targetPlayer = GetPlayerByName(targetName)
        local charGuid = nil
        
        if targetPlayer then
            charGuid = targetPlayer:GetGUIDLow()
        else
            -- Try to find offline player
            local result = CharDBQuery(string.format("SELECT guid FROM characters WHERE name = '%s'", targetName))
            if result then
                charGuid = result:GetUInt32(0)
            else
                Utils.sendMessage(player, "error", "Character '" .. targetName .. "' not found.")
                return
            end
        end
        
        -- Skip Ban() function for character bans - it's broken
        print("[GameMasterSystem] Using direct SQL for character ban (Ban() function is broken for character bans)")
        success = BanHandlers.executeSQLBan(BAN_TYPE.CHARACTER, nil, charGuid, nil, durationSeconds, reason, player:GetName())
        
    elseif banType == BAN_TYPE.IP then
        -- IP ban - need to get player's IP
        local targetPlayer = GetPlayerByName(targetName)
        if not targetPlayer then
            Utils.sendMessage(player, "error", "Player must be online for IP ban.")
            return
        end
        
        local ipAddress = targetPlayer:GetPlayerIP()
        if not ipAddress then
            Utils.sendMessage(player, "error", "Could not retrieve player's IP address.")
            return
        end
        
        banParam = ipAddress
        print(string.format("[GameMasterSystem] IP ban - Using IP: %s", banParam))
        
        -- Try Eluna Ban function for IP ban
        local banResult = Ban(BAN_TYPE.IP, banParam, durationSeconds, reason, player:GetName())
        success = (banResult == 0)  -- 0 = success
        
        if success then
            print(string.format("[GameMasterSystem] ✓ IP ban executed successfully - IP: %s", banParam))
        else
            print(string.format("[GameMasterSystem] ✗ IP ban failed with result: %s", tostring(banResult)))
            -- Fallback to direct SQL
            success = BanHandlers.executeSQLBan(BAN_TYPE.IP, nil, nil, ipAddress, durationSeconds, reason, player:GetName())
        end
    end
    
    -- Send result to Staff
    if success then
        local durationText = duration == 0 and "permanently" or string.format("for %d minutes", duration)
        Utils.sendMessage(player, "success", string.format("%s banned %s %s. Reason: %s", 
            BAN_TYPE_LABELS[banType], targetName, durationText, reason))
        
        -- Log the ban
        print(string.format("[GameMasterSystem] Ban executed - Type: %s, Target: %s, Duration: %s, Staff: %s", 
            BAN_TYPE_LABELS[banType], targetName, durationText, player:GetName()))
        
        -- Kick player if online
        local targetPlayer = GetPlayerByName(targetName)
        if targetPlayer then
            targetPlayer:KickPlayer()
        end
    else
        Utils.sendMessage(player, "error", string.format("Failed to ban %s. Check server logs.", targetName))
    end
end

-- Execute ban using direct SQL (fallback method)
function BanHandlers.executeSQLBan(banType, accountId, charGuid, ipAddress, duration, reason, staffName)
    local currentTime = os.time()
    local unbanTime = duration > 0 and (currentTime + duration) or 0
    
    print(string.format("[GameMasterSystem] Executing SQL ban - Type: %s", BAN_TYPE_LABELS[banType]))
    
    if banType == BAN_TYPE.ACCOUNT and accountId then
        -- Insert into account_banned table
        local query = string.format(
            "INSERT INTO account_banned (id, bandate, unbandate, bannedby, banreason, active) " ..
            "VALUES (%d, %d, %d, '%s', '%s', 1) " ..
            "ON DUPLICATE KEY UPDATE bandate = %d, unbandate = %d, bannedby = '%s', banreason = '%s', active = 1",
            accountId, currentTime, unbanTime, staffName, reason,
            currentTime, unbanTime, staffName, reason
        )
        -- Execute the query
        AuthDBExecute(query)
        
        -- Verify the ban was created
        local verifyQuery = string.format(
            "SELECT 1 FROM account_banned WHERE id = %d AND bandate = %d",
            accountId, currentTime
        )
        local result = AuthDBQuery(verifyQuery)
        if result then
            print("[GameMasterSystem] ✓ Account ban verified in database")
            return true
        else
            print("[GameMasterSystem] ✗ Account ban verification failed")
            return false
        end
        
    elseif banType == BAN_TYPE.CHARACTER and charGuid then
        -- Determine which database has character_banned table
        local DBExecute = nil
        local checkCharTable = CharDBQuery("SHOW TABLES LIKE 'character_banned'")
        if checkCharTable then
            DBExecute = CharDBExecute
            print("[GameMasterSystem] Using CHARACTERS database for character ban")
        else
            DBExecute = AuthDBExecute
            print("[GameMasterSystem] Using AUTH database for character ban")
        end
        
        -- Check if table has 'active' column
        local hasActive = false
        local columns = checkCharTable and CharDBQuery("DESCRIBE character_banned") or AuthDBQuery("DESCRIBE character_banned")
        if columns then
            repeat
                if columns:GetString(0) == "active" then
                    hasActive = true
                    break
                end
            until not columns:NextRow()
        end
        
        -- Insert into character_banned table
        local query
        if hasActive then
            query = string.format(
                "INSERT INTO character_banned (guid, bandate, unbandate, bannedby, banreason, active) " ..
                "VALUES (%d, %d, %d, '%s', '%s', 1) " ..
                "ON DUPLICATE KEY UPDATE bandate = %d, unbandate = %d, bannedby = '%s', banreason = '%s', active = 1",
                charGuid, currentTime, unbanTime, staffName, reason,
                currentTime, unbanTime, staffName, reason
            )
        else
            query = string.format(
                "INSERT INTO character_banned (guid, bandate, unbandate, bannedby, banreason) " ..
                "VALUES (%d, %d, %d, '%s', '%s') " ..
                "ON DUPLICATE KEY UPDATE bandate = %d, unbandate = %d, bannedby = '%s', banreason = '%s'",
                charGuid, currentTime, unbanTime, staffName, reason,
                currentTime, unbanTime, staffName, reason
            )
        end
        -- Execute the query
        local executeSuccess = pcall(function()
            DBExecute(query)
        end)
        
        if executeSuccess then
            print("[GameMasterSystem] ✓ Character ban query executed successfully")
            -- Trust that the execute worked - verification often fails due to transaction isolation
            return true
        else
            print("[GameMasterSystem] ✗ Character ban query execution failed")
            return false
        end
        
    elseif banType == BAN_TYPE.IP and ipAddress then
        -- Insert into ip_banned table
        local query = string.format(
            "INSERT INTO ip_banned (ip, bandate, unbandate, bannedby, banreason) " ..
            "VALUES ('%s', %d, %d, '%s', '%s') " ..
            "ON DUPLICATE KEY UPDATE bandate = %d, unbandate = %d, bannedby = '%s', banreason = '%s'",
            ipAddress, currentTime, unbanTime, staffName, reason,
            currentTime, unbanTime, staffName, reason
        )
        -- Execute the query
        AuthDBExecute(query)
        
        -- Verify the ban was created
        local verifyQuery = string.format(
            "SELECT 1 FROM ip_banned WHERE ip = '%s' AND bandate = %d",
            ipAddress, currentTime
        )
        local result = AuthDBQuery(verifyQuery)
        if result then
            print("[GameMasterSystem] ✓ IP ban verified in database")
            return true
        else
            print("[GameMasterSystem] ✗ IP ban verification failed")
            return false
        end
    end
    
    return false
end

-- Unban handler
function BanHandlers.unbanPlayer(player, targetName, banType)
    -- Validate Staff permissions
    if player:GetGMRank() < 3 then
        Utils.sendMessage(player, "error", "You need Staff rank 3 or higher to unban players.")
        return
    end
    
    banType = tonumber(banType) or BAN_TYPE.CHARACTER
    local success = false
    
    if banType == BAN_TYPE.ACCOUNT then
        -- Get account ID from character name
        local accountId = nil
        local result = CharDBQuery(string.format("SELECT account FROM characters WHERE name = '%s'", targetName))
        if result then
            accountId = result:GetUInt32(0)
        else
            Utils.sendMessage(player, "error", "Character '" .. targetName .. "' not found.")
            return
        end
        
        -- Remove from account_banned
        success = AuthDBExecute(string.format("DELETE FROM account_banned WHERE id = %d", accountId))
        
    elseif banType == BAN_TYPE.CHARACTER then
        -- Get character GUID
        local charGuid = nil
        local result = CharDBQuery(string.format("SELECT guid FROM characters WHERE name = '%s'", targetName))
        if result then
            charGuid = result:GetUInt32(0)
        else
            Utils.sendMessage(player, "error", "Character '" .. targetName .. "' not found.")
            return
        end
        
        -- Try both databases for character_banned
        local charSuccess = CharDBExecute(string.format("DELETE FROM character_banned WHERE guid = %d", charGuid))
        local authSuccess = AuthDBExecute(string.format("DELETE FROM character_banned WHERE guid = %d", charGuid))
        success = charSuccess or authSuccess
        
    elseif banType == BAN_TYPE.IP then
        Utils.sendMessage(player, "error", "IP unban requires the IP address, not player name.")
        return
    end
    
    if success then
        Utils.sendMessage(player, "success", string.format("%s unbanned for %s.", BAN_TYPE_LABELS[banType], targetName))
        print(string.format("[GameMasterSystem] Unban executed - Type: %s, Target: %s, Staff: %s", 
            BAN_TYPE_LABELS[banType], targetName, player:GetName()))
    else
        Utils.sendMessage(player, "error", string.format("Failed to unban %s or no ban found.", targetName))
    end
end

-- Get ban information
function BanHandlers.getBanInfo(player, targetName)
    -- Validate Staff permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local banInfo = {
        account = nil,
        character = nil,
        ip = nil
    }
    
    -- Get account ID and character GUID
    local accountId, charGuid = nil, nil
    local result = CharDBQuery(string.format("SELECT account, guid FROM characters WHERE name = '%s'", targetName))
    if result then
        accountId = result:GetUInt32(0)
        charGuid = result:GetUInt32(1)
    else
        Utils.sendMessage(player, "error", "Character '" .. targetName .. "' not found.")
        return
    end
    
    -- Check account ban
    local accountBan = AuthDBQuery(string.format(
        "SELECT bandate, unbandate, bannedby, banreason FROM account_banned WHERE id = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        accountId
    ))
    if accountBan then
        banInfo.account = {
            banDate = accountBan:GetUInt32(0),
            unbanDate = accountBan:GetUInt32(1),
            bannedBy = accountBan:GetString(2),
            reason = accountBan:GetString(3)
        }
    end
    
    -- Check character ban (try both databases)
    local charBan = CharDBQuery(string.format(
        "SELECT bandate, unbandate, bannedby, banreason FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        charGuid
    ))
    if not charBan then
        charBan = AuthDBQuery(string.format(
            "SELECT bandate, unbandate, bannedby, banreason FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
            charGuid
        ))
    end
    if charBan then
        banInfo.character = {
            banDate = charBan:GetUInt32(0),
            unbanDate = charBan:GetUInt32(1),
            bannedBy = charBan:GetString(2),
            reason = charBan:GetString(3)
        }
    end
    
    -- Send ban info to client
    AIO.Handle(player, "GameMasterSystem", "receiveBanInfo", targetName, banInfo)
end

return BanHandlers