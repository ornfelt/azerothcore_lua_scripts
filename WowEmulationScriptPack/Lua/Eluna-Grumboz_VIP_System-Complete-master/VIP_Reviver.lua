-- must be in a guild to use /g #life
local command = "#life"

function Vipstonerevive(event, player, message, type, language)

local Paccid = player:GetAccountId()

	if (message == command) and (player:HasItem(ACCT["SERVER"].Vip_coin)==true) and (player:GetMapId()~=489) and (player:GetMapId()~=566) and (player:GetMapId()~=607) and (player:GetMapId()~=529) then 
	 	player:ResurrectPlayer(5*(ACCT[Paccid].Vip))
	 	player:SendBroadcastMessage("|cffFF0000[SYSTEM] |cff00cc00"..player:GetName().." was successfully revived.|r")
	return false;
	end
	if (message == command) and (player:HasItem(ACCT["SERVER"].Vip_coin)==true) and (player:GetMapId()==489) or (player:GetMapId()==566) or (player:GetMapId()==607) or (player:GetMapId()==529) then 
	 	player:SendBroadcastMessage("|cffFF0000[SYSTEM] |cff00cc00"..player:GetName().." you cannot use your self-revive in a BG.|r")
	return false;
	end
	if (message == command) and (player:HasItem(ACCT["SERVER"].Vip_coin)==false) then 
	 	player:SendBroadcastMessage("|cffFF0000[SYSTEM] |cff00cc00"..player:GetName().." you need to have a VIP Coin to use the self-revive.|r")
	 	player:SendBroadcastMessage("|cffFF0000[SYSTEM] |cff00cc00"..player:GetName().." you can purchase a Vip Coin from the Custom VIP vendor, misc items for xx wolf coins.|r")
	return false;
	end
end
RegisterPlayerEvent(21, Vipstonerevive)

function VIP_revive_comm(event, player, message, type, language)
    if(message:lower() == ACCT["SERVER"].Commands) then
    	if(player:IsInGuild())then
    		player:SendBroadcastMessage("/guild "..command.." |cff00cc00To revive your self if your in a guild and own a VIP Coin.|r")
    	end
	end
return;
end
RegisterPlayerEvent(18, VIP_revive_comm)

print("Grumbo'z VIP Reviver loaded.")
