local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get the shared namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get module references
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
-- Note: GMMenus is accessed dynamically at runtime since it loads after this module

-- Module: Player Spell Management
local PlayerSpells = {}
GameMasterSystem.PlayerSpells = PlayerSpells

-- Local state
local spellManagerModal = nil
local currentPlayerName = nil
local currentPlayerSpells = {}  -- Initialize as empty table
local selectedSpell = nil
local filteredSpells = {}  -- Store filtered results
local dataLoaded = false  -- Track if spell data has been loaded

-- Function to read the local player's complete spellbook (WoW 3.3.5 compatible)
function PlayerSpells.readLocalSpellbook()
    local spells = {}
    local spellsByCategory = {}
    
    -- In 3.3.5, we need to use GetSpellName instead of GetSpellBookItemName
    -- and the API is slightly different
    
    -- Method 1: Try to read spell tabs if available
    local numTabs = GetNumSpellTabs and GetNumSpellTabs() or 0
    if numTabs > 0 then
        for tabIndex = 1, numTabs do
            local tabName, tabTexture, tabOffset, numSpells = GetSpellTabInfo(tabIndex)
            
            if tabName and numSpells and numSpells > 0 then
                spellsByCategory[tabName] = {}
                
                for spellIndex = 1, numSpells do
                    local actualIndex = tabOffset + spellIndex
                    
                    -- In 3.3.5, use GetSpellName
                    local spellName, spellRank = GetSpellName(actualIndex, "spell")
                    
                    if spellName and spellName ~= "" then
                        -- Get spell texture
                        local texture = GetSpellTexture(actualIndex, "spell")
                        
                        -- Try to get spell ID from link
                        local spellLink = GetSpellLink(actualIndex, "spell")
                        local spellId = nil
                        if spellLink then
                            -- Extract spell ID from link
                            spellId = tonumber(spellLink:match("spell:(%d+)"))
                        end
                        
                        -- Get additional info if we have spell ID
                        local name, rank, icon = spellName, spellRank, texture
                        if spellId then
                            name, rank, icon = GetSpellInfo(spellId)
                        end
                        
                        local spellData = {
                            id = spellId or actualIndex,
                            name = name or spellName,
                            rank = rank or spellRank,
                            icon = icon or texture,
                            tab = tabName,
                            type = "spell"
                        }
                        
                        table.insert(spells, spellData)
                        table.insert(spellsByCategory[tabName], spellData)
                    end
                end
            end
        end
    end
    
    -- Method 2: If tabs don't work, try direct iteration
    if #spells == 0 then
        -- Try to iterate through a reasonable range of spell book slots
        local maxSpells = 500 -- Reasonable maximum for 3.3.5
        for i = 1, maxSpells do
            local spellName, spellRank = GetSpellName(i, "spell")
            
            if spellName and spellName ~= "" then
                local texture = GetSpellTexture(i, "spell")
                local spellLink = GetSpellLink(i, "spell")
                local spellId = nil
                
                if spellLink then
                    spellId = tonumber(spellLink:match("spell:(%d+)"))
                end
                
                -- Get additional info if we have spell ID
                local name, rank, icon = spellName, spellRank, texture
                if spellId then
                    name, rank, icon = GetSpellInfo(spellId)
                end
                
                table.insert(spells, {
                    id = spellId or i,
                    name = name or spellName,
                    rank = rank or spellRank,
                    icon = icon or texture,
                    type = "spell"
                })
            elseif i > 10 and not spellName then
                -- If we hit several empty slots in a row, we're probably done
                break
            end
        end
    end
    
    -- Try to get talents (3.3.5 compatible)
    local numTalentTabs = GetNumTalentTabs and GetNumTalentTabs() or 0
    if numTalentTabs > 0 then
        for tabIndex = 1, numTalentTabs do
            local tabName = GetTalentTabInfo(tabIndex)
            if tabName then
                local numTalents = GetNumTalents(tabIndex)
                for talentIndex = 1, numTalents do
                    local name, iconTexture, tier, column, currentRank, maxRank = GetTalentInfo(tabIndex, talentIndex)
                    if currentRank and currentRank > 0 then
                        -- Try to get spell link for the talent
                        local talentLink = GetTalentLink and GetTalentLink(tabIndex, talentIndex) or nil
                        local spellId = nil
                        
                        if talentLink then
                            spellId = tonumber(talentLink:match("spell:(%d+)"))
                        end
                        
                        table.insert(spells, {
                            id = spellId or (90000 + tabIndex * 100 + talentIndex), -- Fake ID if we can't get real one
                            name = name or "Unknown Talent",
                            rank = currentRank .. "/" .. maxRank,
                            icon = iconTexture,
                            tab = tabName or "Talents",
                            type = "talent"
                        })
                    end
                end
            end
        end
    end
    
    return spells, spellsByCategory
end

-- Handler for server request to read spellbook
function PlayerSpells.handleSpellbookRequest()
    local spells, categories = PlayerSpells.readLocalSpellbook()
    
    if #spells > 0 then
        -- Send spellbook data to server
        -- The server will send it back via receivePlayerSpells
        AIO.Handle("GameMasterSystem", "submitPlayerSpellbook", UnitName("player"), spells)
    else
        print("Unable to read spellbook - no spells found")
    end
end

-- Open the spell manager modal
function PlayerSpells.openSpellManager(playerName, playerEntity)
    currentPlayerName = playerName
    dataLoaded = false  -- Reset the flag when opening
    currentPlayerSpells = {}  -- Clear any previous data
    
    -- Request player spells from server
    AIO.Handle("GameMasterSystem", "getPlayerSpells", playerName)
    
    -- Create the modal while waiting for data
    PlayerSpells.createSpellManagerModal(playerName, playerEntity)
end

