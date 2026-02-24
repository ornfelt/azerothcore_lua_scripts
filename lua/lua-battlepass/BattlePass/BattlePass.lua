--[[
    Battle Pass Client Addon
    BattlePass.lua

    UI and communication handling for the Battle Pass system.
    Uses CSMH (Client Server Message Handler) for server communication.
]]

-- ============================================================================
-- Saved Variables (initialized on first load)
-- ============================================================================

BattlePassDB = BattlePassDB or {}
BattlePassCharDB = BattlePassCharDB or {}

-- ============================================================================
-- CSMH Configuration
-- ============================================================================

local CSMHConfig = {
    Prefix = "BattlePass",
    Functions = {
        [1] = "BattlePass_OnFullSync",
        [2] = "BattlePass_OnLevelDefinitions",
        [3] = "BattlePass_OnProgressUpdate",
        [4] = "BattlePass_OnClaimResult",
        [5] = "BattlePass_OnError",
    }
}

-- ============================================================================
-- Local Variables
-- ============================================================================

local ADDON_NAME = "BattlePass"

-- Player data
local playerData = {
    level = 0,
    currentExp = 0,
    expRequired = 1000,
    totalExp = 0,
    maxLevel = 100,
    claimedLevels = {},
}

-- Level definitions (populated from server)
local levelDefinitions = {}

-- Config from server
local serverConfig = {}

-- UI state - Horizontal layout
local levelItems = {}  -- Changed from levelRows to levelItems
local scrollOffset = 0
local VISIBLE_ITEMS = 8  -- Number of items visible horizontally
local ITEM_WIDTH = 103   -- Width of each level card (92 + 11 spacing)

-- Timer for delayed actions
local pendingTimer = nil

-- ============================================================================
-- Utility Functions
-- ============================================================================

-- Check if a level is claimed
local function IsLevelClaimed(level)
    return playerData.claimedLevels[level] == true
end

-- Get level status from server data (if available)
-- Status: 0=locked, 1=available, 2=claimed, 3=owned
local function GetLevelStatus(level)
    local levelDef = levelDefinitions[level]
    if levelDef and levelDef.status then
        return levelDef.status
    end

    -- Fallback to old logic if no status from server
    if level > playerData.level then
        return 0  -- Locked
    elseif IsLevelClaimed(level) then
        return 2  -- Claimed
    else
        return 1  -- Available
    end
end

-- Get color for level state
-- Status: 0=locked, 1=available, 2=claimed, 3=owned
local function GetLevelStateColor(level)
    local status = GetLevelStatus(level)

    if status == 0 then
        return 0.3, 0.3, 0.3, 0.9     -- Locked (dark grey)
    elseif status == 1 then
        return 0.15, 0.5, 0.15, 0.9   -- Available (green)
    elseif status == 2 then
        return 0.15, 0.3, 0.6, 0.9    -- Claimed (blue)
    elseif status == 3 then
        return 0.6, 0.4, 0.1, 0.9     -- Already owned (gold)
    end

    return 0.3, 0.3, 0.3, 0.9
end

-- Get status text for a level
-- Status: 0=locked, 1=available, 2=claimed, 3=owned
local function GetLevelStatusText(level)
    local status = GetLevelStatus(level)

    if status == 0 then
        return "|cff888888Locked|r"
    elseif status == 1 then
        return "|cff00ff00Claim!|r"
    elseif status == 2 then
        return "|cff4488ffClaimed|r"
    elseif status == 3 then
        return "|cffffaa00Owned|r"
    end

    return "|cff888888Locked|r"
end

-- ============================================================================
-- CSMH Message Handlers (Server -> Client)
-- ============================================================================

-- Handler for full sync response
-- Receives: { level, currentExp, expRequired, totalExp, maxLevel, claimedLevels (table), config (table) }
function BattlePass_OnFullSync(sender, args)
    if not args or #args < 6 then return end

    playerData.level = args[1] or 0
    playerData.currentExp = args[2] or 0
    playerData.expRequired = args[3] or 1000
    playerData.totalExp = args[4] or 0
    playerData.maxLevel = args[5] or 100

    -- Claimed levels come as a table {1=true, 5=true, ...}
    if type(args[6]) == "table" then
        playerData.claimedLevels = args[6]
    else
        playerData.claimedLevels = {}
    end

    -- Optional config table
    if type(args[7]) == "table" then
        serverConfig = args[7]
    end

    BattlePass_UpdateUI()
end

