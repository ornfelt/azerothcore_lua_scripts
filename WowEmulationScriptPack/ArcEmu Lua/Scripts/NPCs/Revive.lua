local MSG_REVIVE = "#ressurrect"

function ReviveOnChat(event, player, message, type, language)
	if(message == MSG_REVIVE) then
		if (player:IsAlive() == true) then 
			player:SendAreaTriggerMessage("|cFF00FFFF[Revive System]|cFFFFA500|cFFFFA500You are not dead so you can't revive yourself!")
			player:SendBroadcastMessage("|cFF00FFFF[Revive System]|cFFFFA500|cFFFFA500You are not dead so you can't revive yourself!")
			else
				if (player:GetItemCount(34057) >= 1) then
				player:ResurrectPlayer()
				player:RemoveItem(34057, 1)
				player:SendBroadcastMessage("|cFF00FFFF[Revive System]|cFFFFA500Checking for |cFF00FFFF[Revive Stone]|cFFFFA500....")
				player:SendBroadcastMessage("|cFF00FFFF[Revive System]|cFFFFA500Found and removed one |cFF00FFFF[Revive Stone]|cFFFFA500...")
				player:SendBroadcastMessage("|cFF00FFFF[Revive System]|cFFFFA500Success.. You have been revived!")
				player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000www.extremisgaming.com!")
				else
				player:SendBroadcastMessage("|cFF00FFFF[Revive System]|cFFFFA500You need 1 |cFF00FFFF[Revive Stone]|cFFFFA500 to use this command!")
				player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000www.extremisgaming.com!")
			end
		end
	end
end
RegisterServerHook(16, "ReviveOnChat")