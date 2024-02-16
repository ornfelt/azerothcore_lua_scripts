-- By Dinkledork: https://discord.gg/waeFbJBRER
-- This script is used to create a custom event 
-- where players can interact with specific NPCs 
-- (defined by the NPC_IDS list) using a gossip menu. 
-- The event requires players to have a particular item (ITEM_ID) in their inventory. 
-- When the player initiates a gossip interaction with the NPC, 
-- the NPC will say a random battle cry, 
-- equip a random two-handed weapon from the predefined list (mainHandItems), 
-- and move to a random destination chosen from a set of predefined locations (destinations). 


-- Define the NPC IDs to be affected by the script
local NPC_IDS = {400104, 400106, 400108, 400105, 400107, 400109} -- Change me and make sure the npc has gossip menu flags in npcflags under creature_template
-- Define the required item ID for the player to have in order to interact with the npc
local ITEM_ID = 60124
-- Define the gossip menu ID
local GOSSIP_MENU_ID = 1
-- Define the gossip text for the player to see
local GOSSIP_TEXT = "Tell the villager to take up a weapon and meet the Scourge head on."
-- Define the main hand item IDs for NPCs to choose from
local mainHandItems = {6905, 10756, 7717}

-- Gossip hello event function
local function OnGossipHello(event, player, creature)
    -- Check if the player has the required item
    if player:HasItem(ITEM_ID) then
        -- Add the gossip menu item with the specified text
        player:GossipMenuAddItem(0, GOSSIP_TEXT, GOSSIP_MENU_ID, 1)
        -- Send the gossip menu to the player
        player:GossipSendMenu(1, creature)
    else
        -- Send a message to the player that they need the required item
        player:SendBroadcastMessage("You need Horde Armaments!")
    end
end

-- Creature death event function
local function OnCreatureDied(event, creature, killer)
    -- Unregister gossip events for all NPCs in the list so that they can have gossip menus again and start over from original positions without equipped items
    for _, npcId in ipairs(NPC_IDS) do
        UnregisterCreatureGossipEvent(npcId, 1)
        UnregisterCreatureGossipEvent(npcId, 2)
    end
    -- Unregister the death event for the creature (probably unnecessary) 
    UnregisterCreatureEvent(creature:GetEntry(), 4)
end

-- Gossip select event function
local function OnGossipSelect(event, player, creature, sender, intid, code)
    -- Check if the gossip menu item was selected
    if intid == 1 then
        -- Give the player quest credit for the killed creature. This is great if you're using this for a quest. You can leave this as is even without
        player:KilledMonsterCredit(creature:GetEntry())

        -- Define possible messages for the creature to say. You can expand on these and change these as you like.
        local messages = {
            "Lok'tar Ogar! For the Horde!",
            "For our people, we fight!",
            "Together, we shall prevail!",
        }
        -- Choose a random message from the list
        local randomMessage = messages[math.random(#messages)]
        -- Make the creature say the selected message
        creature:SendUnitSay(randomMessage, 0)
        -- Make the creature perform an emote
        creature:EmoteState(375)

        -- Define possible destinations for the creature
        local destinations = {
            {x = -482, y = -2710, z = 94.303, o = 4.2},
            {x = -353, y = -2681, z = 95.88, o = 0.0929},
            {x = -579, y = -2650, z = 95.633, o = 3.12},
            {x = -348, y = -2507, z = 95.563, o = 1.49},
        }
        -- Choose a random destination from the list
        local destination = destinations[math.random(#destinations)]
        -- Calculate random final coordinates within a small range so that npcs don't just show up in the same exact spot
        local finalX = destination.x + math.random(-10, 10)
        local finalY = destination.y + math.random(-10, 10)

       
        -- Make the creature move to the chosen destination
        creature:MoveTo(0, finalX, finalY, destination.z, true)
        -- Calculate random home coordinates within a small range 
        local homeX = finalX + math.random(-10, 10)
        local homeY = finalY + math.random(-10, 10)
        -- Set the home position of the creature so that they don't run back to their original spawn points and instead return to the place they moved to originally
        creature:SetHomePosition(homeX, homeY, destination.z, destination.o)

        -- Choose a random main hand item from the list 
        local randomMainHand = mainHandItems[math.random(#mainHandItems)]
        -- Set the creature's equipment slots with the chosen main hand item
        creature:SetEquipmentSlots(randomMainHand, 0, 0)

        -- Remove the gossip flag from the creature so you can't continue to interact with them
        creature:SetNPCFlags(0)

        -- Remove the required item from the player's inventory *You can just comment this out if you want
        player:RemoveItem(ITEM_ID, 1)
        -- Despawn the creature after 90 seconds which is just useful for quests where players are competing for npcs to talk to and get credit for
        creature:DespawnOrUnsummon(90000)

        -- Complete the gossip interaction
        player:GossipComplete()
    end
end

-- Register gossip and death events for all NPCs in the list
for _, npcId in ipairs(NPC_IDS) do
    RegisterCreatureGossipEvent(npcId, 1, OnGossipHello)
    RegisterCreatureGossipEvent(npcId, 2, OnGossipSelect)
    RegisterCreatureEvent(npcId, 4, OnCreatureDied)
end
