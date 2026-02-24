--[[
    GameMasterUI Fuzzy Matcher Module

    Provides fuzzy string matching for spell name suggestions using:
    - Levenshtein distance algorithm
    - Relevance scoring
    - Configurable similarity thresholds

    Use Cases:
    - "Did you mean..." suggestions when search returns 0 results
    - Typo tolerance in spell searches
    - Finding similar spell names

    Performance:
    - O(n*m) complexity for Levenshtein distance (n, m = string lengths)
    - Optimized with early termination for large distances
    - Cache-friendly implementation
]]--

local FuzzyMatcher = {}

-- Configuration
local CONFIG = {
    MAX_DISTANCE = 3,          -- Maximum edit distance to consider (typos)
    MAX_SUGGESTIONS = 5,       -- Maximum number of suggestions to return
    MIN_SIMILARITY_PERCENT = 60, -- Minimum similarity percentage (0-100)
    CASE_SENSITIVE = false     -- Case-sensitive matching
}

-- =====================================================
-- Levenshtein Distance Algorithm
-- =====================================================

--[[
    Calculate Levenshtein distance between two strings
    (minimum number of single-character edits required)

    @param str1 string First string
    @param str2 string Second string
    @param maxDistance number Optional early termination threshold
    @return number Edit distance (or maxDistance+1 if exceeded)
]]--
local function levenshteinDistance(str1, str2, maxDistance)
    -- Normalize strings
    if not CONFIG.CASE_SENSITIVE then
        str1 = string.lower(str1)
        str2 = string.lower(str2)
    end

    local len1 = #str1
    local len2 = #str2

    -- Early termination checks
    if len1 == 0 then return len2 end
    if len2 == 0 then return len1 end

    -- If length difference exceeds max distance, early exit
    if maxDistance and math.abs(len1 - len2) > maxDistance then
        return maxDistance + 1
    end

    -- Create distance matrix (only need current and previous row)
    local prevRow = {}
    local currRow = {}

    -- Initialize first row
    for i = 0, len2 do
        prevRow[i] = i
    end

    -- Calculate distances
    for i = 1, len1 do
        currRow[0] = i
        local char1 = str1:sub(i, i)

        -- Early termination: track minimum value in row
        local rowMin = currRow[0]

        for j = 1, len2 do
            local char2 = str2:sub(j, j)

            -- Calculate cost of operations
            local deleteCost = prevRow[j] + 1
            local insertCost = currRow[j - 1] + 1
            local substituteCost = prevRow[j - 1] + (char1 == char2 and 0 or 1)

            -- Take minimum
            currRow[j] = math.min(deleteCost, insertCost, substituteCost)

            -- Track row minimum
            if currRow[j] < rowMin then
                rowMin = currRow[j]
            end
        end

        -- Early termination: if minimum in row exceeds max distance, abort
        if maxDistance and rowMin > maxDistance then
            return maxDistance + 1
        end

        -- Swap rows
        prevRow, currRow = currRow, prevRow
    end

    return prevRow[len2]
end

-- =====================================================
-- Similarity Scoring
-- =====================================================

