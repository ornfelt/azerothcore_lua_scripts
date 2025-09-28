local DatabaseHelper = require("GameMasterUI.Server.Core.GameMasterUI_DatabaseHelper")

local queries = {
	TrinityCore = {
		loadCreatureDisplays = function()
			return [[
                SELECT `entry`, `name`, `subname`, `IconName`, `type_flags`, `type`, `family`, `rank`, `KillCredit1`, `KillCredit2`, `HealthModifier`, `ManaModifier`, `RacialLeader`, `MovementType`, `modelId1`, `modelId2`, `modelId3`, `modelId4`
                FROM `creature_template`
            ]]
		end,
		npcData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT entry, modelid1, modelid2, modelid3, modelid4, name, subname, type
                FROM creature_template
                WHERE modelid1 != 0 OR modelid2 != 0 OR modelid3 != 0 OR modelid4 != 0
                ORDER BY entry %s
                LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		npcCount = function()
			return [[
                SELECT COUNT(*) 
                FROM creature_template
                WHERE modelid1 != 0 OR modelid2 != 0 OR modelid3 != 0 OR modelid4 != 0;
            ]]
		end,
		gobData = function(sortOrder, pageSize, offset)
			-- Check if gameobjectdisplayinfo table exists
			local hasDisplayInfo = DatabaseHelper.IsOptionalTableAvailable("gameobjectdisplayinfo", "world")
			
			if hasDisplayInfo then
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, m.ModelName
                FROM gameobject_template g
                LEFT JOIN gameobjectdisplayinfo m ON g.displayid = m.ID
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					sortOrder,
					pageSize,
					offset
				)
			else
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, 'N/A' as ModelName
                FROM gameobject_template g
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					sortOrder,
					pageSize,
					offset
				)
			end
		end,
		gobCount = function()
			-- Use simple count without join to avoid issues
			return [[
                SELECT COUNT(*) 
                FROM gameobject_template;
            ]]
		end,
		spellCount = function()
			return [[
                SELECT COUNT(*) 
                FROM spell;
            ]]
		end,
		spellData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
            SELECT id, spellName0, spellDescription0, spellToolTip0, spellVisual1, spellVisual2
            FROM spell
            ORDER BY id %s
            LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchNpcData = function(query, typeId, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT entry, modelid1, modelid2, modelid3, modelid4, name, subname, type
                FROM creature_template
                WHERE name LIKE '%%%s%%' OR subname LIKE '%%%s%%' OR entry LIKE '%%%s%%' %s
                ORDER BY entry %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				query,
				typeId and string.format("OR type = %d", typeId) or "",
				sortOrder,
				pageSize,
				offset * pageSize
			)
		end,
		searchGobData = function(query, typeId, sortOrder, pageSize, offset)
			-- Check if gameobjectdisplayinfo table exists
			local hasDisplayInfo = DatabaseHelper.IsOptionalTableAvailable("gameobjectdisplayinfo", "world")
			
			if hasDisplayInfo then
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, m.ModelName
                FROM gameobject_template g
                LEFT JOIN gameobjectdisplayinfo m ON g.displayid = m.ID
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					sortOrder,
					pageSize,
					offset * pageSize
				)
			else
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, 'N/A' as ModelName
                FROM gameobject_template g
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					sortOrder,
					pageSize,
					offset * pageSize
				)
			end
		end,
		searchSpellData = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT id, spellName0, spellDescription0, spellToolTip0, spellVisual1, spellVisual2
                FROM spell
                WHERE spellName0 LIKE '%%%s%%' OR id LIKE '%%%s%%'
                ORDER BY id %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset * pageSize
			)
		end,
		spellVisualCount = function()
			return [[
                SELECT COUNT(*) 
                FROM spellvisualeffectname;
            ]]
		end,

		spellVisualData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
            SELECT ID, Name, FilePath, AreaEffectSize, Scale, MinAllowedScale, MaxAllowedScale
            FROM spellvisualeffectname
            ORDER BY ID %s
            LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchSpellVisualData = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
            SELECT ID, Name, FilePath, AreaEffectSize, Scale, MinAllowedScale, MaxAllowedScale
            FROM spellvisualeffectname
            WHERE Name LIKE '%%%s%%' OR ID LIKE '%%%s%%'
            ORDER BY ID %s
            LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset * pageSize
			)
		end,
		itemCount = function(inventoryType)
			if inventoryType and inventoryType >= 0 then
				return string.format([[
                    SELECT COUNT(*) 
                    FROM item_template
                    WHERE InventoryType = %d;
                ]], inventoryType)
			else
				return [[
                    SELECT COUNT(*) 
                    FROM item_template;
                ]]
			end
		end,
		itemData = function(sortOrder, pageSize, offset, inventoryType)
			local whereClause = ""
			if inventoryType then
				whereClause = string.format("WHERE InventoryType = %d", inventoryType)
			end

			return string.format(
				[[SELECT entry, name, COALESCE(description, ''), displayid, Quality, InventoryType, ItemLevel, class, subclass
				FROM item_template
				%s
				ORDER BY entry %s
				LIMIT %d OFFSET %d;]],
				whereClause,
				sortOrder,
				pageSize,
				offset
			)
		end,

		searchItemData = function(query, sortOrder, pageSize, offset, inventoryType)
			local whereClause = [[WHERE (name LIKE '%%%s%%' OR entry LIKE '%%%s%%')]]
			if inventoryType then
				whereClause = whereClause .. string.format(" AND InventoryType = %d", inventoryType)
			end

			return string.format(
				[[SELECT entry, name, COALESCE(description, ''), displayid, Quality, InventoryType, ItemLevel, class, subclass
				FROM item_template
				%s
				ORDER BY entry %s
				LIMIT %d OFFSET %d;]],
				string.format(whereClause, escapeString(query), escapeString(query)),
				sortOrder,
				pageSize,
				offset
			)
		end,
	},
	AzerothCore = {
		loadCreatureDisplays = function()
			return [[
                SELECT ct.`entry`, ct.`name`, ct.`subname`, ct.`IconName`, ct.`type_flags`, ct.`type`, ct.`family`, ct.`rank`, ct.`KillCredit1`, ct.`KillCredit2`, ct.`HealthModifier`, ct.`ManaModifier`, ct.`RacialLeader`, ct.`MovementType`, ctm.`CreatureDisplayID`
                FROM `creature_template` ct
                LEFT JOIN `creature_template_model` ctm ON ct.`entry` = ctm.`CreatureID`
            ]]
		end,
		npcData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT ct.entry, ctm.CreatureDisplayID, ct.name, ct.subname, ct.type
                FROM creature_template ct
                LEFT JOIN creature_template_model ctm ON ct.entry = ctm.CreatureID
                ORDER BY ct.entry %s
                LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		gobData = function(sortOrder, pageSize, offset)
			-- Check if gameobjectdisplayinfo table exists
			local hasDisplayInfo = DatabaseHelper.IsOptionalTableAvailable("gameobjectdisplayinfo", "world")
			
			if hasDisplayInfo then
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, m.ModelName
                FROM gameobject_template g
                LEFT JOIN gameobjectdisplayinfo m ON g.displayid = m.ID
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					sortOrder,
					pageSize,
					offset
				)
			else
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, 'N/A' as ModelName
                FROM gameobject_template g
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					sortOrder,
					pageSize,
					offset
				)
			end
		end,
		gobCount = function()
			-- Use simple count without join to avoid issues
			return [[
                SELECT COUNT(*) 
                FROM gameobject_template;
            ]]
		end,
		spellCount = function()
			return [[
                SELECT COUNT(*) 
                FROM spell;
            ]]
		end,
		spellData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT id, spellName0, spellDescription0, spellToolTip0
                FROM spell
                ORDER BY id %s
                LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchNpcData = function(query, typeId, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT ct.entry, ctm.CreatureDisplayID, ct.name, ct.subname, ct.type
                FROM creature_template ct
                LEFT JOIN creature_template_model ctm ON ct.entry = ctm.CreatureID
                WHERE ct.name LIKE '%%%s%%' OR ct.subname LIKE '%%%s%%' OR ct.entry LIKE '%%%s%%' %s
                ORDER BY ct.entry %s
                LIMIT %d OFFSET %d;
            ]],
				escapeString(query),
				escapeString(query),
				escapeString(query),
				typeId and string.format("OR ct.type = %d", typeId) or "",
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchGobData = function(query, typeId, sortOrder, pageSize, offset)
			-- Check if gameobjectdisplayinfo table exists
			local hasDisplayInfo = DatabaseHelper.IsOptionalTableAvailable("gameobjectdisplayinfo", "world")
			
			if hasDisplayInfo then
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, m.ModelName
                FROM gameobject_template g
                LEFT JOIN gameobjectdisplayinfo m ON g.displayid = m.ID
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					sortOrder,
					pageSize,
					offset * pageSize
				)
			else
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, 'N/A' as ModelName
                FROM gameobject_template g
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY g.entry %s
                LIMIT %d OFFSET %d;
                ]],
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					sortOrder,
					pageSize,
					offset * pageSize
				)
			end
		end,
		searchSpellData = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT id, spellName0, spellDescription0, spellToolTip0
                FROM spell
                WHERE spellName0 LIKE '%%%s%%' OR id LIKE '%%%s%%'
                ORDER BY id %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset * pageSize
			)
		end,
		itemCount = function(inventoryType)
			if inventoryType and inventoryType >= 0 then
				return string.format([[
                    SELECT COUNT(*) 
                    FROM item_template
                    WHERE InventoryType = %d;
                ]], inventoryType)
			else
				return [[
                    SELECT COUNT(*) 
                    FROM item_template;
                ]]
			end
		end,
		itemData = function(sortOrder, pageSize, offset, inventoryType)
			local whereClause = ""
			if inventoryType then
				whereClause = string.format("WHERE InventoryType = %d", inventoryType)
			end

			return string.format(
				[[
                SELECT entry, name, description, displayid, InventoryType, Quality, ItemLevel, class, subclass
                FROM item_template
                %s
                ORDER BY entry %s
                LIMIT %d OFFSET %d;
            ]],
				whereClause,
				sortOrder,
				pageSize,
				offset
			)
		end,

		searchItemData = function(query, sortOrder, pageSize, offset, inventoryType)
			local whereClause = [[WHERE (name LIKE '%%%s%%' OR entry LIKE '%%%s%%')]]
			if inventoryType then
				whereClause = whereClause .. string.format(" AND InventoryType = %d", inventoryType)
			end

			return string.format(
				[[
                SELECT entry, name, description, displayid, InventoryType, Quality, ItemLevel, class, subclass
                FROM item_template
                %s
                ORDER BY entry %s
                LIMIT %d OFFSET %d;
            ]],
				string.format(whereClause, query, query),
				sortOrder,
				pageSize,
				offset * pageSize
			)
		end,
	},
}
-- Function to get the appropriate query based on the core name
local function getQuery(coreName, queryType)
    return queries[coreName] and queries[coreName][queryType] or nil
