local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in MailDialog! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI
local GMConfig = _G.GMConfig
local GMMenus = _G.GMMenus

-- ============================================================================
-- Mail Dialog
-- ============================================================================

-- Helper function to get safe item icon
local function GetItemIconSafe(itemId)
    local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemId)
    return icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- Mail composition dialog
function GameMasterSystem.OpenMailDialog(playerName, initialItems, fromInventory)
    if not playerName then return end
    
    -- Ensure GMData.frames exists
    if not GMData.frames then
        GMData.frames = {}
    end
    
    -- Check if a mail frame is already open
    if GMData.frames.currentMailFrame and GMData.frames.currentMailFrame:IsShown() then
        -- Mail frame already exists, add items to it if provided
        local existingFrame = GMData.frames.currentMailFrame
        
        -- Add items if provided
        if initialItems and existingFrame.AddItems then
            -- Handle both single item and array of items
            if initialItems.entry or initialItems.id then
                -- Single item passed
                existingFrame.AddItems({initialItems})
                CreateStyledToast("Item added to mail", 2, 0.5)
            elseif type(initialItems) == "table" and #initialItems > 0 then
                -- Array of items passed
                existingFrame.AddItems(initialItems)
                CreateStyledToast("Items added to mail", 2, 0.5)
            end
        end
        
        -- Focus the existing frame
        existingFrame:Raise()
        return existingFrame
    end
    
    -- Create main frame with improved size
    local mailFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    mailFrame:SetSize(500, 580)  -- Increased height for better layout
    
    -- Smart positioning when opened from inventory
    if fromInventory and PlayerInventory and PlayerInventory.currentModal then
        -- Position to the right of inventory modal to avoid overlap
        local invModal = PlayerInventory.currentModal
        if invModal.dialog then
            local invRight = invModal.dialog:GetRight() or 0
            local screenWidth = GetScreenWidth()
            
            -- Check if there's enough space on the right
            if invRight + 520 < screenWidth then
                -- Position to the right
                mailFrame:SetPoint("LEFT", UIParent, "LEFT", invRight + 20, 0)
            else
                -- Not enough space on right, position to the left
                local invLeft = invModal.dialog:GetLeft() or 0
                if invLeft - 520 > 0 then
                    mailFrame:SetPoint("RIGHT", UIParent, "LEFT", invLeft - 20, 0)
                else
                    -- No space on either side, offset vertically
                    mailFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
                end
            end
        else
            mailFrame:SetPoint("CENTER", UIParent, "CENTER", 200, 0)
        end
        -- Use higher strata when opened from inventory
        mailFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        mailFrame:SetFrameLevel(110)
    else
        mailFrame:SetPoint("CENTER")
        mailFrame:SetFrameStrata("DIALOG")
    end
    
    mailFrame:EnableMouse(true)
    mailFrame:SetMovable(true)
    mailFrame:RegisterForDrag("LeftButton")
    mailFrame:SetScript("OnDragStart", mailFrame.StartMoving)
    mailFrame:SetScript("OnDragStop", mailFrame.StopMovingOrSizing)
    
    -- Add click to raise behavior
    mailFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            -- Bring to front
            self:SetFrameLevel(self:GetFrameLevel() + 1)
        end
    end)
    
    -- Create title bar
    local titleBar = CreateStyledFrame(mailFrame, UISTYLE_COLORS.SectionBg)
    titleBar:SetHeight(35)
    titleBar:SetPoint("TOPLEFT", mailFrame, "TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", mailFrame, "TOPRIGHT", -1, -1)
    
    -- Title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBar, "LEFT", 15, 0)
    title:SetText("Send Mail to " .. playerName)
    title:SetTextColor(1, 1, 1)
    
    -- Close button
    local closeButton = CreateStyledButton(titleBar, "X", 24, 24)
    closeButton:SetPoint("RIGHT", titleBar, "RIGHT", -5, 0)
    closeButton:SetScript("OnClick", function()
        -- Clean up any open dialogs
        if mailFrame.quantityDialog then
            mailFrame.quantityDialog:Hide()
            mailFrame.quantityDialog = nil
        end
        if mailFrame.currentContextMenu then
            mailFrame.currentContextMenu:Hide()
            mailFrame.currentContextMenu = nil
        end
        mailFrame:Hide()
    end)
    
    -- Subject section
    local subjectLabel = mailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    subjectLabel:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 15, -15)
    subjectLabel:SetText("Subject:")
    subjectLabel:SetTextColor(0.8, 0.8, 0.8)
    
    local subjectContainer = CreateStyledEditBox(mailFrame, 450, false, 50)
    subjectContainer:SetPoint("TOPLEFT", subjectLabel, "BOTTOMLEFT", 0, -5)
    
    -- Get the actual EditBox from inside the container
    local subjectBox = subjectContainer:GetChildren()
    
    -- Character count for subject
    local subjectCharCount = mailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    subjectCharCount:SetPoint("RIGHT", subjectContainer, "RIGHT", -5, 0)
    subjectCharCount:SetTextColor(0.5, 0.5, 0.5)
    subjectCharCount:SetText("0/50")
    
    subjectBox:SetScript("OnTextChanged", function(self)
        local len = strlen(self:GetText())
        subjectCharCount:SetText(len .. "/50")
        if len > 45 then
            subjectCharCount:SetTextColor(1, 0.5, 0)
        else
            subjectCharCount:SetTextColor(0.5, 0.5, 0.5)
        end
    end)
    
    -- Message section with scrollable area
    local messageLabel = mailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    messageLabel:SetPoint("TOPLEFT", subjectContainer, "BOTTOMLEFT", 0, -15)
    messageLabel:SetText("Message:")
    messageLabel:SetTextColor(0.8, 0.8, 0.8)
    
    -- Create scrollable message area
    local messageContainer, messageContent, messageScrollBar, updateMessageScroll = CreateScrollableFrame(mailFrame, 450, 120)
    messageContainer:SetPoint("TOPLEFT", messageLabel, "BOTTOMLEFT", 0, -5)
    
    -- Create a simple multi-line edit box directly (avoiding the problematic multiline styled editbox)
    local messageBox = CreateFrame("EditBox", nil, messageContent)
    messageBox:SetPoint("TOPLEFT", messageContent, "TOPLEFT", 5, -5)
    messageBox:SetPoint("TOPRIGHT", messageContent, "TOPRIGHT", -5, -5)
    messageBox:SetMultiLine(true)
    messageBox:SetFontObject("GameFontHighlight")
    messageBox:SetTextColor(1, 1, 1, 1)
    messageBox:SetAutoFocus(false)
    messageBox:SetMaxLetters(500)
    messageBox:SetHeight(300)
    
    -- Style it like a styled edit box
    local messageBg = messageBox:CreateTexture(nil, "BACKGROUND")
    messageBg:SetAllPoints()
    messageBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    messageBg:SetVertexColor(0, 0, 0, 0.3)
    
    -- Update scroll when text changes
    messageBox:SetScript("OnTextChanged", function(self)
        local height = self:GetHeight()
        messageContent:SetHeight(math.max(120, height + 20))
        updateMessageScroll()
    end)
    
    -- Clear focus on escape
    messageBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    -- Attachments section
    local attachmentLabel = mailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    attachmentLabel:SetPoint("TOPLEFT", messageContainer, "BOTTOMLEFT", 0, -15)
    attachmentLabel:SetText("Attachments:")
    attachmentLabel:SetTextColor(0.8, 0.8, 0.8)
    
    -- Attachment counter
    local attachmentCounter = mailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    attachmentCounter:SetPoint("LEFT", attachmentLabel, "RIGHT", 5, 0)
    attachmentCounter:SetText("(0/12)")
    attachmentCounter:SetTextColor(0.6, 0.6, 0.6)
    
    -- Button row container (positioned to the right of attachments label)
    local buttonRow = CreateFrame("Frame", nil, mailFrame)
    buttonRow:SetHeight(24)
    buttonRow:SetPoint("TOPLEFT", attachmentCounter, "RIGHT", 20, 0)
    buttonRow:SetPoint("TOPRIGHT", mailFrame, "TOPRIGHT", -15, 0)
    
    -- Remove selected button (leftmost)
    local removeSelectedButton = CreateStyledButton(buttonRow, "Remove", 70, 24)
    removeSelectedButton:SetPoint("LEFT", buttonRow, "LEFT", 0, 0)
    removeSelectedButton:SetTooltip("Remove selected items", "Click items to select, then click this to remove")
    removeSelectedButton:Disable() -- Initially disabled
    
    -- Clear all button (middle)
    local clearAllButton = CreateStyledButton(buttonRow, "Clear All", 70, 24)
    clearAllButton:SetPoint("LEFT", removeSelectedButton, "RIGHT", 5, 0)
    clearAllButton:SetTooltip("Remove all attachments", "Click to remove all attached items")
    clearAllButton:Disable() -- Initially disabled
    
    -- Add items button (rightmost)
    local addItemsButton = CreateStyledButton(buttonRow, "Add Items", 80, 24)
    addItemsButton:SetPoint("LEFT", clearAllButton, "RIGHT", 5, 0)
    addItemsButton:SetTooltip("Add items to mail", "Click to search and select items to attach")
    
    -- Create invisible container for attachment slots (no background)
    local attachmentContainer = CreateFrame("Frame", nil, mailFrame)
    attachmentContainer:SetPoint("TOPLEFT", attachmentLabel, "BOTTOMLEFT", 0, -30)  -- More space for button row
    attachmentContainer:SetWidth(450)
    attachmentContainer:SetHeight(90)  -- Space for 2 rows
    
    -- Create grid for attachment slots (also invisible)
    local attachmentGrid = CreateFrame("Frame", nil, attachmentContainer)
    attachmentGrid:SetAllPoints()
    
    -- Initialize attachment system
    local attachedItems = {}  -- Array of attached items
    local attachmentSlots = {}  -- Visual slots (both filled and empty)
    local selectedForRemoval = {}  -- Items selected for removal
    local MAX_ATTACHMENTS = 12
    local SLOT_SIZE = 40  -- Larger slots for better visibility
    local SLOT_SPACING = 5
    
    -- Forward declare functions
    local AddItems
    local UpdateAttachmentDisplay
    local ShowQuantityDialog
    
    -- Create empty slot function
    local function CreateEmptySlot(index)
        local slot = CreateFrame("Button", nil, attachmentGrid)
        slot:SetSize(SLOT_SIZE, SLOT_SIZE)
        
        -- Style the slot with a darker background
        local bg = slot:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\Buttons\\WHITE8X8")
        bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
        slot.bg = bg
        
        -- Create a border
        slot:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
        })
        slot:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
        slot.border = slot
        
        -- Add plus sign for empty slots
        local plus = slot:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        plus:SetPoint("CENTER")
        plus:SetText("+")
        plus:SetTextColor(0.4, 0.4, 0.4)
        slot.plus = plus
        
        -- Hover effect
        slot:SetScript("OnEnter", function(self)
            self.bg:SetVertexColor(0.15, 0.15, 0.15, 0.9)
            self.border:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
            self.plus:SetTextColor(0.6, 0.6, 0.6)
        end)
        
        slot:SetScript("OnLeave", function(self)
            self.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
            self.border:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
            self.plus:SetTextColor(0.4, 0.4, 0.4)
        end)
        
        -- Handle drop
        slot:SetScript("OnReceiveDrag", function()
            if CursorHasItem() and #attachedItems < MAX_ATTACHMENTS then
                local type, id, link = GetCursorInfo()
                if type == "item" then
                    local name, _, _, _, _, _, _, maxStack, _, texture = GetItemInfo(link)
                    
                    -- Check if Shift is held for quantity input
                    if IsShiftKeyDown() and ShowQuantityDialog then
                        ShowQuantityDialog(name, id, link, texture, function(count)
                            AddItems({{
                                id = id,
                                link = link,
                                icon = texture,
                                name = name,
                                count = count
                            }})
                            ClearCursor()
                        end, maxStack, maxStack)
                    else
                        -- Default behavior - add 1
                        AddItems({{
                            id = id,
                            link = link,
                            icon = texture,
                            name = name,
                            count = 1
                        }})
                        ClearCursor()
                    end
                end
            elseif #attachedItems >= MAX_ATTACHMENTS then
                CreateStyledToast("Attachment limit reached!", 3, 0.5)
            end
        end)
        
        return slot
    end
    
    -- Quantity dialog function using UIStyleLibrary
    ShowQuantityDialog = function(itemName, itemId, itemLink, itemIcon, onAccept, stackSize, currentQty)
        -- Use currentQty as default if provided, otherwise 1
        local defaultAmount = currentQty or 1
        
        -- Create dialog using UIStyleLibrary for proper styling with dark theme
        local dialogFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)  -- Use standard dark background
        dialogFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        dialogFrame:SetFrameLevel(mailFrame and (mailFrame:GetFrameLevel() + 10) or 100)
        dialogFrame:SetSize(350, 200)
        dialogFrame:SetPoint("CENTER")
        dialogFrame:EnableMouse(true)  -- Block clicks to frames below
        
        -- Add a subtle border for better visibility using standard border color
        dialogFrame:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
        
        -- Title bar with section background
        local titleBar = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.SectionBg)
        titleBar:SetHeight(35)
        titleBar:SetPoint("TOPLEFT", 1, -1)
        titleBar:SetPoint("TOPRIGHT", -1, -1)
        
        -- Title text
        local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("CENTER")
        title:SetText("Edit Quantity")
        title:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
        
        -- Close button
        local closeBtn = CreateStyledButton(titleBar, "X", 24, 24)
        closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -5, 0)
        closeBtn:SetScript("OnClick", function()
            dialogFrame:Hide()
            if mailFrame.quantityDialog == dialogFrame then
                mailFrame.quantityDialog = nil
            end
        end)
        
        -- Item info
        local itemInfo = dialogFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        itemInfo:SetPoint("TOP", titleBar, "BOTTOM", 0, -10)
        itemInfo:SetText(itemName or "Item")
        itemInfo:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
        
        -- Current/Max info
        local rangeInfo = dialogFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        rangeInfo:SetPoint("TOP", itemInfo, "BOTTOM", 0, -5)
        rangeInfo:SetText(string.format("Current: %d, Max: %d", defaultAmount, stackSize or 1))
        rangeInfo:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
        
        -- Edit box (CreateStyledEditBox returns a container with .editBox property)
        local editBoxContainer = CreateStyledEditBox(dialogFrame, 120, true, 10)
        editBoxContainer:SetPoint("TOP", rangeInfo, "BOTTOM", 0, -15)
        local editBox = editBoxContainer.editBox  -- Get the actual EditBox
        editBox:SetText(tostring(defaultAmount))
        editBox:SetFocus()
        editBox:HighlightText()
        
        -- Buttons container
        local buttonContainer = CreateFrame("Frame", nil, dialogFrame)
        buttonContainer:SetPoint("BOTTOM", 0, 15)
        buttonContainer:SetSize(200, 25)
        
        -- Cancel button
        local cancelBtn = CreateStyledButton(buttonContainer, "Cancel", 80, 25)
        cancelBtn:SetPoint("LEFT", 0, 0)
        cancelBtn:SetScript("OnClick", function()
            dialogFrame:Hide()
            if mailFrame.quantityDialog == dialogFrame then
                mailFrame.quantityDialog = nil
            end
        end)
        
        -- OK button
        local okBtn = CreateStyledButton(buttonContainer, "OK", 80, 25)
        okBtn:SetPoint("RIGHT", 0, 0)
        
        local function ValidateAndAccept()
            local quantity = tonumber(editBox:GetText())
            if quantity and quantity > 0 and quantity <= (stackSize or 1) then
                onAccept(quantity)
                dialogFrame:Hide()
                if mailFrame.quantityDialog == dialogFrame then
                    mailFrame.quantityDialog = nil
                end
            end
        end
        
        okBtn:SetScript("OnClick", ValidateAndAccept)
        
        -- Handle Enter key
        editBox:SetScript("OnEnterPressed", ValidateAndAccept)
        
        -- Handle Escape key
        editBox:SetScript("OnEscapePressed", function()
            dialogFrame:Hide()
            if mailFrame.quantityDialog == dialogFrame then
                mailFrame.quantityDialog = nil
            end
        end)
        
        -- Validation on text change
        editBox:SetScript("OnTextChanged", function(self)
            local text = self:GetText()
            local num = tonumber(text)
            if num and num > 0 and num <= (stackSize or 1) then
                okBtn:Enable()
                okBtn:SetAlpha(1.0)
            else
                okBtn:Disable()
                okBtn:SetAlpha(0.5)
            end
        end)
        
        -- Close any existing quantity dialog
        if mailFrame.quantityDialog then
            mailFrame.quantityDialog:Hide()
        end
        
        -- Make sure dialog is visible
        dialogFrame:Show()
        dialogFrame:Raise()
        
        -- Store reference for cleanup
        mailFrame.quantityDialog = dialogFrame
    end
    
    -- Function to show context menu for attachments
    local function ShowAttachmentContextMenu(item, index, card)
        local menuItems = {}
        
        -- Edit Quantity option
        table.insert(menuItems, {
            text = "Edit Quantity",
            icon = "Interface\\Icons\\INV_Misc_Note_01",
            func = function()
                -- Get actual max stack size from item info
                local _, _, _, _, _, _, _, maxStack = GetItemInfo(item.link or item.id)
                maxStack = maxStack or 1  -- Default to 1 if not found
                
                ShowQuantityDialog(
                    item.name or "item",
                    item.id,
                    item.link,
                    item.icon,
                    function(newCount)
                        -- Update the item count
                        attachedItems[index].count = newCount
                        UpdateAttachmentDisplay()
                        CreateStyledToast(string.format("Updated to %dx %s", newCount, item.name or "item"), 2, 0.5)
                    end,
                    maxStack, -- Use actual max stack
                    item.count or 1 -- current amount
                )
            end
        })
        
        -- Duplicate Item option
        table.insert(menuItems, {
            text = "Duplicate Item",
            icon = "Interface\\Icons\\INV_Misc_Book_09",
            func = function()
                -- Check if we have space for another attachment
                if #attachedItems >= MAX_ATTACHMENTS then
                    CreateStyledToast("Cannot duplicate - attachment limit reached!", 3, 0.5)
                    return
                end
                
                -- Create a copy of the item
                local duplicatedItem = {
                    id = item.id,
                    link = item.link,
                    icon = item.icon,
                    count = item.count or 1,
                    quality = item.quality,
                    name = item.name
                }
                
                -- Add the duplicated item
                table.insert(attachedItems, duplicatedItem)
                UpdateAttachmentDisplay()
                CreateStyledToast(string.format("Duplicated %dx %s", duplicatedItem.count, item.name or "item"), 2, 0.5)
            end
        })
        
        -- View Item option
        table.insert(menuItems, {
            text = "View Item",
            icon = "Interface\\Icons\\INV_Misc_Spyglass_03",
            func = function()
                if item.link then
                    DEFAULT_CHAT_FRAME:AddMessage(item.link)
                end
            end
        })
        
        -- Separator
        table.insert(menuItems, { separator = true })
        
        -- Remove Item option
        table.insert(menuItems, {
            text = "Remove Item",
            icon = "Interface\\Icons\\INV_Misc_Bag_09",
            func = function()
                table.remove(attachedItems, index)
                UpdateAttachmentDisplay()
                CreateStyledToast("Item removed from mail", 2, 0.5)
            end
        })
        
        -- If item is selected, add deselect option
        if selectedForRemoval[index] then
            table.insert(menuItems, {
                text = "Clear Selection",
                icon = "Interface\\Buttons\\UI-MinusButton-Up",
                func = function()
                    selectedForRemoval[index] = nil
                    if card.selectionBorder then
                        card.selectionBorder:Hide()
                    end
                    -- Check if any items still selected
                    local hasSelection = false
                    for _ in pairs(selectedForRemoval) do
                        hasSelection = true
                        break
                    end
                    if not hasSelection then
                        removeSelectedButton:Disable()
                    end
                end
            })
        end
        
        -- Create and show the context menu using ShowFullyStyledContextMenu
        -- This function properly handles frame strata and levels
        local menu = ShowFullyStyledContextMenu(menuItems, card, "TOPLEFT", "TOPRIGHT", 5, 0)
        
        if menu then
            -- ShowFullyStyledContextMenu already sets TOOLTIP strata
            -- Ensure it's above the mail dialog
            local mailFrameLevel = mailFrame:GetFrameLevel()
            menu:SetFrameLevel(mailFrameLevel + 100)
            menu:Show()
            menu:Raise()
        end
        
        -- Store reference for cleanup
        if mailFrame.currentContextMenu then
            mailFrame.currentContextMenu:Hide()
        end
        mailFrame.currentContextMenu = menu
    end
    
    -- Update attachment display function
    UpdateAttachmentDisplay = function()
        -- Clear old slots
        for _, slot in ipairs(attachmentSlots) do
            slot:Hide()
        end
        wipe(attachmentSlots)
        wipe(selectedForRemoval)
        
        -- Create slots
        for i = 1, MAX_ATTACHMENTS do
            local row = math.floor((i - 1) / 6)
            local col = (i - 1) % 6
            local x = col * (SLOT_SIZE + SLOT_SPACING)
            local y = -row * (SLOT_SIZE + SLOT_SPACING)
            
            if attachedItems[i] then
                -- Create filled slot
                local item = attachedItems[i]
                local itemIndex = i  -- Capture index in closure
                local card = CreateStyledCard(attachmentGrid, SLOT_SIZE, {
                    texture = item.icon or GetItemIconSafe(item.id),
                    count = item.count or 1,
                    quality = item.quality or "Common",
                    link = item.link,
                    onClick = function(self, button)
                        if button == "RightButton" then
                            -- Show context menu on right-click
                            ShowAttachmentContextMenu(attachedItems[itemIndex], itemIndex, self)
                        elseif button == "LeftButton" then
                            -- Toggle selection for removal on left-click
                            if selectedForRemoval[itemIndex] then
                                selectedForRemoval[itemIndex] = nil
                                if self.selectionBorder then
                                    self.selectionBorder:Hide()
                                end
                            else
                                selectedForRemoval[itemIndex] = true
                                -- Create selection border if it doesn't exist
                                if not self.selectionBorder then
                                    self.selectionBorder = self:CreateTexture(nil, "OVERLAY")
                                    self.selectionBorder:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
                                    self.selectionBorder:SetBlendMode("ADD")
                                    self.selectionBorder:SetAlpha(0.7)
                                    self.selectionBorder:SetPoint("TOPLEFT", -2, 2)
                                    self.selectionBorder:SetPoint("BOTTOMRIGHT", 2, -2)
                                end
                                self.selectionBorder:Show()
                            end
                            
                            -- Enable remove button if any selected
                            local hasSelection = false
                            for _ in pairs(selectedForRemoval) do
                                hasSelection = true
                                break
                            end
                            if hasSelection then
                                removeSelectedButton:Enable()
                            else
                                removeSelectedButton:Disable()
                            end
                        end
                    end
                })
                
                -- Add tooltip with right-click hint
                card:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    if item.link then
                        GameTooltip:SetHyperlink(item.link)
                    else
                        GameTooltip:SetText(item.name or "Item")
                    end
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine("Left-click: Select for removal", 0.7, 0.7, 0.7)
                    GameTooltip:AddLine("Right-click: More options", 0.7, 0.7, 0.7)
                    GameTooltip:Show()
                end)
                card:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)
                
                card:SetPoint("TOPLEFT", attachmentGrid, "TOPLEFT", x, y)
                card.itemIndex = i
                table.insert(attachmentSlots, card)
            else
                -- Create empty slot
                local emptySlot = CreateEmptySlot(i)
                emptySlot:SetPoint("TOPLEFT", attachmentGrid, "TOPLEFT", x, y)
                
                -- First empty slot shows hint text
                if i == 1 then
                    emptySlot.plus:SetText("Drop\nHere")
                    emptySlot.plus:SetTextColor(0.5, 0.5, 0.5)
                    -- Use smaller font
                    local font, size, flags = emptySlot.plus:GetFont()
                    emptySlot.plus:SetFont(font, 10, flags)
                    
                    -- Add tooltip hint about shift-click
                    emptySlot:SetScript("OnEnter", function(self)
                        self.bg:SetVertexColor(0.15, 0.15, 0.15, 0.9)
                        self.border:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
                        self.plus:SetTextColor(0.7, 0.7, 0.7)
                        
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                        GameTooltip:SetText("Drop items here")
                        GameTooltip:AddLine("Hold SHIFT while dropping to specify quantity", 0.7, 0.7, 0.7)
                        GameTooltip:Show()
                    end)
                    emptySlot:SetScript("OnLeave", function(self)
                        self.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
                        self.border:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
                        self.plus:SetTextColor(0.5, 0.5, 0.5)
                        GameTooltip:Hide()
                    end)
                end
                
                table.insert(attachmentSlots, emptySlot)
            end
        end
        
        -- Update counter
        local count = #attachedItems
        attachmentCounter:SetText("(" .. count .. "/12)")
        if count >= 10 then
            attachmentCounter:SetTextColor(1, 0.5, 0)  -- Orange when near limit
        elseif count >= 12 then
            attachmentCounter:SetTextColor(1, 0, 0)  -- Red when full
        else
            attachmentCounter:SetTextColor(0.6, 0.6, 0.6)  -- Normal gray
        end
        
        -- Update button states
        if count > 0 then
            clearAllButton:Enable()
        else
            clearAllButton:Disable()
        end
        
        if count < MAX_ATTACHMENTS then
            addItemsButton:Enable()
        else
            addItemsButton:Disable()
        end
        
        removeSelectedButton:Disable()  -- Reset remove button
    end
    
    -- Function to add items
    AddItems = function(items)
        local added = 0
        for _, item in ipairs(items) do
            local itemCount = item.count or 1
            if #attachedItems < MAX_ATTACHMENTS then
                table.insert(attachedItems, {
                    id = item.entry or item.id,
                    link = item.link or ("item:" .. (item.entry or item.id)),
                    icon = item.icon,
                    count = itemCount,
                    quality = item.quality,
                    name = item.name
                })
                added = added + 1
            else
                break
            end
        end
        
        UpdateAttachmentDisplay()
        
        if added > 0 then
            CreateStyledToast("Added " .. added .. " item(s)", 2, 0.5)
        end
        
        local remaining = MAX_ATTACHMENTS - #attachedItems
        if remaining == 0 then
            CreateStyledToast("Attachment limit reached!", 3, 0.5)
        end
    end
    
    -- Function to remove selected items
    local function RemoveSelectedItems()
        -- Build list of indices to remove (in reverse order)
        local toRemove = {}
        for idx in pairs(selectedForRemoval) do
            table.insert(toRemove, idx)
        end
        table.sort(toRemove, function(a, b) return a > b end)  -- Sort descending
        
        -- Remove items
        for _, idx in ipairs(toRemove) do
            table.remove(attachedItems, idx)
        end
        
        UpdateAttachmentDisplay()
        CreateStyledToast("Removed " .. #toRemove .. " item(s)", 2, 0.5)
    end
    
    -- Add items button handler
    addItemsButton:SetScript("OnClick", function()
        if GMMenus and GMMenus.ItemSelection and GMMenus.ItemSelection.ShowMultiSelectDialog then
            local remaining = MAX_ATTACHMENTS - #attachedItems
            GMMenus.ItemSelection.ShowMultiSelectDialog(function(selectedItems)
                if selectedItems and next(selectedItems) then
                    local itemList = {}
                    for _, item in pairs(selectedItems) do
                        table.insert(itemList, item)
                    end
                    AddItems(itemList)
                end
            end, remaining)
        else
            CreateStyledToast("Item selection not available", 3, 0.5)
        end
    end)
    
    -- Clear all button handler
    clearAllButton:SetScript("OnClick", function()
        wipe(attachedItems)
        UpdateAttachmentDisplay()
        CreateStyledToast("All attachments removed", 2, 0.5)
    end)
    
    -- Remove selected button handler
    removeSelectedButton:SetScript("OnClick", function()
        RemoveSelectedItems()
    end)
    
    -- Support drag and drop on the container as fallback
    attachmentContainer:SetScript("OnReceiveDrag", function()
        if CursorHasItem() and #attachedItems < MAX_ATTACHMENTS then
            local type, id, link = GetCursorInfo()
            if type == "item" then
                local name, _, _, _, _, _, _, maxStack, _, texture = GetItemInfo(link)
                
                -- Check if Shift is held for quantity input
                if IsShiftKeyDown() then
                    ShowQuantityDialog(name, id, link, texture, function(count)
                        AddItems({{
                            id = id,
                            link = link,
                            icon = texture,
                            name = name,
                            count = count
                        }})
                        ClearCursor()
                    end, maxStack, maxStack)
                else
                    -- Default behavior - add 1
                    AddItems({{
                        id = id,
                        link = link,
                        icon = texture,
                        name = name,
                        count = 1
                    }})
                    ClearCursor()
                end
            end
        elseif #attachedItems >= MAX_ATTACHMENTS then
            CreateStyledToast("Attachment limit reached!", 3, 0.5)
        end
    end)
    
    -- Initial update to show first empty slot
    UpdateAttachmentDisplay()
    
    -- Money section
    local moneyLabel = mailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    moneyLabel:SetPoint("TOPLEFT", attachmentContainer, "BOTTOMLEFT", 0, -20)
    moneyLabel:SetText("Send Money:")
    moneyLabel:SetTextColor(0.8, 0.8, 0.8)
    
    -- Gold input
    local goldBoxContainer = CreateStyledEditBox(mailFrame, 60, true, 6)
    goldBoxContainer:SetPoint("LEFT", moneyLabel, "RIGHT", 10, 0)
    local goldBox = goldBoxContainer:GetChildren()
    
    local goldIcon = mailFrame:CreateTexture(nil, "ARTWORK")
    goldIcon:SetSize(14, 14)
    goldIcon:SetPoint("LEFT", goldBoxContainer, "RIGHT", 3, 0)
    goldIcon:SetTexture("Interface\\MoneyFrame\\UI-GoldIcon")
    
    -- Silver input
    local silverBoxContainer = CreateStyledEditBox(mailFrame, 40, true, 2)
    silverBoxContainer:SetPoint("LEFT", goldIcon, "RIGHT", 10, 0)
    local silverBox = silverBoxContainer:GetChildren()
    
    local silverIcon = mailFrame:CreateTexture(nil, "ARTWORK")
    silverIcon:SetSize(14, 14)
    silverIcon:SetPoint("LEFT", silverBoxContainer, "RIGHT", 3, 0)
    silverIcon:SetTexture("Interface\\MoneyFrame\\UI-SilverIcon")
    
    -- Copper input
    local copperBoxContainer = CreateStyledEditBox(mailFrame, 40, true, 2)
    copperBoxContainer:SetPoint("LEFT", silverIcon, "RIGHT", 10, 0)
    local copperBox = copperBoxContainer:GetChildren()
    
    local copperIcon = mailFrame:CreateTexture(nil, "ARTWORK")
    copperIcon:SetSize(14, 14)
    copperIcon:SetPoint("LEFT", copperBoxContainer, "RIGHT", 3, 0)
    copperIcon:SetTexture("Interface\\MoneyFrame\\UI-CopperIcon")
    
    -- COD checkbox
    local codCheckbox = CreateStyledCheckbox(mailFrame, "Cash on Delivery (COD)")
    codCheckbox:SetPoint("TOPLEFT", moneyLabel, "BOTTOMLEFT", 0, -15)
    codCheckbox:SetTooltip("Request payment on delivery", "The recipient must pay the specified amount to receive the mail")
    
    -- Loading bar (hidden by default)
    local loadingBar = nil
    if CreateStyledLoadingBar then
        loadingBar = CreateStyledLoadingBar(mailFrame, 300, 20)
        loadingBar:SetPoint("BOTTOM", mailFrame, "BOTTOM", 0, 60)
        loadingBar:Hide()
    end
    
    -- Buttons
    local sendButton = CreateStyledButton(mailFrame, "Send Mail", 120, 30)
    sendButton:SetPoint("BOTTOMRIGHT", mailFrame, "BOTTOMRIGHT", -20, 20)
    sendButton:SetScript("OnClick", function()
        local subject = subjectBox:GetText()
        local message = messageBox:GetText()
        
        -- Calculate total money in copper
        local gold = tonumber(goldBox:GetText()) or 0
        local silver = tonumber(silverBox:GetText()) or 0
        local copper = tonumber(copperBox:GetText()) or 0
        local totalCopper = (gold * 10000) + (silver * 100) + copper
        
        if subject == "" then
            CreateStyledToast("Please enter a subject", 3, 0.5)
            return
        end
        
        if message == "" then
            CreateStyledToast("Please enter a message", 3, 0.5)
            return
        end
        
        -- Prepare item data
        local itemsToSend = {}
        for _, item in ipairs(attachedItems) do
            table.insert(itemsToSend, item.id)
        end
        
        -- Show loading bar if available
        if loadingBar then
            loadingBar:Show()
            loadingBar:SetProgress(0)
        end
        sendButton:Disable()
        
        -- Animate loading bar with frame timer
        local timerFrame = CreateFrame("Frame")
        local elapsed = 0
        timerFrame:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if loadingBar then
                loadingBar:SetProgress(elapsed / 1.5) -- 1.5 second send time
            end
            
            if elapsed >= 1.5 then
                self:SetScript("OnUpdate", nil)
                
                -- Send the mail with items
                local isCOD = codCheckbox:GetChecked()
                local codAmount = isCOD and totalCopper or 0
                
                -- Prepare item data in format needed for server
                local itemData = {}
                for i, item in ipairs(attachedItems) do
                    table.insert(itemData, {
                        entry = item.id,
                        amount = item.count or 1
                    })
                end
                
                AIO.Handle("GameMasterSystem", "sendPlayerMailWithItems", {
                    recipient = playerName,
                    subject = subject,
                    message = message,
                    money = isCOD and 0 or totalCopper,  -- If COD, money goes in cod field
                    cod = codAmount,
                    items = itemData,
                    stationery = 61,  -- GM stationery (61)
                    delay = 0
                })
                
                -- Show success message
                local itemCount = #itemsToSend
                if itemCount > 0 then
                    CreateStyledToast("Mail sent with " .. itemCount .. " item(s)!", 3, 0.5)
                else
                    CreateStyledToast("Mail sent successfully!", 3, 0.5)
                end
                
                -- Clean up any open dialogs
                if mailFrame.quantityDialog then
                    mailFrame.quantityDialog:Hide()
                    mailFrame.quantityDialog = nil
                end
                if mailFrame.currentContextMenu then
                    mailFrame.currentContextMenu:Hide()
                    mailFrame.currentContextMenu = nil
                end
                -- Hide the frame
                mailFrame:Hide()
            end
        end)
    end)
    
    local cancelButton = CreateStyledButton(mailFrame, "Cancel", 100, 30)
    cancelButton:SetPoint("BOTTOMLEFT", mailFrame, "BOTTOMLEFT", 20, 20)
    cancelButton:SetScript("OnClick", function()
        -- Clean up any open dialogs
        if mailFrame.quantityDialog then
            mailFrame.quantityDialog:Hide()
            mailFrame.quantityDialog = nil
        end
        if mailFrame.currentContextMenu then
            mailFrame.currentContextMenu:Hide()
            mailFrame.currentContextMenu = nil
        end
        mailFrame:Hide()
    end)
    
    -- Make ESC close the frame
    tinsert(UISpecialFrames, mailFrame:GetName() or "GMMailFrame")
    
    -- Add OnHide handler to clear the flag in inventory modal and GMData reference
    mailFrame:SetScript("OnHide", function()
        -- Clear inventory modal flag if opened from there
        if fromInventory and PlayerInventory and PlayerInventory.currentModal then
            PlayerInventory.currentModal.isMailDialogOpen = false
            PlayerInventory.currentModal.mailFrame = nil
        end
        -- Clear global reference
        if GMData.frames.currentMailFrame == mailFrame then
            GMData.frames.currentMailFrame = nil
        end
    end)
    
    -- Add initial items if provided
    if initialItems then
        -- Handle both single item and array of items
        if initialItems.entry or initialItems.id then
            -- Single item passed
            AddItems({initialItems})
        elseif type(initialItems) == "table" and #initialItems > 0 then
            -- Array of items passed
            AddItems(initialItems)
        end
    end
    
    -- Expose the AddItems function on the mail frame
    mailFrame.AddItems = AddItems
    
    -- Store reference in GMData
    GMData.frames.currentMailFrame = mailFrame
    
    -- Focus subject box
    subjectBox:SetFocus()
    
    return mailFrame
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Mail dialog module loaded")
end