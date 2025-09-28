local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in DataHandlers! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI
local GMConfig = _G.GMConfig

if not GMData then
    print("[GameMasterSystem] ERROR: GMData not found! Check load order.")
    return
end

-- ============================================================================
-- Data Reception Handlers
-- ============================================================================
-- IMPORTANT: Client handlers ALWAYS receive player name as first parameter!

-- Test handler to verify AIO is working
function GameMasterSystem.testPing(player, message)
    -- TEST PING received
end

-- Item data handler
function GameMasterSystem.receiveItemData(player, data, offset, pageSize, hasMoreData, inventoryType, totalCount, totalPages, currentPage)
    if not data then
        -- No item data received
        return
    end

    -- Ensure DataStore exists
    if not GMData.DataStore then
        GMData.DataStore = {}
    end

    -- Sanitize item data to handle potential table wrapping from AIO
    if data and type(data) == "table" then
        for _, item in ipairs(data) do
            if item then
                -- Ensure numeric fields are actually numbers
                if item.inventoryType then
                    item.inventoryType = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(item.inventoryType) or item.inventoryType
                    item.inventoryType = tonumber(item.inventoryType) or 0
                end
                if item.quality then
                    item.quality = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(item.quality) or item.quality
                    item.quality = tonumber(item.quality) or 0
                end
                if item.itemLevel then
                    item.itemLevel = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(item.itemLevel) or item.itemLevel
                    item.itemLevel = tonumber(item.itemLevel) or 0
                end
                if item.entry then
                    item.entry = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(item.entry) or item.entry
                    item.entry = tonumber(item.entry) or 0
                end
                -- Ensure string fields are actually strings
                if item.name then
                    item.name = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(item.name) or item.name
                    item.name = tostring(item.name or "")
                end
                if item.description then
                    item.description = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(item.description) or item.description
                    item.description = tostring(item.description or "")
                end
            end
        end
    end

    GMData.DataStore.items = data
    
    -- Build pagination info from individual parameters
    local paginationInfo = nil
    if totalCount then
        paginationInfo = {
            totalCount = totalCount,
            totalPages = totalPages or 1,
            currentPage = currentPage or 1,
            hasNextPage = hasMoreData,
            currentOffset = offset or 0,
            pageSize = pageSize or 15
        }
    end
    
    -- Sanitize offset before updating pagination
    local sanitizedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(offset) or offset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    -- Update pagination state for current tab
    GMUtils.UpdateTabPagination(GMData.activeTab, sanitizedOffset, pageSize, hasMoreData, paginationInfo)
    
    -- Sync with global state
    GMData.currentOffset = offset or 0
    GMData.hasMoreData = hasMoreData or false
    GMData.paginationInfo = paginationInfo

    -- Update UI if viewing items tab
    if GMUI and GMUI.updateContentForActiveTab then
        GMUI.updateContentForActiveTab()
    end

    -- Update pagination buttons
    if GMUI and GMUI.updatePaginationButtons then
        GMUI.updatePaginationButtons()
    end
end

-- NPC data handler
function GameMasterSystem.receiveNPCData(player, data, offset, pageSize, hasMoreData, totalCount, totalPages, currentPage)
    -- Build pagination info from individual parameters
    local paginationInfo = nil
    if totalCount then
        paginationInfo = {
            totalCount = totalCount,
            totalPages = totalPages or 1,
            currentPage = currentPage or 1,
            hasNextPage = hasMoreData,
            currentOffset = offset or 0,
            pageSize = pageSize or 15
        }
    end
    
    if not data then
        return
    end


    -- Ensure DataStore exists
    if not GMData.DataStore then
        GMData.DataStore = {}
    end

    GMData.DataStore.npcs = data
    
    -- Sanitize offset before updating pagination
    local sanitizedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(offset) or offset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    -- Update pagination state for current tab
    GMUtils.UpdateTabPagination(GMData.activeTab, sanitizedOffset, pageSize, hasMoreData, paginationInfo)
    
    -- Sync with global state
    GMData.currentOffset = offset or 0
    GMData.hasMoreData = hasMoreData or false
    GMData.paginationInfo = paginationInfo

    -- Update UI if viewing NPCs tab
    if GMUI and GMUI.updateContentForActiveTab then
        GMUI.updateContentForActiveTab()
    end

    -- Update pagination buttons
    if GMUI and GMUI.updatePaginationButtons then
        GMUI.updatePaginationButtons()
    end
end

