function LvlNpc_OnGossip(Unit, Event, Player)
Unit:GossipCreateMenu(100, Player, 0)
Unit:GossipMenuAddItem(0, "Send me to Hijal as a level 1 rember you can change it back later if you want!", 1, 0)
Unit:GossipMenuAddItem(0, "Send me to the quest area as a level 80.", 2, 0)
Unit:GossipSendMenu(Player)
end

function LvlNpc_OnSelect(Unit, Event, Player, MenuId, id, Code)
if (id == 1) then
Player:SetPlayerLevel(1)
Player:Teleport(1, 4621.727051, -3847.794434, 943.917114)
Unit:GossipComplete(Player)
end

if (id == 2) then
Player:SetPlayerLevel(80)
Player:Teleport(1, 16222.986328, 15724.786133, 4.167824)
Unit:GossipComplete(Player)
end
end

RegisterUnitGossipEvent(10000000, 1, "LvlNpc_OnGossip")
RegisterUnitGossipEvent(10000000, 2, "LvlNpc_OnSelect")
