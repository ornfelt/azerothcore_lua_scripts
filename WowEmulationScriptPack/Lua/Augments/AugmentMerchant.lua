local vendorEntry = 21283
local forgottenSoulID = 7097

local function onTalk(event, player, object)
	player:GossipMenuAddItem( 100,"I would like to buy a random augment for 100 Forgotten Echoes!",0,1)
	player:GossipSendMenu( 1, object )
end

local function onSelect(event, player, object, sender, intid, code, menu_id)
	if(player:HasItem(forgottenSoulID,1))then
		player:SendBroadcastMessage("You've just bought an augment for 100 Forgotten Echoes.")
		generateRandomAugment(player,possibleSpellAugmentChoice[player:GetClass()][math.random(#possibleSpellAugmentChoice[player:GetClass()])],100)
		player:RemoveItem(forgottenSoulID,1)
		player:GossipComplete()
	else
		player:SendBroadcastMessage("You do not have 100 Forgotten Echoes. Come back after more adventures!")
		player:SendAreaTriggerMessage("You do not have 100 Forgotten Echoes. Come back after more adventures!")
	end
end

RegisterCreatureGossipEvent( vendorEntry, 1, onTalk )
RegisterCreatureGossipEvent( vendorEntry, 2, onSelect )