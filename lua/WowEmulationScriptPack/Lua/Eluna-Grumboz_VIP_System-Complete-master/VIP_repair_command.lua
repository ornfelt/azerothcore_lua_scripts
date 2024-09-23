-- use local chat /say #repair
function VIP_repair(event, player, message, type, language)

  	if(message == "#repair") then

		if(player:HasItem(ACCT["SERVER"].Vip_coin)==true) then
        		player:DurabilityRepairAll(100,100)
        		player:SendBroadcastMessage("|cff00cc00All your items have been repaired!|r")
        else
        		player:SendBroadcastMessage("You must have a VIP Coin to use this command.")
      	return false;
    	end
    end
end    

RegisterPlayerEvent(18, VIP_repair)

function VIP_repair_comm(event, player, message, type, language)
    if(message:lower() == ACCT["SERVER"].Commands) then
    	player:SendBroadcastMessage("/say #repair |cff00cc00to repair your gear if you own a VIP Coin.|r")
	end
return;
end
RegisterPlayerEvent(18, VIP_repair_comm)

print("Grumbo'z VIP repair loaded.")
