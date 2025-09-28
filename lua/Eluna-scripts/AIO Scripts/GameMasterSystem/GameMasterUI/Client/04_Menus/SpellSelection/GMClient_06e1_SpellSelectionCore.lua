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
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Spell Selection Modal Module
local SpellSelection = {}
GMMenus.SpellSelection = SpellSelection

-- Export submodules for internal use
SpellSelection.Search = {}
SpellSelection.Dialog = {}
SpellSelection.Rows = {}
SpellSelection.ContextMenu = {}
SpellSelection.Duration = {}

-- Local state (shared across submodules)
SpellSelection.state = {
    spellSelectionModal = nil,
    selectedSpells = {},
    targetPlayerNameForSpell = nil,
    currentSpellData = {},
    selectedDuration = nil
}

-- Main entry point - Create the spell selection dialog
function SpellSelection.createDialog(playerName, castType)
    -- Delegate to Dialog module
    return SpellSelection.Dialog.createDialog(playerName, castType)
end

-- Load predefined spells
function SpellSelection.loadPredefinedSpells(castType)
    local spells = {}
    
    -- Normalize cast type for predefined spells (buffWithDuration uses same spells as buff)
    local normalizedType = castType == "buffWithDuration" and "buff" or castType
    
    -- Add all spell categories
    for _, category in ipairs(GMConfig.SPELL_CATEGORIES) do
        for _, spell in ipairs(category.spells) do
            table.insert(spells, {
                spellId = spell.spellId,
                name = spell.name,
                icon = spell.icon,
                category = category.name
            })
        end
    end
    
    local modal = SpellSelection.state.spellSelectionModal
    if modal then
        -- Reset pagination for predefined spells
        modal.currentOffset = 0
        modal.hasMoreData = false
        modal.totalSpells = #spells
        
        -- Hide pagination controls for predefined spells
        if modal.prevButton then
            modal.prevButton:Hide()
        end
        if modal.nextButton then
            modal.nextButton:Hide()
        end
        if modal.pageInfo then
            modal.pageInfo:Hide()
        end
    end
    
    -- Update display
    SpellSelection.updateSpellList(spells)
end

