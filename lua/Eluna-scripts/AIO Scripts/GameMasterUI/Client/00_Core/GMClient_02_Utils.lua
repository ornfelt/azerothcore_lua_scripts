-- GameMaster UI System - Utility Functions
-- This file contains all utility and helper functions
-- Load order: 02 (Third)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Verify namespace exists
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

local GMUtils = _G.GMUtils
local GMConfig = _G.GMConfig
local GMData = _G.GMData

-- Debug utility function (standardized with server)
function GMUtils.debug(level, ...)
    -- Support old usage: GMUtils.debug(message) -> treat as INFO level
    if type(level) ~= "string" or (level ~= "ERROR" and level ~= "WARNING" and level ~= "INFO" and level ~= "DEBUG") then
        -- Old usage detected, treat first param as part of message
        local args = {level, ...}
        level = "INFO"
        if GMConfig.config.debug or _G.GM_DEBUG then
            print("[GM " .. level .. "]", unpack(args))
        end
        return
    end
    
    -- New usage with level
    local debugEnabled = GMConfig.config.debug or _G.GM_DEBUG
    
    -- Always show errors and warnings
    if level == "ERROR" or level == "WARNING" then
        print("[GM " .. level .. "]", ...)
    elseif debugEnabled then
        -- Show INFO and DEBUG only when debug is enabled
        print("[GM " .. level .. "]", ...)
    end
end

-- Convenience methods for specific log levels
function GMUtils.error(...) GMUtils.debug("ERROR", ...) end
function GMUtils.warning(...) GMUtils.debug("WARNING", ...) end
function GMUtils.info(...) GMUtils.debug("INFO", ...) end
function GMUtils.debugLog(...) GMUtils.debug("DEBUG", ...) end

-- String utilities
function GMUtils.trimSpaces(value)
    return tostring(value):match("^%s*(.-)%s*$")
end

-- Tooltip utilities
function GMUtils.ShowTooltip(owner, anchorPoint, ...)
    -- Store original strata
    local originalStrata = GameTooltip:GetFrameStrata()
    
    -- Check if owner is in a high-level frame (modal/tooltip strata)
    local ownerStrata = owner:GetFrameStrata()
    if ownerStrata == "TOOLTIP" or ownerStrata == "FULLSCREEN_DIALOG" then
        GameTooltip:SetFrameStrata("TOOLTIP")
        GameTooltip:SetFrameLevel(owner:GetFrameLevel() + 10)
    end
    
    -- Set owner and show tooltip
    GameTooltip:SetOwner(owner, anchorPoint or "ANCHOR_RIGHT")
    
    -- Handle different tooltip content types
    local args = {...}
    if #args == 1 and type(args[1]) == "string" then
        -- Simple text tooltip
        GameTooltip:SetText(args[1])
    elseif #args == 2 and type(args[1]) == "string" and type(args[2]) == "string" then
        -- Title and description
        GameTooltip:SetText(args[1])
        GameTooltip:AddLine(args[2], nil, nil, nil, true)
    else
        -- Multiple lines
        for i, line in ipairs(args) do
            if i == 1 then
                GameTooltip:SetText(line)
            else
                GameTooltip:AddLine(line, nil, nil, nil, true)
            end
        end
    end
    
    GameTooltip:Show()
    
    -- Store original strata to restore later
    GameTooltip.originalStrata = originalStrata
end

function GMUtils.HideTooltip()
    GameTooltip:Hide()
    
    -- Restore original strata if stored
    if GameTooltip.originalStrata then
        GameTooltip:SetFrameStrata(GameTooltip.originalStrata)
        GameTooltip.originalStrata = nil
    end
end

-- Throttle function to limit execution frequency
function GMUtils.throttle(func, delay)
    local lastCall = 0
    return function(...)
        local now = GetTime()
        if now - lastCall >= delay then
            lastCall = now
            return func(...)
        end
    end
end

-- Unified delay/timer function for WoW 3.3.5
-- Usage: GMUtils.delay(seconds, callback)
function GMUtils.delay(delay, func)
    local frame = CreateFrame("Frame")
    local elapsed = 0
    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= delay then
            func()
            self:SetScript("OnUpdate", nil)
            self:Hide()
        end
    end)
    frame:Show()
end

-- Aliases for backward compatibility
GMUtils.customTimer = GMUtils.delay
GMUtils.delayedExecution = GMUtils.delay

-- Get item icon texture with fallback
function GMUtils.GetItemIcon(itemID, useFallback)
    if not itemID or itemID == 0 then
        return useFallback and "Interface\\Icons\\INV_Misc_QuestionMark" or nil
    end
    
    -- Use GetItemInfo to get the texture
    local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemID)
    
    -- Return the texture path with optional fallback
    if itemTexture then
        return itemTexture
    elseif useFallback then
        return "Interface\\Icons\\INV_Misc_QuestionMark"
    else
        return nil
    end
