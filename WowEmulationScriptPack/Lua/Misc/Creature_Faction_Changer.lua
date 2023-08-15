local npcid = 14121
local MenuId = 14121
 
local function GossipHelloThere(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem(10, "|TInterface/icons/INV_Misc_Gift_01:35|t|r Character Name Change", 0, 2)
    player:GossipMenuAddItem(10, "|TInterface/icons/INV_Misc_Gift_02:35|t|r Character My Appearance", 0, 3)
    player:GossipMenuAddItem(10, "|TInterface/icons/INV_Misc_Gift_03:35|t|r Character Race Change", 0, 4)
    player:GossipMenuAddItem(10, "|TInterface/icons/INV_Misc_Gift_04:35|t|r Change Faction Change", 0, 5)
    player:GossipSendMenu(1, object, MenuId)
end
 
local function GossipSelectThere(event, player, object, sender, intid, code, menu_id)
    if (intid == 2) then
        player:SetAtLoginFlag(1)
        player:SendBroadcastMessage("Relog")
        player:GossipSendMenu(1, object, MenuId)
        player:GossipComplete()
    end
    if (intid == 3) then
        player:SetAtLoginFlag(8)
        player:SendBroadcastMessage("Relog")
        player:GossipSendMenu(1, object, MenuId)
        player:GossipComplete()
    end
    if (intid == 4) then
        player:SetAtLoginFlag(128)
        player:SendBroadcastMessage("Relog")
        player:GossipSendMenu(1, object, MenuId)
        player:GossipComplete()
    end
    if (intid == 5) then
        player:SetAtLoginFLag(64)
        player:SendBroadcastMessage("Relog")
        player:GossipSendMenu(1, object, MenuId)
        player:GossipComplete()
    end
end
 
RegisterCreatureGossipEvent(npcid, 1, GossipHelloThere)
RegisterCreatureGossipEvent(npcid, 2, GossipSelectThere)