-- Owner: Didrik
-- SendToDiscordLog("DiscordHook has been loaded!")

local function OnLogin(event, player)
    SendToDiscordLog("The account " .. player:GetAccountName() .. " has logged in with a character named: " .. player:GetName())
end

RegisterPlayerEvent(3, OnLogin)