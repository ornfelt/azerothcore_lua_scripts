local apprentice_level = 15
local expert_level = 30
local journeyman_level = 58
local artisan_level = 58
local coldweather_level = 68
local cost_multiplier = 1

local mounts = {}
local locales = {}
locales[1] = {
	["Fractions"] = {"Darnassus", "Gnomeregan", "Ironforge", "Stormwind", "Exodar", "Orgrimmar",
	 "Silvermoon City", "Darkspear Trolls", "Thunder Bluff", "Undercity", "Alliance Flying Mounts", "Horde Flying Mounts"},
	["Other"] = {"Need level ", "!", "Back..", "Are you sure you want to learn this?", "Are you sure you want to buy this mount?"}
}
locales[9] = {
	[33388] = "Верховая езда (ученик)",
	[33391] = "Верховая езда (подмастерье)",
	[34090] = "Верховая езда (умелец)",
	[34091] = "Верховая езда (искусник)",
	[54197] = "Полеты в непогоду",
	[8394] = "Полосатый ледопард",
	[10793] = "Полосатый ночной саблезуб",
	[66847] = "Полосатый рассветный саблезуб",
	[10789] = "Пятнистый ледопард",
	[23338] = "Стремительный грозовой саблезуб",
	[23221] = "Стремительный ледопард",
	[23219] = "Стремительный туманный саблезуб",
	[17453] = "Зеленый механодолгоног",
	[10873] = "Красный механодолгоног",
	[17454] = "Некрашеный механодолгоног",
	[10969] = "Синий механодолгоног",
	[23223] = "Стрем. белый механодолгоног",
	[23222] = "Стрем. желтый механодолгоног",
	[23225] = "Стрем. зеленый механодолгоног",
	[6898] = "Белый баран",
	[6899] = "Бурый баран",
	[6777] = "Серый баран",
	[23240] = "Стремительный белый баран",
	[23238] = "Стремительный бурый баран",
	[23239] = "Стремительный серый баран",
	[470] = "Вороной жеребец",
	[6648] = "Гнедая кобыла",
	[458] = "Гнедой конь",
	[472] = "Пегий конь",
	[23228] = "Стремительный белый рысак",
	[23229] = "Стремительный гнедой рысак",
	[23227] = "Стремительный игреневый конь",
	[34406] = "Бурый элекк",
	[35711] = "Лиловый элекк",
	[35710] = "Серый элекк",
	[35712] = "Большой зеленый элекк",
	[35714] = "Большой лиловый элек",
	[35713] = "Большой синий элекк",
	[64658] = "Черный волк",
	[6653] = "Лютый волк",
	[580] = "Лесной волк",
	[6654] = "Темно-бурый волк",
	[23250] = "Стремительный бурый волк",
	[23251] = "Стремительный лесной волк",
	[23252] = "Стремительный серый волк",
	[34795] = "Красный клылобег",
	[35018] = "Лиловый крылобег",
	[35020] = "Синий крылобег",
	[35022] = "Черный крылобег",
	[35025] = "Стремительный зеленый крылобег",
	[35027] = "Стремительный лиловый крылобег",
	[33660] = "Стремительный розовый крылобег",
	[10796] = "Бирюзовый ящер",
	[8395] = "Изумрудный ящер",
	[10799] = "Фиолетовый ящер",
	[23242] = "Стремительный оливковый ящер",
	[23243] = "Стремительный оранжевый ящер",
	[23241] = "Стремительный синий ящер",
	[64657] = "Белый кодо",
	[18990] = "Бурый кодо",
	[18989] = "Серый кодо",
	[23247] = "Огромный белый кодо",
	[23249] = "Огромный бурый кодо",
	[23248] = "Огромный серый кодо",
	[17464] = "Гнедой конь-скелет",
	[17462] = "Красный конь-скелет",
	[17463] = "Синий конь-скелет",
	[64977] = "Черный конь-скелет",
	[17465] = "Зеленый боевой конь-скелет",
	[66846] = "Коричневый боевой конь-скелет",
	[23246] = "Лиловый боевой конь-скелет",
	[32240] = "Белоснежный грифон",
	[32239] = "Вороной грифон",
	[32235] = "Золотистый грифон",
	[32290] = "Стремительный зеленый грифон",
	[32289] = "Стремительный красный грифон",
	[32292] = "Стремительный лиловый грифон",
	[32242] = "Стремительный синий грифон",
	[32245] = "Зеленый ветрокрыл",
	[32243] = "Рыжий ветрокрыл",
	[32244] = "Синий ветрокрыл",
	[32296] = "Стрем. желтый ветрокрыл",
	[32295] = "Стрем. зеленый ветрокрыл",
	[32246] = "Стрем. красный ветрокрыл",
	[32297] = "Стрем. лиловый ветрокрыл",
	["Fractions"] = {"Дарнас", "Гномреган", "Стальгорн", "Шмормград", "Экзодар", "Оргриммар",
	 "Луносвет", "Племя Черного Копья", "Громовой Утес", "Подгород", "Летающие маунты Альянса", "Летающие маунты Орды"},
	["Other"] = {"Нужен ", " уровень!", "Назад..", "Вы уверены, что хотите этому научиться?", "Вы уверены, что хотите купить этого маунта?"}
}

