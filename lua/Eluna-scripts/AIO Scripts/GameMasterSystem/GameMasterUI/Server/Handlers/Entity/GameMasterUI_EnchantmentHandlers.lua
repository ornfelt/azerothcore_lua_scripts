-- GameMasterUI Enchantment Handlers
-- Server-side handlers for enchantment data

local EnchantmentHandlers = {}

-- Try to load Utils if available
local Utils = _G.Utils or _G.GameMasterUI_Utils

-- Load enchantment data - check if it's already loaded globally first
local EnchantmentData = _G.EnchantmentData
if not EnchantmentData then
    -- Try to load it
    local success, data = pcall(function()
        return require("GameMasterUI_EnchantmentData")
    end)
    if success then
        EnchantmentData = data
    else
        print("[EnchantmentHandlers] Warning: Could not load EnchantmentData module")
    end
end

-- ============================================================================
-- Enchantment Data Functions
-- ============================================================================

-- Send enchantment data to client
function EnchantmentHandlers.sendEnchantmentData(player, slotType)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "error", "You do not have permission to access enchantment data.")
        else
            player:SendBroadcastMessage("|cffff0000You do not have permission to access enchantment data.|r")
        end
        return
    end
    
    local enchants = {}
    
    if EnchantmentData then
        if slotType then
            -- Get enchants for specific slot
            enchants = EnchantmentData.GetEnchantsBySlot(slotType)
        else
            -- Get all enchants
            enchants = EnchantmentData.GetAllEnchantments()
        end
    else
        print("[EnchantmentHandlers] Warning: EnchantmentData not available, sending empty list")
    end
    
    -- Send to client
    AIO.Handle(player, "GameMasterSystem", "receiveEnchantmentData", enchants)
end

-- Query database for enchantments (optional - requires DBC extraction)
function EnchantmentHandlers.queryDatabaseEnchantments(player)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "error", "You do not have permission to query enchantments.")
        else
            player:SendBroadcastMessage("|cffff0000You do not have permission to query enchantments.|r")
        end
        return
    end
    
    -- Check if spell_item_enchantment table exists (from DBC extraction)
    local checkQuery = [[
        SELECT COUNT(*) as count 
        FROM information_schema.tables 
        WHERE table_schema = DATABASE() 
        AND table_name = 'spell_item_enchantment'
    ]]
    
    local result = WorldDBQuery(checkQuery)
    if not result or result:GetUInt32(0) == 0 then
        -- Table doesn't exist, use hardcoded data
        print("[EnchantmentHandlers] spell_item_enchantment table not found, using hardcoded data")
        EnchantmentHandlers.sendEnchantmentData(player)
        return
    end
    
    -- Query enchantments from database
    local query = [[
        SELECT 
            ID,
            Name_lang_enUS as name,
            description_lang_enUS as description,
            m_effectArg_1,
            m_effectArg_2,
            m_effectArg_3,
            m_effectPointsMin_1,
            m_effectPointsMax_1,
            m_requiredSkillID,
            m_requiredSkillRank,
            m_minLevel
        FROM spell_item_enchantment
        WHERE ID > 0
        AND Name_lang_enUS IS NOT NULL
        AND Name_lang_enUS != ''
        ORDER BY ID
        LIMIT 500
    ]]
    
    local enchantments = {}
    local queryResult = WorldDBQuery(query)
    
    if queryResult then
        repeat
            local enchant = {
                id = queryResult:GetUInt32(0),
                name = queryResult:GetString(1),
                description = queryResult:GetString(2) or "",
                skillRequired = queryResult:GetUInt32(8),
                skillRank = queryResult:GetUInt32(9),
                minLevel = queryResult:GetUInt32(10)
            }
            table.insert(enchantments, enchant)
        until not queryResult:NextRow()
        
        print("[EnchantmentHandlers] Loaded " .. #enchantments .. " enchantments from database")
        
        -- Send database enchantments to client
        AIO.Handle(player, "GameMasterSystem", "receiveDatabaseEnchantments", enchantments)
    else
        -- Query failed, use hardcoded data
        print("[EnchantmentHandlers] Database query failed, using hardcoded data")
        EnchantmentHandlers.sendEnchantmentData(player)
    end
end

-- Get popular enchantments for item type
function EnchantmentHandlers.getPopularEnchantments(player, itemEntry)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "error", "You do not have permission to access enchantment data.")
        else
            player:SendBroadcastMessage("|cffff0000You do not have permission to access enchantment data.|r")
        end
        return
    end
    
    -- Query item info to determine slot
    local itemQuery = string.format([[
        SELECT 
            class,
            subclass,
            InventoryType
        FROM item_template
        WHERE entry = %d
    ]], itemEntry)
    
    local result = WorldDBQuery(itemQuery)
    if not result then
        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "error", "Item not found in database.")
        else
            player:SendBroadcastMessage("|cffff0000Item not found in database.|r")
        end
        return
    end
    
    local itemClass = result:GetUInt32(0)
    local itemSubclass = result:GetUInt32(1) 
    local inventoryType = result:GetUInt32(2)
    
    -- Map inventory type to slot
    local slotMap = {
        [1] = "INVTYPE_HEAD",
        [2] = "INVTYPE_NECK",
        [3] = "INVTYPE_SHOULDER",
        [4] = "INVTYPE_BODY",
        [5] = "INVTYPE_CHEST",
        [6] = "INVTYPE_WAIST",
        [7] = "INVTYPE_LEGS",
        [8] = "INVTYPE_FEET",
        [9] = "INVTYPE_WRIST",
        [10] = "INVTYPE_HAND",
        [11] = "INVTYPE_FINGER",
        [12] = "INVTYPE_TRINKET",
        [13] = "INVTYPE_WEAPON",
        [14] = "INVTYPE_SHIELD",
        [15] = "INVTYPE_RANGED",
        [16] = "INVTYPE_CLOAK",
        [17] = "INVTYPE_2HWEAPON",
        [18] = "INVTYPE_BAG",
        [19] = "INVTYPE_TABARD",
        [20] = "INVTYPE_ROBE",
        [21] = "INVTYPE_WEAPONMAINHAND",
        [22] = "INVTYPE_WEAPONOFFHAND",
        [23] = "INVTYPE_HOLDABLE",
        [24] = "INVTYPE_AMMO",
        [25] = "INVTYPE_THROWN",
        [26] = "INVTYPE_RANGEDRIGHT",
        [27] = "INVTYPE_QUIVER",
        [28] = "INVTYPE_RELIC"
    }
    
    local slotType = slotMap[inventoryType] or "UNKNOWN"
    
    -- Get enchants for this slot type
    local enchants = {}
    if EnchantmentData then
        enchants = EnchantmentData.GetEnchantsBySlot(slotType)
    else
        print("[EnchantmentHandlers] Warning: EnchantmentData not available")
    end
    
    -- Send to client
    AIO.Handle(player, "GameMasterSystem", "receivePopularEnchantments", itemEntry, enchants)
