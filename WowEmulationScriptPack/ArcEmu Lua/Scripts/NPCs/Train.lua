local MSG_REVIVE = "#train"

function DonormallOnChat(event, player, message, type, language)
	if(message == MSG_REVIVE) then
	if (player:IsInCombat() == true) then
	player:SendAreaTriggerMessage("|cFF00FFFF[VIP System]|cFFFFA500You can't use this command in combat!")
	player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500Note: VIP command. If you arent a VIP go to www.extremisgaming.com and donate for it to unlock this mall!")
		else
	if (player:GetPlayerLevel() <= 20) then
	player:SendAreaTriggerMessage("|cFF00FFFF[VIP System]|cFFFFA500You must be atleast level 20 to use this command!")
	player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500Note: VIP command. If you arent a VIP go to www.extremisgaming.com and donate for it to unlock this mall!")
		else
			local GMrank = player:GetGmRank()
			if GMrank == "vb" or GMrank == "vs" or GMrank == "vg"  or GMrank == "vd" or GMrank == "a" or GMrank == "az" then
			player:Teleport(608, 1822.714111, 803.867554, 44.365688)
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500Welcome to DONOR MALL!")
			player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000www.extremisgaming.com!")
			else
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be VIP to use this command, go donate on www.extremisgaming.com for VIP rank!!")
			player:SendAreaTriggerMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be VIP to use this command!")
				end
			end
		end
	end
end

RegisterServerHook(16, "DonormallOnChat")