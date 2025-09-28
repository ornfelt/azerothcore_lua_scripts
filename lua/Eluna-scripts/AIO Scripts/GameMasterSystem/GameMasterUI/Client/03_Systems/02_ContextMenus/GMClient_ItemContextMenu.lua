local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local PlayerInventory = _G.PlayerInventory
if not PlayerInventory then
    print("[ERROR] PlayerInventory namespace not found! Check load order.")
    return
end

-- Debug: Confirm this file is loading
print("[PlayerInventory] ItemContextMenu module loading...")

local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig

-- ================================================================================
-- ITEM CONTEXT MENU FUNCTIONS
-- This module provides item-specific context menu functionality including:
-- - Empty slot context menus
-- - Item action context menus
-- - Item management dialogs
-- ================================================================================

-- Show context menu for empty slots
function PlayerInventory.showEmptySlotContextMenu(slot, isEquipment)
    -- Close any existing context menu first
    PlayerInventory.closeContextMenu()
    
    local menuItems = {
        { text = "Empty Slot Actions", isTitle = true }
    }
    
    -- Add separator
    table.insert(menuItems, { text = "", disabled = true, notCheckable = true })
    
    -- Main action - search and add items
    table.insert(menuItems, {
        text = "Search Items...",
        icon = "Interface\\Icons\\INV_Misc_Spyglass_03",
        func = function()
            -- Determine slot restrictions for equipment
            local slotRestriction = nil
            if isEquipment and slot.slotId then
                slotRestriction = slot.slotId
            end
            
            -- Show item search dialog
            if PlayerInventory.showItemSearchDialog then
                PlayerInventory.showItemSearchDialog(slot, isEquipment)
            else
                print("|cffff0000Item search dialog not yet implemented|r")
            end
        end
    })
    
    -- Quick add common items submenu
    local quickAddItems = {}
    
    if isEquipment then
        -- Add equipment-appropriate quick items based on slot
        if slot.slotId == 15 then -- Main hand
            table.insert(quickAddItems, { text = "Shadowmourne", itemId = 49623 })
            table.insert(quickAddItems, { text = "Val'anyr", itemId = 46017 })
            table.insert(quickAddItems, { text = "Thunderfury", itemId = 19019 })
        elseif slot.slotId == 4 then -- Chest
            table.insert(quickAddItems, { text = "Sanctified Ymirjar Lord's Battleplate", itemId = 51227 })
            table.insert(quickAddItems, { text = "Sanctified Frost Witch's Tunic", itemId = 51200 })
        elseif slot.slotId == 0 then -- Head
            table.insert(quickAddItems, { text = "Sanctified Ymirjar Lord's Helmet", itemId = 51226 })
            table.insert(quickAddItems, { text = "Sanctified Frost Witch's Helm", itemId = 51202 })
        end
    else
        -- Add common consumables for inventory
        table.insert(quickAddItems, { text = "Flask of Endless Rage", itemId = 46377 })
        table.insert(quickAddItems, { text = "Potion of Speed", itemId = 40211 })
        table.insert(quickAddItems, { text = "Fish Feast", itemId = 43015 })
        table.insert(quickAddItems, { text = "Heavy Frostweave Bandage", itemId = 34722 })
        table.insert(quickAddItems, { text = "Runic Mana Potion", itemId = 33448 })
    end
    
    -- Create quick add submenu
    if #quickAddItems > 0 then
        local quickAddMenu = {}
        for _, item in ipairs(quickAddItems) do
            table.insert(quickAddMenu, {
                text = item.text,
                icon = "Interface\\Icons\\INV_Misc_QuestionMark",  -- Default icon
                func = function()
                    -- Add item to the specific slot
                    local targetBag = slot.bagId or 0
                    local targetSlot = slot.slotId or 0
                    
                    if isEquipment then
                        -- For equipment, equip directly
                        AIO.Handle("GameMasterSystem", "equipItemById", 
                            PlayerInventory.currentPlayerName, item.itemId, slot.slotId)
                        print(string.format("Equipping %s to slot %d", item.text, slot.slotId))
                    else
                        -- For inventory, add to specific bag/slot
                        AIO.Handle("GameMasterSystem", "addItemToSpecificSlot", 
                            PlayerInventory.currentPlayerName, item.itemId, 1, targetBag, targetSlot)
                        print(string.format("Adding %s to bag %d slot %d", item.text, targetBag, targetSlot))
                    end
                    -- Server will send refreshInventoryDisplay to update the UI
                end
            })
        end
        
        table.insert(menuItems, {
            text = "Quick Add",
            icon = "Interface\\Icons\\INV_Misc_Gift_01",
            hasArrow = true,
            menuList = quickAddMenu
        })
    end
    
    -- Add custom item by ID
    table.insert(menuItems, {
        text = "Add by Item ID...",
        icon = "Interface\\Icons\\INV_Misc_Note_01",
        func = function()
            PlayerInventory.showAddItemByIdDialog(slot, isEquipment)
        end
    })
    
    -- Store the menu reference
    PlayerInventory.currentContextMenu = PlayerInventory.showContextMenuWithSmartPositioning(menuItems, slot)
