-- Example ingame commands:
-- .xp 1.25
-- .xp 0.73

local enabled = true -- set to false to disable the entire script
local GMonly = false -- set to true to allow only GMs to change rates

local function getPlayerCharacterGUID(player)
    return player:GetGUIDLow()
end

local XPSQL2 = [[ CREATE TABLE IF NOT EXISTS Custom_XP ( CharID int(10) unsigned NOT NULL, Rate float unsigned NOT NULL DEFAULT 1) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
WorldDBExecute(XPSQL2)


local function GMONLY(player)
    player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

local function OnLogin(event, player)
    local PUID = getPlayerCharacterGUID(player)
    local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))

    if Q then
        local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
        player:SendBroadcastMessage(string.format("|cff5af304Your XP rate is curently set to %.1f|r", Rate))
    end
end

local function SetRate(event, player, command)
    local mingmrank = 3
    local PUID = getPlayerCharacterGUID(player)

    if command:find("xp") then
        local rate = tonumber(command:sub(4))

        if rate and rate >= 0.01 and rate <= 10 then
            if (GMonly and player:GetGMRank() < mingmrank) then
                GMONLY(player)
                return false
            else
                WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
                WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, %.2f)", PUID, rate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your XP rate to %.2fx|r", rate))
                return false
            end
        end
    end
end


local function OnXP(event, player, amount, victim)
    local PUID = getPlayerCharacterGUID(player)
    local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
    local mingmrank = 3

    if Q then
        local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
        Rate = tonumber(string.format("%.1f", Rate))

        if (GMonly and player:GetGMRank() < mingmrank) then
            return amount
        end

        if (GMonly and player:GetGMRank() >= mingmrank) then
            return amount * Rate
        end

        if (not GMonly) then
            return amount * Rate
        end
    else
        return amount
    end
end

if enabled then
    RegisterPlayerEvent(3, OnLogin)
    RegisterPlayerEvent(12, OnXP)
    RegisterPlayerEvent(42, SetRate)
end