-- Update spell list display
function SpellSelection.updateSpellList(spells)
    local modal = SpellSelection.state.spellSelectionModal
    if not modal then return end
    
    -- Clear existing rows
    for _, row in ipairs(modal.spellRows or {}) do
        row:Hide()
        row:SetParent(nil)
    end
    wipe(modal.spellRows or {})
    modal.spellRows = {}
    
    -- Update count
    if modal.spellCountLabel then
        modal.spellCountLabel:SetText("Showing " .. #spells .. " spells")
    end
    
    -- Create spell rows using Rows module
    SpellSelection.state.currentSpellData = spells
    for i, spellData in ipairs(spells) do
        local row = SpellSelection.Rows.createSpellRow(modal.scrollContent, spellData, i)
        table.insert(modal.spellRows, row)
    end
    
    -- Update scroll content height
    if modal.scrollContent and modal.updateScroll then
        modal.scrollContent:SetHeight(math.max(400, #spells * 35 + 10))
        modal.updateScroll()
    end
end

-- Filter spells by search text
function SpellSelection.filterSpells(searchText)
    local modal = SpellSelection.state.spellSelectionModal
    if not modal then return end
    
    if not searchText or searchText == "" then
        SpellSelection.loadPredefinedSpells(modal.castType)
        return
    end
    
    searchText = searchText:lower()
    local filteredSpells = {}
    
    -- Search through all spell categories
    for _, category in ipairs(GMConfig.SPELL_CATEGORIES) do
        for _, spell in ipairs(category.spells) do
            if spell.name:lower():find(searchText, 1, true) or tostring(spell.spellId):find(searchText, 1, true) then
                table.insert(filteredSpells, {
                    spellId = spell.spellId,
                    name = spell.name,
                    icon = spell.icon,
                    category = category.name
                })
            end
        end
    end
    
    -- Hide pagination for filtered predefined spells
    if modal.prevButton then
        modal.prevButton:Hide()
    end
    if modal.nextButton then
        modal.nextButton:Hide()
    end
    if modal.pageInfo then
        modal.pageInfo:Hide()
    end
    
    SpellSelection.updateSpellList(filteredSpells)
end

-- Confirm spell cast
function SpellSelection.confirmCastSpell()
    local state = SpellSelection.state
    if #state.selectedSpells == 0 then
        print("No spell selected")
        return
    end
    
    local spell = state.selectedSpells[1]
    local modal = state.spellSelectionModal
    local castType = modal and modal.castType
    
    -- Debug logging to help troubleshoot issues
    print("[DEBUG] Spell selection - castType:", castType, "selectedSpells:", #state.selectedSpells, "spellId:", spell.spellId, "target:", state.targetPlayerNameForSpell)
    
    if castType == "buffWithDuration" then
        -- Apply buff with selected duration
        local duration = state.selectedDuration or 60000 -- Default to 1 minute if not set
        AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", state.targetPlayerNameForSpell, spell.spellId, duration)
        local durationText = duration == -1 and "permanent" or string.format("%d seconds", duration / 1000)
        CreateStyledToast(string.format("Applied %s (%s) to %s", spell.name, durationText, state.targetPlayerNameForSpell), 2, 0.5)
    elseif castType == "buff" then
        AIO.Handle("GameMasterSystem", "applyBuffToPlayer", state.targetPlayerNameForSpell, spell.spellId)
    elseif castType == "self" then
        AIO.Handle("GameMasterSystem", "makePlayerCastOnSelf", state.targetPlayerNameForSpell, spell.spellId)
    elseif castType == "target" then
        AIO.Handle("GameMasterSystem", "makePlayerCastOnTarget", state.targetPlayerNameForSpell, spell.spellId)
    elseif castType == "onplayer" then
        AIO.Handle("GameMasterSystem", "castSpellOnPlayer", state.targetPlayerNameForSpell, spell.spellId)
    elseif castType == "learn" then
        -- Handle learning spell
        AIO.Handle("GameMasterSystem", "playerSpellLearn", state.targetPlayerNameForSpell, spell.spellId)
        CreateStyledToast(string.format("Teaching %s to %s...", spell.name, state.targetPlayerNameForSpell), 2, 0.5)
    end
    
    -- Close modal
    if modal then
        modal:Hide()
    end
end

-- Handle spell search results from server
function SpellSelection.updateSpellSearchResults(spells, offset, pageSize, hasMoreData, totalCount)
    local modal = SpellSelection.state.spellSelectionModal
    if not modal or not modal:IsVisible() then
        return
    end
    
    print("[GMMenus] Received", #spells, "spells from server, offset:", offset, "hasMore:", hasMoreData, "total:", totalCount)
    
    -- Update modal state using Search module
    SpellSelection.Search.updateModalState(modal, offset, pageSize, hasMoreData, totalCount)
    
    -- Reset search feedback text color and show results count
    if modal.spellCountLabel then
        modal.spellCountLabel:SetTextColor(0.7, 0.7, 0.7) -- Reset to normal gray
        local searchText = ""
        if modal.searchBox and modal.searchBox.editBox then
            searchText = modal.searchBox.editBox:GetText() or ""
        end
        if searchText ~= "" then
            modal.spellCountLabel:SetText("Database search: " .. #spells .. " results")
        else
            modal.spellCountLabel:SetText("Browsing all spells: " .. #spells .. " results")
        end
    end
    
    -- Show pagination controls for database results
    if modal.prevButton then
        modal.prevButton:Show()
    end
    if modal.nextButton then
        modal.nextButton:Show()
    end
    if modal.pageInfo then
        modal.pageInfo:Show()
    end
    
    -- Update pagination controls
    SpellSelection.updatePaginationControls()
    
    -- Update the spell list with server results
    SpellSelection.updateSpellList(spells)
end

-- Update pagination controls visibility and text
function SpellSelection.updatePaginationControls()
    local modal = SpellSelection.state.spellSelectionModal
    if not modal then return end
    
    -- Update previous button (WoW 3.3.5 uses Enable/Disable)
    if modal.prevButton then
        if modal.currentOffset > 0 then
            modal.prevButton:Enable()
        else
            modal.prevButton:Disable()
        end
    end
    
    -- Update next button (WoW 3.3.5 uses Enable/Disable)
    if modal.nextButton then
        if modal.hasMoreData then
            modal.nextButton:Enable()
        else
            modal.nextButton:Disable()
        end
    end
    
    -- Update page info using Search module
    if modal.pageInfo then
        local paginationInfo = SpellSelection.Search.getPaginationInfo(modal)
        
        if paginationInfo.totalSpells > 0 then
            modal.pageInfo:SetText(string.format("Showing %d-%d of %d", 
                paginationInfo.startNum, paginationInfo.endNum, paginationInfo.totalSpells))
        else
            modal.pageInfo:SetText("Page " .. paginationInfo.currentPage)
        end
    end
end

-- Export the main functions
GMMenus.createSpellSelectionDialog = function(playerName, castType)
    return SpellSelection.createDialog(playerName, castType)
end

GMMenus.updateSpellSearchResults = function(spells, offset, pageSize, hasMoreData, totalCount)
    if SpellSelection.updateSpellSearchResults then
        SpellSelection.updateSpellSearchResults(spells, offset, pageSize, hasMoreData, totalCount)
    end
end