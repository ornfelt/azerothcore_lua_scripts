local KarazhanTeleporter = {}

KarazhanTeleporter.NPC_ID = 90009
KarazhanTeleporter.GOSSIP_ICON = 0
KarazhanTeleporter.KARAZHAN_MAP_ID = 532
KarazhanTeleporter.KARAZHAN_X = -11089.735
KarazhanTeleporter.KARAZHAN_Y = -1988.7
KarazhanTeleporter.KARAZHAN_Z = 49.755
KarazhanTeleporter.KARAZHAN_ORIENTATION = 6

function KarazhanTeleporter.OnGossipHello(event, player, object)
    player:GossipClearMenu()

    -- Check player level
    local playerLevel = player:GetLevel()
    if playerLevel >= 61 and playerLevel <= 80 then
        player:SendBroadcastMessage("You must be level 60 to access this feature.")
        return
    end

    -- Add teleport option
    player:GossipMenuAddItem(KarazhanTeleporter.GOSSIP_ICON, "Teleport me to Karazhan.", 0, 1)

    player:GossipSendMenu(1, object)
end

function KarazhanTeleporter.OnGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then
        -- Teleport the player to Karazhan
        player:Teleport(KarazhanTeleporter.KARAZHAN_MAP_ID, KarazhanTeleporter.KARAZHAN_X, KarazhanTeleporter.KARAZHAN_Y, KarazhanTeleporter.KARAZHAN_Z, KarazhanTeleporter.KARAZHAN_ORIENTATION)
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(KarazhanTeleporter.NPC_ID, 1, KarazhanTeleporter.OnGossipHello)
RegisterCreatureGossipEvent(KarazhanTeleporter.NPC_ID, 2, KarazhanTeleporter.OnGossipSelect)
