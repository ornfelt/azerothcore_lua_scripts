local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

--[[
    GameMasterUI Unified Search Manager - Client Core

    Provides centralized search coordination for all search types:
    - Spell search
    - Item search
    - Player search
    - Extensible for new types

    Features:
    - Debounced input handling
    - Local state management
    - Pagination controls
    - Result caching
    - Callback system

    Architecture:
    - State Pattern: Each search type maintains independent state
    - Observer Pattern: Callbacks notify UI of results
    - Debouncing: Timer-based delay for user input
]]--

-- Preserve existing state if module is reloaded
local ClientSearchManager = _G.GMClientSearchManager or {}
_G.GMClientSearchManager = ClientSearchManager

-- Get module references
local GMConfig = _G.GMConfig

-- Preserve state across reloads
local searchStates = ClientSearchManager._searchStates or {}
ClientSearchManager._searchStates = searchStates

-- Search configuration per type
local searchConfigs = ClientSearchManager._searchConfigs or {}
ClientSearchManager._searchConfigs = searchConfigs

-- Result callbacks per type
local searchCallbacks = ClientSearchManager._searchCallbacks or {}
ClientSearchManager._searchCallbacks = searchCallbacks

-- Debounce frames per type
local debounceFrames = ClientSearchManager._debounceFrames or {}
ClientSearchManager._debounceFrames = debounceFrames

-- =====================================================
-- Module Initialization
-- =====================================================

--[[
    Initialize search for a specific type

    @param searchType string Unique identifier (e.g., "spells", "items")
    @param config table Configuration with:
        - pageSize: number (default: 50)
        - debounce: table {enabled: bool, delay: number (ms)}
        - defaultFilters: table (optional)
]]--
function ClientSearchManager.InitSearch(searchType, config)
    config = config or {}

    -- Initialize state
    searchStates[searchType] = {
        query = "",
        filters = config.defaultFilters or {},
        pagination = {
            currentOffset = 0,
            pageSize = config.pageSize or 50,
            hasNextPage = false,
            hasPrevPage = false,
            totalCount = 0,
            currentPage = 1,
            totalPages = 1
        },
        results = {},
        isSearching = false,
        lastSearchTime = 0
    }

    -- Store config
    searchConfigs[searchType] = config

    -- Create debounce frame if needed
    if config.debounce and config.debounce.enabled then
        ClientSearchManager.CreateDebounceFrame(searchType, config.debounce.delay)
    end

    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print(string.format("[ClientSearchManager] Initialized search type: %s", searchType))
    end
end

-- =====================================================
-- Debouncing System
-- =====================================================

function ClientSearchManager.CreateDebounceFrame(searchType, delay)
    if debounceFrames[searchType] then
        return -- Already exists
    end

    local frame = CreateFrame("Frame")
    frame:Hide()
    frame.searchType = searchType
    frame.delay = (delay or 500) / 1000 -- Convert ms to seconds

    frame:SetScript("OnUpdate", function(self, elapsed)
        self.timeLeft = (self.timeLeft or 0) - elapsed

        if self.timeLeft <= 0 then
            self:Hide()
            -- Execute the search
            ClientSearchManager.ExecuteSearchImmediate(self.searchType)
        end
    end)

    debounceFrames[searchType] = frame

    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print(string.format("[ClientSearchManager] Created debounce frame for %s (delay: %dms)",
            searchType, delay))
    end
end

function ClientSearchManager.TriggerDebounce(searchType)
    local frame = debounceFrames[searchType]
    if not frame then
        -- No debounce, execute immediately
        ClientSearchManager.ExecuteSearchImmediate(searchType)
        return
    end

    -- Reset timer
    frame.timeLeft = frame.delay
    frame:Show()
end

function ClientSearchManager.CancelDebounce(searchType)
    local frame = debounceFrames[searchType]
    if frame then
        frame:Hide()
    end
end

-- =====================================================
-- Search Execution
-- =====================================================

--[[
    Trigger a search with debouncing

    @param searchType string Search type identifier
    @param query string Search query text
    @param filters table Optional filter parameters
    @param resetPagination bool Reset to first page (default: true)
]]--
function ClientSearchManager.Search(searchType, query, filters, resetPagination)
    local state = searchStates[searchType]
    if not state then
        print("[ClientSearchManager] Search type not initialized:", searchType)
        return false
    end

    -- Update state
    state.query = query or ""
    state.filters = filters or state.filters

    if resetPagination ~= false then
        state.pagination.currentOffset = 0
    end

    -- Trigger debounce or execute immediately
    local config = searchConfigs[searchType]
    if config and config.debounce and config.debounce.enabled then
        ClientSearchManager.TriggerDebounce(searchType)
    else
        ClientSearchManager.ExecuteSearchImmediate(searchType)
    end

    return true
end

--[[
    Execute search immediately (bypasses debouncing)
]]--
function ClientSearchManager.ExecuteSearchImmediate(searchType)
    local state = searchStates[searchType]
    if not state then
        return
    end

    -- Mark as searching
    state.isSearching = true
    state.lastSearchTime = GetTime()

    -- Prepare parameters
    local params = {
        query = state.query,
        filters = state.filters,
        offset = state.pagination.currentOffset,
        pageSize = state.pagination.pageSize
    }

    -- Send to server
    AIO.Handle("SearchManager", "search_" .. searchType, params)

    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print(string.format("[ClientSearchManager] Executing search: %s, query: '%s', offset: %d",
            searchType, state.query, state.pagination.currentOffset))
    end
end

-- =====================================================
-- Result Handling
-- =====================================================