end

-- Show context menu for inventory items
function PlayerInventory.showItemContextMenu(slot, itemData, isEquipment)
    if not itemData or not itemData.entry then return end
    
    -- Debug: Confirm real function is being called
    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print("[PlayerInventory] Real showItemContextMenu called!")
    end
    
    -- Debug: Check itemData contents for custom bags
    if GMConfig.config.debug and itemData.bag and itemData.bag >= 1500 then
        print(string.format("[PlayerInventory] Context menu for custom bag item: %s", itemData.name or "Unknown"))
        print(string.format("[PlayerInventory]   Bag: %d, Slot: %d", itemData.bag, itemData.slot or 0))
        print(string.format("[PlayerInventory]   itemGuid: %s", tostring(itemData.itemGuid)))
        print(string.format("[PlayerInventory]   All fields: entry=%s, count=%s, quality=%s", 
            tostring(itemData.entry), tostring(itemData.count), tostring(itemData.quality)))
    end
    
    -- Close any existing context menu first
    PlayerInventory.closeContextMenu()
    
    local menuItems = {
        { text = string.format("%s Actions", isEquipment and "Equipment" or "Item"), isTitle = true },
        { text = string.format("ID: %d | %s", itemData.entry, itemData.name or "Unknown"), isTitle = true, notCheckable = true }
    }
    
    -- Add separator
    table.insert(menuItems, { text = "", disabled = true, notCheckable = true })
    
    if isEquipment then
        -- Equipment-specific actions
        table.insert(menuItems, {
            text = "Unequip Item",
            icon = "Interface\\Icons\\INV_Misc_Bag_08",
            func = function()
                AIO.Handle("GameMasterSystem", "unequipPlayerItem", PlayerInventory.currentPlayerName, slot.slotId)
                print(string.format("Unequipping item from slot %d", slot.slotId))
            end
        })
        
        table.insert(menuItems, {
            text = "Repair Item",
            icon = "Interface\\Icons\\Trade_BlackSmithing",
            func = function()
                AIO.Handle("GameMasterSystem", "repairPlayerItem", PlayerInventory.currentPlayerName, slot.slotId, true)
                print("Repairing item...")
            end
        })
    else
        -- Inventory item actions
        if itemData.equipable then
            table.insert(menuItems, {
                text = "Equip Item",
                icon = "Interface\\Icons\\INV_Chest_Chain",
                func = function()
                    AIO.Handle("GameMasterSystem", "equipPlayerItem", PlayerInventory.currentPlayerName, itemData.bag, itemData.slot)
                    print("Equipping item...")
                end
            })
        end
        
        if itemData.count and itemData.count > 1 then
            table.insert(menuItems, {
                text = "Split Stack",
                icon = "Interface\\Icons\\INV_Misc_Coin_01",
                func = function()
                    PlayerInventory.showSplitStackDialog(itemData)
                end
            })
            
            table.insert(menuItems, {
                text = "Modify Stack Count",
                icon = "Interface\\Icons\\INV_Misc_Note_01",
                func = function()
                    PlayerInventory.showModifyStackDialog(itemData)
                end
            })
        end
    end
    
    -- Common actions for both equipment and inventory
    table.insert(menuItems, { text = "", disabled = true, notCheckable = true }) -- Separator
    
    -- Enchantment submenu
    table.insert(menuItems, {
        text = "Enchantments",
        icon = "Interface\\Icons\\INV_Enchant_DustPrismatic",
        hasArrow = true,
        menuList = PlayerInventory.createEnchantmentMenu(itemData, isEquipment, slot)
    })
    
    table.insert(menuItems, {
        text = "Duplicate Item",
        icon = "Interface\\Icons\\INV_Misc_Gift_01",
        func = function()
            local count = itemData.count or 1
            AIO.Handle("GameMasterSystem", "duplicatePlayerItem", PlayerInventory.currentPlayerName, itemData.entry, count)
            print(string.format("Duplicating %dx %s", count, itemData.name or "item"))
        end
    })
    
    -- Add More submenu with target selection
    local _, _, _, _, _, _, _, itemStackCount = GetItemInfo(itemData.entry)
    local maxStack = itemStackCount or 20  -- Default to 20 if not found
    
    -- Get self name and current player name
    local selfName = UnitName("player")
    local targetName = PlayerInventory.currentPlayerName
    local isSelf = (selfName == targetName)
    
    -- Helper function to create add options for a target
    local function createAddOptions(target)
        local options = {
            {
                text = "Add x1",
                icon = "Interface\\Icons\\INV_Misc_Coin_01",
                func = function()
                    AIO.Handle("GameMasterSystem", "addItemToPlayer", 
                        target, itemData.entry, 1)
                    print(string.format("Adding 1x %s to %s", itemData.name or "item", target))
                    PlayerInventory.closeContextMenu()
                end
            },
            {
                text = string.format("Add Stack (x%d)", maxStack),
                icon = "Interface\\Icons\\INV_Misc_Coin_02",
                func = function()
                    AIO.Handle("GameMasterSystem", "addItemToPlayer", 
                        target, itemData.entry, maxStack)
                    print(string.format("Adding %dx %s to %s", maxStack, itemData.name or "item", target))
                    PlayerInventory.closeContextMenu()
                end
            }
        }
        
        -- Add custom amount option
        table.insert(options, { text = "", disabled = true, notCheckable = true }) -- Separator
        table.insert(options, {
            text = "Custom Amount...",
            icon = "Interface\\Icons\\INV_Misc_Note_01",
            func = function()
                PlayerInventory.showAddItemDialog(itemData, target)
            end
        })
        
        return options
    end
    
    -- Build the Add More menu structure
    local addMoreMenuItems = {}
    
    if isSelf then
        -- If viewing own inventory, just show direct options
        addMoreMenuItems = createAddOptions(selfName)
    else
        -- If viewing another player's inventory, show both options
        table.insert(addMoreMenuItems, {
            text = "Add to Self",
            icon = "Interface\\Icons\\INV_Misc_Gift_02",
            hasArrow = true,
            menuList = createAddOptions(selfName)
        })
        
        table.insert(addMoreMenuItems, {
            text = string.format("Add to %s", targetName or "Player"),
            icon = "Interface\\Icons\\INV_Misc_Gift_01",
            hasArrow = true,
            menuList = createAddOptions(targetName)
        })
    end
    
    table.insert(menuItems, {
        text = "Add More",
        icon = "Interface\\Icons\\Spell_ChargePositive",
        hasArrow = true,
        menuList = addMoreMenuItems
    })
    
    table.insert(menuItems, {
        text = "Mail to Player",
        icon = "Interface\\Icons\\INV_Letter_01",
        func = function()
            PlayerInventory.showMailItemDialog(itemData)
        end
    })
    
    table.insert(menuItems, {
        text = "View Stats",
        icon = "Interface\\Icons\\INV_Misc_Note_02",
        func = function()
            PlayerInventory.showItemStatsDialog(itemData)
        end
    })
    
    -- Add separator before delete
    table.insert(menuItems, { text = "", disabled = true, notCheckable = true })
    
    -- Delete action (last item, with warning color)
    table.insert(menuItems, {
        text = "|cffff0000Delete Item|r",
        icon = "Interface\\Icons\\INV_Misc_Bomb_02",
        func = function()
            PlayerInventory.showDeleteConfirmDialog(itemData, isEquipment, slot)
        end
    })
    
    -- Store the menu reference
    PlayerInventory.currentContextMenu = PlayerInventory.showContextMenuWithSmartPositioning(menuItems, slot)