-- Handler for level definitions
-- Receives: { levels (table of level definitions) }
function BattlePass_OnLevelDefinitions(sender, args)
    if not args or #args < 1 then return end

    local levels = args[1]
    if type(levels) ~= "table" then return end

    -- Process level definitions
    for _, lvl in pairs(levels) do
        if lvl.level then
            levelDefinitions[lvl.level] = {
                level = lvl.level,
                name = lvl.name or "Unknown",
                icon = lvl.icon or "INV_Misc_QuestionMark",
                rewardType = lvl.rewardType or 1,
                count = lvl.count or 1,
                status = lvl.status or 0,  -- 0=locked, 1=available, 2=claimed, 3=owned
            }
        end
    end

    BattlePass_UpdateUI()
end

-- Handler for progress updates
-- Receives: { gainedExp, newLevel, currentExp, expRequired, levelsGained }
function BattlePass_OnProgressUpdate(sender, args)
    if not args or #args < 5 then return end

    local gainedExp = args[1] or 0
    local newLevel = args[2] or playerData.level
    local currentExp = args[3] or 0
    local expRequired = args[4] or 1000
    local levelsGained = args[5] or 0

    -- Show XP gain animation
    if gainedExp > 0 then
        BattlePass_ShowXPGain(gainedExp)
    end

    -- Show level up notification
    if levelsGained > 0 then
        BattlePass_ShowLevelUp(newLevel)
    end

    -- Update player data
    playerData.level = newLevel
    playerData.currentExp = currentExp
    playerData.expRequired = expRequired

    BattlePass_UpdateUI()
end

-- Handler for claim result
-- Receives: { success, level, message, updatedLevels (optional) }
function BattlePass_OnClaimResult(sender, args)
    if not args or #args < 3 then return end

    local success = args[1]
    local level = args[2]
    local message = args[3]

    if success then
        playerData.claimedLevels[level] = true
        print("|cff00ff00[Battle Pass]|r " .. (message or "Reward claimed!"))
    else
        print("|cffff0000[Battle Pass]|r " .. (message or "Failed to claim reward."))
    end

    -- If updated levels table is provided, refresh definitions
    if type(args[4]) == "table" then
        for _, lvl in pairs(args[4]) do
            if lvl.level and levelDefinitions[lvl.level] then
                levelDefinitions[lvl.level].status = lvl.status or 0
            end
        end
    end

    BattlePass_UpdateUI()
end

-- Handler for error messages
-- Receives: { code, message }
function BattlePass_OnError(sender, args)
    if not args or #args < 2 then return end

    local code = args[1] or "UNKNOWN"
    local message = args[2] or "Unknown error"

    print("|cffff0000[Battle Pass Error]|r " .. message)
end

-- ============================================================================
-- Client -> Server Communication
-- ============================================================================

-- Request sync from server
function BattlePass_RequestSync()
    SendClientRequest(CSMHConfig.Prefix, 1)
end

-- Request to claim a specific level
local function RequestClaimLevel(level)
    SendClientRequest(CSMHConfig.Prefix, 2, level)
end

-- Request to claim all available rewards
function BattlePass_ClaimAll()
    SendClientRequest(CSMHConfig.Prefix, 3)
end

-- ============================================================================
-- UI Functions
-- ============================================================================

-- Flag to track if we've initialized
local isInitialized = false

-- Initialize the main frame
function BattlePass_OnFrameLoad(frame)
    if frame then
        frame:RegisterForDrag("LeftButton")
    end
end

-- Initialize level items and register CSMH handlers (called when addon is ready)
local function InitializeAddon()
    if isInitialized then
        return
    end

    -- Verify scroll content exists
    if not BattlePassScrollContent then
        print("|cffff0000[Battle Pass]|r ERROR: BattlePassScrollContent not found")
        return
    end

    -- Create level items dynamically (horizontal layout)
    for i = 1, VISIBLE_ITEMS do
        local itemName = "BattlePassLevelItem"..i
        local item = CreateFrame("Button", itemName, BattlePassScrollContent, "BattlePassLevelItemTemplate")
        if item then
            -- Horizontal positioning: (i-1) * ITEM_WIDTH from left, 0 from top
            item:SetPoint("TOPLEFT", (i-1) * ITEM_WIDTH, 0)
            item.index = i
            levelItems[i] = item
        else
            print("|cffff0000[Battle Pass]|r ERROR: Failed to create item " .. i)
        end
    end

    -- Register CSMH server response handlers
    RegisterServerResponses(CSMHConfig)

    isInitialized = true
end

