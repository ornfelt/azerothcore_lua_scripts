local MSG_BUFF = "#donorbuffs"

function DonorBuffsOnChat(event, player, message, type, language)
	if(message == MSG_BUFF) then
			if (player:HasAura(33077) == true) then
			player:SendBroadcastMessage("|cFF00FFFF[Buff System]|cFFFFA500|cFFFFA500You have already been buffed!")
			else
			local GMrank = player:GetGmRank()
			if GMrank == "vb" or GMrank == "vs"  or GMrank == "vg" or GMrank == "vd" or GMrank == "a" or GMrank == "az" then
			player:CastSpell(33077)
			player:CastSpell(33078)
			player:CastSpell(33079)
			player:CastSpell(33080)
			player:CastSpell(33081)
			player:CastSpell(33082)
			player:CastSpell(24705)
			player:CastSpell(26035)
                        player:CastSpell(47440) -- Commanding Shout
			player:CastSpell(48161) -- Power Fortitude
			player:CastSpell(48469) -- Mark of the Wild
			player:CastSpell(53307) -- Thorns
			player:CastSpell(20217) -- Blessing of Kings
			player:CastSpell(58449) -- Strength Buff
			player:CastSpell(58451) -- Agility Buff
			player:CastSpell(33081) -- Stamina Buff
			player:CastSpell(48099) -- Intellect Buff
			player:CastSpell(43197) -- Spirit Buff
                        print(""..player:GetName().." used #buffs command")
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You have been buffed!")
			player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000Thank you for donating and helping the server")
			else
			player:SendBroadcastMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be at least a Vip Bronze to use this command, go donate on www.extremisgaming.com for VIP rank!!")
			player:SendAreaTriggerMessage("|cFF00FFFF[VIP System]|cFFFFA500|cFFFFA500You must be at least a Vip Bronze to use this command!")
			end
		end
	end
end

RegisterServerHook(16, "DonorBuffsOnChat")