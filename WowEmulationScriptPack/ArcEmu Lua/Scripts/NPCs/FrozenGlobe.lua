 function Item_TriggerFrozenGlobe(item, event, player)
  Item_menuFrozenGlobe(item, player)
 end

 function Item_menuFrozenGlobe(item, player)

if (player:IsInCombat() == true) then
	player:SendAreaTriggerMessage("You are in combat!")
	else                          
		item:GossipCreateMenu(3543, player, 0)
		item:GossipMenuAddItem(1, "Hillsbrad Foothills Mountains", 1, 0)
		item:GossipMenuAddItem(1, "Stratholme bridge", 2, 0)
		item:GossipSendMenu(player)
	end
end

function OnSelect(item, event, player, id, intid, code)

if(intid == 1) then
	player:Teleport(560, 3323.52, 606.19, 166.5)
end

if(intid == 2) then
	player:Teleport(595, 1929.06, 1286.9, 144.46)
end




end
 
RegisterItemGossipEvent(94007,1,"Item_TriggerFrozenGlobe")
RegisterItemGossipEvent(94007,2,"OnSelectFrozenGlobe")