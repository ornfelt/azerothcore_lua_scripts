-- ----------------------------------------------------------------------------------------------------------
--  While in-game, just prepend any of the commands below with "!" or "."  For example, ".bank" or "!mail".
--
--  Hosted by Aldori15 on Github: https://github.com/Aldori15/global-mail_banking_auctions
-- ----------------------------------------------------------------------------------------------------------

local commands = {
    bank = { "bank", "openbank" },  -- Chat commands for opening the bank
    mail = { "mail", "mailbox" },  -- Chat commands for opening the mailbox
    auction = { "auctions", "ah", "auctionhouse" },  -- Chat commands for opening the auction house
}

local function HandleChatCommand(event, player, message, type, language)
    -- Convert message to lowercase for case-insensitive comparison
    local normalizedMessage = string.lower(message)

    for action, commandList in pairs(commands) do
        for _, command in ipairs(commandList) do
            if normalizedMessage == command then
                if action == "bank" then
                    player:SendShowBank(player)
                elseif action == "mail" then
                    player:SendShowMail(player)
                elseif action == "auction" then
                    player:SendAuctionMenu(player)
                end
                -- Return false to prevent further processing
                return false
            end
        end
    end
end

RegisterPlayerEvent(42, HandleChatCommand)