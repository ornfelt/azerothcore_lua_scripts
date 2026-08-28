local DatabaseHelper = require("GameMasterUI.Server.Core.GameMasterUI_DatabaseHelper")
local SpellModule = require("GameMasterUI.Server.Database.GameMasterUI_DatabaseSpells")
local ItemModule = require("GameMasterUI.Server.Database.GameMasterUI_DatabaseItems")

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
			return [[
                SELECT COUNT(*)
                FROM gameobject_template;
            ]]
		end,
		searchNpcData = function(query, typeId, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT entry, modelid1, modelid2, modelid3, modelid4, name, subname, type,
                (
                    CASE
                        WHEN name = '%s' THEN 100
                        WHEN name LIKE '%s %%' THEN 90
                        WHEN name LIKE '%% %s' THEN 85
                        WHEN name LIKE '%s%%' THEN 80
                        WHEN name LIKE '%% %s %%' THEN 70
                        WHEN name LIKE '%%%s%%' THEN 50
                        WHEN subname LIKE '%%%s%%' THEN 30
                        ELSE 10
                    END
                ) as relevance
                FROM creature_template
                WHERE name LIKE '%%%s%%' OR subname LIKE '%%%s%%' OR entry LIKE '%%%s%%' %s
                ORDER BY relevance DESC, name ASC, entry ASC
                LIMIT %d OFFSET %d;
            ]],
				query, query, query, query, query, query, query,
				query, query, query,
				typeId and string.format("OR type = %d", typeId) or "",
				pageSize,
				offset
			)
		end,
		searchGobData = function(query, typeId, sortOrder, pageSize, offset)
			local hasDisplayInfo = DatabaseHelper.IsOptionalTableAvailable("gameobjectdisplayinfo", "world")

			local relevanceCase = string.format([[
                (
                    CASE
                        WHEN g.name = '%s' THEN 100
                        WHEN g.name LIKE '%s %%' THEN 90
                        WHEN g.name LIKE '%% %s' THEN 85
                        WHEN g.name LIKE '%s%%' THEN 80
                        WHEN g.name LIKE '%% %s %%' THEN 70
                        WHEN g.name LIKE '%%%s%%' THEN 50
                        ELSE 10
                    END
                ) as relevance]], query, query, query, query, query, query)

			if hasDisplayInfo then
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, m.ModelName,
                %s
                FROM gameobject_template g
                LEFT JOIN gameobjectdisplayinfo m ON g.displayid = m.ID
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY relevance DESC, g.name ASC, g.entry ASC
                LIMIT %d OFFSET %d;
                ]],
					relevanceCase,
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					pageSize,
					offset
				)
			else
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, 'N/A' as ModelName,
                %s
                FROM gameobject_template g
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY relevance DESC, g.name ASC, g.entry ASC
                LIMIT %d OFFSET %d;
                ]],
					relevanceCase,
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					pageSize,
					offset
				)
			end
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
			return [[
                SELECT COUNT(*)
                FROM gameobject_template;
            ]]
		end,
		searchNpcData = function(query, typeId, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT ct.entry, ctm.CreatureDisplayID, ct.name, ct.subname, ct.type,
                (
                    CASE
                        WHEN ct.name = '%s' THEN 100
                        WHEN ct.name LIKE '%s %%' THEN 90
                        WHEN ct.name LIKE '%% %s' THEN 85
                        WHEN ct.name LIKE '%s%%' THEN 80
                        WHEN ct.name LIKE '%% %s %%' THEN 70
                        WHEN ct.name LIKE '%%%s%%' THEN 50
                        WHEN ct.subname LIKE '%%%s%%' THEN 30
                        ELSE 10
                    END
                ) as relevance
                FROM creature_template ct
                LEFT JOIN creature_template_model ctm ON ct.entry = ctm.CreatureID
                WHERE ct.name LIKE '%%%s%%' OR ct.subname LIKE '%%%s%%' OR ct.entry LIKE '%%%s%%' %s
                ORDER BY relevance DESC, ct.name ASC, ct.entry ASC
                LIMIT %d OFFSET %d;
            ]],
				query, query, query, query, query, query, query,
				query, query, query,
				typeId and string.format("OR ct.type = %d", typeId) or "",
				pageSize,
				offset
			)
		end,
		searchGobData = function(query, typeId, sortOrder, pageSize, offset)
			local hasDisplayInfo = DatabaseHelper.IsOptionalTableAvailable("gameobjectdisplayinfo", "world")

			local relevanceCase = string.format([[
                (
                    CASE
                        WHEN g.name = '%s' THEN 100
                        WHEN g.name LIKE '%s %%' THEN 90
                        WHEN g.name LIKE '%% %s' THEN 85
                        WHEN g.name LIKE '%s%%' THEN 80
                        WHEN g.name LIKE '%% %s %%' THEN 70
                        WHEN g.name LIKE '%%%s%%' THEN 50
                        ELSE 10
                    END
                ) as relevance]], query, query, query, query, query, query)

			if hasDisplayInfo then
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, m.ModelName,
                %s
                FROM gameobject_template g
                LEFT JOIN gameobjectdisplayinfo m ON g.displayid = m.ID
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY relevance DESC, g.name ASC, g.entry ASC
                LIMIT %d OFFSET %d;
                ]],
					relevanceCase,
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					pageSize,
					offset
				)
			else
				return string.format(
					[[
                SELECT g.entry, g.displayid, g.name, g.type, 'N/A' as ModelName,
                %s
                FROM gameobject_template g
                WHERE g.name LIKE '%%%s%%' OR g.entry LIKE '%%%s%%' %s
                ORDER BY relevance DESC, g.name ASC, g.entry ASC
                LIMIT %d OFFSET %d;
                ]],
					relevanceCase,
					query,
					query,
					typeId and string.format("OR g.type = %d", typeId) or "",
					pageSize,
					offset
				)
			end
		end,
	},
}

