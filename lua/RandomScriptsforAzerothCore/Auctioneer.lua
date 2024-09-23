local Auctioneer = {};

function Auctioneer.OnGossipHello(event, player, object)
player:GossipClearMenu()
player:GossipMenuAddItem(0, "What happened here?", 0, 0)
player:GossipSendMenu(1, object)
end

function Auctioneer.OnGossipSelect(event, player, object, sender, intid, code, menuid)
if (intid == 0) then
object:SendUnitSay("Big block of ice came tumbling out of the sky and smacked right into the Auctionhouse. We're lucky we even made it out alive...", 0)
end
end

RegisterCreatureGossipEvent(400063, 1, Auctioneer.OnGossipHello)
RegisterCreatureGossipEvent(400063, 2, Auctioneer.OnGossipSelect)