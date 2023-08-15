--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

local MSG_BUFF = ".buff"

function BuffsOnChat(event, player, message, type, language)
	if(message == MSG_BUFF) then
			if (player:HasAura(36035) == true) then
					player:SendBroadcastMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500You have already been buffed!")
			else
			local GMrank = player:GetGmRank()
			if GMrank == "vp" or GMrank == "vip"  or GMrank == "a" or GMrank == "az" or GMrank == "vg" or GMrank == "vipd" then
				player:CastSpell(33077)
				player:CastSpell(33078)
				player:CastSpell(33079)
				player:CastSpell(33080)
				player:CastSpell(33081)
				player:CastSpell(33082)
				player:CastSpell(24705)
				player:CastSpell(26035)
				print(""..player:GetName().." used .buff command")
				player:SendBroadcastMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500You have been buffed!")
				player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000http://Zarkmania.ucoz.com!")
			else
				player:SendBroadcastMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500Failures have been developed :(")
				player:SendAreaTriggerMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500Not working!")
			end
		end
	end
end

RegisterServerHook(16, "BuffsOnChat")