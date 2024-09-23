local StormwindCitizen = {}

StormwindCitizen.NPC_ID = 400028
StormwindCitizen.ITEM_ID = 60083 -- Soothing spices as a test, required to interact with the npc. Can set to a given quest item.
StormwindCitizen.SPELL_ID = 139

local gossipText = "Get the Stormwind Citizen to calm down..."

-- This function is called when the player first interacts with the NPC
function StormwindCitizen.OnGossipHello(event, player, creature)
    -- Check if the player has the necessary item
    if (player:HasItem(StormwindCitizen.ITEM_ID)) then
        -- Add the option to the gossip menu
        player:GossipMenuAddItem(0, gossipText, 0, 1)
        -- Send the gossip menu to the player
        player:GossipSendMenu(1, creature)
    else
        -- Send an error message to the player if they don't have the necessary item
        player:SendBroadcastMessage("They aren't responding to anything...Maybe you should go ask Arch Bishop Benedictus for help at the Cathedral of Light.")
    end
end

-- This function is called when the player selects an option from the gossip menu
function StormwindCitizen.OnGossipSelect(event, player, creature, sender, intid, code)
    -- Check if the selected option is the one we added in OnGossipHello
    if (intid == 1) then
        -- Remove the item from the player's inventory
        player:RemoveItem(StormwindCitizen.ITEM_ID, 1)
        -- Remove all auras from the NPC. Important since they have a fear aura.
        creature:RemoveAllAuras()
        -- Give credit to the player for killing the NPC. Important for quest credit. The NPC literally dies.
        player:KilledMonsterCredit(StormwindCitizen.NPC_ID)
        -- Cast the spell on the NPC for visual effect.
        creature:CastSpell(creature, StormwindCitizen.SPELL_ID, true)
        -- Choose a random dialogue for the NPC to say after interacting
        local randomDialogue = math.random(1, 3)
        if randomDialogue == 1 then
            creature:SendUnitSay("Oh, thank you for helping me come to my senses...I should be going now...", 0)
        elseif randomDialogue == 2 then
            creature:SendUnitSay("Thank you so much! I feel much better now...", 0)
        else
            creature:SendUnitSay("I can finally think clearly again, thank you!", 0)
        end
        -- Close the gossip menu
        player:GossipComplete()
        -- Despawn the NPC after a 5 second delay
        creature:DespawnOrUnsummon(5000)
    end
end

-- Register the gossip events for the NPC
RegisterCreatureGossipEvent(StormwindCitizen.NPC_ID, 1, StormwindCitizen.OnGossipHello)
RegisterCreatureGossipEvent(StormwindCitizen.NPC_ID, 2, StormwindCitizen.OnGossipSelect)