-- Create the spell management modal
function PlayerSpells.createSpellManagerModal(playerName, playerEntity)
    -- Create a unique global name for UISpecialFrames support
    local modalName = "GMSpellManagerModal_" .. math.random(100000, 999999)
    
    -- Create styled frame with global name for 3.3.5 compatibility
    local bgColor = (UISTYLE_COLORS and UISTYLE_COLORS.DialogBg) or {0.1, 0.1, 0.1}
    spellManagerModal = CreateFrame("Frame", modalName, UIParent)
    -- Apply UIStyleLibrary styling manually
    spellManagerModal:SetBackdrop(UISTYLE_BACKDROPS.Solid)
    spellManagerModal:SetBackdropColor(bgColor[1], bgColor[2], bgColor[3], 1)
    spellManagerModal:SetFrameStrata("HIGH")
    spellManagerModal:SetWidth(800)
    spellManagerModal:SetHeight(600)
    spellManagerModal:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    spellManagerModal:EnableMouse(true)
    spellManagerModal:SetMovable(true)
    spellManagerModal:RegisterForDrag("LeftButton")
    spellManagerModal:SetScript("OnDragStart", spellManagerModal.StartMoving)
    spellManagerModal:SetScript("OnDragStop", spellManagerModal.StopMovingOrSizing)
    spellManagerModal:SetClampedToScreen(true)
    
    -- Title bar
    local titleBar = CreateFrame("Frame", nil, spellManagerModal)
    titleBar:SetHeight(30)
    titleBar:SetPoint("TOPLEFT", spellManagerModal, "TOPLEFT", 0, 0)
    titleBar:SetPoint("TOPRIGHT", spellManagerModal, "TOPRIGHT", 0, 0)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() spellManagerModal:StartMoving() end)
    titleBar:SetScript("OnDragStop", function() spellManagerModal:StopMovingOrSizing() end)
    
    -- Title text
    local titleText = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("CENTER", titleBar, "CENTER", 0, 0)
    titleText:SetText("Spell Manager: " .. playerName)
    titleText:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    -- Close button using UIStyleLibrary
    local closeButton = CreateStyledButton(spellManagerModal, "X", 24, 24)
    closeButton:SetPoint("TOPRIGHT", spellManagerModal, "TOPRIGHT", -5, -5)
    closeButton:SetFrameLevel(spellManagerModal:GetFrameLevel() + 2)  -- Ensure button is above other elements
    closeButton:EnableMouse(true)  -- Explicitly enable mouse
    closeButton:SetScript("OnClick", function()
        spellManagerModal:Hide()
    end)
    closeButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Close")
        GameTooltip:Show()
    end)
    closeButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Add to UISpecialFrames for proper ESC key handling
    tinsert(UISpecialFrames, modalName)
    
    -- Also support direct ESC handling as backup
    spellManagerModal:EnableKeyboard(true)
    spellManagerModal:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:Hide()
            -- In 3.3.5, keys naturally propagate unless explicitly handled
        end
        -- Other keys will naturally propagate in 3.3.5
    end)
    
    -- Bottom button panel
    local buttonPanel = CreateFrame("Frame", nil, spellManagerModal)
    buttonPanel:SetHeight(40)
    buttonPanel:SetPoint("BOTTOMLEFT", spellManagerModal, "BOTTOMLEFT", 10, 5)
    buttonPanel:SetPoint("BOTTOMRIGHT", spellManagerModal, "BOTTOMRIGHT", -10, 5)
    
    -- Refresh button
    local refreshBtn = CreateStyledButton(buttonPanel, "Refresh", 100, 30)
    refreshBtn:SetPoint("BOTTOMLEFT", buttonPanel, "BOTTOMLEFT", 0, 0)
    refreshBtn:SetScript("OnClick", function()
        AIO.Handle("GameMasterSystem", "getPlayerSpells", playerName)
    end)
    
    -- Learn Spell button
    local learnBtn = CreateStyledButton(buttonPanel, "Learn Spell", 120, 30)
    learnBtn:SetPoint("LEFT", refreshBtn, "RIGHT", 5, 0)
    learnBtn:SetScript("OnClick", function()
        -- Use the existing comprehensive spell selection dialog
        -- Access GMMenus dynamically since it loads after this module
        if _G.GMMenus and _G.GMMenus.createSpellSelectionDialog then
            _G.GMMenus.createSpellSelectionDialog(playerName, "learn")
        else
            -- Enhanced debug info to help troubleshoot
            if not _G.GMMenus then
                CreateStyledToast("GMMenus module not loaded yet - check load order", 4, 0.5)
                print("[PlayerSpells] GMMenus module not available at runtime")
            elseif not _G.GMMenus.createSpellSelectionDialog then
                CreateStyledToast("Spell selection dialog function not available", 4, 0.5)
                print("[PlayerSpells] GMMenus.createSpellSelectionDialog function not found")
            else
                CreateStyledToast("Unknown issue with spell selection system", 4, 0.5)
                print("[PlayerSpells] Unknown issue accessing spell selection dialog")
            end
        end
    end)
    
    -- Close button
    local closeBtn = CreateStyledButton(buttonPanel, "Close", 100, 30)
    closeBtn:SetPoint("BOTTOMRIGHT", buttonPanel, "BOTTOMRIGHT", 0, 0)
    closeBtn:SetScript("OnClick", function()
        spellManagerModal:Hide()
    end)
    
    -- Create content area
    local content = CreateFrame("Frame", nil, spellManagerModal)
    content:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 10, -10)
    content:SetPoint("BOTTOMRIGHT", buttonPanel, "TOPRIGHT", -10, 10)
    
    -- Info panel
    local infoPanelBgColor = (UISTYLE_COLORS and UISTYLE_COLORS.SectionBg) or {0.12, 0.12, 0.12}
    local infoPanel = CreateStyledFrame(content, infoPanelBgColor)
    infoPanel:SetHeight(30)
    infoPanel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
    infoPanel:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, 0)
    
    local infoText = infoPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoText:SetPoint("LEFT", infoPanel, "LEFT", 10, 0)
    infoText:SetText(string.format("Player: %s | Level %d %s", 
        playerName, 
        playerEntity.level or 1, 
        playerEntity.class or "Unknown"))
    infoText:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    spellManagerModal.infoText = infoText
    
    -- Create search box with smarter callback
    local isInitializing = true
    local searchCallback = function(text, userInput)
        -- During initialization, ignore empty text changes
        if isInitializing and (not text or text == "") then
            return
        end
        
        -- Mark as no longer initializing after first real interaction
        if text and text ~= "" then
            isInitializing = false
        end
        
        -- Only filter if data has been loaded
        if dataLoaded then
            PlayerSpells.filterSpells(text)
        end
    end
    
    local searchBox = CreateStyledSearchBox(content, 300, "Search spells...", searchCallback)
    searchBox:SetPoint("TOP", infoPanel, "BOTTOM", 0, -10)
    spellManagerModal.searchBox = searchBox
    
    -- Mark as initialized after a brief moment
    local initTimer = CreateFrame("Frame")
    local elapsed = 0
    initTimer:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= 0.2 then
            isInitializing = false
            self:SetScript("OnUpdate", nil)
        end
    end)
    
    -- Spell count label
    local spellCountLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spellCountLabel:SetPoint("TOP", searchBox, "BOTTOM", 0, -5)
    spellCountLabel:SetText("Loading spells...")
    spellCountLabel:SetTextColor(0.7, 0.7, 0.7)
    spellManagerModal.spellCountLabel = spellCountLabel
    
    -- Create two-column layout
    -- Use a safe color fallback in case UISTYLE_COLORS is not loaded properly
    local panelBgColor = (UISTYLE_COLORS and UISTYLE_COLORS.OptionBg) or {0.08, 0.08, 0.08}
    
    local leftPanel = CreateStyledFrame(content, panelBgColor)
    leftPanel:SetWidth(380)
    leftPanel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -80)
    leftPanel:SetPoint("BOTTOMLEFT", content, "BOTTOMLEFT", 0, 0)
    
    local rightPanel = CreateStyledFrame(content, panelBgColor)
    rightPanel:SetPoint("TOPLEFT", leftPanel, "TOPRIGHT", 10, 0)
    rightPanel:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
    
    -- Left panel: Spell list
    local leftTitle = leftPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    leftTitle:SetPoint("TOP", leftPanel, "TOP", 0, -10)
    leftTitle:SetText("Known Spells")
    leftTitle:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    -- Scrollable spell list
    local listContainer = CreateFrame("Frame", nil, leftPanel)
    listContainer:SetPoint("TOPLEFT", leftPanel, "TOPLEFT", 5, -35)
    listContainer:SetPoint("BOTTOMRIGHT", leftPanel, "BOTTOMRIGHT", -5, 5)
    
    -- Create scrollable area with error handling
    local scrollContainer, scrollContent, scrollBar, updateScroll
    local success, result = pcall(function()
        return {CreateScrollableFrame(
            listContainer,
            listContainer:GetWidth() - 4,
            listContainer:GetHeight() - 4
        )}
    end)
    
    if success and result then
        scrollContainer, scrollContent, scrollBar, updateScroll = unpack(result)
        if scrollContainer then
            scrollContainer:SetPoint("TOPLEFT", 2, -2)
        end
    else
        -- Fallback: Create simple scrollable area without styled scrollbar
        scrollContainer = CreateFrame("ScrollFrame", nil, listContainer)
        scrollContainer:SetPoint("TOPLEFT", 2, -2)
        scrollContainer:SetPoint("BOTTOMRIGHT", -14, 2)
        
        scrollContent = CreateFrame("Frame", nil, listContainer)
        scrollContent:SetWidth(listContainer:GetWidth() - 20)
        scrollContainer:SetScrollChild(scrollContent)
        
        -- Simple scrollbar
        scrollBar = CreateFrame("Slider", nil, listContainer, "UIPanelScrollBarTemplate")
        scrollBar:SetPoint("TOPRIGHT", -2, -18)
        scrollBar:SetPoint("BOTTOMRIGHT", -2, 18)
        scrollBar:SetMinMaxValues(0, 100)
        scrollBar:SetValue(0)
        scrollBar:SetWidth(16)
        scrollBar:SetScript("OnValueChanged", function(self, value)
            scrollContainer:SetVerticalScroll(value)
        end)
        
        updateScroll = function()
            local contentHeight = scrollContent:GetHeight()
            local frameHeight = scrollContainer:GetHeight()
            if contentHeight > frameHeight then
                scrollBar:SetMinMaxValues(0, contentHeight - frameHeight)
                scrollBar:Show()
            else
                scrollBar:Hide()
            end
        end
        
        -- Mouse wheel support
        scrollContainer:EnableMouseWheel(true)
        scrollContainer:SetScript("OnMouseWheel", function(self, delta)
            local current = scrollBar:GetValue()
            local min, max = scrollBar:GetMinMaxValues()
            local step = 20
            if delta > 0 then
                scrollBar:SetValue(math.max(min, current - step))
            else
                scrollBar:SetValue(math.min(max, current + step))
            end
        end)
    end
    
    spellManagerModal.scrollContent = scrollContent
    spellManagerModal.updateScroll = updateScroll
    spellManagerModal.spellRows = {}
    
    -- Right panel: Spell actions
    local rightTitle = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    rightTitle:SetPoint("TOP", rightPanel, "TOP", 0, -10)
    rightTitle:SetText("Spell Actions")
    rightTitle:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    -- Selected spell info
    local sectionBgColor = (UISTYLE_COLORS and UISTYLE_COLORS.SectionBg) or {0.12, 0.12, 0.12}
    local selectedSpellFrame = CreateStyledFrame(rightPanel, sectionBgColor)
    selectedSpellFrame:SetHeight(80)
    selectedSpellFrame:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, -35)
    selectedSpellFrame:SetPoint("TOPRIGHT", rightPanel, "TOPRIGHT", -10, -35)
    
    local selectedIcon = selectedSpellFrame:CreateTexture(nil, "ARTWORK")
    selectedIcon:SetSize(48, 48)
    selectedIcon:SetPoint("LEFT", selectedSpellFrame, "LEFT", 10, 0)
    selectedIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    spellManagerModal.selectedIcon = selectedIcon
    
    local selectedName = selectedSpellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    selectedName:SetPoint("TOPLEFT", selectedIcon, "TOPRIGHT", 10, -5)
    selectedName:SetText("No spell selected")
    selectedName:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    spellManagerModal.selectedName = selectedName
    
    local selectedId = selectedSpellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    selectedId:SetPoint("TOPLEFT", selectedName, "BOTTOMLEFT", 0, -5)
    selectedId:SetText("")
    selectedId:SetTextColor(0.7, 0.7, 0.7)
    spellManagerModal.selectedId = selectedId
    
    -- Store detail panel references for clearing later
    spellManagerModal.detailPanel = {
        spellName = selectedName,
        spellId = selectedId,
        spellIcon = selectedIcon
    }
    
    -- Action buttons
    local actionY = -130
    local buttonHeight = 30
    local buttonSpacing = 5
    
    -- Cast Actions
    local castHeader = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    castHeader:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    castHeader:SetText("Cast Actions:")
    castHeader:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    actionY = actionY - 20
    
    local castOnSelfBtn = CreateStyledButton(rightPanel, "Cast on Self", 150, buttonHeight)
    castOnSelfBtn:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    castOnSelfBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellCastOnSelf", currentPlayerName, selectedSpell.id)
        end
    end)
    
    local castOnTargetBtn = CreateStyledButton(rightPanel, "Cast on Target", 150, buttonHeight)
    castOnTargetBtn:SetPoint("LEFT", castOnSelfBtn, "RIGHT", buttonSpacing, 0)
    castOnTargetBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellCastOnTarget", currentPlayerName, selectedSpell.id)
        end
    end)
    
    actionY = actionY - buttonHeight - buttonSpacing
    
    local castFromTargetBtn = CreateStyledButton(rightPanel, "Cast from Player", 150, buttonHeight)
    castFromTargetBtn:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    castFromTargetBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellCastFromPlayer", currentPlayerName, selectedSpell.id)
        end
    end)
    
    actionY = actionY - buttonHeight - 15
    
    -- Aura Actions
    local auraHeader = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    auraHeader:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    auraHeader:SetText("Aura Actions:")
    auraHeader:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    actionY = actionY - 20
    
    local applyAuraBtn = CreateStyledButton(rightPanel, "Apply as Aura", 150, buttonHeight)
    applyAuraBtn:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    applyAuraBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellApplyAura", currentPlayerName, selectedSpell.id)
        end
    end)
    
    local removeAuraBtn = CreateStyledButton(rightPanel, "Remove Aura", 150, buttonHeight)
    removeAuraBtn:SetPoint("LEFT", applyAuraBtn, "RIGHT", buttonSpacing, 0)
    removeAuraBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellRemoveAura", currentPlayerName, selectedSpell.id)
        end
    end)
    
    actionY = actionY - buttonHeight - 15
    
    -- Cooldown Actions
    local cdHeader = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    cdHeader:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    cdHeader:SetText("Cooldown Actions:")
    cdHeader:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    actionY = actionY - 20
    
    local resetCooldownBtn = CreateStyledButton(rightPanel, "Reset Cooldown", 150, buttonHeight)
    resetCooldownBtn:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    resetCooldownBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellResetCooldown", currentPlayerName, selectedSpell.id)
        end
    end)
    
    local checkCooldownBtn = CreateStyledButton(rightPanel, "Check Cooldown", 150, buttonHeight)
    checkCooldownBtn:SetPoint("LEFT", resetCooldownBtn, "RIGHT", buttonSpacing, 0)
    checkCooldownBtn:SetScript("OnClick", function()
        if selectedSpell then
            AIO.Handle("GameMasterSystem", "playerSpellCheckCooldown", currentPlayerName, selectedSpell.id)
        end
    end)
    
    actionY = actionY - buttonHeight - 15
    
    -- Management Actions
    local mgmtHeader = rightPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mgmtHeader:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    mgmtHeader:SetText("Management:")
    mgmtHeader:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    
    actionY = actionY - 20
    
    local unlearnBtn = CreateStyledButton(rightPanel, "Unlearn Spell", 150, buttonHeight)
    unlearnBtn:SetPoint("TOPLEFT", rightPanel, "TOPLEFT", 10, actionY)
    unlearnBtn:SetScript("OnClick", function()
        if selectedSpell then
            PlayerSpells.showUnlearnConfirmation({
                id = selectedSpell.id,
                name = selectedSpell.name,
                playerName = currentPlayerName
            })
        end
    end)
    
    local resetAllCdBtn = CreateStyledButton(rightPanel, "Reset All Cooldowns", 150, buttonHeight)
    resetAllCdBtn:SetPoint("LEFT", unlearnBtn, "RIGHT", buttonSpacing, 0)
    resetAllCdBtn:SetScript("OnClick", function()
        AIO.Handle("GameMasterSystem", "playerResetAllCooldowns", currentPlayerName)
    end)
    
    -- Store references
    spellManagerModal.leftPanel = leftPanel
    spellManagerModal.rightPanel = rightPanel
    spellManagerModal.actionButtons = {
        castOnSelfBtn, castOnTargetBtn, castFromTargetBtn,
        applyAuraBtn, removeAuraBtn,
        resetCooldownBtn, checkCooldownBtn,
        unlearnBtn, resetAllCdBtn
    }
    
    -- Show the modal
    spellManagerModal:Show()
    
    -- Modal show/hide handlers (SetPropagateKeyboardInput not available in 3.3.5)
    spellManagerModal:SetScript("OnShow", function(self)
        -- Keys naturally propagate in 3.3.5
    end)
    
    spellManagerModal:SetScript("OnHide", function(self)
        -- Clean up when hiding
    end)
    
    return spellManagerModal
