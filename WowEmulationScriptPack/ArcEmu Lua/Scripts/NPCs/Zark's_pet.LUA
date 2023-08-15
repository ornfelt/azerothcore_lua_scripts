--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

local NPC_ENTRY = 100102

function On_Gossip_Hello(unit, event, player)
	unit:GossipCreateMenu(3000, player, 0)
	unit:GossipMenuAddItem(2, "I'ma poke you!", 1, 0)
	unit:GossipMenuAddItem(2, "I'll leave you alone.", 2, 0)
	unit:GossipSendMenu(player)
end

function On_Gossip_Select(unit, event, player, id, intid, code) 
	if(intid == 1) then
		unit:SendChatMessage(14, 0, "Grrr!")
		player:GossipComplete()
	elseif(intid == 2) then
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(100102, 1, On_Gossip_Hello)
RegisterUnitGossipEvent(100102, 2, On_Gossip_Select)