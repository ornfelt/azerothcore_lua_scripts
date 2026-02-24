--[[
    GameMasterUI Query Cache Module

    Provides LRU (Least Recently Used) + TTL caching for database query results:
    - Zone name caching (TTL: 300s - zones rarely change)
    - Ban status caching (TTL: 60s - needs frequent updates)
    - Player data caching (TTL: 30s - frequently changing)
    - Batch query support for multiple keys

    Performance Benefits:
    - True LRU eviction policy with doubly-linked list
    - O(1) lookups, inserts, and evictions
    - Reduces N+1 query patterns
    - Eliminates repeated lookups
    - Configurable TTL per cache type

    LRU Implementation:
    - Doubly-linked list tracks access order
    - Most recently used items at head
    - Least recently used items at tail
    - Evict from tail when cache is full
]]--

local QueryCache = {}

-- LRU Node structure for doubly-linked list
local function createNode(key, value, expiry)
    return {
        key = key,
        value = value,
        expiry = expiry,
        prev = nil,
        next = nil
    }
end

-- LRU Cache structure for each cache type
local function createLRUCache(maxSize)
    return {
        map = {},      -- key -> node
        head = nil,    -- most recently used
        tail = nil,    -- least recently used
        size = 0,
        maxSize = maxSize
    }
end

-- Cache storage with LRU support
local caches = {
    zones = createLRUCache(500),      -- Zone ID -> Zone Name
    banStatus = createLRUCache(1000), -- "accountId:charGuid" -> {banned: bool, type: string}
    playerData = createLRUCache(200), -- Player GUID -> full player data
    itemData = createLRUCache(1000),  -- Item ID -> item template data
}

-- TTL configuration (in seconds)
local TTL_CONFIG = {
    zones = 300,      -- 5 minutes (zones rarely change)
    banStatus = 60,   -- 1 minute (bans need frequent updates)
    playerData = 30,  -- 30 seconds (player data changes frequently)
    itemData = 600,   -- 10 minutes (item templates rarely change)
}

-- Cache statistics for monitoring
local stats = {
    zones = { hits = 0, misses = 0, sets = 0 },
    banStatus = { hits = 0, misses = 0, sets = 0 },
    playerData = { hits = 0, misses = 0, sets = 0 },
    itemData = { hits = 0, misses = 0, sets = 0 },
}

-- Reference to config (will be injected)
local Config

-- =====================================================
-- LRU Helper Functions
-- =====================================================

-- Get current timestamp
local function getCurrentTime()
    return os.time()
end

-- Remove node from doubly-linked list
local function removeNode(lru, node)
    if node.prev then
        node.prev.next = node.next
    else
        lru.head = node.next
    end

    if node.next then
        node.next.prev = node.prev
    else
        lru.tail = node.prev
    end
end

-- Add node to head of list (most recently used)
local function addToHead(lru, node)
    node.next = lru.head
    node.prev = nil

    if lru.head then
        lru.head.prev = node
    end

    lru.head = node

    if not lru.tail then
        lru.tail = node
    end
end

-- Move node to head (mark as recently used)
local function moveToHead(lru, node)
    removeNode(lru, node)
    addToHead(lru, node)
end

-- Remove and return least recently used node (from tail)
local function evictLRU(lru)
    if not lru.tail then
        return nil
    end

    local evicted = lru.tail
    removeNode(lru, evicted)
    lru.map[evicted.key] = nil
    lru.size = lru.size - 1

    return evicted
end

-- Clean expired entries from LRU cache
local function cleanExpiredEntries(cacheType)
    local lru = caches[cacheType]
    if not lru then return 0 end

    local currentTime = getCurrentTime()
    local cleaned = 0
    local node = lru.head
    local nodesToRemove = {}

    -- Collect expired nodes
    while node do
        if node.expiry and currentTime > node.expiry then
            table.insert(nodesToRemove, node)
        end
        node = node.next
    end

    -- Remove expired nodes
    for _, expiredNode in ipairs(nodesToRemove) do
        removeNode(lru, expiredNode)
        lru.map[expiredNode.key] = nil
        lru.size = lru.size - 1
        cleaned = cleaned + 1
    end

    return cleaned
