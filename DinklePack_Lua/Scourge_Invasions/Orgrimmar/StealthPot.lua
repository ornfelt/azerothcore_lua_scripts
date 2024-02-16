local DravenTwo = {}

DravenTwo.NPC_ID = 400069
DravenTwo.ITEM_ID = 60114

function DravenTwo.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "|TInterface\\Icons\\ability_stealth:50:50:-23:0|tPurchase 3 Stealth Potions for 75 Silver.|r", 0, 1)
    player:GossipSendMenu(1, creature)
end

function DravenTwo.OnGossipSelect(event, player, creature, sender, action)
    if action == 1 then
        if player:GetCoinage() < 7500 then
            player:SendBroadcastMessage("You do not have enough coins.")
            player:GossipComplete()
        else
            player:SetCoinage(player:GetCoinage() - 7500)
            player:AddItem(DravenTwo.ITEM_ID, 3)
            player:SendBroadcastMessage("You have received 3 Stealth Potions.")
            player:GossipComplete()
        end
    end
end

function DravenTwo.OnSpawn(event, creature)
    creature:CastSpell(creature, 17683, true)
end

RegisterCreatureGossipEvent(DravenTwo.NPC_ID, 1, DravenTwo.OnGossipHello)
RegisterCreatureGossipEvent(DravenTwo.NPC_ID, 2, DravenTwo.OnGossipSelect)
RegisterCreatureEvent(DravenTwo.NPC_ID, 5, DravenTwo.OnSpawn)
