local MSG_REVIVE = "#gold"

function IncreaseGoldOnChat(event, player, message, type, language)
	if(message == MSG_REVIVE) then
			local GMrank = player:GetGmRank()
			if GMrank == "vb" then
			player:AddItem(97423, 1)
			
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500Vip Bronze Coin Added!")
			else
			if GMrank == "vs" then
			player:AddItem(97424, 1)
			
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500Vip Silver Coin Added!")
			else
			if GMrank == "vg" then
			player:AddItem(97425, 1)
			
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500Vip Gold Coin Added!")
			else
			if GMrank == "vd" or GMrank == "a" or GMrank == "az" then
			player:AddItem(974236, 1)
			
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500Vip Diamond Coin Added!")
			else
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be VIP to use this command, go donate on www.extremisgaming.com for VIP rank!!")
			player:SendAreaTriggerMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be VIP to use this command!")
					end
				end
			end
		end
	end
end

RegisterServerHook(16, "IncreaseGoldOnChat")