local Config = {}
Config.EnableGamemaster        = true -- Allow GM characters to learn spells
Config.EnableClassSpells       = true -- Learn class-specific spells
Config.EnableSpellsFromQuests  = true -- Learn spells normally obtained through quests
Config.EnableTalentRanks       = true -- Learn talent ranks
Config.EnableProficiencies     = true -- Learn proficiencies (weapon and defense skills)
Config.EnableApprenticeRiding  = true -- Learn apprentice riding
Config.EnableJourneymanRiding  = true -- Learn journeyman riding
Config.EnableExpertRiding      = true -- Learn expert riding
Config.EnableArtisanRiding     = true -- Learn artisan riding
Config.EnableColdWeatherFlying = true -- Learn cold weather flying

local Event          = {
    OnLogin          = 3,
    OnLevelChanged   = 13,
    OnTalentsChanged = 16,
}

local Team    = {
    Universal = -1,
    Alliance  = 0,
    Horde     = 1,
}

local Race    = {
    Universal = -1,
    Human     = 1,
    Orc       = 2,
    Dwarf     = 3,
    NightElf  = 4,
    Undead    = 5,
    Tauren    = 6,
    Gnome     = 7,
    Troll     = 8,
    BloodElf  = 10,
    Draenei   = 11,
}

local Class     = {
    Universal   = -1,
    Warrior     = 1,
    Paladin     = 2,
    Hunter      = 3,
    Rogue       = 4,
    Priest      = 5,
    DeathKnight = 6,
    Shaman      = 7,
    Mage        = 8,
    Warlock     = 9,
    Druid       = 11,
}