end

-- Dialog for adding item by ID to empty slot
function PlayerInventory.showAddItemByIdDialog(slot, isEquipment)
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Add Item by ID",
        message = isEquipment and 
            string.format("Enter item ID to equip in %s slot:", 
                PlayerInventory.INVENTORY_CONFIG.EQUIPMENT_SLOTS[slot.slotId] or "equipment") or
            -- Display 1-based slot number to user (internal is 0-based)
            string.format("Enter item ID to add to bag %d, slot %d:", 
                slot.bagId or 0, (slot.slotId or 0) + 1),
        placeholder = "Enter item ID...",
        numeric = true,
        buttons = {
            {
                text = "Add",
                onClick = function(dialog, inputText)
                    local itemId = tonumber(inputText)
                    if itemId and itemId > 0 then
                        if isEquipment then
                            -- For equipment, equip directly
                            AIO.Handle("GameMasterSystem", "equipItemById", 
                                PlayerInventory.currentPlayerName, itemId, slot.slotId)
                            print(string.format("Equipping item %d to slot %d", itemId, slot.slotId))
                        else
                            -- For inventory, add to specific bag/slot
                            AIO.Handle("GameMasterSystem", "addItemToSpecificSlot", 
                                PlayerInventory.currentPlayerName, itemId, 1, 
                                slot.bagId or 0, slot.slotId or 0)
                            print(string.format("Adding item %d to bag %d slot %d", 
                                itemId, slot.bagId or 0, slot.slotId or 0))
                        end
                        dialog:Hide()
                        -- Server will send refreshInventoryDisplay to update the UI
                    else
                        print("|cffff0000Invalid item ID!|r")
                    end
                end
            },
            {
                text = "Cancel",
                onClick = function(dialog) dialog:Hide() end
            }
        }
    })
    PlayerInventory.closeContextMenu()
    dialog:Show()
