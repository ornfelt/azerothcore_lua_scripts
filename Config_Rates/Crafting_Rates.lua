--[[
Name: Crafting_Rates
Version: 1.0.0
Made by: Dinkledork
Notes: use ingame command .craft

]]


CraftingRatesNamespace = {}

CraftingRatesNamespace.enabled = true
CraftingRatesNamespace.GMonly = false

function CraftingRatesNamespace.getPlayerCharacterGUID(player)
    if not player then
        print("Error: Player object is nil in getPlayerCharacterGUID")
        return nil
    end
    return player:GetGUIDLow()
end

function CraftingRatesNamespace.GMONLY(player)
    if not player then
        return
    end
    -- player:SendBroadcastMessage("|cffff0000You don't have permission to use this command.|r")
end

function CraftingRatesNamespace.OnLogin(event, player)
    if not player then
        return
    end
    local PUID = CraftingRatesNamespace.getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT CraftRate FROM custom_craft_rates WHERE CharID=%i", PUID))

    if Q then
        local CraftRate = Q:GetUInt32(0)
        player:SendBroadcastMessage(string.format("|cff5af304Your craft rate is currently set to %dx|r", CraftRate))
    end
end

function CraftingRatesNamespace.SetCraftRate(event, player, command)
    if not player then
        return false
    end
    local mingmrank = 3
    local PUID = CraftingRatesNamespace.getPlayerCharacterGUID(player)

    if command:find("craft") then
        local rate = tonumber(command:sub(7))

        if command == "craft" then
            player:SendBroadcastMessage("|cff5af304To set your craft rate, type '.craft X' where X is a value between 1 and 10.|r")
            return false
        end

        if rate and rate >= 1 and rate <= 10 then
            if player:HasItem(800048, 1) or player:HasItem(800086, 1) then
                player:SendBroadcastMessage("|cffff0000You cannot use this command while certain challenge modes are active!|r")
                return false
            end
            if CraftingRatesNamespace.GMonly and player:GetGMRank() < mingmrank then
                CraftingRatesNamespace.GMONLY(player)
                return false
            else
                CharDBExecute(string.format("REPLACE INTO custom_craft_rates (CharID, CraftRate) VALUES (%i, %d)", PUID, rate))
                player:SendBroadcastMessage(string.format("|cff5af304You changed your craft rate to %dx|r", rate))
                return false
            end
        else
            player:SendBroadcastMessage("|cffff0000Invalid craft rate. Please enter a value between 1 and 10.|r")
            return false
        end
    end
end

function CraftingRatesNamespace.onCreateItem(event, player, item, count)
    if not player then
        return
    end

    local itemEntry = item:GetEntry()
    local PUID = CraftingRatesNamespace.getPlayerCharacterGUID(player)
    local Q = CharDBQuery(string.format("SELECT CraftRate FROM custom_craft_rates WHERE CharID=%i", PUID))
    local CraftRate = 1

    if Q then
        CraftRate = Q:GetUInt32(0)
    end

    local additionalCount = (CraftRate - 1) * count

    if additionalCount > 0 then
        player:AddItem(itemEntry, additionalCount)
    end
end

function CraftingRatesNamespace.createCraftRatesTable()
    CharDBExecute([[
        CREATE TABLE IF NOT EXISTS custom_craft_rates (
            CharID INT PRIMARY KEY,
            CraftRate INT DEFAULT 1
        );
    ]])
end

if CraftingRatesNamespace.enabled then
    CraftingRatesNamespace.createCraftRatesTable()
    RegisterPlayerEvent(3, CraftingRatesNamespace.OnLogin)
    RegisterPlayerEvent(52, CraftingRatesNamespace.onCreateItem)
    RegisterPlayerEvent(42, CraftingRatesNamespace.SetCraftRate)
end