-- Required Race, Spell id, Required level, required spell id, earned from quests
local ClassSpells = {
    -- Warrior
    {{ Race.Universal, 78, 1, -1, 0 }, -- Heroic Strike (Rank 1)
    { Race.Universal, 2457, 1, -1, 0 }, -- Battle Stance
    { Race.Universal, 6673, 1, -1, 0 }, -- Battle Shout (Rank 1)
    { Race.Universal, 100, 4, -1, 0 }, -- Charge (Rank 1)
    { Race.Universal, 772, 4, -1, 0 }, -- Rend (Rank 1)
    { Race.Universal, 6343, 6, -1, 0 }, -- Thunder Clap (Rank 1)
    { Race.Universal, 34428, 6, -1, 0 }, -- Victory Rush
    { Race.Universal, 284, 8, 78, 0 }, -- Heroic Strike (Rank 2)
    { Race.Universal, 1715, 8, -1, 0 }, -- Hamstring
    { Race.Universal, 71, 10, -1, 1 }, -- Defensive Stance
    { Race.Universal, 355, 10, 71, 1 }, -- Taunt
    { Race.Universal, 2687, 10, -1, 0 }, -- Bloodrage
    { Race.Universal, 6546, 10, 772, 0 }, -- Rend (Rank 2)
    { Race.Universal, 7386, 10, 71, 1 }, -- Sunder Armor
    { Race.Universal, 72, 12, -1, 0 }, -- Shield Bash
    { Race.Universal, 5242, 12, 6673, 0 }, -- Battle Shout (Rank 2)
    { Race.Universal, 7384, 12, -1, 0 }, -- Overpower
    { Race.Universal, 1160, 14, -1, 0 }, -- Demoralizing Shout (Rank 1)
    { Race.Universal, 6572, 14, -1, 0 }, -- Revenge (Rank 1)
    { Race.Universal, 285, 16, 284, 0 }, -- Heroic Strike (Rank 3)
    { Race.Universal, 694, 16, -1, 0 }, -- Mocking Blow
    { Race.Universal, 2565, 16, -1, 0 }, -- Shield Block
    { Race.Universal, 676, 18, -1, 0 }, -- Disarm
    { Race.Universal, 8198, 18, 6343, 0 }, -- Thunder Clap (Rank 2)
    { Race.Universal, 845, 20, -1, 0 }, -- Cleave (Rank 1)
    { Race.Universal, 6547, 20, 6546, 0 }, -- Rend (Rank 3)
    { Race.Universal, 12678, 20, -1, 0 }, -- Stance Mastery (Passive)
    { Race.Universal, 20230, 20, -1, 0 }, -- Retaliation
    { Race.Universal, 5246, 22, -1, 0 }, -- Intimidating Shout
    { Race.Universal, 6192, 22, 5242, 0 }, -- Battle Shout (Rank 3)
    { Race.Universal, 1608, 24, 285, 0 }, -- Heroic Strike (Rank 4)
    { Race.Universal, 5308, 24, -1, 0 }, -- Execute (Rank 1)
    { Race.Universal, 6190, 24, 1160, 0 }, -- Demoralizing Shout (Rank 2)
    { Race.Universal, 6574, 24, 6572, 0 }, -- Revenge (Rank 2)
    { Race.Universal, 1161, 26, -1, 0 }, -- Challenging Shout
    { Race.Universal, 6178, 26, 100, 0 }, -- Charge (Rank 2)
    { Race.Universal, 871, 28, -1, 0 }, -- Shield Wall
    { Race.Universal, 8204, 28, 8198, 0 }, -- Thunder Clap (Rank 3)
    { Race.Universal, 1464, 30, -1, 0 }, -- Slam (Rank 1)
    { Race.Universal, 2458, 30, -1, 1 }, -- Berserker Stance
    { Race.Universal, 6548, 30, 6547, 0 }, -- Rend (Rank 4)
    { Race.Universal, 7369, 30, 845, 0 }, -- Cleave (Rank 2)
    { Race.Universal, 20252, 30, 2458, 1 }, -- Intercept
    { Race.Universal, 11549, 32, 6192, 0 }, -- Battle Shout (Rank 4)
    { Race.Universal, 11564, 32, 1608, 0 }, -- Heroic Strike (Rank 5)
    { Race.Universal, 18499, 32, -1, 0 }, -- Berserker Rage
    { Race.Universal, 20658, 32, 5308, 0 }, -- Execute (Rank 2)
    { Race.Universal, 7379, 34, 6574, 0 }, -- Revenge (Rank 3)
    { Race.Universal, 11554, 34, 6190, 0 }, -- Demoralizing Shout (Rank 3)
    { Race.Universal, 1680, 36, -1, 0 }, -- Whirlwind
    { Race.Universal, 6552, 38, -1, 0 }, -- Pummel
    { Race.Universal, 8205, 38, 8204, 0 }, -- Thunder Clap (Rank 4)
    { Race.Universal, 8820, 38, 1464, 0 }, -- Slam (Rank 2)
    { Race.Universal, 11565, 40, 11564, 0 }, -- Heroic Strike (Rank 6)
    { Race.Universal, 11572, 40, 6548, 0 }, -- Rend (Rank 5)
    { Race.Universal, 11608, 40, 7369, 0 }, -- Cleave (Rank 3)
    { Race.Universal, 20660, 40, 20658, 0 }, -- Execute (Rank 3)
    { Race.Universal, 23922, 40, -1, 0 }, -- Shield Slam (Rank 1)
    { Race.Universal, 11550, 42, 11549, 0 }, -- Battle Shout (Rank 5)
    { Race.Universal, 11555, 44, 11554, 0 }, -- Demoralizing Shout (Rank 4)
    { Race.Universal, 11600, 44, 7379, 0 }, -- Revenge (Rank 4)
    { Race.Universal, 11578, 46, 6178, 0 }, -- Charge (Rank 3)
    { Race.Universal, 11604, 46, 8820, 0 }, -- Slam (Rank 3)
    { Race.Universal, 11566, 48, 11565, 0 }, -- Heroic Strike (Rank 7)
    { Race.Universal, 11580, 48, 8205, 0 }, -- Thunder Clap (Rank 5)
    { Race.Universal, 20661, 48, 20660, 0 }, -- Execute (Rank 4)
    { Race.Universal, 23923, 48, 23922, 0 }, -- Shield Slam (Rank 2)
    { Race.Universal, 1719, 50, -1, 0 }, -- Recklessness
    { Race.Universal, 11573, 50, 11572, 0 }, -- Rend (Rank 6)
    { Race.Universal, 11609, 50, 11608, 0 }, -- Cleave (Rank 4)
    { Race.Universal, 11551, 52, 11550, 0 }, -- Battle Shout (Rank 6)
    { Race.Universal, 11556, 54, 11555, 0 }, -- Demoralizing Shout (Rank 5)
    { Race.Universal, 11601, 54, 11600, 0 }, -- Revenge (Rank 5)
    { Race.Universal, 11605, 54, 11604, 0 }, -- Slam (Rank 4)
    { Race.Universal, 23924, 54, 23923, 0 }, -- Shield Slam (Rank 3)
    { Race.Universal, 11567, 56, 11566, 0 }, -- Heroic Strike (Rank 8)
    { Race.Universal, 20662, 56, 20661, 0 }, -- Execute (Rank 5)
    { Race.Universal, 11581, 58, 11580, 0 }, -- Thunder Clap (Rank 6)
    { Race.Universal, 11574, 60, 11573, 0 }, -- Rend (Rank 7)
    { Race.Universal, 20569, 60, 11609, 0 }, -- Cleave (Rank 5)
    { Race.Universal, 23925, 60, 23924, 0 }, -- Shield Slam (Rank 4)
    { Race.Universal, 25286, 60, 11567, 0 }, -- Heroic Strike (Rank 9)
    { Race.Universal, 25288, 60, 11601, 0 }, -- Revenge (Rank 6)
    { Race.Universal, 25289, 60, 11551, 0 }, -- Battle Shout (Rank 7)
    { Race.Universal, 25241, 61, 11605, 0 }, -- Slam (Rank 5)
    { Race.Universal, 25202, 62, 11556, 0 }, -- Demoralizing Shout (Rank 6)
    { Race.Universal, 25269, 63, 25288, 0 }, -- Revenge (Rank 7)
    { Race.Universal, 23920, 64, -1, 0 }, -- Spell Reflection
    { Race.Universal, 25234, 65, 20662, 0 }, -- Execute (Rank 6)
    { Race.Universal, 25258, 66, 23925, 0 }, -- Shield Slam (Rank 5)
    { Race.Universal, 29707, 66, 25286, 0 }, -- Heroic Strike (Rank 10)
    { Race.Universal, 25264, 67, 11581, 0 }, -- Thunder Clap (Rank 7)
    { Race.Universal, 469, 68, -1, 0 }, -- Commanding Shout (Rank 1)
    { Race.Universal, 25208, 68, 11574, 0 }, -- Rend (Rank 8)
    { Race.Universal, 25231, 68, 20569, 0 }, -- Cleave (Rank 6)
    { Race.Universal, 2048, 69, 25289, 0 }, -- Battle Shout (Rank 8)
    { Race.Universal, 25242, 69, 25241, 0 }, -- Slam (Rank 6)
    { Race.Universal, 3411, 70, -1, 0 }, -- Intervene
    { Race.Universal, 25203, 70, 25202, 0 }, -- Demoralizing Shout (Rank 7)
    { Race.Universal, 25236, 70, 25234, 0 }, -- Execute (Rank 7)
    { Race.Universal, 30324, 70, 29707, 0 }, -- Heroic Strike (Rank 11)
    { Race.Universal, 30356, 70, 25258, 0 }, -- Shield Slam (Rank 6)
    { Race.Universal, 30357, 70, 25269, 0 }, -- Revenge (Rank 8)
    { Race.Universal, 46845, 71, 25208, 0 }, -- Rend (Rank 9)
    { Race.Universal, 64382, 71, -1, 0 }, -- Shattering Throw
    { Race.Universal, 47449, 72, 30324, 0 }, -- Heroic Strike (Rank 12)
    { Race.Universal, 47519, 72, 25231, 0 }, -- Cleave (Rank 7)
    { Race.Universal, 47470, 73, 25236, 0 }, -- Execute (Rank 8)
    { Race.Universal, 47501, 73, 25264, 0 }, -- Thunder Clap (Rank 8)
    { Race.Universal, 47439, 74, 469, 0 }, -- Commanding Shout (Rank 2)
    { Race.Universal, 47474, 74, 25242, 0 }, -- Slam (Rank 7)
    { Race.Universal, 47487, 75, 30356, 0 }, -- Shield Slam (Rank 7)
    { Race.Universal, 55694, 75, -1, 0 }, -- Enraged Regeneration
    { Race.Universal, 47450, 76, 47449, 0 }, -- Heroic Strike (Rank 13)
    { Race.Universal, 47465, 76, 46845, 0 }, -- Rend (Rank 10)
    { Race.Universal, 47520, 77, 47519, 0 }, -- Cleave (Rank 8)
    { Race.Universal, 47436, 78, 2048, 0 }, -- Battle Shout (Rank 9)
    { Race.Universal, 47502, 78, 47501, 0 }, -- Thunder Clap (Rank 9)
    { Race.Universal, 47437, 79, 25203, 0 }, -- Demoralizing Shout (Rank 8)
    { Race.Universal, 47475, 79, 47474, 0 }, -- Slam (Rank 8)
    { Race.Universal, 47440, 80, 47439, 0 }, -- Commanding Shout (Rank 3)
    { Race.Universal, 47471, 80, 47470, 0 }, -- Execute (Rank 9)
    { Race.Universal, 47488, 80, 47487, 0 }, -- Shield Slam (Rank 8)
    { Race.Universal, 57755, 80, -1, 0 }, -- Heroic Throw
    { Race.Universal, 57823, 80, 30357, 0 }}, -- Revenge (Rank 9)
    -- Paladin
    {{ Race.Universal, 465, 1, -1, 0 }, -- Devotion Aura (Rank 1)
    { Race.Universal, 635, 1, -1, 0 }, -- Holy Light (Rank 1)
    { Race.Universal, 21084, 1, -1, 0 }, -- Seal of Righteousness
    { Race.Universal, 19740, 4, -1, 0 }, -- Blessing of Might (Rank 1)
    { Race.Universal, 20271, 4, -1, 0 }, -- Judgement of Light
    { Race.Universal, 498, 6, -1, 0 }, -- Divine Protection
    { Race.Universal, 639, 6, 635, 0 }, -- Holy Light (Rank 2)
    { Race.Universal, 853, 8, -1, 0 }, -- Hammer of Justice (Rank 1)
    { Race.Universal, 1152, 8, -1, 0 }, -- Purify
    { Race.Universal, 633, 10, -1, 0 }, -- Lay on Hands (Rank 1)
    { Race.Universal, 1022, 10, -1, 0 }, -- Hand of Protection (Rank 1)
    { Race.Universal, 10290, 10, 465, 0 }, -- Devotion Aura (Rank 2)
    { Race.Universal, 7328, 12, -1, 0 }, -- Redemption (Rank 1)
    { Race.Universal, 19834, 12, 19740, 0 }, -- Blessing of Might (Rank 2)
    { Race.Universal, 53408, 12, -1, 0 }, -- Judgement of Wisdom
    { Race.Universal, 647, 14, 639, 0 }, -- Holy Light (Rank 3)
    { Race.Universal, 19742, 14, -1, 0 }, -- Blessing of Wisdom (Rank 1)
    { Race.Universal, 31789, 14, -1, 0 }, -- Righteous Defense
    { Race.Universal, 7294, 16, -1, 0 }, -- Retribution Aura (Rank 1)
    { Race.Universal, 25780, 16, -1, 0 }, -- Righteous Fury
    { Race.Universal, 62124, 16, -1, 0 }, -- Hand of Reckoning
    { Race.Universal, 1044, 18, -1, 0 }, -- Hand of Freedom
    { Race.Universal, 643, 20, 10290, 0 }, -- Devotion Aura (Rank 3)
    { Race.Universal, 879, 20, -1, 0 }, -- Exorcism (Rank 1)
    { Race.Universal, 5502, 20, -1, 0 }, -- Sense Undead
    { Race.Universal, 19750, 20, -1, 0 }, -- Flash of Light (Rank 1)
    { Race.Universal, 20217, 20, -1, 0 }, -- Blessing of Kings
    { Race.Universal, 26573, 20, -1, 0 }, -- Consecration (Rank 1)
    { Race.Universal, 1026, 22, 647, 0 }, -- Holy Light (Rank 4)
    { Race.Universal, 19746, 22, -1, 0 }, -- Concentration Aura
    { Race.Universal, 19835, 22, 19834, 0 }, -- Blessing of Might (Rank 3)
    { Race.Universal, 20164, 22, -1, 0 }, -- Seal of Justice
    { Race.Universal, 5588, 24, 853, 0 }, -- Hammer of Justice (Rank 2)
    { Race.Universal, 5599, 24, 1022, 0 }, -- Hand of Protection (Rank 2)
    { Race.Universal, 10322, 24, 7328, 0 }, -- Redemption (Rank 2)
    { Race.Universal, 10326, 24, -1, 0 }, -- Turn Evil
    { Race.Universal, 19850, 24, 19742, 0 }, -- Blessing of Wisdom (Rank 2)
    { Race.Universal, 1038, 26, -1, 0 }, -- Hand of Salvation
    { Race.Universal, 10298, 26, 7294, 0 }, -- Retribution Aura (Rank 2)
    { Race.Universal, 19939, 26, 19750, 0 }, -- Flash of Light (Rank 2)
    { Race.Universal, 5614, 28, 879, 0 }, -- Exorcism (Rank 2)
    { Race.Universal, 19876, 28, -1, 0 }, -- Shadow Resistance Aura (Rank 1)
    { Race.Universal, 53407, 28, -1, 0 }, -- Judgement of Justice
    { Race.Universal, 1042, 30, 1026, 0 }, -- Holy Light (Rank 5)
    { Race.Universal, 2800, 30, 633, 0 }, -- Lay on Hands (Rank 2)
    { Race.Universal, 10291, 30, 643, 0 }, -- Devotion Aura (Rank 4)
    { Race.Universal, 19752, 30, -1, 0 }, -- Divine Intervention
    { Race.Universal, 20116, 30, 26573, 0 }, -- Consecration (Rank 2)
    { Race.Universal, 20165, 30, -1, 0 }, -- Seal of Light
    { Race.Universal, 19836, 32, 19835, 0 }, -- Blessing of Might (Rank 4)
    { Race.Universal, 19888, 32, -1, 0 }, -- Frost Resistance Aura (Rank 1)
    { Race.Universal, 642, 34, -1, 0 }, -- Divine Shield
    { Race.Universal, 19852, 34, 19850, 0 }, -- Blessing of Wisdom (Rank 3)
    { Race.Universal, 19940, 34, 19939, 0 }, -- Flash of Light (Rank 3)
    { Race.Universal, 5615, 36, 5614, 0 }, -- Exorcism (Rank 3)
    { Race.Universal, 10299, 36, 10298, 0 }, -- Retribution Aura (Rank 3)
    { Race.Universal, 10324, 36, 10322, 0 }, -- Redemption (Rank 3)
    { Race.Universal, 19891, 36, -1, 0 }, -- Fire Resistance Aura (Rank 1)
    { Race.Universal, 3472, 38, 1042, 0 }, -- Holy Light (Rank 6)
    { Race.Universal, 10278, 38, 5599, 0 }, -- Hand of Protection (Rank 3)
    { Race.Universal, 20166, 38, -1, 0 }, -- Seal of Wisdom
    { Race.Universal, 1032, 40, 10291, 0 }, -- Devotion Aura (Rank 5)
    { Race.Universal, 5589, 40, 5588, 0 }, -- Hammer of Justice (Rank 3)
    { Race.Universal, 19895, 40, 19876, 0 }, -- Shadow Resistance Aura (Rank 2)
    { Race.Universal, 20922, 40, 20116, 0 }, -- Consecration (Rank 3)
    { Race.Universal, 4987, 42, -1, 0 }, -- Cleanse
    { Race.Universal, 19837, 42, 19836, 0 }, -- Blessing of Might (Rank 5)
    { Race.Universal, 19941, 42, 19940, 0 }, -- Flash of Light (Rank 4)
    { Race.Universal, 10312, 44, 5615, 0 }, -- Exorcism (Rank 4)
    { Race.Universal, 19853, 44, 19852, 0 }, -- Blessing of Wisdom (Rank 4)
    { Race.Universal, 19897, 44, 19888, 0 }, -- Frost Resistance Aura (Rank 2)
    { Race.Universal, 24275, 44, -1, 0 }, -- Hammer of Wrath (Rank 1)
    { Race.Universal, 6940, 46, -1, 0 }, -- Hand of Sacrifice
    { Race.Universal, 10300, 46, 10299, 0 }, -- Retribution Aura (Rank 4)
    { Race.Universal, 10328, 46, 3472, 0 }, -- Holy Light (Rank 7)
    { Race.Universal, 19899, 48, 19891, 0 }, -- Fire Resistance Aura (Rank 2)
    { Race.Universal, 20772, 48, 10324, 0 }, -- Redemption (Rank 4)
    { Race.Universal, 2812, 50, -1, 0 }, -- Holy Wrath (Rank 1)
    { Race.Universal, 10292, 50, 1032, 0 }, -- Devotion Aura (Rank 6)
    { Race.Universal, 10310, 50, 2800, 0 }, -- Lay on Hands (Rank 3)
    { Race.Universal, 19942, 50, 19941, 0 }, -- Flash of Light (Rank 5)
    { Race.Universal, 20923, 50, 20922, 0 }, -- Consecration (Rank 4)
    { Race.Universal, 10313, 52, 10312, 0 }, -- Exorcism (Rank 5)
    { Race.Universal, 19838, 52, 19837, 0 }, -- Blessing of Might (Rank 6)
    { Race.Universal, 19896, 52, 19895, 0 }, -- Shadow Resistance Aura (Rank 3)
    { Race.Universal, 24274, 52, 24275, 0 }, -- Hammer of Wrath (Rank 2)
    { Race.Universal, 25782, 52, -1, 0 }, -- Greater Blessing of Might (Rank 1)
    { Race.Universal, 10308, 54, 5589, 0 }, -- Hammer of Justice (Rank 4)
    { Race.Universal, 10329, 54, 10328, 0 }, -- Holy Light (Rank 8)
    { Race.Universal, 19854, 54, 19853, 0 }, -- Blessing of Wisdom (Rank 5)
    { Race.Universal, 25894, 54, -1, 0 }, -- Greater Blessing of Wisdom (Rank 1)
    { Race.Universal, 10301, 56, 10300, 0 }, -- Retribution Aura (Rank 5)
    { Race.Universal, 19898, 56, 19897, 0 }, -- Frost Resistance Aura (Rank 3)
    { Race.Universal, 19943, 58, 19942, 0 }, -- Flash of Light (Rank 6)
    { Race.Universal, 10293, 60, 10292, 0 }, -- Devotion Aura (Rank 7)
    { Race.Universal, 10314, 60, 10313, 0 }, -- Exorcism (Rank 6)
    { Race.Universal, 10318, 60, 2812, 0 }, -- Holy Wrath (Rank 2)
    { Race.Universal, 19900, 60, 19899, 0 }, -- Fire Resistance Aura (Rank 3)
    { Race.Universal, 20773, 60, 20772, 0 }, -- Redemption (Rank 5)
    { Race.Universal, 20924, 60, 20923, 0 }, -- Consecration (Rank 5)
    { Race.Universal, 24239, 60, 24274, 0 }, -- Hammer of Wrath (Rank 3)
    { Race.Universal, 25290, 60, 19854, 0 }, -- Blessing of Wisdom (Rank 6)
    { Race.Universal, 25291, 60, 19838, 0 }, -- Blessing of Might (Rank 7)
    { Race.Universal, 25292, 60, 10329, 0 }, -- Holy Light (Rank 9)
    { Race.Universal, 25898, 60, -1, 0 }, -- Greater Blessing of Kings
    { Race.Universal, 25916, 60, 25782, 0 }, -- Greater Blessing of Might (Rank 2)
    { Race.Universal, 25918, 60, 25894, 0 }, -- Greater Blessing of Wisdom (Rank 2)
    { Race.Universal, 27135, 62, 25292, 0 }, -- Holy Light (Rank 10)
    { Race.Universal, 32223, 62, -1, 0 }, -- Crusader Aura
    { Race.Universal, 27151, 63, 19896, 0 }, -- Shadow Resistance Aura (Rank 4)
    { Race.Draenei, 31801, 64, -1, 0 }, -- Seal of Vengeance
    { Race.Dwarf, 31801, 64, -1, 0 }, -- Seal of Vengeance
    { Race.Human, 31801, 64, -1, 0 }, -- Seal of Vengeance
    { Race.Universal, 27142, 65, 25290, 0 }, -- Blessing of Wisdom (Rank 7)
    { Race.Universal, 27143, 65, 25918, 0 }, -- Greater Blessing of Wisdom (Rank 3)
    { Race.Universal, 27137, 66, 19943, 0 }, -- Flash of Light (Rank 7)
    { Race.Universal, 27150, 66, 10301, 0 }, -- Retribution Aura (Rank 6)
    { Race.BloodElf, 53736, 66, -1, 0 }, -- Seal of Corruption
    { Race.Universal, 27138, 68, 10314, 0 }, -- Exorcism (Rank 7)
    { Race.Universal, 27152, 68, 19898, 0 }, -- Frost Resistance Aura (Rank 4)
    { Race.Universal, 27180, 68, 24239, 0 }, -- Hammer of Wrath (Rank 4)
    { Race.Universal, 27139, 69, 10318, 0 }, -- Holy Wrath (Rank 3)
    { Race.Universal, 27154, 69, 10310, 0 }, -- Lay on Hands (Rank 4)
    { Race.Universal, 27136, 70, 27135, 0 }, -- Holy Light (Rank 11)
    { Race.Universal, 27140, 70, 25291, 0 }, -- Blessing of Might (Rank 8)
    { Race.Universal, 27141, 70, 25916, 0 }, -- Greater Blessing of Might (Rank 3)
    { Race.Universal, 27149, 70, 10293, 0 }, -- Devotion Aura (Rank 8)
    { Race.Universal, 27153, 70, 19900, 0 }, -- Fire Resistance Aura (Rank 4)
    { Race.Universal, 27173, 70, 20924, 0 }, -- Consecration (Rank 6)
    { Race.Universal, 31884, 70, -1, 0 }, -- Avenging Wrath
    { Race.Universal, 48935, 71, 27142, 0 }, -- Blessing of Wisdom (Rank 8)
    { Race.Universal, 48937, 71, 27143, 0 }, -- Greater Blessing of Wisdom (Rank 4)
    { Race.Universal, 54428, 71, -1, 0 }, -- Divine Plea
    { Race.Universal, 48816, 72, 27139, 0 }, -- Holy Wrath (Rank 4)
    { Race.Universal, 48949, 72, 20773, 0 }, -- Redemption (Rank 6)
    { Race.Universal, 48800, 73, 27138, 0 }, -- Exorcism (Rank 8)
    { Race.Universal, 48931, 73, 27140, 0 }, -- Blessing of Might (Rank 9)
    { Race.Universal, 48933, 73, 27141, 0 }, -- Greater Blessing of Might (Rank 4)
    { Race.Universal, 48784, 74, 27137, 0 }, -- Flash of Light (Rank 8)
    { Race.Universal, 48805, 74, 27180, 0 }, -- Hammer of Wrath (Rank 5)
    { Race.Universal, 48941, 74, 27149, 0 }, -- Devotion Aura (Rank 9)
    { Race.Universal, 48781, 75, 27136, 0 }, -- Holy Light (Rank 12)
    { Race.Universal, 48818, 75, 27173, 0 }, -- Consecration (Rank 7)
    { Race.Universal, 53600, 75, -1, 0 }, -- Shield of Righteousness (Rank 1)
    { Race.Universal, 48943, 76, 27151, 0 }, -- Shadow Resistance Aura (Rank 5)
    { Race.Universal, 54043, 76, 27150, 0 }, -- Retribution Aura (Rank 7)
    { Race.Universal, 48936, 77, 48935, 0 }, -- Blessing of Wisdom (Rank 9)
    { Race.Universal, 48938, 77, 48937, 0 }, -- Greater Blessing of Wisdom (Rank 5)
    { Race.Universal, 48945, 77, 27152, 0 }, -- Frost Resistance Aura (Rank 5)
    { Race.Universal, 48788, 78, 27154, 0 }, -- Lay on Hands (Rank 5)
    { Race.Universal, 48817, 78, 48816, 0 }, -- Holy Wrath (Rank 5)
    { Race.Universal, 48947, 78, 27153, 0 }, -- Fire Resistance Aura (Rank 5)
    { Race.Universal, 48785, 79, 48784, 0 }, -- Flash of Light (Rank 9)
    { Race.Universal, 48801, 79, 48800, 0 }, -- Exorcism (Rank 9)
    { Race.Universal, 48932, 79, 48931, 0 }, -- Blessing of Might (Rank 10)
    { Race.Universal, 48934, 79, 48933, 0 }, -- Greater Blessing of Might (Rank 5)
    { Race.Universal, 48942, 79, 48941, 0 }, -- Devotion Aura (Rank 10)
    { Race.Universal, 48950, 79, 48949, 0 }, -- Redemption (Rank 7)
    { Race.Universal, 48782, 80, 48781, 0 }, -- Holy Light (Rank 13)
    { Race.Universal, 48806, 80, 48805, 0 }, -- Hammer of Wrath (Rank 6)
    { Race.Universal, 48819, 80, 48818, 0 }, -- Consecration (Rank 8)
    { Race.Universal, 53601, 80, -1, 0 }, -- Sacred Shield (Rank 1)
    { Race.Universal, 61411, 80, 53600, 0 }}, -- Shield of Righteousness (Rank 2)
    -- Hunter
    {{ Race.Universal, 1494, 1, -1, 0 }, -- Track Beasts
    { Race.Universal, 2973, 1, -1, 0 }, -- Raptor Strike (Rank 1)
    { Race.Universal, 1978, 4, -1, 0 }, -- Serpent Sting (Rank 1)
    { Race.Universal, 13163, 4, -1, 0 }, -- Aspect of the Monkey
    { Race.Universal, 1130, 6, -1, 0 }, -- Hunter's Mark (Rank 1)
    { Race.Universal, 3044, 6, -1, 0 }, -- Arcane Shot (Rank 1)
    { Race.Universal, 5116, 8, -1, 0 }, -- Concussive Shot
    { Race.Universal, 14260, 8, 2973, 0 }, -- Raptor Strike (Rank 2)
    { Race.Universal, 883, 10, -1, 1 }, -- Call Pet
    { Race.Universal, 982, 10, 883, 1 }, -- Revive Pet
    { Race.Universal, 1515, 10, 883, 1 }, -- Tame Beast
    { Race.Universal, 2641, 10, 883, 1 }, -- Dismiss Pet
    { Race.Universal, 6991, 10, 883, 1 }, -- Feed Pet
    { Race.Universal, 13165, 10, -1, 0 }, -- Aspect of the Hawk (Rank 1)
    { Race.Universal, 13549, 10, 1978, 0 }, -- Serpent Sting (Rank 2)
    { Race.Universal, 19883, 10, -1, 0 }, -- Track Humanoids
    { Race.Universal, 136, 12, -1, 0 }, -- Mend Pet (Rank 1)
    { Race.Universal, 2974, 12, -1, 0 }, -- Wing Clip
    { Race.Universal, 14281, 12, 3044, 0 }, -- Arcane Shot (Rank 2)
    { Race.Universal, 20736, 12, -1, 0 }, -- Distracting Shot (Rank 1)
    { Race.Universal, 1002, 14, -1, 0 }, -- Eyes of the Beast
    { Race.Universal, 1513, 14, -1, 0 }, -- Scare Beast (Rank 1)
    { Race.Universal, 6197, 14, -1, 0 }, -- Eagle Eye
    { Race.Universal, 1495, 16, -1, 0 }, -- Mongoose Bite (Rank 1)
    { Race.Universal, 5118, 16, -1, 0 }, -- Aspect of the Cheetah
    { Race.Universal, 13795, 16, -1, 0 }, -- Immolation Trap (Rank 1)
    { Race.Universal, 14261, 16, 14260, 0 }, -- Raptor Strike (Rank 3)
    { Race.Universal, 2643, 18, -1, 0 }, -- Multi-Shot (Rank 1)
    { Race.Universal, 13550, 18, 13549, 0 }, -- Serpent Sting (Rank 3)
    { Race.Universal, 14318, 18, 13165, 0 }, -- Aspect of the Hawk (Rank 2)
    { Race.Universal, 19884, 18, -1, 0 }, -- Track Undead
    { Race.Universal, 781, 20, -1, 0 }, -- Disengage
    { Race.Universal, 1499, 20, -1, 0 }, -- Freezing Trap (Rank 1)
    { Race.Universal, 3111, 20, 136, 0 }, -- Mend Pet (Rank 2)
    { Race.Universal, 14282, 20, 14281, 0 }, -- Arcane Shot (Rank 3)
    { Race.Universal, 34074, 20, -1, 0 }, -- Aspect of the Viper
    { Race.Universal, 3043, 22, -1, 0 }, -- Scorpid Sting
    { Race.Universal, 14323, 22, 1130, 0 }, -- Hunter's Mark (Rank 2)
    { Race.Universal, 1462, 24, -1, 0 }, -- Beast Lore
    { Race.Universal, 14262, 24, 14261, 0 }, -- Raptor Strike (Rank 4)
    { Race.Universal, 19885, 24, -1, 0 }, -- Track Hidden
    { Race.Universal, 3045, 26, -1, 0 }, -- Rapid Fire
    { Race.Universal, 13551, 26, 13550, 0 }, -- Serpent Sting (Rank 4)
    { Race.Universal, 14302, 26, 13795, 0 }, -- Immolation Trap (Rank 2)
    { Race.Universal, 19880, 26, -1, 0 }, -- Track Elementals
    { Race.Universal, 3661, 28, 3111, 0 }, -- Mend Pet (Rank 3)
    { Race.Universal, 13809, 28, -1, 0 }, -- Frost Trap
    { Race.Universal, 14283, 28, 14282, 0 }, -- Arcane Shot (Rank 4)
    { Race.Universal, 14319, 28, 14318, 0 }, -- Aspect of the Hawk (Rank 3)
    { Race.Universal, 5384, 30, -1, 0 }, -- Feign Death
    { Race.Universal, 13161, 30, -1, 0 }, -- Aspect of the Beast
    { Race.Universal, 14269, 30, 1495, 0 }, -- Mongoose Bite (Rank 2)
    { Race.Universal, 14288, 30, 2643, 0 }, -- Multi-Shot (Rank 2)
    { Race.Universal, 14326, 30, 1513, 0 }, -- Scare Beast (Rank 2)
    { Race.Universal, 1543, 32, -1, 0 }, -- Flare
    { Race.Universal, 14263, 32, 14262, 0 }, -- Raptor Strike (Rank 5)
    { Race.Universal, 19878, 32, -1, 0 }, -- Track Demons
    { Race.Universal, 13552, 34, 13551, 0 }, -- Serpent Sting (Rank 5)
    { Race.Universal, 13813, 34, -1, 0 }, -- Explosive Trap (Rank 1)
    { Race.Universal, 3034, 36, -1, 0 }, -- Viper Sting
    { Race.Universal, 3662, 36, 3661, 0 }, -- Mend Pet (Rank 4)
    { Race.Universal, 14284, 36, 14283, 0 }, -- Arcane Shot (Rank 5)
    { Race.Universal, 14303, 36, 14302, 0 }, -- Immolation Trap (Rank 3)
    { Race.Universal, 14320, 38, 14319, 0 }, -- Aspect of the Hawk (Rank 4)
    { Race.Universal, 1510, 40, -1, 0 }, -- Volley (Rank 1)
    { Race.Universal, 13159, 40, -1, 0 }, -- Aspect of the Pack
    { Race.Universal, 14264, 40, 14263, 0 }, -- Raptor Strike (Rank 6)
    { Race.Universal, 14310, 40, 1499, 0 }, -- Freezing Trap (Rank 2)
    { Race.Universal, 14324, 40, 14323, 0 }, -- Hunter's Mark (Rank 3)
    { Race.Universal, 19882, 40, -1, 0 }, -- Track Giants
    { Race.Universal, 13553, 42, 13552, 0 }, -- Serpent Sting (Rank 6)
    { Race.Universal, 14289, 42, 14288, 0 }, -- Multi-Shot (Rank 3)
    { Race.Universal, 13542, 44, 3662, 0 }, -- Mend Pet (Rank 5)
    { Race.Universal, 14270, 44, 14269, 0 }, -- Mongoose Bite (Rank 3)
    { Race.Universal, 14285, 44, 14284, 0 }, -- Arcane Shot (Rank 6)
    { Race.Universal, 14316, 44, 13813, 0 }, -- Explosive Trap (Rank 2)
    { Race.Universal, 14304, 46, 14303, 0 }, -- Immolation Trap (Rank 4)
    { Race.Universal, 14327, 46, 14326, 0 }, -- Scare Beast (Rank 3)
    { Race.Universal, 20043, 46, -1, 0 }, -- Aspect of the Wild (Rank 1)
    { Race.Universal, 14265, 48, 14264, 0 }, -- Raptor Strike (Rank 7)
    { Race.Universal, 14321, 48, 14320, 0 }, -- Aspect of the Hawk (Rank 5)
    { Race.Universal, 13554, 50, 13553, 0 }, -- Serpent Sting (Rank 7)
    { Race.Universal, 14294, 50, 1510, 0 }, -- Volley (Rank 2)
    { Race.Universal, 19879, 50, -1, 0 }, -- Track Dragonkin
    { Race.Universal, 56641, 50, -1, 0 }, -- Steady Shot (Rank 1)
    { Race.Universal, 13543, 52, 13542, 0 }, -- Mend Pet (Rank 6)
    { Race.Universal, 14286, 52, 14285, 0 }, -- Arcane Shot (Rank 7)
    { Race.Universal, 14290, 54, 14289, 0 }, -- Multi-Shot (Rank 4)
    { Race.Universal, 14317, 54, 14316, 0 }, -- Explosive Trap (Rank 3)
    { Race.Universal, 14266, 56, 14265, 0 }, -- Raptor Strike (Rank 8)
    { Race.Universal, 14305, 56, 14304, 0 }, -- Immolation Trap (Rank 5)
    { Race.Universal, 20190, 56, 20043, 0 }, -- Aspect of the Wild (Rank 2)
    { Race.Universal, 13555, 58, 13554, 0 }, -- Serpent Sting (Rank 8)
    { Race.Universal, 14271, 58, 14270, 0 }, -- Mongoose Bite (Rank 4)
    { Race.Universal, 14295, 58, 14294, 0 }, -- Volley (Rank 3)
    { Race.Universal, 14322, 58, 14321, 0 }, -- Aspect of the Hawk (Rank 6)
    { Race.Universal, 14325, 58, 14324, 0 }, -- Hunter's Mark (Rank 4)
    { Race.Universal, 13544, 60, 13543, 0 }, -- Mend Pet (Rank 7)
    { Race.Universal, 14287, 60, 14286, 0 }, -- Arcane Shot (Rank 8)
    { Race.Universal, 14311, 60, 14310, 0 }, -- Freezing Trap (Rank 3)
    { Race.Universal, 19263, 60, -1, 0 }, -- Deterrence
    { Race.Universal, 19801, 60, -1, 0 }, -- Tranquilizing Shot
    { Race.Universal, 25294, 60, 14290, 0 }, -- Multi-Shot (Rank 5)
    { Race.Universal, 25295, 60, 13555, 0 }, -- Serpent Sting (Rank 9)
    { Race.Universal, 25296, 60, 14322, 0 }, -- Aspect of the Hawk (Rank 7)
    { Race.Universal, 27025, 61, 14317, 0 }, -- Explosive Trap (Rank 4)
    { Race.Universal, 34120, 62, 56641, 0 }, -- Steady Shot (Rank 2)
    { Race.Universal, 27014, 63, 14266, 0 }, -- Raptor Strike (Rank 9)
    { Race.Universal, 27023, 65, 14305, 0 }, -- Immolation Trap (Rank 6)
    { Race.Universal, 34026, 66, -1, 0 }, -- Kill Command
    { Race.Universal, 27016, 67, 25295, 0 }, -- Serpent Sting (Rank 10)
    { Race.Universal, 27021, 67, 25294, 0 }, -- Multi-Shot (Rank 6)
    { Race.Universal, 27022, 67, 14295, 0 }, -- Volley (Rank 4)
    { Race.Universal, 27044, 68, 25296, 0 }, -- Aspect of the Hawk (Rank 8)
    { Race.Universal, 27045, 68, 20190, 0 }, -- Aspect of the Wild (Rank 3)
    { Race.Universal, 27046, 68, 13544, 0 }, -- Mend Pet (Rank 8)
    { Race.Universal, 34600, 68, -1, 0 }, -- Snake Trap
    { Race.Universal, 27019, 69, 14287, 0 }, -- Arcane Shot (Rank 9)
    { Race.Universal, 34477, 70, -1, 0 }, -- Misdirection
    { Race.Universal, 36916, 70, 14271, 0 }, -- Mongoose Bite (Rank 5)
    { Race.Universal, 48995, 71, 27014, 0 }, -- Raptor Strike (Rank 10)
    { Race.Universal, 49051, 71, 34120, 0 }, -- Steady Shot (Rank 3)
    { Race.Universal, 49066, 71, 27025, 0 }, -- Explosive Trap (Rank 5)
    { Race.Universal, 53351, 71, -1, 0 }, -- Kill Shot (Rank 1)
    { Race.Universal, 49055, 72, 27023, 0 }, -- Immolation Trap (Rank 7)
    { Race.Universal, 49000, 73, 27016, 0 }, -- Serpent Sting (Rank 11)
    { Race.Universal, 49044, 73, 27019, 0 }, -- Arcane Shot (Rank 10)
    { Race.Universal, 48989, 74, 27046, 0 }, -- Mend Pet (Rank 9)
    { Race.Universal, 49047, 74, 27021, 0 }, -- Multi-Shot (Rank 7)
    { Race.Universal, 58431, 74, 27022, 0 }, -- Volley (Rank 5)
    { Race.Universal, 61846, 74, -1, 0 }, -- Aspect of the Dragonhawk (Rank 1)
    { Race.Universal, 53271, 75, -1, 0 }, -- Master's Call
    { Race.Universal, 53338, 75, 14325, 0 }, -- Hunter's Mark (Rank 5)
    { Race.Universal, 61005, 75, 53351, 0 }, -- Kill Shot (Rank 2)
    { Race.Universal, 49071, 76, 27045, 0 }, -- Aspect of the Wild (Rank 4)
    { Race.Universal, 48996, 77, 48995, 0 }, -- Raptor Strike (Rank 11)
    { Race.Universal, 49052, 77, 49051, 0 }, -- Steady Shot (Rank 4)
    { Race.Universal, 49067, 77, 49066, 0 }, -- Explosive Trap (Rank 6)
    { Race.Universal, 49056, 78, 49055, 0 }, -- Immolation Trap (Rank 8)
    { Race.Universal, 49001, 79, 49000, 0 }, -- Serpent Sting (Rank 12)
    { Race.Universal, 49045, 79, 49044, 0 }, -- Arcane Shot (Rank 11)
    { Race.Universal, 48990, 80, 48989, 0 }, -- Mend Pet (Rank 10)
    { Race.Universal, 49048, 80, -1, 0 }, -- Multi-Shot (Rank 8)
    { Race.Universal, 53339, 80, 36916, 0 }, -- Mongoose Bite (Rank 6)
    { Race.Universal, 58434, 80, 58431, 0 }, -- Volley (Rank 6)
    { Race.Universal, 60192, 80, -1, 0 }, -- Freezing Arrow (Rank 1)
    { Race.Universal, 61006, 80, 61005, 0 }, -- Kill Shot (Rank 3)
    { Race.Universal, 61847, 80, 61846, 0 }, -- Aspect of the Dragonhawk (Rank 2)
    { Race.Universal, 62757, 80, -1, 0 }}, -- Call Stabled Pet
    -- Rogue
    {{ Race.Universal, 1752, 1, -1, 0 }, -- Sinister Strike (Rank 1)
    { Race.Universal, 1784, 1, -1, 0 }, -- Stealth
    { Race.Universal, 1804, 1, -1, 0 }, -- Pick Lock
    { Race.Universal, 2098, 1, -1, 0 }, -- Eviscerate (Rank 1)
    { Race.Universal, 53, 4, -1, 0 }, -- Backstab (Rank 1)
    { Race.Universal, 921, 4, -1, 0 }, -- Pick Pocket
    { Race.Universal, 1757, 6, 1752, 0 }, -- Sinister Strike (Rank 2)
    { Race.Universal, 1776, 6, -1, 0 }, -- Gouge
    { Race.Universal, 5277, 8, -1, 0 }, -- Evasion (Rank 1)
    { Race.Universal, 6760, 8, 2098, 0 }, -- Eviscerate (Rank 2)
    { Race.Universal, 2983, 10, -1, 0 }, -- Sprint (Rank 1)
    { Race.Universal, 5171, 10, -1, 0 }, -- Slice and Dice (Rank 1)
    { Race.Universal, 6770, 10, -1, 0 }, -- Sap (Rank 1)
    { Race.Universal, 1766, 12, -1, 0 }, -- Kick
    { Race.Universal, 2589, 12, 53, 0 }, -- Backstab (Rank 2)
    { Race.Universal, 703, 14, -1, 0 }, -- Garrote (Rank 1)
    { Race.Universal, 1758, 14, 1757, 0 }, -- Sinister Strike (Rank 3)
    { Race.Universal, 8647, 14, -1, 0 }, -- Expose Armor
    { Race.Universal, 1966, 16, -1, 0 }, -- Feint (Rank 1)
    { Race.Universal, 6761, 16, 6760, 0 }, -- Eviscerate (Rank 3)
    { Race.Universal, 8676, 18, -1, 0 }, -- Ambush (Rank 1)
    { Race.Universal, 1943, 20, -1, 0 }, -- Rupture (Rank 1)
    { Race.Universal, 2590, 20, 2589, 0 }, -- Backstab (Rank 3)
    { Race.Universal, 51722, 20, -1, 0 }, -- Dismantle
    { Race.Universal, 1725, 22, -1, 0 }, -- Distract
    { Race.Universal, 1759, 22, 1758, 0 }, -- Sinister Strike (Rank 4)
    { Race.Universal, 1856, 22, -1, 0 }, -- Vanish (Rank 1)
    { Race.Universal, 8631, 22, 703, 0 }, -- Garrote (Rank 2)
    { Race.Universal, 2836, 24, -1, 0 }, -- Detect Traps (Passive)
    { Race.Universal, 6762, 24, 6761, 0 }, -- Eviscerate (Rank 4)
    { Race.Universal, 1833, 26, -1, 0 }, -- Cheap Shot
    { Race.Universal, 8724, 26, 8676, 0 }, -- Ambush (Rank 2)
    { Race.Universal, 2070, 28, 6770, 0 }, -- Sap (Rank 2)
    { Race.Universal, 2591, 28, 2590, 0 }, -- Backstab (Rank 4)
    { Race.Universal, 6768, 28, 1966, 0 }, -- Feint (Rank 2)
    { Race.Universal, 8639, 28, 1943, 0 }, -- Rupture (Rank 2)
    { Race.Universal, 408, 30, -1, 0 }, -- Kidney Shot (Rank 1)
    { Race.Universal, 1760, 30, 1759, 0 }, -- Sinister Strike (Rank 5)
    { Race.Universal, 1842, 30, -1, 0 }, -- Disarm Trap
    { Race.Universal, 8632, 30, 8631, 0 }, -- Garrote (Rank 3)
    { Race.Universal, 8623, 32, 6762, 0 }, -- Eviscerate (Rank 5)
    { Race.Universal, 2094, 34, -1, 0 }, -- Blind
    { Race.Universal, 8696, 34, 2983, 0 }, -- Sprint (Rank 2)
    { Race.Universal, 8725, 34, 8724, 0 }, -- Ambush (Rank 3)
    { Race.Universal, 8640, 36, 8639, 0 }, -- Rupture (Rank 3)
    { Race.Universal, 8721, 36, 2591, 0 }, -- Backstab (Rank 5)
    { Race.Universal, 8621, 38, 1760, 0 }, -- Sinister Strike (Rank 6)
    { Race.Universal, 8633, 38, 8632, 0 }, -- Garrote (Rank 4)
    { Race.Universal, 1860, 40, -1, 0 }, -- Safe Fall (Passive)
    { Race.Universal, 8624, 40, 8623, 0 }, -- Eviscerate (Rank 6)
    { Race.Universal, 8637, 40, 6768, 0 }, -- Feint (Rank 3)
    { Race.Universal, 1857, 42, 1856, 0 }, -- Vanish (Rank 2)
    { Race.Universal, 6774, 42, 5171, 0 }, -- Slice and Dice (Rank 2)
    { Race.Universal, 11267, 42, 8725, 0 }, -- Ambush (Rank 4)
    { Race.Universal, 11273, 44, 8640, 0 }, -- Rupture (Rank 4)
    { Race.Universal, 11279, 44, 8721, 0 }, -- Backstab (Rank 6)
    { Race.Universal, 11289, 46, 8633, 0 }, -- Garrote (Rank 5)
    { Race.Universal, 11293, 46, 8621, 0 }, -- Sinister Strike (Rank 7)
    { Race.Universal, 11297, 48, 2070, 0 }, -- Sap (Rank 3)
    { Race.Universal, 11299, 48, 8624, 0 }, -- Eviscerate (Rank 7)
    { Race.Universal, 8643, 50, 408, 0 }, -- Kidney Shot (Rank 2)
    { Race.Universal, 11268, 50, 11267, 0 }, -- Ambush (Rank 5)
    { Race.Universal, 26669, 50, 5277, 0 }, -- Evasion (Rank 2)
    { Race.Universal, 11274, 52, 11273, 0 }, -- Rupture (Rank 5)
    { Race.Universal, 11280, 52, 11279, 0 }, -- Backstab (Rank 7)
    { Race.Universal, 11303, 52, 8637, 0 }, -- Feint (Rank 4)
    { Race.Universal, 11290, 54, 11289, 0 }, -- Garrote (Rank 6)
    { Race.Universal, 11294, 54, 11293, 0 }, -- Sinister Strike (Rank 8)
    { Race.Universal, 11300, 56, 11299, 0 }, -- Eviscerate (Rank 8)
    { Race.Universal, 11269, 58, 11268, 0 }, -- Ambush (Rank 6)
    { Race.Universal, 11305, 58, 8696, 0 }, -- Sprint (Rank 3)
    { Race.Universal, 11275, 60, 11274, 0 }, -- Rupture (Rank 6)
    { Race.Universal, 11281, 60, 11280, 0 }, -- Backstab (Rank 8)
    { Race.Universal, 25300, 60, 11281, 0 }, -- Backstab (Rank 9)
    { Race.Universal, 25302, 60, 11303, 0 }, -- Feint (Rank 5)
    { Race.Universal, 31016, 60, 11300, 0 }, -- Eviscerate (Rank 9)
    { Race.Universal, 26839, 61, 11290, 0 }, -- Garrote (Rank 7)
    { Race.Universal, 26861, 62, 11294, 0 }, -- Sinister Strike (Rank 9)
    { Race.Universal, 26889, 62, 1857, 0 }, -- Vanish (Rank 3)
    { Race.Universal, 32645, 62, -1, 0 }, -- Envenom (Rank 1)
    { Race.Universal, 26679, 64, -1, 0 }, -- Deadly Throw (Rank 1)
    { Race.Universal, 26865, 64, 31016, 0 }, -- Eviscerate (Rank 10)
    { Race.Universal, 27448, 64, 25302, 0 }, -- Feint (Rank 6)
    { Race.Universal, 27441, 66, 11269, 0 }, -- Ambush (Rank 7)
    { Race.Universal, 31224, 66, -1, 0 }, -- Cloak of Shadows
    { Race.Universal, 26863, 68, 25300, 0 }, -- Backstab (Rank 10)
    { Race.Universal, 26867, 68, 11275, 0 }, -- Rupture (Rank 7)
    { Race.Universal, 32684, 69, 32645, 0 }, -- Envenom (Rank 2)
    { Race.Universal, 5938, 70, -1, 0 }, -- Shiv
    { Race.Universal, 26862, 70, 26861, 0 }, -- Sinister Strike (Rank 10)
    { Race.Universal, 26884, 70, 26839, 0 }, -- Garrote (Rank 8)
    { Race.Universal, 48673, 70, 26679, 0 }, -- Deadly Throw (Rank 2)
    { Race.Universal, 48689, 70, 27441, 0 }, -- Ambush (Rank 8)
    { Race.Universal, 51724, 71, 11297, 0 }, -- Sap (Rank 4)
    { Race.Universal, 48658, 72, 27448, 0 }, -- Feint (Rank 7)
    { Race.Universal, 48667, 73, 26865, 0 }, -- Eviscerate (Rank 11)
    { Race.Universal, 48656, 74, 26863, 0 }, -- Backstab (Rank 11)
    { Race.Universal, 48671, 74, 26867, 0 }, -- Rupture (Rank 8)
    { Race.Universal, 57992, 74, 32684, 0 }, -- Envenom (Rank 3)
    { Race.Universal, 48675, 75, 26884, 0 }, -- Garrote (Rank 9)
    { Race.Universal, 48690, 75, 48689, 0 }, -- Ambush (Rank 9)
    { Race.Universal, 57934, 75, -1, 0 }, -- Tricks of the Trade
    { Race.Universal, 48637, 76, 26862, 0 }, -- Sinister Strike 11
    { Race.Universal, 48674, 76, 48673, 0 }, -- Deadly Throw (Rank 3)
    { Race.Universal, 48659, 78, 48658, 0 }, -- Feint (Rank 8)
    { Race.Universal, 48668, 79, 48667, 0 }, -- Eviscerate (Rank 12)
    { Race.Universal, 48672, 79, 48671, 0 }, -- Rupture (Rank 9)
    { Race.Universal, 48638, 80, 48637, 0 }, -- Sinister Strike (Rank 12)
    { Race.Universal, 48657, 80, 48656, 0 }, -- Backstab (Rank 12)
    { Race.Universal, 48676, 80, 48675, 0 }, -- Garrote (Rank 10)
    { Race.Universal, 48691, 80, 48690, 0 }, -- Ambush (Rank 10)
    { Race.Universal, 51723, 80, -1, 0 }, -- Fan of Knives
    { Race.Universal, 57993, 80, 57992, 0 }}, -- Envenom (Rank 4)
    -- Priest
    {{ Race.Universal, 585, 1, -1, 0 }, -- Smite (Rank 1)
    { Race.Universal, 1243, 1, -1, 0 }, -- Power Word: Fortitude (Rank 1)
    { Race.Universal, 2050, 1, -1, 0 }, -- Lesser Heal (Rank 1)
    { Race.Universal, 589, 4, -1, 0 }, -- Shadow Word: Pain (Rank 1)
    { Race.Universal, 2052, 4, 2050, 0 }, -- Lesser Heal (Rank 2)
    { Race.Universal, 17, 6, -1, 0 }, -- Power Word: Shield (Rank 1)
    { Race.Universal, 591, 6, 585, 0 }, -- Smite (Rank 2)
    { Race.Universal, 139, 8, -1, 0 }, -- Renew (Rank 1)
    { Race.Universal, 586, 8, -1, 0 }, -- Fade
    { Race.Universal, 594, 10, 589, 0 }, -- Shadow Word: Pain (Rank 2)
    { Race.Universal, 2006, 10, -1, 0 }, -- Resurrection (Rank 1)
    { Race.Universal, 2053, 10, 2052, 0 }, -- Lesser Heal (Rank 3)
    { Race.Universal, 8092, 10, -1, 0 }, -- Mind Blast (Rank 1)
    { Race.Universal, 588, 12, -1, 0 }, -- Inner Fire (Rank 1)
    { Race.Universal, 592, 12, 17, 0 }, -- Power Word: Shield (Rank 2)
    { Race.Universal, 1244, 12, 1243, 0 }, -- Power Word: Fortitude (Rank 2)
    { Race.Universal, 528, 14, -1, 0 }, -- Cure Disease
    { Race.Universal, 598, 14, 591, 0 }, -- Smite (Rank 3)
    { Race.Universal, 6074, 14, 139, 0 }, -- Renew (Rank 2)
    { Race.Universal, 8122, 14, -1, 0 }, -- Psychic Scream (Rank 1)
    { Race.Universal, 2054, 16, -1, 0 }, -- Heal (Rank 1)
    { Race.Universal, 8102, 16, 8092, 0 }, -- Mind Blast (Rank 2)
    { Race.Universal, 527, 18, -1, 0 }, -- Dispel Magic (Rank 1)
    { Race.Universal, 600, 18, 592, 0 }, -- Power Word: Shield (Rank 3)
    { Race.Universal, 970, 18, 594, 0 }, -- Shadow Word: Pain (Rank 3)
    { Race.Universal, 453, 20, -1, 0 }, -- Mind Soothe
    { Race.Universal, 2061, 20, -1, 0 }, -- Flash Heal (Rank 1)
    { Race.Universal, 2944, 20, -1, 0 }, -- Devouring Plague (Rank 1)
    { Race.Universal, 6075, 20, 6074, 0 }, -- Renew (Rank 3)
    { Race.Universal, 6346, 20, -1, 0 }, -- Fear Ward
    { Race.Universal, 7128, 20, 588, 0 }, -- Inner Fire (Rank 2)
    { Race.Universal, 9484, 20, -1, 0 }, -- Shackle Undead (Rank 1)
    { Race.Universal, 14914, 20, -1, 0 }, -- Holy Fire (Rank 1)
    { Race.Universal, 15237, 20, -1, 0 }, -- Holy Nova (Rank 1)
    { Race.Universal, 984, 22, 598, 0 }, -- Smite (Rank 4)
    { Race.Universal, 2010, 22, 2006, 0 }, -- Resurrection (Rank 2)
    { Race.Universal, 2055, 22, 2054, 0 }, -- Heal (Rank 2)
    { Race.Universal, 2096, 22, -1, 0 }, -- Mind Vision (Rank 1)
    { Race.Universal, 8103, 22, 8102, 0 }, -- Mind Blast (Rank 3)
    { Race.Universal, 1245, 24, 1244, 0 }, -- Power Word: Fortitude (Rank 3)
    { Race.Universal, 3747, 24, 600, 0 }, -- Power Word: Shield (Rank 4)
    { Race.Universal, 8129, 24, -1, 0 }, -- Mana Burn
    { Race.Universal, 15262, 24, 14914, 0 }, -- Holy Fire (Rank 2)
    { Race.Universal, 992, 26, 970, 0 }, -- Shadow Word: Pain (Rank 4)
    { Race.Universal, 6076, 26, 6075, 0 }, -- Renew (Rank 4)
    { Race.Universal, 9472, 26, 2061, 0 }, -- Flash Heal (Rank 2)
    { Race.Universal, 6063, 28, 2055, 0 }, -- Heal (Rank 3)
    { Race.Universal, 8104, 28, 8103, 0 }, -- Mind Blast (Rank 4)
    { Race.Universal, 8124, 28, 8122, 0 }, -- Psychic Scream (Rank 2)
    { Race.Universal, 15430, 28, 15237, 0 }, -- Holy Nova (Rank 2)
    { Race.Universal, 19276, 28, 2944, 0 }, -- Devouring Plague (Rank 2)
    { Race.Universal, 596, 30, -1, 0 }, -- Prayer of Healing (Rank 1)
    { Race.Universal, 602, 30, 7128, 0 }, -- Inner Fire (Rank 3)
    { Race.Universal, 605, 30, -1, 0 }, -- Mind Control
    { Race.Universal, 976, 30, -1, 0 }, -- Shadow Protection (Rank 1)
    { Race.Universal, 1004, 30, 984, 0 }, -- Smite (Rank 5)
    { Race.Universal, 6065, 30, 3747, 0 }, -- Power Word: Shield (Rank 5)
    { Race.Universal, 14752, 30, -1, 0 }, -- Divine Spirit (Rank 1)
    { Race.Universal, 15263, 30, 15262, 0 }, -- Holy Fire (Rank 3)
    { Race.Universal, 552, 32, -1, 0 }, -- Abolish Disease
    { Race.Universal, 6077, 32, 6076, 0 }, -- Renew (Rank 5)
    { Race.Universal, 9473, 32, 9472, 0 }, -- Flash Heal (Rank 3)
    { Race.Universal, 1706, 34, -1, 0 }, -- Levitate
    { Race.Universal, 2767, 34, 992, 0 }, -- Shadow Word: Pain (Rank 5)
    { Race.Universal, 6064, 34, 6063, 0 }, -- Heal (Rank 4)
    { Race.Universal, 8105, 34, 8104, 0 }, -- Mind Blast (Rank 5)
    { Race.Universal, 10880, 34, 2010, 0 }, -- Resurrection (Rank 3)
    { Race.Universal, 988, 36, 527, 0 }, -- Dispel Magic (Rank 2)
    { Race.Universal, 2791, 36, 1245, 0 }, -- Power Word: Fortitude (Rank 4)
    { Race.Universal, 6066, 36, 6065, 0 }, -- Power Word: Shield (Rank 6)
    { Race.Universal, 15264, 36, 15263, 0 }, -- Holy Fire (Rank 4)
    { Race.Universal, 15431, 36, 15430, 0 }, -- Holy Nova (Rank 3)
    { Race.Universal, 19277, 36, 19276, 0 }, -- Devouring Plague (Rank 3)
    { Race.Universal, 6060, 38, 1004, 0 }, -- Smite (Rank 6)
    { Race.Universal, 6078, 38, 6077, 0 }, -- Renew (Rank 6)
    { Race.Universal, 9474, 38, 9473, 0 }, -- Flash Heal (Rank 4)
    { Race.Universal, 996, 40, 596, 0 }, -- Prayer of Healing (Rank 2)
    { Race.Universal, 1006, 40, 602, 0 }, -- Inner Fire (Rank 4)
    { Race.Universal, 2060, 40, -1, 0 }, -- Greater Heal (Rank 1)
    { Race.Universal, 8106, 40, 8105, 0 }, -- Mind Blast (Rank 6)
    { Race.Universal, 9485, 40, 9484, 0 }, -- Shackle Undead (Rank 2)
    { Race.Universal, 14818, 40, 14752, 0 }, -- Divine Spirit (Rank 2)
    { Race.Universal, 10888, 42, 8124, 0 }, -- Psychic Scream (Rank 3)
    { Race.Universal, 10892, 42, 2767, 0 }, -- Shadow Word: Pain (Rank 6)
    { Race.Universal, 10898, 42, 6066, 0 }, -- Power Word: Shield (Rank 7)
    { Race.Universal, 10957, 42, 976, 0 }, -- Shadow Protection (Rank 2)
    { Race.Universal, 15265, 42, 15264, 0 }, -- Holy Fire (Rank 5)
    { Race.Universal, 10909, 44, 2096, 0 }, -- Mind Vision (Rank 2)
    { Race.Universal, 10915, 44, 9474, 0 }, -- Flash Heal (Rank 5)
    { Race.Universal, 10927, 44, 6078, 0 }, -- Renew (Rank 7)
    { Race.Universal, 19278, 44, 19277, 0 }, -- Devouring Plague (Rank 4)
    { Race.Universal, 27799, 44, 15431, 0 }, -- Holy Nova (Rank 4)
    { Race.Universal, 10881, 46, 10880, 0 }, -- Resurrection (Rank 4)
    { Race.Universal, 10933, 46, 6060, 0 }, -- Smite (Rank 7)
    { Race.Universal, 10945, 46, 8106, 0 }, -- Mind Blast (Rank 7)
    { Race.Universal, 10963, 46, 2060, 0 }, -- Greater Heal (Rank 2)
    { Race.Universal, 10899, 48, 10898, 0 }, -- Power Word: Shield (Rank 8)
    { Race.Universal, 10937, 48, 2791, 0 }, -- Power Word: Fortitude (Rank 5)
    { Race.Universal, 15266, 48, 15265, 0 }, -- Holy Fire (Rank 6)
    { Race.Universal, 21562, 48, -1, 0 }, -- Prayer of Fortitude (Rank 1)
    { Race.Universal, 10893, 50, 10892, 0 }, -- Shadow Word: Pain (Rank 7)
    { Race.Universal, 10916, 50, 10915, 0 }, -- Flash Heal (Rank 6)
    { Race.Universal, 10928, 50, 10927, 0 }, -- Renew (Rank 8)
    { Race.Universal, 10951, 50, 1006, 0 }, -- Inner Fire (Rank 5)
    { Race.Universal, 10960, 50, 996, 0 }, -- Prayer of Healing (Rank 3)
    { Race.Universal, 14819, 50, 14818, 0 }, -- Divine Spirit (Rank 3)
    { Race.Universal, 10946, 52, 10945, 0 }, -- Mind Blast (Rank 8)
    { Race.Universal, 10964, 52, 10963, 0 }, -- Greater Heal (Rank 3)
    { Race.Universal, 19279, 52, 19278, 0 }, -- Devouring Plague (Rank 5)
    { Race.Universal, 27800, 52, 27799, 0 }, -- Holy Nova (Rank 5)
    { Race.Universal, 10900, 54, 10899, 0 }, -- Power Word: Shield (Rank 9)
    { Race.Universal, 10934, 54, 10933, 0 }, -- Smite (Rank 8)
    { Race.Universal, 15267, 54, 15266, 0 }, -- Holy Fire (Rank 7)
    { Race.Universal, 10890, 56, 10888, 0 }, -- Psychic Scream (Rank 4)
    { Race.Universal, 10917, 56, 10916, 0 }, -- Flash Heal (Rank 7)
    { Race.Universal, 10929, 56, 10928, 0 }, -- Renew (Rank 9)
    { Race.Universal, 10958, 56, 10957, 0 }, -- Shadow Protection (Rank 3)
    { Race.Universal, 27683, 56, -1, 0 }, -- Prayer of Shadow Protection (Rank 1)
    { Race.Universal, 10894, 58, 10893, 0 }, -- Shadow Word: Pain (Rank 8)
    { Race.Universal, 10947, 58, 10946, 0 }, -- Mind Blast (Rank 9)
    { Race.Universal, 10965, 58, 10964, 0 }, -- Greater Heal (Rank 4)
    { Race.Universal, 20770, 58, 10881, 0 }, -- Resurrection (Rank 5)
    { Race.Universal, 10901, 60, 10900, 0 }, -- Power Word: Shield (Rank 10)
    { Race.Universal, 10938, 60, 10937, 0 }, -- Power Word: Fortitude (Rank 6)
    { Race.Universal, 10952, 60, 10951, 0 }, -- Inner Fire (Rank 6)
    { Race.Universal, 10955, 60, 9485, 0 }, -- Shackle Undead (Rank 3)
    { Race.Universal, 10961, 60, 10960, 0 }, -- Prayer of Healing (Rank 4)
    { Race.Universal, 15261, 60, 15267, 0 }, -- Holy Fire (Rank 8)
    { Race.Universal, 19280, 60, 19279, 0 }, -- Devouring Plague (Rank 6)
    { Race.Universal, 21564, 60, 21562, 0 }, -- Prayer of Fortitude (Rank 2)
    { Race.Universal, 25314, 60, 10965, 0 }, -- Greater Heal (Rank 5)
    { Race.Universal, 25315, 60, 10929, 0 }, -- Renew (Rank 10)
    { Race.Universal, 25316, 60, 10961, 0 }, -- Prayer of Healing (Rank 5)
    { Race.Universal, 27681, 60, -1, 0 }, -- Prayer of Spirit (Rank 1)
    { Race.Universal, 27801, 60, 27800, 0 }, -- Holy Nova (Rank 6)
    { Race.Universal, 27841, 60, 14819, 0 }, -- Divine Spirit (Rank 4)
    { Race.Universal, 25233, 61, 10917, 0 }, -- Flash Heal (Rank 8)
    { Race.Universal, 25363, 61, 10934, 0 }, -- Smite (Rank 9)
    { Race.Universal, 32379, 62, -1, 0 }, -- Shadow Word: Death (Rank 1)
    { Race.Universal, 25210, 63, 25314, 0 }, -- Greater Heal (Rank 6)
    { Race.Universal, 25372, 63, 10947, 0 }, -- Mind Blast (Rank 10)
    { Race.Universal, 32546, 64, -1, 0 }, -- Binding Heal (Rank 1)
    { Race.Universal, 25217, 65, 10901, 0 }, -- Power Word: Shield (Rank 11)
    { Race.Universal, 25221, 65, 25315, 0 }, -- Renew (Rank 11)
    { Race.Universal, 25367, 65, 10894, 0 }, -- Shadow Word: Pain (Rank 9)
    { Race.Universal, 25384, 66, 15261, 0 }, -- Holy Fire (Rank 9)
    { Race.Universal, 34433, 66, -1, 0 }, -- Shadowfiend
    { Race.Universal, 25235, 67, 25233, 0 }, -- Flash Heal (Rank 9)
    { Race.Universal, 25213, 68, 25210, 0 }, -- Greater Heal (Rank 7)
    { Race.Universal, 25308, 68, 25316, 0 }, -- Prayer of Healing (Rank 6)
    { Race.Universal, 25331, 68, 27801, 0 }, -- Holy Nova (Rank 7)
    { Race.Universal, 25433, 68, 10958, 0 }, -- Shadow Protection (Rank 4)
    { Race.Universal, 25435, 68, 20770, 0 }, -- Resurrection (Rank 6)
    { Race.Universal, 25467, 68, 19280, 0 }, -- Devouring Plague (Rank 7)
    { Race.Universal, 33076, 68, -1, 0 }, -- Prayer of Mending (Rank 1)
    { Race.Universal, 25364, 69, 25363, 0 }, -- Smite (Rank 10)
    { Race.Universal, 25375, 69, 25372, 0 }, -- Mind Blast (Rank 11)
    { Race.Universal, 25431, 69, 10952, 0 }, -- Inner Fire (Rank 7)
    { Race.Universal, 25218, 70, 25217, 0 }, -- Power Word: Shield (Rank 12)
    { Race.Universal, 25222, 70, 25221, 0 }, -- Renew (Rank 12)
    { Race.Universal, 25312, 70, 27841, 0 }, -- Divine Spirit (Rank 5)
    { Race.Universal, 25368, 70, 25367, 0 }, -- Shadow Word: Pain (Rank 10)
    { Race.Universal, 25389, 70, 10938, 0 }, -- Power Word: Fortitude (Rank 7)
    { Race.Universal, 25392, 70, 21564, 0 }, -- Prayer of Fortitude (Rank 3)
    { Race.Universal, 32375, 70, -1, 0 }, -- Mass Dispel
    { Race.Universal, 32996, 70, 32379, 0 }, -- Shadow Word: Death (Rank 2)
    { Race.Universal, 32999, 70, 27681, 0 }, -- Prayer of Spirit (Rank 2)
    { Race.Universal, 39374, 70, 27683, 0 }, -- Prayer of Shadow Protection (Rank 2)
    { Race.Universal, 48040, 71, 25431, 0 }, -- Inner Fire (Rank 8)
    { Race.Universal, 48119, 72, 32546, 0 }, -- Binding Heal (Rank 2)
    { Race.Universal, 48134, 72, 25384, 0 }, -- Holy Fire (Rank 10)
    { Race.Universal, 48062, 73, 25213, 0 }, -- Greater Heal (Rank 8)
    { Race.Universal, 48070, 73, 25235, 0 }, -- Flash Heal (Rank 10)
    { Race.Universal, 48299, 73, 25467, 0 }, -- Devouring Plague (Rank 8)
    { Race.Universal, 48112, 74, 33076, 0 }, -- Prayer of Mending (Rank 2)
    { Race.Universal, 48122, 74, 25364, 0 }, -- Smite (Rank 11)
    { Race.Universal, 48126, 74, 25375, 0 }, -- Mind Blast (Rank 12)
    { Race.Universal, 48045, 75, -1, 0 }, -- Mind Sear (Rank 1)
    { Race.Universal, 48065, 75, 25218, 0 }, -- Power Word: Shield (Rank 13)
    { Race.Universal, 48067, 75, 25222, 0 }, -- Renew (Rank 13)
    { Race.Universal, 48077, 75, 25331, 0 }, -- Holy Nova (Rank 8)
    { Race.Universal, 48124, 75, 25368, 0 }, -- Shadow Word: Pain (Rank 11)
    { Race.Universal, 48157, 75, 32996, 0 }, -- Shadow Word: Death (Rank 3)
    { Race.Universal, 48072, 76, 25308, 0 }, -- Prayer of Healing (Rank 7)
    { Race.Universal, 48169, 76, 25433, 0 }, -- Shadow Protection (Rank 5)
    { Race.Universal, 48168, 77, 48040, 0 }, -- Inner Fire (Rank 9)
    { Race.Universal, 48170, 77, 39374, 0 }, -- Prayer of Shadow Protection (Rank 3)
    { Race.Universal, 48063, 78, 48062, 0 }, -- Greater Heal (Rank 9)
    { Race.Universal, 48120, 78, 48119, 0 }, -- Binding Heal (Rank 3)
    { Race.Universal, 48135, 78, 48134, 0 }, -- Holy Fire (Rank 11)
    { Race.Universal, 48171, 78, 25435, 0 }, -- Resurrection (Rank 7)
    { Race.Universal, 48071, 79, 48070, 0 }, -- Flash Heal (Rank 11)
    { Race.Universal, 48113, 79, 48112, 0 }, -- Prayer of Mending (Rank 3)
    { Race.Universal, 48123, 79, 48122, 0 }, -- Smite (Rank 12)
    { Race.Universal, 48127, 79, 48126, 0 }, -- Mind Blast (Rank 13)
    { Race.Universal, 48300, 79, 48299, 0 }, -- Devouring Plague (Rank 9)
    { Race.Universal, 48066, 80, 48065, 0 }, -- Power Word: Shield (Rank 14)
    { Race.Universal, 48068, 80, 48067, 0 }, -- Renew (Rank 14)
    { Race.Universal, 48073, 80, 25312, 0 }, -- Divine Spirit (Rank 6)
    { Race.Universal, 48074, 80, 32999, 0 }, -- Prayer of Spirit (Rank 3)
    { Race.Universal, 48078, 80, 48077, 0 }, -- Holy Nova (Rank 9)
    { Race.Universal, 48125, 80, 48124, 0 }, -- Shadow Word: Pain (Rank 12)
    { Race.Universal, 48158, 80, 48157, 0 }, -- Shadow Word: Death (Rank 4)
    { Race.Universal, 48161, 80, 25389, 0 }, -- Power Word: Fortitude (Rank 8)
    { Race.Universal, 48162, 80, 25392, 0 }, -- Prayer of Fortitude (Rank 4)
    { Race.Universal, 53023, 80, 48045, 0 }, -- Mind Sear (Rank 2)
    { Race.Universal, 64843, 80, -1, 0 }, -- Divine Hymn (Rank 1)
    { Race.Universal, 64901, 80, -1, 0 }}, -- Hymn of Hope
    -- Death Knight
    {{ Race.Universal, 45462, 55, -1, 0 }, -- Plague Strike (Rank 1)
    { Race.Universal, 45477, 55, -1, 0 }, -- Icy Touch (Rank 1)
    { Race.Universal, 45902, 55, -1, 0 }, -- Blood Strike (Rank 1)
    { Race.Universal, 47541, 55, -1, 0 }, -- Death Coil (Rank 1)
    { Race.Universal, 48266, 55, -1, 0 }, -- Blood Presence
    { Race.Universal, 49576, 55, -1, 0 }, -- Death Grip
    { Race.Universal, 50977, 55, -1, 0 }, -- Death Gate
    { Race.Universal, 53323, 55, -1, 0 }, -- Rune of Swordshattering
    { Race.Universal, 53331, 55, -1, 0 }, -- Rune of Lichbane
    { Race.Universal, 53342, 55, -1, 0 }, -- Rune of Spellshattering
    { Race.Universal, 53344, 55, -1, 0 }, -- Rune of the Fallen Crusader
    { Race.Universal, 54446, 55, -1, 0 }, -- Rune of Swordbreaking
    { Race.Universal, 54447, 55, -1, 0 }, -- Rune of Spellbreaking
    { Race.Universal, 62158, 55, -1, 0 }, -- Rune of the Stoneskin Gargoyle
    { Race.Universal, 70164, 55, -1, 0 }, -- Rune of the Nerubian Carapace
    { Race.Universal, 46584, 56, -1, 0 }, -- Raise Dead
    { Race.Universal, 49998, 56, -1, 0 }, -- Death Strike (Rank 1)
    { Race.Universal, 50842, 56, -1, 0 }, -- Pestilence
    { Race.Universal, 47528, 57, -1, 0 }, -- Mind Freeze
    { Race.Universal, 48263, 57, -1, 0 }, -- Frost Presence
    { Race.Universal, 45524, 58, -1, 0 }, -- Chains of Ice
    { Race.Universal, 48721, 58, -1, 0 }, -- Blood Boil (Rank 1)
    { Race.Universal, 47476, 59, -1, 0 }, -- Strangulate
    { Race.Universal, 49926, 59, 45902, 0 }, -- Blood Strike (Rank 2)
    { Race.Universal, 43265, 60, -1, 0 }, -- Death and Decay (Rank 1)
    { Race.Universal, 49917, 60, 45462, 0 }, -- Plague Strike (Rank 2)
    { Race.Universal, 3714, 61, -1, 0 }, -- Path of Frost
    { Race.Universal, 49020, 61, -1, 0 }, -- Obliterate (Rank 1)
    { Race.Universal, 49896, 61, 45477, 0 }, -- Icy Touch (Rank 2)
    { Race.Universal, 48792, 62, -1, 0 }, -- Icebound Fortitude
    { Race.Universal, 49892, 62, 47541, 0 }, -- Death Coil (Rank 2)
    { Race.Universal, 49999, 63, 49998, 0 }, -- Death Strike (Rank 2)
    { Race.Universal, 45529, 64, -1, 0 }, -- Blood Tap
    { Race.Universal, 49927, 64, 49926, 0 }, -- Blood Strike (Rank 3)
    { Race.Universal, 49918, 65, 49917, 0 }, -- Plague Strike (Rank 3)
    { Race.Universal, 56222, 65, -1, 0 }, -- Dark Command
    { Race.Universal, 57330, 65, -1, 0 }, -- Horn of Winter (Rank 1)
    { Race.Universal, 48743, 66, -1, 0 }, -- Death Pact
    { Race.Universal, 49939, 66, 48721, 0 }, -- Blood Boil (Rank 2)
    { Race.Universal, 49903, 67, 49896, 0 }, -- Icy Touch (Rank 3)
    { Race.Universal, 49936, 67, 43265, 0 }, -- Death and Decay (Rank 2)
    { Race.Universal, 51423, 67, 49020, 0 }, -- Obliterate (Rank 2)
    { Race.Universal, 56815, 67, -1, 0 }, -- Rune Strike
    { Race.Universal, 48707, 68, -1, 0 }, -- Anti-Magic Shell
    { Race.Universal, 49893, 68, 49892, 0 }, -- Death Coil (Rank 3)
    { Race.Universal, 49928, 69, 49927, 0 }, -- Blood Strike (Rank 4)
    { Race.Universal, 45463, 70, 49999, 0 }, -- Death Strike (Rank 3)
    { Race.Universal, 48265, 70, -1, 0 }, -- Unholy Presence
    { Race.Universal, 49919, 70, 49918, 0 }, -- Plague Strike (Rank 4)
    { Race.Universal, 49940, 72, 49939, 0 }, -- Blood Boil (Rank 3)
    { Race.Universal, 61999, 72, -1, 0 }, -- Raise Ally
    { Race.Universal, 49904, 73, 49903, 0 }, -- Icy Touch (Rank 4)
    { Race.Universal, 49937, 73, 49936, 0 }, -- Death and Decay (Rank 3)
    { Race.Universal, 51424, 73, 51423, 0 }, -- Obliterate (Rank 3)
    { Race.Universal, 49929, 74, 49928, 0 }, -- Blood Strike (Rank 5)
    { Race.Universal, 47568, 75, -1, 0 }, -- Empower Rune Weapon
    { Race.Universal, 49920, 75, 49919, 0 }, -- Plague Strike (Rank 5)
    { Race.Universal, 49923, 75, 45463, 0 }, -- Death Strike (Rank 4)
    { Race.Universal, 57623, 75, 57330, 0 }, -- Horn of Winter (Rank 2)
    { Race.Universal, 49894, 76, 49893, 0 }, -- Death Coil (Rank 4)
    { Race.Universal, 49909, 78, 49904, 0 }, -- Icy Touch (Rank 5)
    { Race.Universal, 49941, 78, 49940, 0 }, -- Blood Boil (Rank 4)
    { Race.Universal, 51425, 79, 51424, 0 }, -- Obliterate (Rank 4)
    { Race.Universal, 42650, 80, -1, 0 }, -- Army of the Dead
    { Race.Universal, 49895, 80, 49894, 0 }, -- Death Coil (Rank 5)
    { Race.Universal, 49921, 80, 49920, 0 }, -- Plague Strike (Rank 6)
    { Race.Universal, 49924, 80, 49923, 0 }, -- Death Strike (Rank 5)
    { Race.Universal, 49930, 80, 49929, 0 }, -- Blood Strike (Rank 6)
    { Race.Universal, 49938, 80, 49937, 0 }}, -- Death and Decay (Rank 4)
    -- Shaman
    {{ Race.Universal, 331, 1, -1, 0 }, -- Healing Wave (Rank 1)
    { Race.Universal, 403, 1, -1, 0 }, -- Lightning Bolt (Rank 1)
    { Race.Universal, 8017, 1, -1, 0 }, -- Rockbiter Weapon (Rank 1)
    { Race.Universal, 8042, 4, -1, 0 }, -- Earth Shock (Rank 1)
    { Race.Universal, 8071, 4, -1, 1 }, -- Stoneskin Totem (Rank 1)
    { Race.Universal, 332, 6, 331, 0 }, -- Healing Wave (Rank 2)
    { Race.Universal, 2484, 6, -1, 0 }, -- Earthbind Totem
    { Race.Universal, 324, 8, -1, 0 }, -- Lightning Shield (Rank 1)
    { Race.Universal, 529, 8, 403, 0 }, -- Lightning Bolt (Rank 2)
    { Race.Universal, 5730, 8, -1, 0 }, -- Stoneclaw Totem (Rank 1)
    { Race.Universal, 8018, 8, 8017, 0 }, -- Rockbiter Weapon (Rank 2)
    { Race.Universal, 8044, 8, 8042, 0 }, -- Earth Shock (Rank 2)
    { Race.Universal, 3599, 10, -1, 1 }, -- Searing Totem (Rank 1)
    { Race.Universal, 8024, 10, -1, 0 }, -- Flametongue Weapon (Rank 1)
    { Race.Universal, 8050, 10, -1, 0 }, -- Flame Shock (Rank 1)
    { Race.Universal, 8075, 10, -1, 0 }, -- Strength of Earth Totem (Rank 1)
    { Race.Universal, 370, 12, -1, 0 }, -- Purge (Rank 1)
    { Race.Universal, 547, 12, 332, 0 }, -- Healing Wave (Rank 3)
    { Race.Universal, 1535, 12, -1, 0 }, -- Fire Nova (Rank 1)
    { Race.Universal, 2008, 12, -1, 0 }, -- Ancestral Spirit (Rank 1)
    { Race.Universal, 548, 14, 529, 0 }, -- Lightning Bolt (Rank 3)
    { Race.Universal, 8045, 14, 8044, 0 }, -- Earth Shock (Rank 3)
    { Race.Universal, 8154, 14, 8071, 0 }, -- Stoneskin Totem (Rank 2)
    { Race.Universal, 325, 16, 324, 0 }, -- Lightning Shield (Rank 2)
    { Race.Universal, 526, 16, -1, 0 }, -- Cure Toxins
    { Race.Universal, 2645, 16, -1, 0 }, -- Ghost Wolf
    { Race.Universal, 8019, 16, 8018, 0 }, -- Rockbiter Weapon (Rank 3)
    { Race.Universal, 57994, 16, -1, 0 }, -- Wind Shear
    { Race.Universal, 913, 18, 547, 0 }, -- Healing Wave (Rank 4)
    { Race.Universal, 6390, 18, 5730, 0 }, -- Stoneclaw Totem (Rank 2)
    { Race.Universal, 8027, 18, 8024, 0 }, -- Flametongue Weapon (Rank 2)
    { Race.Universal, 8052, 18, 8050, 0 }, -- Flame Shock (Rank 2)
    { Race.Universal, 8143, 18, -1, 0 }, -- Tremor Totem
    { Race.Universal, 915, 20, 548, 0 }, -- Lightning Bolt (Rank 4)
    { Race.Universal, 5394, 20, -1, 1 }, -- Healing Stream Totem (Rank 1)
    { Race.Universal, 6363, 20, 3599, 0 }, -- Searing Totem (Rank 2)
    { Race.Universal, 8004, 20, -1, 0 }, -- Lesser Healing Wave (Rank 1)
    { Race.Universal, 8033, 20, -1, 0 }, -- Frostbrand Weapon (Rank 1)
    { Race.Universal, 8056, 20, -1, 0 }, -- Frost Shock (Rank 1)
    { Race.Universal, 52127, 20, -1, 0 }, -- Water Shield (Rank 1)
    { Race.Universal, 131, 22, -1, 0 }, -- Water Breathing
    { Race.Universal, 8498, 22, 1535, 0 }, -- Fire Nova (Rank 2)
    { Race.Universal, 905, 24, 325, 0 }, -- Lightning Shield (Rank 3)
    { Race.Universal, 939, 24, 913, 0 }, -- Healing Wave (Rank 5)
    { Race.Universal, 8046, 24, 8045, 0 }, -- Earth Shock (Rank 4)
    { Race.Universal, 8155, 24, 8154, 0 }, -- Stoneskin Totem (Rank 3)
    { Race.Universal, 8160, 24, 8075, 0 }, -- Strength of Earth Totem (Rank 2)
    { Race.Universal, 8181, 24, -1, 0 }, -- Frost Resistance Totem (Rank 1)
    { Race.Universal, 10399, 24, 8019, 0 }, -- Rockbiter Weapon (Rank 4)
    { Race.Universal, 20609, 24, 2008, 0 }, -- Ancestral Spirit (Rank 2)
    { Race.Universal, 943, 26, 915, 0 }, -- Lightning Bolt (Rank 5)
    { Race.Universal, 5675, 26, -1, 0 }, -- Mana Spring Totem (Rank 1)
    { Race.Universal, 6196, 26, -1, 0 }, -- Far Sight
    { Race.Universal, 8030, 26, 8027, 0 }, -- Flametongue Weapon (Rank 3)
    { Race.Universal, 8190, 26, -1, 0 }, -- Magma Totem (Rank 1)
    { Race.Universal, 546, 28, -1, 0 }, -- Water Walking
    { Race.Universal, 6391, 28, 6390, 0 }, -- Stoneclaw Totem (Rank 3)
    { Race.Universal, 8008, 28, 8004, 0 }, -- Lesser Healing Wave (Rank 2)
    { Race.Universal, 8038, 28, 8033, 0 }, -- Frostbrand Weapon (Rank 2)
    { Race.Universal, 8053, 28, 8052, 0 }, -- Flame Shock (Rank 3)
    { Race.Universal, 8184, 28, -1, 0 }, -- Fire Resistance Totem (Rank 1)
    { Race.Universal, 8227, 28, -1, 0 }, -- Flametongue Totem (Rank 1)
    { Race.Universal, 52129, 28, 52127, 0 }, -- Water Shield (Rank 2)
    { Race.Universal, 556, 30, -1, 0 }, -- Astral Recall
    { Race.Universal, 6364, 30, 6363, 0 }, -- Searing Totem (Rank 3)
    { Race.Universal, 6375, 30, 5394, 0 }, -- Healing Stream Totem (Rank 2)
    { Race.Universal, 8177, 30, -1, 0 }, -- Grounding Totem
    { Race.Universal, 8232, 30, -1, 0 }, -- Windfury Weapon (Rank 1)
    { Race.Universal, 10595, 30, -1, 0 }, -- Nature Resistance Totem (Rank 1)
    { Race.Universal, 20608, 30, -1, 0 }, -- Reincarnation (Passive)
    { Race.Universal, 36936, 30, -1, 0 }, -- Totemic Recall
    { Race.Universal, 51730, 30, -1, 0 }, -- Earthliving Weapon (Rank 1)
    { Race.Universal, 66842, 30, -1, 0 }, -- Call of the Elements
    { Race.Universal, 421, 32, -1, 0 }, -- Chain Lightning (Rank 1)
    { Race.Universal, 945, 32, 905, 0 }, -- Lightning Shield (Rank 4)
    { Race.Universal, 959, 32, 939, 0 }, -- Healing Wave (Rank 6)
    { Race.Universal, 6041, 32, 943, 0 }, -- Lightning Bolt (Rank 6)
    { Race.Universal, 8012, 32, 370, 0 }, -- Purge (Rank 2)
    { Race.Universal, 8499, 32, 8498, 0 }, -- Fire Nova (Rank 3)
    { Race.Universal, 8512, 32, -1, 0 }, -- Windfury Totem
    { Race.Universal, 6495, 34, -1, 0 }, -- Sentry Totem
    { Race.Universal, 8058, 34, 8056, 0 }, -- Frost Shock (Rank 2)
    { Race.Universal, 10406, 34, 8155, 0 }, -- Stoneskin Totem (Rank 4)
    { Race.Universal, 52131, 34, 52129, 0 }, -- Water Shield (Rank 3)
    { Race.Universal, 8010, 36, 8008, 0 }, -- Lesser Healing Wave (Rank 3)
    { Race.Universal, 10412, 36, 8046, 0 }, -- Earth Shock (Rank 5)
    { Race.Universal, 10495, 36, 5675, 0 }, -- Mana Spring Totem (Rank 2)
    { Race.Universal, 10585, 36, 8190, 0 }, -- Magma Totem (Rank 2)
    { Race.Universal, 16339, 36, 8030, 0 }, -- Flametongue Weapon (Rank 4)
    { Race.Universal, 20610, 36, 20609, 0 }, -- Ancestral Spirit (Rank 3)
    { Race.Universal, 6392, 38, 6391, 0 }, -- Stoneclaw Totem (Rank 4)
    { Race.Universal, 8161, 38, 8160, 0 }, -- Strength of Earth Totem (Rank 3)
    { Race.Universal, 8170, 38, -1, 0 }, -- Cleansing Totem
    { Race.Universal, 8249, 38, 8227, 0 }, -- Flametongue Totem (Rank 2)
    { Race.Universal, 10391, 38, 6041, 0 }, -- Lightning Bolt (Rank 7)
    { Race.Universal, 10456, 38, 8038, 0 }, -- Frostbrand Weapon (Rank 3)
    { Race.Universal, 10478, 38, 8181, 0 }, -- Frost Resistance Totem (Rank 2)
    { Race.Universal, 930, 40, 421, 0 }, -- Chain Lightning (Rank 2)
    { Race.Universal, 1064, 40, -1, 0 }, -- Chain Heal (Rank 1)
    { Race.Universal, 6365, 40, 6364, 0 }, -- Searing Totem (Rank 4)
    { Race.Universal, 6377, 40, 6375, 0 }, -- Healing Stream Totem (Rank 3)
    { Race.Universal, 8005, 40, 959, 0 }, -- Healing Wave (Rank 7)
    { Race.Universal, 8134, 40, 945, 0 }, -- Lightning Shield (Rank 5)
    { Race.Universal, 8235, 40, 8232, 0 }, -- Windfury Weapon (Rank 2)
    { Race.Universal, 10447, 40, 8053, 0 }, -- Flame Shock (Rank 4)
    { Race.Universal, 51988, 40, 51730, 0 }, -- Earthliving Weapon (Rank 2)
    { Race.Universal, 66843, 40, -1, 0 }, -- Call of the Ancestors
    { Race.Universal, 52134, 41, 52131, 0 }, -- Water Shield (Rank 4)
    { Race.Universal, 10537, 42, 8184, 0 }, -- Fire Resistance Totem (Rank 2)
    { Race.Universal, 11314, 42, 8499, 0 }, -- Fire Nova (Rank 4)
    { Race.Universal, 10392, 44, 10391, 0 }, -- Lightning Bolt (Rank 8)
    { Race.Universal, 10407, 44, 10406, 0 }, -- Stoneskin Totem (Rank 5)
    { Race.Universal, 10466, 44, 8010, 0 }, -- Lesser Healing Wave (Rank 4)
    { Race.Universal, 10600, 44, 10595, 0 }, -- Nature Resistance Totem (Rank 2)
    { Race.Universal, 10472, 46, 8058, 0 }, -- Frost Shock (Rank 3)
    { Race.Universal, 10496, 46, 10495, 0 }, -- Mana Spring Totem (Rank 3)
    { Race.Universal, 10586, 46, 10585, 0 }, -- Magma Totem (Rank 3)
    { Race.Universal, 10622, 46, 1064, 0 }, -- Chain Heal (Rank 2)
    { Race.Universal, 16341, 46, 16339, 0 }, -- Flametongue Weapon (Rank 5)
    { Race.Universal, 2860, 48, 930, 0 }, -- Chain Lightning (Rank 3)
    { Race.Universal, 10395, 48, 8005, 0 }, -- Healing Wave (Rank 8)
    { Race.Universal, 10413, 48, 10412, 0 }, -- Earth Shock (Rank 6)
    { Race.Universal, 10427, 48, 6392, 0 }, -- Stoneclaw Totem (Rank 5)
    { Race.Universal, 10431, 48, 8134, 0 }, -- Lightning Shield (Rank 6)
    { Race.Universal, 10526, 48, 8249, 0 }, -- Flametongue Totem (Rank 3)
    { Race.Universal, 16355, 48, 10456, 0 }, -- Frostbrand Weapon (Rank 4)
    { Race.Universal, 20776, 48, 20610, 0 }, -- Ancestral Spirit (Rank 4)
    { Race.Universal, 52136, 48, 52134, 0 }, -- Water Shield (Rank 5)
    { Race.Universal, 10437, 50, 6365, 0 }, -- Searing Totem (Rank 5)
    { Race.Universal, 10462, 50, 6377, 0 }, -- Healing Stream Totem (Rank 4)
    { Race.Universal, 10486, 50, 8235, 0 }, -- Windfury Weapon (Rank 3)
    { Race.Universal, 15207, 50, 10392, 0 }, -- Lightning Bolt (Rank 9)
    { Race.Universal, 51991, 50, 51988, 0 }, -- Earthliving Weapon (Rank 3)
    { Race.Universal, 66844, 50, -1, 0 }, -- Call of the Spirits
    { Race.Universal, 10442, 52, 8161, 0 }, -- Strength of Earth Totem (Rank 4)
    { Race.Universal, 10448, 52, 10447, 0 }, -- Flame Shock (Rank 5)
    { Race.Universal, 10467, 52, 10466, 0 }, -- Lesser Healing Wave (Rank 5)
    { Race.Universal, 11315, 52, 11314, 0 }, -- Fire Nova (Rank 5)
    { Race.Universal, 10408, 54, 10407, 0 }, -- Stoneskin Totem (Rank 6)
    { Race.Universal, 10479, 54, 10478, 0 }, -- Frost Resistance Totem (Rank 3)
    { Race.Universal, 10623, 54, 10622, 0 }, -- Chain Heal (Rank 3)
    { Race.Universal, 52138, 55, 52136, 0 }, -- Water Shield (Rank 6)
    { Race.Universal, 10396, 56, 10395, 0 }, -- Healing Wave (Rank 9)
    { Race.Universal, 10432, 56, 10431, 0 }, -- Lightning Shield (Rank 7)
    { Race.Universal, 10497, 56, 10496, 0 }, -- Mana Spring Totem (Rank 4)
    { Race.Universal, 10587, 56, 10586, 0 }, -- Magma Totem (Rank 4)
    { Race.Universal, 10605, 56, 2860, 0 }, -- Chain Lightning (Rank 4)
    { Race.Universal, 15208, 56, 15207, 0 }, -- Lightning Bolt (Rank 10)
    { Race.Universal, 16342, 56, 16341, 0 }, -- Flametongue Weapon (Rank 6)
    { Race.Universal, 10428, 58, 10427, 0 }, -- Stoneclaw Totem (Rank 6)
    { Race.Universal, 10473, 58, 10472, 0 }, -- Frost Shock (Rank 4)
    { Race.Universal, 10538, 58, 10537, 0 }, -- Fire Resistance Totem (Rank 3)
    { Race.Universal, 16356, 58, 16355, 0 }, -- Frostbrand Weapon (Rank 5)
    { Race.Universal, 16387, 58, 10526, 0 }, -- Flametongue Totem (Rank 4)
    { Race.Universal, 10414, 60, 10413, 0 }, -- Earth Shock (Rank 7)
    { Race.Universal, 10438, 60, 10437, 0 }, -- Searing Totem (Rank 6)
    { Race.Universal, 10463, 60, 10462, 0 }, -- Healing Stream Totem (Rank 5)
    { Race.Universal, 10468, 60, 10467, 0 }, -- Lesser Healing Wave (Rank 6)
    { Race.Universal, 10601, 60, 10600, 0 }, -- Nature Resistance Totem (Rank 3)
    { Race.Universal, 16362, 60, 10486, 0 }, -- Windfury Weapon (Rank 4)
    { Race.Universal, 20777, 60, 20776, 0 }, -- Ancestral Spirit (Rank 5)
    { Race.Universal, 25357, 60, 10396, 0 }, -- Healing Wave (Rank 10)
    { Race.Universal, 25361, 60, 10442, 0 }, -- Strength of Earth Totem (Rank 5)
    { Race.Universal, 29228, 60, 10448, 0 }, -- Flame Shock (Rank 6)
    { Race.Universal, 51992, 60, 51991, 0 }, -- Earthliving Weapon (Rank 4)
    { Race.Universal, 25422, 61, 10623, 0 }, -- Chain Heal (Rank 4)
    { Race.Universal, 25546, 61, 11315, 0 }, -- Fire Nova (Rank 6)
    { Race.Universal, 24398, 62, 52138, 0 }, -- Water Shield (Rank 7)
    { Race.Universal, 25448, 62, 15208, 0 }, -- Lightning Bolt (Rank 11)
    { Race.Universal, 25391, 63, 25357, 0 }, -- Healing Wave (Rank 11)
    { Race.Universal, 25439, 63, 10605, 0 }, -- Chain Lightning (Rank 5)
    { Race.Universal, 25469, 63, 10432, 0 }, -- Lightning Shield (Rank 8)
    { Race.Universal, 25508, 63, 10408, 0 }, -- Stoneskin Totem (Rank 7)
    { Race.Universal, 3738, 64, -1, 0 }, -- Wrath of Air Totem
    { Race.Universal, 25489, 64, 16342, 0 }, -- Flametongue Weapon (Rank 7)
    { Race.Universal, 25528, 65, 25361, 0 }, -- Strength of Earth Totem (Rank 6)
    { Race.Universal, 25552, 65, 10587, 0 }, -- Magma Totem (Rank 5)
    { Race.Universal, 25570, 65, 10497, 0 }, -- Mana Spring Totem (Rank 5)
    { Race.Universal, 2062, 66, -1, 0 }, -- Earth Elemental Totem
    { Race.Universal, 25420, 66, 10468, 0 }, -- Lesser Healing Wave (Rank 7)
    { Race.Universal, 25500, 66, 16356, 0 }, -- Frostbrand Weapon (Rank 6)
    { Race.Universal, 25449, 67, 25448, 0 }, -- Lightning Bolt (Rank 12)
    { Race.Universal, 25525, 67, 10428, 0 }, -- Stoneclaw Totem (Rank 7)
    { Race.Universal, 25557, 67, 16387, 0 }, -- Flametongue Totem (Rank 5)
    { Race.Universal, 25560, 67, 10479, 0 }, -- Frost Resistance Totem (Rank 4)
    { Race.Universal, 2894, 68, -1, 0 }, -- Fire Elemental Totem
    { Race.Universal, 25423, 68, 25422, 0 }, -- Chain Heal (Rank 5)
    { Race.Universal, 25464, 68, 10473, 0 }, -- Frost Shock (Rank 5)
    { Race.Universal, 25505, 68, 16362, 0 }, -- Windfury Weapon (Rank 5)
    { Race.Universal, 25563, 68, 10538, 0 }, -- Fire Resistance Totem (Rank 4)
    { Race.Universal, 25454, 69, 10414, 0 }, -- Earth Shock (Rank 8)
    { Race.Universal, 25533, 69, 10438, 0 }, -- Searing Totem (Rank 7)
    { Race.Universal, 25567, 69, 10463, 0 }, -- Healing Stream Totem (Rank 6)
    { Race.Universal, 25574, 69, 10601, 0 }, -- Nature Resistance Totem (Rank 4)
    { Race.Universal, 25590, 69, 20777, 0 }, -- Ancestral Spirit (Rank 6)
    { Race.Universal, 33736, 69, 24398, 0 }, -- Water Shield (Rank 8)
    { Race.Universal, 2825, 70, -1, 0 }, -- Bloodlust
    { Race.Universal, 25396, 70, 25391, 0 }, -- Healing Wave (Rank 12)
    { Race.Universal, 25442, 70, 25439, 0 }, -- Chain Lightning (Rank 6)
    { Race.Universal, 25457, 70, 29228, 0 }, -- Flame Shock (Rank 7)
    { Race.Universal, 25472, 70, 25469, 0 }, -- Lightning Shield (Rank 9)
    { Race.Universal, 25509, 70, 25508, 0 }, -- Stoneskin Totem (Rank 8)
    { Race.Universal, 25547, 70, 25546, 0 }, -- Fire Nova (Rank 7)
    { Race.Universal, 51993, 70, 51992, 0 }, -- Earthliving Weapon (Rank 5)
    { Race.Universal, 58580, 71, 25525, 0 }, -- Stoneclaw Totem (Rank 8)
    { Race.Universal, 58649, 71, 25557, 0 }, -- Flametongue Totem (Rank 6)
    { Race.Universal, 58699, 71, 25533, 0 }, -- Searing Totem (Rank 8)
    { Race.Universal, 58755, 71, 25567, 0 }, -- Healing Stream Totem (Rank 7)
    { Race.Universal, 58771, 71, 25570, 0 }, -- Mana Spring Totem (Rank 6)
    { Race.Universal, 58785, 71, 25489, 0 }, -- Flametongue Weapon (Rank 8)
    { Race.Universal, 58794, 71, 25500, 0 }, -- Frostbrand Weapon (Rank 7)
    { Race.Universal, 58801, 71, 25505, 0 }, -- Windfury Weapon (Rank 6)
    { Race.Universal, 49275, 72, 25420, 0 }, -- Lesser Healing Wave (Rank 8)
    { Race.Universal, 49235, 73, 25464, 0 }, -- Frost Shock (Rank 6)
    { Race.Universal, 49237, 73, 25449, 0 }, -- Lightning Bolt (Rank 13)
    { Race.Universal, 58731, 73, 25552, 0 }, -- Magma Totem (Rank 6)
    { Race.Universal, 58751, 73, 25509, 0 }, -- Stoneskin Totem (Rank 9)
    { Race.Universal, 49230, 74, 25454, 0 }, -- Earth Shock (Rank 9)
    { Race.Universal, 49270, 74, 25442, 0 }, -- Chain Lightning (Rank 7)
    { Race.Universal, 55458, 74, 25423, 0 }, -- Chain Heal (Rank 6)
    { Race.Universal, 49232, 75, 25457, 0 }, -- Flame Shock (Rank 8)
    { Race.Universal, 49272, 75, 25396, 0 }, -- Healing Wave (Rank 13)
    { Race.Universal, 49280, 75, 25472, 0 }, -- Lightning Shield (Rank 10)
    { Race.Universal, 51505, 75, -1, 0 }, -- Lava Burst (Rank 1)
    { Race.Universal, 57622, 75, 25528, 0 }, -- Strength of Earth Totem (Rank 7)
    { Race.Universal, 58581, 75, 58580, 0 }, -- Stoneclaw Totem (Rank 9)
    { Race.Universal, 58652, 75, 58649, 0 }, -- Flametongue Totem (Rank 7)
    { Race.Universal, 58703, 75, 58699, 0 }, -- Searing Totem (Rank 9)
    { Race.Universal, 58737, 75, 25563, 0 }, -- Fire Resistance Totem (Rank 5)
    { Race.Universal, 58741, 75, 25560, 0 }, -- Frost Resistance Totem (Rank 5)
    { Race.Universal, 58746, 75, 25574, 0 }, -- Nature Resistance Totem (Rank 5)
    { Race.Universal, 61649, 75, 25547, 0 }, -- Fire Nova (Rank 8)
    { Race.Universal, 57960, 76, 33736, 0 }, -- Water Shield (Rank 9)
    { Race.Universal, 58756, 76, 58755, 0 }, -- Healing Stream Totem (Rank 8)
    { Race.Universal, 58773, 76, 58771, 0 }, -- Mana Spring Totem (Rank 7)
    { Race.Universal, 58789, 76, 58785, 0 }, -- Flametongue Weapon (Rank 9)
    { Race.Universal, 58795, 76, 58794, 0 }, -- Frostbrand Weapon (Rank 8)
    { Race.Universal, 58803, 76, 58801, 0 }, -- Windfury Weapon (Rank 7)
    { Race.Universal, 49276, 77, 49275, 0 }, -- Lesser Healing Wave (Rank 9)
    { Race.Universal, 49236, 78, 49235, 0 }, -- Frost Shock (Rank 7)
    { Race.Universal, 58582, 78, 58581, 0 }, -- Stoneclaw Totem (Rank 10)
    { Race.Universal, 58734, 78, 58731, 0 }, -- Magma Totem (Rank 7)
    { Race.Universal, 58753, 78, 58751, 0 }, -- Stoneskin Totem (Rank 10)
    { Race.Universal, 49231, 79, 49230, 0 }, -- Earth Shock (Rank 10)
    { Race.Universal, 49238, 79, 49237, 0 }, -- Lightning Bolt (Rank 14)
    { Race.Universal, 49233, 80, 49232, 0 }, -- Flame Shock (Rank 9)
    { Race.Universal, 49271, 80, 49270, 0 }, -- Chain Lightning (Rank 8)
    { Race.Universal, 49273, 80, 49272, 0 }, -- Healing Wave (Rank 14)
    { Race.Universal, 49277, 80, 25590, 0 }, -- Ancestral Spirit (Rank 7)
    { Race.Universal, 49281, 80, 49280, 0 }, -- Lightning Shield (Rank 11)
    { Race.Universal, 51514, 80, -1, 0 }, -- Hex
    { Race.Universal, 51994, 80, 51993, 0 }, -- Earthliving Weapon (Rank 6)
    { Race.Universal, 55459, 80, 55458, 0 }, -- Chain Heal (Rank 7)
    { Race.Universal, 58643, 80, 57622, 0 }, -- Strength of Earth Totem (Rank 8)
    { Race.Universal, 58656, 80, 58652, 0 }, -- Flametongue Totem (Rank 8)
    { Race.Universal, 58704, 80, 58703, 0 }, -- Searing Totem (Rank 10)
    { Race.Universal, 58739, 80, 58737, 0 }, -- Fire Resistance Totem (Rank 6)
    { Race.Universal, 58745, 80, 58741, 0 }, -- Frost Resistance Totem (Rank 6)
    { Race.Universal, 58749, 80, 58746, 0 }, -- Nature Resistance Totem (Rank 6)
    { Race.Universal, 58757, 80, 58756, 0 }, -- Healing Stream Totem (Rank 9)
    { Race.Universal, 58774, 80, 58773, 0 }, -- Mana Spring Totem (Rank 8)
    { Race.Universal, 58790, 80, 58789, 0 }, -- Flametongue Weapon (Rank 10)
    { Race.Universal, 58796, 80, 58795, 0 }, -- Frostbrand Weapon (Rank 9)
    { Race.Universal, 58804, 80, 58803, 0 }, -- Windfury Weapon (Rank 8)
    { Race.Universal, 60043, 80, 51505, 0 }, -- Lava Burst (Rank 2)
    { Race.Universal, 61657, 80, 61649, 0 }}, -- Fire Nova (Rank 9)
    -- Mage
    {{ Race.Universal, 133, 1, -1, 0 }, -- Fireball (Rank 1)
    { Race.Universal, 168, 1, -1, 0 }, -- Frost Armor (Rank 1)
    { Race.Universal, 1459, 1, -1, 0 }, -- Arcane Intellect (Rank 1)
    { Race.Universal, 116, 4, -1, 0 }, -- Frostbolt (Rank 1)
    { Race.Universal, 5504, 4, -1, 0 }, -- Conjure Water (Rank 1)
    { Race.Universal, 143, 6, 133, 0 }, -- Fireball (Rank 2)
    { Race.Universal, 587, 6, -1, 0 }, -- Conjure Food (Rank 1)
    { Race.Universal, 2136, 6, -1, 0 }, -- Fire Blast (Rank 1)
    { Race.Universal, 118, 8, -1, 0 }, -- Polymorph (Rank 1)
    { Race.Universal, 205, 8, 116, 0 }, -- Frostbolt (Rank 2)
    { Race.Universal, 5143, 8, -1, 0 }, -- Arcane Missiles (Rank 1)
    { Race.Universal, 122, 10, -1, 0 }, -- Frost Nova (Rank 1)
    { Race.Universal, 5505, 10, 5504, 0 }, -- Conjure Water (Rank 2)
    { Race.Universal, 7300, 10, 168, 0 }, -- Frost Armor (Rank 2)
    { Race.Universal, 130, 12, -1, 0 }, -- Slow Fall
    { Race.Universal, 145, 12, 143, 0 }, -- Fireball (Rank 3)
    { Race.Universal, 597, 12, 587, 0 }, -- Conjure Food (Rank 2)
    { Race.Universal, 604, 12, -1, 0 }, -- Dampen Magic (Rank 1)
    { Race.Universal, 837, 14, 205, 0 }, -- Frostbolt (Rank 3)
    { Race.Universal, 1449, 14, -1, 0 }, -- Arcane Explosion (Rank 1)
    { Race.Universal, 1460, 14, 1459, 0 }, -- Arcane Intellect (Rank 2)
    { Race.Universal, 2137, 14, 2136, 0 }, -- Fire Blast (Rank 2)
    { Race.Universal, 2120, 16, -1, 0 }, -- Flamestrike (Rank 1)
    { Race.Universal, 5144, 16, 5143, 0 }, -- Arcane Missiles (Rank 2)
    { Race.Universal, 475, 18, -1, 0 }, -- Remove Curse
    { Race.Universal, 1008, 18, -1, 0 }, -- Amplify Magic (Rank 1)
    { Race.Universal, 3140, 18, 145, 0 }, -- Fireball (Rank 4)
    { Race.Universal, 10, 20, -1, 0 }, -- Blizzard (Rank 1)
    { Race.Universal, 543, 20, -1, 0 }, -- Fire Ward (Rank 1)
    { Race.Universal, 1463, 20, -1, 0 }, -- Mana Shield (Rank 1)
    { Race.Universal, 1953, 20, -1, 0 }, -- Blink
    { Race.Universal, 5506, 20, 5505, 0 }, -- Conjure Water (Rank 3)
    { Race.Universal, 7301, 20, 7300, 0 }, -- Frost Armor (Rank 3)
    { Race.Universal, 7322, 20, 837, 0 }, -- Frostbolt (Rank 4)
    { Race.Universal, 12051, 20, -1, 0 }, -- Evocation
    { Race.Universal, 12824, 20, 118, 0 }, -- Polymorph (Rank 2)
    { Race.Universal, 990, 22, 597, 0 }, -- Conjure Food (Rank 3)
    { Race.Universal, 2138, 22, 2137, 0 }, -- Fire Blast (Rank 3)
    { Race.Universal, 2948, 22, -1, 0 }, -- Scorch (Rank 1)
    { Race.Universal, 6143, 22, -1, 0 }, -- Frost Ward (Rank 1)
    { Race.Universal, 8437, 22, 1449, 0 }, -- Arcane Explosion (Rank 2)
    { Race.Universal, 2121, 24, 2120, 0 }, -- Flamestrike (Rank 2)
    { Race.Universal, 2139, 24, -1, 0 }, -- Counterspell
    { Race.Universal, 5145, 24, 5144, 0 }, -- Arcane Missiles (Rank 3)
    { Race.Universal, 8400, 24, 3140, 0 }, -- Fireball (Rank 5)
    { Race.Universal, 8450, 24, 604, 0 }, -- Dampen Magic (Rank 2)
    { Race.Universal, 120, 26, -1, 0 }, -- Cone of Cold (Rank 1)
    { Race.Universal, 865, 26, 122, 0 }, -- Frost Nova (Rank 2)
    { Race.Universal, 8406, 26, 7322, 0 }, -- Frostbolt (Rank 5)
    { Race.Universal, 759, 28, -1, 0 }, -- Conjure Mana Gem (Rank 1)
    { Race.Universal, 1461, 28, 1460, 0 }, -- Arcane Intellect (Rank 3)
    { Race.Universal, 6141, 28, 10, 0 }, -- Blizzard (Rank 2)
    { Race.Universal, 8444, 28, 2948, 0 }, -- Scorch (Rank 2)
    { Race.Universal, 8494, 28, 1463, 0 }, -- Mana Shield (Rank 2)
    { Race.Universal, 6127, 30, 5506, 0 }, -- Conjure Water (Rank 4)
    { Race.Universal, 7302, 30, -1, 0 }, -- Ice Armor (Rank 1)
    { Race.Universal, 8401, 30, 8400, 0 }, -- Fireball (Rank 6)
    { Race.Universal, 8412, 30, 2138, 0 }, -- Fire Blast (Rank 4)
    { Race.Universal, 8438, 30, 8437, 0 }, -- Arcane Explosion (Rank 3)
    { Race.Universal, 8455, 30, 1008, 0 }, -- Amplify Magic (Rank 2)
    { Race.Universal, 8457, 30, 543, 0 }, -- Fire Ward (Rank 2)
    { Race.Universal, 45438, 30, -1, 0 }, -- Ice Block
    { Race.Universal, 6129, 32, 990, 0 }, -- Conjure Food (Rank 4)
    { Race.Universal, 8407, 32, 8406, 0 }, -- Frostbolt (Rank 6)
    { Race.Universal, 8416, 32, 5145, 0 }, -- Arcane Missiles (Rank 4)
    { Race.Universal, 8422, 32, 2121, 0 }, -- Flamestrike (Rank 3)
    { Race.Universal, 8461, 32, 6143, 0 }, -- Frost Ward (Rank 2)
    { Race.Universal, 6117, 34, -1, 0 }, -- Mage Armor (Rank 1)
    { Race.Universal, 8445, 34, 8444, 0 }, -- Scorch (Rank 3)
    { Race.Universal, 8492, 34, 120, 0 }, -- Cone of Cold (Rank 2)
    { Race.Universal, 8402, 36, 8401, 0 }, -- Fireball (Rank 7)
    { Race.Universal, 8427, 36, 6141, 0 }, -- Blizzard (Rank 3)
    { Race.Universal, 8451, 36, 8450, 0 }, -- Dampen Magic (Rank 3)
    { Race.Universal, 8495, 36, 8494, 0 }, -- Mana Shield (Rank 3)
    { Race.Universal, 3552, 38, 759, 0 }, -- Conjure Mana Gem (Rank 2)
    { Race.Universal, 8408, 38, 8407, 0 }, -- Frostbolt (Rank 7)
    { Race.Universal, 8413, 38, 8412, 0 }, -- Fire Blast (Rank 5)
    { Race.Universal, 8439, 38, 8438, 0 }, -- Arcane Explosion (Rank 4)
    { Race.Universal, 6131, 40, 865, 0 }, -- Frost Nova (Rank 3)
    { Race.Universal, 7320, 40, 7302, 0 }, -- Ice Armor (Rank 2)
    { Race.Universal, 8417, 40, 8416, 0 }, -- Arcane Missiles (Rank 5)
    { Race.Universal, 8423, 40, 8422, 0 }, -- Flamestrike (Rank 4)
    { Race.Universal, 8446, 40, 8445, 0 }, -- Scorch (Rank 4)
    { Race.Universal, 8458, 40, 8457, 0 }, -- Fire Ward (Rank 3)
    { Race.Universal, 10138, 40, 6127, 0 }, -- Conjure Water (Rank 5)
    { Race.Universal, 12825, 40, 12824, 0 }, -- Polymorph (Rank 3)
    { Race.Universal, 8462, 42, 8461, 0 }, -- Frost Ward (Rank 3)
    { Race.Universal, 10144, 42, 6129, 0 }, -- Conjure Food (Rank 5)
    { Race.Universal, 10148, 42, 8402, 0 }, -- Fireball (Rank 8)
    { Race.Universal, 10156, 42, 1461, 0 }, -- Arcane Intellect (Rank 4)
    { Race.Universal, 10159, 42, 8492, 0 }, -- Cone of Cold (Rank 3)
    { Race.Universal, 10169, 42, 8455, 0 }, -- Amplify Magic (Rank 3)
    { Race.Universal, 10179, 44, 8408, 0 }, -- Frostbolt (Rank 8)
    { Race.Universal, 10185, 44, 8427, 0 }, -- Blizzard (Rank 4)
    { Race.Universal, 10191, 44, 8495, 0 }, -- Mana Shield (Rank 4)
    { Race.Universal, 10197, 46, 8413, 0 }, -- Fire Blast (Rank 6)
    { Race.Universal, 10201, 46, 8439, 0 }, -- Arcane Explosion (Rank 5)
    { Race.Universal, 10205, 46, 8446, 0 }, -- Scorch (Rank 5)
    { Race.Universal, 22782, 46, 6117, 0 }, -- Mage Armor (Rank 2)
    { Race.Universal, 10053, 48, 3552, 0 }, -- Conjure Mana Gem (Rank 3)
    { Race.Universal, 10149, 48, 10148, 0 }, -- Fireball (Rank 9)
    { Race.Universal, 10173, 48, 8451, 0 }, -- Dampen Magic (Rank 4)
    { Race.Universal, 10211, 48, 8417, 0 }, -- Arcane Missiles (Rank 6)
    { Race.Universal, 10215, 48, 8423, 0 }, -- Flamestrike (Rank 5)
    { Race.Universal, 10139, 50, 10138, 0 }, -- Conjure Water (Rank 6)
    { Race.Universal, 10160, 50, 10159, 0 }, -- Cone of Cold (Rank 4)
    { Race.Universal, 10180, 50, 10179, 0 }, -- Frostbolt (Rank 9)
    { Race.Universal, 10219, 50, 7320, 0 }, -- Ice Armor (Rank 3)
    { Race.Universal, 10223, 50, 8458, 0 }, -- Fire Ward (Rank 4)
    { Race.Universal, 10145, 52, 10144, 0 }, -- Conjure Food (Rank 6)
    { Race.Universal, 10177, 52, 8462, 0 }, -- Frost Ward (Rank 4)
    { Race.Universal, 10186, 52, 10185, 0 }, -- Blizzard (Rank 5)
    { Race.Universal, 10192, 52, 10191, 0 }, -- Mana Shield (Rank 5)
    { Race.Universal, 10206, 52, 10205, 0 }, -- Scorch (Rank 6)
    { Race.Universal, 10150, 54, 10149, 0 }, -- Fireball (Rank 10)
    { Race.Universal, 10170, 54, 10169, 0 }, -- Amplify Magic (Rank 4)
    { Race.Universal, 10199, 54, 10197, 0 }, -- Fire Blast (Rank 7)
    { Race.Universal, 10202, 54, 10201, 0 }, -- Arcane Explosion (Rank 6)
    { Race.Universal, 10230, 54, 6131, 0 }, -- Frost Nova (Rank 4)
    { Race.Universal, 10157, 56, 10156, 0 }, -- Arcane Intellect (Rank 5)
    { Race.Universal, 10181, 56, 10180, 0 }, -- Frostbolt (Rank 10)
    { Race.Universal, 10212, 56, 10211, 0 }, -- Arcane Missiles (Rank 7)
    { Race.Universal, 10216, 56, 10215, 0 }, -- Flamestrike (Rank 6)
    { Race.Universal, 23028, 56, -1, 0 }, -- Arcane Brilliance (Rank 1)
    { Race.Universal, 10054, 58, 10053, 0 }, -- Conjure Mana Gem (Rank 4)
    { Race.Universal, 10161, 58, 10160, 0 }, -- Cone of Cold (Rank 5)
    { Race.Universal, 10207, 58, 10206, 0 }, -- Scorch (Rank 7)
    { Race.Universal, 22783, 58, 22782, 0 }, -- Mage Armor (Rank 3)
    { Race.Universal, 10140, 60, 10139, 0 }, -- Conjure Water (Rank 7)
    { Race.Universal, 10151, 60, 10150, 0 }, -- Fireball (Rank 11)
    { Race.Universal, 10174, 60, 10173, 0 }, -- Dampen Magic (Rank 5)
    { Race.Universal, 10187, 60, 10186, 0 }, -- Blizzard (Rank 6)
    { Race.Universal, 10193, 60, 10192, 0 }, -- Mana Shield (Rank 6)
    { Race.Universal, 10220, 60, 10219, 0 }, -- Ice Armor (Rank 4)
    { Race.Universal, 10225, 60, 10223, 0 }, -- Fire Ward (Rank 5)
    { Race.Universal, 12826, 60, 12825, 0 }, -- Polymorph (Rank 4)
    { Race.Universal, 25304, 60, 10181, 0 }, -- Frostbolt (Rank 11)
    { Race.Universal, 25306, 60, 10151, 0 }, -- Fireball (Rank 12)
    { Race.Universal, 25345, 60, 10212, 0 }, -- Arcane Missiles (Rank 8)
    { Race.Universal, 28609, 60, 10177, 0 }, -- Frost Ward (Rank 5)
    { Race.Universal, 28612, 60, 10145, 0 }, -- Conjure Food (Rank 7)
    { Race.Universal, 27078, 61, 10199, 0 }, -- Fire Blast (Rank 8)
    { Race.Universal, 27080, 62, 10202, 0 }, -- Arcane Explosion (Rank 7)
    { Race.Universal, 30482, 62, -1, 0 }, -- Molten Armor (Rank 1)
    { Race.Universal, 27071, 63, 25304, 0 }, -- Frostbolt (Rank 12)
    { Race.Universal, 27075, 63, 25345, 0 }, -- Arcane Missiles (Rank 9)
    { Race.Universal, 27130, 63, 10170, 0 }, -- Amplify Magic (Rank 5)
    { Race.Universal, 27086, 64, 10216, 0 }, -- Flamestrike (Rank 7)
    { Race.Universal, 30451, 64, -1, 0 }, -- Arcane Blast (Rank 1)
    { Race.Universal, 27073, 65, 10207, 0 }, -- Scorch (Rank 8)
    { Race.Universal, 27087, 65, 10161, 0 }, -- Cone of Cold (Rank 6)
    { Race.Universal, 37420, 65, 10140, 0 }, -- Conjure Water (Rank 8)
    { Race.Universal, 27070, 66, 25306, 0 }, -- Fireball (Rank 13)
    { Race.Universal, 30455, 66, -1, 0 }, -- Ice Lance (Rank 1)
    { Race.Universal, 27088, 67, 10230, 0 }, -- Frost Nova (Rank 5)
    { Race.Universal, 33944, 67, 10174, 0 }, -- Dampen Magic (Rank 6)
    { Race.Universal, 66, 68, -1, 0 }, -- Invisibility
    { Race.Universal, 27085, 68, 10187, 0 }, -- Blizzard (Rank 7)
    { Race.Universal, 27101, 68, 10054, 0 }, -- Conjure Mana Gem (Rank 5)
    { Race.Universal, 27131, 68, 10193, 0 }, -- Mana Shield (Rank 7)
    { Race.Universal, 27072, 69, 27071, 0 }, -- Frostbolt (Rank 13)
    { Race.Universal, 27124, 69, 10220, 0 }, -- Ice Armor (Rank 5)
    { Race.Universal, 27125, 69, 22783, 0 }, -- Mage Armor Armor 4
    { Race.Universal, 27128, 69, 10225, 0 }, -- Fire Ward (Rank 6)
    { Race.Universal, 33946, 69, 27130, 0 }, -- Amplify Magic (Rank 6)
    { Race.Universal, 38699, 69, 27075, 0 }, -- Arcane Missiles (Rank 10)
    { Race.Universal, 27074, 70, 27073, 0 }, -- Scorch (Rank 9)
    { Race.Universal, 27079, 70, 27078, 0 }, -- Fire Blast (Rank 9)
    { Race.Universal, 27082, 70, 27080, 0 }, -- Arcane Explosion (Rank 8)
    { Race.Universal, 27090, 70, 37420, 0 }, -- Conjure Water (Rank 9)
    { Race.Universal, 27126, 70, 10157, 0 }, -- Arcane Intellect (Rank 6)
    { Race.Universal, 27127, 70, 23028, 0 }, -- Arcane Brilliance (Rank 2)
    { Race.Universal, 30449, 70, -1, 0 }, -- Spellsteal
    { Race.Universal, 32796, 70, 28609, 0 }, -- Frost Ward (Rank 6)
    { Race.Universal, 33717, 70, 28612, 0 }, -- Conjure Food (Rank 8)
    { Race.Universal, 38692, 70, 27070, 0 }, -- Fireball (Rank 14)
    { Race.Universal, 38697, 70, 27072, 0 }, -- Frostbolt (Rank 14)
    { Race.Universal, 38704, 70, 38699, 0 }, -- Arcane Missiles (Rank 11)
    { Race.Universal, 43987, 70, -1, 0 }, -- Ritual of Refreshment
    { Race.Universal, 42894, 71, 30451, 0 }, -- Arcane Blast (Rank 2)
    { Race.Universal, 43023, 71, 27125, 0 }, -- Mage Armor (Rank 5)
    { Race.Universal, 43045, 71, 30482, 0 }, -- Molten Armor (Rank 2)
    { Race.Universal, 42913, 72, 30455, 0 }, -- Ice Lance (Rank 2)
    { Race.Universal, 42925, 72, 27086, 0 }, -- Flamestrike (Rank 8)
    { Race.Universal, 42930, 72, 27087, 0 }, -- Cone of Cold (Rank 7)
    { Race.Universal, 42858, 73, 27074, 0 }, -- Scorch (Rank 10)
    { Race.Universal, 43019, 73, 27131, 0 }, -- Mana Shield (Rank 8)
    { Race.Universal, 42832, 74, 38692, 0 }, -- Fireball (Rank 15)
    { Race.Universal, 42872, 74, 27079, 0 }, -- Fire Blast (Rank 10)
    { Race.Universal, 42939, 74, 27085, 0 }, -- Blizzard (Rank 8)
    { Race.Universal, 42841, 75, 38697, 0 }, -- Frostbolt (Rank 15)
    { Race.Universal, 42843, 75, 38704, 0 }, -- Arcane Missiles (Rank 12)
    { Race.Universal, 42917, 75, 27088, 0 }, -- Frost Nova (Rank 6)
    { Race.Universal, 42955, 75, -1, 0 }, -- Conjure Refreshment (Rank 1)
    { Race.Universal, 44614, 75, -1, 0 }, -- Frostfire Bolt (Rank 1)
    { Race.Universal, 42896, 76, 42894, 0 }, -- Arcane Blast (Rank 3)
    { Race.Universal, 42920, 76, 27082, 0 }, -- Arcane Explosion (Rank 9)
    { Race.Universal, 43015, 76, 33944, 0 }, -- Dampen Magic (Rank 7)
    { Race.Universal, 42985, 77, 27101, 0 }, -- Conjure Mana Gem (Rank 6)
    { Race.Universal, 43017, 77, 33946, 0 }, -- Amplify Magic (Rank 7)
    { Race.Universal, 42833, 78, 42832, 0 }, -- Fireball (Rank 16)
    { Race.Universal, 42859, 78, 42858, 0 }, -- Scorch (Rank 11)
    { Race.Universal, 42914, 78, 42913, 0 }, -- Ice Lance (Rank 3)
    { Race.Universal, 43010, 78, 27128, 0 }, -- Fire Ward (Rank 7)
    { Race.Universal, 42842, 79, 42841, 0 }, -- Frostbolt (Rank 16)
    { Race.Universal, 42846, 79, 42843, 0 }, -- Arcane Missiles (Rank 13)
    { Race.Universal, 42926, 79, 42925, 0 }, -- Flamestrike (Rank 9)
    { Race.Universal, 42931, 79, 42930, 0 }, -- Cone of Cold (Rank 8)
    { Race.Universal, 43008, 79, 27124, 0 }, -- Ice Armor (Rank 6)
    { Race.Universal, 43012, 79, 32796, 0 }, -- Frost Ward (Rank 7)
    { Race.Universal, 43020, 79, 43019, 0 }, -- Mana Shield (Rank 9)
    { Race.Universal, 43024, 79, 43023, 0 }, -- Mage Armor (Rank 6)
    { Race.Universal, 43046, 79, 43045, 0 }, -- Molten Armor (Rank 3)
    { Race.Universal, 42873, 80, 42872, 0 }, -- Fire Blast (Rank 11)
    { Race.Universal, 42897, 80, 42896, 0 }, -- Arcane Blast (Rank 4)
    { Race.Universal, 42921, 80, 42920, 0 }, -- Arcane Explosion (Rank 10)
    { Race.Universal, 42940, 80, 42939, 0 }, -- Blizzard (Rank 9)
    { Race.Universal, 42956, 80, 42955, 0 }, -- Conjure Refreshment (Rank 2)
    { Race.Universal, 42995, 80, 27126, 0 }, -- Arcane Intellect (Rank 7)
    { Race.Universal, 43002, 80, 27127, 0 }, -- Arcane Brilliance (Rank 3)
    { Race.Universal, 47610, 80, 44614, 0 }, -- Frostfire Bolt (Rank 2)
    { Race.Universal, 55342, 80, -1, 0 }, -- Mirror Image
    { Race.Universal, 58659, 80, -1, 0 }}, -- Ritual of Refreshment
    -- Warlock
    {{ Race.Universal, 348, 1, -1, 0 }, -- Immolate (Rank 1)
    { Race.Universal, 686, 1, -1, 0 }, -- Shadow Bolt (Rank 1)
    { Race.Universal, 687, 1, -1, 0 }, -- Demon Skin (Rank 1)
    { Race.Universal, 688, 1, -1, 0 }, -- Summon Imp
    { Race.Universal, 172, 4, -1, 0 }, -- Corruption (Rank 1)
    { Race.Universal, 702, 4, -1, 0 }, -- Curse of Weakness (Rank 1)
    { Race.Universal, 695, 6, 686, 0 }, -- Shadow Bolt (Rank 2)
    { Race.Universal, 1454, 6, -1, 0 }, -- Life Tap (Rank 1)
    { Race.Universal, 980, 8, -1, 0 }, -- Curse of Agony (Rank 1)
    { Race.Universal, 5782, 8, -1, 0 }, -- Fear (Rank 1)
    { Race.Universal, 696, 10, 687, 0 }, -- Demon Skin (Rank 2)
    { Race.Universal, 697, 10, -1, 1 }, -- Summon Voidwalker
    { Race.Universal, 707, 10, 348, 0 }, -- Immolate (Rank 2)
    { Race.Universal, 1120, 10, -1, 0 }, -- Drain Soul (Rank 1)
    { Race.Universal, 6201, 10, -1, 0 }, -- Create Healthstone (Rank 1)
    { Race.Universal, 705, 12, 695, 0 }, -- Shadow Bolt (Rank 3)
    { Race.Universal, 755, 12, -1, 0 }, -- Health Funnel (Rank 1)
    { Race.Universal, 1108, 12, 702, 0 }, -- Curse of Weakness (Rank 2)
    { Race.Universal, 689, 14, -1, 0 }, -- Drain Life (Rank 1)
    { Race.Universal, 6222, 14, 172, 0 }, -- Corruption (Rank 2)
    { Race.Universal, 1455, 16, 1454, 0 }, -- Life Tap (Rank 2)
    { Race.Universal, 5697, 16, -1, 0 }, -- Unending Breath
    { Race.Universal, 693, 18, -1, 0 }, -- Create Soulstone (Rank 1)
    { Race.Universal, 1014, 18, 980, 0 }, -- Curse of Agony (Rank 2)
    { Race.Universal, 5676, 18, -1, 0 }, -- Searing Pain (Rank 1)
    { Race.Universal, 698, 20, -1, 0 }, -- Ritual of Summoning
    { Race.Universal, 706, 20, -1, 0 }, -- Demon Armor (Rank 1)
    { Race.Universal, 712, 20, -1, 1 }, -- Summon Succubus
    { Race.Universal, 1088, 20, 705, 0 }, -- Shadow Bolt (Rank 4)
    { Race.Universal, 1094, 20, 707, 0 }, -- Immolate (Rank 3)
    { Race.Universal, 3698, 20, 755, 0 }, -- Health Funnel (Rank 2)
    { Race.Universal, 5740, 20, -1, 0 }, -- Rain of Fire (Rank 1)
    { Race.Universal, 126, 22, -1, 0 }, -- Eye of Kilrogg
    { Race.Universal, 699, 22, 689, 0 }, -- Drain Life (Rank 2)
    { Race.Universal, 6202, 22, 6201, 0 }, -- Create Healthstone (Rank 2)
    { Race.Universal, 6205, 22, 1108, 0 }, -- Curse of Weakness (Rank 3)
    { Race.Universal, 5138, 24, -1, 0 }, -- Drain Mana
    { Race.Universal, 5500, 24, -1, 0 }, -- Sense Demons
    { Race.Universal, 6223, 24, 6222, 0 }, -- Corruption (Rank 3)
    { Race.Universal, 8288, 24, 1120, 0 }, -- Drain Soul (Rank 2)
    { Race.Universal, 132, 26, -1, 0 }, -- Detect Invisibility
    { Race.Universal, 1456, 26, 1455, 0 }, -- Life Tap (Rank 3)
    { Race.Universal, 1714, 26, -1, 0 }, -- Curse of Tongues (Rank 1)
    { Race.Universal, 17919, 26, 5676, 0 }, -- Searing Pain (Rank 2)
    { Race.Universal, 710, 28, -1, 0 }, -- Banish (Rank 1)
    { Race.Universal, 1106, 28, 1088, 0 }, -- Shadow Bolt (Rank 5)
    { Race.Universal, 3699, 28, 3698, 0 }, -- Health Funnel (Rank 3)
    { Race.Universal, 6217, 28, 1014, 0 }, -- Curse of Agony (Rank 3)
    { Race.Universal, 6366, 28, -1, 0 }, -- Create Firestone (Rank 1)
    { Race.Universal, 691, 30, -1, 1 }, -- Summon Felhunter
    { Race.Universal, 709, 30, 699, 0 }, -- Drain Life (Rank 3)
    { Race.Universal, 1086, 30, 706, 0 }, -- Demon Armor (Rank 2)
    { Race.Universal, 1098, 30, -1, 0 }, -- Enslave Demon (Rank 1)
    { Race.Universal, 1949, 30, -1, 0 }, -- Hellfire (Rank 1)
    { Race.Universal, 2941, 30, 1094, 0 }, -- Immolate (Rank 4)
    { Race.Universal, 20752, 30, 693, 0 }, -- Create Soulstone (Rank 2)
    { Race.Universal, 1490, 32, -1, 0 }, -- Curse of the Elements (Rank 1)
    { Race.Universal, 6213, 32, 5782, 0 }, -- Fear (Rank 2)
    { Race.Universal, 6229, 32, -1, 0 }, -- Shadow Ward (Rank 1)
    { Race.Universal, 7646, 32, 6205, 0 }, -- Curse of Weakness (Rank 4)
    { Race.Universal, 5699, 34, 6202, 0 }, -- Create Healthstone (Rank 3)
    { Race.Universal, 6219, 34, 5740, 0 }, -- Rain of Fire (Rank 2)
    { Race.Universal, 7648, 34, 6223, 0 }, -- Corruption (Rank 4)
    { Race.Universal, 17920, 34, 17919, 0 }, -- Searing Pain (Rank 3)
    { Race.Universal, 2362, 36, -1, 0 }, -- Create Spellstone (Rank 1)
    { Race.Universal, 3700, 36, 3699, 0 }, -- Health Funnel (Rank 4)
    { Race.Universal, 7641, 36, 1106, 0 }, -- Shadow Bolt (Rank 6)
    { Race.Universal, 11687, 36, 1456, 0 }, -- Life Tap (Rank 4)
    { Race.Universal, 17951, 36, 6366, 0 }, -- Create Firestone (Rank 2)
    { Race.Universal, 7651, 38, 709, 0 }, -- Drain Life (Rank 4)
    { Race.Universal, 8289, 38, 8288, 0 }, -- Drain Soul (Rank 3)
    { Race.Universal, 11711, 38, 6217, 0 }, -- Curse of Agony (Rank 4)
    { Race.Universal, 5484, 40, -1, 0 }, -- Howl of Terror (Rank 1)
    { Race.Universal, 11665, 40, 2941, 0 }, -- Immolate (Rank 5)
    { Race.Universal, 11733, 40, 1086, 0 }, -- Demon Armor (Rank 3)
    { Race.Universal, 20755, 40, 20752, 0 }, -- Create Soulstone (Rank 3)
    { Race.Universal, 6789, 42, -1, 0 }, -- Death Coil (Rank 1)
    { Race.Universal, 11683, 42, 1949, 0 }, -- Hellfire (Rank 2)
    { Race.Universal, 11707, 42, 7646, 0 }, -- Curse of Weakness (Rank 5)
    { Race.Universal, 11739, 42, 6229, 0 }, -- Shadow Ward (Rank 2)
    { Race.Universal, 17921, 42, 17920, 0 }, -- Searing Pain (Rank 4)
    { Race.Universal, 11659, 44, 7641, 0 }, -- Shadow Bolt (Rank 7)
    { Race.Universal, 11671, 44, 7648, 0 }, -- Corruption (Rank 5)
    { Race.Universal, 11693, 44, 3700, 0 }, -- Health Funnel (Rank 5)
    { Race.Universal, 11725, 44, 1098, 0 }, -- Enslave Demon (Rank 2)
    { Race.Universal, 11677, 46, 6219, 0 }, -- Rain of Fire (Rank 3)
    { Race.Universal, 11688, 46, 11687, 0 }, -- Life Tap (Rank 5)
    { Race.Universal, 11699, 46, 7651, 0 }, -- Drain Life (Rank 5)
    { Race.Universal, 11721, 46, 1490, 0 }, -- Curse of the Elements (Rank 2)
    { Race.Universal, 11729, 46, 5699, 0 }, -- Create Healthstone (Rank 4)
    { Race.Universal, 17952, 46, 17951, 0 }, -- Create Firestone (Rank 3)
    { Race.Universal, 6353, 48, -1, 0 }, -- Soul Fire (Rank 1)
    { Race.Universal, 11712, 48, 11711, 0 }, -- Curse of Agony (Rank 5)
    { Race.Universal, 17727, 48, 2362, 0 }, -- Create Spellstone (Rank 2)
    { Race.Universal, 18647, 48, 710, 0 }, -- Banish (Rank 2)
    { Race.Universal, 11667, 50, 11665, 0 }, -- Immolate (Rank 6)
    { Race.Universal, 11719, 50, 1714, 0 }, -- Curse of Tongues (Rank 2)
    { Race.Universal, 11734, 50, 11733, 0 }, -- Demon Armor (Rank 4)
    { Race.Universal, 17922, 50, 17921, 0 }, -- Searing Pain (Rank 5)
    { Race.Universal, 17925, 50, 6789, 0 }, -- Death Coil (Rank 2)
    { Race.Universal, 20756, 50, 20755, 0 }, -- Create Soulstone (Rank 4)
    { Race.Universal, 11660, 52, 11659, 0 }, -- Shadow Bolt (Rank 8)
    { Race.Universal, 11675, 52, 8289, 0 }, -- Drain Soul (Rank 4)
    { Race.Universal, 11694, 52, 11693, 0 }, -- Health Funnel (Rank 6)
    { Race.Universal, 11708, 52, 11707, 0 }, -- Curse of Weakness (Rank 6)
    { Race.Universal, 11740, 52, 11739, 0 }, -- Shadow Ward (Rank 3)
    { Race.Universal, 11672, 54, 11671, 0 }, -- Corruption (Rank 6)
    { Race.Universal, 11684, 54, 11683, 0 }, -- Hellfire (Rank 3)
    { Race.Universal, 11700, 54, 11699, 0 }, -- Drain Life (Rank 6)
    { Race.Universal, 17928, 54, 5484, 0 }, -- Howl of Terror (Rank 2)
    { Race.Universal, 6215, 56, 6213, 0 }, -- Fear (Rank 3)
    { Race.Universal, 11689, 56, 11688, 0 }, -- Life Tap (Rank 6)
    { Race.Universal, 17924, 56, 6353, 0 }, -- Soul Fire (Rank 2)
    { Race.Universal, 17953, 56, 17952, 0 }, -- Create Firestone (Rank 4)
    { Race.Universal, 11678, 58, 11677, 0 }, -- Rain of Fire (Rank 4)
    { Race.Universal, 11713, 58, 11712, 0 }, -- Curse of Agony (Rank 6)
    { Race.Universal, 11726, 58, 11725, 0 }, -- Enslave Demon (Rank 3)
    { Race.Universal, 11730, 58, 11729, 0 }, -- Create Healthstone (Rank 5)
    { Race.Universal, 17923, 58, 17922, 0 }, -- Searing Pain (Rank 6)
    { Race.Universal, 17926, 58, 17925, 0 }, -- Death Coil (Rank 3)
    { Race.Universal, 603, 60, -1, 0 }, -- Curse of Doom (Rank 1)
    { Race.Universal, 11661, 60, 11660, 0 }, -- Shadow Bolt (Rank 9)
    { Race.Universal, 11668, 60, 11667, 0 }, -- Immolate (Rank 7)
    { Race.Universal, 11695, 60, 11694, 0 }, -- Health Funnel (Rank 7)
    { Race.Universal, 11722, 60, 11721, 0 }, -- Curse of the Elements (Rank 3)
    { Race.Universal, 11735, 60, 11734, 0 }, -- Demon Armor (Rank 5)
    { Race.Universal, 17728, 60, 17727, 0 }, -- Create Spellstone (Rank 3)
    { Race.Universal, 20757, 60, 20756, 0 }, -- Create Soulstone (Rank 5)
    { Race.Universal, 25307, 60, 11661, 0 }, -- Shadow Bolt (Rank 10)
    { Race.Universal, 25309, 60, 11668, 0 }, -- Immolate (Rank 8)
    { Race.Universal, 25311, 60, 11672, 0 }, -- Corruption (Rank 7)
    { Race.Universal, 28610, 60, 11740, 0 }, -- Shadow Ward (Rank 4)
    { Race.Universal, 27224, 61, 11708, 0 }, -- Curse of Weakness (Rank 7)
    { Race.Universal, 27219, 62, 11700, 0 }, -- Drain Life (Rank 7)
    { Race.Universal, 28176, 62, -1, 0 }, -- Fel Armor (Rank 1)
    { Race.Universal, 27211, 64, 17924, 0 }, -- Soul Fire (Rank 3)
    { Race.Universal, 29722, 64, -1, 0 }, -- Incinerate (Rank 1)
    { Race.Universal, 27210, 65, 17923, 0 }, -- Searing Pain (Rank 7)
    { Race.Universal, 27216, 65, 25311, 0 }, -- Corruption (Rank 8)
    { Race.Universal, 27250, 66, 17953, 0 }, -- Create Firestone (Rank 5)
    { Race.Universal, 28172, 66, 17728, 0 }, -- Create Spellstone (Rank 4)
    { Race.Universal, 29858, 66, -1, 0 }, -- Soulshatter
    { Race.Universal, 27217, 67, 11675, 0 }, -- Drain Soul (Rank 5)
    { Race.Universal, 27218, 67, 11713, 0 }, -- Curse of Agony (Rank 7)
    { Race.Universal, 27259, 67, 11695, 0 }, -- Health Funnel (Rank 8)
    { Race.Universal, 27213, 68, 11684, 0 }, -- Hellfire (Rank 4)
    { Race.Universal, 27222, 68, 11689, 0 }, -- Life Tap (Rank 7)
    { Race.Universal, 27223, 68, 17926, 0 }, -- Death Coil (Rank 4)
    { Race.Universal, 27230, 68, 11730, 0 }, -- Create Healthstone (Rank 6)
    { Race.Universal, 29893, 68, -1, 0 }, -- Ritual of Souls (Rank 1)
    { Race.Universal, 27209, 69, 25307, 0 }, -- Shadow Bolt (Rank 11)
    { Race.Universal, 27212, 69, 11678, 0 }, -- Rain of Fire (Rank 5)
    { Race.Universal, 27215, 69, 25309, 0 }, -- Immolate (Rank 9)
    { Race.Universal, 27220, 69, 27219, 0 }, -- Drain Life (Rank 8)
    { Race.Universal, 27228, 69, 11722, 0 }, -- Curse of the Elements (Rank 4)
    { Race.Universal, 28189, 69, 28176, 0 }, -- Fel Armor (Rank 2)
    { Race.Universal, 30909, 69, 27224, 0 }, -- Curse of Weakness (Rank 8)
    { Race.Universal, 27238, 70, 20757, 0 }, -- Create Soulstone (Rank 6)
    { Race.Universal, 27243, 70, -1, 0 }, -- Seed of Corruption (Rank 1)
    { Race.Universal, 27260, 70, 11735, 0 }, -- Demon Armor (Rank 6)
    { Race.Universal, 30459, 70, 27210, 0 }, -- Searing Pain (Rank 8)
    { Race.Universal, 30545, 70, 27211, 0 }, -- Soul Fire (Rank 4)
    { Race.Universal, 30910, 70, 603, 0 }, -- Curse of Doom (Rank 2)
    { Race.Universal, 32231, 70, 29722, 0 }, -- Incinerate (Rank 2)
    { Race.Universal, 47812, 71, 27216, 0 }, -- Corruption (Rank 9)
    { Race.Universal, 50511, 71, 30909, 0 }, -- Curse of Weakness (Rank 9)
    { Race.Universal, 47819, 72, 27212, 0 }, -- Rain of Fire (Rank 6)
    { Race.Universal, 47886, 72, 28172, 0 }, -- Create Spellstone (Rank 5)
    { Race.Universal, 47890, 72, 28610, 0 }, -- Shadow Ward (Rank 5)
    { Race.Universal, 61191, 72, 11726, 0 }, -- Enslave Demon (Rank 4)
    { Race.Universal, 47859, 73, 27223, 0 }, -- Death Coil (Rank 5)
    { Race.Universal, 47863, 73, 27218, 0 }, -- Curse of Agony (Rank 8)
    { Race.Universal, 47871, 73, 27230, 0 }, -- Create Healthstone (Rank 7)
    { Race.Universal, 47808, 74, 27209, 0 }, -- Shadow Bolt (Rank 12)
    { Race.Universal, 47814, 74, 30459, 0 }, -- Searing Pain (Rank 9)
    { Race.Universal, 47837, 74, 32231, 0 }, -- Incinerate (Rank 3)
    { Race.Universal, 47892, 74, 28189, 0 }, -- Fel Armor (Rank 3)
    { Race.Universal, 60219, 74, 27250, 0 }, -- Create Firestone (Rank 6)
    { Race.Universal, 47810, 75, 27215, 0 }, -- Immolate (Rank 10)
    { Race.Universal, 47824, 75, 30545, 0 }, -- Soul Fire (Rank 5)
    { Race.Universal, 47835, 75, 27243, 0 }, -- Seed of Corruption (Rank 2)
    { Race.Universal, 47897, 75, -1, 0 }, -- Shadowflame (Rank 1)
    { Race.Universal, 47793, 76, 27260, 0 }, -- Demon Armor (Rank 7)
    { Race.Universal, 47856, 76, 27259, 0 }, -- Health Funnel (Rank 9)
    { Race.Universal, 47884, 76, 27238, 0 }, -- Create Soulstone (Rank 7)
    { Race.Universal, 47813, 77, 47812, 0 }, -- Corruption (Rank 10)
    { Race.Universal, 47855, 77, 27217, 0 }, -- Drain Soul (Rank 6)
    { Race.Universal, 47823, 78, 27213, 0 }, -- Hellfire (Rank 5)
    { Race.Universal, 47857, 78, 27220, 0 }, -- Drain Life (Rank 9)
    { Race.Universal, 47860, 78, 47859, 0 }, -- Death Coil (Rank 6)
    { Race.Universal, 47865, 78, 27228, 0 }, -- Curse of the Elements (Rank 5)
    { Race.Universal, 47888, 78, 47886, 0 }, -- Create Spellstone (Rank 6)
    { Race.Universal, 47891, 78, 47890, 0 }, -- Shadow Ward (Rank 6)
    { Race.Universal, 47809, 79, 47808, 0 }, -- Shadow Bolt (Rank 13)
    { Race.Universal, 47815, 79, 47814, 0 }, -- Searing Pain (Rank 10)
    { Race.Universal, 47820, 79, 47819, 0 }, -- Rain of Fire (Rank 7)
    { Race.Universal, 47864, 79, 47863, 0 }, -- Curse of Agony (Rank 9)
    { Race.Universal, 47878, 79, 47871, 0 }, -- Create Healthstone (Rank 8)
    { Race.Universal, 47893, 79, 47892, 0 }, -- Fel Armor (Rank 4)
    { Race.Universal, 47811, 80, 47810, 0 }, -- Immolate (Rank 11)
    { Race.Universal, 47825, 80, 47824, 0 }, -- Soul Fire (Rank 6)
    { Race.Universal, 47836, 80, 47835, 0 }, -- Seed of Corruption (Rank 3)
    { Race.Universal, 47838, 80, 47837, 0 }, -- Incinerate (Rank 4)
    { Race.Universal, 47867, 80, 30910, 0 }, -- Curse of Doom (Rank 3)
    { Race.Universal, 47889, 80, 47793, 0 }, -- Demon Armor (Rank 8)
    { Race.Universal, 48018, 80, -1, 0 }, -- Demonic Circle: Summon
    { Race.Universal, 48020, 80, -1, 0 }, -- Demonic Circle: Teleport
    { Race.Universal, 57946, 80, 27222, 0 }, -- Life Tap (Rank 8)
    { Race.Universal, 58887, 80, 29893, 0 }, -- Ritual of Souls (Rank 2)
    { Race.Universal, 60220, 80, 60219, 0 }, -- Create Firestone (Rank 7)
    { Race.Universal, 61290, 80, 47897, 0 }}, -- Shadowflame (Rank 2)
    -- Unused
    {{}},
    -- Druid
    {{ Race.Universal, 1126, 1, -1, 0 }, -- Mark of the Wild (Rank 1)
    { Race.Universal, 5176, 1, -1, 0 }, -- Wrath (Rank 1)
    { Race.Universal, 5185, 1, -1, 0 }, -- Healing Touch (Rank 1)
    { Race.Universal, 774, 4, -1, 0 }, -- Rejuvenation (Rank 1)
    { Race.Universal, 8921, 4, -1, 0 }, -- Moonfire (Rank 1)
    { Race.Universal, 467, 6, -1, 0 }, -- Thorns (Rank 1)
    { Race.Universal, 5177, 6, 5176, 0 }, -- Wrath (Rank 2)
    { Race.Universal, 339, 8, -1, 0 }, -- Entangling Roots (Rank 1)
    { Race.Universal, 5186, 8, 5185, 0 }, -- Healing Touch (Rank 2)
    { Race.Universal, 99, 10, -1, 0 }, -- Demoralizing Roar (Rank 1)
    { Race.Universal, 1058, 10, 774, 0 }, -- Rejuvenation (Rank 2)
    { Race.Universal, 5232, 10, 1126, 0 }, -- Mark of the Wild (Rank 2)
    { Race.Universal, 5487, 10, -1, 1 }, -- Bear Form (Shapeshift)
    { Race.Universal, 6795, 10, 5487, 1 }, -- Growl
    { Race.Universal, 6807, 10, 5487, 1 }, -- Maul (Rank 1)
    { Race.Universal, 8924, 10, 8921, 0 }, -- Moonfire (Rank 2)
    { Race.Universal, 16689, 10, -1, 0 }, -- Nature's Grasp (Rank 1)
    { Race.Universal, 5229, 12, -1, 0 }, -- Enrage
    { Race.Universal, 8936, 12, -1, 0 }, -- Regrowth (Rank 1)
    { Race.Universal, 50769, 12, -1, 0 }, -- Revive (Rank 1)
    { Race.Universal, 782, 14, 467, 0 }, -- Thorns (Rank 2)
    { Race.Universal, 5178, 14, 5177, 0 }, -- Wrath (Rank 3)
    { Race.Universal, 5187, 14, 5186, 0 }, -- Healing Touch (Rank 3)
    { Race.Universal, 5211, 14, -1, 0 }, -- Bash (Rank 1)
    { Race.Universal, 779, 16, -1, 0 }, -- Swipe (Bear) (Rank 1)
    { Race.Universal, 783, 16, -1, 0 }, -- Travel Form (Shapeshift)
    { Race.Universal, 1066, 16, -1, 0 }, -- Aquatic Form (Shapeshift)
    { Race.Universal, 1430, 16, 1058, 0 }, -- Rejuvenation (Rank 3)
    { Race.Universal, 8925, 16, 8924, 0 }, -- Moonfire (Rank 3)
    { Race.Universal, 770, 18, -1, 0 }, -- Faerie Fire
    { Race.Universal, 1062, 18, 339, 0 }, -- Entangling Roots (Rank 2)
    { Race.Universal, 2637, 18, -1, 0 }, -- Hibernate (Rank 1)
    { Race.Universal, 6808, 18, 6807, 0 }, -- Maul (Rank 2)
    { Race.Universal, 8938, 18, 8936, 0 }, -- Regrowth (Rank 2)
    { Race.Universal, 16810, 18, 16689, 0 }, -- Nature's Grasp (Rank 2)
    { Race.Universal, 16857, 18, -1, 0 }, -- Faerie Fire (Feral)
    { Race.Universal, 768, 20, -1, 0 }, -- Cat Form (Shapeshift)
    { Race.Universal, 1079, 20, -1, 0 }, -- Rip (Rank 1)
    { Race.Universal, 1082, 20, -1, 0 }, -- Claw (Rank 1)
    { Race.Universal, 1735, 20, 99, 0 }, -- Demoralizing Roar (Rank 2)
    { Race.Universal, 2912, 20, -1, 0 }, -- Starfire (Rank 1)
    { Race.Universal, 5188, 20, 5187, 0 }, -- Healing Touch (Rank 4)
    { Race.Universal, 5215, 20, -1, 0 }, -- Prowl
    { Race.Universal, 6756, 20, 5232, 0 }, -- Mark of the Wild (Rank 3)
    { Race.Universal, 20484, 20, -1, 0 }, -- Rebirth (Rank 1)
    { Race.Universal, 2090, 22, 1430, 0 }, -- Rejuvenation (Rank 4)
    { Race.Universal, 2908, 22, -1, 0 }, -- Soothe Animal (Rank 1)
    { Race.Universal, 5179, 22, 5178, 0 }, -- Wrath (Rank 4)
    { Race.Universal, 5221, 22, -1, 0 }, -- Shred (Rank 1)
    { Race.Universal, 8926, 22, 8925, 0 }, -- Moonfire (Rank 4)
    { Race.Universal, 780, 24, 779, 0 }, -- Swipe (Bear) (Rank 2)
    { Race.Universal, 1075, 24, 782, 0 }, -- Thorns (Rank 3)
    { Race.Universal, 1822, 24, -1, 0 }, -- Rake (Rank 1)
    { Race.Universal, 2782, 24, -1, 0 }, -- Remove Curse
    { Race.Universal, 5217, 24, -1, 0 }, -- Tiger's Fury (Rank 1)
    { Race.Universal, 8939, 24, 8938, 0 }, -- Regrowth (Rank 3)
    { Race.Universal, 50768, 24, 50769, 0 }, -- Revive (Rank 2)
    { Race.Universal, 1850, 26, -1, 0 }, -- Dash (Rank 1)
    { Race.Universal, 2893, 26, -1, 0 }, -- Abolish Poison
    { Race.Universal, 5189, 26, 5188, 0 }, -- Healing Touch (Rank 5)
    { Race.Universal, 6809, 26, 6808, 0 }, -- Maul (Rank 3)
    { Race.Universal, 8949, 26, 2912, 0 }, -- Starfire (Rank 2)
    { Race.Universal, 2091, 28, 2090, 0 }, -- Rejuvenation (Rank 5)
    { Race.Universal, 3029, 28, 1082, 0 }, -- Claw (Rank 2)
    { Race.Universal, 5195, 28, 1062, 0 }, -- Entangling Roots (Rank 3)
    { Race.Universal, 5209, 28, -1, 0 }, -- Challenging Roar
    { Race.Universal, 8927, 28, 8926, 0 }, -- Moonfire (Rank 5)
    { Race.Universal, 8998, 28, -1, 0 }, -- Cower (Rank 1)
    { Race.Universal, 9492, 28, 1079, 0 }, -- Rip (Rank 2)
    { Race.Universal, 16811, 28, 16810, 0 }, -- Nature's Grasp (Rank 3)
    { Race.Universal, 740, 30, -1, 0 }, -- Tranquility (Rank 1)
    { Race.Universal, 5180, 30, 5179, 0 }, -- Wrath (Rank 5)
    { Race.Universal, 5234, 30, 6756, 0 }, -- Mark of the Wild (Rank 4)
    { Race.Universal, 6798, 30, 5211, 0 }, -- Bash (Rank 2)
    { Race.Universal, 6800, 30, 5221, 0 }, -- Shred (Rank 2)
    { Race.Universal, 8940, 30, 8939, 0 }, -- Regrowth (Rank 4)
    { Race.Universal, 20739, 30, 20484, 0 }, -- Rebirth (Rank 2)
    { Race.Universal, 5225, 32, -1, 0 }, -- Track Humanoids
    { Race.Universal, 6778, 32, 5189, 0 }, -- Healing Touch (Rank 6)
    { Race.Universal, 6785, 32, -1, 0 }, -- Ravage (Rank 1)
    { Race.Universal, 9490, 32, 1735, 0 }, -- Demoralizing Roar (Rank 3)
    { Race.Universal, 22568, 32, -1, 0 }, -- Ferocious Bite (Rank 1)
    { Race.Universal, 769, 34, 780, 0 }, -- Swipe (Bear) (Rank 3)
    { Race.Universal, 1823, 34, 1822, 0 }, -- Rake (Rank 2)
    { Race.Universal, 3627, 34, 2091, 0 }, -- Rejuvenation (Rank 6)
    { Race.Universal, 8914, 34, 1075, 0 }, -- Thorns (Rank 4)
    { Race.Universal, 8928, 34, 8927, 0 }, -- Moonfire (Rank 6)
    { Race.Universal, 8950, 34, 8949, 0 }, -- Starfire (Rank 3)
    { Race.Universal, 8972, 34, 6809, 0 }, -- Maul (Rank 4)
    { Race.Universal, 6793, 36, 5217, 0 }, -- Tiger's Fury (Rank 2)
    { Race.Universal, 8941, 36, 8940, 0 }, -- Regrowth (Rank 5)
    { Race.Universal, 9005, 36, -1, 0 }, -- Pounce (Rank 1)
    { Race.Universal, 9493, 36, 9492, 0 }, -- Rip (Rank 3)
    { Race.Universal, 22842, 36, -1, 0 }, -- Frenzied Regeneration
    { Race.Universal, 50767, 36, 50768, 0 }, -- Revive (Rank 3)
    { Race.Universal, 5196, 38, 5195, 0 }, -- Entangling Roots (Rank 4)
    { Race.Universal, 5201, 38, 3029, 0 }, -- Claw (Rank 3)
    { Race.Universal, 6780, 38, 5180, 0 }, -- Wrath (Rank 6)
    { Race.Universal, 8903, 38, 6778, 0 }, -- Healing Touch (Rank 7)
    { Race.Universal, 8955, 38, 2908, 0 }, -- Soothe Animal (Rank 2)
    { Race.Universal, 8992, 38, 6800, 0 }, -- Shred (Rank 3)
    { Race.Universal, 16812, 38, 16811, 0 }, -- Nature's Grasp (Rank 4)
    { Race.Universal, 18657, 38, 2637, 0 }, -- Hibernate (Rank 2)
    { Race.Universal, 8907, 40, 5234, 0 }, -- Mark of the Wild (Rank 5)
    { Race.Universal, 8910, 40, 3627, 0 }, -- Rejuvenation (Rank 7)
    { Race.Universal, 8918, 40, 740, 0 }, -- Tranquility (Rank 2)
    { Race.Universal, 8929, 40, 8928, 0 }, -- Moonfire (Rank 7)
    { Race.Universal, 9000, 40, 8998, 0 }, -- Cower (Rank 2)
    { Race.Universal, 9634, 40, -1, 0 }, -- Dire Bear Form (Shapeshift)
    { Race.Universal, 16914, 40, -1, 0 }, -- Hurricane (Rank 1)
    { Race.Universal, 20719, 40, -1, 0 }, -- Feline Grace (Passive)
    { Race.Universal, 20742, 40, 20739, 0 }, -- Rebirth (Rank 3)
    { Race.Universal, 22827, 40, 22568, 0 }, -- Ferocious Bite (Rank 2)
    { Race.Universal, 29166, 40, -1, 0 }, -- Innervate
    { Race.Universal, 62600, 40, -1, 0 }, -- Savage Defense (Passive)
    { Race.Universal, 6787, 42, 6785, 0 }, -- Ravage (Rank 2)
    { Race.Universal, 8951, 42, 8950, 0 }, -- Starfire (Rank 4)
    { Race.Universal, 9745, 42, 8972, 0 }, -- Maul (Rank 5)
    { Race.Universal, 9747, 42, 9490, 0 }, -- Demoralizing Roar (Rank 4)
    { Race.Universal, 9750, 42, 8941, 0 }, -- Regrowth (Rank 6)
    { Race.Universal, 1824, 44, 1823, 0 }, -- Rake (Rank 3)
    { Race.Universal, 9752, 44, 9493, 0 }, -- Rip (Rank 4)
    { Race.Universal, 9754, 44, 769, 0 }, -- Swipe (Bear) (Rank 4)
    { Race.Universal, 9756, 44, 8914, 0 }, -- Thorns (Rank 5)
    { Race.Universal, 9758, 44, 8903, 0 }, -- Healing Touch (Rank 8)
    { Race.Universal, 22812, 44, -1, 0 }, -- Barkskin
    { Race.Universal, 8905, 46, 6780, 0 }, -- Wrath (Rank 7)
    { Race.Universal, 8983, 46, 6798, 0 }, -- Bash (Rank 3)
    { Race.Universal, 9821, 46, 1850, 0 }, -- Dash (Rank 2)
    { Race.Universal, 9823, 46, 9005, 0 }, -- Pounce (Rank 2)
    { Race.Universal, 9829, 46, 8992, 0 }, -- Shred (Rank 4)
    { Race.Universal, 9833, 46, 8929, 0 }, -- Moonfire (Rank 8)
    { Race.Universal, 9839, 46, 8910, 0 }, -- Rejuvenation (Rank 8)
    { Race.Universal, 9845, 48, 6793, 0 }, -- Tiger's Fury (Rank 3)
    { Race.Universal, 9849, 48, 5201, 0 }, -- Claw (Rank 4)
    { Race.Universal, 9852, 48, 5196, 0 }, -- Entangling Roots (Rank 5)
    { Race.Universal, 9856, 48, 9750, 0 }, -- Regrowth (Rank 7)
    { Race.Universal, 16813, 48, 16812, 0 }, -- Nature's Grasp (Rank 5)
    { Race.Universal, 22828, 48, 22827, 0 }, -- Ferocious Bite (Rank 3)
    { Race.Universal, 50766, 48, 50767, 0 }, -- Revive (Rank 4)
    { Race.Universal, 9862, 50, 8918, 0 }, -- Tranquility (Rank 3)
    { Race.Universal, 9866, 50, 6787, 0 }, -- Ravage (Rank 3)
    { Race.Universal, 9875, 50, 8951, 0 }, -- Starfire (Rank 5)
    { Race.Universal, 9880, 50, 9745, 0 }, -- Maul (Rank 6)
    { Race.Universal, 9884, 50, 8907, 0 }, -- Mark of the Wild (Rank 6)
    { Race.Universal, 9888, 50, 9758, 0 }, -- Healing Touch (Rank 9)
    { Race.Universal, 17401, 50, 16914, 0 }, -- Hurricane (Rank 2)
    { Race.Universal, 20747, 50, 20742, 0 }, -- Rebirth (Rank 4)
    { Race.Universal, 21849, 50, -1, 0 }, -- Gift of the Wild (Rank 1)
    { Race.Universal, 9834, 52, 9833, 0 }, -- Moonfire (Rank 9)
    { Race.Universal, 9840, 52, 9839, 0 }, -- Rejuvenation (Rank 9)
    { Race.Universal, 9892, 52, 9000, 0 }, -- Cower (Rank 3)
    { Race.Universal, 9894, 52, 9752, 0 }, -- Rip (Rank 5)
    { Race.Universal, 9898, 52, 9747, 0 }, -- Demoralizing Roar (Rank 5)
    { Race.Universal, 9830, 54, 9829, 0 }, -- Shred (Rank 5)
    { Race.Universal, 9857, 54, 9856, 0 }, -- Regrowth (Rank 8)
    { Race.Universal, 9901, 54, 8955, 0 }, -- Soothe Animal (Rank 3)
    { Race.Universal, 9904, 54, 1824, 0 }, -- Rake (Rank 4)
    { Race.Universal, 9908, 54, 9754, 0 }, -- Swipe (Bear) (Rank 5)
    { Race.Universal, 9910, 54, 9756, 0 }, -- Thorns (Rank 6)
    { Race.Universal, 9912, 54, 8905, 0 }, -- Wrath (Rank 8)
    { Race.Universal, 9827, 56, 9823, 0 }, -- Pounce (Rank 3)
    { Race.Universal, 9889, 56, 9888, 0 }, -- Healing Touch (Rank 10)
    { Race.Universal, 22829, 56, 22828, 0 }, -- Ferocious Bite (Rank 4)
    { Race.Universal, 9835, 58, 9834, 0 }, -- Moonfire (Rank 10)
    { Race.Universal, 9841, 58, 9840, 0 }, -- Rejuvenation (Rank 10)
    { Race.Universal, 9850, 58, 9849, 0 }, -- Claw (Rank 5)
    { Race.Universal, 9853, 58, 9852, 0 }, -- Entangling Roots (Rank 6)
    { Race.Universal, 9867, 58, 9866, 0 }, -- Ravage (Rank 4)
    { Race.Universal, 9876, 58, 9875, 0 }, -- Starfire (Rank 6)
    { Race.Universal, 9881, 58, 9880, 0 }, -- Maul (Rank 7)
    { Race.Universal, 17329, 58, 16813, 0 }, -- Nature's Grasp (Rank 6)
    { Race.Universal, 18658, 58, 18657, 0 }, -- Hibernate (Rank 3)
    { Race.Universal, 9846, 60, 9845, 0 }, -- Tiger's Fury (Rank 4)
    { Race.Universal, 9858, 60, 9857, 0 }, -- Regrowth (Rank 9)
    { Race.Universal, 9863, 60, 9862, 0 }, -- Tranquility (Rank 4)
    { Race.Universal, 9885, 60, 9884, 0 }, -- Mark of the Wild (Rank 7)
    { Race.Universal, 9896, 60, 9894, 0 }, -- Rip (Rank 6)
    { Race.Universal, 17402, 60, 17401, 0 }, -- Hurricane (Rank 3)
    { Race.Universal, 20748, 60, 20747, 0 }, -- Rebirth (Rank 5)
    { Race.Universal, 21850, 60, 21849, 0 }, -- Gift of the Wild (Rank 2)
    { Race.Universal, 25297, 60, 9889, 0 }, -- Healing Touch (Rank 11)
    { Race.Universal, 25298, 60, 9876, 0 }, -- Starfire (Rank 7)
    { Race.Universal, 25299, 60, 9841, 0 }, -- Rejuvenation (Rank 11)
    { Race.Universal, 31018, 60, 22829, 0 }, -- Ferocious Bite (Rank 5)
    { Race.Universal, 31709, 60, 9892, 0 }, -- Cower (Rank 4)
    { Race.Universal, 33943, 60, 34090, 0 }, -- Flight Form (Shapeshift)
    { Race.Universal, 50765, 60, 50766, 0 }, -- Revive (Rank 5)
    { Race.Universal, 26984, 61, 9912, 0 }, -- Wrath (Rank 9)
    { Race.Universal, 27001, 61, 9830, 0 }, -- Shred (Rank 6)
    { Race.Universal, 22570, 62, -1, 0 }, -- Maim (Rank 1)
    { Race.Universal, 26978, 62, 25297, 0 }, -- Healing Touch (Rank 12)
    { Race.Universal, 26998, 62, 9898, 0 }, -- Demoralizing Roar (Rank 6)
    { Race.Universal, 24248, 63, 31018, 0 }, -- Ferocious Bite (Rank 6)
    { Race.Universal, 26981, 63, 25299, 0 }, -- Rejuvenation (Rank 12)
    { Race.Universal, 26987, 63, 9835, 0 }, -- Moonfire (Rank 11)
    { Race.Universal, 26992, 64, 9910, 0 }, -- Thorns (Rank 7)
    { Race.Universal, 26997, 64, 9908, 0 }, -- Swipe (Bear) (Rank 6)
    { Race.Universal, 27003, 64, 9904, 0 }, -- Rake (Rank 5)
    { Race.Universal, 33763, 64, -1, 0 }, -- Lifebloom (Rank 1)
    { Race.Universal, 26980, 65, 9858, 0 }, -- Regrowth (Rank 10)
    { Race.Universal, 33357, 65, 9821, 0 }, -- Dash (Rank 3)
    { Race.Universal, 27005, 66, 9867, 0 }, -- Ravage (Rank 5)
    { Race.Universal, 27006, 66, 9827, 0 }, -- Pounce (Rank 4)
    { Race.Universal, 33745, 66, -1, 0 }, -- Lacerate (Rank 1)
    { Race.Universal, 26986, 67, 25298, 0 }, -- Starfire (Rank 8)
    { Race.Universal, 26996, 67, 9881, 0 }, -- Maul (Rank 8)
    { Race.Universal, 27000, 67, 9850, 0 }, -- Claw (Rank 6)
    { Race.Universal, 27008, 67, 9896, 0 }, -- Rip (Rank 7)
    { Race.Universal, 26989, 68, 9853, 0 }, -- Entangling Roots (Rank 7)
    { Race.Universal, 27009, 68, 17329, 0 }, -- Nature's Grasp (Rank 7)
    { Race.Universal, 26979, 69, 26978, 0 }, -- Healing Touch (Rank 13)
    { Race.Universal, 26982, 69, 26981, 0 }, -- Rejuvenation (Rank 13)
    { Race.Universal, 26985, 69, 26984, 0 }, -- Wrath (Rank 10)
    { Race.Universal, 26994, 69, 20748, 0 }, -- Rebirth (Rank 6)
    { Race.Universal, 27004, 69, 31709, 0 }, -- Cower (Rank 5)
    { Race.Universal, 50764, 69, 50765, 0 }, -- Revive (Rank 6)
    { Race.Universal, 26983, 70, 9863, 0 }, -- Tranquility (Rank 5)
    { Race.Universal, 26988, 70, 26987, 0 }, -- Moonfire (Rank 12)
    { Race.Universal, 26990, 70, 9885, 0 }, -- Mark of the Wild (Rank 8)
    { Race.Universal, 26991, 70, 21850, 0 }, -- Gift of the Wild (Rank 3)
    { Race.Universal, 26995, 70, 9901, 0 }, -- Soothe Animal (Rank 4)
    { Race.Universal, 27002, 70, 27001, 0 }, -- Shred (Rank 7)
    { Race.Universal, 27012, 70, 17402, 0 }, -- Hurricane (Rank 4)
    { Race.Universal, 33786, 70, -1, 0 }, -- Cyclone
    { Race.Universal, 40120, 70, 34091, 0 }, -- Swift Flight Form (Shapeshift)
    { Race.Universal, 48442, 71, 26980, 0 }, -- Regrowth (Rank 11)
    { Race.Universal, 48559, 71, 26998, 0 }, -- Demoralizing Roar (Rank 7)
    { Race.Universal, 49799, 71, 27008, 0 }, -- Rip (Rank 8)
    { Race.Universal, 50212, 71, 9846, 0 }, -- Tiger's Fury (Rank 5)
    { Race.Universal, 62078, 71, -1, 0 }, -- Swipe (Cat) (Rank 1)
    { Race.Universal, 48450, 72, 33763, 0 }, -- Lifebloom (Rank 2)
    { Race.Universal, 48464, 72, 26986, 0 }, -- Starfire (Rank 9)
    { Race.Universal, 48561, 72, 26997, 0 }, -- Swipe (Bear) (Rank 7)
    { Race.Universal, 48573, 72, 27003, 0 }, -- Rake (Rank 6)
    { Race.Universal, 48576, 72, 24248, 0 }, -- Ferocious Bite (Rank 7)
    { Race.Universal, 48479, 73, 26996, 0 }, -- Maul (Rank 9)
    { Race.Universal, 48567, 73, 33745, 0 }, -- Lacerate (Rank 2)
    { Race.Universal, 48569, 73, 27000, 0 }, -- Claw (Rank 7)
    { Race.Universal, 48578, 73, 27005, 0 }, -- Ravage (Rank 6)
    { Race.Universal, 48377, 74, 26979, 0 }, -- Healing Touch (Rank 14)
    { Race.Universal, 48459, 74, 26985, 0 }, -- Wrath (Rank 11)
    { Race.Universal, 49802, 74, 22570, 0 }, -- Maim (Rank 2)
    { Race.Universal, 53307, 74, 26992, 0 }, -- Thorns (Rank 8)
    { Race.Universal, 48440, 75, 26982, 0 }, -- Rejuvenation (Rank 14)
    { Race.Universal, 48446, 75, 26983, 0 }, -- Tranquility (Rank 6)
    { Race.Universal, 48462, 75, 26988, 0 }, -- Moonfire (Rank 13)
    { Race.Universal, 48571, 75, 27002, 0 }, -- Shred (Rank 8)
    { Race.Universal, 52610, 75, -1, 0 }, -- Savage Roar (Rank 1)
    { Race.Universal, 48575, 76, 27004, 0 }, -- Cower (Rank 6)
    { Race.Universal, 48443, 77, 48442, 0 }, -- Regrowth (Rank 12)
    { Race.Universal, 48560, 77, 48559, 0 }, -- Demoralizing Roar (Rank 8)
    { Race.Universal, 48562, 77, 48561, 0 }, -- Swipe (Bear) (Rank 8)
    { Race.Universal, 49803, 77, 27006, 0 }, -- Pounce (Rank 5)
    { Race.Universal, 48465, 78, 48464, 0 }, -- Starfire (Rank 10)
    { Race.Universal, 48574, 78, 48573, 0 }, -- Rake (Rank 7)
    { Race.Universal, 48577, 78, 48576, 0 }, -- Ferocious Bite (Rank 8)
    { Race.Universal, 53308, 78, 26989, 0 }, -- Entangling Roots (Rank 8)
    { Race.Universal, 53312, 78, 27009, 0 }, -- Nature's Grasp (Rank 8)
    { Race.Universal, 48378, 79, 48377, 0 }, -- Healing Touch (Rank 15)
    { Race.Universal, 48461, 79, 48459, 0 }, -- Wrath (Rank 12)
    { Race.Universal, 48477, 79, 26994, 0 }, -- Rebirth (Rank 7)
    { Race.Universal, 48480, 79, 48479, 0 }, -- Maul (Rank 10)
    { Race.Universal, 48570, 79, 48569, 0 }, -- Claw (Rank 8)
    { Race.Universal, 48579, 79, 48578, 0 }, -- Ravage (Rank 7)
    { Race.Universal, 50213, 79, 50212, 0 }, -- Tiger's Fury (Rank 6)
    { Race.Universal, 48441, 80, 48440, 0 }, -- Rejuvenation (Rank 15)
    { Race.Universal, 48447, 80, 48446, 0 }, -- Tranquility (Rank 7)
    { Race.Universal, 48451, 80, 48450, 0 }, -- Lifebloom (Rank 3)
    { Race.Universal, 48463, 80, 48462, 0 }, -- Moonfire (Rank 14)
    { Race.Universal, 48467, 80, 27012, 0 }, -- Hurricane (Rank 5)
    { Race.Universal, 48469, 80, 26990, 0 }, -- Mark of the Wild (Rank 9)
    { Race.Universal, 48470, 80, 26991, 0 }, -- Gift of the Wild (Rank 4)
    { Race.Universal, 48568, 80, 48567, 0 }, -- Lacerate (Rank 3)
    { Race.Universal, 48572, 80, 48571, 0 }, -- Shred (Rank 9)
    { Race.Universal, 49800, 80, 49799, 0 }, -- Rip (Rank 9)
    { Race.Universal, 50464, 80, -1, 0 }, -- Nourish (Rank 1)
    { Race.Universal, 50763, 80, 50764, 0 }}, -- Revive (Rank 7)
}

