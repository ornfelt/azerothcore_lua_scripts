Bonk = {}

-- Create the item you want to give to the player
Bonk.ITEM_ID = 60112 -- replace with the ID of the item you want to give
Bonk.ITEM_ID2 = 37500 -- replace with the ID of the new item you want to give

-- Register the gossip event for the NPC
function Bonk.OnGossipHello(event, player, creature)
player:GossipMenuAddItem(0, "|TInterface\\Icons\\ability_druid_flightform:50:50:-13:0|tMech Wings for 75 silver.", 0, 1)
player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_misc_key_14:50:50:-13:0|tKeys to a Shredder for 45 silver.", 0, 2)
player:GossipSendMenu(1, creature)
end

function Bonk.OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        if player:GetCoinage() < 7500 then
            player:SendBroadcastMessage("You don't have enough coins.")
            player:GossipComplete()
        else
            player:SetCoinage(player:GetCoinage() - 7500)
            player:AddItem(Bonk.ITEM_ID, 1)
            player:SendBroadcastMessage("You have received Mech Wings.")
            player:GossipComplete()
        end
    elseif intid == 2 then
        if player:GetCoinage() < 4500 then
            player:SendBroadcastMessage("You don't have enough coins.")
            player:GossipComplete()
        else
            player:SetCoinage(player:GetCoinage() - 4500)
            player:AddItem(Bonk.ITEM_ID2, 1)
            player:SendBroadcastMessage("You have received keys to a Refurbished Shredder.")
            player:GossipComplete()
        end
    end
end



-- Send a unit yell when the NPC spawns
function Bonk.OnSpawn(event, creature)
creature:SendUnitYell("Step right up! I've got Mech Wings and keys to Refurbished Shredders!", 0)
creature:CastSpell(creature, 20374)
end

-- Register the gossip events with the NPC
RegisterCreatureGossipEvent(400043, 1, Bonk.OnGossipHello)
RegisterCreatureGossipEvent(400043, 2, Bonk.OnGossipSelect)
RegisterCreatureEvent(400043, 5, Bonk.OnSpawn)