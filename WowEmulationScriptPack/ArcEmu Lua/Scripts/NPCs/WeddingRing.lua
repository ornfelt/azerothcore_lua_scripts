function Ring_OnGossip(pItem, event, plr, pmisc, intid)
	pItem:GossipCreateMenu(1, player, 0)
	pItem:GossipMenuAddItem(1, "Accept the Quest.", 1, 0)
	pItem:GossipMenuAddItem(1, "Do not accept.", 2, 0)
	if(intid == 1) then
		pItem:GossipMenuAddItem(1, "Are you sure?", 3, 0)
	end
	pItem:GossipSendMenu(player)
end

function Ring_OnGossipSelect(pItem, event, plr, id, intid, pmisc)
	if(intid == 2) then
		player:GossipComplete()
end

	if(intid == 3) then
		player:StartQuest(99998)
		player:GossipComplete()
		end
end

RegisterItemGossipEvent(93002, 1, "Ring_OnGossip")
RegisterItemGossipEvent(93002, 2, "Ring_OnGossipSelect")
	