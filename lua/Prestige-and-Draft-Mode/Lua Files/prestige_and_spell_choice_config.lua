CONFIG = {
    MAX_LEVEL = 70,  --Level Required to venture into Prestige Mode(s) via NPC_ID Gossip

    NPC_ID = 2069426, --Default Custom Chromie npc. But can be put on any npc with a Gossip Flag

    DRAFT_MODE_REROLLS = 5, --Base Amount of Rerolls a player gets when starting Draft

    DRAFT_MODE_SPELLS = 3,  --Base Amount of Spells a player gets when starting Draft

    DRAFT_REROLLS_GAINED_PER_PRESTIGE_LEVEL = 5, --Everytime a player prestiges, on the next run they get this many rerolls at start formula being (players prestige total count * DRAFT_REROLLS_GAINED_PER_PRESTIGE_LEVEL)

    DRAFT_BANS_START = 5, --Amount of bans every player gets at the start of a draft
    
    INCLUDE_RARITY_5 = false, --These are broken(like infinitely spammable, they stil function, spells. This will ruin any sort of balance on your server. But if you're singleplayer, who cares? This also includes racial passives for now.

    REROLLS_PER_LEVELUP = 2, --How many extra rerolls a player gets per levelup while in Draft Mode

    POOL_AMOUNT = 45, --How many spells get pooled for the player to choose from. Higher numbers burdens server exponentially playercount goes up. Careful with this.

    RARITY_DISTRIBUTION = { -- Sum of 1.0 Distribution of rarities of spells filling up POOL_AMOUNT
        [0] = 0.50,
        [1] = 0.27,
        [2] = 0.14,
        [3] = 0.06,
        [4] = 0.03,
    },

    PrestigeTitles = {  --Titles Linked to the prestige & draft system. 11 titles for prestige progress and one Temporary 'draft mode only' title to differentiate players from others.
        [1] = 523, [2] = 524, [3] = 525, [4] = 526,
        [5] = 527, [6] = 528, [7] = 529, [8] = 530,
        [9] = 531, [10] = 532, [11] = 537
    },

    --- CHROMIE DIALOGUE

    CHROMIE_LOCATION_HORDE = "Chromie can be found just outside Orgrimmar.",  --At Max level, player gets an on screen message to go visit chromie to prestige. This does not set the location, this is the faction specific part of the phrase. Horde.

    CHROMIE_LOCATION_ALLIANCE = "Chromie can be found just outside Ironforge.",--At Max level, player gets an on screen message to go visit chromie to prestige. This does not set the location, this is the faction specific part of the phrase. Alliance.


    --Lore explaining away prestige in-world
    prestigeDescription = [[
    In the vast weave of time, there are countless realities where your character made different choices.

    Perhaps a Troll warrior learned the secrets of the Light, or a Tauren mage studied the mysteries of the arcane.

    The Prestige System lets you tap into these echoes of alternate timelines, drawing from destinies you never walked.. but could have.

    The Bronze Dragonflight has safeguarded these echoes, and now, with the timelines becoming increasingly unstable, we’ve made these echoes accessible.. with a cost, of course.

    To Prestige is to reset your journey through time, returning to your youth while retaining special memories in the form of unique spells, chosen from other realities.
    ]],

    --Players who are not MAX_LEVEL will see this message
    prestigeBlockedMessage = "You are not yet at max level.\nYou cannot partake in prestigeous events.",

    --This is the displayed list of things lost upon prestige.
    prestigeLossList = {
        "- Earned Levels",
        "- Learned Spells",
        "- Quest History",
        "- Talents and Talent Points",
        "- Equipped Gear(Returned via Mail)"
    },
    startingGear = {
      -- ALLIANCE
      ["HUMAN_WARRIOR"] = {
        [16] = 49778, -- Worn Greatsword (Two-Hand)
        [4]  = 38,    -- Recruit's Shirt
        [7]  = 39,    -- Recruit's Pants
        [8]  = 40,    -- Recruit's Boots
        [5]  = 6125   -- Brawler's Harness (Alternate Chest Visual)
      },
      ["HUMAN_PALADIN"] = {
        [4]  = 45,    -- Squire's Shirt
        [16] = 2361,  -- Battleworn Hammer (Two-Hand)
        [7]  = 43,    -- Squire's Pants
        [8]  = 44     -- Footpad Shoes
      },
      ["HUMAN_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger
        [8]  = 47,    -- Footpad Shoes
        [7]  = 39,    -- Recruit's Pants
        [4]  = 45     -- Squire's Shirt
      },
      ["HUMAN_PRIEST"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 53,    -- Neophyte's Shirt
        [7]  = 52,    -- Neophyte's Pants
        [8]  = 51     -- Neophyte's Boots
      },
      ["HUMAN_MAGE"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 45,    -- Squire's Shirt
        [7]  = 39,    -- Squire's Pants
        [8]  = 55     -- Apprentice's Boots
      },
      ["HUMAN_WARLOCK"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 57,    -- Acolyte's Robe
        [8]  = 59,    -- Acolyte's Shoes
        [4]  = 6097   -- Acolyte's Shirt
      },
      ["NIGHTELF_WARRIOR"] = {
        [16] = 12282, -- Worn Battleaxe
        [5]  = 1364,  -- Ragged Leather Vest
        [7]  = 1366,  -- Ragged Leather Pants
        [8]  = 1367   -- Ragged Leather Boots
      },
      ["NIGHTELF_ROGUE"] = {
        [5]  = 2105,  -- Thug Shirt
        [7]  = 120,   -- Thug Pants
        [8]  = 121,   -- Thug Boots
        [16] = 2092   -- Worn Dagger
      },
      ["NIGHTELF_HUNTER"] = {
        [18] = 25,  -- Worn Shortbow(RANGED)
        [17] = 2512,  -- ARROWS
        [16] = 12282, -- Worn Battleaxe
        [4]  = 148,   -- Rugged Trapper's Shirt
        [7]  = 147,   -- Rugged Trapper's Pants
        [8]  = 129    -- Rugged Trapper's Boots
      },
      ["NIGHTELF_DRUID"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 6098,  -- Neophyte's Robe
        [7]  = 6124,  -- Novice's Pants
        [8]  = 129    -- Novice's Boots
      },
      ["GNOME_WARRIOR"] = {
        [16] = 25,    -- Worn Shortsword
        [5]  = 6125,  -- Brawler's Harness
        [7]  = 38,    -- Recruit's Pants
        [8]  = 39     -- Recruit's Boots
      },
      ["GNOME_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger
        [8]  = 47,    -- Footpad Shoes
        [7]  = 39,    -- Recruit's Pants
        [5]  = 45     -- Squire's Shirt
      },
      ["GNOME_MAGE"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 45,    -- Squire's Shirt
        [7]  = 39,    -- Squire's Pants
        [8]  = 55     -- Apprentice's Boots
      },
      ["GNOME_WARLOCK"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 57,    -- Acolyte's Robe
        [8]  = 59,    -- Acolyte's Shoes
        [4]  = 6097   -- Acolyte's Shirt
      },
      ["DRAENEI_WARRIOR"] = {
        [16] = 25,    -- Worn Shortsword
        [5]  = 6125,  -- Brawler's Harness
        [7]  = 39,    -- Recruit's Pants
        [8]  = 39     -- Recruit's Boots
      },
      ["DRAENEI_PALADIN"] = {
        [16] = 2361,  -- Battleworn Hammer
        [5]  = 43,    -- Squire's Shirt
        [7]  = 45,    -- Squire's Pants
        [8]  = 47     -- Footpad Shoes
      },
      ["DRAENEI_PRIEST"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 53,    -- Neophyte's Shirt
        [7]  = 52,    -- Neophyte's Pants
        [8]  = 51     -- Neophyte's Boots
      },
      ["DRAENEI_MAGE"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 45,    -- Squire's Shirt
        [7]  = 39,    -- Squire's Pants
        [8]  = 55     -- Apprentice's Boots
      },
      ["DRAENEI_SHAMAN"] = {
        [16] = 36,    -- Worn Mace
        [3]  = 154,   -- Primitive Mantle
        [7]  = 153,   -- Primitive Kilt
        [5]  = 6098   -- Neophyte's Robe
      },
      ["DWARF_WARRIOR"] = {
        [16] = 12282, -- Worn Battleaxe (Two-Hand)
        [5]  = 6125,  -- Brawler's Harness
        [7]  = 47,    -- Footpad Pants
        [8]  = 48     -- Footpad Shoes
      },

      ["DWARF_PALADIN"] = {
        [16] = 2361,  -- Battleworn Hammer
        [5]  = 6074,  -- Novice's Vestments
        [7]  = 52,    -- Neophyte's Pants
        [8]  = 51     -- Neophyte's Boots
      },

      ["DWARF_HUNTER"] = {
        [16] = 2508,  -- Old Blunderbuss
        [17] = 2516,  -- BULLETS
        [5]  = 6130,  -- Trapper's Shirt
        [7]  = 6135,  -- Primitive Kilt
        [8]  = 40     -- Recruit's Boots
      },

      ["DWARF_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger
        [5]  = 6123,  -- Novice's Shirt
        [7]  = 120,   -- Thug Pants
        [8]  = 121    -- Thug Boots
      },

      ["DWARF_PRIEST"] = {
        [16] = 35,    -- Bent Staff
        [5]  = 53,    -- Neophyte's Shirt
        [7]  = 52,    -- Neophyte's Pants
        [8]  = 51     -- Neophyte's Boots
      },
      -- HORDE
      ["ORC_WARRIOR"] = {
        [16] = 25,    -- Worn Shortsword (Main Hand)
        [5]  = 6125,  -- Brawler's Harness (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 40     -- Recruit's Boots (Feet)
      },
      ["ORC_HUNTER"] = {
        [18] = 25,  -- Worn Shortbow(RANGED)
        [17] = 2512,  -- ARROWS
        [16] = 12282, -- Worn Battleaxe (Two-Hand)
        [5]  = 147,   -- Rugged Trapper's Shirt (Chest)
        [7]  = 148,   -- Rugged Trapper's Pants (Legs)
        [8]  = 129    -- Rugged Trapper's Boots (Feet)
      },
      ["ORC_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger (Main Hand)
        [5]  = 45,    -- Squire's Shirt (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 47     -- Footpad Shoes (Feet)
      },
      ["ORC_SHAMAN"] = {
        [16] = 36,    -- Worn Mace (Main Hand)
        [3]  = 154,   -- Primitive Mantle (Shoulder)
        [5]  = 6098,  -- Neophyte's Robe (Chest)
        [7]  = 153    -- Primitive Kilt (Legs)
      },
      ["ORC_WARLOCK"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 57,    -- Acolyte's Robe (Chest)
        [8]  = 59,    -- Acolyte's Shoes (Feet)
        [4]  = 6097   -- Acolyte's Shirt (Visual Shirt)
      },
      ["TROLL_WARRIOR"] = {
        [16] = 25,    -- Worn Shortsword (Main Hand)
        [5]  = 6125,  -- Brawler's Harness (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 40     -- Recruit's Boots (Feet)
      },
      ["TROLL_HUNTER"] = {
        [18] = 25,  -- Worn Shortbow(RANGED)
        [17] = 2512,  -- ARROWS
        [16] = 12282, -- Worn Battleaxe (Two-Hand)
        [5]  = 147,   -- Rugged Trapper's Shirt (Chest)
        [7]  = 148,   -- Rugged Trapper's Pants (Legs)
        [8]  = 129    -- Rugged Trapper's Boots (Feet)
      },
      ["TROLL_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger (Main Hand)
        [5]  = 45,    -- Squire's Shirt (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 47     -- Footpad Shoes (Feet)
      },
      ["TROLL_SHAMAN"] = {
        [16] = 36,    -- Worn Mace (Main Hand)
        [3]  = 154,   -- Primitive Mantle (Shoulder)
        [5]  = 6098,  -- Neophyte's Robe (Chest)
        [7]  = 153    -- Primitive Kilt (Legs)
      },
      ["TROLL_PRIEST"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 53,    -- Neophyte's Shirt (Chest)
        [7]  = 52,    -- Neophyte's Pants (Legs)
        [8]  = 51     -- Neophyte's Boots (Feet)
      },
      ["TROLL_MAGE"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 45,    -- Squire's Shirt (Chest)
        [7]  = 39,    -- Squire's Pants (Legs)
        [8]  = 55     -- Apprentice's Boots (Feet)
      },
      ["UNDEAD_WARRIOR"] = {
        [16] = 25,    -- Worn Shortsword (Main Hand)
        [5]  = 6125,  -- Brawler's Harness (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 40     -- Recruit's Boots (Feet)
      },
      ["UNDEAD_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger (Main Hand)
        [5]  = 45,    -- Squire's Shirt (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 47     -- Footpad Shoes (Feet)
      },
      ["UNDEAD_MAGE"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 45,    -- Squire's Shirt (Chest)
        [7]  = 39,    -- Squire's Pants (Legs)
        [8]  = 55     -- Apprentice's Boots (Feet)
      },
      ["UNDEAD_WARLOCK"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 57,    -- Acolyte's Robe (Chest)
        [8]  = 59,    -- Acolyte's Shoes (Feet)
        [4]  = 6097   -- Acolyte's Shirt (Visual Shirt)
      },
      ["UNDEAD_PRIEST"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 53,    -- Neophyte's Shirt (Chest)
        [7]  = 52,    -- Neophyte's Pants (Legs)
        [8]  = 51     -- Neophyte's Boots (Feet)
      },
      ["TAUREN_WARRIOR"] = {
        [16] = 25,    -- Worn Shortsword (Main Hand)
        [5]  = 6125,  -- Brawler's Harness (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 40     -- Recruit's Boots (Feet)
      },
      ["TAUREN_DRUID"] = {
        [17] = 35,    -- Bent Staff (Two-Hand)
        [5]  = 6098,  -- Neophyte's Robe (Chest)
        [7]  = 140,   -- Novice's Pants (Legs)
        [8]  = 139    -- Novice's Boots (Feet)
      },
      ["TAUREN_SHAMAN"] = {
        [16] = 36,    -- Worn Mace (Main Hand)
        [3]  = 154,   -- Primitive Mantle (Shoulder)
        [5]  = 6098,  -- Neophyte's Robe (Chest)
        [7]  = 153    -- Primitive Kilt (Legs)
      },
      ["BLOODELF_PALADIN"] = {
        [16] = 2361,  -- Battleworn Hammer (Main Hand)
        [5]  = 43,    -- Squire's Shirt (Chest)
        [7]  = 45,    -- Squire's Pants (Legs)
        [8]  = 47     -- Footpad Shoes (Feet)
      },
      ["BLOODELF_ROGUE"] = {
        [16] = 2092,  -- Worn Dagger (Main Hand)
        [5]  = 45,    -- Squire's Shirt (Chest)
        [7]  = 39,    -- Recruit's Pants (Legs)
        [8]  = 47     -- Footpad Shoes (Feet)
      },
      ["BLOODELF_HUNTER"] = {
        [18] = 2512,  -- Old Blunderbuss (Ranged)
        [18] = 2101,  -- Light Quiver (Ammo)
        [16] = 12282, -- Worn Battleaxe (Two-Hand)
        [5]  = 147,   -- Rugged Trapper's Shirt (Chest)
        [7]  = 148,   -- Rugged Trapper's Pants (Legs)
        [8]  = 129    -- Rugged Trapper's Boots (Feet)
      },
      ["BLOODELF_MAGE"] = {
        [17] = 20978,   -- Apprentice's Staff (Two-Hand)
        [5]  = 56,      -- Apprentice's Robes (Chest)
        [7]  = 1395,    -- Apprentice's Pants (Legs)
        [8]  = 20895    -- Apprentice's Boots (Feet)
      },
      ["BLOODELF_PRIEST"] = {
        [17] = 20978, -- Apprentice's Staff (Two-Hand)
        [5]  = 53,    -- Neophyte's Shirt (Chest)
        [7]  = 52,    -- Neophyte's Pants (Legs)
        [8]  = 51     -- Neophyte's Boots (Feet)
      },
      ["BLOODELF_WARLOCK"] = {
        [17] = 20978, -- Apprentice's Staff (Two-Hand)
        [5]  = 57,    -- Acolyte's Robe (Chest)
        [8]  = 59,    -- Acolyte's Shoes (Feet)
        [4]  = 6097   -- Acolyte's Shirt (Visual Shirt)
      },
      ["DEATHKNIGHT"] = {
        [5]  = 34650, -- Acherus Knight's Tunic (Chest)
        [10] = 34649, -- Acherus Knight's Gauntlets (Hands)
        [7]  = 34656, -- Acherus Knight's Legplates (Legs)
        [8]  = 34648, -- Acherus Knight's Greaves (Feet)
        [6]  = 34651, -- Acherus Knight's Girdle (Waist)
        [15] = 34659, -- Acherus Knight's Shroud (Back)
        [2]  = 34657, -- Choker of Damnation (Neck)
        [11] = 34658, -- Plague Band (Ring 1)
        [12] = 38147, -- Corrupted Band (Ring 2)
        [1]  = 34652  -- Acherus Knight's Hood (Head)
      },
      ["ORC_MAGE"] = {
        [17] = 20978,   -- Apprentice's Staff (Two-Hand)
        [5]  = 56,      -- Apprentice's Robes (Chest)
        [7]  = 1395,    -- Apprentice's Pants (Legs)
        [8]  = 20895    -- Apprentice's Boots (Feet)
      },
      ["TROLL_MAGE"] = {
        [17] = 20978,   -- Apprentice's Staff (Two-Hand)
        [5]  = 56,      -- Apprentice's Robes (Chest)
        [7]  = 1395,    -- Apprentice's Pants (Legs)
        [8]  = 20895    -- Apprentice's Boots (Feet)
      },
      ["DWARF_MAGE"] = {
        [17] = 20978,   -- Apprentice's Staff (Two-Hand)
        [5]  = 56,      -- Apprentice's Robes (Chest)
        [7]  = 1395,    -- Apprentice's Pants (Legs)
        [8]  = 20895    -- Apprentice's Boots (Feet)
      },
      ["TAUREN_MAGE"] = {
        [17] = 20978,   -- Apprentice's Staff (Two-Hand)
        [5]  = 56,      -- Apprentice's Robes (Chest)
        [7]  = 1395,    -- Apprentice's Pants (Legs)
        [8]  = 20895    -- Apprentice's Boots (Feet)
      },
      ["NIGHTELF_MAGE"] = {
        [17] = 20978,   -- Apprentice's Staff (Two-Hand)
        [5]  = 56,      -- Apprentice's Robes (Chest)
        [7]  = 1395,    -- Apprentice's Pants (Legs)
        [8]  = 20895    -- Apprentice's Boots (Feet)
      },
    }
}
 
 