end

-- ================================================================================
-- FORWARD DECLARATIONS FOR DIALOGS
-- These functions are implemented in other modules but referenced here
-- ================================================================================

-- Forward declaration for Add Item dialog
if not PlayerInventory.showAddItemDialog then
    PlayerInventory.showAddItemDialog = function(itemData, targetPlayer)
        -- Use the target player if provided, otherwise fall back to current player
        local target = targetPlayer or PlayerInventory.currentPlayerName
        
        -- Use the CreateInputDialog helper function
        local dialog = PlayerInventory.CreateInputDialog({
            title = "Add More Items",
            message = string.format("How many %s to add to %s?", itemData.name or "items", target),
            placeholder = "Enter amount...",
            numeric = true,
            buttons = {
                {
                    text = "Add",
                    onClick = function(dialog, inputText)
                        local amount = tonumber(inputText)
                        if amount and amount > 0 then
                            AIO.Handle("GameMasterSystem", "addItemToPlayer", 
                                target, itemData.entry, amount)
                            print(string.format("Adding %dx %s to %s", amount, itemData.name or "item", target))
                            dialog:Hide()
                        else
                            print("|cffff0000Invalid amount!|r")
                        end
                    end
                },
                {
                    text = "Cancel",
                    onClick = function(dialog) dialog:Hide() end
                }
            }
        })
        PlayerInventory.closeContextMenu()
        dialog:Show()
    end
