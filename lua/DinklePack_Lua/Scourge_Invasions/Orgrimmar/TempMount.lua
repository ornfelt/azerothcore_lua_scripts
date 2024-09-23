local ThunderhoofBoo = {}

ThunderhoofBoo.NPC_ID = 400042 
ThunderhoofBoo.ITEM_ID = 60111 

function ThunderhoofBoo.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "|TInterface\\Icons\\ability_mount_tawnywindrider:50:50:-13:0|tLoan me a Wind Rider for 25 silver.", 0, 1)
    player:GossipSendMenu(1, creature)
end

function ThunderhoofBoo.OnGossipSelect(event, player, creature, sender, action)
    if action == 1 then
        if player:GetCoinage() < 2500 then
            player:SendBroadcastMessage("You do not have enough silver.")
            player:GossipComplete()
        else
            player:SetCoinage(player:GetCoinage() - 2500)
            player:AddItem(ThunderhoofBoo.ITEM_ID, 1)
            player:SendBroadcastMessage("You have received a Wind Rider.")
            player:GossipComplete()
        end
    end
end

function ThunderhoofBoo.OnSpawn(event, creature)
    creature:SendUnitYell("Lend yourself a Wind Rider for 25 silver! You won't want to fight the Scourge without one!", 0)
    creature:CastSpell(creature, 20374)
end

RegisterCreatureGossipEvent(ThunderhoofBoo.NPC_ID, 1, ThunderhoofBoo.OnGossipHello)
RegisterCreatureGossipEvent(ThunderhoofBoo.NPC_ID, 2, ThunderhoofBoo.OnGossipSelect)
RegisterCreatureEvent(ThunderhoofBoo.NPC_ID, 5, ThunderhoofBoo.OnSpawn)
