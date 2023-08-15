function Nagatwo_OnGossip(pUnit, event, player)
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(0, "Cannibalize is a racial trait for which race?", 5, 0)
		pUnit:GossipMenuAddItem(0, "Let me think...", 2, 0)
		pUnit:GossipSendMenu(player)
end

function Nagatwo_OnGossipSelect(pUnit, event, player, id, intid, pmisc)
		if(intid == 5) then
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(0, "[A]Orc", 3, 0)
		pUnit:GossipMenuAddItem(0, "[B]Troll", 3, 0)
		pUnit:GossipMenuAddItem(0, "[C]Undead", 4, 0)
		pUnit:GossipMenuAddItem(0, "[D]Human", 3, 0)
		pUnit:GossipSendMenu(player)
end

		if(intid == 3) then
		pUnit:SendChatMessage(12, 0, "Your answer is incorrect.")
		player:GossipComplete()
end

		if(intid == 2) then
		player:GossipComplete()
		
end

		if(intid == 4) then
		player:SetPhase(1)
		pUnit:SendChatMessage(12, 0, "Correct.")
		player:GossipComplete()
		end
end
	
RegisterUnitGossipEvent(30911, 1, "Nagatwo_OnGossip")
RegisterUnitGossipEvent(30911, 2, "Nagatwo_OnGossipSelect")	


	