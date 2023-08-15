-----Local--------
local MSG_UNSTUCK = "#unstuck"

----FUNCTION-------
function GetTeam(Player)
  local r = Player:GetPlayerRace()
	if (r == 2 or r == 5 or r == 6 or r == 8 or r == 10) then -- horde
		return 1
	elseif (r == 1 or r == 3 or r == 4 or r == 7 or r == 11) then -- ally
		return 0
	end
end

function OnChat(event, player, message, type, language)
	if(message == MSG_UNSTUCK) then
		if (player:IsInCombat()==true) then
			player:SendAreaTriggerMessage("You are in combat so you can't unstuck!")
		else
            		if(GetTeam(player) == 1) then
						player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000www.extremisgaming.com!")
						player:SendBroadcastMessage("|cffFF0000[Unstucker]|cffFFFF05You have been unstucked, and sended back to your starting posistion.")
						player:Teleport(1, 5080.19, -1798.89, 1327.03) --- horde start
            		elseif(GetTeam(player) == 0) then
						player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000www.extremisgaming.com!")
						player:SendBroadcastMessage("|cffFF0000[Unstucker]|cffFFFF05You have been unstucked, and sended back to your starting posistion.")
						player:Teleport(1, 5080.19, -1798.89, 1327.03) --- Ally start
			end
		end
	end
end	

RegisterServerHook(16, "OnChat")