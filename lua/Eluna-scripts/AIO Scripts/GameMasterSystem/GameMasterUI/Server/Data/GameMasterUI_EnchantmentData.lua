-- GameMasterUI Enchantment Data for WoW 3.3.5
-- This file contains all enchantment IDs and their categorization

local EnchantmentData = {}

-- ============================================================================
-- Complete WoW 3.3.5 Enchantment Database
-- ============================================================================

-- Weapon Enchants (Main Hand, Off Hand, Two-Handed)
EnchantmentData.WEAPON_ENCHANTS = {
    -- WotLK Top Tier
    { id = 3788, name = "Accuracy", description = "+25 Hit and +25 Critical Strike" },
    { id = 3789, name = "Berserking", description = "Chance to increase attack power by 400" },
    { id = 3790, name = "Black Magic", description = "Chance to increase haste by 250" },
    { id = 3869, name = "Blade Ward", description = "Chance to increase parry by 200 and inflict damage" },
    { id = 3870, name = "Blood Draining", description = "Chance to heal you for 400 to 600" },
    { id = 3368, name = "Rune of the Fallen Crusader", description = "Chance to heal and increase Strength (DK)" },
    { id = 3366, name = "Rune of Lichbane", description = "+2% weapon damage vs Undead (DK)" },
    { id = 3365, name = "Rune of Swordshattering", description = "Parry chance and reduce disarm (DK)" },
    { id = 3594, name = "Rune of Swordbreaking", description = "Parry chance and reduce disarm 2H (DK)" },
    { id = 3367, name = "Rune of Spellshattering", description = "Deflect magic and reduce silence (DK)" },
    { id = 3595, name = "Rune of Spellbreaking", description = "Deflect magic and reduce silence 2H (DK)" },
    { id = 3370, name = "Rune of Razorice", description = "+2% weapon damage as Frost" },
    { id = 3369, name = "Rune of Cinderglacier", description = "Chance for two additional Fire/Shadow attacks" },
    { id = 3847, name = "Rune of the Stoneskin Gargoyle", description = "+25 Defense and +2% Stamina" },
    { id = 3883, name = "Rune of the Nerubian Carapace", description = "+1% avoidance and +2% Stamina" },
    
    -- High-End Spell Power
    { id = 3834, name = "Mighty Spellpower", description = "+63 Spell Power" },
    { id = 3846, name = "Major Spellpower", description = "+50 Spell Power" },
    { id = 3854, name = "Greater Spellpower", description = "+50 Spell Power (Staff)" },
    { id = 3855, name = "Exceptional Spellpower", description = "+50 Spell Power" },
    { id = 3833, name = "Superior Potency", description = "+32 Spell Power" },
    { id = 3844, name = "Exceptional Spirit", description = "+45 Spirit" },
    
    -- Melee DPS
    { id = 3827, name = "Massacre", description = "+110 Attack Power" },
    { id = 3828, name = "Greater Savagery", description = "+85 Attack Power (2H)" },
    { id = 3225, name = "Executioner", description = "Chance for 120 Armor Penetration" },
    { id = 2673, name = "Mongoose", description = "Chance for +120 Agility and attack speed" },
    { id = 3241, name = "Lifeward", description = "Chance to heal for 300" },
    { id = 3239, name = "Icebreaker", description = "Chance for Fire damage" },
    { id = 3273, name = "Deathfrost", description = "Chance for Shadow Frost damage" },
    { id = 3251, name = "Giant Slayer", description = "Chance for extra damage to giants" },
    
    -- Tanking
    { id = 3851, name = "Titanium Weapon Chain", description = "Reduces disarm duration and +28 hit" },
    { id = 3731, name = "Titanium Plating", description = "+40 Block Value (Shield)" },
    { id = 1952, name = "Major Intellect", description = "+30 Intellect (Shield)" },
    { id = 3849, name = "Titanium Plating", description = "+36 Block Value (Shield)" },
    { id = 3748, name = "Resilience", description = "+12 Defense (Shield)" },
    
    -- Classic/TBC Enchants
    { id = 2674, name = "Spellsurge", description = "Chance to restore mana to party" },
    { id = 2675, name = "Battlemaster", description = "Chance for extra attack" },
    { id = 2672, name = "Soulfrost", description = "+54 Shadow and Frost Spell Power" },
    { id = 2671, name = "Sunfire", description = "+50 Arcane and Fire Spell Power" },
    { id = 2667, name = "Major Agility", description = "+35 Agility (2H)" },
    { id = 2670, name = "Major Agility", description = "+35 Agility" },
    { id = 2668, name = "Major Intellect", description = "+30 Intellect" },
    { id = 2669, name = "Major Spellpower", description = "+40 Spell Power" },
    { id = 2666, name = "Major Healing", description = "+81 Healing Power" },
    { id = 1900, name = "Crusader", description = "Chance to heal and increase Strength" },
    { id = 1894, name = "Icy Chill", description = "Chance to cast Frost damage" },
    { id = 1899, name = "Unholy Weapon", description = "Chance to cause disease" },
    { id = 1898, name = "Lifestealing", description = "Chance to steal life" },
    { id = 1897, name = "Fiery Weapon", description = "Chance for Fire damage" },
    { id = 1606, name = "Greater Striking", description = "+4 Weapon Damage" },
    { id = 249, name = "Minor Beastslayer", description = "+2 damage to Beasts" },
    { id = 250, name = "Minor Striking", description = "+1 Weapon Damage" },
}

