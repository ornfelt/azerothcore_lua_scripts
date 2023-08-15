local PLAYER_EVENT_ON_LOGIN = 3

local function OnLogin(event, player)
    player:SendBroadcastMessage("Hello!")
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)