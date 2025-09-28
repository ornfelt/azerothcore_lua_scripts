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

-- Spell Search Module
local Search = SpellSelection.Search

-- Default configuration constants
Search.DEFAULT_PAGE_SIZE = 50
Search.MIN_PAGE_SIZE = 10
Search.MAX_PAGE_SIZE = 500

-- Real-time search state
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
    local pageSize = Search.getValidPageSize(modalState)
    AIO.Handle("GameMasterSystem", "searchSpells", searchText or "", modalState.currentOffset, pageSize)
end

-- Handle pagination navigation
function Search.handlePreviousPage(modalState, searchText)
    if not modalState or modalState.currentOffset <= 0 then return end
    
    local pageSize = Search.getValidPageSize(modalState)
    modalState.currentOffset = math.max(0, modalState.currentOffset - pageSize)
    AIO.Handle("GameMasterSystem", "searchSpells", searchText or "", modalState.currentOffset, pageSize)
end

function Search.handleNextPage(modalState, searchText)
    if not modalState or not modalState.hasMoreData then return end
    
    local pageSize = Search.getValidPageSize(modalState)
    modalState.currentOffset = modalState.currentOffset + pageSize
    AIO.Handle("GameMasterSystem", "searchSpells", searchText or "", modalState.currentOffset, pageSize)
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