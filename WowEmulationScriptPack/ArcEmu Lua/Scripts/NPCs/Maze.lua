function Naga_OnGossip(pUnit, event, player)
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(1, "What is 76*76/5?", 1, 0)
		pUnit:GossipMenuAddItem(1, "Let me think...", 2, 0)
		pUnit:GossipSendMenu(player)
end

function Naga_OnGossipSelect(pUnit, event, player, id, intid, pmisc)
	if(intid == 1) then
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(0, "[A]1157,2", 3, 0)
		pUnit:GossipMenuAddItem(0, "[B]1337", 3, 0)
		pUnit:GossipMenuAddItem(0, "[C]1155,2", 4, 0) 
		pUnit:GossipSendMenu(player)
end

	if(intid == 3) then
		pUnit:SendChatMessage(12, 0, "Your answer is incorrect.")
		player:GossipComplete()
end

	if(intid == 4) then
		pUnit:SendChatMessage(12, 0, "Correct.")
		player:SetPhase(2)
		player:GossipComplete()
end

	if(intid == 2) then
		player:GossipComplete()
		end
end

RegisterUnitGossipEvent(27648, 1, "Naga_OnGossip")
RegisterUnitGossipEvent(27648, 2, "Naga_OnGossipSelect")