--[[
    Calculate similarity percentage between two strings

    @param str1 string First string
    @param str2 string Second string
    @return number Similarity percentage (0-100)
]]--
local function calculateSimilarity(str1, str2)
    local maxLen = math.max(#str1, #str2)
    if maxLen == 0 then return 100 end

    local distance = levenshteinDistance(str1, str2, CONFIG.MAX_DISTANCE)

    -- If distance exceeds threshold, return 0
    if distance > CONFIG.MAX_DISTANCE then
        return 0
    end

    -- Calculate similarity percentage
    return math.floor((1 - (distance / maxLen)) * 100)
end

-- =====================================================
-- Fuzzy Matching Functions
-- =====================================================

--[[
    Find similar strings from a list

    @param query string Search query
    @param candidates table List of candidate strings
    @param limit number Optional result limit (default: CONFIG.MAX_SUGGESTIONS)
    @return table Array of {text, distance, similarity} sorted by distance
]]--
function FuzzyMatcher.findSimilar(query, candidates, limit)
    if not query or #query == 0 then
        return {}
    end

    if not candidates or #candidates == 0 then
        return {}
    end

    limit = limit or CONFIG.MAX_SUGGESTIONS
    local matches = {}

    -- Calculate distances for all candidates
    for _, candidate in ipairs(candidates) do
        local distance = levenshteinDistance(query, candidate, CONFIG.MAX_DISTANCE)

        -- Only include if within threshold
        if distance <= CONFIG.MAX_DISTANCE then
            local similarity = calculateSimilarity(query, candidate)

            if similarity >= CONFIG.MIN_SIMILARITY_PERCENT then
                table.insert(matches, {
                    text = candidate,
                    distance = distance,
                    similarity = similarity
                })
            end
        end
    end

    -- Sort by distance (ascending), then similarity (descending)
    table.sort(matches, function(a, b)
        if a.distance ~= b.distance then
            return a.distance < b.distance
        end
        return a.similarity > b.similarity
    end)

    -- Limit results
    if #matches > limit then
        local limited = {}
        for i = 1, limit do
            table.insert(limited, matches[i])
        end
        return limited
    end

    return matches
end

--[[
    Find similar spell names from spell data

    @param query string Search query
    @param spellData table Array of spell objects with 'name' field
    @param limit number Optional result limit
    @return table Array of spell objects sorted by relevance
]]--
function FuzzyMatcher.findSimilarSpells(query, spellData, limit)
    if not query or #query == 0 or not spellData then
        return {}
    end

    limit = limit or CONFIG.MAX_SUGGESTIONS
    local matches = {}

    -- Calculate distances for all spell names
    for _, spell in ipairs(spellData) do
        if spell and spell.name then
            local distance = levenshteinDistance(query, spell.name, CONFIG.MAX_DISTANCE)

            if distance <= CONFIG.MAX_DISTANCE then
                local similarity = calculateSimilarity(query, spell.name)

                if similarity >= CONFIG.MIN_SIMILARITY_PERCENT then
                    -- Clone spell object and add matching metadata
                    local matchedSpell = {}
                    for k, v in pairs(spell) do
                        matchedSpell[k] = v
                    end
                    matchedSpell.matchDistance = distance
                    matchedSpell.matchSimilarity = similarity

                    table.insert(matches, matchedSpell)
                end
            end
        end
    end

    -- Sort by distance, then similarity
    table.sort(matches, function(a, b)
        if a.matchDistance ~= b.matchDistance then
            return a.matchDistance < b.matchDistance
        end
        return a.matchSimilarity > b.matchSimilarity
    end)

    -- Limit results
    if #matches > limit then
        local limited = {}
        for i = 1, limit do
            table.insert(limited, matches[i])
        end
        return limited
    end

    return matches
end

--[[
    Check if two strings are similar within threshold

    @param str1 string First string
    @param str2 string Second string
    @return boolean True if similar
    @return number Distance (if similar)
]]--
function FuzzyMatcher.isSimilar(str1, str2)
    local distance = levenshteinDistance(str1, str2, CONFIG.MAX_DISTANCE)
    local isSimilar = distance <= CONFIG.MAX_DISTANCE

    if isSimilar then
        local similarity = calculateSimilarity(str1, str2)
        return similarity >= CONFIG.MIN_SIMILARITY_PERCENT, distance
    end

    return false, distance
end

-- =====================================================
-- Configuration Functions
-- =====================================================

--[[
    Update configuration

    @param config table Configuration overrides
]]--
function FuzzyMatcher.configure(config)
    if config.maxDistance then
        CONFIG.MAX_DISTANCE = config.maxDistance
    end

    if config.maxSuggestions then
        CONFIG.MAX_SUGGESTIONS = config.maxSuggestions
    end

    if config.minSimilarityPercent then
        CONFIG.MIN_SIMILARITY_PERCENT = config.minSimilarityPercent
    end

    if config.caseSensitive ~= nil then
        CONFIG.CASE_SENSITIVE = config.caseSensitive
    end
end

--[[
    Get current configuration

    @return table Configuration object
]]--
function FuzzyMatcher.getConfig()
    return {
        maxDistance = CONFIG.MAX_DISTANCE,
        maxSuggestions = CONFIG.MAX_SUGGESTIONS,
        minSimilarityPercent = CONFIG.MIN_SIMILARITY_PERCENT,
        caseSensitive = CONFIG.CASE_SENSITIVE
    }
end

-- =====================================================
-- Utility Functions
-- =====================================================

--[[
    Calculate Levenshtein distance (exposed for testing)

    @param str1 string First string
    @param str2 string Second string
    @return number Edit distance
]]--
function FuzzyMatcher.distance(str1, str2)
    return levenshteinDistance(str1, str2, nil)
end

--[[
    Calculate similarity percentage (exposed for testing)

    @param str1 string First string
    @param str2 string Second string
    @return number Similarity (0-100)
]]--
function FuzzyMatcher.similarity(str1, str2)
    return calculateSimilarity(str1, str2)
end

-- Export module
return FuzzyMatcher
