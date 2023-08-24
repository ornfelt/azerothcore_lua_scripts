Draven = {}

-- Create the item you want to give to the player
Draven.ITEM_ID = 60114 -- replace with the ID of the item you want to give

-- Register the gossip event for the NPC
function Draven.OnGossipHello(event, player, creature)
player:GossipMenuAddItem(0, "|TInterface\\Icons\\ability_stealth:50:50:-23:0|tPurchase 3 Stealth Potions for 75 Silver.|r", 0, 1)
player:GossipSendMenu(1, creature)
end

-- Handle the player's selection in the gossip menu
function Draven.OnGossipSelect(event, player, creature, sender, action)
if action == 1 then
if player:GetCoinage() < 7500 then
player:SendBroadcastMessage("You do not have enough coins.")
player:GossipComplete()
else
player:SetCoinage(player:GetCoinage() - 7500)
player:AddItem(Draven.ITEM_ID, 3)
player:SendBroadcastMessage("You have received 3 Stealth Potions.")
player:GossipComplete()
end
end
end

-- Send a unit yell when the NPC spawns
function Draven.OnSpawn(event, creature)
creature:SendUnitYell("", 0)
creature:CastSpell(creature, 17683, true)
end

-- Register the gossip events with the NPC
RegisterCreatureGossipEvent(400069, 1, Draven.OnGossipHello)
RegisterCreatureGossipEvent(400069, 2, Draven.OnGossipSelect)
RegisterCreatureEvent(400069, 5, Draven.OnSpawn)