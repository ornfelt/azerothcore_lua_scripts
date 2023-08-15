function Item_Trigger(item, event, player)

 	player:Teleport(560, 3323.52, 606.19, 166.5)
	player:SendBroadcastMessage("Hello, and welcome to the Crypt of the Forgotten!")
end



RegisterItemGossipEvent(91002,1,"Item_Trigger")