end

-- Update spell list
function PlayerSpells.updateSpellList(spells)
    if not spellManagerModal then return end
    
    -- Ensure spells is a table
    if type(spells) ~= "table" then
        spells = {}
    end
    
    -- Debug: Log when updating spell list (commented out for production)
    -- print(string.format("[PlayerSpells] Updating spell list with %d spells (dataLoaded: %s)", 
    --     #spells, tostring(dataLoaded)))
    
    -- Clear existing rows
    if spellManagerModal.spellRows then
        for _, row in ipairs(spellManagerModal.spellRows) do
            if row then
                row:Hide()
                row:SetParent(nil)
            end
        end
        wipe(spellManagerModal.spellRows)
    else
        spellManagerModal.spellRows = {}
    end
    
    -- Update count
    if spellManagerModal.spellCountLabel then
        spellManagerModal.spellCountLabel:SetText(string.format("Showing %d spells", #spells))
    end
    
    -- Create spell rows
    for i, spellData in ipairs(spells) do
        local row = PlayerSpells.createSpellRow(spellManagerModal.scrollContent, spellData, i)
        table.insert(spellManagerModal.spellRows, row)
    end
    
    -- Update scroll content height
    if spellManagerModal.scrollContent and spellManagerModal.updateScroll then
        spellManagerModal.scrollContent:SetHeight(math.max(400, #spells * 35 + 10))
        spellManagerModal.updateScroll()
    end
end

-- Helper function to truncate long spell names
function PlayerSpells.truncateSpellName(name, maxLength)
    maxLength = maxLength or 25  -- Default max length
    
    if not name or #name <= maxLength then
        return name
    end
    
    -- Try to truncate at a word boundary if possible
    local truncated = name:sub(1, maxLength - 3)  -- Leave room for "..."
    
    -- Find last space before max length for cleaner truncation
    local lastSpace = truncated:find(" [^ ]*$")  -- Find last space
    if lastSpace and lastSpace > 15 then  -- Only use word boundary if we have at least 15 chars
        truncated = name:sub(1, lastSpace - 1)
    end
    
    return truncated .. "..."
end

-- Create a spell row in the list
function PlayerSpells.createSpellRow(parent, spellData, index)
    local rowBgColor = (UISTYLE_COLORS and UISTYLE_COLORS.SectionBg) or {0.12, 0.12, 0.12}
    local row = CreateStyledFrame(parent, rowBgColor)
    row:SetHeight(30)
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, -5 - ((index - 1) * 35))
    row:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -25, -5 - ((index - 1) * 35))
    
    -- Enable mouse for selection
    row:EnableMouse(true)
    
    -- Icon container for overlays
    local iconContainer = CreateFrame("Frame", nil, row)
    iconContainer:SetSize(24, 24)
    iconContainer:SetPoint("LEFT", row, "LEFT", 5, 0)
    
    -- Icon
    local icon = iconContainer:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints()
    
    -- Try to get icon from client API first, fallback to provided icon
    local spellIcon = GetSpellTexture(spellData.id) or spellData.icon
    icon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
    
    -- Aura indicator overlay (green glow for active auras)
    local auraIndicator = iconContainer:CreateTexture(nil, "OVERLAY")
    auraIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill")
    auraIndicator:SetAllPoints()
    auraIndicator:SetBlendMode("ADD")
    auraIndicator:SetVertexColor(0, 1, 0, 0.3)
    auraIndicator:Hide()
    row.auraIndicator = auraIndicator
    
    -- Cooldown overlay (gray out with clock sweep)
    local cooldownOverlay = iconContainer:CreateTexture(nil, "OVERLAY", nil, 1)
    cooldownOverlay:SetAllPoints()
    cooldownOverlay:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    cooldownOverlay:SetVertexColor(0, 0, 0, 0.6)
    cooldownOverlay:Hide()
    row.cooldownOverlay = cooldownOverlay
    
    -- Cooldown text
    local cooldownText = iconContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    cooldownText:SetPoint("CENTER", iconContainer, "CENTER", 0, 0)
    cooldownText:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
    cooldownText:Hide()
    row.cooldownText = cooldownText
    
    -- Spell name with color coding
    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", iconContainer, "RIGHT", 5, 0)
    nameText:SetJustifyH("LEFT")
    
    -- Color code by type
    local fullName = spellData.name or "Unknown"
    -- Use consistent truncation length now that we're not showing category
    local displayName = PlayerSpells.truncateSpellName(fullName, 32)  -- Truncate long names
    
    -- Add rank if present (but keep it short)
    if spellData.rank and spellData.rank ~= "" then
        local rankText = spellData.rank
        -- Truncate rank if needed
        if #rankText > 10 then
            rankText = rankText:sub(1, 7) .. "..."
        end
        displayName = displayName .. " (" .. rankText .. ")"
    end
    
    nameText:SetText(displayName)
    
    -- Store full name for tooltip
    row.fullSpellName = fullName
    row.spellRank = spellData.rank
    
    -- Set color based on spell type
    if spellData.type == "talent" then
        nameText:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3]) -- White for talents
    elseif spellData.disabled == 1 then
        nameText:SetTextColor(0.5, 0.5, 0.5) -- Gray for disabled
    elseif spellData.active == 0 then
        nameText:SetTextColor(0.7, 0.7, 0.7) -- Light gray for inactive
    else
        nameText:SetTextColor(1, 1, 1) -- White for normal
    end
    
    -- Spell ID (positioned on the right)
    local idText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    idText:SetPoint("RIGHT", row, "RIGHT", -10, 0)
    idText:SetText("ID: " .. (spellData.id or 0))
    idText:SetTextColor(0.7, 0.7, 0.7)
    idText:SetWidth(60)  -- Fixed width for ID text
    idText:SetJustifyH("RIGHT")
    
    -- Set width for name text to prevent overlap with ID
    -- Calculate available width: total width - icon(24) - icon margin(5) - id(60) - margins
    local nameWidth = 350 - 24 - 5 - 60 - 20  -- Much more space for the name now
    nameText:SetWidth(nameWidth)
    nameText:SetWordWrap(false)  -- Don't wrap text
    
    -- Selection highlight
    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
    highlight:SetBlendMode("ADD")
    highlight:SetAlpha(0.3)
    
    -- Click handler with keyboard modifiers
    row:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            -- Check for keyboard modifiers for quick actions
            if IsControlKeyDown() then
                -- Ctrl+Click = Cast on player
                AIO.Handle("GameMasterSystem", "playerSpellCastOnSelf", currentPlayerName, spellData.id)
                CreateStyledToast("Casting " .. spellData.name .. " on " .. currentPlayerName, 2, 0.5)
                return
            elseif IsShiftKeyDown() then
                -- Shift+Click = Apply as aura
                AIO.Handle("GameMasterSystem", "playerSpellApplyAura", currentPlayerName, spellData.id)
                CreateStyledToast("Applying " .. spellData.name .. " as aura to " .. currentPlayerName, 2, 0.5)
                -- Update visual state after a moment
                PlayerSpells.scheduleUpdate(0.5, function()
                    PlayerSpells.updateSpellRowState(self, spellData)
                end)
                return
            elseif IsAltKeyDown() then
                -- Alt+Click = Reset cooldown
                AIO.Handle("GameMasterSystem", "playerSpellResetCooldown", currentPlayerName, spellData.id)
                CreateStyledToast("Reset cooldown for " .. spellData.name, 2, 0.5)
                -- Update visual state after a moment
                PlayerSpells.scheduleUpdate(0.5, function()
                    PlayerSpells.updateSpellRowState(self, spellData)
                end)
                return
            end
            
            -- Normal click - select row
            -- Deselect all other rows
            for _, otherRow in ipairs(spellManagerModal.spellRows) do
                if otherRow.selected then
                    otherRow.selected = false
                    otherRow:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
                end
            end
            
            -- Select this row
            self.selected = true
            self:SetBackdropBorderColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
            
            -- Update selected spell
            selectedSpell = spellData
            PlayerSpells.updateSelectedSpell(spellData)
            
        elseif button == "RightButton" then
            -- Show context menu for this spell
            PlayerSpells.showSpellContextMenu(spellData)
        end
    end)
    
    -- Enhanced tooltip with keyboard shortcuts
    row:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        
        -- Try to set spell tooltip first
        GameTooltip:SetSpellByID(spellData.id)
        
        -- If no spell tooltip available, or we want to show the full name
        if GameTooltip:NumLines() == 0 then
            -- Show full spell name (especially useful for truncated names)
            local fullNameWithRank = self.fullSpellName or spellData.name or "Unknown Spell"
            if self.spellRank and self.spellRank ~= "" then
                fullNameWithRank = fullNameWithRank .. " (" .. self.spellRank .. ")"
            end
            GameTooltip:SetText(fullNameWithRank, 1, 1, 1)
            GameTooltip:AddLine("Spell ID: " .. (spellData.id or 0), 0.7, 0.7, 0.7)
            
            -- Add type information
            if spellData.type == "talent" then
                GameTooltip:AddLine("Type: Talent", 1, 0.8, 0)
            else
                GameTooltip:AddLine("Type: Spell", 0.6, 0.8, 1)
            end
        else
            -- Spell tooltip exists
            if self.fullSpellName and #self.fullSpellName > 32 then
                -- If name was truncated, add full name
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Full name: " .. self.fullSpellName, 1, 0.8, 0)
            end
            
            -- Add type info to existing tooltip
            if spellData.type then
                GameTooltip:AddLine(" ")
                if spellData.type == "talent" then
                    GameTooltip:AddLine("Type: Talent", 1, 0.8, 0)
                else
                    GameTooltip:AddLine("Type: Spell", 0.6, 0.8, 1)
                end
            end
        end
        
        -- Add visual state info
        if self.auraIndicator and self.auraIndicator:IsShown() then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Active Aura", 0, 1, 0)
        end
        if self.cooldownOverlay and self.cooldownOverlay:IsShown() then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("On Cooldown", UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
        end
        
        -- Add keyboard shortcuts
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Quick Actions:", 1, 0.8, 0)
        GameTooltip:AddLine("Left-click: Select", 0.5, 0.5, 0.5)
        GameTooltip:AddLine("Right-click: Context menu", 0.5, 0.5, 0.5)
        GameTooltip:AddLine("Ctrl+Click: Cast on player", 0.5, 0.5, 0.5)
        GameTooltip:AddLine("Shift+Click: Apply as aura", 0.5, 0.5, 0.5)
        GameTooltip:AddLine("Alt+Click: Reset cooldown", 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    
    row:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    row.spellData = spellData
    row.iconContainer = iconContainer
    
    -- Check and display initial state
    PlayerSpells.updateSpellRowState(row, spellData)
    
    return row
end

-- Update spell row visual state based on aura/cooldown status
function PlayerSpells.updateSpellRowState(row, spellData)
    if not row or not spellData then return end
    
    -- Check if player has this aura active (client-side check)
    if currentPlayerName == UnitName("player") then
        -- Can check local player's auras
        if UnitAura("player", spellData.name) then
            row.auraIndicator:Show()
        else
            row.auraIndicator:Hide()
        end
        
        -- Check cooldown
        local start, duration, enabled = GetSpellCooldown(spellData.name)
        if start and duration and duration > 1.5 then
            -- Spell is on cooldown
            row.cooldownOverlay:Show()
            local remaining = math.ceil(duration - (GetTime() - start))
            if remaining > 0 then
                row.cooldownText:SetText(remaining)
                row.cooldownText:Show()
            else
                row.cooldownText:Hide()
            end
        else
            row.cooldownOverlay:Hide()
            row.cooldownText:Hide()
        end
    else
        -- For other players, we'd need server updates
        -- Hide indicators for now
        row.auraIndicator:Hide()
        row.cooldownOverlay:Hide()
        row.cooldownText:Hide()
    end
end

-- Update all spell row states (call this periodically or after actions)
function PlayerSpells.updateAllSpellStates()
    if not spellManagerModal or not spellManagerModal.spellRows then return end
    
    for _, row in ipairs(spellManagerModal.spellRows) do
        if row and row.spellData and row:IsVisible() then
            PlayerSpells.updateSpellRowState(row, row.spellData)
        end
    end
end

-- Simple timer implementation for 3.3.5 (no C_Timer)
local updateTimers = {}
local timerFrame = CreateFrame("Frame")
timerFrame:SetScript("OnUpdate", function(self, elapsed)
    for i = #updateTimers, 1, -1 do
        local timer = updateTimers[i]
        timer.time = timer.time - elapsed
        if timer.time <= 0 then
            timer.callback()
            table.remove(updateTimers, i)
        end
    end
end)

function PlayerSpells.scheduleUpdate(delay, callback)
    table.insert(updateTimers, {time = delay, callback = callback})
end

-- Update selected spell display
function PlayerSpells.updateSelectedSpell(spellData)
    if not spellManagerModal then return end
    
    -- Update icon
    local spellIcon = GetSpellTexture(spellData.id) or spellData.icon
    spellManagerModal.selectedIcon:SetTexture(spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark")
    
    -- Update name
    spellManagerModal.selectedName:SetText(spellData.name or "Unknown Spell")
    
    -- Update ID
    spellManagerModal.selectedId:SetText(string.format("ID: %d", spellData.id or 0))
    
    -- Enable action buttons
    for _, btn in ipairs(spellManagerModal.actionButtons) do
        btn:Enable()
    end
end

-- Filter spells
function PlayerSpells.filterSpells(searchText)
    -- Debug (commented out for production)
    -- print(string.format("[PlayerSpells] filterSpells called with text: '%s', dataLoaded: %s", 
    --     searchText or "nil", tostring(dataLoaded)))
    
    -- Don't filter if data hasn't been loaded yet
    if not dataLoaded then
        -- print("[PlayerSpells] Data not loaded, skipping filter")
        return
    end
    
    -- Ensure currentPlayerSpells is a table
    if type(currentPlayerSpells) ~= "table" then
        currentPlayerSpells = {}
    end
    
    if not searchText or searchText == "" then
        PlayerSpells.updateSpellList(currentPlayerSpells)
        return
    end
    
    searchText = searchText:lower()
    local filtered = {}
    
    for _, spell in ipairs(currentPlayerSpells) do
        if spell and type(spell) == "table" then
            local name = (spell.name or ""):lower()
            local id = tostring(spell.id or 0)
            
            if name:find(searchText, 1, true) or id:find(searchText, 1, true) then
                table.insert(filtered, spell)
            end
        end
    end
    
    PlayerSpells.updateSpellList(filtered)
end

-- Show context menu for spell
function PlayerSpells.showSpellContextMenu(spellData)
    -- Create context menu using MenuFactory if available
    if GMMenus and GMMenus.MenuFactory and GMMenus.MenuFactory.createPlayerSpellMenu then
        local menu = GMMenus.MenuFactory.createPlayerSpellMenu(spellData, currentPlayerName)
        ShowStyledEasyMenu(menu, "cursor")
    else
        -- Fallback to enhanced inline menu
        local menu = {
            {
                text = "Spell: " .. (spellData.name or "Unknown"),
                isTitle = true,
                notCheckable = true,
            },
            {
                text = "Cast Spell",
                hasArrow = true,
                menuList = {
                    {
                        text = "Cast on Player",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellCastOnSelf", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Cast on Player",
                        tooltipText = "Make the player cast this spell on themselves",
                    },
                    {
                        text = "Cast on Target",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellCastOnTarget", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Cast on Target",
                        tooltipText = "Make the player cast this spell on their current target",
                    },
                    {
                        text = "Cast from Player",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellCastFromPlayer", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Cast from Player",
                        tooltipText = "Make the player cast this spell on you",
                    },
                },
                notCheckable = true,
            },
            {
                text = "Apply as Aura",
                hasArrow = true,
                menuList = {
                    {
                        text = "Apply to Player",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellApplyAura", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Apply Aura",
                        tooltipText = "Apply this spell as a persistent aura/buff on the player",
                    },
                    { isSeparator = true },
                    {
                        text = "Apply with Duration",
                        hasArrow = true,
                        menuList = {
                            {
                                text = "1 Minute",
                                func = function()
                                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", currentPlayerName, spellData.id, 60000)
                                end,
                                notCheckable = true,
                            },
                            {
                                text = "10 Minutes",
                                func = function()
                                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", currentPlayerName, spellData.id, 600000)
                                end,
                                notCheckable = true,
                            },
                            {
                                text = "1 Hour",
                                func = function()
                                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", currentPlayerName, spellData.id, 3600000)
                                end,
                                notCheckable = true,
                            },
                            {
                                text = "24 Hours",
                                func = function()
                                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", currentPlayerName, spellData.id, 86400000)
                                end,
                                notCheckable = true,
                            },
                            {
                                text = "Permanent",
                                func = function()
                                    AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", currentPlayerName, spellData.id, -1)
                                end,
                                notCheckable = true,
                                tooltipTitle = "Permanent",
                                tooltipText = "Apply until death or manual removal",
                            },
                            { isSeparator = true },
                            {
                                text = "Custom Duration...",
                                func = function()
                                    PlayerSpells.showCustomDurationDialog(spellData)
                                end,
                                notCheckable = true,
                                tooltipTitle = "Custom Duration",
                                tooltipText = "Enter a custom duration in seconds",
                            },
                        },
                        notCheckable = true,
                    },
                    { isSeparator = true },
                    {
                        text = "Remove This Aura",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellRemoveAura", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Remove Aura",
                        tooltipText = "Remove only this specific aura from the player",
                    },
                    {
                        text = "Check Aura Info",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerGetAuraInfo", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Aura Info",
                        tooltipText = "Display duration, stacks, and caster information",
                    },
                },
                notCheckable = true,
            },
            {
                text = "Cooldown Management",
                hasArrow = true,
                menuList = {
                    {
                        text = "Reset This Cooldown",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellResetCooldown", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Reset Cooldown",
                        tooltipText = "Remove the cooldown from this specific spell",
                    },
                    {
                        text = "Reset All Cooldowns",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerResetAllCooldowns", currentPlayerName)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Reset All",
                        tooltipText = "Remove cooldowns from ALL spells for this player",
                    },
                    {
                        text = "Check Cooldown Status",
                        func = function()
                            AIO.Handle("GameMasterSystem", "playerSpellCheckCooldown", currentPlayerName, spellData.id)
                        end,
                        notCheckable = true,
                        tooltipTitle = "Check Status",
                        tooltipText = "Display remaining cooldown time for this spell",
                    },
                },
                notCheckable = true,
            },
            { isSeparator = true },
            {
                text = "Unlearn Spell",
                func = function()
                    PlayerSpells.showUnlearnConfirmation({
                        id = spellData.id,
                        name = spellData.name,
                        playerName = currentPlayerName
                    })
                end,
                notCheckable = true,
                tooltipTitle = "Unlearn Spell",
                tooltipText = "Make the player permanently unlearn this spell",
            },
            { isSeparator = true },
            {
                text = "Cancel",
                func = function() end,
                notCheckable = true,
            },
        }
        
        ShowStyledEasyMenu(menu, "cursor")
    end
end

-- [DEPRECATED] Show learn spell dialog - Now using GMMenus.createSpellSelectionDialog
-- This function is kept for backwards compatibility but redirects to the main spell selection system
function PlayerSpells.showLearnSpellDialog(playerName)
    -- Redirect to the comprehensive spell selection dialog (dynamic access)
    if _G.GMMenus and _G.GMMenus.createSpellSelectionDialog then
        _G.GMMenus.createSpellSelectionDialog(playerName, "learn")
    else
        CreateStyledToast("Spell selection system not available", 3, 0.5)
    end
end

-- [DEPRECATED] Show spell search dialog for learning - Now integrated into main spell selection
function PlayerSpells.showSpellSearchDialog(playerName, searchText)
    -- Redirect to the comprehensive spell selection dialog (dynamic access)
    if _G.GMMenus and _G.GMMenus.createSpellSelectionDialog then
        _G.GMMenus.createSpellSelectionDialog(playerName, "learn")
    else
        CreateStyledToast("Spell selection system not available", 3, 0.5)
    end
end

-- Show custom duration dialog
function PlayerSpells.showCustomDurationDialog(spellData)
    -- Create custom duration dialog
    local dialog = CreateStyledDialog({
        title = "Apply Aura with Custom Duration",
        width = 400,
        height = 250,
        closeOnEscape = true,
    })
    
    -- Content frame
    local content = CreateFrame("Frame", nil, dialog)
    content:SetPoint("TOPLEFT", dialog, "TOPLEFT", 15, -40)
    content:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -15, 60)
    
    -- Spell info
    local spellInfo = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    spellInfo:SetPoint("TOP", content, "TOP", 0, -10)
    spellInfo:SetText(spellData.name or "Unknown Spell")
    
    local spellId = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    spellId:SetPoint("TOP", spellInfo, "BOTTOM", 0, -5)
    spellId:SetText("Spell ID: " .. (spellData.id or 0))
    spellId:SetTextColor(0.7, 0.7, 0.7)
    
    -- Duration input
    local inputLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    inputLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -60)
    inputLabel:SetText("Duration (seconds):")
    
    local inputBox = CreateStyledEditBox(content, 150, true, 10, false)
    inputBox:SetPoint("LEFT", inputLabel, "RIGHT", 10, 0)
    inputBox:SetText("60")
    inputBox:SetFocus()
    inputBox:HighlightText()
    
    -- Quick duration buttons
    local quickLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quickLabel:SetPoint("TOPLEFT", inputLabel, "BOTTOMLEFT", 0, -20)
    quickLabel:SetText("Quick Select:")
    
    local quickButtons = {
        {text = "1m", duration = 60},
        {text = "10m", duration = 600},
        {text = "30m", duration = 1800},
        {text = "1h", duration = 3600},
        {text = "6h", duration = 21600},
        {text = "24h", duration = 86400},
    }
    
    local lastButton = nil
    for i, btn in ipairs(quickButtons) do
        local quickBtn = CreateStyledButton(content, btn.text, 45, 22)
        if i == 1 then
            quickBtn:SetPoint("TOPLEFT", quickLabel, "BOTTOMLEFT", 0, -5)
        else
            quickBtn:SetPoint("LEFT", lastButton, "RIGHT", 5, 0)
        end
        quickBtn:SetScript("OnClick", function()
            inputBox:SetText(tostring(btn.duration))
            inputBox:HighlightText()
        end)
        lastButton = quickBtn
    end
    
    -- Action buttons
    local applyBtn = CreateStyledButton(content, "Apply", 100, 24)
    applyBtn:SetPoint("BOTTOMRIGHT", content, "BOTTOMRIGHT", 0, 0)
    applyBtn:SetScript("OnClick", function()
        local duration = tonumber(inputBox:GetText())
        if duration and duration > 0 then
            -- Convert seconds to milliseconds
            local durationMs = duration * 1000
            AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", currentPlayerName, spellData.id, durationMs)
            dialog:Hide()
            CreateStyledToast(string.format("Applied %s for %d seconds", spellData.name, duration), 2, 0.5)
        else
            CreateStyledToast("Invalid duration! Please enter a positive number.", 3, 0.5)
        end
    end)
    
    local cancelBtn = CreateStyledButton(content, "Cancel", 100, 24)
    cancelBtn:SetPoint("RIGHT", applyBtn, "LEFT", -10, 0)
    cancelBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Handle Enter key
    inputBox:SetScript("OnEnterPressed", function()
        applyBtn:Click()
    end)
    
    dialog:Show()
end

-- Custom unlearn confirmation dialog using standard CreateStyledDialog
function PlayerSpells.showUnlearnConfirmation(spell)
    if not spell or not spell.id then
        return
    end
    
    local targetPlayer = spell.playerName or currentPlayerName or "the player"
    local spellName = spell.name or "Unknown Spell"
    local spellId = spell.id
    
    -- Create dialog using the standard CreateStyledDialog function
    local dialogOptions = {
        title = "Confirm Unlearn Spell",
        message = string.format("Are you sure you want to make %s unlearn:\n\n|cffffcc00%s|r\n(Spell ID: %d)\n\nThis action cannot be undone.",
            targetPlayer,
            spellName,
            spellId),
        width = 400,
        height = 250,
        closeOnEscape = true,
        buttons = {
            {
                text = "Cancel",
                callback = function()
                    -- Dialog will be closed automatically by CreateStyledDialog
                    -- unless closeOnClick is set to false
                end
            },
            {
                text = "Unlearn",
                callback = function()
                    -- Send unlearn request (server will automatically refresh the spell list)
                    AIO.Handle("GameMasterSystem", "playerSpellUnlearn", targetPlayer, spellId)
                    
                    -- Show feedback toast
                    CreateStyledToast(string.format("Unlearning %s...", spellName), 2, 0.5)
                    
                    -- Clear the selected spell since it's being unlearned
                    if selectedSpell and selectedSpell.id == spellId then
                        selectedSpell = nil
                        if spellManagerModal and spellManagerModal.detailPanel then
                            -- Clear the detail panel
                            local detailPanel = spellManagerModal.detailPanel
                            if detailPanel.spellName then
                                detailPanel.spellName:SetText("No spell selected")
                            end
                            if detailPanel.spellId then
                                detailPanel.spellId:SetText("")
                            end
                            if detailPanel.spellIcon then
                                detailPanel.spellIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                            end
                        end
                        
                        -- Disable action buttons since no spell is selected
                        if spellManagerModal and spellManagerModal.actionButtons then
                            for _, btn in ipairs(spellManagerModal.actionButtons) do
                                btn:Disable()
                            end
                        end
                    end
                    
                    -- Dialog will be closed automatically by CreateStyledDialog
                end
            }
        }
    }
    
    local confirmDialog = CreateStyledDialog(dialogOptions)
    confirmDialog:Show()
    
    -- Store reference for cleanup if needed
    PlayerSpells.unlearnConfirmDialog = confirmDialog
end

-- Handle server responses
function PlayerSpells.receivePlayerSpells(spells, isSerialized)
    print(string.format("[PlayerSpells] receivePlayerSpells called - type: %s, isSerialized: %s", 
        type(spells), tostring(isSerialized)))
    
    -- If data is serialized as string, deserialize it
    if isSerialized and type(spells) == "string" then
        -- Load Smallfolk for deserialization
        local smallfolk = nil
        pcall(function()
            if not Smallfolk then
                dofile("Interface/AddOns/AIO_Client/Dep_Smallfolk/smallfolk.lua")
            end
            smallfolk = Smallfolk
        end)
        
        if smallfolk then
            print(string.format("[PlayerSpells] Attempting to deserialize string of length %d", #spells))
            -- Debug: print first 100 chars of the string
            print(string.format("[PlayerSpells] First 100 chars: %s", spells:sub(1, 100)))
            
            local success, decoded = pcall(smallfolk.loads, spells, 100000) -- Increase max size
            if success then
                if type(decoded) == "table" then
                    print(string.format("[PlayerSpells] Deserialized %d spells", #decoded))
                    spells = decoded
                else
                    print(string.format("[PlayerSpells] Deserialization returned non-table: %s", type(decoded)))
                    spells = {}
                end
            else
                print(string.format("[PlayerSpells] Deserialization error: %s", tostring(decoded)))
                spells = {}
            end
        else
            print("[PlayerSpells] Smallfolk not available, cannot deserialize")
            spells = {}
        end
    end
    
    if type(spells) == "table" then
        print(string.format("[PlayerSpells] Processing %d spells", #spells))
        -- Debug: print first spell if available
        if spells[1] then
            print(string.format("[PlayerSpells] First spell: ID=%s, Name=%s", 
                tostring(spells[1].id), tostring(spells[1].name)))
        end
    else
        print(string.format("[PlayerSpells] Invalid spell data type after processing: %s", type(spells)))
        spells = {}
    end
    
    if not spellManagerModal then
        print("[PlayerSpells] Modal not created, ignoring spell data")
        return
    end
    
    print(string.format("[PlayerSpells] Storing %d spells", #spells))
    
    -- Store the spell data globally
    currentPlayerSpells = spells
    
    -- Mark data as loaded BEFORE updating display
    dataLoaded = true
    
    -- Update the display
    PlayerSpells.updateSpellList(spells)
end

-- Handle simplified spell data
function PlayerSpells.receivePlayerSpellsSimple(simpleSpells)
    print(string.format("[PlayerSpells] receivePlayerSpellsSimple called - type: %s", type(simpleSpells)))
    
    if not spellManagerModal then
        print("[PlayerSpells] Modal not created, ignoring spell data")
        return
    end
    
    -- Convert simple format back to full format
    local spells = {}
    if type(simpleSpells) == "table" then
        print(string.format("[PlayerSpells] Processing %d simple spells", #simpleSpells))
        for i, simple in ipairs(simpleSpells) do
            if type(simple) == "table" then
                -- Get additional spell info from client API
                local spellId = simple.i or 0
                local name, rank, icon = GetSpellInfo(spellId)
                
                table.insert(spells, {
                    id = spellId,
                    name = name or simple.n or "Unknown",
                    rank = rank or simple.r or "",
                    icon = icon or "",
                    type = "spell",
                    active = 1,
                    disabled = 0
                })
            end
        end
    else
        print(string.format("[PlayerSpells] Invalid simple spell data type: %s", type(simpleSpells)))
        spells = {}
    end
    
    print(string.format("[PlayerSpells] Converted to %d full spells", #spells))
    
    -- Store the spell data globally
    currentPlayerSpells = spells
    
    -- Mark data as loaded BEFORE updating display
    dataLoaded = true
    
    -- Update the display
    PlayerSpells.updateSpellList(spells)
end

-- Handle spell data as delimited string
function PlayerSpells.receiveSpellString(playerNameOrSpellString, actualSpellString)
    -- Fix: The spell data is coming in the second parameter
    -- First parameter seems to be the player name
    local spellString = actualSpellString or playerNameOrSpellString
    
    -- If actualSpellString exists, use it; otherwise use the first param
    if actualSpellString and type(actualSpellString) == "string" and actualSpellString:find("|") then
        spellString = actualSpellString
    end
    
    -- Debug output (can be removed later)
    -- print(string.format("[PlayerSpells] Using spell string with length: %d", spellString and #spellString or 0))
    
    if not spellManagerModal then
        return
    end
    
    local spells = {}
    local spellCount = 0
    
    if type(spellString) == "string" and spellString ~= "" then
        -- Debug: Show first 200 chars of the string (can be removed later)
        -- print(string.format("[PlayerSpells] Processing: %s", spellString:sub(1, 200)))
        
        -- Split by semicolon to get individual spells
        for spellData in spellString:gmatch("[^;]+") do
            spellCount = spellCount + 1
            -- Split each spell by pipe to get id|name|rank|type|active|disabled
            local parts = {}
            for part in spellData:gmatch("[^|]+") do
                table.insert(parts, part)
            end
            
            if parts[1] then
                local spellId = tonumber(parts[1]) or 0
                local spellName = parts[2] or "Unknown"
                local spellRank = parts[3] or ""
                local spellType = parts[4] or "spell"
                local active = tonumber(parts[5]) or 1
                local disabled = tonumber(parts[6]) or 0
                
                -- Debug output for first few spells (can be removed later)
                -- if spellCount <= 3 then
                --     print(string.format("[PlayerSpells] Spell %d: ID=%d, Name=%s, Type=%s", 
                --         spellCount, spellId, spellName, spellType))
                -- end
                
                -- Get icon from client API (more reliable than server)
                local _, _, icon = GetSpellInfo(spellId)
                
                table.insert(spells, {
                    id = spellId,
                    name = spellName,
                    rank = spellRank,
                    icon = icon or "",
                    type = spellType,
                    active = active,
                    disabled = disabled,
                    tab = spellType == "talent" and "Talents" or "Spells"
                })
            end
        end
        
        -- Debug output (can be removed later)
        -- print(string.format("[PlayerSpells] Parsed %d spells from string", #spells))
    end
    
    -- Store the spell data globally
    currentPlayerSpells = spells
    
    -- Mark data as loaded BEFORE updating display
    dataLoaded = true
    
    -- Update the display
    PlayerSpells.updateSpellList(spells)
end

-- [DEPRECATED] Handle spell search results - Now handled by main handler system
-- This function is no longer used since we use the main spell selection dialog
function PlayerSpells.receiveSpellSearchResults(spells, offset, pageSize, hasMoreData, totalCount)
    -- This function is deprecated and no longer used
    -- Search results are now handled by GMClient_08_Handlers.lua -> GMMenus.updateSpellSearchResults
    print("[PlayerSpells] receiveSpellSearchResults called but deprecated - should use main handler")
end

-- Export functions for server communication
GameMasterSystem.receivePlayerSpells = PlayerSpells.receivePlayerSpells
GameMasterSystem.receivePlayerSpellsSimple = PlayerSpells.receivePlayerSpellsSimple
GameMasterSystem.receiveSpellString = PlayerSpells.receiveSpellString
GameMasterSystem.requestSpellbookData = PlayerSpells.handleSpellbookRequest
-- Note: receiveSpellSearchResults is NOT exported here to avoid conflict with main handler

-- Player Spells module loaded