end

-- Table name mappings for different query types
local queryTableMappings = {
    -- NPC queries
    loadCreatureDisplays = {"creature_template", "creature_template_model"},
    npcData = {"creature_template", "creature_template_model"},
    npcCount = {"creature_template"},
    searchNpcData = {"creature_template", "creature_template_model"},
    
    -- GameObject queries
    gobData = {"gameobject_template", "gameobjectdisplayinfo"},
    gobCount = {"gameobject_template"},
    searchGobData = {"gameobject_template", "gameobjectdisplayinfo"},
    
    -- Spell queries
    spellCount = {"spell"},
    spellData = {"spell"},
    searchSpellData = {"spell"},
    spellVisualCount = {"spellvisualeffectname"},
    spellVisualData = {"spellvisualeffectname"},
    searchSpellVisualData = {"spellvisualeffectname"},
    
    -- Item queries
    itemCount = {"item_template"},
    itemData = {"item_template"},
    searchItemData = {"item_template"},
}

-- Safe query execution functions
local function executeSafeQuery(queryFunc, databaseType, queryType)
    databaseType = databaseType or "world"
    
    local success, result = pcall(function()
        local query = queryFunc()
        if not query then
            return nil
        end
        
        -- Add database prefix support if configured
        if DatabaseHelper then
            -- Get the tables used in this query type
            local tables = queryTableMappings[queryType] or {}
            local modifiedQuery, error = DatabaseHelper.BuildSafeQuery(query, tables, databaseType)
            if not modifiedQuery then
                return nil, error
            end
            query = modifiedQuery
        end
        
        return DatabaseHelper.SafeQuery(query, databaseType)
    end)
    
    if success then
        return result
    else
        if DatabaseHelper and DatabaseHelper.debug then
            print(string.format("[GameMasterUI] Query execution failed: %s", tostring(result)))
        end
        return nil
    end
end

-- Initialize database helper when module loads
local function initialize()
    if DatabaseHelper and DatabaseHelper.Initialize then
        -- Config will be injected by the main system
        -- This is just a placeholder - actual initialization happens in Init.lua
    end
end

return {
    queries = queries,
    getQuery = getQuery,
    executeSafeQuery = executeSafeQuery,
    queryTableMappings = queryTableMappings,
    initialize = initialize,
}
