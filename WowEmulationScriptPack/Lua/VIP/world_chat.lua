local on = "#w on"
local off = "#w off"

function ChatSystem(event, player, msg, type, lang, channel)
	if(msg ~= "")then
		if(msg ~= "Away")then
			local PaccName = player:GetAccountName()
			if(msg == on) then
				ACCT[PaccName].chat = 1
				player:SendBroadcastMessage("|cff3399ffWorld chat feature toggled on.|r")
				return false;
			elseif(msg == off) then
				ACCT[PaccName].chat = 0
				player:SendBroadcastMessage("|cff3399ffWorld chat feature toggled off.|r")
				return false;
			elseif(ACCT[PaccName].chat == 1)then -- 0 = world chat off :: 1 = world chat on
				local t = "[|cffF15F0C|Hplayer:" .. player:GetName() .. "|h" .. player:GetName() .. "|h|r]:|cffFAE5E5" .. msg;
				SendWorldMessage(t)
				return false;
			
			end
		end
	end
end

RegisterPlayerEvent(18, ChatSystem)

