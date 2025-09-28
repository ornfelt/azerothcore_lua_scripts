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

-- Debug utility function
function GMUtils.debug(...)
    if GMConfig.config.debug or _G.GM_DEBUG then
        -- [GM Debug]
    end
end

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

-- Custom timer implementation for WoW 3.3.5
function GMUtils.customTimer(delay, func)
    local frame = CreateFrame("Frame")
    local elapsed = 0
    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= delay then
            func()
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- Delayed execution utility
function GMUtils.delayedExecution(delay, func)
    local elapsed = 0
    local frame = CreateFrame("Frame")
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

-- Get item icon texture with fallback
function GMUtils.GetItemIcon(itemID)
    if not itemID or itemID == 0 then
        return nil
    end
    
    -- Use GetItemInfo to get the texture
    local _, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemID)
    
    -- Return the texture path or nil if not found
    return itemTexture
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

-- Show tooltip
function GMUtils.showTooltip(frame, title, text)
    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
    GameTooltip:SetText(title, 1, 1, 1)
    if text then
        GameTooltip:AddLine(text, nil, nil, nil, true)
    end
    GameTooltip:Show()
end

-- Hide tooltip
function GMUtils.hideTooltip()
    GameTooltip:Hide()
end

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
    if state.totalCount > 0 and pageNumber > state.totalPages then
        return false
    end
    
    -- Calculate new offset
    local newOffset = (pageNumber - 1) * state.pageSize
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

-- Utilities loaded