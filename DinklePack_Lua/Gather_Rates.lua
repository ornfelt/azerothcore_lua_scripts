GatherRatesNamespace = {}

GatherRatesNamespace.enabled = true
GatherRatesNamespace.GMonly = false

function GatherRatesNamespace.getPlayerCharacterGUID(player)
    return player:GetGUIDLow()
end

function GatherRatesNamespace.GMONLY(player)
    -- player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

function GatherRatesNamespace.OnLogin(event, player)
    local PUID = GatherRatesNamespace.getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT GatherRate FROM custom_gather_rates WHERE CharID=%i", PUID))

    if Q then
        local GatherRate = Q:GetUInt32(0)
        player:SendBroadcastMessage(string.format("|cff5af304Your gather rate is currently set to %dx|r", GatherRate))
    end
end

function GatherRatesNamespace.SetGatherRate(event, player, command)
    local mingmrank = 3
    local PUID = GatherRatesNamespace.getPlayerCharacterGUID(player)

    if command:find("ga") then
        local rate = tonumber(command:sub(4))

        if command == "ga" then
            player:SendBroadcastMessage("|cff5af304To set your gather rate, type '.ga X' where X is a value between 1 and 10.|r")
            return false
        end

        if rate and rate >= 1 and rate <= 10 then
            if player:HasItem(800048, 1) or player:HasItem(800086, 1) then
                player:SendBroadcastMessage("|cffff0000You cannot use this command while certain challenge modes are active!|r")
                return false
            end
            if GatherRatesNamespace.GMonly and player:GetGMRank() < mingmrank then
                GatherRatesNamespace.GMONLY(player)
                return false
            else
                CharDBExecute(string.format("REPLACE INTO custom_gather_rates (CharID, GatherRate) VALUES (%i, %d)", PUID, rate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your gather rate to %dx|r", rate))
                return false
            end
        else
            player:SendBroadcastMessage("|cffff0000Invalid gather rate. Please enter a value between 1 and 10.|r")
            return false
        end
    end
end

function GatherRatesNamespace.onLootItem(event, player, item, count)
    local itemEntry = item:GetEntry()
    local PUID = GatherRatesNamespace.getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT GatherRate FROM custom_gather_rates WHERE CharID=%i", PUID))
    local GatherRate = 1

    if Q then
        GatherRate = Q:GetUInt32(0)
    end

    if item:GetClass() == 7 then
        local additionalCount = (GatherRate - 1) * count
        
        if additionalCount > 0 then
            player:AddItem(itemEntry, additionalCount)
        end
    end
end

function GatherRatesNamespace.createGatherRatesTable()
    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS custom_gather_rates (
            CharID INT PRIMARY KEY,
            GatherRate INT DEFAULT 1
        );
    ]])
end

if GatherRatesNamespace.enabled then
    GatherRatesNamespace.createGatherRatesTable()
    RegisterPlayerEvent(3, GatherRatesNamespace.OnLogin)
    RegisterPlayerEvent(32, GatherRatesNamespace.onLootItem)
    RegisterPlayerEvent(42, GatherRatesNamespace.SetGatherRate)
end