-- GameObject data handler
function GameMasterSystem.receiveGameObjectData(player, data, offset, pageSize, hasMoreData, totalCount, totalPages, currentPage)
    if not data then
        -- No game object data received
        return
    end

    -- Ensure DataStore exists
    if not GMData.DataStore then
        GMData.DataStore = {}
    end

    GMData.DataStore.gameobjects = data
    
    -- Build pagination info from individual parameters
    local paginationInfo = nil
    if totalCount then
        paginationInfo = {
            totalCount = totalCount,
            totalPages = totalPages or 1,
            currentPage = currentPage or 1,
            hasNextPage = hasMoreData,
            currentOffset = offset or 0,
            pageSize = pageSize or 15
        }
    end
    
    -- Sanitize offset before updating pagination
    local sanitizedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(offset) or offset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    -- Update pagination state for current tab
    GMUtils.UpdateTabPagination(GMData.activeTab, sanitizedOffset, pageSize, hasMoreData, paginationInfo)
    
    -- Sync with global state
    GMData.currentOffset = offset or 0
    GMData.hasMoreData = hasMoreData or false
    GMData.paginationInfo = paginationInfo
    
    -- Update UI if viewing game objects tab
    if GMUI and GMUI.updateContentForActiveTab then
        GMUI.updateContentForActiveTab()
    end

    -- Update pagination buttons
    if GMUI and GMUI.updatePaginationButtons then
        GMUI.updatePaginationButtons()
    end
end

-- Spell data handler
function GameMasterSystem.receiveSpellData(player, data, offset, pageSize, hasMoreData, paginationInfo)
    if not data then
        -- No spell data received
        return
    end

    -- Ensure DataStore exists
    if not GMData.DataStore then
        GMData.DataStore = {}
    end

    -- Sanitize spell data to handle potential table wrapping from AIO
    if data and type(data) == "table" then
        for _, spell in ipairs(data) do
            if spell then
                -- Ensure numeric fields are actually numbers
                if spell.id then
                    spell.id = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(spell.id) or spell.id
                    spell.id = tonumber(spell.id) or 0
                end
                if spell.visual then
                    spell.visual = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(spell.visual) or spell.visual
                    spell.visual = tonumber(spell.visual) or 0
                end
                -- Ensure string fields are actually strings
                if spell.name then
                    spell.name = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(spell.name) or spell.name
                    spell.name = tostring(spell.name or "")
                end
                if spell.description then
                    spell.description = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(spell.description) or spell.description
                    spell.description = tostring(spell.description or "")
                end
            end
        end
    end

    GMData.DataStore.spells = data
    
    -- Sanitize offset before updating pagination
    local sanitizedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(offset) or offset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    -- Update pagination state for current tab
    GMUtils.UpdateTabPagination(GMData.activeTab, sanitizedOffset, pageSize, hasMoreData, paginationInfo)
    
    -- Sync with global state
    GMData.currentOffset = offset or 0
    GMData.hasMoreData = hasMoreData or false
    GMData.paginationInfo = paginationInfo

    -- Update UI if viewing spells tab
    if GMUI and GMUI.updateContentForActiveTab then
        GMUI.updateContentForActiveTab()
    end

    -- Update pagination buttons
    if GMUI and GMUI.updatePaginationButtons then
        GMUI.updatePaginationButtons()
    end
end

-- Spell visual data handler
function GameMasterSystem.receiveSpellVisualData(player, data, offset, pageSize, hasMoreData, totalCount, totalPages, currentPage)
    if not data then
        -- No spell visual data received
        return
    end

    -- Ensure DataStore exists
    if not GMData.DataStore then
        GMData.DataStore = {}
    end

    GMData.DataStore.spellvisuals = data
    
    -- Build pagination info from individual parameters
    local paginationInfo = nil
    if totalCount then
        paginationInfo = {
            totalCount = totalCount,
            totalPages = totalPages or 1,
            currentPage = currentPage or 1,
            hasNextPage = hasMoreData,
            currentOffset = offset or 0,
            pageSize = pageSize or 15
        }
    end
    
    -- Sanitize offset before updating pagination
    local sanitizedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(offset) or offset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    -- Update pagination state for current tab
    GMUtils.UpdateTabPagination(GMData.activeTab, sanitizedOffset, pageSize, hasMoreData, paginationInfo)
    
    -- Sync with global state
    GMData.currentOffset = offset or 0
    GMData.hasMoreData = hasMoreData or false
    GMData.paginationInfo = paginationInfo

    -- Update UI if viewing spell visuals tab
    if GMUI and GMUI.updateContentForActiveTab then
        GMUI.updateContentForActiveTab()
    end

    -- Update pagination buttons
    if GMUI and GMUI.updatePaginationButtons then
        GMUI.updatePaginationButtons()
    end
end