-- Chest Enchants (Chest, Robe, Vest)
EnchantmentData.CHEST_ENCHANTS = {
    -- WotLK
    { id = 3832, name = "Powerful Stats", description = "+10 All Stats" },
    { id = 3297, name = "Super Health", description = "+275 Health" },
    { id = 3245, name = "Exceptional Resilience", description = "+20 Resilience" },
    { id = 3252, name = "Super Stats", description = "+8 All Stats" },
    { id = 3253, name = "Mighty Health", description = "+200 Health" },
    { id = 1953, name = "Greater Defense", description = "+22 Defense" },
    { id = 3236, name = "Mighty Health", description = "+150 Health" },
    { id = 3233, name = "Exceptional Mana", description = "+250 Mana" },
    
    -- TBC/Classic
    { id = 2661, name = "Exceptional Stats", description = "+6 All Stats" },
    { id = 2659, name = "Exceptional Health", description = "+150 Health" },
    { id = 1950, name = "Major Health", description = "+100 Health" },
    { id = 1951, name = "Major Mana", description = "+100 Mana" },
    { id = 866, name = "Superior Stats", description = "+4 All Stats" },
    { id = 1891, name = "Stats", description = "+3 All Stats" },
    { id = 1892, name = "Greater Stats", description = "+4 All Stats" },
}

-- Boot Enchants
EnchantmentData.BOOT_ENCHANTS = {
    -- WotLK
    { id = 3232, name = "Tuskarr's Vitality", description = "+15 Stamina and Minor Speed" },
    { id = 3826, name = "Icewalker", description = "+12 Hit and +12 Critical Strike" },
    { id = 3244, name = "Greater Vitality", description = "+7 MP5 and +7 HP5" },
    { id = 3824, name = "Greater Assault", description = "+32 Attack Power" },
    { id = 1597, name = "Greater Fortitude", description = "+22 Stamina" },
    { id = 983, name = "Superior Agility", description = "+16 Agility" },
    { id = 3606, name = "Nitro Boosts", description = "Engineering: Rocket boost" },
    
    -- TBC/Classic
    { id = 2940, name = "Boar's Speed", description = "+9 Stamina and Minor Speed" },
    { id = 2939, name = "Cat's Swiftness", description = "+6 Agility and Minor Speed" },
    { id = 2656, name = "Vitality", description = "+4 MP5 and +4 HP5" },
    { id = 2657, name = "Dexterity", description = "+12 Agility" },
    { id = 2658, name = "Surefooted", description = "+10 Hit and 5% Snare/Root resist" },
    { id = 2649, name = "Fortitude", description = "+12 Stamina" },
    { id = 929, name = "Greater Stamina", description = "+7 Stamina" },
    { id = 904, name = "Greater Agility", description = "+7 Agility" },
    { id = 849, name = "Minor Speed", description = "Minor Speed Increase" },
}

