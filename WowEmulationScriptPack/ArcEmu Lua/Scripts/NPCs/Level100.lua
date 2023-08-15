local MSG_REVIVE = "#255"

function Level255OnChat(event, player, message, type, language)
	if(message == MSG_REVIVE) then
	if (player:GetPlayerLevel() >= 255) then
	player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You cant use this command, your already level 90!")
	player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be VIP to use this command, go donate on www.extremisgaming.com for VIP rank!!")
			else
			local GMrank = player:GetGmRank()
			if GMrank == "vb" or GMrank == "vs" or GMrank == "vg"  or GMrank == "vs" or GMrank  == "0" or GMrank == "a" or GMrank == "az" then
			player:SetLevel(255)
		    player:SendBroadcastMessage("|cFF00FFFF[Vip System]|cFFFFA500|cFFFFA500Congratulations your now level 90!")
			else
			player:SendBroadcastMessage("|cFF00FFFF[Vip System]|cFFFFA500|cFFFFA500You must be at least a Bronze-VIP to use this command, go donate on www.extremisgaming.com for VIP rank!!")
			player:SendAreaTriggerMessage("|cFF00FFFF[Vip System]|cFFFFA500|cFFFFA500You must be at least a Bronze-VIP to use this command!")
		end
	end
end
end

RegisterServerHook(16, "Level255OnChat")