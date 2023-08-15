--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Gossiper_GossipHello(pUnit, event, player)
	pUnit:GossipCreateMenu(100, player, 0)
	pUnit:GossipMenuAddItem(10, "I'm ready to fight!", 1, 0)
	pUnit:GossipSendMenu(player)
end
	
function Gossiper_OnGossipSelect(pUnit, event, player, intid, id, code, pMisc)
	if(intid == 1) then
		pUnit:SendChatMessage(11, 0, "Get ready to Die!")
		pUnit:SetFaction(14)
		player:GossipComplete()
	end
end

RegisterUnitGossipEvent(33707, 1, Gossiper_GossipHello)
RegisterUnitGossipEvent(33707, 2, Gossiper_OnGossipSelect)