-- Spell id, required level, required spell id
local TalentRanks = {
    -- Warrior
    {{ 21551, 48, 12294 }, -- Mortal Strike (Rank 2)
    { 21552, 54, 21551 }, -- Mortal Strike (Rank 3)
    { 21553, 60, 21552 }, -- Mortal Strike (Rank 4)
    { 30016, 60, 20243 }, -- Devastate (Rank 2)
    { 25248, 66, 21553 }, -- Mortal Strike (Rank 5)
    { 30022, 70, 30016 }, -- Devastate (Rank 3)
    { 30330, 70, 25248 }, -- Mortal Strike (Rank 6)
    { 47485, 75, 30330 }, -- Mortal Strike (Rank 7)
    { 47497, 75, 30022 }, -- Devastate (Rank 4)
    { 47486, 80, 47485 }, -- Mortal Strike (Rank 8)
    { 47498, 80, 47497 }}, -- Devastate (Rank 5)
    -- Paladin
    {{ 20929, 48, 20473 }, -- Holy Shock (Rank 2)
    { 20927, 50, 20925 }, -- Holy Shield (Rank 2)
    { 20930, 56, 20929 }, -- Holy Shock (Rank 3)
    { 20928, 60, 20927 }, -- Holy Shield (Rank 3)
    { 25899, 60, 20911 }, -- Greater Blessing of Sanctuary
    { 32699, 60, 31935 }, -- Avenger's Shield (Rank 2)
    { 27174, 64, 20930 }, -- Holy Shock (Rank 4)
    { 27179, 70, 20928 }, -- Holy Shield (Rank 4)
    { 32700, 70, 32699 }, -- Avenger's Shield (Rank 3)
    { 33072, 70, 27174 }, -- Holy Shock (Rank 5)
    { 48824, 75, 33072 }, -- Holy Shock (Rank 6)
    { 48826, 75, 32700 }, -- Avenger's Shield (Rank 4)
    { 48951, 75, 27179 }, -- Holy Shield (Rank 5)
    { 48825, 80, 48824 }, -- Holy Shock (Rank 7)
    { 48827, 80, 48826 }, -- Avenger's Shield (Rank 5)
    { 48952, 80, 48951 }}, -- Holy Shield (Rank 6)
    -- Hunter
    {{ 20900, 28, 19434 }, -- Aimed Shot (Rank 2)
    { 20901, 36, 20900 }, -- Aimed Shot (Rank 3)
    { 20909, 42, 19306 }, -- Counterattack (Rank 2)
    { 20902, 44, 20901 }, -- Aimed Shot (Rank 4)
    { 24132, 50, 19386 }, -- Wyvern Sting (Rank 2)
    { 20903, 52, 20902 }, -- Aimed Shot (Rank 5)
    { 20910, 54, 20909 }, -- Counterattack (Rank 3)
    { 63668, 57, 3674, 0 }, -- Black Arrow (Rank 2)
    { 20904, 60, 20903 }, -- Aimed Shot (Rank 6)
    { 24133, 60, 24132 }, -- Wyvern Sting (Rank 3)
    { 63669, 63, 63668 }, -- Black Arrow (Rank 3)
    { 27067, 66, 20910 }, -- Counterattack (Rank 4)
    { 63670, 69, 63669 }, -- Black Arrow (Rank 4)
    { 27065, 70, 20904 }, -- Aimed Shot (Rank 7)
    { 27068, 70, 24133 }, -- Wyvern Sting (Rank 4)
    { 60051, 70, 53301 }, -- Explosive Shot (Rank 2)
    { 48998, 72, 27067 }, -- Counterattack (Rank 5)
    { 49011, 75, 27068 }, -- Wyvern Sting (Rank 5)
    { 49049, 75, 27065 }, -- Aimed Shot (Rank 8)
    { 60052, 75, 60051 }, -- Explosive Shot (Rank 3)
    { 63671, 75, 63670 }, -- Black Arrow (Rank 5)
    { 48999, 78, 48998 }, -- Counterattack (Rank 6)
    { 49012, 80, 49011 }, -- Wyvern Sting (Rank 6)
    { 49050, 80, 49049 }, -- Aimed Shot (Rank 9)
    { 60053, 80, 60052 }, -- Explosive Shot (Rank 4)
    { 63672, 80, 63671 }}, -- Black Arrow (Rank 6)
    -- Rogue
    {{ 17347, 46, 16511 }, -- Hemorrhage (Rank 2)
    { 34411, 50, 1329, 0 }, -- Mutilate (Rank 2)
    { 17348, 58, 17347 }, -- Hemorrhage (Rank 3)
    { 34412, 60, 34411 }, -- Mutilate (Rank 3)
    { 26864, 70, 17348 }, -- Hemorrhage (Rank 4)
    { 34413, 70, 34412 }, -- Mutilate (Rank 4)
    { 48663, 75, 34413 }, -- Mutilate (Rank 5)
    { 48660, 80, 26864 }, -- Hemorrhage (Rank 5)
    { 48666, 80, 48663 }}, -- Mutilate (Rank 6)
    -- Priest
    {{ 19238, 26, 19236 }, -- Desperate Prayer (Rank 2)
    { 17311, 28, 15407 }, -- Mind Flay (Rank 2)
    { 19240, 34, 19238 }, -- Desperate Prayer (Rank 3)
    { 17312, 36, 17311 }, -- Mind Flay (Rank 3)
    { 19241, 42, 19240 }, -- Desperate Prayer (Rank 4)
    { 17313, 44, 17312 }, -- Mind Flay (Rank 4)
    { 19242, 50, 19241 }, -- Desperate Prayer (Rank 5)
    { 27870, 50, 724 }, -- Lightwell (Rank 2)
    { 17314, 52, 17313 }, -- Mind Flay (Rank 5)
    { 34863, 56, 34861 }, -- Circle of Healing (Rank 2)
    { 19243, 58, 19242 }, -- Desperate Prayer (Rank 6)
    { 18807, 60, 17314 }, -- Mind Flay (Rank 6)
    { 27871, 60, 27870 }, -- Lightwell (Rank 3)
    { 34864, 60, 34863 }, -- Circle of Healing (Rank 3)
    { 34916, 60, 34914 }, -- Vampiric Touch (Rank 2)
    { 34865, 65, 34864 }, -- Circle of Healing (Rank 4)
    { 25437, 66, 19243 }, -- Desperate Prayer (Rank 7)
    { 25387, 68, 18807 }, -- Mind Flay (Rank 7)
    { 28275, 70, 27871 }, -- Lightwell (Rank 4)
    { 34866, 70, 34865 }, -- Circle of Healing (Rank 5)
    { 34917, 70, 34916 }, -- Vampiric Touch (Rank 3)
    { 53005, 70, 47540 }, -- Penance (Rank 2)
    { 48172, 73, 25437 }, -- Desperate Prayer (Rank 8)
    { 48155, 74, 25387 }, -- Mind Flay (Rank 8)
    { 48086, 75, 28275 }, -- Lightwell (Rank 5)
    { 48088, 75, 34866 }, -- Circle of Healing (Rank 6)
    { 48159, 75, 34917 }, -- Vampiric Touch (Rank 4)
    { 53006, 75, 53005 }, -- Penance (Rank 3)
    { 48087, 80, 48086 }, -- Lightwell (Rank 6)
    { 48089, 80, 48088 }, -- Circle of Healing (Rank 7)
    { 48156, 80, 48155 }, -- Mind Flay (Rank 9)
    { 48160, 80, 48159 }, -- Vampiric Touch (Rank 5)
    { 48173, 80, 48172 }, -- Desperate Prayer (Rank 9)
    { 53007, 80, 53006 }}, -- Penance (Rank 4)
    -- Death Knight
    {{ 55258, 59, 55050 }, -- Heart Strike (Rank 2)
    { 51325, 60, 49158 }, -- Corpse Explosion (Rank 2)
    { 51416, 60, 49143 }, -- Frost Strike (Rank 2)
    { 55259, 64, 55258 }, -- Heart Strike (Rank 3)
    { 51417, 65, 51416 }, -- Frost Strike (Rank 3)
    { 55265, 67, 55090 }, -- Scourge Strike (Rank 2)
    { 55260, 69, 55259 }, -- Heart Strike (Rank 4)
    { 51326, 70, 51325 }, -- Corpse Explosion (Rank 3)
    { 51409, 70, 49184 }, -- Howling Blast (Rank 2)
    { 51418, 70, 51417 }, -- Frost Strike (Rank 4)
    { 55270, 73, 55265 }, -- Scourge Strike (Rank 3)
    { 55261, 74, 55260 }, -- Heart Strike (Rank 5)
    { 51327, 75, 51326 }, -- Corpse Explosion (Rank 4)
    { 51410, 75, 51409 }, -- Howling Blast (Rank 3)
    { 51419, 75, 51418 }, -- Frost Strike (Rank 5)
    { 55271, 79, 55270 }, -- Scourge Strike (Rank 4)
    { 51328, 80, 51327 }, -- Corpse Explosion (Rank 5)
    { 51411, 80, 51410 }, -- Howling Blast (Rank 4)
    { 55262, 80, 55261 }, -- Heart Strike (Rank 6)
    { 55268, 80, 51419 }}, -- Frost Strike (Rank 6)
    -- Shaman
    {{ 32593, 60, 974 }, -- Earth Shield (Rank 2)
    { 57720, 60, 30706 }, -- Totem of Wrath (Rank 2)
    { 32594, 70, 32593 }, -- Earth Shield (Rank 3)
    { 57721, 70, 57720 }, -- Totem of Wrath (Rank 3)
    { 59156, 70, 51490 }, -- Thunderstorm (Rank 2)
    { 61299, 70, 61295 }, -- Riptide (Rank 2)
    { 49283, 75, 32594 }, -- Earth Shield (Rank 4)
    { 59158, 75, 59156 }, -- Thunderstorm (Rank 3)
    { 61300, 75, 61299 }, -- Riptide (Rank 3)
    { 49284, 80, 49283 }, -- Earth Shield (Rank 5)
    { 57722, 80, 57721 }, -- Totem of Wrath (Rank 4)
    { 59159, 80, 59158 }, -- Thunderstorm (Rank 4)
    { 61301, 80, 61300 }}, -- Riptide (Rank 4)
    -- Mage
    {{ 12505, 24, 11366 }, -- Pyroblast (Rank 2)
    { 12522, 30, 12505 }, -- Pyroblast (Rank 3)
    { 12523, 36, 12522 }, -- Pyroblast (Rank 4)
    { 13018, 36, 11113 }, -- Blast Wave (Rank 2)
    { 12524, 42, 12523 }, -- Pyroblast (Rank 5)
    { 13019, 44, 13018 }, -- Blast Wave (Rank 3)
    { 13031, 46, 11426 }, -- Ice Barrier (Rank 2)
    { 12525, 48, 12524 }, -- Pyroblast (Rank 6)
    { 13020, 52, 13019 }, -- Blast Wave (Rank 4)
    { 13032, 52, 13031 }, -- Ice Barrier (Rank 3)
    { 12526, 54, 12525 }, -- Pyroblast (Rank 7)
    { 33041, 56, 31661 }, -- Dragon's Breath (Rank 2)
    { 13033, 58, 13032 }, -- Ice Barrier (Rank 4)
    { 13021, 60, 13020 }, -- Blast Wave (Rank 5)
    { 18809, 60, 12526 }, -- Pyroblast (Rank 8)
    { 27134, 64, 13033 }, -- Ice Barrier (Rank 5)
    { 33042, 64, 33041 }, -- Dragon's Breath (Rank 3)
    { 27133, 65, 13021 }, -- Blast Wave (Rank 6)
    { 27132, 66, 18809 }, -- Pyroblast (Rank 9)
    { 33043, 70, 33042 }, -- Dragon's Breath (Rank 4)
    { 33405, 70, 27134 }, -- Ice Barrier (Rank 6)
    { 33933, 70, 27133 }, -- Blast Wave (Rank 7)
    { 33938, 70, 27132 }, -- Pyroblast (Rank 10)
    { 44780, 70, 44425 }, -- Arcane Barrage (Rank 2)
    { 55359, 70, 44457 }, -- Living Bomb (Rank 2)
    { 42890, 73, 33938 }, -- Pyroblast (Rank 11)
    { 42944, 75, 33933 }, -- Blast Wave (Rank 8)
    { 42949, 75, 33043 }, -- Dragon's Breath (Rank 5)
    { 43038, 75, 33405 }, -- Ice Barrier (Rank 7)
    { 42891, 77, 42890 }, -- Pyroblast (Rank 12)
    { 42945, 80, 42944 }, -- Blast Wave (Rank 9)
    { 42950, 80, 42949 }, -- Dragon's Breath (Rank 6)
    { 43039, 80, 43038 }, -- Ice Barrier (Rank 8)
    { 44781, 80, 44780 }, -- Arcane Barrage (Rank 3)
    { 55360, 80, 55359 }}, -- Living Bomb (Rank 3)
    -- Warlock
    {{ 18867, 24, 17877 }, -- Shadowburn (Rank 2)
    { 18868, 32, 18867 }, -- Shadowburn (Rank 3)
    { 18869, 40, 18868 }, -- Shadowburn (Rank 4)
    { 18870, 48, 18869 }, -- Shadowburn (Rank 5)
    { 18937, 50, 18220 }, -- Dark Pact (Rank 2)
    { 18871, 56, 18870 }, -- Shadowburn (Rank 6)
    { 18938, 60, 18937 }, -- Dark Pact (Rank 3)
    { 30404, 60, 30108 }, -- Unstable Affliction (Rank 2)
    { 30413, 60, 30283 }, -- Shadowfury (Rank 2)
    { 27263, 63, 18871 }, -- Shadowburn (Rank 7)
    { 27265, 70, 18938 }, -- Dark Pact (Rank 4)
    { 30405, 70, 30404 }, -- Unstable Affliction (Rank 3)
    { 30414, 70, 30413 }, -- Shadowfury (Rank 3)
    { 30546, 70, 27263 }, -- Shadowburn (Rank 8)
    { 59161, 70, 48181 }, -- Haunt (Rank 2)
    { 59170, 70, 50796 }, -- Chaos Bolt (Rank 2)
    { 47826, 75, 30546 }, -- Shadowburn (Rank 9)
    { 47841, 75, 30405 }, -- Unstable Affliction (Rank 4)
    { 47846, 75, 30414 }, -- Shadowfury (Rank 4)
    { 59163, 75, 59161 }, -- Haunt (Rank 3)
    { 59171, 75, 59170 }, -- Chaos Bolt (Rank 3)
    { 47827, 80, 47826 }, -- Shadowburn (Rank 10)
    { 47843, 80, 47841 }, -- Unstable Affliction (Rank 5)
    { 47847, 80, 47846 }, -- Shadowfury (Rank 5)
    { 59092, 80, 27265 }, -- Dark Pact (Rank 5)
    { 59164, 80, 59163 }, -- Haunt (Rank 4)
    { 59172, 80, 59171 }}, -- Chaos Bolt (Rank 4)
    -- Unused
    {{}},
    -- Druid
    {{ 24974, 30, 5570 }, -- Insect Swarm (Rank 2)
    { 24975, 40, 24974 }, -- Insect Swarm (Rank 3)
    { 24976, 50, 24975 }, -- Insect Swarm (Rank 4)
    { 33982, 58, 33876 }, -- Mangle (Cat) (Rank 2)
    { 33986, 58, 33878 }, -- Mangle (Bear) (Rank 2)
    { 24977, 60, 24976 }, -- Insect Swarm (Rank 5)
    { 53223, 60, 50516 }, -- Typhoon (Rank 2)
    { 33983, 68, 33982 }, -- Mangle (Cat) (Rank 3)
    { 33987, 68, 33986 }, -- Mangle (Bear) (Rank 3)
    { 27013, 70, 24977 }, -- Insect Swarm (Rank 6)
    { 53199, 70, 48505 }, -- Starfall (Rank 2)
    { 53225, 70, 53223 }, -- Typhoon (Rank 3)
    { 53248, 70, 48438 }, -- Wild Growth (Rank 2)
    { 48563, 75, 33987 }, -- Mangle (Bear) (Rank 4)
    { 48565, 75, 33983 }, -- Mangle (Cat) (Rank 4)
    { 53200, 75, 53199 }, -- Starfall (Rank 3)
    { 53226, 75, 53225 }, -- Typhoon (Rank 4)
    { 53249, 75, 53248 }, -- Wild Growth (Rank 3)
    { 48468, 80, 27013 }, -- Insect Swarm (Rank 7)
    { 48564, 80, 48563 }, -- Mangle (Bear) (Rank 5)
    { 48566, 80, 48565 }, -- Mangle (Cat) (Rank 5)
    { 53201, 80, 53200 }, -- Starfall (Rank 4)
    { 53251, 80, 53249 }, -- Wild Growth (Rank 4)
    { 61384, 80, 53226 }}, -- Typhoon (Rank 5)
}