--[[
    Receive search results from server (called by AIO)
]]--
function ClientSearchManager.ReceiveResults(data)
    local searchType = data.searchType
    local state = searchStates[searchType]

    if not state then
        if GMConfig and GMConfig.config and GMConfig.config.debug then
            print("[ClientSearchManager] Received results for uninitialized search type:", searchType)
        end
        return
    end

    -- Update state
    state.results = data.results or {}
    state.isSearching = false
    state.metadata = data.metadata  -- Store metadata (e.g., fuzzy suggestions)

    -- Update pagination info
    if data.pagination then
        state.pagination.currentOffset = data.pagination.currentOffset or 0
        state.pagination.pageSize = data.pagination.pageSize or 50
        state.pagination.hasNextPage = data.pagination.hasNextPage or false
        state.pagination.hasPrevPage = data.pagination.hasPrevPage or false
        state.pagination.totalCount = data.pagination.totalCount or -1
        state.pagination.currentPage = data.pagination.currentPage or 1
        state.pagination.totalPages = data.pagination.totalPages or -1
        state.pagination.resultCount = data.pagination.resultCount or #state.results
    end

    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print(string.format("[ClientSearchManager] Received %d results for %s (page %d/%d)",
            #state.results, searchType,
            state.pagination.currentPage, state.pagination.totalPages))

        -- Debug suggestions if present
        if state.metadata and state.metadata.hasSuggestions then
            print(string.format("[ClientSearchManager] Found %d suggestions for '%s'",
                #(state.metadata.suggestions or {}), state.metadata.originalQuery or ""))
        end
    end

    -- Trigger callback with metadata
    local callback = searchCallbacks[searchType]
    if callback then
        callback(state.results, state.pagination, state.metadata)
    end
end

-- =====================================================
-- Pagination Controls
-- =====================================================

function ClientSearchManager.NextPage(searchType)
    local state = searchStates[searchType]
    if not state or not state.pagination.hasNextPage then
        return false
    end

    state.pagination.currentOffset = state.pagination.currentOffset + state.pagination.pageSize
    ClientSearchManager.ExecuteSearchImmediate(searchType)
    return true
end

function ClientSearchManager.PrevPage(searchType)
    local state = searchStates[searchType]
    if not state or not state.pagination.hasPrevPage then
        return false
    end

    state.pagination.currentOffset = math.max(0,
        state.pagination.currentOffset - state.pagination.pageSize)
    ClientSearchManager.ExecuteSearchImmediate(searchType)
    return true
end

function ClientSearchManager.GoToPage(searchType, pageNumber)
    local state = searchStates[searchType]
    if not state then
        return false
    end

    pageNumber = math.max(1, pageNumber)
    state.pagination.currentOffset = (pageNumber - 1) * state.pagination.pageSize
    ClientSearchManager.ExecuteSearchImmediate(searchType)
    return true
end

function ClientSearchManager.SetPageSize(searchType, pageSize)
    local state = searchStates[searchType]
    if not state then
        return false
    end

    pageSize = math.max(10, math.min(500, pageSize))
    state.pagination.pageSize = pageSize
    state.pagination.currentOffset = 0  -- Reset to first page
    return true
end

-- =====================================================
-- Filter Management
-- =====================================================

function ClientSearchManager.SetFilter(searchType, filterName, filterValue)
    local state = searchStates[searchType]
    if not state then
        return false
    end

    state.filters[filterName] = filterValue
    return true
end

function ClientSearchManager.ClearFilter(searchType, filterName)
    local state = searchStates[searchType]
    if not state then
        return false
    end

    state.filters[filterName] = nil
    return true
end

function ClientSearchManager.ClearAllFilters(searchType)
    local state = searchStates[searchType]
    if not state then
        return false
    end

    state.filters = {}
    return true
end

function ClientSearchManager.GetFilters(searchType)
    local state = searchStates[searchType]
    if not state then
        return {}
    end

    return state.filters
end

-- =====================================================
-- Callback System
-- =====================================================

--[[
    Register a callback for search results

    @param searchType string Search type identifier
    @param callback function(results, paginationInfo)
]]--
function ClientSearchManager.RegisterCallback(searchType, callback)
    searchCallbacks[searchType] = callback
end

function ClientSearchManager.UnregisterCallback(searchType)
    searchCallbacks[searchType] = nil
end

-- =====================================================
-- State Access
-- =====================================================

function ClientSearchManager.GetState(searchType)
    return searchStates[searchType]
end

function ClientSearchManager.GetResults(searchType)
    local state = searchStates[searchType]
    return state and state.results or {}
end

function ClientSearchManager.GetPaginationInfo(searchType)
    local state = searchStates[searchType]
    return state and state.pagination or {}
end

function ClientSearchManager.IsSearching(searchType)
    local state = searchStates[searchType]
    return state and state.isSearching or false
end

function ClientSearchManager.GetQuery(searchType)
    local state = searchStates[searchType]
    return state and state.query or ""
end

-- =====================================================
-- Utility Functions
-- =====================================================

function ClientSearchManager.ClearResults(searchType)
    local state = searchStates[searchType]
    if state then
        state.results = {}
        state.query = ""
        state.pagination.currentOffset = 0
    end
end

function ClientSearchManager.Reset(searchType)
    local config = searchConfigs[searchType]
    if config then
        ClientSearchManager.InitSearch(searchType, config)
    end
end

-- =====================================================
-- AIO Handler Registration
-- =====================================================

-- Register AIO handler to receive results from server
local SearchManagerHandlers = AIO.AddHandlers("SearchManager", {})

function SearchManagerHandlers.receiveResults(player, data)
    ClientSearchManager.ReceiveResults(data)
end

if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[ClientSearchManager] Module loaded and AIO handlers registered")
end
