local g_CustomDiffFactor = 3

local function OnGossipHello(event, player, object)
    for i = 1, 10 do
        player:GossipMenuAddItem(0, "Set difficulty factor to " .. i, 0, i)
    end
    player:GossipSendMenu(1, object)
end

local function OnGossipSelect(event, player, object, sender, intid, code, menu_id)
    SetGlobalVariable("g_CustomDiffFactor", intid)
    player:SendBroadcastMessage("Difficulty factor set to " .. intid)
    player:GossipComplete()
end

RegisterCreatureGossipEvent(400031, 1, OnGossipHello)
RegisterCreatureGossipEvent(400031, 2, OnGossipSelect)