-- Spell id, required level
local Proficiencies = {
    -- Warrior
    {{ 196, 1 }, -- One-Handed Axes
    { 197, 1 }, -- Two-Handed Axes
    { 198, 1 }, -- One-Handed Maces
    { 199, 1 }, -- Two-Handed Maces
    { 200, 1 }, -- Polearms
    { 201, 1 }, -- One-Handed Swords
    { 202, 1 }, -- Two-Handed Swords
    { 227, 1 }, -- Staves
    { 264, 1 }, -- Bows
    { 266, 1 }, -- Guns
    { 1180,1 }, -- Daggers
    { 5011, 1 }, -- Crossbows
    { 15590, 1 }, -- Fist Weapons
    { 3127, 6 }, -- Parry (Passive)
    { 674, 20 }, -- Dual Wield (Passive)
    { 750, 40 }}, -- Plate Mail
    -- Paladin
    {{ 196, 1 }, -- One-Handed Axes
    { 197, 1 }, -- Two-Handed Axes
    { 198, 1 }, -- One-Handed Maces
    { 199, 1 }, -- Two-Handed Maces
    { 200, 1 }, -- Polearms
    { 201, 1 }, -- One-Handed Swords
    { 202, 1 }, -- Two-Handed Swords
    { 3127, 8 }, -- Parry (Passive)
    { 750, 40 }}, -- Plate Mail
    -- Hunter
    {{ 196, 1 }, -- One-Handed Axes
    { 197, 1 }, -- Two-Handed Axes
    { 200, 1 }, -- Polearms
    { 201, 1 }, -- One-Handed Swords
    { 202, 1 }, -- Two-Handed Swords
    { 227, 1 }, -- Staves
    { 264, 1 }, -- Bows
    { 266, 1 }, -- Guns
    { 1180, 1 }, -- Daggers
    { 5011, 1 }, -- Crossbows
    { 15590, 1 }, -- Fist Weapons
    { 3127, 8 }, -- Parry (Passive)
    { 674, 20 }, -- Dual Wield (Passive)
    { 8737, 40 }}, -- Mail
    -- Rogue
    {{ 196, 1 }, -- One-Handed Axes
    { 198, 1 }, -- One-Handed Maces
    { 201, 1 }, -- One-Handed Swords
    { 264, 1 }, -- Bows
    { 266, 1 }, -- Guns
    { 1180, 1 }, -- Daggers
    { 5011, 1 }, -- Crossbows
    { 15590, 1 }, -- Fist Weapons
    { 674, 10 }, -- Dual Wield (Passive)
    { 3127, 12 }}, -- Parry (Passive)
    -- Priest
    {{ 198, 1 }, -- One-Handed Maces
    { 227, 1 }, -- Staves
    { 1180, 1 }, -- Daggers
    { 5009, 1 }}, -- Wands
    -- Death Knight
    {{ 196, 1 }, -- One-Handed Axes
    { 197, 1 }, -- Two-Handed Axes
    { 198, 1 }, -- One-Handed Maces
    { 199, 1 }, -- Two-Handed Maces
    { 200, 1 }, -- Polearms
    { 201, 1 }, -- One-Handed Swords
    { 202, 1 }, -- Two-Handed Swords
    { 3127, 12 }, -- Parry (Passive)
    { 674, 20 }, -- Dual Wield (Passive)
    { 750, 40 }}, -- Plate Mail
    -- Shaman
    {{ 196, 1 }, -- One-Handed Axes
    { 197, 1 }, -- Two-Handed Axes
    { 198, 1 }, -- One-Handed Maces
    { 199, 1 }, -- Two-Handed Maces
    { 227, 1 }, -- Staves
    { 1180, 1 }, -- Daggers
    { 15590, 1 }, -- Fist Weapons
    { 8737, 40 }}, -- Mail
    -- Mage
    {{ 201, 1 }, -- One-Handed Swords
    { 227, 1 }, -- Staves
    { 1180, 1 }, -- Daggers
    { 5009, 1 }}, -- Wands
    -- Warlock
    {{ 201, 1 }, -- One-Handed Swords
    { 227, 1 }, -- Staves
    { 1180, 1 }, -- Daggers
    { 5009, 1 }}, -- Wands
    -- Unused
    {{}},
    -- Druid
    {{ 198, 1 }, -- One-Handed Maces
    { 199, 1 }, -- Two-Handed Maces
    { 200, 1 }, -- Polearms
    { 227, 1 }, -- Staves
    { 1180, 1 }, -- Daggers
    { 15590, 1 }}, -- Fist Weapons
}

