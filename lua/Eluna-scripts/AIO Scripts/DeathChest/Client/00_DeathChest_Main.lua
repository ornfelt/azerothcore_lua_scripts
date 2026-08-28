local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

DeathChestUI = DeathChestUI or {}

-- Layout constants (shared across files)
DeathChestUI.FRAME_WIDTH = 420
DeathChestUI.ROW_HEIGHT = 40
DeathChestUI.ICON_SIZE = 34
DeathChestUI.HEADER_HEIGHT = 24
DeathChestUI.TOOLBAR_HEIGHT = 34
DeathChestUI.PADDING = 10
DeathChestUI.MAX_VISIBLE_ROWS = 7

-- Quality colors from UIStyleLibrary
DeathChestUI.QUALITY_COLORS = {
    [0] = UISTYLE_COLORS.Poor,
    [1] = UISTYLE_COLORS.Common,
    [2] = UISTYLE_COLORS.Uncommon,
    [3] = UISTYLE_COLORS.Rare,
    [4] = UISTYLE_COLORS.Epic,
    [5] = UISTYLE_COLORS.Legendary,
}

-- Shared state
DeathChestUI.state = {
    chestGuid = 0,
    rawItems = {},
    displayItems = {},
    goldAmount = 0,
    goldDbId = 0,
    activeFilter = "All",
    searchText = "",
    casting = false,
    staggerNextPopulate = false,
}

-- UI element references (populated by later files)
DeathChestUI.ui = {}

-- AIO handlers
local Handlers = AIO.AddHandlers("DeathChest", {})

function Handlers.Open(player, itemData, chestGuid)
    if not itemData or #itemData == 0 then return end
    local state = DeathChestUI.state
    state.chestGuid = chestGuid or 0
    state.activeFilter = "All"
    state.searchText = ""
    state.staggerNextPopulate = true
    -- Reset search box and filter dropdown
    local ui = DeathChestUI.ui
    if ui.searchBox then ui.searchBox:SetText("") end
    if ui.filterDropdown then
        UIDropDownMenu_SetText(ui.filterDropdown, "All")
    end
    DeathChestUI.StoreAndDisplay(itemData)
    ui.mainFrame:Show()
    AIO.Handle("DeathChest", "UIOpened", state.chestGuid)
end

function Handlers.UpdateList(player, itemData)
    if not itemData or #itemData == 0 then
        DeathChestUI.ui.mainFrame:Hide()
        return
    end
    DeathChestUI.StoreAndDisplay(itemData)
end

function Handlers.Error(player, message)
    if message then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff4444[Death Chest] " .. message .. "|r")
    end
end

function Handlers.ForceClose(player)
    DeathChestUI.ui.mainFrame:Hide()
end