end

-- =====================================================
-- Core Cache Functions
-- =====================================================

-- Get value from cache (LRU-aware)
function QueryCache.get(cacheType, key)
    local lru = caches[cacheType]
    if not lru then
        return nil
    end

    local node = lru.map[key]
    if not node then
        stats[cacheType].misses = stats[cacheType].misses + 1
        return nil
    end

    -- Check if expired
    if node.expiry and getCurrentTime() > node.expiry then
        removeNode(lru, node)
        lru.map[key] = nil
        lru.size = lru.size - 1
        stats[cacheType].misses = stats[cacheType].misses + 1
        return nil
    end

    -- Move to head (mark as recently used)
    moveToHead(lru, node)
    stats[cacheType].hits = stats[cacheType].hits + 1
    return node.value
end

-- Set value in cache with TTL (LRU-aware)
function QueryCache.set(cacheType, key, value, customTTL)
    local lru = caches[cacheType]

    if not lru then
        if Config and Config.debug then
            print(string.format("[QueryCache] Invalid cache type: %s", tostring(cacheType)))
        end
        return false
    end

    local ttl = customTTL or TTL_CONFIG[cacheType] or 60
    local expiry = getCurrentTime() + ttl

    -- Check if key already exists
    local existingNode = lru.map[key]
    if existingNode then
        -- Update existing node
        existingNode.value = value
        existingNode.expiry = expiry
        moveToHead(lru, existingNode)
    else
        -- Create new node
        local newNode = createNode(key, value, expiry)

        -- Evict LRU if cache is full
        if lru.size >= lru.maxSize then
            local evicted = evictLRU(lru)
            if Config and Config.debug and evicted then
                print(string.format("[QueryCache] LRU evicted: %s (key: %s)",
                    cacheType, tostring(evicted.key)))
            end
        end

        -- Add new node
        lru.map[key] = newNode
        addToHead(lru, newNode)
        lru.size = lru.size + 1
    end

    stats[cacheType].sets = stats[cacheType].sets + 1
    return true
end

-- Get multiple values (batch get)
function QueryCache.getBatch(cacheType, keys)
    local results = {}
    local missing = {}

    for _, key in ipairs(keys) do
        local value = QueryCache.get(cacheType, key)
        if value ~= nil then
            results[key] = value
        else
            table.insert(missing, key)
        end
    end

    return results, missing
end

-- Set multiple values (batch set)
function QueryCache.setBatch(cacheType, keyValuePairs, customTTL)
    local success = true
    for key, value in pairs(keyValuePairs) do
        if not QueryCache.set(cacheType, key, value, customTTL) then
            success = false
        end
    end
    return success
end

-- =====================================================
-- Specialized Cache Functions
-- =====================================================

-- Zone name caching
function QueryCache.getZoneName(areaId)
    return QueryCache.get("zones", tostring(areaId))
end

function QueryCache.setZoneName(areaId, zoneName)
    return QueryCache.set("zones", tostring(areaId), zoneName)
end

-- Ban status caching
function QueryCache.getBanStatus(accountId, charGuid)
    local key = string.format("%d:%d", accountId, charGuid)
    return QueryCache.get("banStatus", key)
end

function QueryCache.setBanStatus(accountId, charGuid, isBanned, banType)
    local key = string.format("%d:%d", accountId, charGuid)
    local value = { banned = isBanned, type = banType }
    return QueryCache.set("banStatus", key, value)
end

-- Batch ban status lookup
function QueryCache.getBanStatusBatch(playerList)
    local keys = {}
    for _, player in ipairs(playerList) do
        local key = string.format("%d:%d", player.accountId, player.charGuid)
        table.insert(keys, key)
    end

    local cached, missing = QueryCache.getBatch("banStatus", keys)
    return cached, missing
end

-- Player data caching
function QueryCache.getPlayerData(playerGuid)
    return QueryCache.get("playerData", tostring(playerGuid))