-- Update the UI with current data
function BattlePass_UpdateUI()
    if not BattlePassFrame or not BattlePassFrame:IsShown() then return end

    -- Update level text
    local levelText = _G["BattlePassLevelText"]
    local maxLevelText = _G["BattlePassMaxLevelText"]

    if levelText then
        levelText:SetText(tostring(playerData.level))
    end

    if maxLevelText then
        maxLevelText:SetText("/ " .. tostring(playerData.maxLevel))
    end

    -- Update progress bar
    if BattlePassProgressBar then
        local progress = playerData.currentExp
        local maxProgress = playerData.expRequired

        -- At max level, show full bar
        if playerData.level >= playerData.maxLevel then
            progress = maxProgress
        end

        -- Ensure we have valid values (avoid division by zero)
        if maxProgress <= 0 then maxProgress = 1 end

        BattlePassProgressBar:SetMinMaxValues(0, maxProgress)
        BattlePassProgressBar:SetValue(progress)

        local progressText = _G["BattlePassProgressText"]
        if progressText then
            if playerData.level >= playerData.maxLevel then
                progressText:SetText("MAX LEVEL")
            else
                local percent = maxProgress > 0 and math.floor((progress / maxProgress) * 100) or 0
                progressText:SetText(string.format("%d / %d (%d%%)", progress, maxProgress, percent))
            end
        end
    end

    -- Update scroll frame
    BattlePass_UpdateScrollFrame()

    -- Update claim all button
    if BattlePassClaimAllButton then
        local hasUnclaimed = false
        for level = 1, playerData.level do
            if levelDefinitions[level] and not IsLevelClaimed(level) then
                hasUnclaimed = true
                break
            end
        end
        if hasUnclaimed then
            BattlePassClaimAllButton:Enable()
        else
            BattlePassClaimAllButton:Disable()
        end
    end
end

-- Update the scroll frame content (horizontal layout - manual scroll)
function BattlePass_UpdateScrollFrame()
    local numLevels = playerData.maxLevel

    -- Update navigation buttons state
    if BattlePassPrevButton then
        if scrollOffset > 0 then
            BattlePassPrevButton:Enable()
        else
            BattlePassPrevButton:Disable()
        end
    end

    if BattlePassNextButton then
        if scrollOffset + VISIBLE_ITEMS < numLevels then
            BattlePassNextButton:Enable()
        else
            BattlePassNextButton:Disable()
        end
    end

    -- Update visible items
    for i = 1, VISIBLE_ITEMS do
        local item = levelItems[i]
        if item then
            local levelIndex = scrollOffset + i

            if levelIndex <= numLevels then
                local levelData = levelDefinitions[levelIndex]
                local status = GetLevelStatus(levelIndex)

                -- Level number
                local levelText = _G[item:GetName().."Level"]
                if levelText then
                    levelText:SetText(levelIndex)
                end

                -- Icon
                local icon = _G[item:GetName().."Icon"]
                if icon then
                    if levelData and levelData.icon then
                        icon:SetTexture("Interface\\Icons\\" .. levelData.icon)
                    else
                        icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                    end

                    -- Desaturate icon if locked
                    if status == 0 then
                        icon:SetDesaturated(true)
                        icon:SetVertexColor(0.5, 0.5, 0.5)
                    else
                        icon:SetDesaturated(false)
                        icon:SetVertexColor(1, 1, 1)
                    end
                end

                -- Icon overlay (border) - also desaturate if locked
                local iconOverlay = _G[item:GetName().."IconOverlay"]
                if iconOverlay then
                    if status == 0 then
                        iconOverlay:SetDesaturated(true)
                        iconOverlay:SetVertexColor(0.5, 0.5, 0.5)
                    else
                        iconOverlay:SetDesaturated(false)
                        iconOverlay:SetVertexColor(1, 1, 1)
                    end
                end

                -- Name
                local nameText = _G[item:GetName().."Name"]
                if nameText then
                    if levelData then
                        nameText:SetText(levelData.name)
                    else
                        nameText:SetText("???")
                    end

                    -- Grey out name if locked
                    if status == 0 then
                        nameText:SetTextColor(0.5, 0.5, 0.5)
                    else
                        nameText:SetTextColor(1, 1, 1)
                    end
                end

                -- Status
                local statusText = _G[item:GetName().."Status"]
                if statusText then
                    statusText:SetText(GetLevelStatusText(levelIndex))
                end

                -- Checkmark for claimed levels
                local checkmark = _G[item:GetName().."Checkmark"]
                if checkmark then
                    if IsLevelClaimed(levelIndex) then
                        checkmark:Show()
                    else
                        checkmark:Hide()
                    end
                end

                -- Black overlay for locked items
                local blackOverlay = _G[item:GetName().."BlackOverlay"]
                if blackOverlay then
                    if status == 0 then
                        blackOverlay:Show()
                    else
                        blackOverlay:Hide()
                    end
                end

                -- Background color
                local r, g, b, a = GetLevelStateColor(levelIndex)
                item:SetBackdropColor(r, g, b, a)

                -- Border color - grey if locked
                if status == 0 then
                    item:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
                else
                    item:SetBackdropBorderColor(0.6, 0.5, 0.3, 1)
                end

                -- Store level for click handler
                item.level = levelIndex
                item.status = status

                item:Show()
            else
                item:Hide()
            end
        end
    end

    -- Update scrollbar
    BattlePassScrollBar_Update()