local riding = {
	{
		spellid = 33388,
		name = "Apprentice Riding (75)",
		icon = "spell_nature_swiftness",
		level = apprentice_level,
		cost = 1000 * cost_multiplier
	},
	{
		spellid = 33391,
		name = "Expert Riding (150)",
		icon = "spell_nature_swiftness",
		level = expert_level,
		requires = 33388,
		cost = 100000 * cost_multiplier
	},
	{
		spellid = 34090,
		name = "Journeyman Riding (225)",
		icon = "spell_nature_swiftness",
		level = journeyman_level,
		requires = 33391,
		cost = 500000 * cost_multiplier
	},
	{
		spellid = 34091,
		name = "Artisan Ridin (300)",
		icon = "spell_nature_swiftness",
		level = artisan_level,
		requires = 34090,
		cost = 2000000 * cost_multiplier
	},
	{
		spellid = 54197,
		name = "Cold Weather Flying",
		icon = "spell_frost_arcticwinds",
		level = coldweather_level,
		requires = 34090,
		cost = 500000 * cost_multiplier
	}
}

mounts[1] = {
	name = "Darnassus", 
	icon = "inv_misc_tournaments_symbol_nightelf",
	requires = 33388,
	items = {
		{
			name = "Striped Frostsaber", -- Полосатый ледопард
			icon = "ability_mount_whitetiger",
			spellid = 8394,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Striped Nightsaber", -- Полосатый ночной саблезуб
			icon = "ability_mount_blackpanther",
			spellid = 10793,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Striped Dawnsaber", -- Полосатый рассветный саблезуб
			icon = "ability_mount_whitetiger",
			spellid = 66847,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Spotted Frostsaber", -- Пятнистый ледопард
			icon = "ability_mount_whitetiger",
			spellid = 10789,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift Stormsaber", -- Стремительный грозовой саблезуб
			icon = "ability_mount_blackpanther",
			spellid = 23338,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Frostsaber", -- Стремительный ледопард 
			icon = "ability_mount_whitetiger",
			spellid = 23221,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Mistsaber", -- Стремительный туманный саблезуб
			icon = "ability_mount_blackpanther",
			spellid = 23219,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}


mounts[2] = {
	name = "Gnomeregan",  -- 
	icon = "inv_misc_tournaments_symbol_gnome",
	requires = 33388,
	items = {
		{
			name = "Green Mechanostrider", -- Зеленый механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 17453,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Red Mechanostrider", -- Красный механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 10873,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Unpainted Mechanostrider", -- Некрашеный механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 17454,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Blue Mechanostrider", -- Синий механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 10969,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift White Mechanostrider", -- Стремительный белый механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 23223,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Yellow Mechanostrider", -- Стремительный желтый механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 23222,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Green Mechanostrider", -- Стремительный зеленый механодолгоног
			icon = "ability_mount_mechastrider",
			spellid = 23225,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[3] = {
	name = "Ironforge", 
	icon = "inv_misc_tournaments_symbol_dwarf",
	requires = 33388,
	items = {
		{
			name = "White Ram", -- Белый баран
			icon = "ability_mount_mountainram",
			spellid = 6898,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Brown Ram", -- Бурый баран
			icon = "ability_mount_mountainram",
			spellid = 6899,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Gray Ram", -- Серый баран
			icon = "ability_mount_mountainram",
			spellid = 6777,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift White Ram", -- Стремительный белый баран
			icon = "ability_mount_mountainram",
			spellid = 23240,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000
		},
		{
			name = "Swift Brown Ram", -- Стремительный бурый баран
			icon = "ability_mount_mountainram",
			spellid = 23238,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Gray Ram", -- Стремительный серый баран
			icon = "ability_mount_mountainram",
			spellid = 23239,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[4] = {
	name = "Stormwind", 
	icon = "inv_misc_tournaments_symbol_human",
	requires = 33388,
	items = {
		{
			name = "Black Stallion", -- Вороной жеребец
			icon = "ability_mount_ridinghorse",
			spellid = 470,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Chestnut Mare", -- Гнедая кобыла
			icon = "ability_mount_ridinghorse",
			spellid = 6648,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Brown Horse", -- Гнедой конь
			icon = "ability_mount_ridinghorse",
			spellid = 458,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Pinto", -- Пегий конь
			icon = "ability_mount_ridinghorse",
			spellid = 472,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift White Steed", -- Стремительный белый рысак
			icon = "ability_mount_ridinghorse",
			spellid = 23228,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Brown Steed", -- Стремительный гнедой рысак
			icon = "ability_mount_ridinghorse",
			spellid = 23229,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Palomino", -- Стремительный игреневый конь
			icon = "ability_mount_ridinghorse",
			spellid = 23227,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[5] = {
	name = "Exodar", 
	icon = "inv_misc_tournaments_symbol_draenei",
	requires = 33388,
	items = {
		{
			name = "Brauner Elekk", -- Бурый элекк
			icon = "ability_mount_ridingelekk",
			spellid = 34406,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Lila Elekk", -- Лиловый элекк
			icon = "ability_mount_ridingelekk_purple",
			spellid = 35711,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Gray Elekk", -- Серый элекк
			icon = "ability_mount_ridingelekk_grey",
			spellid = 35710,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Great Green Elekk", -- Большой зеленый элекк 
			icon = "ability_mount_ridingelekkelite_green",
			spellid = 35712,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Great Purple Elekk", -- Большой лиловый элек
			icon = "ability_mount_ridingelekkelite_purple",
			spellid = 35714,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Great Blue Elekk", -- Большой синий элекк
			icon = "ability_mount_ridingelekkelite_blue",
			spellid = 35713,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[6] = {
	name = "Orgrimmar", 
	icon = "inv_misc_tournaments_symbol_orc",
	requires = 33388,
	items = {
		{
			name = "Black Wolf",-- Черный волк
			icon = "ability_mount_blackdirewolf",
			spellid = 64658,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Dire Wolf",
			icon = "ability_mount_whitedirewolf", -- Лютый волк
			spellid = 6653,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Timber Wolf", -- Лесной волк
			icon = "ability_mount_blackdirewolf",
			spellid = 580,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Brown Wolf", -- Темно-бурый волк
			icon = "ability_mount_blackdirewolf",
			spellid = 6654,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift Brown Wolf", -- Стремительный бурый волк
			icon = "ability_mount_blackdirewolf",
			spellid = 23250,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Timber Wolf", -- Стремительный лесной волк
			icon = "ability_mount_whitedirewolf",
			spellid = 23251,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Gray Wolf", -- Стремительный серый волк
			icon = "ability_mount_whitedirewolf",
			spellid = 23252,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[7] = {
	name = "Silvermoon City", 
	icon = "inv_misc_tournaments_symbol_bloodelf",
	requires = 33388,
	items = {
		{
			name = "Red Hawkstrider", -- Красный клылобег
			icon = "ability_mount_cockatricemount",
			spellid = 34795,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Purple Hawkstrider", -- Лиловый крылобег
			icon = "ability_mount_cockatricemount_purple",
			spellid = 35018,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Blue Hawkstrider", -- Синий крылобег
			icon = "ability_mount_cockatricemount_blue",
			spellid = 35020,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Black Hawkstrider", -- Черный крылобег
			icon = "ability_mount_cockatricemount_black",
			spellid = 35022,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift Green Hawkstrider", -- Стремительный зеленый крылобег
			icon = "ability_mount_cockatricemountelite_green",
			spellid = 35025,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Purple Hawkstrider", -- Стремительный лиловый крылобег
			icon = "ability_mount_cockatricemountelite_purple",
			spellid = 35027,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Pink Hawkstrider", -- Стремительный розовый крылобег
			icon = "ability_mount_cockatricemountelite",
			spellid = 33660,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[8] = {
	name = "Darkspear Trolls", 
	icon = "inv_misc_tournaments_symbol_troll",
	requires = 33388,
	items = {
		{
			name = "Turquoise Raptor", -- Бирюзовый ящер
			icon = "ability_mount_raptor",
			spellid = 10796,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Emerald Raptor", -- Изумрудный ящер
			icon = "ability_mount_raptor",
			spellid = 8395,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Violet Raptor", -- Фиолетовый ящер
			icon = "ability_mount_raptor",
			spellid = 10799,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Swift Olive Raptor", -- Стремительный оливковый ящер
			icon = "ability_mount_raptor",
			spellid = 23242,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Orange Raptor", -- Стремительный оранжевый ящер
			icon = "ability_mount_raptor",
			spellid = 23243,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Swift Blue Raptor", -- Стремительный синий ящер
			icon = "ability_mount_raptor",
			spellid = 23241,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[9] = {
	name = "Thunder Bluff", 
	icon = "inv_misc_tournaments_symbol_tauren",
	requires = 33388,
	items = {
		{
			name = "White Kodo", -- Белый кодо
			icon = "ability_mount_kodo_01",
			spellid = 64657,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Brown Kodo", -- Бурый кодо
			icon = "ability_mount_kodo_03",
			spellid = 18990,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Gray Kodo", -- Серый кодо
			icon = "ability_mount_kodo_01",
			spellid = 18989,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Great White Kodo", -- Огромный белый кодо
			icon = "ability_mount_kodo_01",
			spellid = 23247,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Great Brown Kodo", -- Огромный бурый кодо
			icon = "ability_mount_kodo_03",
			spellid = 23249,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Great Gray Kodo", -- Огромный серый кодо
			icon = "ability_mount_kodo_01",
			spellid = 23248,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[10] = {
	name = "Undercity", 
	icon = "inv_misc_tournaments_symbol_scourge",
	requires = 33388,
	items = {
		{
			name = "Brown Skeletal Horse", -- Гнедой конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 17464,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Red Skeletal Horse", -- Красный конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 17462,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Blue Skeletal Horse", -- Синий конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 17463,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Black Skeletal Horse", -- Черный конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 64977,
			requires = 33388,
			rarity = "ff0070dd",
			cost = 1000 * cost_multiplier
		},
		{
			name = "Green Skeletal Warhorse", -- Зеленый боевой конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 17465,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Ochre Skeletal Warhorse", -- Коричневый боевой конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 66846,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		},
		{
			name = "Purple Skeletal Warhorse", -- Лиловый боевой конь-скелет
			icon = "ability_mount_undeadhorse",
			spellid = 23246,
			requires = 33391,
			rarity = "ffa335ee",
			cost = 10000 * cost_multiplier
		}
	}
}

mounts[11] = {
	name = "Alliance Flying Mounts", 
	icon = "achievement_pvp_a_16",
	requires = 34090,
	items = {
		{
			name = "Snowy Gryphon", -- Белоснежный грифон
			icon = "ability_mount_snowygryphon",
			spellid = 32240,
			requires = 34090,
			rarity = "ff0070dd",
			cost = 50000 * cost_multiplier
		},
		{
			name = "Ebon Gryphon", -- Вороной грифон
			icon = "ability_mount_ebongryphon",
			spellid = 32239,
			requires = 34090,
			rarity = "ff0070dd",
			cost = 50000 * cost_multiplier
		},
		{
			name = "Golden Gryphon", -- Золотистый грифон
			icon = "ability_mount_goldengryphon",
			spellid = 32235,
			requires = 34090,
			rarity = "ff0070dd",
			cost = 50000 * cost_multiplier
		},
		{
			name = "Swift Green Gryphon", -- Стремительный зеленый грифон
			icon = "ability_mount_gryphon_01",
			spellid = 32290,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		},
		{
			name = "Swift Red Gryphon", -- Стремительный красный грифон
			icon = "ability_mount_gryphon_01",
			spellid = 32289,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		},
		{
			name = "Swift Purple Gryphon", -- Стремительный лиловый грифон
			icon = "ability_mount_gryphon_01",
			spellid = 32292,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		},
		{
			name = "Swift Blue Gryphon", -- Стремительный синий грифон
			icon = "ability_mount_gryphon_01",
			spellid = 32242,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		}
	}
}

mounts[12] = {
	name = "Horde Flying Mounts", 
	icon = "achievement_pvp_h_16",
	requires = 34090,
	items = {
		{
			name = "Green Wind Rider", -- Зеленый ветрокрыл
			icon = "ability_mount_greenwindrider",
			spellid = 32245,
			requires = 34090,
			rarity = "ff0070dd",
			cost = 50000 * cost_multiplier
		},
		{
			name = "Tawny Wind Rider", -- Рыжий ветрокрыл
			icon = "ability_mount_tawnywindrider",
			spellid = 32243,
			requires = 34090,
			rarity = "ff0070dd",
			cost = 50000 * cost_multiplier
		},
		{
			name = "Blue Wind Rider", -- Синий ветрокрыл
			icon = "ability_mount_bluewindrider",
			spellid = 32244,
			requires = 34090,
			rarity = "ff0070dd",
			cost = 50000 * cost_multiplier
		},
		{
			name = "Swift Yellow Wind Rider", -- Стремительный желтый ветрокрыл
			icon = "ability_mount_swiftyellowwindrider",
			spellid = 32296,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		},
		{
			name = "Swift Green Wind Rider", -- Стремительный зеленый ветрокрыл
			icon = "ability_mount_swiftgreenwindrider",
			spellid = 32295,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		},
		{
			name = "Swift Red Wind Rider", -- Стремительный красный ветрокрыл
			icon = "ability_mount_swiftredwindrider",
			spellid = 32246,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		},
		{
			name = "Swift Purple Wind Rider", -- Стремительный лиловый ветрокрыл
			icon = "ability_mount_swiftpurplewindrider",
			spellid = 32297,
			requires = 34091,
			rarity = "ffa335ee",
			cost = 300000 * cost_multiplier
		}
	}
}

-- Example mounts tabs
--
-- mounts[13] = {
	-- name = "Other Ground Mounts", 
	-- icon = "ability_mount_polarbear_white",
	-- requires = 33388,
	-- items = {
		-- {
			-- name = "Green Wind Rider",
			-- icon = "ability_mount_polarbear_white",
			-- spellid = 32245,
			-- requires = 34090,
			-- rarity = "ffa335ee",
			-- cost = 50000 * cost_multiplier
		-- },
	-- }
-- }

-- mounts[14] = {
	-- name = "Other Flying Mounts", 
	-- icon = "ability_mount_drake_twilight",
	-- requires = 34090,
	-- items = {
		-- {
			-- name = "Black Drake",
			-- icon = "ability_mount_drake_twilight",
			-- spellid = 59650,
			-- requires = 34090,
			-- rarity = "ffa335ee",
			-- cost = 50000 * cost_multiplier
		-- },
	-- }
-- }

-----------------------------------

local vendor_items = {}

function vendor_items.getItems()
	return mounts
end

function vendor_items.getRidingSkills()
	return riding
end

function vendor_items.getLocales()
	return locales
end

return vendor_items