end

-- Forward declaration for Delete Confirm dialog
if not PlayerInventory.showDeleteConfirmDialog then
    PlayerInventory.showDeleteConfirmDialog = function(itemData, isEquipment, slot)
        -- Use CreateStyledDialog for the confirmation
        local dialog = CreateStyledDialog({
            title = "|cffff0000Delete Item|r",
            message = string.format(
                "|cffff0000WARNING: This action cannot be undone!|r\n\n" ..
                "Are you sure you want to delete:\n" ..
                "|cffffff00%s|r x%d?",
                itemData.name or "Unknown Item",
                itemData.count or 1
            ),
            buttons = {
                {
                    text = "|cffff0000Delete|r",
                    callback = function()
                        if isEquipment then
                            print(string.format("[DEBUG] Deleting equipped item at slot %d", slot.slotId))
                            AIO.Handle("GameMasterSystem", "deleteEquippedItem", PlayerInventory.currentPlayerName, slot.slotId)
                        else
                            -- Debug print to check bag and slot values
                            print(string.format("[DEBUG] Deleting inventory item: bag=%s, slot=%s", 
                                tostring(itemData.bag), tostring(itemData.slot)))
                            
                            -- Check if bag and slot exist
                            if not itemData.bag or not itemData.slot then
                                print("|cffff0000ERROR: Missing bag or slot information for item!|r")
                                print("[DEBUG] ItemData contents:")
                                for k, v in pairs(itemData) do
                                    print(string.format("  %s = %s", tostring(k), tostring(v)))
                                end
                                return
                            end
                            
                            AIO.Handle("GameMasterSystem", "deleteInventoryItem", PlayerInventory.currentPlayerName,
                                      itemData.bag, itemData.slot)
                        end
                        print(string.format("|cffff0000Deleting: %s|r", itemData.name or "item"))
                    end
                },
                {
                    text = "Cancel",
                    callback = function() end  -- Dialog will auto-hide
                }
            }
        })
        PlayerInventory.closeContextMenu()
        dialog:Show()
    end
end

-- Forward declaration for Mail Item dialog  
if not PlayerInventory.showMailItemDialog then
    PlayerInventory.showMailItemDialog = function(itemData)
        -- Use the GameMasterSystem mail dialog with the item pre-populated
        if GameMasterSystem and GameMasterSystem.OpenMailDialog then
            -- Prepare item data for the mail dialog
            local itemToMail = {
                id = itemData.entry,
                icon = itemData.icon or itemData.texture,
                count = itemData.count or 1,
                quality = itemData.quality,
                name = itemData.name,
                link = itemData.link
            }
            
            -- Mark that mail dialog is being opened from inventory modal
            if PlayerInventory.currentModal then
                PlayerInventory.currentModal.isMailDialogOpen = true
            end
            
            -- Open mail dialog with the item pre-attached
            local mailFrame = GameMasterSystem.OpenMailDialog(PlayerInventory.currentPlayerName, itemToMail, true) -- true = from inventory
            
            -- Store reference to mail frame if needed
            if PlayerInventory.currentModal and mailFrame then
                PlayerInventory.currentModal.mailFrame = mailFrame
            end
        else
            print("|cffff0000Mail system not available|r")
        end
    end
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    -- print("[PlayerInventory] Item context menu module loaded")
end
-- Debug message
-- print('[PlayerInventory] ItemContextMenu module fully loaded with showItemContextMenu function')
