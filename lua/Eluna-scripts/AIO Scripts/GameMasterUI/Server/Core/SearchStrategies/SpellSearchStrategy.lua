--[[
    GameMasterUI - Spell Search Strategy

    Configuration for spell search using the unified SearchManager

    Features:
    - Search by spell name or ID
    - Pagination support
    - Result caching (10 minutes)
    - Spell icon and metadata retrieval
]]--

local SpellSearchStrategy = {}

-- Module dependencies
local Utils
local FuzzyMatcher

function SpellSearchStrategy.Initialize(utils, fuzzyMatcher)
    Utils = utils
    FuzzyMatcher = fuzzyMatcher
end

--[[
    Create and return the spell search configuration
]]--
function SpellSearchStrategy.GetConfig()
    return {
        -- Unique identifier
        searchType = "spells",

        -- Permissions
        requiredGMRank = 2,

        -- Caching configuration
        cache = {
            enabled = true,
            ttl = 600,  -- 10 minutes (spells rarely change)
            keyGenerator = function(params)
                return table.concat({
                    params.query or "",
                    params.offset,
                    params.pageSize
                }, ":")
            end
        },

        -- Pagination configuration
        pagination = {
            defaultPageSize = 50,
            minPageSize = 10,
            maxPageSize = 500
        },

        -- Build count query for accurate pagination
        buildCountQuery = function(params)
            local query = params.query or ""

            if query == "" then
                return [[
                    SELECT COUNT(*)
                    FROM spell
                    WHERE spellName0 != ''
                ]]
            else
                return string.format([[
                    SELECT COUNT(*)
                    FROM spell
                    WHERE spellName0 LIKE '%%%s%%' OR id = '%s'
                ]], query, query)
            end
        end,

        -- Build main query
        buildQuery = function(params)
            local query = params.query or ""
            local offset = params.offset or 0
            local pageSize = params.pageSize or 50

            if query == "" then
                -- Get all spells (no search filter)
                return string.format([[
                    SELECT id, spellName0
                    FROM spell
                    WHERE spellName0 != ''
                    ORDER BY id ASC
                    LIMIT %d OFFSET %d
                ]], pageSize, offset)
            else
                -- Search by name or ID
                return string.format([[
                    SELECT id, spellName0
                    FROM spell
                    WHERE spellName0 LIKE '%%%s%%' OR id = '%s'
                    ORDER BY id ASC
                    LIMIT %d OFFSET %d
                ]], query, query, pageSize, offset)
            end
        end,

        -- Transform database row to result object
        transformResult = function(dbRow, params)
            local spellId = dbRow:GetUInt32(0)
            local spellName = dbRow:GetString(1)

            return {
                spellId = spellId,
                name = spellName
                -- Note: Icon is fetched client-side using GetSpellTexture
            }
        end,

        -- Parameter validation
        validateParams = function(params)
            -- Spell search has no special validation requirements
            -- Base validation (pagination, sanitization) handled by SearchManager
            return true, nil
        end,

        -- Post-processing: Add fuzzy suggestions if no results
        postProcess = function(results, params)
            local query = params.query or ""

            -- Only add suggestions if search had a query and returned 0 results
            if query ~= "" and #results == 0 and FuzzyMatcher then
                -- Query for similar spell names using fuzzy matching
                local suggestionQuery = string.format([[
                    SELECT id, spellName0
                    FROM spell
                    WHERE spellName0 != ''
                    ORDER BY id ASC
                    LIMIT 100
                ]])

                -- Execute query synchronously for suggestions (small result set)
                local suggestionResult = WorldDBQuery(suggestionQuery)
                if suggestionResult then
                    local candidates = {}
                    repeat
                        local spellId = suggestionResult:GetUInt32(0)
                        local spellName = suggestionResult:GetString(1)
                        table.insert(candidates, {
                            spellId = spellId,
                            name = spellName
                        })
                    until not suggestionResult:NextRow()

                    -- Find similar spell names using fuzzy matching
                    local suggestions = FuzzyMatcher.findSimilarSpells(query, candidates, 5)

                    -- Add suggestions metadata to results
                    if #suggestions > 0 then
                        return results, {
                            hasSuggestions = true,
                            suggestions = suggestions,
                            originalQuery = query
                        }
                    end
                end
            end

            -- No suggestions needed or found
            return results, nil
        end
    }
end

--[[
    Register this search strategy with SearchManager
]]--
function SpellSearchStrategy.Register(searchManager, utils, fuzzyMatcher)
    SpellSearchStrategy.Initialize(utils, fuzzyMatcher)
    local config = SpellSearchStrategy.GetConfig()
    searchManager.RegisterSearchType(config)
end

return SpellSearchStrategy