-- Glove Enchants
EnchantmentData.GLOVE_ENCHANTS = {
    -- WotLK
    { id = 3222, name = "Greater Agility", description = "+20 Agility" },
    { id = 3231, name = "Expertise", description = "+15 Expertise" },
    { id = 3238, name = "Gatherer", description = "+5 Herbalism, Mining, Skinning" },
    { id = 3246, name = "Exceptional Armor", description = "+240 Armor" },
    { id = 3253, name = "Armsman", description = "+2% Threat and +10 Parry" },
    { id = 3234, name = "Precision", description = "+20 Hit" },
    { id = 3829, name = "Greater Assault", description = "+44 Attack Power" },
    { id = 3831, name = "Haste", description = "+20 Haste" },
    { id = 3604, name = "Hyperspeed Accelerators", description = "Engineering: +340 Haste for 12 sec" },
    { id = 3603, name = "Hand-Mounted Pyro Rocket", description = "Engineering: Fire damage" },
    { id = 3860, name = "Reticulated Armor Webbing", description = "Engineering: +885 Armor" },
    
    -- TBC/Classic
    { id = 2937, name = "Major Spellpower", description = "+20 Spell Power" },
    { id = 2935, name = "Major Healing", description = "+35 Healing" },
    { id = 2934, name = "Blasting", description = "+10 Critical Strike" },
    { id = 2613, name = "Threat", description = "+2% Threat" },
    { id = 2614, name = "Precise Strikes", description = "+15 Hit" },
    { id = 2615, name = "Major Agility", description = "+15 Agility" },
    { id = 2616, name = "Assault", description = "+26 Attack Power" },
    { id = 2617, name = "Superior Agility", description = "+15 Agility" },
    { id = 2564, name = "Major Strength", description = "+15 Strength" },
    { id = 2322, name = "Healing Power", description = "+30 Healing" },
    { id = 1603, name = "Crushing", description = "+15 Attack Power" },
    { id = 931, name = "Minor Haste", description = "+1% Attack Speed" },
    { id = 930, name = "Riding Skill", description = "+2% Mount Speed" },
}

-- Cloak Enchants
EnchantmentData.CLOAK_ENCHANTS = {
    -- WotLK
    { id = 3831, name = "Greater Speed", description = "+23 Haste" },
    { id = 3243, name = "Spell Piercing", description = "+35 Spell Penetration" },
    { id = 3256, name = "Shadow Armor", description = "+155 Armor" },
    { id = 3296, name = "Superior Dodge", description = "+18 Dodge" },
    { id = 3294, name = "Superior Defense", description = "+16 Defense" },
    { id = 3825, name = "Speed", description = "+15 Haste" },
    { id = 3728, name = "Flexweave Underlay", description = "Engineering: Parachute" },
    { id = 3859, name = "Springy Arachnoweave", description = "Engineering: Parachute + Spell Power" },
    { id = 1099, name = "Major Agility", description = "+22 Agility" },
    { id = 1262, name = "Superior Arcane Resistance", description = "+20 Arcane Resistance" },
    { id = 1354, name = "Superior Fire Resistance", description = "+20 Fire Resistance" },
    { id = 1400, name = "Superior Frost Resistance", description = "+20 Frost Resistance" },
    { id = 1446, name = "Superior Shadow Resistance", description = "+20 Shadow Resistance" },
    { id = 1441, name = "Superior Nature Resistance", description = "+20 Nature Resistance" },
    { id = 3230, name = "Titanweave", description = "+16 Defense" },
    
    -- TBC/Classic
    { id = 2938, name = "Greater Dodge", description = "+12 Dodge" },
    { id = 2662, name = "Major Armor", description = "+120 Armor" },
    { id = 2664, name = "Major Resistance", description = "+7 All Resistances" },
    { id = 2650, name = "Spell Penetration", description = "+20 Spell Penetration" },
    { id = 2648, name = "Steelweave", description = "+12 Defense" },
    { id = 2622, name = "Dodge", description = "+12 Dodge" },
    { id = 2621, name = "Greater Agility", description = "+12 Agility" },
    { id = 2619, name = "Greater Resistance", description = "+5 All Resistances" },
    { id = 1888, name = "Resistance", description = "+3 All Resistances" },
    { id = 1889, name = "Greater Resistance", description = "+5 All Resistances" },
    { id = 849, name = "Superior Defense", description = "+70 Armor" },
}

