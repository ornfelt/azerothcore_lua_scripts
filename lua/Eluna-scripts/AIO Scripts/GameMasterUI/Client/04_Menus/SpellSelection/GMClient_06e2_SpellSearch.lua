local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus or not GMMenus.SpellSelection then
    print("[ERROR] SpellSelection module not found! Check load order.")
    return
end

local SpellSelection = GMMenus.SpellSelection
local GMConfig = _G.GMConfig
local ClientSearchManager = _G.GMClientSearchManager

-- Spell Search Module
local Search = SpellSelection.Search

-- Default configuration constants
Search.DEFAULT_PAGE_SIZE = 50
Search.MIN_PAGE_SIZE = 10
Search.MAX_PAGE_SIZE = 500

-- Initialize spell search with unified SearchManager
if ClientSearchManager then
    ClientSearchManager.InitSearch("spells", {
        pageSize = Search.DEFAULT_PAGE_SIZE,
        debounce = {
            enabled = true,
            delay = 500  -- 500ms
        }
    })

    -- Register callback for spell search results
    ClientSearchManager.RegisterCallback("spells", function(results, pagination, metadata)
        Search.handleSearchResults(results, pagination, metadata)
    end)

    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print("[SpellSearch] Initialized with unified SearchManager")
    end
end

-- Real-time search state (kept for backward compatibility)
local realtimeSearchFrame = nil
local realtimeSearchText = nil
local SEARCH_DELAY = 0.5 -- 500ms delay after user stops typing

-- Create pagination state with safe defaults
function Search.createModalState(castType)
    return {
        castType = castType,
        currentOffset = 0,
        pageSize = 50, -- Use literal value to avoid self-reference
        hasMoreData = false,
        totalSpells = 0
    }
end

-- Safely get pageSize with fallback
function Search.getValidPageSize(modalState)
    if not modalState then return 50 end
    local pageSize = modalState.pageSize or 50
    return math.max(10, math.min(500, pageSize))
end

-- Update modal state from server response
function Search.updateModalState(modalState, offset, pageSize, hasMoreData, totalCount)
    if not modalState then return end
    
    modalState.currentOffset = offset or 0
    modalState.hasMoreData = hasMoreData or false
    modalState.totalSpells = totalCount or 0
    
    -- Preserve pageSize if server doesn't provide it, otherwise use server value
    if pageSize then
        modalState.pageSize = pageSize
    end
    -- Ensure pageSize is never nil (fallback to default)
    modalState.pageSize = Search.getValidPageSize(modalState)
end

-- Handle search request with safe parameters
function Search.handleSearchRequest(modalState, searchText)
    if not modalState then return end

    modalState.currentOffset = 0

    -- Use unified SearchManager if available
    if ClientSearchManager then
        ClientSearchManager.Search("spells", searchText or "", nil, true)
    else
        -- Fallback to direct AIO call
        local pageSize = Search.getValidPageSize(modalState)
        AIO.Handle("GameMasterSystem", "searchSpells", searchText or "", modalState.currentOffset, pageSize)
    end
end

-- Handle pagination navigation
function Search.handlePreviousPage(modalState, searchText)
    if not modalState or modalState.currentOffset <= 0 then return end

    -- Use unified SearchManager if available
    if ClientSearchManager then
        ClientSearchManager.PrevPage("spells")
    else
        -- Fallback to direct AIO call
        local pageSize = Search.getValidPageSize(modalState)
        modalState.currentOffset = math.max(0, modalState.currentOffset - pageSize)
        AIO.Handle("GameMasterSystem", "searchSpells", searchText or "", modalState.currentOffset, pageSize)
    end
end

function Search.handleNextPage(modalState, searchText)
    if not modalState or not modalState.hasMoreData then return end

    -- Use unified SearchManager if available
    if ClientSearchManager then
        ClientSearchManager.NextPage("spells")
    else
        -- Fallback to direct AIO call
        local pageSize = Search.getValidPageSize(modalState)
        modalState.currentOffset = modalState.currentOffset + pageSize
        AIO.Handle("GameMasterSystem", "searchSpells", searchText or "", modalState.currentOffset, pageSize)
    end
