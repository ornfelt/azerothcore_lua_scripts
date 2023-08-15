 function Item_Trigger(item, event, player)
  Item_menu(item, player)
 end

 function Item_menu(item, player)
if (player:IsInCombat() == true) then
 player:SendAreaTriggerMessage("You are in combat!")
    else                          
  item:GossipCreateMenu(3543, player, 0)
item:GossipMenuAddItem(1, "Forest Area", 1, 0)
item:GossipMenuAddItem(1, "Rocky Area", 2, 0)
item:GossipMenuAddItem(1, "Desert Area", 3, 0)
item:GossipMenuAddItem(1, "Insect Area", 4, 0)
item:GossipSendMenu(player)
end
end

 function OnSelect(item, event, player, id, intid, code)

if(intid == 1) then
player:Teleport(209, 312.067, 1591.909, -271.452)
end

if(intid == 2) then
player:Teleport(209, 2358.637, 1541.420, -17.081)
end

if(intid == 3) then
player:Teleport(209, -384.0272, 302.708, 53.231 )
end

if(intid == 4) then
player:Teleport(209, -76.391, 1222.575, -51.526)
end

end



 
RegisterItemGossipEvent(96000,1,"Item_Trigger")
RegisterItemGossipEvent(96000,2,"OnSelect")