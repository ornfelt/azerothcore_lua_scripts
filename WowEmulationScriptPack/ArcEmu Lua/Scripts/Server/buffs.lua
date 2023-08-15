local MSG_BUFF = "#Buff"

function BuffOnChat(event, player, message, type, language)
	if(message == MSG_BUFF) then
			if (player:HasAura(33077) == true) then
			player:SendBroadcastMessage("|cFF00FFFF[Player System]|cFFFFA500|cFFFFA500You have already been buffed!")
			else
			local GMrank = player:GetGmRank()
			if GMrank == "0" or GMrank == "1" or GMrank == "2" or GMrank == "3" then
			player:CastSpell(33077)
			player:CastSpell(33078)
			player:CastSpell(33079)
			player:CastSpell(33080)
			player:CastSpell(33081)
			player:CastSpell(33082)
			player:CastSpell(24705)
			player:CastSpell(26035)
                      
			print(""..player:GetName().." used #buffs command")
			player:SendBroadcastMessage("|cFF00FFFF[Player System]|cFFFFA500|cFFFFA500You have been buffed!")
			player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05To Gain even more buffs when using this command |cffFF0000|cffFFFF05  |cffFF0000donate|cffFFFF05 on |cffFF0000www.extremisgaming.com!")
			end
		end
	end
end

RegisterServerHook(16, "BuffOnChat")