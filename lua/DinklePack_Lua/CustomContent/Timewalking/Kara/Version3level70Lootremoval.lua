local LootControl = {}

LootControl.EVENT_IDS = {
    ON_LOOT = {53, 32, 56}
}

LootControl.MAP_ID = 532
LootControl.PLAYER_LEVEL = 60
LootControl.ITEM_ID_RANGE = {10000, 40000}

function LootControl.RemoveItems(eventId, delay, repeats, player)
    local lootTable = player:GetData("temp_lootTable")
    if lootTable then
        for _, loot in ipairs(lootTable) do
            player:RemoveItem(loot.itemID, loot.itemCount)
            if loot.itemID == 29434 then
                player:SendBroadcastMessage("An unseen force blocked your acquisition of Badges.")
            else
                player:SendBroadcastMessage("The looted item has mysteriously vanished from your bags...the power must've been too great to hold on to...")
            end
        end
        player:SetData("temp_lootTable", {})
    end
end

function LootControl.OnLoot(event, player, item, count)
    local mapId = player:GetMapId()
    local playerLevel = player:GetLevel()
    if mapId == LootControl.MAP_ID and playerLevel <= LootControl.PLAYER_LEVEL then
        local itemId = item:GetEntry()
        if itemId >= LootControl.ITEM_ID_RANGE[1] and itemId <= LootControl.ITEM_ID_RANGE[2] then
            local lootTable = player:GetData("temp_lootTable") or {}
            table.insert(lootTable, {itemID = itemId, itemCount = count})

            player:SetData("temp_lootTable", lootTable)
            if not player:GetData("removeItemsEventStarted") then
                local eventId = player:RegisterEvent(LootControl.RemoveItems, 50, 0)
                player:SetData("removeItemsEventId", eventId)
                player:SetData("removeItemsEventStarted", true)
            end
        end
    end
end

for _, event in ipairs(LootControl.EVENT_IDS.ON_LOOT) do
    RegisterPlayerEvent(event, LootControl.OnLoot)
end
