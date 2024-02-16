CustomXPNamespace = {}

CustomXPNamespace.enabled = true
CustomXPNamespace.GMonly = false

function CustomXPNamespace.getPlayerCharacterGUID(player)
    return player:GetGUIDLow()
end

function CustomXPNamespace.GMONLY(player)
    -- player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

function CustomXPNamespace.OnLogin(event, player)
    local PUID = CustomXPNamespace.getPlayerCharacterGUID(player)
    local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))

    if Q then
        local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
        player:SendBroadcastMessage(string.format("|cff5af304Your experience rate is currently set to %.1f|r", Rate))
    end
end

function CustomXPNamespace.OnFirstLogin(event, player)
    local PUID = CustomXPNamespace.getPlayerCharacterGUID(player)
    local defaultRate = 1
    WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, %.2f)", PUID, defaultRate))
    player:SendBroadcastMessage(string.format("|cff5af304Your experience rate is set to default: %.1fx|r", defaultRate))
end

function CustomXPNamespace.SetRate(event, player, command)
    local mingmrank = 3
    local PUID = CustomXPNamespace.getPlayerCharacterGUID(player)
    
    if command:find("xp") or command:find("exp") then
        if player:HasItem(800048, 1) then
            player:SendBroadcastMessage("|cffff0000You do not have access to this feature in Slow and Steady Mode.|r")
            return false
        end

        if command:find("q") or command:find("Q") or command:find("?") or command == "xp" or command == "exp" then
            local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
            if Q then
                local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
                player:SendBroadcastMessage(string.format("|cff5af304Your experience rate is currently set to %.1fx|r", Rate))
            else
                player:SendBroadcastMessage("|cff5af304Your experience rate is not found, default experience rate will be applied.|r")
            end
            
            player:SendBroadcastMessage("|cff5af304To set your experience rate, type '.xp X' or '.exp X' where X is a value between 0.01 and 10.|r")
            return false
        end

        local rate = tonumber(command:sub(command:find("xp") and 4 or 5))

        if rate and rate >= 0.01 and rate <= 10 then
            if CustomXPNamespace.GMonly and player:GetGMRank() < mingmrank then
                CustomXPNamespace.GMONLY(player)
                return false
            elseif not CustomXPNamespace.GMonly or player:GetGMRank() >= mingmrank then
                WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
                WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, %.2f)", PUID, rate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your experience rate to %.2fx|r", rate))
                return false
            end
        end
    end
end

function CustomXPNamespace.OnXP(event, player, amount, victim)
    local PUID = CustomXPNamespace.getPlayerCharacterGUID(player)
    local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
    local mingmrank = 3

    if Q then
        local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
        Rate = tonumber(string.format("%.1f", Rate))

        if (CustomXPNamespace.GMonly and player:GetGMRank() < mingmrank) then
            return amount
        end

        if (CustomXPNamespace.GMonly and player:GetGMRank() >= mingmrank) then
            return amount * Rate
        end

        if (not CustomXPNamespace.GMonly) then
            return amount * Rate
        end
    else
        return amount
    end
end

if CustomXPNamespace.enabled then
    RegisterPlayerEvent(3, CustomXPNamespace.OnLogin)
    RegisterPlayerEvent(12, CustomXPNamespace.OnXP)
    RegisterPlayerEvent(42, CustomXPNamespace.SetRate)
    RegisterPlayerEvent(30, CustomXPNamespace.OnFirstLogin) 
end
