-- use local chat /say

local command = "#buff"

local BUFFIDS = {
	[1] = {24752, 48074},
	[2] = {43223, 36880, 467, 48469, 48162}, 
	[3] = {48170, 16877, 10220, 13033, 11735, 10952} 
				} -- add/remove spell IDs for buffs (used in the buff command).     
local STONEBUFFIDS = {23948, 26662} -- add/remove spell IDs for buffs (used in the buff command).
     
function VIPbuff(event, player, message, type, language)
local Paccid = player:GetAccountId()
	
	if(message:lower() == command) then
		player:SetMaxHealth(ACCT[Paccid].Health + ((ACCT[Paccid].Health * 0.05) * ACCT[Paccid].Vip))
	
		for _, v in ipairs(BUFFIDS[1]) do
				player:AddAura(v, player)
		end
		
		player:SendBroadcastMessage("|cff00cc00!!POOFF!!|r")

		if(player:HasItem(ACCT["SERVER"].Vip_coin)~=true)then
			player:SendBroadcastMessage("|cff00cc00Purchase a VIP Stone from your local VIP Vendor|r")
			player:SendBroadcastMessage("|cff00cc00to get more buffs.|r")
		end

		if(player:HasItem(ACCT["SERVER"].Vip_coin)==true) then
			for _, v in ipairs(STONEBUFFIDS) do
				player:AddAura(v, player)
			end
		end
	
		if(player:IsInGuild()~=true)then
			player:SendBroadcastMessage("|cff00cc00Join a Guild to get more buffs.|r")
		
		else
			for _, v in ipairs(BUFFIDS[2]) do
				player:AddAura(v, player)
			end
			player:SendBroadcastMessage("|cff00cc00!!Now To Battle!!|r")
		end
	
		if((ACCT[Paccid].Vip)<(ACCT["SERVER"].Vip_max/2))then
			player:SendBroadcastMessage("|cff00cc00Earn VIP "..(ACCT["SERVER"].Vip_max/2).." to get more buffs.|r")
			
		else
			for _, v in ipairs(BUFFIDS[3]) do
				player:AddAura(v, player)
			end
			player:SendBroadcastMessage("|cff00cc00!!PUFF n TUFF!!|r")
		end		
	player:SendBroadcastMessage("|cff00cc00You have been buffed, enjoy!|r")
	return false;
	end
end

RegisterPlayerEvent(18, VIPbuff)

function VIP_buff_comm(event, player, message, type, language)
    if(message:lower() == ACCT["SERVER"].Commands) then
    	player:SendBroadcastMessage("/say "..command.." |cff00cc00For a health and aura buff.|r")
	end
end
RegisterPlayerEvent(18, VIP_buff_comm)

print("Grumbo'z VIP Buff loaded.")