end

-- Handle level item click
function BattlePass_OnLevelItemClick(self)
    local level = self.level
    if not level then return end

    local status = GetLevelStatus(level)

    if status == 1 then
        -- Available: claim this reward via CSMH
        RequestClaimLevel(level)
    elseif status == 2 then
        -- Already claimed
        print("|cff888888[Battle Pass]|r Level " .. level .. " already claimed.")
    elseif status == 3 then
        -- Already owns the reward
        print("|cffffaa00[Battle Pass]|r You already own this reward!")
    elseif status == 0 then
        -- Locked
        print("|cff888888[Battle Pass]|r Reach level " .. level .. " to claim this reward.")
    end
end

-- Handle level item hover
function BattlePass_OnLevelItemEnter(self)
    local level = self.level
    if not level then return end

    local levelData = levelDefinitions[level]
    if not levelData then return end

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("Level " .. level, 1, 0.82, 0)
    GameTooltip:AddLine(levelData.name, 1, 1, 1)

    -- Add reward type info
    local typeNames = {
        [1] = "Item",
        [2] = "Gold",
        [3] = "Title",
        [4] = "Spell",
        [5] = "Currency",
    }
    local typeName = typeNames[levelData.rewardType] or "Reward"
    GameTooltip:AddLine(typeName .. " x" .. levelData.count, 0.5, 0.5, 0.5)

    -- Status (using server status if available)
    local status = GetLevelStatus(level)
    if status == 0 then
        GameTooltip:AddLine("Locked - Reach level " .. level, 1, 0, 0)
    elseif status == 1 then
        GameTooltip:AddLine("Click to claim!", 0, 1, 0)
    elseif status == 2 then
        GameTooltip:AddLine("Already claimed", 0.5, 0.5, 1)
    elseif status == 3 then
        GameTooltip:AddLine("You already own this reward", 1, 0.7, 0)
    end

    GameTooltip:Show()
end

-- Called when frame is shown
function BattlePass_OnShow()
    InitializeAddon()
    -- Update UI immediately with current data (even if empty)
    BattlePass_UpdateUI()
    -- Then request fresh data from server
    BattlePass_RequestSync()
end

-- ============================================================================
-- XP Gain Animation
-- ============================================================================

local xpGainFadeTime = 0
local xpGainFading = false

local function XPGainFadeUpdate(self, elapsed)
    if not xpGainFading then return end

    xpGainFadeTime = xpGainFadeTime + elapsed
    if xpGainFadeTime < 1.5 then
        -- Stay visible for 1.5 seconds
        BattlePassXPGainFrame:SetAlpha(1)
    elseif xpGainFadeTime < 2.5 then
        -- Fade out over 1 second
        local alpha = 1 - ((xpGainFadeTime - 1.5) / 1.0)
        BattlePassXPGainFrame:SetAlpha(alpha)
    else
        -- Done
        BattlePassXPGainFrame:Hide()
        xpGainFading = false
    end
end

function BattlePass_ShowXPGain(amount)
    if BattlePassXPGainText then
        BattlePassXPGainText:SetText("|cff00ff00+" .. amount .. " XP|r")
    end
    if BattlePassXPGainFrame then
        BattlePassXPGainFrame:Show()
        BattlePassXPGainFrame:SetAlpha(1)
        xpGainFadeTime = 0
        xpGainFading = true
    end
end

-- ============================================================================
-- Level Up Notification
-- ============================================================================

function BattlePass_ShowLevelUp(newLevel)
    -- Play sound (LEVELUPSOUND = 888)
    -- PlaySound("LevelUp")

    -- Print message
    print("|cffff8000[Battle Pass]|r Level " .. newLevel .. " reached!")
end

-- ============================================================================
-- Actions
-- ============================================================================

-- Toggle frame visibility
function BattlePass_Toggle()
    if BattlePassFrame:IsShown() then
        BattlePassFrame:Hide()
    else
        BattlePassFrame:Show()
    end
end