end

-- Calculate pagination info for display
function Search.getPaginationInfo(modalState)
    if not modalState then
        return { currentPage = 1, startNum = 0, endNum = 0, totalSpells = 0 }
    end
    
    local pageSize = Search.getValidPageSize(modalState)
    local currentPage = math.floor(modalState.currentOffset / pageSize) + 1
    local startNum = modalState.currentOffset + 1
    local endNum = math.min(modalState.currentOffset + pageSize, modalState.totalSpells)
    
    return {
        currentPage = currentPage,
        startNum = startNum,
        endNum = endNum,
        totalSpells = modalState.totalSpells
    }
end

-- Initialize search timer frame (WoW 3.3.5 compatible)
local function initializeSearchTimer()
    if not realtimeSearchFrame then
        realtimeSearchFrame = CreateFrame("Frame")
        realtimeSearchFrame:Hide()
        realtimeSearchFrame:SetScript("OnUpdate", function(self, elapsed)
            self.timeLeft = (self.timeLeft or 0) - elapsed
            if self.timeLeft <= 0 then
                self:Hide()
                -- Execute the search
                local modal = SpellSelection.state.spellSelectionModal
                if realtimeSearchText and modal and modal:IsVisible() then
                    local currentText = ""
                    if modal.searchBox and modal.searchBox.editBox then
                        currentText = modal.searchBox.editBox:GetText() or ""
                    end
                    
                    -- Verify search text is still the same (user hasn't typed more)
                    if currentText == realtimeSearchText and realtimeSearchText ~= "" then
                        -- Trigger database search via Search module
                        if GMConfig and GMConfig.config and GMConfig.config.debug then
                            print("[GMMenus] Real-time search executing for:", realtimeSearchText)
                        end
                        Search.handleSearchRequest(modal, realtimeSearchText)
                    end
                end
            end
        end)
    end
end

-- Handle real-time spell search with debouncing
function Search.handleRealtimeSpellSearch(searchText)
    -- Initialize timer frame if needed
    initializeSearchTimer()
    
    -- Cancel previous timer by hiding the frame
    if realtimeSearchFrame then
        realtimeSearchFrame:Hide()
    end
    
    local modal = SpellSelection.state.spellSelectionModal
    if not modal then return end
    
    -- Handle empty search - show predefined spells immediately
    if not searchText or searchText == "" or string.len(searchText) == 0 then
        SpellSelection.filterSpells("")
        -- Update UI to show we're in predefined mode
        if modal.spellCountLabel then
            modal.spellCountLabel:SetText("Showing predefined spells")
        end
        return
    end
    
    -- For very short search terms, still show predefined spells filtered
    if string.len(searchText) < 2 then
        SpellSelection.filterSpells(searchText)
        if modal.spellCountLabel then
            modal.spellCountLabel:SetText("Filtering predefined spells...")
        end
        return
    end
    
    -- Show immediate feedback for longer search terms
    if modal.spellCountLabel then
        modal.spellCountLabel:SetText("Searching database...")
        modal.spellCountLabel:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3]) -- White while searching
    end
    
    -- Store search text and start timer for database search (debounced)
    realtimeSearchText = searchText
    realtimeSearchFrame.timeLeft = SEARCH_DELAY
    realtimeSearchFrame:Show()
end

