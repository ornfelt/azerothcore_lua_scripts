--[[
Name: More GM Functions
Version: 1.0.0
Made by: MadBuffoon
Notes: 

]]
local enabled = true
local MenuMenus = true
local GM_F_GossipID = 9910004
local Gold = 10000

function GMFunctionMenuGossip(event, player)
	if player:GetGMRank() < 3 then
		return
	end
	player:GossipClearMenu()
	
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_misc_coin_01:45:45:-40|t Add gold", 0, 1, true, "How much gold?")
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9999)
	
	player:GossipSendMenu(1, player, GM_F_GossipID)

end


--(Start)
local function GM_F_OnSelect(event, player, _, sender, intid, code)
local PlayerName = player:GetName()
	
	if(intid == 1) then --List
		local gold_Amount = code * Gold
		player:ModifyMoney(gold_Amount)
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou added |cfffca726"..code.." gold|cff3399FF. To Self.")
		player:GossipComplete()
	end		
	if(intid == 9999) then --Back
		GMSettingsMenuGossip(event, player)
		return false
	end
end
--(End)
if enabled then
RegisterPlayerGossipEvent(GM_F_GossipID, 2, GM_F_OnSelect)
end
