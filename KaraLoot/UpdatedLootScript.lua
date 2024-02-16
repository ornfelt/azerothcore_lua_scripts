local function RemoveItemDelayed(eventId, delay, repeats, player)
    local itemId = player:GetData("temp_itemId")
    local itemCnt = player:GetData("temp_itemCount") -- Storing item count
    if itemId and itemCnt then
        player:RemoveItem(itemId, itemCnt) -- Remove exact item count
        if itemId == 29434 then
            player:SendBroadcastMessage("An unseen force blocked your acquisition of Badges.")
        else
            player:SendBroadcastMessage("The looted item has mysteriously vanished from your bags...the power must've been too great to hold on to...")
        end
        player:SetData("temp_itemId", nil)
        player:SetData("temp_itemCount", nil) -- Clear stored item count
    end
end

local function OnLoot(event, player, item, count)
    local mapId = player:GetMapId()
    local playerLevel = player:GetLevel()
    if mapId == 532 and playerLevel <= 60 then
        local itemId = item:GetEntry()
        if itemId >= 15000 and itemId <= 40000 then
            player:SetData("temp_itemId", itemId)
            player:SetData("temp_itemCount", count) -- Store item count
            player:RegisterEvent(RemoveItemDelayed, 500, 1)
        end
    end
end

RegisterPlayerEvent(32, OnLoot)
