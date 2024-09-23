Thunderhoof = {}

-- Create the item you want to give to the player
Thunderhoof.ITEM_ID = 60111 -- replace with the ID of the item you want to give

-- Register the gossip event for the NPC
function Thunderhoof.OnGossipHello(event, player, creature)
player:GossipMenuAddItem(0, "|TInterface\\Icons\\ability_mount_tawnywindrider:50:50:-13:0|tLoan me a Wind Rider for 25 silver.", 0, 1)
player:GossipSendMenu(1, creature)
end

-- Handle the player's selection in the gossip menu
function Thunderhoof.OnGossipSelect(event, player, creature, sender, action)
if action == 1 then
if player:GetCoinage() < 2500 then
player:SendBroadcastMessage("You do not have enough silver.")
player:GossipComplete()
else
player:SetCoinage(player:GetCoinage() - 2500)
player:AddItem(Thunderhoof.ITEM_ID, 1)
player:SendBroadcastMessage("You have received a Wind Rider.")
player:GossipComplete()
end
end
end

-- Send a unit yell when the NPC spawns
function Thunderhoof.OnSpawn(event, creature)
creature:SendUnitYell("Lend yourself a Wind Rider for 25 silver! You won't want to fight the Scourge without one!", 0)
creature:CastSpell(creature, 20374)
end

-- Register the gossip events with the NPC
RegisterCreatureGossipEvent(400042, 1, Thunderhoof.OnGossipHello)
RegisterCreatureGossipEvent(400042, 2, Thunderhoof.OnGossipSelect)
RegisterCreatureEvent(400042, 5, Thunderhoof.OnSpawn)