-- Bracer Enchants
EnchantmentData.BRACER_ENCHANTS = {
    -- WotLK
    { id = 3850, name = "Major Stamina", description = "+40 Stamina" },
    { id = 2332, name = "Superior Spellpower", description = "+30 Spell Power" },
    { id = 3845, name = "Greater Assault", description = "+50 Attack Power" },
    { id = 3231, name = "Expertise", description = "+15 Expertise" },
    { id = 2326, name = "Major Spirit", description = "+18 Spirit" },
    { id = 1147, name = "Greater Spirit", description = "+18 Spirit" },
    { id = 2650, name = "Spellpower", description = "+15 Spell Power" },
    { id = 2649, name = "Fortitude", description = "+12 Stamina" },
    { id = 2648, name = "Major Healing", description = "+30 Healing" },
    { id = 2647, name = "Brawn", description = "+12 Strength" },
    { id = 2646, name = "Stats", description = "+4 All Stats" },
    { id = 3002, name = "Greater Spellpower", description = "+23 Spell Power" },
    
    -- Fur Lining (Leatherworking)
    { id = 3757, name = "Fur Lining - Attack Power", description = "LW: +130 Attack Power" },
    { id = 3758, name = "Fur Lining - Stamina", description = "LW: +102 Stamina" },
    { id = 3759, name = "Fur Lining - Spell Power", description = "LW: +76 Spell Power" },
    { id = 3760, name = "Fur Lining - Fire Resist", description = "LW: +70 Fire Resistance" },
    { id = 3761, name = "Fur Lining - Frost Resist", description = "LW: +70 Frost Resistance" },
    { id = 3762, name = "Fur Lining - Shadow Resist", description = "LW: +70 Shadow Resistance" },
    { id = 3763, name = "Fur Lining - Nature Resist", description = "LW: +70 Nature Resistance" },
    { id = 3756, name = "Fur Lining - Arcane Resist", description = "LW: +70 Arcane Resistance" },
    
    -- TBC/Classic
    { id = 2661, name = "Superior Healing", description = "+30 Healing" },
    { id = 2650, name = "Major Defense", description = "+12 Defense" },
    { id = 2649, name = "Assault", description = "+24 Attack Power" },
    { id = 1600, name = "Major Intellect", description = "+12 Intellect" },
    { id = 1593, name = "Major Strength", description = "+15 Strength" },
    { id = 1891, name = "Superior Stamina", description = "+9 Stamina" },
    { id = 1885, name = "Greater Strength", description = "+7 Strength" },
    { id = 1883, name = "Greater Intellect", description = "+7 Intellect" },
    { id = 905, name = "Greater Stamina", description = "+7 Stamina" },
    { id = 923, name = "Deflection", description = "+5 Defense" },
    { id = 906, name = "Greater Strength", description = "+9 Strength" },
}

-- Leg Enchants (Leg Armor Kits and Thread)
EnchantmentData.LEG_ENCHANTS = {
    -- WotLK Leg Armor Kits
    { id = 3853, name = "Earthen Leg Armor", description = "+40 Stamina and +28 Resilience" },
    { id = 3325, name = "Frosthide Leg Armor", description = "+55 Stamina and +22 Agility" },
    { id = 3326, name = "Icescale Leg Armor", description = "+75 Attack Power and +22 Critical Strike" },
    { id = 3327, name = "Jormungar Leg Armor", description = "+45 Stamina and +15 Agility" },
    { id = 3822, name = "Nerubian Leg Armor", description = "+55 Attack Power and +15 Critical Strike" },
    { id = 3823, name = "Wyrmscale Leg Armor", description = "+78 Attack Power and +22 Critical Strike" },
    
    -- WotLK Spellthreads
    { id = 3719, name = "Azure Spellthread", description = "+35 Spell Power and +20 Stamina" },
    { id = 3720, name = "Shining Spellthread", description = "+35 Spell Power and +12 Spirit" },
    { id = 3721, name = "Brilliant Spellthread", description = "+50 Spell Power and +20 Spirit" },
    { id = 3872, name = "Sapphire Spellthread", description = "+50 Spell Power and +30 Stamina" },
    
    -- TBC Leg Armor
    { id = 3012, name = "Nethercleft Leg Armor", description = "+40 Stamina and +12 Agility" },
    { id = 3013, name = "Nethercobra Leg Armor", description = "+50 Attack Power and +12 Critical Strike" },
    { id = 3010, name = "Cobrahide Leg Armor", description = "+30 Attack Power and +10 Critical Strike" },
    { id = 3011, name = "Clefthide Leg Armor", description = "+30 Stamina and +10 Agility" },
    { id = 2747, name = "Silver Spellthread", description = "+25 Spell Power and +15 Stamina" },
    { id = 2748, name = "Golden Spellthread", description = "+35 Healing and +20 Stamina" },
    { id = 2745, name = "Mystic Spellthread", description = "+25 Spell Power and +15 Stamina" },
    { id = 2746, name = "Runic Spellthread", description = "+35 Spell Power and +20 Stamina" },
    
    -- Leatherworking Reinforcements
    { id = 3329, name = "Jormungar Leg Reinforcements", description = "LW: +45 Stamina and +15 Agility" },
    { id = 3330, name = "Nerubian Leg Reinforcements", description = "LW: +55 Attack Power and +15 Critical Strike" },
}

