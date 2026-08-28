local spellQueries = {
	TrinityCore = {
		spellCount = function()
			return [[
                SELECT COUNT(*)
                FROM spell;
            ]]
		end,
		spellDataSimple = function(sortOrder, pageSize, offset)
			return string.format(
				[[
            SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                   s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                   s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                   '' as visualFilePath1,
                   '' as visualFilePath2
            FROM spell s
            ORDER BY s.id %s
            LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchSpellDataSimple = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                       s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                       s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                       '' as visualFilePath1,
                       '' as visualFilePath2
                FROM spell s
                WHERE s.spell_name_enus LIKE '%%%s%%' OR s.id LIKE '%%%s%%'
                ORDER BY s.id %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset
			)
		end,
		spellData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
            SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                   s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                   s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                   COALESCE(
                       cast1_base.FilePath, cast1_world.FilePath, cast1_special.FilePath,
                       impact1_base.FilePath, impact1_world.FilePath, impact1_special.FilePath,
                       state1_base.FilePath, state1_world.FilePath, state1_special.FilePath,
                       ''
                   ) as visualFilePath1,
                   COALESCE(
                       cast2_base.FilePath, cast2_world.FilePath, cast2_special.FilePath,
                       impact2_base.FilePath, impact2_world.FilePath, impact2_special.FilePath,
                       state2_base.FilePath, state2_world.FilePath, state2_special.FilePath,
                       ''
                   ) as visualFilePath2
            FROM spell s
            LEFT JOIN spellvisual sv1 ON s.spell_visual_1 = sv1.ID
            LEFT JOIN spellvisualkit cast1 ON sv1.CastKit = cast1.ID
            LEFT JOIN spellvisualeffectname cast1_base ON cast1.BaseEffect = cast1_base.ID
            LEFT JOIN spellvisualeffectname cast1_world ON cast1.WorldEffect = cast1_world.ID
            LEFT JOIN spellvisualeffectname cast1_special ON cast1.SpecialEffect1 = cast1_special.ID
            LEFT JOIN spellvisualkit impact1 ON sv1.ImpactKit = impact1.ID
            LEFT JOIN spellvisualeffectname impact1_base ON impact1.BaseEffect = impact1_base.ID
            LEFT JOIN spellvisualeffectname impact1_world ON impact1.WorldEffect = impact1_world.ID
            LEFT JOIN spellvisualeffectname impact1_special ON impact1.SpecialEffect1 = impact1_special.ID
            LEFT JOIN spellvisualkit state1 ON sv1.StateKit = state1.ID
            LEFT JOIN spellvisualeffectname state1_base ON state1.BaseEffect = state1_base.ID
            LEFT JOIN spellvisualeffectname state1_world ON state1.WorldEffect = state1_world.ID
            LEFT JOIN spellvisualeffectname state1_special ON state1.SpecialEffect1 = state1_special.ID
            LEFT JOIN spellvisual sv2 ON s.spell_visual_2 = sv2.ID
            LEFT JOIN spellvisualkit cast2 ON sv2.CastKit = cast2.ID
            LEFT JOIN spellvisualeffectname cast2_base ON cast2.BaseEffect = cast2_base.ID
            LEFT JOIN spellvisualeffectname cast2_world ON cast2.WorldEffect = cast2_world.ID
            LEFT JOIN spellvisualeffectname cast2_special ON cast2.SpecialEffect1 = cast2_special.ID
            LEFT JOIN spellvisualkit impact2 ON sv2.ImpactKit = impact2.ID
            LEFT JOIN spellvisualeffectname impact2_base ON impact2.BaseEffect = impact2_base.ID
            LEFT JOIN spellvisualeffectname impact2_world ON impact2.WorldEffect = impact2_world.ID
            LEFT JOIN spellvisualeffectname impact2_special ON impact2.SpecialEffect1 = impact2_special.ID
            LEFT JOIN spellvisualkit state2 ON sv2.StateKit = state2.ID
            LEFT JOIN spellvisualeffectname state2_base ON state2.BaseEffect = state2_base.ID
            LEFT JOIN spellvisualeffectname state2_world ON state2.WorldEffect = state2_world.ID
            LEFT JOIN spellvisualeffectname state2_special ON state2.SpecialEffect1 = state2_special.ID
            ORDER BY s.id %s
            LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchSpellData = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                       s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                       s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                       COALESCE(
                           cast1_base.FilePath, cast1_world.FilePath, cast1_special.FilePath,
                           impact1_base.FilePath, impact1_world.FilePath, impact1_special.FilePath,
                           state1_base.FilePath, state1_world.FilePath, state1_special.FilePath,
                           ''
                       ) as visualFilePath1,
                       COALESCE(
                           cast2_base.FilePath, cast2_world.FilePath, cast2_special.FilePath,
                           impact2_base.FilePath, impact2_world.FilePath, impact2_special.FilePath,
                           state2_base.FilePath, state2_world.FilePath, state2_special.FilePath,
                           ''
                       ) as visualFilePath2
                FROM spell s
                LEFT JOIN spellvisual sv1 ON s.spell_visual_1 = sv1.ID
                LEFT JOIN spellvisualkit cast1 ON sv1.CastKit = cast1.ID
                LEFT JOIN spellvisualeffectname cast1_base ON cast1.BaseEffect = cast1_base.ID
                LEFT JOIN spellvisualeffectname cast1_world ON cast1.WorldEffect = cast1_world.ID
                LEFT JOIN spellvisualeffectname cast1_special ON cast1.SpecialEffect1 = cast1_special.ID
                LEFT JOIN spellvisualkit impact1 ON sv1.ImpactKit = impact1.ID
                LEFT JOIN spellvisualeffectname impact1_base ON impact1.BaseEffect = impact1_base.ID
                LEFT JOIN spellvisualeffectname impact1_world ON impact1.WorldEffect = impact1_world.ID
                LEFT JOIN spellvisualeffectname impact1_special ON impact1.SpecialEffect1 = impact1_special.ID
                LEFT JOIN spellvisualkit state1 ON sv1.StateKit = state1.ID
                LEFT JOIN spellvisualeffectname state1_base ON state1.BaseEffect = state1_base.ID
                LEFT JOIN spellvisualeffectname state1_world ON state1.WorldEffect = state1_world.ID
                LEFT JOIN spellvisualeffectname state1_special ON state1.SpecialEffect1 = state1_special.ID
                LEFT JOIN spellvisual sv2 ON s.spell_visual_2 = sv2.ID
                LEFT JOIN spellvisualkit cast2 ON sv2.CastKit = cast2.ID
                LEFT JOIN spellvisualeffectname cast2_base ON cast2.BaseEffect = cast2_base.ID
                LEFT JOIN spellvisualeffectname cast2_world ON cast2.WorldEffect = cast2_world.ID
                LEFT JOIN spellvisualeffectname cast2_special ON cast2.SpecialEffect1 = cast2_special.ID
                LEFT JOIN spellvisualkit impact2 ON sv2.ImpactKit = impact2.ID
                LEFT JOIN spellvisualeffectname impact2_base ON impact2.BaseEffect = impact2_base.ID
                LEFT JOIN spellvisualeffectname impact2_world ON impact2.WorldEffect = impact2_world.ID
                LEFT JOIN spellvisualeffectname impact2_special ON impact2.SpecialEffect1 = impact2_special.ID
                LEFT JOIN spellvisualkit state2 ON sv2.StateKit = state2.ID
                LEFT JOIN spellvisualeffectname state2_base ON state2.BaseEffect = state2_base.ID
                LEFT JOIN spellvisualeffectname state2_world ON state2.WorldEffect = state2_world.ID
                LEFT JOIN spellvisualeffectname state2_special ON state2.SpecialEffect1 = state2_special.ID
                WHERE s.spell_name_enus LIKE '%%%s%%' OR s.id LIKE '%%%s%%'
                ORDER BY s.id %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset
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
				offset
			)
		end,
	},
	AzerothCore = {
		spellCount = function()
			return [[
                SELECT COUNT(*)
                FROM spell;
            ]]
		end,
		spellDataSimple = function(sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                       s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                       s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                       '' as visualFilePath1,
                       '' as visualFilePath2
                FROM spell s
                ORDER BY s.id %s
                LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchSpellDataSimple = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                       s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                       s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                       '' as visualFilePath1,
                       '' as visualFilePath2
                FROM spell s
                WHERE s.spell_name_enus LIKE '%%%s%%' OR s.id LIKE '%%%s%%'
                ORDER BY s.id %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset
			)
		end,
		spellData = function(sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                       s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                       s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                       COALESCE(
                           cast1_base.FilePath, cast1_world.FilePath, cast1_special.FilePath,
                           impact1_base.FilePath, impact1_world.FilePath, impact1_special.FilePath,
                           state1_base.FilePath, state1_world.FilePath, state1_special.FilePath,
                           ''
                       ) as visualFilePath1,
                       COALESCE(
                           cast2_base.FilePath, cast2_world.FilePath, cast2_special.FilePath,
                           impact2_base.FilePath, impact2_world.FilePath, impact2_special.FilePath,
                           state2_base.FilePath, state2_world.FilePath, state2_special.FilePath,
                           ''
                       ) as visualFilePath2
                FROM spell s
                LEFT JOIN spellvisual sv1 ON s.spell_visual_1 = sv1.ID
                LEFT JOIN spellvisualkit cast1 ON sv1.CastKit = cast1.ID
                LEFT JOIN spellvisualeffectname cast1_base ON cast1.BaseEffect = cast1_base.ID
                LEFT JOIN spellvisualeffectname cast1_world ON cast1.WorldEffect = cast1_world.ID
                LEFT JOIN spellvisualeffectname cast1_special ON cast1.SpecialEffect1 = cast1_special.ID
                LEFT JOIN spellvisualkit impact1 ON sv1.ImpactKit = impact1.ID
                LEFT JOIN spellvisualeffectname impact1_base ON impact1.BaseEffect = impact1_base.ID
                LEFT JOIN spellvisualeffectname impact1_world ON impact1.WorldEffect = impact1_world.ID
                LEFT JOIN spellvisualeffectname impact1_special ON impact1.SpecialEffect1 = impact1_special.ID
                LEFT JOIN spellvisualkit state1 ON sv1.StateKit = state1.ID
                LEFT JOIN spellvisualeffectname state1_base ON state1.BaseEffect = state1_base.ID
                LEFT JOIN spellvisualeffectname state1_world ON state1.WorldEffect = state1_world.ID
                LEFT JOIN spellvisualeffectname state1_special ON state1.SpecialEffect1 = state1_special.ID
                LEFT JOIN spellvisual sv2 ON s.spell_visual_2 = sv2.ID
                LEFT JOIN spellvisualkit cast2 ON sv2.CastKit = cast2.ID
                LEFT JOIN spellvisualeffectname cast2_base ON cast2.BaseEffect = cast2_base.ID
                LEFT JOIN spellvisualeffectname cast2_world ON cast2.WorldEffect = cast2_world.ID
                LEFT JOIN spellvisualeffectname cast2_special ON cast2.SpecialEffect1 = cast2_special.ID
                LEFT JOIN spellvisualkit impact2 ON sv2.ImpactKit = impact2.ID
                LEFT JOIN spellvisualeffectname impact2_base ON impact2.BaseEffect = impact2_base.ID
                LEFT JOIN spellvisualeffectname impact2_world ON impact2.WorldEffect = impact2_world.ID
                LEFT JOIN spellvisualeffectname impact2_special ON impact2.SpecialEffect1 = impact2_special.ID
                LEFT JOIN spellvisualkit state2 ON sv2.StateKit = state2.ID
                LEFT JOIN spellvisualeffectname state2_base ON state2.BaseEffect = state2_base.ID
                LEFT JOIN spellvisualeffectname state2_world ON state2.WorldEffect = state2_world.ID
                LEFT JOIN spellvisualeffectname state2_special ON state2.SpecialEffect1 = state2_special.ID
                ORDER BY s.id %s
                LIMIT %d OFFSET %d;
            ]],
				sortOrder,
				pageSize,
				offset
			)
		end,
		searchSpellData = function(query, sortOrder, pageSize, offset)
			return string.format(
				[[
                SELECT s.id, s.spell_name_enus, s.spell_desc_enus, s.spell_tooltip_enus, s.spell_visual_1, s.spell_visual_2,
                       s.effect_misc_value_a_1, s.effect_misc_value_a_2, s.effect_misc_value_a_3,
                       s.effect_1, s.effect_2, s.effect_3, s.school_mask,
                       COALESCE(
                           cast1_base.FilePath, cast1_world.FilePath, cast1_special.FilePath,
                           impact1_base.FilePath, impact1_world.FilePath, impact1_special.FilePath,
                           state1_base.FilePath, state1_world.FilePath, state1_special.FilePath,
                           ''
                       ) as visualFilePath1,
                       COALESCE(
                           cast2_base.FilePath, cast2_world.FilePath, cast2_special.FilePath,
                           impact2_base.FilePath, impact2_world.FilePath, impact2_special.FilePath,
                           state2_base.FilePath, state2_world.FilePath, state2_special.FilePath,
                           ''
                       ) as visualFilePath2
                FROM spell s
                LEFT JOIN spellvisual sv1 ON s.spell_visual_1 = sv1.ID
                LEFT JOIN spellvisualkit cast1 ON sv1.CastKit = cast1.ID
                LEFT JOIN spellvisualeffectname cast1_base ON cast1.BaseEffect = cast1_base.ID
                LEFT JOIN spellvisualeffectname cast1_world ON cast1.WorldEffect = cast1_world.ID
                LEFT JOIN spellvisualeffectname cast1_special ON cast1.SpecialEffect1 = cast1_special.ID
                LEFT JOIN spellvisualkit impact1 ON sv1.ImpactKit = impact1.ID
                LEFT JOIN spellvisualeffectname impact1_base ON impact1.BaseEffect = impact1_base.ID
                LEFT JOIN spellvisualeffectname impact1_world ON impact1.WorldEffect = impact1_world.ID
                LEFT JOIN spellvisualeffectname impact1_special ON impact1.SpecialEffect1 = impact1_special.ID
                LEFT JOIN spellvisualkit state1 ON sv1.StateKit = state1.ID
                LEFT JOIN spellvisualeffectname state1_base ON state1.BaseEffect = state1_base.ID
                LEFT JOIN spellvisualeffectname state1_world ON state1.WorldEffect = state1_world.ID
                LEFT JOIN spellvisualeffectname state1_special ON state1.SpecialEffect1 = state1_special.ID
                LEFT JOIN spellvisual sv2 ON s.spell_visual_2 = sv2.ID
                LEFT JOIN spellvisualkit cast2 ON sv2.CastKit = cast2.ID
                LEFT JOIN spellvisualeffectname cast2_base ON cast2.BaseEffect = cast2_base.ID
                LEFT JOIN spellvisualeffectname cast2_world ON cast2.WorldEffect = cast2_world.ID
                LEFT JOIN spellvisualeffectname cast2_special ON cast2.SpecialEffect1 = cast2_special.ID
                LEFT JOIN spellvisualkit impact2 ON sv2.ImpactKit = impact2.ID
                LEFT JOIN spellvisualeffectname impact2_base ON impact2.BaseEffect = impact2_base.ID
                LEFT JOIN spellvisualeffectname impact2_world ON impact2.WorldEffect = impact2_world.ID
                LEFT JOIN spellvisualeffectname impact2_special ON impact2.SpecialEffect1 = impact2_special.ID
                LEFT JOIN spellvisualkit state2 ON sv2.StateKit = state2.ID
                LEFT JOIN spellvisualeffectname state2_base ON state2.BaseEffect = state2_base.ID
                LEFT JOIN spellvisualeffectname state2_world ON state2.WorldEffect = state2_world.ID
                LEFT JOIN spellvisualeffectname state2_special ON state2.SpecialEffect1 = state2_special.ID
                WHERE s.spell_name_enus LIKE '%%%s%%' OR s.id LIKE '%%%s%%'
                ORDER BY s.id %s
                LIMIT %d OFFSET %d;
            ]],
				query,
				query,
				sortOrder,
				pageSize,
				offset
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
				offset
			)
		end,
	},
}

local spellTableMappings = {
	spellCount = {"spell"},
	spellData = {"spell", "spellvisual", "spellvisualkit", "spellvisualeffectname"},
	spellDataSimple = {"spell"},
	searchSpellData = {"spell", "spellvisual", "spellvisualkit", "spellvisualeffectname"},
	searchSpellDataSimple = {"spell"},
	spellVisualCount = {"spellvisualeffectname"},
	spellVisualData = {"spellvisualeffectname"},
	searchSpellVisualData = {"spellvisualeffectname"},
}

return {
	queries = spellQueries,
	tableMappings = spellTableMappings,
}