-- Scroll to previous items (navigate left)
function BattlePass_ScrollPrev()
    scrollOffset = math.max(0, scrollOffset - VISIBLE_ITEMS)
    BattlePass_UpdateScrollFrame()
    BattlePassScrollBar_Update()
    -- PlaySound("igMainMenuOptionCheckBoxOn")
end

-- Scroll to next items (navigate right)
function BattlePass_ScrollNext()
    local maxOffset = math.max(0, playerData.maxLevel - VISIBLE_ITEMS)
    scrollOffset = math.min(maxOffset, scrollOffset + VISIBLE_ITEMS)
    BattlePass_UpdateScrollFrame()
    BattlePassScrollBar_Update()
    --PlaySound("igMainMenuOptionCheckBoxOn")
end

-- ============================================================================
-- Horizontal ScrollBar Handlers
-- ============================================================================

function BattlePassScrollBar_OnLoad(self)
    self:SetMinMaxValues(0, 100)
    self:SetValue(0)
    self:SetValueStep(1)
    self:SetObeyStepOnDrag(true)
end

function BattlePassScrollBar_OnValueChanged(self, value)
    -- Convert slider value to scroll offset
    local maxOffset = math.max(0, playerData.maxLevel - VISIBLE_ITEMS)
    if maxOffset > 0 then
        scrollOffset = math.floor((value / 100) * maxOffset + 0.5)
        BattlePass_UpdateScrollFrame()
    end
end

function BattlePassScrollBar_Update()
    if not BattlePassScrollBar then return end

    local maxOffset = math.max(0, playerData.maxLevel - VISIBLE_ITEMS)

    if maxOffset == 0 then
        -- No scrolling needed
        BattlePassScrollBar:SetMinMaxValues(0, 0)
        BattlePassScrollBar:SetValue(0)
        BattlePassScrollBar:Hide()
    else
        -- Calculate slider position from scrollOffset
        local sliderValue = (scrollOffset / maxOffset) * 100
        BattlePassScrollBar:SetMinMaxValues(0, 100)
        BattlePassScrollBar:SetValue(sliderValue)
        BattlePassScrollBar:Show()
    end
end

-- Handle mouse wheel scroll
function BattlePass_OnMouseWheel(self, delta)
    if delta > 0 then
        -- Scroll up = Previous (left)
        BattlePass_ScrollPrev()
    else
        -- Scroll down = Next (right)
        BattlePass_ScrollNext()
    end
end

-- Show info about the Battle Pass
function BattlePass_ShowInfo()
    print("|cffff8000[Battle Pass]|r Season 1")
    print("|cff00ff00Level:|r " .. playerData.level .. " / " .. playerData.maxLevel)
    print("|cff00ff00XP:|r " .. playerData.currentExp .. " / " .. playerData.expRequired)
    print("|cff00ff00Total XP:|r " .. playerData.totalExp)

    local claimed = 0
    for i = 1, playerData.level do
        if IsLevelClaimed(i) then
            claimed = claimed + 1
        end
    end
    print("|cff00ff00Claimed Rewards:|r " .. claimed .. " / " .. playerData.level)
end

-- ============================================================================
-- Slash Commands
-- ============================================================================

SLASH_BATTLEPASS1 = "/bp"
SLASH_BATTLEPASS2 = "/battlepass"

SlashCmdList["BATTLEPASS"] = function(msg)
    msg = string.lower(msg or "")

    if msg == "sync" then
        BattlePass_RequestSync()
    elseif msg == "hide" then
        BattlePassFrame:Hide()
    elseif msg == "info" then
        BattlePass_ShowInfo()
    else
        BattlePass_Toggle()
    end
end

-- ============================================================================
-- Event Handler
-- ============================================================================

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

local loginSyncDone = false
local loginTimer = 0

eventFrame:SetScript("OnUpdate", function(self, elapsed)
    -- Handle XP gain fade animation
    XPGainFadeUpdate(self, elapsed)

    -- Handle delayed login sync
    if pendingTimer then
        loginTimer = loginTimer + elapsed
        if loginTimer >= 2 then
            pendingTimer = nil
            loginTimer = 0
            BattlePass_RequestSync()
        end
    end
end)

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "BattlePass" then
            InitializeAddon()
        end
    elseif event == "PLAYER_LOGIN" then
        -- Initial sync after a short delay (2 seconds)
        if not loginSyncDone then
            pendingTimer = true
            loginTimer = 0
            loginSyncDone = true
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- Refresh on zone change if frame is open
        if BattlePassFrame and BattlePassFrame:IsShown() then
            BattlePass_RequestSync()
        end
    end
end)
