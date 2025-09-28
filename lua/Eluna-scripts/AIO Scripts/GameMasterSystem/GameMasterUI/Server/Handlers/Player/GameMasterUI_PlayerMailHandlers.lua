--[[
    GameMaster UI - Player Mail Handlers Module
    
    This module handles all mail-related functionality:
    - Sending mail to players
    - Sending mail with items
    - Mail with gold/COD
]]--

local PlayerMailHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerMailHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register all mail-related handlers
    GameMasterSystem.sendPlayerMail = PlayerMailHandlers.sendPlayerMail
    GameMasterSystem.sendPlayerMailWithItems = PlayerMailHandlers.sendPlayerMailWithItems
end

-- Send mail to player
function PlayerMailHandlers.sendPlayerMail(player, targetName, subject, body, gold)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Validate inputs
    if not subject or subject == "" then
        Utils.sendMessage(player, "error", "Mail subject cannot be empty.")
        return
    end
    
    if not body or body == "" then
        Utils.sendMessage(player, "error", "Mail body cannot be empty.")
        return
    end
    
    gold = tonumber(gold) or 0
    if gold < 0 then
        gold = 0
    end
    
    -- Convert gold to copper
    local copper = gold * 10000
    
    -- Find target player (can be offline for mail)
    local targetGuid = nil
    local targetPlayer = GetPlayerByName(targetName)
    
    if targetPlayer then
        targetGuid = targetPlayer:GetGUIDLow()
    else
        -- Try to find offline player
        local result = CharDBQuery(string.format("SELECT guid FROM characters WHERE name = '%s'", targetName))
        if result then
            targetGuid = result:GetUInt32(0)
        else
            Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found.")
            return
        end
    end
    
    -- Send mail using Eluna's SendMail function
    -- SendMail(subject, body, receiverGuid, senderGuid, stationary, delay, money, cod, entry, amount)
    -- Using GM stationery (61) instead of default (41)
    SendMail(subject, body, targetGuid, 0, 61, 0, copper, 0, 0, 0)
    
    Utils.sendMessage(player, "success", string.format("Mail sent to %s with subject: %s", targetName, subject))
    
    -- Notify online player
    if targetPlayer then
        targetPlayer:SendBroadcastMessage(string.format("You have received mail from Staff %s.", player:GetName()))
    end
end

-- Send mail with items to player
function PlayerMailHandlers.sendPlayerMailWithItems(player, data)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Extract data from table
    local targetName = data.recipient
    local subject = data.subject
    local body = data.message
    local money = data.money or 0
    local cod = data.cod or 0
    local items = data.items or {}
    local stationery = data.stationery or 61  -- GM stationery (61) by default
    local delay = data.delay or 0
    
    -- Validate inputs
    if not targetName or targetName == "" then
        Utils.sendMessage(player, "error", "Recipient name cannot be empty.")
        return
    end
    
    if not subject or subject == "" then
        Utils.sendMessage(player, "error", "Mail subject cannot be empty.")
        return
    end
    
    if not body or body == "" then
        Utils.sendMessage(player, "error", "Mail body cannot be empty.")
        return
    end
    
    -- Validate money and cod
    money = tonumber(money) or 0
    cod = tonumber(cod) or 0
    
    if money < 0 then money = 0 end
    if cod < 0 then cod = 0 end
    
    -- Find target player (can be offline for mail)
    local targetGuid = nil
    local targetPlayer = GetPlayerByName(targetName)
    
    if targetPlayer then
        targetGuid = targetPlayer:GetGUIDLow()
    else
        -- Try to find offline player
        local result = CharDBQuery(string.format("SELECT guid FROM characters WHERE name = '%s'", targetName))
        if result then
            targetGuid = result:GetUInt32(0)
        else
            Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found.")
            return
        end
    end
    
    -- Build SendMail parameters
    -- SendMail(subject, text, receiverGUIDLow, senderGUIDLow, stationary, delay, money, cod, entry1, amount1, entry2, amount2, ...)
    -- Using senderGUIDLow = 0 to make it appear from "Game Master" system
    local params = {
        subject,
        body,
        targetGuid,
        0,  -- Sender GUID 0 = system/GM mail
        stationery,
        delay,
        money,
        cod
    }
    
    -- Add items (up to 12)
    local itemCount = 0
    for i = 1, math.min(#items, 12) do
        local item = items[i]
        if item and item.entry then
            local entry = tonumber(item.entry) or 0
            local amount = tonumber(item.amount) or 1
            
            if entry > 0 and amount > 0 then
                table.insert(params, entry)
                table.insert(params, amount)
                itemCount = itemCount + 1
            end
        end
    end
    
    -- Send the mail using unpacked parameters
    SendMail(unpack(params))
    
    -- Send success message
    if itemCount > 0 then
        Utils.sendMessage(player, "success", string.format("Mail sent to %s with %d item(s). Subject: %s", targetName, itemCount, subject))
    else
        Utils.sendMessage(player, "success", string.format("Mail sent to %s. Subject: %s", targetName, subject))
    end
    
    -- Notify online player
    if targetPlayer then
        if itemCount > 0 then
            targetPlayer:SendBroadcastMessage(string.format("You have received mail with %d item(s) from Staff %s.", itemCount, player:GetName()))
        else
            targetPlayer:SendBroadcastMessage(string.format("You have received mail from Staff %s.", player:GetName()))
        end
    end
end

return PlayerMailHandlers