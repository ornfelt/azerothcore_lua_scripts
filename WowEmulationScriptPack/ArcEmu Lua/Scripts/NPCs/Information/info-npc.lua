function ServInfo_OnGossipTalk(Item,_,player)
    ServInfo_OnGossipSelect1(Item,0,player,0,1)
end

function ServInfo_OnGossipSelect1(Item,_, player,_, intid)
    if (intid == 1) then
        Item:GossipCreateMenu(100, player, 0)
        Item:GossipMenuAddItem(0, "Information", 2, 0)
        Item:GossipMenuAddItem(0, "Support Information", 3, 0)
        Item:GossipMenuAddItem(0, "Other Info", 4, 0)
        Item:GossipSendMenu(player)
    end

    if (intid == 2) then
        Item:GossipCreateMenu(100, player, 0)
        Item:GossipMenuAddItem(0, "Website", 10, 0)
        Item:GossipMenuAddItem(0, "Whad do we have on realm?", 11, 0)
        Item:GossipMenuAddItem(0, "Back", 1, 0)
        Item:GossipSendMenu(player)
    end

    if (intid == 3) then
        Item:GossipCreateMenu(100, player, 0)
        Item:GossipMenuAddItem(0, "Support [On-Line]", 12, 0)
        Item:GossipMenuAddItem(0, "Support [OffLine Forums]", 13, 0)
        Item:GossipMenuAddItem(0, "Back", 1, 0)
        Item:GossipSendMenu(player)
    end

    if (intid == 4) then
        Item:GossipCreateMenu(100, player, 0)
        Item:GossipMenuAddItem(0, "Ventrilo Server", 14, 0)
        item:GossipMenuAdditem(0, "Website", 15, 0)
        item:GossipMenuAdditem(0, "Vote", 16, 0)
        item:GossipMenuAdditem(0, "PlayerTools", 17, 0)
        Item:GossipMenuAddItem(0, "Back", 1, 0)
        Item:GossipSendMenu(player)
    end

    if (intid == 10) then
        player:SendBroadcastMessage("If you want to visit our website, and have fun on our forums please visit: *Website*")
        player:GossipComplete()
    end

    if (intid == 11) then
        player:SendBroadcastMessage("Our server is custom one... We have much events and many custom items! Our game masters are really friendly!.")
        player:GossipComplete()
    end

    if (intid == 12) then
        player:SendBroadcastMessage("For GameMaster suppor you have to write "ticket". Gamemaster will help you as soon as he/she can!")
        player:GossipComplete()
    end

    if (intid == 13) then
        player:SendBroadcastMessage("We also have a Support and Bug Reporting section on the forums to report an array of different things")
        player:GossipComplete()
    end

    if (intid == 14) then
        player:SendBroadcastMessage("Our vetrilo servers ip is: *Server IP*")
        player:GossipComplete()
    end
    if (intid == 15) then
        player:SendBroadcastMessage("our website is *Website*")
        player:GossipComplete()
    end
    if (intid == 16) then
        player:SendBroadcastMessage("Do you want to help us? Vote now! *Server Domain*")
        player:GossipComplete()
    end
   
    if (intid == 17) then
        player:SendBroadcastMessage("Do you have any problems in-game and GameMaster can't help you? Get to the *Server Domain*  and your problem will be pass!")
        player:GossipComplete()
    end
end
RegisterItemGossipEvent(*NPC ID*, 1, "ServInfo_OnGossipTalk")
RegisterItemGossipEvent(*NPC ID*, 2, "ServInfo_OnGossipSelect1")