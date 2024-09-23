--[[
To use just add

	kickPlayer(player,delay)
	
to where ever you want to kick the player.

The delay = time in seconds.
Second will be auto converted to ms.
]]




local function kick(eventId, delay, repeats, player)
	player:SaveToDB()
	player:KickPlayer()
	--player:LogoutPlayer(true)
end

function kickPlayer(player,delay)
	player:SendBroadcastMessage("|cffff3347Notice: |cfffcca03You are getting kicked in |cffff3347"..delay.."|cfffcca03 seconds to make use the account/character changes applied.")	
	local delayMS = delay * 1000
    player:RegisterEvent(kick, delayMS, 1, player)
end