end

function QueryCache.setPlayerData(playerGuid, playerData)
    return QueryCache.set("playerData", tostring(playerGuid), playerData)
end

-- Item data caching
function QueryCache.getItemData(itemId)
    return QueryCache.get("itemData", tostring(itemId))
end

function QueryCache.setItemData(itemId, itemData)
    return QueryCache.set("itemData", tostring(itemId), itemData)
end

-- =====================================================
-- Cache Maintenance Functions
-- =====================================================

-- Clear specific cache type (LRU-aware)
function QueryCache.clear(cacheType)
    local lru = caches[cacheType]
    if lru then
        -- Get max size before clearing
        local maxSize = lru.maxSize

        -- Create new LRU cache
        caches[cacheType] = createLRUCache(maxSize)

        -- Reset stats
        stats[cacheType] = { hits = 0, misses = 0, sets = 0 }
        return true
    end
    return false
end

-- Clear all caches
function QueryCache.clearAll()
    for cacheType, _ in pairs(caches) do
        QueryCache.clear(cacheType)
    end
end

-- Clean expired entries from all caches
function QueryCache.cleanExpired()
    local totalCleaned = 0
    for cacheType, _ in pairs(caches) do
        totalCleaned = totalCleaned + cleanExpiredEntries(cacheType)
    end

    if Config and Config.debug and totalCleaned > 0 then
        print(string.format("[QueryCache] Cleaned %d expired entries", totalCleaned))
    end

    return totalCleaned
end

-- Get cache statistics (LRU-aware)
function QueryCache.getStats()
    local totalStats = { hits = 0, misses = 0, sets = 0 }
    local cacheStats = {}

    for cacheType, stat in pairs(stats) do
        local lru = caches[cacheType]

        cacheStats[cacheType] = {
            hits = stat.hits,
            misses = stat.misses,
            sets = stat.sets,
            hitRate = stat.hits + stat.misses > 0 and (stat.hits / (stat.hits + stat.misses)) or 0,
            size = lru and lru.size or 0,
            maxSize = lru and lru.maxSize or 0,
            utilizationPercent = (lru and lru.maxSize > 0) and (lru.size / lru.maxSize * 100) or 0
        }

        totalStats.hits = totalStats.hits + stat.hits
        totalStats.misses = totalStats.misses + stat.misses
        totalStats.sets = totalStats.sets + stat.sets
    end

    totalStats.hitRate = totalStats.hits + totalStats.misses > 0 and
        (totalStats.hits / (totalStats.hits + totalStats.misses)) or 0

    return {
        total = totalStats,
        byType = cacheStats
    }
end

-- Configure TTL for cache type
function QueryCache.setTTL(cacheType, ttlSeconds)
    if TTL_CONFIG[cacheType] then
        TTL_CONFIG[cacheType] = ttlSeconds
        return true
    end
    return false
end

-- Get current TTL configuration
function QueryCache.getTTLConfig()
    local config = {}
    for k, v in pairs(TTL_CONFIG) do
        config[k] = v
    end
    return config
end

-- =====================================================
-- Module Initialization
-- =====================================================

function QueryCache.Initialize(config)
    Config = config

    if Config and Config.debug then
        print("[QueryCache] Initialized with TTL config:")
        for cacheType, ttl in pairs(TTL_CONFIG) do
            print(string.format("  %s: %d seconds", cacheType, ttl))
        end
    end

    -- Start periodic cleanup (every 5 minutes)
    -- Note: This would need to be implemented with a timer system
    -- For now, cleanup will be manual or triggered by cache operations
end

-- Manual cleanup trigger (call periodically)
function QueryCache.periodicCleanup()
    local cleaned = QueryCache.cleanExpired()

    if Config and Config.debug and cleaned > 0 then
        local stats = QueryCache.getStats()
        print(string.format("[QueryCache] Periodic cleanup: %d expired entries removed", cleaned))
        print(string.format("[QueryCache] Cache hit rate: %.2f%%", stats.total.hitRate * 100))
    end
end

return QueryCache