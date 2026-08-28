local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local DC = DeathChestUI
local ui = DC.ui
ui.itemRows = {}

-- Create a single item row (loot-slot style)
function DeathChestUI.CreateItemRow(parent, index)
    local row = CreateFrame("Button", nil, parent)
    row:SetSize(parent:GetWidth(), DC.ROW_HEIGHT)
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -(index - 1) * DC.ROW_HEIGHT)

    -- Dark slot background with alternating tint
    local slotBg = row:CreateTexture(nil, "BACKGROUND")
    slotBg:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    slotBg:SetAllPoints()
    if index % 2 == 0 then
        slotBg:SetVertexColor(0.14, 0.14, 0.14, 0.4)
    else
        slotBg:SetVertexColor(0.08, 0.08, 0.08, 0.5)
    end

    -- Hover highlight
    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    highlight:SetAlpha(0.25)
    highlight:SetBlendMode("ADD")

    -- Item icon (no texcoord crop — native icon border looks clean)
    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(DC.ICON_SIZE, DC.ICON_SIZE)
    icon:SetPoint("LEFT", row, "LEFT", 5, 0)

    -- Quality border glow around icon
    local glow = row:CreateTexture(nil, "ARTWORK", nil, 2)
    glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
    glow:SetSize(DC.ICON_SIZE + 10, DC.ICON_SIZE + 10)
    glow:SetPoint("CENTER", icon, "CENTER")
    glow:SetBlendMode("ADD")
    glow:SetAlpha(0.6)

    -- Item name
    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", icon, "RIGHT", 8, 0)
    nameText:SetPoint("RIGHT", row, "RIGHT", -52, 0)
    nameText:SetJustifyH("LEFT")

    -- Item count (bottom-right of icon)
    local countText = row:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    countText:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -1, 1)

    -- "Loot" label on right
    local lootLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lootLabel:SetPoint("RIGHT", row, "RIGHT", -8, 0)
    lootLabel:SetText("|cffddaa44Loot|r")

    -- Click to take item (with sweep effect)
    row:SetScript("OnClick", function(self)
        if DC.state.casting then return end
        if self.dbId and self.dbId > 0 then
            local id = self.dbId
            DC.LootWithEffect(self, function()
                AIO.Handle("DeathChest", "TakeItem", id)
            end)
        end
    end)

    -- Tooltip on hover
    row:SetScript("OnEnter", function(self)
        if self.itemLink then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(self.itemLink)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)

    row.icon = icon
    row.glow = glow
    row.nameText = nameText
    row.countText = countText
    row.dbId = 0
    row.itemLink = nil
    return row
end

-- Populate visible item rows from a filtered item list
function DeathChestUI.PopulateItems(items)
    local shouldStagger = DC.state.staggerNextPopulate
    DC.state.staggerNextPopulate = false

    for i = 1, #ui.itemRows do
        ui.itemRows[i]:Hide()
    end

    for i, item in ipairs(items) do
        local row = ui.itemRows[i]
        if not row then
            row = DC.CreateItemRow(ui.content, i)
            ui.itemRows[i] = row
        end
        row:SetPoint("TOPLEFT", ui.content, "TOPLEFT", 0, -(i - 1) * DC.ROW_HEIGHT)

        local name, link, rarity, _, _, _, _, _, _, texture = GetItemInfo(item.entry)
        name = name or ("Item #" .. item.entry)
        texture = texture or "Interface\\Icons\\INV_Misc_QuestionMark"
        rarity = rarity or 1
        link = link or ("|cffffffff[" .. name .. "]|r")

        local color = DC.QUALITY_COLORS[rarity] or DC.QUALITY_COLORS[1]
        row.icon:SetTexture(texture)
        row.glow:SetVertexColor(color[1], color[2], color[3])
        row.nameText:SetText(string.format("|cff%02x%02x%02x%s|r",
            color[1] * 255, color[2] * 255, color[3] * 255, name))

        if item.count > 1 then
            row.countText:SetText(item.count)
        else
            row.countText:SetText("")
        end

        row.dbId = item.id
        row.itemLink = link
        row:SetAlpha(shouldStagger and 0 or 1)
        row:Show()
    end

    ui.content:SetHeight(math.max(#items * DC.ROW_HEIGHT, 1))
    DC.UpdateLayout(#items)

    if shouldStagger and DC.StaggerReveal then
        DC.StaggerReveal()
    end

    if #DC.state.rawItems == 0 and DC.state.goldAmount == 0 then
        ui.mainFrame:Hide()
    end
end
