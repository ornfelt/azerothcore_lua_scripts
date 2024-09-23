--Credits to Dinkledork.
--I created this script to be used in a quest to calm down some frantic stormwind citizens. If player has specified item, can interact with specified 
--npc and select the gossip item that gives the player kill credit. Npc despawns after 5 seconds.

local npcid = 400028 --npc required for quest. Must have a gossip menu flag and be friendly
local gossipText = "Get the Stormwind Citizen to calm down..." --Gossip dialogue. Change to Whatever
local itemId = 60083 --Required item to interact with the npc. Can set to a given quest item. Item will be consumed on use
local spellId = 139 --Visual effect spell to be cast on npc

-- This function is called when the player first interacts with the NPC
local function OnGossipHello(event, player, creature)
-- Check if the player has the necessary item
if (player:HasItem(itemId)) then
-- Add the option to the gossip menu
player:GossipMenuAddItem(0, gossipText, 0, 1)
-- Send the gossip menu to the player
player:GossipSendMenu(1, creature)
else
-- Send an error message to the player if they don't have the necessary item
player:SendBroadcastMessage("You do not have the necessary item to calm the citizen.") --can change error message to whatever you want
end 
end

-- This function is called when the player selects an option from the gossip menu
local function OnGossipSelect(event, player, creature, sender, intid, code)
-- Check if the selected option is the one we added in OnGossipHello
if (intid == 1) then
-- Remove the item from the player's inventory
player:RemoveItem(itemId, 1)
-- Remove all auras from the NPC. Important since they have a fear aura.
creature:RemoveAllAuras()
-- Give credit to the player for killing the NPC. Important for quest credit. The NPC literally dies.
player:KilledMonsterCredit(npcid)
-- Cast the spell on the NPC for visual effect.
creature:CastSpell(creature, spellId, true)
-- Choose a random dialogue for the NPC to say after interacting
local randomDialogue = math.random(1, 3)
if randomDialogue == 1 then
creature:SendUnitSay("Oh, thank you for helping me come to my senses...I should be going now...", 0) --dialogue 1
elseif randomDialogue == 2 then
creature:SendUnitSay("Thank you so much! I feel much better now...", 0) --dialogue 2
else
creature:SendUnitSay("I can finally think clearly again, thank you!", 0) --dialogue 3
end
-- Close the gossip menu
player:GossipComplete()
-- Despawn the NPC after a 5 second delay
creature:DespawnOrUnsummon(5000)
end
end

-- Register the gossip events for the NPC
RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)