-- Shoulder Enchants (Inscription/Reputation)
EnchantmentData.SHOULDER_ENCHANTS = {
    -- Sons of Hodir
    { id = 3852, name = "Greater Inscription of the Pinnacle", description = "+40 Dodge and +15 Defense" },
    { id = 3793, name = "Greater Inscription of the Axe", description = "+40 Attack Power and +15 Critical Strike" },
    { id = 3794, name = "Greater Inscription of the Crag", description = "+24 Spell Power and +8 MP5" },
    { id = 3795, name = "Greater Inscription of the Storm", description = "+24 Spell Power and +15 Critical Strike" },
    { id = 3796, name = "Greater Inscription of the Pinnacle", description = "+20 Dodge and +15 Defense" },
    
    -- Inscription Profession
    { id = 3835, name = "Master's Inscription of the Axe", description = "Inscription: +120 Attack Power and +15 Critical Strike" },
    { id = 3836, name = "Master's Inscription of the Crag", description = "Inscription: +61 Spell Power and +15 Critical Strike" },
    { id = 3837, name = "Master's Inscription of the Storm", description = "Inscription: +70 Spell Power and +15 Critical Strike" },
    { id = 3838, name = "Master's Inscription of the Pinnacle", description = "Inscription: +60 Dodge and +15 Defense" },
    
    -- Lesser Inscriptions
    { id = 3806, name = "Lesser Inscription of the Axe", description = "+30 Attack Power and +10 Critical Strike" },
    { id = 3807, name = "Lesser Inscription of the Crag", description = "+18 Spell Power and +5 MP5" },
    { id = 3808, name = "Lesser Inscription of the Storm", description = "+18 Spell Power and +10 Critical Strike" },
    { id = 3809, name = "Lesser Inscription of the Pinnacle", description = "+15 Dodge and +10 Defense" },
    
    -- PvP Inscriptions
    { id = 3810, name = "Inscription of Triumph", description = "+40 Attack Power and +15 Resilience" },
    { id = 3811, name = "Inscription of Dominance", description = "+23 Spell Power and +15 Resilience" },
    
    -- TBC Shoulder Enchants
    { id = 2986, name = "Greater Inscription of Vengeance", description = "+30 Attack Power and +10 Critical Strike" },
    { id = 2982, name = "Greater Inscription of the Blade", description = "+20 Attack Power and +15 Critical Strike" },
    { id = 2983, name = "Greater Inscription of the Knight", description = "+15 Defense and +10 Dodge" },
    { id = 2984, name = "Greater Inscription of the Oracle", description = "+23 Healing and +5 MP5" },
    { id = 2985, name = "Greater Inscription of the Orb", description = "+15 Spell Power and +14 Critical Strike" },
    { id = 2990, name = "Inscription of Endurance", description = "+7 All Resistances" },
}