-- Required team, required race, required class, spell id, required level, required spell id, earned from quests, enabled
local Riding = {
    { Team.Universal, Race.Universal, Class.Universal, 33388, 20, -1, 0, Config.EnableApprenticeRiding }, -- Apprentice Riding
    { Team.Alliance, Race.Human, Class.Universal, 458, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Brown Horse
    { Team.Alliance, Race.Human, Class.Universal, 472, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Pinto
    { Team.Horde, Race.Orc, Class.Universal, 580, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Timber Wolf
    { Team.Universal, Race.Universal, Class.Warlock, 5784, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Felsteed
    { Team.Alliance, Race.Human, Class.Universal, 6648, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Chestnut Mare
    { Team.Horde, Race.Orc, Class.Universal, 6653, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Dire Wolf
    { Team.Horde, Race.Orc, Class.Universal, 6654, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Brown Wolf
    { Team.Alliance, Race.Dwarf, Class.Universal, 6777, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Gray Ram
    { Team.Alliance, Race.Dwarf, Class.Universal, 6898, 20, 33388, 0, Config.EnableApprenticeRiding }, -- White Ram
    { Team.Alliance, Race.Dwarf, Class.Universal, 6899, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Brown Ram
    { Team.Alliance, Race.NightElf, Class.Universal, 8394, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Striped Frostsaber
    { Team.Horde, Race.Troll, Class.Universal, 8395, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Emerald Raptor
    { Team.Alliance, Race.NightElf, Class.Universal, 10789, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Spotted Frostsaber
    { Team.Alliance, Race.NightElf, Class.Universal, 10793, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Striped Nightsaber
    { Team.Horde, Race.Troll, Class.Universal, 10796, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Turquoise Raptor
    { Team.Horde, Race.Troll, Class.Universal, 10799, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Violet Raptor
    { Team.Alliance, Race.Gnome, Class.Universal, 10873, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Red Mechanostrider
    { Team.Alliance, Race.Gnome, Class.Universal, 10969, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Blue Mechanostrider
    { Team.Horde, Race.BloodElf, Class.Paladin, 34769, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Warhorse
    { Team.Alliance, Race.Gnome, Class.Universal, 17453, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Green Mechanostrider
    { Team.Alliance, Race.Gnome, Class.Universal, 17454, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Unpainted Mechanostrider
    { Team.Horde, Race.Undead, Class.Universal, 17462, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Red Skeletal Horse
    { Team.Horde, Race.Undead, Class.Universal, 17463, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Blue Skeletal Horse
    { Team.Horde, Race.Undead, Class.Universal, 17464, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Brown Skeletal Horse
    { Team.Horde, Race.Tauren, Class.Universal, 18989, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Gray Kodo
    { Team.Horde, Race.Tauren, Class.Universal, 18990, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Brown Kodo
    { Team.Alliance, Race.Draenei, Class.Universal, 34406, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Brown Elekk
    { Team.Alliance, Race.Draenei, Class.Paladin, 13819, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Summon Warhorse
    { Team.Alliance, Race.Human, Class.Paladin, 13819, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Summon Warhorse
    { Team.Alliance, Race.Dwarf, Class.Paladin, 13819, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Summon Warhorse
    { Team.Horde, Race.BloodElf, Class.Universal, 34795, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Red Hawkstrider
    { Team.Horde, Race.BloodElf, Class.Universal, 35018, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Purple Hawkstrider
    { Team.Horde, Race.BloodElf, Class.Universal, 35020, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Blue Hawkstrider
    { Team.Horde, Race.BloodElf, Class.Universal, 35022, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Black Hawkstrider
    { Team.Alliance, Race.Draenei, Class.Universal, 35710, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Gray Elekk
    { Team.Alliance, Race.Draenei, Class.Universal, 35711, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Purple Elekk
    { Team.Horde, Race.Tauren, Class.Universal, 64657, 20, 33388, 0, Config.EnableApprenticeRiding }, -- White Kodo
    { Team.Horde, Race.Orc, Class.Universal, 64658, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Black Wolf
    { Team.Horde, Race.Undead, Class.Universal, 64977, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Black Skeletal Horse
    { Team.Alliance, Race.NightElf, Class.Universal, 66847, 20, 33388, 0, Config.EnableApprenticeRiding }, -- Striped Dawnsaber
    { Team.Universal, Race.Universal, Class.Universal, 33391, 40, 33388, 0, Config.EnableJourneymanRiding }, -- Journeyman Riding
    { Team.Horde, Race.Undead, Class.Universal, 17465, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Green Skeletal Warhorse
    { Team.Universal, Race.Universal, Class.Warlock, 23161, 40, 33391, 1, Config.EnableJourneymanRiding }, -- Dreadsteed
    { Team.Alliance, Race.Human, Class.Paladin, 23214, 40, 33391, 1, Config.EnableJourneymanRiding }, -- Summon Charger
    { Team.Alliance, Race.Dwarf, Class.Paladin, 23214, 40, 33391, 1, Config.EnableJourneymanRiding }, -- Summon Charger
    { Team.Alliance, Race.Draenei, Class.Paladin, 23214, 40, 33391, 1, Config.EnableJourneymanRiding }, -- Summon Charger
    { Team.Alliance, Race.NightElf, Class.Universal, 23219, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Mistsaber
    { Team.Alliance, Race.NightElf, Class.Universal, 23221, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Frostsaber
    { Team.Alliance, Race.Gnome, Class.Universal, 23222, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Yellow Mechanostrider
    { Team.Alliance, Race.Gnome, Class.Universal, 23223, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift White Mechanostrider
    { Team.Alliance, Race.Gnome, Class.Universal, 23225, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Green Mechanostrider
    { Team.Alliance, Race.Human, Class.Universal, 23227, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Palomino
    { Team.Alliance, Race.Human, Class.Universal, 23228, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift White Steed
    { Team.Alliance, Race.Human, Class.Universal, 23229, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Brown Steed
    { Team.Alliance, Race.Dwarf, Class.Universal, 23238, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Brown Ram
    { Team.Alliance, Race.Dwarf, Class.Universal, 23239, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Gray Ram
    { Team.Alliance, Race.Dwarf, Class.Universal, 23240, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift White Ram
    { Team.Horde, Race.Troll, Class.Universal, 23241, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Blue Raptor
    { Team.Horde, Race.Troll, Class.Universal, 23242, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Olive Raptor
    { Team.Horde, Race.Troll, Class.Universal, 23243, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Orange Raptor
    { Team.Horde, Race.Undead, Class.Universal, 23246, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Purple Skeletal Warhorse
    { Team.Horde, Race.Tauren, Class.Universal, 23247, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Great White Kodo
    { Team.Horde, Race.Tauren, Class.Universal, 23248, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Great Gray Kodo
    { Team.Horde, Race.Tauren, Class.Universal, 23249, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Great Brown Kodo
    { Team.Horde, Race.Orc, Class.Universal, 23250, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Brown Wolf
    { Team.Horde, Race.Orc, Class.Universal, 23251, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Timber Wolf
    { Team.Horde, Race.Orc, Class.Universal, 23252, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Gray Wolf
    { Team.Alliance, Race.NightElf, Class.Universal, 23338, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Stormsaber
    { Team.Horde, Race.BloodElf, Class.Universal, 33660, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Pink Hawkstrider
    { Team.Horde, Race.BloodElf, Class.Paladin, 34767, 40, 33391, 1, Config.EnableJourneymanRiding }, -- Charger
    { Team.Horde, Race.BloodElf, Class.Universal, 35025, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Green Hawkstrider
    { Team.Horde, Race.BloodElf, Class.Universal, 35027, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Swift Purple Hawkstrider
    { Team.Alliance, Race.Draenei, Class.Universal, 35712, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Great Green Elekk
    { Team.Alliance, Race.Draenei, Class.Universal, 35713, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Great Blue Elekk
    { Team.Alliance, Race.Draenei, Class.Universal, 35714, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Great Purple Elekk
    { Team.Horde, Race.Undead, Class.Universal, 66846, 40, 33391, 0, Config.EnableJourneymanRiding }, -- Ochre Skeletal Warhorse
    { Team.Universal, Race.Universal, Class.Universal, 34090, 60, 33391, 0, Config.EnableExpertRiding }, -- Expert Riding
    { Team.Alliance, Race.Universal, Class.Universal, 32235, 60, 34090, 0, Config.EnableExpertRiding }, -- Golden Gryphon
    { Team.Alliance, Race.Universal, Class.Universal, 32239, 60, 34090, 0, Config.EnableExpertRiding }, -- Ebon Gryphon
    { Team.Alliance, Race.Universal, Class.Universal, 32240, 60, 34090, 0, Config.EnableExpertRiding }, -- Snowy Gryphon
    { Team.Horde, Race.Universal, Class.Universal, 32243, 60, 34090, 0, Config.EnableExpertRiding }, -- Tawny Wind Rider
    { Team.Horde, Race.Universal, Class.Universal, 32244, 60, 34090, 0, Config.EnableExpertRiding }, -- Blue Wind Rider
    { Team.Horde, Race.Universal, Class.Universal, 32245, 60, 34090, 0, Config.EnableExpertRiding }, -- Green Wind Rider
    { Team.Universal, Race.Universal, Class.DeathKnight, 48778, 60, 33391, 0, Config.EnableExpertRiding }, -- Acherus Deathcharger
    { Team.Universal, Race.Universal, Class.Universal, 34091, 70, 34090, 0, Config.EnableArtisanRiding }, -- Artisan Riding
    { Team.Alliance, Race.Universal, Class.Universal, 32242, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Blue Gryphon
    { Team.Horde, Race.Universal, Class.Universal, 32246, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Red Wind Rider
    { Team.Alliance, Race.Universal, Class.Universal, 32289, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Red Gryphon
    { Team.Alliance, Race.Universal, Class.Universal, 32290, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Green Gryphon
    { Team.Alliance, Race.Universal, Class.Universal, 32292, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Purple Gryphon
    { Team.Horde, Race.Universal, Class.Universal, 32295, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Green Wind Rider
    { Team.Horde, Race.Universal, Class.Universal, 32296, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Yellow Wind Rider
    { Team.Horde, Race.Universal, Class.Universal, 32297, 70, 34091, 0, Config.EnableArtisanRiding }, -- Swift Purple Wind Rider
    { Team.Universal, Race.Universal, Class.Universal, 54197, 77, 34090, 0, Config.EnableColdWeatherFlying }, -- Cold Weather Flying (Passive)
}

-- Item id, required level
local Totems = {
    { 5175, 4 }, -- Earth Totem
    { 5176, 10 }, -- Fire Totem
    { 5177, 20 }, -- Water totem
    { 5178, 30 } -- Air Totem
}

function Player:LearnClassSpells()
    local count = 0
    for _ in pairs(ClassSpells[self:GetClass()]) do count = count + 1 end

    for i=1, count do
        if ((ClassSpells[self:GetClass()][i][1] == Race.Universal or ClassSpells[self:GetClass()][i][1] == self:GetRace()) and (ClassSpells[self:GetClass()][i][3] <= self:GetLevel()) and (ClassSpells[self:GetClass()][i][5] == 0 or (ClassSpells[self:GetClass()][i][5] == 1 and Config.EnableSpellsFromQuests)) and (ClassSpells[self:GetClass()][i][4] == -1 or self:HasSpell(ClassSpells[self:GetClass()][i][4])) and (not self:HasSpell(ClassSpells[self:GetClass()][i][2]))) then
            self:LearnSpell(ClassSpells[self:GetClass()][i][2])
        end
    end
end

function Player:LearnTalentRanks()
    local count = 0
    for _ in pairs(TalentRanks[self:GetClass()]) do count = count + 1 end

    for i=1, count do
        if (TalentRanks[self:GetClass()][i][2] <= self:GetLevel() and self:HasSpell(TalentRanks[self:GetClass()][i][3]) and not self:HasSpell(TalentRanks[self:GetClass()][i][1])) then
            self:LearnSpell(TalentRanks[self:GetClass()][i][1])
        end
    end
end

function Player:LearnProficiencies()
    local count = 0
    for _ in pairs(Proficiencies[self:GetClass()]) do count = count + 1 end

    for i=1, count do
        if (Proficiencies[self:GetClass()][i][2] <= self:GetLevel() and not self:HasSpell(Proficiencies[self:GetClass()][i][1])) then
            self:LearnSpell(Proficiencies[self:GetClass()][i][1])
        end
    end
end

function Player:AddTotems()
    if (self:GetClass() == Class.Shaman) then
        local count = 0
        for _ in pairs(Totems) do count = count + 1 end

        for i=1, count do
            if (Totems[i][2] <= self:GetLevel() and not self:HasItem(Totems[i][1], 1, true)) then
                self:AddItem(Totems[i][1], 1)
            end
        end
    end
end

function Player:LearnRiding()
    local count = 0
    for _ in pairs(Riding) do count = count + 1 end

    for i=1, count do
        if ((Riding[i][1] == Team.Universal or Riding[i][1] == self:GetTeam()) and (Riding[i][2] == Race.Universal or Riding[i][2] == self:GetRace()) and (Riding[i][3] == Class.Universal or Riding[i][3] == self:GetClass()) and (Riding[i][5] <= self:GetLevel()) and (Riding[i][6] == -1 or self:HasSpell(Riding[i][6])) and (Riding[i][7] == 0 or (Riding[i][7] == 1 and Config.EnableSpellsFromQuests)) and (Riding[i][8]) and (not self:HasSpell(Riding[i][4]))) then
            self:LearnSpell(Riding[i][4])
        end
    end
end

local function LearnSpellsOnLogin(event, player)
    if (player:GetGMRank() == 0 or Config.EnableGamemaster) then
        if (Config.EnableClassSpells) then
            player:LearnClassSpells()
        end

        if (Config.EnableClassSpells and Config.EnableSpellsFromQuests) then
            player:AddTotems()
        end

        if (Config.EnableTalentRanks) then
            player:LearnTalentRanks()
        end

        if (Config.EnableProficiencies) then
            player:LearnProficiencies()
        end

        if (Config.EnableApprenticeRiding or Config.EnableJourneymanRiding or Config.EnableExpertRiding or Config.EnableArtisanRiding or Config.EnableColdWeatherFlying) then
            player:LearnRiding()
        end
    end
end
RegisterPlayerEvent(Event.OnLogin, LearnSpellsOnLogin)

local function LearnSpellsOnLevelChanged(event, player, oldLevel)
    if (player:GetGMRank() == 0 or Config.EnableGamemaster) then
        if (Config.EnableClassSpells) then
            player:LearnClassSpells()
        end

        if (Config.EnableClassSpells and Config.EnableSpellsFromQuests) then
            player:AddTotems()
        end

        if (Config.EnableTalentRanks) then
            player:LearnTalentRanks()
        end

        if (Config.EnableProficiencies) then
            player:LearnProficiencies()
        end

        if (Config.EnableApprenticeRiding or Config.EnableJourneymanRiding or Config.EnableExpertRiding or Config.EnableArtisanRiding or Config.EnableColdWeatherFlying) then
            player:LearnRiding()
        end
    end
end
RegisterPlayerEvent(Event.OnLevelChanged, LearnSpellsOnLevelChanged)

local function LearnSpellsOnTalentsChanged(event, player, points)
    if (player:GetGMRank() == 0 or Config.EnableGamemaster) then
        if (Config.EnableClassSpells and player:GetClass() == Class.Paladin) then
            player:LearnClassSpells()
        end

        if (Config.EnableTalentRanks) then
            player:LearnTalentRanks()
        end
    end
end
RegisterPlayerEvent(Event.OnTalentsChanged, LearnSpellsOnTalentsChanged)
