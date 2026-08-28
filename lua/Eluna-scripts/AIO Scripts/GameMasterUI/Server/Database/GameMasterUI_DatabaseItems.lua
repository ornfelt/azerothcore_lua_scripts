local itemQueries = {
	TrinityCore = {
		loadItemForPacket = function(itemEntry)
			return string.format(
				[[SELECT entry, class, subclass, name, displayid, Quality, Flags, FlagsExtra,
				BuyPrice, SellPrice, InventoryType, AllowableClass, AllowableRace,
				ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank,
				requiredspell, requiredhonorrank, RequiredCityRank,
				RequiredReputationFaction, RequiredReputationRank,
				maxcount, stackable, ContainerSlots,
				stat_type1, stat_value1, stat_type2, stat_value2,
				stat_type3, stat_value3, stat_type4, stat_value4,
				stat_type5, stat_value5, stat_type6, stat_value6,
				stat_type7, stat_value7, stat_type8, stat_value8,
				stat_type9, stat_value9, stat_type10, stat_value10,
				ScalingStatDistribution, ScalingStatValue,
				dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2,
				armor, holy_res, fire_res, nature_res, frost_res, shadow_res, arcane_res,
				delay, ammo_type, RangedModRange,
				spellid_1, spelltrigger_1, spellcharges_1, spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1,
				spellid_2, spelltrigger_2, spellcharges_2, spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2,
				spellid_3, spelltrigger_3, spellcharges_3, spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3,
				spellid_4, spelltrigger_4, spellcharges_4, spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4,
				spellid_5, spelltrigger_5, spellcharges_5, spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5,
				bonding, COALESCE(description, '') as description, PageText, LanguageID, PageMaterial,
				startquest, lockid, Material, sheath, RandomProperty, RandomSuffix,
				block, itemset, MaxDurability, area, Map, BagFamily, TotemCategory,
				socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3,
				socketBonus, GemProperties, RequiredDisenchantSkill, ArmorDamageModifier,
				duration, ItemLimitCategory, HolidayId
				FROM item_template WHERE entry = %d;]],
				itemEntry
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
				string.format(whereClause, query, query),
				sortOrder,
				pageSize,
				offset
			)
		end,
	},
	AzerothCore = {
		loadItemForPacket = function(itemEntry)
			return string.format(
				[[SELECT entry, class, subclass, name, displayid, Quality, Flags, FlagsExtra,
				BuyPrice, SellPrice, InventoryType, AllowableClass, AllowableRace,
				ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank,
				requiredspell, requiredhonorrank, RequiredCityRank,
				RequiredReputationFaction, RequiredReputationRank,
				maxcount, stackable, ContainerSlots,
				stat_type1, stat_value1, stat_type2, stat_value2,
				stat_type3, stat_value3, stat_type4, stat_value4,
				stat_type5, stat_value5, stat_type6, stat_value6,
				stat_type7, stat_value7, stat_type8, stat_value8,
				stat_type9, stat_value9, stat_type10, stat_value10,
				ScalingStatDistribution, ScalingStatValue,
				dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2,
				armor, holy_res, fire_res, nature_res, frost_res, shadow_res, arcane_res,
				delay, ammo_type, RangedModRange,
				spellid_1, spelltrigger_1, spellcharges_1, spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1,
				spellid_2, spelltrigger_2, spellcharges_2, spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2,
				spellid_3, spelltrigger_3, spellcharges_3, spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3,
				spellid_4, spelltrigger_4, spellcharges_4, spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4,
				spellid_5, spelltrigger_5, spellcharges_5, spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5,
				bonding, COALESCE(description, '') as description, PageText, LanguageID, PageMaterial,
				startquest, lockid, Material, sheath, RandomProperty, RandomSuffix,
				block, itemset, MaxDurability, area, Map, BagFamily, TotemCategory,
				socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3,
				socketBonus, GemProperties, RequiredDisenchantSkill, ArmorDamageModifier,
				duration, ItemLimitCategory, HolidayId
				FROM item_template WHERE entry = %d;]],
				itemEntry
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
                SELECT entry, name, COALESCE(description, ''), displayid, Quality, InventoryType, ItemLevel, class, subclass
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
                SELECT entry, name, COALESCE(description, ''), displayid, Quality, InventoryType, ItemLevel, class, subclass
                FROM item_template
                %s
                ORDER BY entry %s
                LIMIT %d OFFSET %d;
            ]],
				string.format(whereClause, query, query),
				sortOrder,
				pageSize,
				offset
			)
		end,
	},
}

local itemTableMappings = {
	loadItemForPacket = {"item_template"},
	itemCount = {"item_template"},
	itemData = {"item_template"},
	searchItemData = {"item_template"},
}

return {
	queries = itemQueries,
	tableMappings = itemTableMappings,
}
