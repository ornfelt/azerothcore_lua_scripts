-- ----------------------------------------------------------------------------------------------------------
--  While in-game, just prepend any of the commands below with "!" or "."  For example, ".bank" or "!mail".
--  Mail and Bank will open up their respective windows.  Auction will summon a temporary Auctioneer NPC.
--
--  Hosted by Aldori15 on Github: https://github.com/Aldori15/global-mail_banking_auctions
-- ----------------------------------------------------------------------------------------------------------

local config = {
    enableBank = true,
    enableMail = true,
    enableAuction = true,
}

local commands = {
    bank = { "bank", "openbank" },  -- Chat commands for opening the bank
    mail = { "mb", "mail", "mailbox" },  -- Chat commands for opening the mailbox
    auction = { "auctions", "ah", "auctionhouse" },  -- Chat commands for summoning the auction house NPC
}

local auctioneerSayMessages = {
    "The auction is open, but only for a short time!",
    "I won't be here long—list or browse quickly!",
    "Make your trades fast; I’m just passing through!",
    "A brief window for your auction needs—use it wisely!",
    "I'm here temporarily, so make your bids count!",
    "Short-term service, long-term deals—act fast!",
}

local auctioneerNpcEntries = {
    ALLIANCE = 15659,
    HORDE = 16628,
}

local distanceInFront = 1.5  -- Distance to spawn auctioneer in front of the player
local auctioneerLifespan = 60000  -- 60 second lifespan before despawning

local function HandleAuctionCommand(player)
    -- Calculate spawn position and orientation
    local playerX, playerY, playerZ, playerO = player:GetX(), player:GetY(), player:GetZ(), player:GetO()
    local spawnX = playerX + math.cos(playerO) * distanceInFront
    local spawnY = playerY + math.sin(playerO) * distanceInFront
    local spawnO = (playerO + math.pi) % (2 * math.pi) -- Opposite direction to face the player

    -- Spawn a temporary auctioneer in front of the player
    local tempAuctioneerEntry = player:GetTeam() == 0 and auctioneerNpcEntries.ALLIANCE or auctioneerNpcEntries.HORDE
    local spawnType = 3  -- TEMPSUMMON_TIMED_DESPAWN.  Do not change this value from 3
    local auctioneer = player:SpawnCreature(tempAuctioneerEntry, spawnX, spawnY, playerZ, spawnO, spawnType, auctioneerLifespan)
    
    if auctioneer then       
        local randomMessage = auctioneerSayMessages[math.random(#auctioneerSayMessages)]
        auctioneer:SendUnitSay(randomMessage, 0)
    else
        print("Error: Failed to spawn auctioneer for player: " .. player:GetName())
    end
end

local function HandleChatCommand(event, player, message, type, language)
    -- Convert message to lowercase for case-insensitive comparison
    local normalizedMessage = string.lower(message)

    for action, commandList in pairs(commands) do
        for _, command in ipairs(commandList) do
            if normalizedMessage == command then
                if action == "bank" and config.enableBank then
                    player:SendShowBank(player)
                elseif action == "mail" and config.enableMail then
                    playerGuid = player:GetGUIDLow()
                    player:SendShowMailBox(playerGuid)
                elseif action == "auction" and config.enableAuction then
                    HandleAuctionCommand(player)
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