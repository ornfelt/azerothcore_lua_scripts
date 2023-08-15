--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


local MSG_HONOR = ".increase arena"

function ArenaOnChat(event, player, message, type, language)
	if(message == MSG_HONOR) then
			 if (player:GetArenaPoints() >= 50000) then
			player:SendBroadcastMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500Your arena points are at its max!")
			 else
			    local GMrank = player:GetGmRank()
			 if GMrank == "1"  or GMrank == "2" or GMrank == "3" or GMrank == "az" then
			player:AddArenaPoints(2500)
			player:SendBroadcastMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500Added 2500 more arena points to your character.")
			 else
			player:SendBroadcastMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500Your not a Staff member!")
			player:SendAreaTriggerMessage("|cFF00FFFF[WoD Message]|cFFFFA500|cFFFFA500Not working!")
			end
		end
	end
end

RegisterServerHook(16, "ArenaOnChat")