-- Handle search results from unified SearchManager
function Search.handleSearchResults(results, pagination, metadata)
    local modal = SpellSelection.state.spellSelectionModal
    if not modal then return end

    -- Update modal state with pagination info
    Search.updateModalState(modal,
        pagination.currentOffset,
        pagination.pageSize,
        pagination.hasNextPage,
        pagination.totalCount)

    -- Transform results to expected format (server sends spellId, client expects id)
    local transformedResults = {}
    for _, spell in ipairs(results) do
        table.insert(transformedResults, {
            id = spell.spellId,
            name = spell.name
        })
    end

    -- Update UI with results (delegate to SpellRows module)
    if SpellSelection.Rows and SpellSelection.Rows.displaySpellRows then
        SpellSelection.Rows.displaySpellRows(modal, transformedResults)
    end

    -- Handle fuzzy suggestions if no results found
    if metadata and metadata.hasSuggestions and #transformedResults == 0 then
        Search.displaySuggestions(modal, metadata)
    else
        Search.clearSuggestions(modal)
    end

    -- Update spell count label
    if modal.spellCountLabel then
        if pagination.totalCount > 0 then
            modal.spellCountLabel:SetText(string.format("Showing %d-%d of %d spells",
                pagination.currentOffset + 1,
                math.min(pagination.currentOffset + pagination.resultCount, pagination.totalCount),
                pagination.totalCount))
        elseif pagination.totalCount == 0 then
            if metadata and metadata.hasSuggestions then
                modal.spellCountLabel:SetText(string.format("No spells found for '%s'", metadata.originalQuery or ""))
            else
                modal.spellCountLabel:SetText("No spells found")
            end
        else
            -- Unknown total count
            modal.spellCountLabel:SetText(string.format("Showing %d spells", pagination.resultCount))
        end
    end

    if GMConfig and GMConfig.config and GMConfig.config.debug then
        print(string.format("[SpellSearch] Received %d results (page %d/%d)",
            #results, pagination.currentPage, pagination.totalPages))
    end
end

-- Display fuzzy suggestions (Did you mean...?)
function Search.displaySuggestions(modal, metadata)
    if not modal or not metadata or not metadata.suggestions then
        return
    end

    -- Clear existing suggestions
    Search.clearSuggestions(modal)

    -- Create suggestions container if it doesn't exist
    if not modal.suggestionsContainer then
        modal.suggestionsContainer = CreateFrame("Frame", nil, modal.spellListFrame)
        modal.suggestionsContainer:SetPoint("TOP", modal.spellListFrame, "TOP", 0, -5)
        modal.suggestionsContainer:SetWidth(modal.spellListFrame:GetWidth() - 20)
        modal.suggestionsContainer:SetHeight(1)

        -- Title
        local title = modal.suggestionsContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        title:SetPoint("TOPLEFT", 10, -5)
        title:SetText("Did you mean:")
        title:SetTextColor(UISTYLE_COLORS.Yellow[1], UISTYLE_COLORS.Yellow[2], UISTYLE_COLORS.Yellow[3])
        modal.suggestionsContainer.title = title

        modal.suggestionsContainer.buttons = {}
    end

    -- Show container
    modal.suggestionsContainer:Show()

    -- Create suggestion buttons
    local yOffset = -25
    for i, suggestion in ipairs(metadata.suggestions) do
        if i > 5 then break end

        local btn = CreateFrame("Button", nil, modal.suggestionsContainer)
        btn:SetSize(modal.suggestionsContainer:GetWidth() - 20, 22)
        btn:SetPoint("TOPLEFT", 10, yOffset)

        -- Button background
        btn:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
        btn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
        btn:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")

        -- Button text
        local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("LEFT", 5, 0)
        text:SetText(string.format("%s (similarity: %d%%)", suggestion.name, suggestion.matchSimilarity or 0))
        text:SetTextColor(UISTYLE_COLORS.LightBlue[1], UISTYLE_COLORS.LightBlue[2], UISTYLE_COLORS.LightBlue[3])

        -- Click handler
        btn:SetScript("OnClick", function()
            if modal.searchBox and modal.searchBox.editBox then
                modal.searchBox.editBox:SetText(suggestion.name)
                Search.handleSearchRequest(modal, suggestion.name)
            end
        end)

        table.insert(modal.suggestionsContainer.buttons, btn)
        yOffset = yOffset - 24
    end

    modal.suggestionsContainer:SetHeight(math.abs(yOffset) + 5)
end

-- Clear suggestions display
function Search.clearSuggestions(modal)
    if not modal or not modal.suggestionsContainer then
        return
    end

    for _, btn in ipairs(modal.suggestionsContainer.buttons or {}) do
        btn:Hide()
        btn:SetParent(nil)
    end
    modal.suggestionsContainer.buttons = {}

    modal.suggestionsContainer:Hide()
end