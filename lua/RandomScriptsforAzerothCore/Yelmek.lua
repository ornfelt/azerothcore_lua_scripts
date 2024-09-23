local Yelmek = {};

function Yelmek.OnGossipHello(event, player, object)
player:GossipClearMenu()
player:GossipMenuAddItem(0, "What happened here?", 0, 0)
player:GossipSendMenu(1, object)
end

function Yelmek.OnGossipSelect(event, player, object, sender, intid, code, menuid)
if (intid == 0) then
object:SendUnitSay("Man...I really overdid it this time. I don't really want to go into detail...You can see the results for yourself...", 0)
end
end

RegisterCreatureGossipEvent(400062, 1, Yelmek.OnGossipHello)
RegisterCreatureGossipEvent(400062, 2, Yelmek.OnGossipSelect)