-- Head Enchants (Reputation Arcanum)
EnchantmentData.HEAD_ENCHANTS = {
    -- WotLK Arcanums
    { id = 3878, name = "Arcanum of the Eclipsed Moon", description = "+25 Spell Power and +30 Stamina" },
    { id = 3812, name = "Arcanum of Torment", description = "+50 Attack Power and +20 Critical Strike" },
    { id = 3813, name = "Arcanum of the Scourge", description = "+25 Spell Power and +30 Stamina" },
    { id = 3814, name = "Arcanum of Triumph", description = "+50 Attack Power and +20 Resilience" },
    { id = 3815, name = "Arcanum of Dominance", description = "+29 Spell Power and +20 Resilience" },
    { id = 3816, name = "Arcanum of the Savage Gladiator", description = "+30 Stamina and +25 Resilience" },
    { id = 3817, name = "Arcanum of Blissful Mending", description = "+30 Spell Power and +8 MP5" },
    { id = 3818, name = "Arcanum of Burning Mysteries", description = "+30 Spell Power and +20 Critical Strike" },
    { id = 3819, name = "Arcanum of the Stalwart Protector", description = "+37 Stamina and +20 Defense" },
    { id = 3820, name = "Arcanum of the Frosty Soul", description = "+30 Stamina and +20 Frost Resistance" },
    { id = 3842, name = "Arcanum of the Toxic Wastes", description = "+30 Stamina and +20 Nature Resistance" },
    
    -- Engineering Tinkers
    { id = 3826, name = "Mind Amplification Dish", description = "Engineering: Mind Control chance + 45 Stamina" },
    
    -- TBC Arcanums
    { id = 3002, name = "Arcanum of Ferocity", description = "+34 Attack Power and +16 Hit" },
    { id = 3003, name = "Arcanum of the Gladiator", description = "+30 Stamina and +20 Resilience" },
    { id = 3004, name = "Arcanum of the Defender", description = "+17 Defense and +16 Dodge" },
    { id = 3005, name = "Arcanum of the Outcast", description = "+25 Spell Power and +12 MP5" },
    { id = 3006, name = "Arcanum of Renewal", description = "+35 Healing and +10 MP5" },
    { id = 3007, name = "Arcanum of Power", description = "+23 Spell Power and +14 Hit" },
    { id = 3008, name = "Arcanum of Protection", description = "+20 All Resistances" },
    { id = 3001, name = "Arcanum of Fire Warding", description = "+20 Fire Resistance" },
    { id = 3000, name = "Arcanum of Shadow Warding", description = "+20 Shadow Resistance" },
}

-- Belt Enchants (Belt Buckle/Engineering)
EnchantmentData.BELT_ENCHANTS = {
    -- Belt Buckles (adds socket)
    { id = 3729, name = "Eternal Belt Buckle", description = "Add a prismatic socket to belt" },
    
    -- Engineering
    { id = 3601, name = "Frag Belt", description = "Engineering: Throw bombs" },
    { id = 3599, name = "Personal Electromagnetic Pulse Generator", description = "Engineering: Malfunction chance" },
}

-- Ring Enchants (Enchanting profession only)
EnchantmentData.RING_ENCHANTS = {
    { id = 3839, name = "Assault", description = "Enchanting: +40 Attack Power" },
    { id = 3840, name = "Greater Spellpower", description = "Enchanting: +23 Spell Power" },
    { id = 3791, name = "Stamina", description = "Enchanting: +30 Stamina" },
    { id = 2931, name = "Stats", description = "Enchanting: +4 All Stats" },
    { id = 2929, name = "Striking", description = "Enchanting: +20 Attack Power" },
    { id = 2930, name = "Healing Power", description = "Enchanting: +20 Healing" },
    { id = 2928, name = "Spellpower", description = "Enchanting: +12 Spell Power" },
}

-- Shield Enchants
EnchantmentData.SHIELD_ENCHANTS = {
    { id = 3849, name = "Titanium Plating", description = "+36 Block Value" },
    { id = 1952, name = "Major Intellect", description = "+25 Intellect" },
    { id = 3229, name = "Resilience", description = "+12 Defense" },
    { id = 2655, name = "Greater Stamina", description = "+18 Stamina" },
    { id = 2654, name = "Major Stamina", description = "+18 Stamina" },
    { id = 2653, name = "Resistance", description = "+5 All Resistances" },
    { id = 1888, name = "Resistance", description = "+5 All Resistances" },
    { id = 1904, name = "Tough Shield", description = "+15 Block Value" },
    { id = 1128, name = "Greater Stamina", description = "+7 Stamina" },
    { id = 863, name = "Greater Stamina", description = "+7 Stamina" },
}