-- Merge spell queries from sub-module
for coreName, spellFuncs in pairs(SpellModule.queries) do
	if queries[coreName] then
		for funcName, func in pairs(spellFuncs) do
			queries[coreName][funcName] = func
		end
	end
end

-- Merge item queries from sub-module
for coreName, itemFuncs in pairs(ItemModule.queries) do
	if queries[coreName] then
		for funcName, func in pairs(itemFuncs) do
			queries[coreName][funcName] = func
		end
	end
end

local function getQuery(coreName, queryType)
    return queries[coreName] and queries[coreName][queryType] or nil
end

local queryTableMappings = {
    loadCreatureDisplays = {"creature_template", "creature_template_model"},
    npcData = {"creature_template", "creature_template_model"},
    npcCount = {"creature_template"},
    searchNpcData = {"creature_template", "creature_template_model"},
    gobData = {"gameobject_template", "gameobjectdisplayinfo"},
    gobCount = {"gameobject_template"},
    searchGobData = {"gameobject_template", "gameobjectdisplayinfo"},
}

-- Merge table mappings from sub-modules
for key, value in pairs(SpellModule.tableMappings) do
    queryTableMappings[key] = value
end
for key, value in pairs(ItemModule.tableMappings) do
    queryTableMappings[key] = value
end

local function executeSafeQuery(queryFunc, databaseType, queryType)
    databaseType = databaseType or "world"

    local success, result = pcall(function()
        local query = queryFunc()
        if not query then
            return nil
        end

        if DatabaseHelper then
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

local function executeSafeQueryAsync(queryFunc, callback, databaseType, queryType)
    databaseType = databaseType or "world"

    local success, error = pcall(function()
        local query = queryFunc()
        if not query then
            callback(nil, "Query function returned nil")
            return
        end

        if DatabaseHelper then
            local tables = queryTableMappings[queryType] or {}
            DatabaseHelper.BuildSafeQueryAsync(query, tables, callback, databaseType)
        else
            DatabaseHelper.SafeQueryAsync(query, callback, databaseType)
        end
    end)

    if not success then
        if DatabaseHelper and DatabaseHelper.debug then
            print(string.format("[GameMasterUI] Async query setup failed: %s", tostring(error)))
        end
        callback(nil, tostring(error))
    end
end

local function initialize()
    if DatabaseHelper and DatabaseHelper.Initialize then
    end
end

return {
    queries = queries,
    getQuery = getQuery,
    executeSafeQuery = executeSafeQuery,
    executeSafeQueryAsync = executeSafeQueryAsync,
    queryTableMappings = queryTableMappings,
    initialize = initialize,
}
