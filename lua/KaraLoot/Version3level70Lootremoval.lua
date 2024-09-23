local function RemoveItems(eventId, delay, repeats, player)
    if player:GetData("logout_flag") then
        return
    end

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
        -- Clear the loot table
        player:SetData("temp_lootTable", {})
    end
end

local function OnLoot(event, player, item, count)
    local mapId = player:GetMapId()
    local playerLevel = player:GetLevel()
    if mapId == 532 and playerLevel <= 60 then
        local itemId = item:GetEntry()
        if itemId >= 15000 and itemId <= 40000 then
            -- Get the loot table (or create it if it doesn't exist)
            local lootTable = player:GetData("temp_lootTable") or {}
            -- Add the new item to the loot table
            table.insert(lootTable, {itemID = itemId, itemCount = count})
            -- Store the updated loot table
            player:SetData("temp_lootTable", lootTable)
        end
    end
end

local function OnLogin(event, player)
    player:SetData("logout_flag", false)
    -- Register a periodic event to remove looted items every 1 second
    player:RegisterEvent(RemoveItems, 1000, 0)
end

local function OnLogout(event, player)
    player:SetData("logout_flag", true)
end

RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(4, OnLogout)
--RegisterPlayerEvent(52, OnLoot)
RegisterPlayerEvent(53, OnLoot)
RegisterPlayerEvent(32, OnLoot)
RegisterPlayerEvent(56, OnLoot)
