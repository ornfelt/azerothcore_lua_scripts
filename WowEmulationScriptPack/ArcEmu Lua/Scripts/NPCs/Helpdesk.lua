local spawned = 0

function HelpDesk(pItem, event, player)
	if(spawned == 1) then
		player:SendBroadcastMessage("You can only have one sexy bot!")
else
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(1, "DUMMY", 1, 0)
		end
end
function HelpDesk_Stuff(pItem, event, player, intid, id, pmisc)
	if(intid == 1) then
		spawned = 1
		end
end

RegisterItemGossipEvent(94024, 1, "HelpDesk")
RegisterItemGossipEvent(94024, 2, "HelpDesk_Stuff")


	
	
	
		