local SocketExchanger = {}

SocketExchanger.NPC_ID = 190015
SocketExchanger.SOCKET_ENCHANT_ID = 37430
SocketExchanger.REQUIRED_ITEM_ID = 17010
SocketExchanger.REQUIRED_ITEM_AMOUNT = 10
SocketExchanger.exchangeCount = 0

function SocketExchanger.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_misc_gem_variety_01:50:50:-43:0|tPurchase gem sockets for your gear?", 0, 1)
    player:GossipSendMenu(1, creature)
end

function SocketExchanger.OnGossipSelect(event, player, creature, sender, intid, code, menuid)
    if (intid == 1) then
        local requiredAmount = SocketExchanger.REQUIRED_ITEM_AMOUNT
        creature:SendUnitSay("Exchanging " .. requiredAmount .. " Fiery Cores for a socket enchant. Are you sure, " .. player:GetName() .. "?", 0)
        player:GossipMenuAddItem(0, "Yes", 0, 2)
        player:GossipMenuAddItem(0, "No", 0, 3)
        player:GossipSendMenu(1, creature)
    elseif (intid == 2) then
        if (player:GetItemCount(SocketExchanger.REQUIRED_ITEM_ID) >= SocketExchanger.REQUIRED_ITEM_AMOUNT) then
            player:RemoveItem(SocketExchanger.REQUIRED_ITEM_ID, SocketExchanger.REQUIRED_ITEM_AMOUNT)
            player:AddItem(SocketExchanger.SOCKET_ENCHANT_ID, 1)
            creature:SendUnitSay("The socket enchant has been added to your inventory.", 0)
            SocketExchanger.exchangeCount = SocketExchanger.exchangeCount + 1
            if (SocketExchanger.exchangeCount >= 3) then
                creature:SendUnitSay("Thanks a bunch! See you next week!", 0)
                creature:DespawnOrUnsummon(1000)
            end
            player:GossipComplete()
        else
            creature:SendUnitSay("You do not have enough Fiery Cores.", 0)
            player:GossipComplete()
        end
    elseif (intid == 3) then
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(SocketExchanger.NPC_ID, 1, SocketExchanger.OnGossipHello)
RegisterCreatureGossipEvent(SocketExchanger.NPC_ID, 2, SocketExchanger.OnGossipSelect)
