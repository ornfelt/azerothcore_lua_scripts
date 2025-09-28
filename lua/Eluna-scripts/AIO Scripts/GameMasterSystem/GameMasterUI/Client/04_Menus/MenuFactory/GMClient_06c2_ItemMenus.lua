local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

local GMUtils = _G.GMUtils
local MenuItems = GMMenus.MenuItems
local MenuFactory = GMMenus.MenuFactory

-- Item Menus Module
local ItemMenus = {}

function ItemMenus.createItemMenu(entity)
    local trimmedEntry = GMUtils.trimSpaces(entity.entry)
    return {
        MenuItems.createTitle("Item ID: " .. trimmedEntry),
        {
            text = "Add Item to Player",
            func = function()
                AIO.Handle("GameMasterSystem", "addItemEntity", trimmedEntry, 1)
            end,
            notCheckable = true,
            tooltipTitle = "Add Item",
            tooltipText = "Adds this item to yourself or your target",
        },
        {
            text = "Add Item (5)",
            func = function()
                AIO.Handle("GameMasterSystem", "addItemEntity", trimmedEntry, 5)
            end,
            notCheckable = true,
        },
        {
            text = "Add Item (Max Stack)",
            func = function()
                AIO.Handle("GameMasterSystem", "addItemEntityMax", trimmedEntry)
            end,
            notCheckable = true,
            tooltipTitle = "Add Max Stack",
            tooltipText = "Adds the maximum stack size of this item",
        },
        {
            text = "Duplicate to Database",
            func = function()
                print("Duplicating Item with ID: " .. trimmedEntry)
                AIO.Handle("GameMasterSystem", "duplicateItemEntity", trimmedEntry)
            end,
            notCheckable = true,
            tooltipTitle = "Duplicate to Database",
            tooltipText = "Duplicate this Item to the database.\n\n"
                .. "This will create a new entry in the database with the same data as this Item.\n\n"
                .. "You can then modify the new entry as needed.",
            tooltipOnButton = true,
        },
        MenuItems.createCopyMenu(entity),
        MenuItems.CANCEL,
    }
end

-- Export function to MenuFactory
MenuFactory.createItemMenu = ItemMenus.createItemMenu

-- Item menus module loaded