-- local isEnabled = true

-- local EQUIP_ITEM_IDS = {800024, 800025, 800026, 800027, 800028, 800029, 800030, 800031, 800032, 800033}
-- local REMOVE_ITEM_IDS = {60202, 60107, 60106, 60105, 60104, 60103, 60102, 60101, 60095, 60094}
-- local BROADCAST_MESSAGE = "The power of both items was too great to wield. Your bracers have been destroyed."
-- local DELAY = 1000

-- local EQUIPMENT_SLOT_TRINKET1 = 12
-- local EQUIPMENT_SLOT_TRINKET2 = 13
-- local EQUIPMENT_SLOT_WRISTS = 8

-- local SPELL_TO_CAST = 13259

-- local function IsInTable(value, table)
--    for _, v in pairs(table) do
--        if v == value then
--            return true
--        end
--    end
--    return false
-- end

-- local function GetEquippedItemIdInSlot(player, slot)
--    local item = player:GetEquippedItemBySlot(slot)
--    if item then
--        return item:GetEntry()
--    end
--    return nil
-- end

-- local function RemoveItemAndNotify(eventId, delay, repeats, player)
--    if player and player:IsInWorld() then
--        local itemId = player:GetData("itemToRemove")
--        if itemId then
--            player:RemoveItem(itemId, 1)
--            player:SendBroadcastMessage(BROADCAST_MESSAGE)
--            player:CastSpell(player, SPELL_TO_CAST, true)
--        end
--    end
-- end

-- local function OnPlayerEquip(event, player, item, bag, slot)
--    if not isEnabled then
--        return
--    end

--    local itemId = item:GetEntry()

--    if IsInTable(itemId, REMOVE_ITEM_IDS) and (IsInTable(GetEquippedItemIdInSlot(player, EQUIPMENT_SLOT_TRINKET1), EQUIP_ITEM_IDS) or IsInTable(GetEquippedItemIdInSlot(player, EQUIPMENT_SLOT_TRINKET2), EQUIP_ITEM_IDS)) then
--        player:SetData("itemToRemove", itemId)
--        player:RegisterEvent(RemoveItemAndNotify, DELAY, 1)
--    end

--    if IsInTable(itemId, EQUIP_ITEM_IDS) and IsInTable(GetEquippedItemIdInSlot(player, EQUIPMENT_SLOT_WRISTS), REMOVE_ITEM_IDS) then
--        local removeItemId = GetEquippedItemIdInSlot(player, EQUIPMENT_SLOT_WRISTS)
--        player:SetData("itemToRemove", removeItemId)
--        player:RegisterEvent(RemoveItemAndNotify, DELAY, 1)
--    end
-- end

-- function EnableOrDisableScript(enable)
--    isEnabled = enable
-- end

-- RegisterPlayerEvent(29, OnPlayerEquip)
