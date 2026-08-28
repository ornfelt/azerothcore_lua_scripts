--[[
    GameMasterUI Shared Utilities Module
    Common validation helpers used across multiple handler modules
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

-- Export the module
return SharedUtils