-- Player data handler
function GameMasterSystem.receivePlayerData(player, data, offset, pageSize, hasMoreData, totalCount, totalPages, currentPage)
    if not data then
        return
    end

    -- Ensure DataStore exists
    if not GMData.DataStore then
        GMData.DataStore = {}
    end

    -- Clear and replace the data completely
    GMData.DataStore.players = nil  -- Clear old data first
    GMData.DataStore.players = data  -- Set new data
    
    -- Build pagination info from individual parameters
    local paginationInfo = nil
    if totalCount then
        paginationInfo = {
            totalCount = totalCount,
            totalPages = totalPages or 1,
            currentPage = currentPage or 1,
            hasNextPage = hasMoreData,
            currentOffset = offset or 0,
            pageSize = pageSize or 15
        }
    end
    
    -- Sanitize offset before updating pagination
    local sanitizedOffset = GMUtils and GMUtils.safeGetValue and GMUtils.safeGetValue(offset) or offset
    sanitizedOffset = tonumber(sanitizedOffset) or 0
    
    -- Update pagination state for current tab
    GMUtils.UpdateTabPagination(GMData.activeTab, sanitizedOffset, pageSize, hasMoreData, paginationInfo)
    
    -- Sync with global state
    GMData.currentOffset = offset or 0
    GMData.hasMoreData = hasMoreData or false
    GMData.paginationInfo = paginationInfo
    
    -- Store player data for list view
    if _G.GMCards then
        _G.GMCards.currentPlayerData = data
    end

    -- Always update the content tab which will create the list if needed
    if GMUI and GMUI.updateContentForActiveTab then
        GMUI.updateContentForActiveTab()
    end

    -- Update pagination buttons
    if GMUI and GMUI.updatePaginationButtons then
        GMUI.updatePaginationButtons()
    end
end

-- ============================================================================
-- Server Information Handlers
-- ============================================================================

-- GM level handler
function GameMasterSystem.receiveGmLevel(player, gmLevel)
    if not gmLevel then
        -- No GM level received
        return
    end

    GMData.PlayerGMLevel = gmLevel
    -- Player GM level received

    -- Update UI if it exists
    if GMUI.mainFrame and GMUI.updateTitleWithGMLevel then
        GMUI.updateTitleWithGMLevel()
    end
end

-- Core name handler
function GameMasterSystem.receiveCoreName(player, coreName)
    if not coreName then
        -- No core name received
        return
    end

    GMData.CoreName = coreName
    -- Core name received
end

-- Server capabilities handler
function GameMasterSystem.receiveServerCapabilities(player, capabilities)
    if not capabilities then
        return
    end
    
    -- Store server capabilities
    GMData.ServerCapabilities = capabilities
    print("[GameMasterSystem] Received server capabilities:")
    print("  - Character ban support: " .. tostring(capabilities.supportsCharacterBan))
    print("  - Server version: " .. (capabilities.serverVersion or "Unknown"))
    
    -- Update any UI elements that depend on capabilities
    if not capabilities.supportsCharacterBan then
        print("[GameMasterSystem] WARNING: Character bans are not supported on this server")
    end
end

-- ============================================================================
-- Modal Data Handlers
-- ============================================================================

-- Handler for receiving modal item data
function GameMasterSystem.receiveModalItemData(player, items)
    if not items then
        -- No modal item data received
        return
    end
    
    -- Update the modal with received items
    if _G.GMMenus and _G.GMMenus.updateModalItems then
        _G.GMMenus.updateModalItems(items)
    end
end

-- Handler for receiving spell search results
function GameMasterSystem.receiveSpellSearchResults(player, spells, offset, pageSize, hasMoreData, totalCount)
    if not spells then
        -- No spell data received
        return
    end
    
    -- Update the spell modal with received data including pagination info
    if _G.GMMenus and _G.GMMenus.updateSpellSearchResults then
        _G.GMMenus.updateSpellSearchResults(spells, offset, pageSize, hasMoreData, totalCount)
    end
end

-- ============================================================================
-- Error Handlers
-- ============================================================================

-- Error handler for pagination errors
function GameMasterSystem.handlePaginationError(player, message)
    -- Check if this is a "no more data" error
    if message and (message:find("No tab") or message:find("data found")) then
        -- Set hasMoreData to false to prevent further scrolling
        GMData.hasMoreData = false
        
        -- Optionally show a subtle notification (commented out to avoid spam)
        -- print("You've reached the end of the data.")
        
        -- Update UI to reflect end of data
        if GMUI and GMUI.updateContentForActiveTab then
            GMUI.updateContentForActiveTab()
        end
    end
end

-- Generic error handler
function GameMasterSystem.handleError(player, errorType, message)
    if errorType == "pagination" then
        GameMasterSystem.handlePaginationError(player, message)
    else
        -- Handle other error types as needed
        if GMConfig and GMConfig.config and GMConfig.config.debug then
            print("[GameMasterUI Error]", errorType, message)
        end
    end
end

-- ============================================================================
-- Initialization
-- ============================================================================

-- Finalize UI pattern for cross-file dependencies
function GameMasterSystem.FinalizeHandlers()
    -- This function can be called after all modules are loaded
    -- to ensure any cross-file dependencies are resolved

    -- Check if main UI is created and needs initial data
    if GMUI.mainFrame and not GMData.initialDataLoaded then
        -- Request initial data from server
        -- Requesting initial data from server
        AIO.Handle("GameMasterSystem", "requestInitialData")
        
        -- Request server capabilities
        AIO.Handle("GameMasterSystem", "getServerCapabilities")
        
        GMData.initialDataLoaded = true
    end
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Data handlers module loaded")
end