-- Ranged Weapon Enchants (Bows, Crossbows, Guns)
EnchantmentData.RANGED_ENCHANTS = {
    { id = 3607, name = "Superior Scouting", description = "+5 Damage" },
    { id = 3608, name = "Heartseeker Scope", description = "+40 Critical Strike" },
    { id = 3843, name = "Sun Scope", description = "+40 Haste" },
    { id = 2724, name = "Stabilized Eternium Scope", description = "+28 Critical Strike" },
    { id = 2723, name = "Khorium Scope", description = "+12 Damage" },
    { id = 2722, name = "Adamantite Scope", description = "+10 Damage" },
    { id = 2523, name = "Biznicks 247x128 Accurascope", description = "+30 Hit" },
    { id = 663, name = "Sniper Scope", description = "+7 Damage" },
    { id = 664, name = "Scope (+7 Damage)", description = "+7 Damage" },
}

-- ============================================================================
-- Random Suffix Enchantments (e.g., "of the Bear", "of the Eagle")
-- ============================================================================

-- Load random suffix data if available
local RandomSuffixData = nil
local randomSuffixLoadSuccess, randomSuffixModule = pcall(function()
    return require("GameMasterUI_RandomSuffixData")
end)
if randomSuffixLoadSuccess then
    RandomSuffixData = randomSuffixModule
    print("[EnchantmentData] Loaded RandomSuffixData module")
else
    print("[EnchantmentData] RandomSuffixData module not found, random suffixes will not be available")
end

