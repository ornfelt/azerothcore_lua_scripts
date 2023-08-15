 function Item_Trigger(item, event, player)
  Item_menu(item, player)
 end

 function Item_menu(item, player)
if (player:IsInCombat() == true) then
 player:SendAreaTriggerMessage("You are in combat!")
    else                          
  item:GossipCreateMenu(3545, player, 0)
item:GossipMenuAddItem(1, "Bring me back to the Stone of Elements", 1, 0)

item:GossipSendMenu(player)
end
end

 function OnSelect(item, event, player, id, intid, code)

if(intid == 1) then
player:Teleport(534, 5060, -2083, 1368)

end

end



 
RegisterItemGossipEvent(94027,1,"Item_Trigger")
RegisterItemGossipEvent(94027,2,"OnSelect")