end

-- Alias for backward compatibility with safe version
GMUtils.GetItemIconSafe = function(itemID)
    return GMUtils.GetItemIcon(itemID, true)
end

-- Get item quality color
function GMUtils.getQualityColor(quality)
    if GMConfig.QUALITY_COLORS[quality] then
        return unpack(GMConfig.QUALITY_COLORS[quality])
    end
    return 1, 1, 1 -- Default to white
end

-- Calculate card dimensions based on parent size
function GMUtils.calculateCardDimensions(parent)
    local parentWidth = parent:GetWidth()
    local parentHeight = parent:GetHeight()
    
    local cardWidth = (parentWidth - 60) / GMConfig.config.NUM_COLUMNS
    local cardHeight = (parentHeight - 120) / GMConfig.config.NUM_ROWS
    
    return cardWidth, cardHeight
end

-- Format numbers with commas
function GMUtils.formatNumber(num)
    if type(num) ~= "number" then
        return tostring(num)
    end
    
    local formatted = tostring(num)
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

-- Check if table is empty
function GMUtils.isTableEmpty(t)
    if type(t) ~= "table" then
        return true
    end
    
    for _ in pairs(t) do
        return false
    end
    return true
end

-- Deep copy a table
function GMUtils.deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[GMUtils.deepCopy(orig_key)] = GMUtils.deepCopy(orig_value)
        end
        setmetatable(copy, GMUtils.deepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

-- Get current tab type
function GMUtils.getCurrentTabType()
    local activeTab = GMData.activeTab
    
    -- Check if it's a main tab
    for cardType, data in pairs(GMConfig.CardTypes) do
        if data.tabIndex == activeTab then
            return cardType
        end
    end
    
    -- Check if it's an item subcategory
    for categoryName, category in pairs(GMConfig.CardTypes.Item.categories) do
        for _, subCategory in ipairs(category.subCategories) do
            if subCategory.index == activeTab then
                return "Item", subCategory.value
            end
        end
    end
    
    return nil
end

-- Update data for current tab
function GMUtils.updateCurrentTabData(data, offset, pageSize, hasMore)
    local tabType = GMUtils.getCurrentTabType()
    if not tabType then
        GMUtils.debug("No valid tab type found for activeTab:", GMData.activeTab)
        return
    end
    
    local dataKey = GMConfig.CardTypes[tabType] and GMConfig.CardTypes[tabType].dataKey
    if dataKey then
        GMData.DataStore[dataKey] = data
        GMData.currentOffset = offset
        GMData.hasMoreData = hasMore
    end
end

-- Get display ID for different entity types
function GMUtils.getDisplayId(data, entityType)
    if entityType == "NPC" then
        return data.modelId or data.displayId
    elseif entityType == "GameObject" then
        return data.displayId or data.modelId
    elseif entityType == "SpellVisual" then
        return data.id or data.visualId
    elseif entityType == "Item" then
        return data.displayId or data.modelId
    end
    return nil
end

-- Duplicate tooltip functions removed - use GMUtils.ShowTooltip/HideTooltip instead

-- Create a simple animation effect (fade in)
function GMUtils.fadeIn(frame, duration)
    duration = duration or 0.3
    frame:SetAlpha(0)
    frame:Show()
    
    local elapsed = 0
    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        local alpha = elapsed / duration
        if alpha >= 1 then
            alpha = 1
            self:SetScript("OnUpdate", nil)
        end
        self:SetAlpha(alpha)
    end)
end

-- Create a simple animation effect (fade out)
function GMUtils.fadeOut(frame, duration, hideOnComplete)
    duration = duration or 0.3
    
    local startAlpha = frame:GetAlpha()
    local elapsed = 0
    
    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        local alpha = startAlpha * (1 - (elapsed / duration))
        if alpha <= 0 then
            alpha = 0
            self:SetScript("OnUpdate", nil)
            if hideOnComplete then
                self:Hide()
            end
        end
        self:SetAlpha(alpha)
    end)
end

-- Tab state management utilities
function GMUtils.GetTabState(tabIndex)
    if not tabIndex then return nil end
    
    -- Create state if it doesn't exist
    if not GMData.tabStates[tabIndex] then
        GMData.tabStates[tabIndex] = {
            currentOffset = 0,
            currentPage = 1,
            totalPages = 1,
            totalCount = 0,
            pageSize = GMConfig.config.PAGE_SIZE or 15,
            hasMoreData = false,
            searchQuery = "",
            paginationInfo = nil
        }
    end
    
    return GMData.tabStates[tabIndex]
end

