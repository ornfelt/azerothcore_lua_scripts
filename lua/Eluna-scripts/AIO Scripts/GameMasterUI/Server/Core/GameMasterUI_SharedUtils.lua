--[[
    GameMasterUI Shared Utilities Module
    Consolidates common validation and helper functions to reduce code duplication
]]

local SharedUtils = {}

-- Validate GM permissions and target player
-- Returns: success (bool), targetPlayer (Player object or nil), errorMessage (string or nil)
function SharedUtils.validateGMAndTarget(player, targetName, minRank)
    minRank = minRank or 2
    
    -- Check GM rank
    if player:GetGMRank() < minRank then
        return false, nil, "You do not have permission to use this command. Required GM rank: " .. minRank
    end
    
    -- If no target name provided, return success with nil target (for commands that don't need a target)
    if not targetName then
        return true, nil, nil
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        return false, nil, "Player '" .. targetName .. "' not found or is offline."
    end
    
    return true, targetPlayer, nil
end

-- Validate just GM permissions
-- Returns: success (bool), errorMessage (string or nil)
function SharedUtils.validatePermission(player, minRank)
    minRank = minRank or 2
    
    if player:GetGMRank() < minRank then
        return false, "You do not have permission to use this command. Required GM rank: " .. minRank
    end
    
    return true, nil
end

-- Send standardized error message
function SharedUtils.sendError(player, message)
    if Utils and Utils.sendMessage then
        Utils.sendMessage(player, "error", message)
    else
        player:SendBroadcastMessage("|cFFFF0000[Error]|r " .. message)
    end
end

-- Send standardized success message
function SharedUtils.sendSuccess(player, message)
    if Utils and Utils.sendMessage then
        Utils.sendMessage(player, "success", message)
    else
        player:SendBroadcastMessage("|cFF00FF00[Success]|r " .. message)
    end
end

-- Send standardized info message
function SharedUtils.sendInfo(player, message)
    if Utils and Utils.sendMessage then
        Utils.sendMessage(player, "info", message)
    else
        player:SendBroadcastMessage("|cFF00CCFF[Info]|r " .. message)
    end
end

-- Validate item ID exists
function SharedUtils.validateItem(itemId)
    if not itemId or itemId == 0 then
        return false, "Invalid item ID"
    end
    
    -- Additional validation could be added here (check against item database)
    return true, nil
end

-- Validate spell ID exists
function SharedUtils.validateSpell(spellId)
    if not spellId or spellId == 0 then
        return false, "Invalid spell ID"
    end
    
    -- Additional validation could be added here (check against spell database)
    return true, nil
end

-- Get player by various identifiers (name, GUID, or Player object)
function SharedUtils.getPlayer(identifier)
    if type(identifier) == "string" then
        -- Try as player name first
        local player = GetPlayerByName(identifier)
        if player then return player end
        
        -- Try as GUID
        return GetPlayerByGUID(identifier)
    elseif type(identifier) == "number" then
        -- Assume it's a GUID
        return GetPlayerByGUID(identifier)
    elseif type(identifier) == "userdata" then
        -- Assume it's already a player object
        return identifier
    end
    
    return nil
end

-- Safe database query execution with error handling
function SharedUtils.executeQuery(query, errorContext)
    local success, result = pcall(function()
        return WorldDBQuery(query)
    end)
    
    if not success then
        print("[GameMasterUI] Database error in " .. (errorContext or "unknown context") .. ": " .. tostring(result))
        return nil
    end
    
    return result
end

-- Export the module
return SharedUtils