end

-- Apply enchantment with validation
function EnchantmentHandlers.applyEnchantmentWithValidation(player, targetName, slotInfo, enchantId, isEquipment)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "error", "You do not have permission to enchant items.")
        else
            player:SendBroadcastMessage("|cffff0000You do not have permission to enchant items.|r")
        end
        return
    end
    
    -- Check if this is a random suffix enchantment (ID > 50000)
    if enchantId > 50000 then
        -- This is a random suffix enchantment
        local suffixId = enchantId - 50000
        
        -- Load RandomSuffixData if needed
        local RandomSuffixData = _G.RandomSuffixData
        if not RandomSuffixData then
            local success, data = pcall(function()
                return require("GameMasterUI_RandomSuffixData")
            end)
            if success then
                RandomSuffixData = data
            else
                print("[EnchantmentHandlers] Warning: Could not load RandomSuffixData")
            end
        end
        
        if RandomSuffixData then
            local suffixData = RandomSuffixData.GetRandomSuffixById(suffixId)
            if suffixData then
                print(string.format("[EnchantmentHandlers] Applying random suffix: %s (Original ID: %d)", 
                    suffixData.name, suffixId))
                
                -- For random suffixes, we need to apply the actual enchantment IDs
                -- The first enchantment in the list is typically the primary one
                if suffixData.enchants and suffixData.enchants[1] then
                    local primaryEnchantId = suffixData.enchants[1][1]
                    print(string.format("[EnchantmentHandlers] Using primary enchant ID: %d", primaryEnchantId))
                    enchantId = primaryEnchantId -- Use the primary enchant ID
                end
            else
                print(string.format("[EnchantmentHandlers] Warning: Random suffix ID %d not found", suffixId))
            end
        end
    else
        -- Regular enchantment
        local enchantData = nil
        if EnchantmentData then
            enchantData = EnchantmentData.GetEnchantmentById(enchantId)
            if not enchantData then
                -- Try to apply anyway (might be a valid ID not in our list)
                print(string.format("[EnchantmentHandlers] Warning: Enchantment ID %d not found in data, attempting anyway", enchantId))
            else
                print(string.format("[EnchantmentHandlers] Applying enchantment: %s (ID: %d)", enchantData.name, enchantId))
            end
        else
            print(string.format("[EnchantmentHandlers] Warning: EnchantmentData not available, applying ID %d", enchantId))
        end
    end
    
    -- Forward to existing item handler
    local ItemHandlers = _G.ItemHandlers or _G.GameMasterUI_ItemHandlers
    if ItemHandlers and ItemHandlers.enchantPlayerItem then
        ItemHandlers.enchantPlayerItem(player, targetName, slotInfo, enchantId, isEquipment)
    else
        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "error", "Item handlers not available.")
        else
            player:SendBroadcastMessage("|cffff0000Item handlers not available.|r")
        end
    end
end

-- ============================================================================
-- Registration
-- ============================================================================

function EnchantmentHandlers.register()
    print("[EnchantmentHandlers] Registering enchantment handlers...")
    
    -- Register handlers with GameMasterSystem
    if _G.GameMasterSystem then
        _G.GameMasterSystem.sendEnchantmentData = EnchantmentHandlers.sendEnchantmentData
        _G.GameMasterSystem.queryDatabaseEnchantments = EnchantmentHandlers.queryDatabaseEnchantments
        _G.GameMasterSystem.getPopularEnchantments = EnchantmentHandlers.getPopularEnchantments
        _G.GameMasterSystem.applyEnchantmentWithValidation = EnchantmentHandlers.applyEnchantmentWithValidation
        
        print("[EnchantmentHandlers] Successfully registered enchantment handlers")
    else
        print("[EnchantmentHandlers] ERROR: GameMasterSystem not found!")
    end
end

-- Auto-register on load
EnchantmentHandlers.register()

return EnchantmentHandlers