function GMUtils.ResetTabState(tabIndex)
    if not tabIndex then return end
    
    GMData.tabStates[tabIndex] = {
        currentOffset = 0,
        currentPage = 1,
        totalPages = 1,
        totalCount = 0,
        pageSize = GMConfig.config.PAGE_SIZE or 15,
        hasMoreData = false,
        searchQuery = "",
        paginationInfo = nil
    }
end

function GMUtils.UpdateTabPagination(tabIndex, offset, pageSize, hasMoreData, paginationInfo)
    if not tabIndex then return end
    
    local state = GMUtils.GetTabState(tabIndex)
    
    -- Sanitize numeric values to handle potential table wrapping from AIO
    local sanitizedOffset = offset and GMUtils.safeGetValue(offset) or state.currentOffset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    local sanitizedPageSize = pageSize and GMUtils.safeGetValue(pageSize) or state.pageSize
    sanitizedPageSize = tonumber(sanitizedPageSize) or 15
    
    -- Update basic values with sanitized data
    state.currentOffset = sanitizedOffset
    state.pageSize = sanitizedPageSize
    state.hasMoreData = hasMoreData or false
    
    -- Update from pagination info if provided
    if paginationInfo then
        -- Sanitize pagination info values
        state.paginationInfo = paginationInfo
        state.totalCount = tonumber(GMUtils.safeGetValue(paginationInfo.totalCount)) or 0
        state.totalPages = tonumber(GMUtils.safeGetValue(paginationInfo.totalPages)) or 1
        state.currentPage = tonumber(GMUtils.safeGetValue(paginationInfo.currentPage)) or 1
        state.hasMoreData = paginationInfo.hasNextPage or false
    else
        -- Calculate current page from sanitized offset
        state.currentPage = math.floor(sanitizedOffset / sanitizedPageSize) + 1
    end
    
    -- Sync with global state if this is the active tab (use sanitized values)
    if tabIndex == GMData.activeTab then
        GMData.currentOffset = sanitizedOffset
        GMData.hasMoreData = state.hasMoreData
        GMData.paginationInfo = state.paginationInfo
    end
end

function GMUtils.GoToPage(tabIndex, pageNumber)
    if not tabIndex or not pageNumber then return false end
    
    local state = GMUtils.GetTabState(tabIndex)
    pageNumber = tonumber(pageNumber)
    
    if not pageNumber or pageNumber < 1 then return false end
    
    -- Don't allow going beyond known pages (unless we don't know total)
    local totalCount = tonumber(GMUtils.safeGetValue(state.totalCount)) or 0
    local totalPages = tonumber(GMUtils.safeGetValue(state.totalPages)) or 1
    if totalCount > 0 and pageNumber > totalPages then
        return false
    end
    
    -- Calculate new offset (sanitize pageSize to prevent table math errors)
    local pageSize = tonumber(GMUtils.safeGetValue(state.pageSize)) or 15
    local newOffset = (pageNumber - 1) * pageSize
    state.currentOffset = newOffset
    state.currentPage = pageNumber
    
    -- Sync with global state if this is the active tab
    if tabIndex == GMData.activeTab then
        GMData.currentOffset = state.currentOffset
    end
    
    return true
end

-- Safe value extraction utilities
-- These functions handle cases where AIO serialization might wrap values in tables
function GMUtils.safeGetValue(value)
    -- If value is a table, try to extract the actual value
    if type(value) == "table" then
        -- Check for common AIO serialization patterns
        if value[1] ~= nil then
            return value[1]  -- Array-like table, get first element
        elseif value.value ~= nil then
            return value.value  -- Object with 'value' property
        elseif value.data ~= nil then
            return value.data  -- Object with 'data' property
        else
            -- Try to get the first value in the table
            for _, v in pairs(value) do
                return v  -- Return first value found
            end
        end
    end
    return value  -- Return as-is if not a table
end

-- Safe numeric comparison
function GMUtils.safeCompareNumbers(a, b, operator)
    local valA = GMUtils.safeGetValue(a)
    local valB = GMUtils.safeGetValue(b)
    
    -- Convert to numbers if possible
    valA = tonumber(valA) or 0
    valB = tonumber(valB) or 0
    
    if operator == "<" then
        return valA < valB
    elseif operator == ">" then
        return valA > valB
    elseif operator == "<=" then
        return valA <= valB
    elseif operator == ">=" then
        return valA >= valB
    elseif operator == "==" then
        return valA == valB
    else
        return false
    end
end

-- Safe string comparison
function GMUtils.safeCompareStrings(a, b)
    local valA = GMUtils.safeGetValue(a)
    local valB = GMUtils.safeGetValue(b)
    
    -- Convert to strings
    valA = tostring(valA or "")
    valB = tostring(valB or "")
    
    return valA < valB
end

-- Error handling and reporting
GMUtils.errorLog = {}
GMUtils.maxErrors = 20

