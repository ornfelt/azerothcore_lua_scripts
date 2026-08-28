local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local DC = DeathChestUI
local ui = DC.ui
local W = DC.FRAME_WIDTH

-- Search box (WoW native InputBoxTemplate)
local searchBox = CreateFrame("EditBox", "DeathChestSearchBox", ui.mainFrame, "InputBoxTemplate")
searchBox:SetSize(180, 22)
searchBox:SetAutoFocus(false)
searchBox:SetPoint("TOPLEFT", ui.mainFrame, "TOPLEFT", 18, -(DC.HEADER_HEIGHT + 8))
searchBox:SetFontObject("ChatFontNormal")
searchBox:SetTextInsets(16, 0, 0, 0)

local searchIcon = searchBox:CreateTexture(nil, "OVERLAY")
searchIcon:SetSize(14, 14)
searchIcon:SetPoint("LEFT", searchBox, "LEFT", 0, 0)
searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
searchIcon:SetVertexColor(0.6, 0.6, 0.6)

local placeholder = searchBox:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
placeholder:SetPoint("LEFT", searchIcon, "RIGHT", 4, 0)
placeholder:SetText("Search...")

searchBox:SetScript("OnTextChanged", function(self)
    local text = self:GetText()
    if text == "" then placeholder:Show() else placeholder:Hide() end
    DC.state.searchText = text
    DC.ApplyFilters()
end)
searchBox:SetScript("OnEscapePressed", function(self)
    self:SetText("")
    self:ClearFocus()
end)
searchBox:SetScript("OnEnterPressed", function(self)
    self:ClearFocus()
end)
ui.searchBox = searchBox

-- Filter dropdown (WoW native UIDropDownMenu)
local dropdown = CreateFrame("Frame", "DeathChestFilterDropdown", ui.mainFrame, "UIDropDownMenuTemplate")
dropdown:SetPoint("LEFT", searchBox, "RIGHT", -8, -2)
UIDropDownMenu_SetWidth(dropdown, 80)
UIDropDownMenu_SetText(dropdown, "All")

UIDropDownMenu_Initialize(dropdown, function(self, level)
    for _, cat in ipairs(DC.CATEGORIES) do
        local info = UIDropDownMenu_CreateInfo()
        info.text = cat.label
        info.func = function()
            DC.state.activeFilter = cat.id
            UIDropDownMenu_SetText(dropdown, cat.label)
            DC.ApplyFilters()
        end
        UIDropDownMenu_AddButton(info, level)
    end
end)
ui.filterDropdown = dropdown

-- Item count label
local countLabel = ui.mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
countLabel:SetPoint("TOPRIGHT", ui.mainFrame, "TOPRIGHT", -14, -(DC.HEADER_HEIGHT + 12))
countLabel:SetTextColor(0.6, 0.6, 0.6, 1)
ui.itemCountLabel = countLabel

function DeathChestUI.UpdateItemCount()
    local total = #DC.state.rawItems
    local shown = #DC.state.displayItems
    local state = DC.state
    if state.activeFilter == "All" and state.searchText == "" then
        countLabel:SetText(total .. " items")
    else
        countLabel:SetText(shown .. "/" .. total)
    end
end

-- Quick-take buttons row
local QUICK_TAKE_DEFS = {
    { label = "Take Equip",    categoryId = "Equipment" },
    { label = "Take Consume",  categoryId = "Consumable" },
    { label = "Take Reagents", categoryId = "TradeGoods" },
}

local quickTakeRow = CreateFrame("Frame", nil, ui.mainFrame)
quickTakeRow:SetSize(W - 36, 26)
ui.quickTakeRow = quickTakeRow
ui.quickTakeBtns = {}

local btnWidth = math.floor((W - 36 - (#QUICK_TAKE_DEFS - 1) * 4) / #QUICK_TAKE_DEFS)

for i, def in ipairs(QUICK_TAKE_DEFS) do
    local btn = CreateFrame("Button", nil, quickTakeRow, "UIPanelButtonTemplate")
    btn:SetSize(btnWidth, 22)
    btn:SetText(def.label)
    btn.categoryId = def.categoryId

    if i == 1 then
        btn:SetPoint("LEFT", quickTakeRow, "LEFT", 0, 0)
    else
        btn:SetPoint("LEFT", ui.quickTakeBtns[i - 1], "RIGHT", 4, 0)
    end

    btn:SetScript("OnClick", function()
        if DC.state.casting then return end
        local ids = DC.CollectIdsByCategory(def.categoryId)
        if #ids > 0 and DC.state.chestGuid > 0 then
            local guid = DC.state.chestGuid
            DC.LootMultiEffect(function()
                AIO.Handle("DeathChest", "TakeMultiple", guid, ids)
            end)
        end
    end)

    ui.quickTakeBtns[i] = btn
end

-- Enable/disable quick-take buttons based on available items
function DeathChestUI.UpdateQuickTakeButtons()
    for _, btn in ipairs(ui.quickTakeBtns) do
        local ids = DC.CollectIdsByCategory(btn.categoryId)
        if #ids > 0 then
            btn:Enable()
            btn:SetAlpha(1)
        else
            btn:Disable()
            btn:SetAlpha(0.4)
        end
    end
end

-- Register for ESC-to-close
tinsert(UISpecialFrames, "DeathChestFrame")