-- Get all random suffix enchantments
EnchantmentData.RANDOM_SUFFIX_ENCHANTS = {}
if RandomSuffixData then
    EnchantmentData.RANDOM_SUFFIX_ENCHANTS = RandomSuffixData.GetAllRandomSuffixEnchantments()
    print(string.format("[EnchantmentData] Loaded %d random suffix enchantments", #EnchantmentData.RANDOM_SUFFIX_ENCHANTS))
end

-- ============================================================================
-- Helper Functions
-- ============================================================================

-- Get enchants by slot type
function EnchantmentData.GetEnchantsBySlot(slotType)
    local normalizedSlot = string.upper(slotType)
    
    -- Map slot names to enchant categories
    local slotMap = {
        -- Weapons
        ["MAIN HAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["OFF HAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["MAINHAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["OFFHAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["ONE-HAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["TWO-HAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["WEAPON"] = EnchantmentData.WEAPON_ENCHANTS,
        ["INVTYPE_WEAPON"] = EnchantmentData.WEAPON_ENCHANTS,
        ["INVTYPE_2HWEAPON"] = EnchantmentData.WEAPON_ENCHANTS,
        ["INVTYPE_WEAPONMAINHAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["INVTYPE_WEAPONOFFHAND"] = EnchantmentData.WEAPON_ENCHANTS,
        ["INVTYPE_SHIELD"] = EnchantmentData.SHIELD_ENCHANTS,
        ["INVTYPE_HOLDABLE"] = EnchantmentData.SHIELD_ENCHANTS,
        ["INVTYPE_RANGED"] = EnchantmentData.RANGED_ENCHANTS,
        ["INVTYPE_THROWN"] = EnchantmentData.RANGED_ENCHANTS,
        ["INVTYPE_RANGEDRIGHT"] = EnchantmentData.RANGED_ENCHANTS,
        
        -- Armor
        ["CHEST"] = EnchantmentData.CHEST_ENCHANTS,
        ["INVTYPE_CHEST"] = EnchantmentData.CHEST_ENCHANTS,
        ["INVTYPE_ROBE"] = EnchantmentData.CHEST_ENCHANTS,
        ["FEET"] = EnchantmentData.BOOT_ENCHANTS,
        ["INVTYPE_FEET"] = EnchantmentData.BOOT_ENCHANTS,
        ["HANDS"] = EnchantmentData.GLOVE_ENCHANTS,
        ["INVTYPE_HAND"] = EnchantmentData.GLOVE_ENCHANTS,
        ["BACK"] = EnchantmentData.CLOAK_ENCHANTS,
        ["INVTYPE_CLOAK"] = EnchantmentData.CLOAK_ENCHANTS,
        ["WRIST"] = EnchantmentData.BRACER_ENCHANTS,
        ["INVTYPE_WRIST"] = EnchantmentData.BRACER_ENCHANTS,
        ["LEGS"] = EnchantmentData.LEG_ENCHANTS,
        ["INVTYPE_LEGS"] = EnchantmentData.LEG_ENCHANTS,
        ["SHOULDER"] = EnchantmentData.SHOULDER_ENCHANTS,
        ["INVTYPE_SHOULDER"] = EnchantmentData.SHOULDER_ENCHANTS,
        ["HEAD"] = EnchantmentData.HEAD_ENCHANTS,
        ["INVTYPE_HEAD"] = EnchantmentData.HEAD_ENCHANTS,
        ["WAIST"] = EnchantmentData.BELT_ENCHANTS,
        ["INVTYPE_WAIST"] = EnchantmentData.BELT_ENCHANTS,
        ["FINGER"] = EnchantmentData.RING_ENCHANTS,
        ["INVTYPE_FINGER"] = EnchantmentData.RING_ENCHANTS,
    }
    
    local slotEnchants = slotMap[normalizedSlot] or {}
    
    -- Combine slot-specific enchants with random suffix enchants
    -- Random suffixes can apply to most equipment types
    local combinedEnchants = {}
    
    -- Add slot-specific enchants first
    for _, enchant in ipairs(slotEnchants) do
        table.insert(combinedEnchants, enchant)
    end
    
    -- Add random suffix enchants for applicable slots
    -- Random suffixes typically apply to weapons and armor pieces
    local allowRandomSuffix = normalizedSlot:find("WEAPON") or 
                             normalizedSlot:find("CHEST") or
                             normalizedSlot:find("HEAD") or
                             normalizedSlot:find("SHOULDER") or
                             normalizedSlot:find("LEGS") or
                             normalizedSlot:find("FEET") or
                             normalizedSlot:find("HAND") or
                             normalizedSlot:find("WRIST") or
                             normalizedSlot:find("WAIST") or
                             normalizedSlot:find("FINGER") or
                             normalizedSlot:find("CLOAK") or
                             normalizedSlot:find("SHIELD")
    
    if allowRandomSuffix and EnchantmentData.RANDOM_SUFFIX_ENCHANTS then
        for _, enchant in ipairs(EnchantmentData.RANDOM_SUFFIX_ENCHANTS) do
            table.insert(combinedEnchants, enchant)
        end
    end
    
    return combinedEnchants
end

-- Get all enchantments
function EnchantmentData.GetAllEnchantments()
    local allEnchants = {}
    
    -- Combine all enchant tables
    local tables = {
        EnchantmentData.WEAPON_ENCHANTS,
        EnchantmentData.CHEST_ENCHANTS,
        EnchantmentData.BOOT_ENCHANTS,
        EnchantmentData.GLOVE_ENCHANTS,
        EnchantmentData.CLOAK_ENCHANTS,
        EnchantmentData.BRACER_ENCHANTS,
        EnchantmentData.LEG_ENCHANTS,
        EnchantmentData.SHOULDER_ENCHANTS,
        EnchantmentData.HEAD_ENCHANTS,
        EnchantmentData.BELT_ENCHANTS,
        EnchantmentData.RING_ENCHANTS,
        EnchantmentData.SHIELD_ENCHANTS,
        EnchantmentData.RANGED_ENCHANTS,
        EnchantmentData.RANDOM_SUFFIX_ENCHANTS, -- Include random suffixes
    }
    
    for _, enchantTable in ipairs(tables) do
        for _, enchant in ipairs(enchantTable) do
            table.insert(allEnchants, enchant)
        end
    end
    
    return allEnchants
end

-- Get enchantment by ID
function EnchantmentData.GetEnchantmentById(enchantId)
    local allEnchants = EnchantmentData.GetAllEnchantments()
    for _, enchant in ipairs(allEnchants) do
        if enchant.id == enchantId then
            return enchant
        end
    end
    return nil
end

-- Export the module
_G.EnchantmentData = EnchantmentData
return EnchantmentData