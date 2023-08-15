--[[

	This is created by zdroid9770  :D

	© Copyright 2011 - 2012

]]

local NPC_ENTRY = 7000011

function On_Gossip_Hello(unit, event, player)
	unit:GossipCreateMenu(3000, player, 0)
	unit:GossipMenuAddItem(2, "Whats my GM level?", 1, 0)
	unit:GossipSendMenu(player)
end

function On_Gossip_Select(unit, event, player, id, intid, code)
	if (intid == 1) then
		if(v:IsGm()==true) then
			unit:SendChatMessage(12, 0, "Your GM Level is: "..pUnit:GetGMRank().."!")
			unit:GossipComplete(player)
		else
			unit:SendChatMessage(14, 0, "Your not a GM"..player:GetName().."!")
			unit:GossipComplete(player)
		end
	end
	player:GossipComplete()
end

RegisterUnitGossipEvent(NPC_ENTRY, 1, On_Gossip_Hello)
RegisterUnitGossipEvent(NPC_ENTRY, 2, On_Gossip_Select)
