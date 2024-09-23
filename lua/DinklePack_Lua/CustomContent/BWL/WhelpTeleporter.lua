local NefariousWhelpling = {}

NefariousWhelpling.NPC_ID = 400155 -- Nefarious Whelpling
NefariousWhelpling.REWARD_POINTS_ITEM_ID = 37711
NefariousWhelpling.REWARD_POINTS_REQUIRED = 25
NefariousWhelpling.SEARCH_RANGE = 40 -- Change the range as required
NefariousWhelpling.SPELL_TO_CAST = 14867 -- Spell to cast when the player selects "Yes, I'm sure"

function NefariousWhelpling.TeleportToNearestWhelpling(player, creature)
    local creaturesInRange = creature:GetCreaturesInRange(NefariousWhelpling.SEARCH_RANGE, NefariousWhelpling.NPC_ID)
    
    if creaturesInRange and #creaturesInRange > 0 then
        local targetWhelpling = creaturesInRange[1] -- Assuming the target whelpling is the first creature in range
        local mapId = targetWhelpling:GetMapId()
        local x, y, z, o = targetWhelpling:GetLocation()
        
        -- Teleport player to the target whelpling
        player:Teleport(mapId, x, y, z, o)
    else
        print("No whelpling found within range.") -- Debug message
    end
end

function NefariousWhelpling.OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        if player:GetItemCount(NefariousWhelpling.REWARD_POINTS_ITEM_ID) >= NefariousWhelpling.REWARD_POINTS_REQUIRED then
            -- Confirm choice
            player:GossipMenuAddItem(0, "Yes, I'm sure.", 0, 2)
            player:GossipMenuAddItem(0, "No, nevermind.", 0, 3)
            player:GossipSendMenu(2, creature)
        else
            creature:SendUnitSay("Sowwy, you no have enough points.", 0)
            player:GossipComplete()
        end
    elseif intid == 3 then -- Declined choice
        creature:SendUnitSay("Awww, too bad...", 0)
        player:GossipComplete()
    end
end

function NefariousWhelpling.OnConfirmOpenDoor(event, player, creature, sender, intid, code)
    if intid == 2 then -- Confirmed choice
        -- Remove reward points
        player:RemoveItem(NefariousWhelpling.REWARD_POINTS_ITEM_ID, NefariousWhelpling.REWARD_POINTS_REQUIRED)
        -- Cast spell on player
        player:CastSpell(player, NefariousWhelpling.SPELL_TO_CAST)
        -- Send broadcast message
        player:SendBroadcastMessage("You paid the toll of 25 Reward Points.")
        -- Teleport player to the nearest whelpling
        NefariousWhelpling.TeleportToNearestWhelpling(player, creature)
        player:GossipComplete()
    end
end

function NefariousWhelpling.OnGossipHello(event, player, creature)
    if player:IsInCombat() then
        player:SendBroadcastMessage("You cannot speak to this NPC while in combat.")
        player:GossipComplete()
    else
        -- Creature says something before opening the gossip menu
        creature:SendUnitSay("Rawr! You want to get on other side?", 0)
        player:SendBroadcastMessage("Speaking to this whelpling will allow you to bypass gates and potentially skip bosses or the stupid Supression Room.")

        player:GossipMenuAddItem(0, "Teleport to the next whelp for 15 reward points.", 1, 1)
        player:GossipSendMenu(1, creature)
    end
end

RegisterCreatureGossipEvent(NefariousWhelpling.NPC_ID, 1, NefariousWhelpling.OnGossipHello)
RegisterCreatureGossipEvent(NefariousWhelpling.NPC_ID, 2, NefariousWhelpling.OnGossipSelect)
RegisterCreatureGossipEvent(NefariousWhelpling.NPC_ID, 2, NefariousWhelpling.OnConfirmOpenDoor)
