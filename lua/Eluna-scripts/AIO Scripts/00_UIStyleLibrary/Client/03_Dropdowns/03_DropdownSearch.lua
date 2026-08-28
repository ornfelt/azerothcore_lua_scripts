local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- DROPDOWN SEARCH FILTER
-- ===================================
-- Pure search/filter functions for dropdown menus (no closure dependencies)

DropdownSearchFilter = {}

--- Calculates a fuzzy match score between text and a search query
-- @param text - The text to score against
-- @param query - The lowercased search query
-- @param queryWords - Table of individual words from the query
-- @return number - Score (higher = better match, 0 = no match)
function DropdownSearchFilter.CalculateScore(text, query, queryWords)
    local lowerText = string.lower(text)
    local score = 0

    -- Exact match gets highest score
    if lowerText == query then
        return 100
    end

    -- Contains exact query gets high score
    if string.find(lowerText, query, 1, true) then
        score = score + 50
        -- Bonus if it starts with the query
        if string.find(lowerText, "^" .. query) then
            score = score + 20
        end
    end

    -- Word boundary matches
    for _, word in ipairs(queryWords) do
        if string.find(lowerText, "%f[%w]" .. word) then
            score = score + 15
        end
        if string.find(lowerText, word, 1, true) then
            score = score + 5
        end
    end

    -- Fuzzy matching - characters appear in order (not necessarily consecutive)
    if #queryWords == 1 then
        local query_chars = {}
        for c in query:gmatch(".") do
            table.insert(query_chars, c)
        end

        local text_pos = 1
        local matched_chars = 0

        for _, char in ipairs(query_chars) do
            local found_pos = string.find(lowerText, char, text_pos, true)
            if found_pos then
                matched_chars = matched_chars + 1
                text_pos = found_pos + 1
            end
        end

        if matched_chars == #query_chars then
            score = score + math.floor(matched_chars * 2)
        end
    end

    return score
end

--- Filters a list of dropdown items by a search query using fuzzy matching
-- @param itemList - Table of item data (strings, tables with .text, separators, titles)
-- @param searchQuery - The search string to filter by
-- @return table - Filtered and scored items (best matches first)
function DropdownSearchFilter.FilterItems(itemList, searchQuery)
    -- Safety checks
    if not itemList or type(itemList) ~= "table" then
        return {}
    end
    if not searchQuery or searchQuery == "" then
        return itemList
    end

    local filtered = {}
    local scored = {}
    local lowerQuery = string.lower(searchQuery)
    local queryWords = {}

    -- Split query into words for better matching
    for word in lowerQuery:gmatch("%w+") do
        table.insert(queryWords, word)
    end

    for _, itemData in ipairs(itemList) do
        -- Handle different item data formats
        if type(itemData) == "table" and itemData.isSeparator then
            -- Skip separators in search
        elseif type(itemData) == "table" and itemData.isTitle then
            -- Include titles but don't filter them (unless they match)
            local titleText = itemData.text or ""
            local titleScore = DropdownSearchFilter.CalculateScore(titleText, lowerQuery, queryWords)
            if titleScore > 0 or lowerQuery == "" then
                table.insert(filtered, itemData)
            end
        else
            -- Process regular items for filtering
            local itemText = ""

            if type(itemData) == "string" then
                itemText = itemData
            elseif type(itemData) == "table" and itemData.text then
                itemText = itemData.text
            end

            -- Calculate match score
            if itemText ~= "" then
                local itemScore = DropdownSearchFilter.CalculateScore(itemText, lowerQuery, queryWords)
                if itemScore > 0 then
                    table.insert(scored, {item = itemData, score = itemScore})
                end
            end
        end
    end

    -- Sort by score (highest first)
    table.sort(scored, function(a, b) return a.score > b.score end)

    -- Add scored items to filtered list
    for _, entry in ipairs(scored) do
        table.insert(filtered, entry.item)
    end

    return filtered
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["DropdownSearch"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: DropdownSearch module loaded")
end
