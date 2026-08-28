-- ----------------------------------------------------------------------------------------------------------
--  While in-game, prepend any of the commands below with "!" or "." (e.g., ".bank" or "!mail").
--  - Mail, Bank, and Auction will open their windows.
--  - Repair costs gold and attempts to use the guild bank.
--
--  Hosted by Aldori15 on Github: https://github.com/Aldori15/global-mail_banking_auctions
-- ----------------------------------------------------------------------------------------------------------

local config = {
    enableBank = true,
    enableMail = true,
    enableAuction = true,
    enableGearRepair = true,
    cooldownSeconds = 10, -- Prevent command spamming
}

local commands = {
    bank = { "bank", "openbank" },  -- Chat commands for opening the bank
    mail = { "mb", "mail", "mailbox" },  -- Chat commands for opening the mailbox
    auction = { "auctions", "ah", "auctionhouse" },  -- Chat commands for opening the auction house window
    repair = { "repair", "gearrepair", "fixgear" }, -- Chat commands for repairing gear
}

-- Command cooldown tracking: [playerGuid][action] = expiryTimestamp
local playerCooldowns = {}

local function IsPlayerOnCooldown(player, action)
    local guid = player:GetGUIDLow()
    local now = os.time()

    if not playerCooldowns[guid] then
        playerCooldowns[guid] = {}
    end

    local cooldownTable = playerCooldowns[guid]

    if cooldownTable[action] and now < cooldownTable[action] then
        local remaining = cooldownTable[action] - now
        player:SendBroadcastMessage("You must wait " .. remaining .. " seconds before using that command again.")
        return true
    end

    cooldownTable[action] = now + config.cooldownSeconds
    return false
end

local function HandleChatCommand(event, player, message, type, language)
    -- Convert message to lowercase for case-insensitive comparison
    local normalizedMessage = string.lower(message)

    for action, commandList in pairs(commands) do
        for _, command in ipairs(commandList) do
            if normalizedMessage == command then
                -- Safety checks to prevent command abuse
                if player:IsInCombat() or player:IsDead() or player:IsFlying() then
                    player:SendBroadcastMessage("You cannot use this command right now.")
                    return false
                end

                if IsPlayerOnCooldown(player, action) then return false end

                if action == "bank" and config.enableBank then
                    player:SendShowBank(player)
                elseif action == "mail" and config.enableMail then
                    local playerGuid = player:GetGUIDLow()
                    player:SendShowMailBox(playerGuid)
                elseif action == "auction" and config.enableAuction then
                    player:SendAuctionMenu(player)
                elseif action == "repair" and config.enableGearRepair then
                    player:DurabilityRepairAll(true, 1.0, true)
                    player:SendBroadcastMessage("Your equipment has been repaired using guild bank funds.")
                else
                    -- If the config is disabled for a specific command, notify the player
                    player:SendBroadcastMessage("The " .. action .. " command is currently disabled.")
                end
                return false  -- Prevent further processing if command is matched
            end
        end
    end
    return true  -- Allow further processing if no command is matched
end

RegisterPlayerEvent(42, HandleChatCommand)