-- Capture errors for reporting
function GMUtils.logError(errorMsg, context)
    local errorEntry = {
        time = date("%H:%M:%S"),
        message = errorMsg,
        context = context or "Unknown"
    }
    
    table.insert(GMUtils.errorLog, 1, errorEntry)
    
    -- Keep only last maxErrors entries
    while #GMUtils.errorLog > GMUtils.maxErrors do
        table.remove(GMUtils.errorLog)
    end
    
    -- If report dialog exists, notify it
    if GMReportDialog and GMReportDialog.CaptureError then
        GMReportDialog.CaptureError(errorMsg)
    end
    
    -- Debug output if enabled
    GMUtils.debug("[ERROR]", context or "", errorMsg)
end

-- Get recent errors for reporting
function GMUtils.getRecentErrors()
    return GMUtils.errorLog
end

-- Clear error log
function GMUtils.clearErrorLog()
    GMUtils.errorLog = {}
end

-- Protected call wrapper with error logging
function GMUtils.protectedCall(func, context, ...)
    local success, result = pcall(func, ...)
    if not success then
        GMUtils.logError(result, context)
        return false, result
    end
    return true, result
end

-- Register initializers list
GMUtils.initializers = GMUtils.initializers or {}

-- Register an initializer function
function GMUtils.RegisterInitializer(func)
    table.insert(GMUtils.initializers, func)
end

-- Run all registered initializers
function GMUtils.RunInitializers()
    for i, func in ipairs(GMUtils.initializers) do
        local success, err = pcall(func)
        if not success then
            GMUtils.logError(err, "Initializer " .. i)
        end
    end
end

-- ============================================================================
-- Item Link and Display Utilities
-- ============================================================================

-- Generate item link using cached data with fallback to GetItemInfo
function GMUtils.GetItemLink(itemId, enchantId)
    -- Try cache first
    if _G.GMItemCache and _G.GMItemCache.HasItem(itemId) then
        local item = _G.GMItemCache.GetItem(itemId)
        return _G.GMItemCache.BuildItemLink(item, enchantId)
    end
    
    -- Fallback to WoW's GetItemInfo
    local name, link = GetItemInfo(itemId)
    if link then
        return link
    end
    
    -- Final fallback - create basic link
    local colorCode = "|cff9d9d9d"  -- Gray color for unknown items
    local itemString = string.format("item:%d:%d:0:0:0:0:0:0:80", itemId, enchantId or 0)
    return string.format("%s|H%s|h[Item %d]|h|r", colorCode, itemString, itemId)
end

-- Get item name with quality color
function GMUtils.GetColoredItemName(itemId)
    -- Try cache first
    if _G.GMItemCache and _G.GMItemCache.HasItem(itemId) then
        local item = _G.GMItemCache.GetItem(itemId)
        local colorCode = _G.GMItemCache.QUALITY_COLORS[item.quality] or "|cffffffff"
        return colorCode .. item.name .. "|r"
    end
    
    -- Fallback to GetItemInfo
    local name, _, quality = GetItemInfo(itemId)
    if name then
        local colors = {
            [0] = "|cff9d9d9d",  -- Poor
            [1] = "|cffffffff",  -- Common
            [2] = "|cff1eff00",  -- Uncommon
            [3] = "|cff0070dd",  -- Rare
            [4] = "|cffa335ee",  -- Epic
            [5] = "|cffff8000",  -- Legendary
        }
        local colorCode = colors[quality] or "|cffffffff"
        return colorCode .. name .. "|r"
    end
    
    -- Final fallback
    return "|cff9d9d9d[Item " .. itemId .. "]|r"
end

-- Enhanced tooltip setting with cache support
function GMUtils.SetItemTooltip(tooltip, itemId, enchantId)
    -- Try cache first for enhanced tooltip
    if _G.GMItemCache and _G.GMItemCache.SetTooltip(tooltip, itemId, enchantId) then
        return true
    end
    
    -- Fallback to standard tooltip
    local itemString = string.format("item:%d:%d:0:0:0:0:0:0:80", itemId, enchantId or 0)
    tooltip:SetHyperlink(itemString)
    return false
end

-- Get item info with cache fallback (mimics GetItemInfo API)
function GMUtils.GetItemInfo(itemId)
    -- Try cache first
    if _G.GMItemCache and _G.GMItemCache.HasItem(itemId) then
        return _G.GMItemCache.GetItemInfo(itemId)
    end
    
    -- Fallback to WoW's GetItemInfo
    return GetItemInfo(itemId)
end

-- Check if item data is available (cache or client)
function GMUtils.IsItemDataAvailable(itemId)
    if _G.GMItemCache and _G.GMItemCache.HasItem(itemId) then
        return true
    end
    
    local name = GetItemInfo(itemId)
    return name ~= nil
end

-- Utilities loaded with item cache support