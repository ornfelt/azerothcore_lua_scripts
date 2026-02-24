-- GameMasterUI Random Suffix Data for WoW 3.3.5
-- This file contains all random item suffix enchantments (e.g., "of the Bear", "of the Eagle")

local RandomSuffixData = {}

-- Map of base enchantment IDs to their stat effects
-- These are the enchantment IDs referenced in ItemRandomSuffix
RandomSuffixData.ENCHANT_EFFECTS = {
    [2802] = { stat = "Agility", multiplier = 1.0 },
    [2803] = { stat = "Stamina", multiplier = 1.5 },
    [2804] = { stat = "Intellect", multiplier = 1.0 },
    [2805] = { stat = "Strength", multiplier = 1.0 },
    [2806] = { stat = "Spirit", multiplier = 1.0 },
    [2813] = { stat = "Defense Rating", multiplier = 0.5 },
    [2814] = { stat = "Health Regeneration", multiplier = 0.4 },
    [2815] = { stat = "Dodge Rating", multiplier = 0.5 },
    [2816] = { stat = "Mana Regeneration", multiplier = 0.4 },
    [2817] = { stat = "Arcane Resistance", multiplier = 0.6 },
    [2818] = { stat = "Fire Resistance", multiplier = 0.6 },
    [2819] = { stat = "Frost Resistance", multiplier = 0.6 },
    [2820] = { stat = "Nature Resistance", multiplier = 0.6 },
    [2821] = { stat = "Shadow Resistance", multiplier = 0.6 },
    [2822] = { stat = "Critical Strike Rating", multiplier = 0.5 },
    [2823] = { stat = "Critical Strike Rating", multiplier = 0.5 }, -- Duplicate in data
    [2824] = { stat = "Spell Power", multiplier = 0.58 },
    [2825] = { stat = "Attack Power", multiplier = 2.0 },
    [2826] = { stat = "Block Rating", multiplier = 0.5 },
    [3726] = { stat = "Haste Rating", multiplier = 0.5 },
    [3727] = { stat = "Hit Rating", multiplier = 0.5 },
}

-- Complete list of random suffix enchantments
RandomSuffixData.RANDOM_SUFFIXES = {
    -- Classic Suffixes
    { id = 5, name = "of the Monkey", enchants = {{2802, 6666}, {2803, 10000}} }, -- Agility + Stamina
    { id = 6, name = "of the Eagle", enchants = {{2804, 6666}, {2803, 10000}} }, -- Intellect + Stamina
    { id = 7, name = "of the Bear", enchants = {{2803, 10000}, {2805, 6666}} }, -- Stamina + Strength
    { id = 8, name = "of the Whale", enchants = {{2806, 6666}, {2803, 10000}} }, -- Spirit + Stamina
    { id = 9, name = "of the Owl", enchants = {{2804, 6666}, {2806, 6666}} }, -- Intellect + Spirit
    { id = 10, name = "of the Gorilla", enchants = {{2804, 6666}, {2805, 6666}} }, -- Intellect + Strength
    { id = 11, name = "of the Falcon", enchants = {{2802, 6666}, {2804, 6666}} }, -- Agility + Intellect
    { id = 12, name = "of the Boar", enchants = {{2806, 6666}, {2805, 6666}} }, -- Spirit + Strength
    { id = 13, name = "of the Wolf", enchants = {{2802, 6666}, {2806, 6666}} }, -- Agility + Spirit
    { id = 14, name = "of the Tiger", enchants = {{2802, 6666}, {2805, 6666}} }, -- Agility + Strength
    { id = 15, name = "of Spirit", enchants = {{2806, 10000}} }, -- Pure Spirit
    { id = 16, name = "of Stamina", enchants = {{2803, 15000}} }, -- Pure Stamina
    { id = 17, name = "of Strength", enchants = {{2805, 10000}} }, -- Pure Strength
    { id = 18, name = "of Agility", enchants = {{2802, 10000}} }, -- Pure Agility
    { id = 19, name = "of Intellect", enchants = {{2804, 10000}} }, -- Pure Intellect
    { id = 20, name = "of Power", enchants = {{2825, 20000}} }, -- Attack Power
    
    -- Spell Power Suffixes (consolidated in 3.0)
    { id = 21, name = "of Spell Power", enchants = {{2824, 11700}} }, -- Was Arcane Wrath
    { id = 22, name = "of Spell Power", enchants = {{2824, 11700}} }, -- Was Fiery Wrath
    { id = 23, name = "of Spell Power", enchants = {{2824, 11700}} }, -- Was Frozen Wrath
    { id = 24, name = "of Spell Power", enchants = {{2824, 11700}} }, -- Was Nature's Wrath
    { id = 25, name = "of Spell Power", enchants = {{2824, 11700}} }, -- Was Shadow Wrath
    { id = 26, name = "of Spell Power", enchants = {{2824, 11700}} }, -- Generic Spell Power
    
    -- Defense and Avoidance
    { id = 27, name = "of Defense", enchants = {{2813, 10000}} }, -- Defense Rating
    { id = 28, name = "of Regeneration", enchants = {{2814, 4000}} }, -- Health Regen
    { id = 29, name = "of Eluding", enchants = {{2815, 6666}, {2802, 6666}} }, -- Dodge + Agility
    { id = 30, name = "of Concentration", enchants = {{2816, 4000}} }, -- Mana Regen
    
    -- Resistance Suffixes
    { id = 31, name = "of Arcane Protection", enchants = {{2803, 10000}, {2817, 6666}} }, -- Stamina + Arcane Resist
    { id = 32, name = "of Fire Protection", enchants = {{2803, 10000}, {2818, 6666}} }, -- Stamina + Fire Resist
    { id = 33, name = "of Frost Protection", enchants = {{2803, 10000}, {2819, 6666}} }, -- Stamina + Frost Resist
    { id = 34, name = "of Nature Protection", enchants = {{2803, 10000}, {2820, 6666}} }, -- Stamina + Nature Resist
    { id = 35, name = "of Shadow Protection", enchants = {{2803, 10000}, {2821, 6666}} }, -- Stamina + Shadow Resist
    
    -- Complex Combinations
    { id = 36, name = "of the Sorcerer", enchants = {{2803, 7889}, {2804, 5259}, {2824, 6153}} }, -- Stamina + Int + SP
    { id = 37, name = "of the Physician", enchants = {{2803, 7889}, {2804, 5259}, {2824, 6153}} }, -- Similar to Sorcerer
    { id = 38, name = "of the Prophet", enchants = {{2804, 5259}, {2806, 5259}, {2824, 6153}} }, -- Int + Spirit + SP
    { id = 39, name = "of the Invoker", enchants = {{2804, 5259}, {2824, 6153}, {2822, 5259}} }, -- Int + SP + Crit
    { id = 40, name = "of the Bandit", enchants = {{2802, 5259}, {2803, 7889}, {2825, 10518}} }, -- Agi + Stam + AP
    { id = 41, name = "of the Beast", enchants = {{2805, 5259}, {2802, 5259}, {2803, 7889}} }, -- Str + Agi + Stam
    { id = 42, name = "of the Hierophant", enchants = {{2803, 7889}, {2806, 5259}, {2824, 6153}} }, -- Stam + Spirit + SP
    { id = 43, name = "of the Soldier", enchants = {{2805, 5259}, {2803, 7889}, {2823, 5259}} }, -- Str + Stam + Crit
    { id = 44, name = "of the Elder", enchants = {{2803, 7889}, {2804, 5259}, {2816, 2104}} }, -- Stam + Int + MP5
    { id = 45, name = "of the Champion", enchants = {{2805, 5259}, {2803, 7889}, {2813, 5259}} }, -- Str + Stam + Defense
    { id = 47, name = "of Blocking", enchants = {{2826, 6666}, {2805, 6666}} }, -- Block + Strength
    
    -- Hunt/Shadow/Wild themes
    { id = 49, name = "of the Grove", enchants = {{2805, 7266}, {2802, 4106}, {2803, 4790}} }, -- Str + Agi + Stam
    { id = 50, name = "of the Hunt", enchants = {{2825, 14532}, {2802, 4106}, {2804, 3193}} }, -- AP + Agi + Int
    { id = 51, name = "of the Mind", enchants = {{2824, 8501}, {2822, 4106}, {2804, 3193}} }, -- SP + Crit + Int
    { id = 52, name = "of the Crusade", enchants = {{2824, 8501}, {2804, 4106}, {2813, 3193}} }, -- SP + Int + Defense
    { id = 53, name = "of the Vision", enchants = {{2824, 8501}, {2804, 4106}, {2803, 3193}} }, -- SP + Int + Stam
    { id = 54, name = "of the Ancestor", enchants = {{2805, 7266}, {2823, 4106}, {2803, 4790}} }, -- Str + Crit + Stam
    { id = 55, name = "of the Nightmare", enchants = {{2811, 8501}, {2803, 6159}, {2804, 3193}} }, -- Shadow SP + Stam + Int (2811 not mapped)
    { id = 56, name = "of the Battle", enchants = {{2805, 7266}, {2803, 6159}, {2823, 3193}} }, -- Str + Stam + Crit
    { id = 57, name = "of the Shadow", enchants = {{2825, 14532}, {2802, 4106}, {2803, 4790}} }, -- AP + Agi + Stam
    { id = 58, name = "of the Sun", enchants = {{2824, 6153}, {2803, 5259}, {2804, 5259}} }, -- SP + Stam + Int
    { id = 59, name = "of the Moon", enchants = {{2804, 5259}, {2803, 5259}, {2806, 5259}} }, -- Int + Stam + Spirit
    { id = 60, name = "of the Wild", enchants = {{2825, 10518}, {2803, 5259}, {2802, 5259}} }, -- AP + Stam + Agi
    
    -- Resistance variants (simplified names)
    { id = 61, name = "of Spell Power", enchants = {{2824, 2659}} }, -- Resistance variant
    { id = 62, name = "of Strength", enchants = {{2805, 5000}} }, -- Resistance variant
    { id = 63, name = "of Agility", enchants = {{2802, 5000}} }, -- Resistance variant
    { id = 64, name = "of Power", enchants = {{2825, 10000}} }, -- Resistance variant
    { id = 65, name = "of Magic", enchants = {{2824, 5850}} }, -- Resistance variant
    
    -- Knight/Seer variants
    { id = 66, name = "of the Knight", enchants = {{2803, 7889}, {2813, 5259}, {2824, 6153}} }, -- Stam + Defense + SP
    { id = 67, name = "of the Seer", enchants = {{2803, 7889}, {2822, 5259}, {2824, 6153}} }, -- Stam + Crit + SP
    
    -- Level 60 variants (similar stats, different IDs)
    { id = 68, name = "of the Bear", enchants = {{2805, 6666}, {2803, 6666}} }, -- <60 variant
    { id = 69, name = "of the Eagle", enchants = {{2803, 6666}, {2804, 6666}} }, -- <60 variant
    { id = 70, name = "of the Ancestor", enchants = {{2805, 7266}, {2822, 4106}, {2803, 3193}} }, -- <60 variant
    { id = 71, name = "of the Bandit", enchants = {{2802, 5259}, {2803, 5259}, {2825, 10518}} }, -- <60 variant
    { id = 72, name = "of the Battle", enchants = {{2805, 7266}, {2803, 4106}, {2822, 3193}} }, -- <60 variant
    { id = 73, name = "of the Elder", enchants = {{2803, 5259}, {2804, 5259}, {2816, 2104}} }, -- <60 variant
    { id = 74, name = "of the Beast", enchants = {{2805, 5259}, {2802, 5259}, {2803, 5259}} }, -- <60 variant
    { id = 75, name = "of the Champion", enchants = {{2805, 5259}, {2803, 5259}, {2813, 5259}} }, -- <60 variant
    { id = 76, name = "of the Grove", enchants = {{2805, 7266}, {2802, 4106}, {2803, 3193}} }, -- <60 variant
    { id = 77, name = "of the Knight", enchants = {{2803, 5259}, {2813, 5259}, {2824, 6153}} }, -- <60 variant
    { id = 78, name = "of the Monkey", enchants = {{2802, 6666}, {2803, 6666}} }, -- <60 variant
    { id = 79, name = "of the Moon", enchants = {{2804, 5259}, {2803, 3506}, {2806, 5259}} }, -- <60 variant
    { id = 80, name = "of the Wild", enchants = {{2825, 10518}, {2803, 3506}, {2802, 5259}} }, -- <60 variant
    { id = 81, name = "of the Whale", enchants = {{2803, 6666}, {2806, 6666}} }, -- <60 variant
    { id = 82, name = "of the Vision", enchants = {{2824, 8501}, {2804, 4106}, {2803, 2129}} }, -- <60 variant
    { id = 83, name = "of the Sun", enchants = {{2824, 6153}, {2803, 3506}, {2804, 5259}} }, -- <60 variant
    { id = 84, name = "of Stamina", enchants = {{2803, 10000}} }, -- <60 variant
    { id = 85, name = "of the Sorcerer", enchants = {{2803, 5259}, {2804, 5259}, {2824, 6153}} }, -- <60 variant
    { id = 86, name = "of the Soldier", enchants = {{2805, 5259}, {2803, 5259}, {2822, 5259}} }, -- <60 variant
    { id = 87, name = "of the Shadow", enchants = {{2825, 14532}, {2802, 4106}, {2803, 3193}} }, -- <60 variant
    
    -- WotLK additions
    { id = 88, name = "of the Foreseer", enchants = {{2804, 5259}, {3726, 5259}, {2824, 6153}} }, -- Int + Haste + SP
    { id = 89, name = "of the Thief", enchants = {{2803, 7889}, {2825, 10518}, {3726, 5259}} }, -- Stam + AP + Haste
    { id = 90, name = "of the Necromancer", enchants = {{2803, 7889}, {3727, 5259}, {2824, 6153}} }, -- Stam + Hit + SP
    { id = 91, name = "of the Marksman", enchants = {{2803, 7889}, {2802, 5259}, {3727, 5259}} }, -- Stam + Agi + Hit
    { id = 92, name = "of the Squire", enchants = {{2803, 7889}, {3727, 5259}, {2805, 5259}} }, -- Stam + Hit + Str
    { id = 93, name = "of Restoration", enchants = {{2803, 7889}, {2824, 6153}, {2816, 2103}} }, -- Stam + SP + MP5
    
    -- Darkmoon Card variants (special)
    { id = 94, name = "", enchants = {{2802, 9000}} }, -- Agility (Darkmoon)
    { id = 95, name = "", enchants = {{2805, 9000}} }, -- Strength (Darkmoon)
    { id = 96, name = "", enchants = {{2803, 13500}} }, -- Stamina (Darkmoon)
    { id = 97, name = "", enchants = {{2804, 9000}} }, -- Intellect (Darkmoon)
    { id = 98, name = "", enchants = {{2806, 9000}} }, -- Spirit (Darkmoon)
    
    -- Speed suffix
    { id = 99, name = "of Speed", enchants = {{3726, 10000}} }, -- Pure Haste
}

-- Convert random suffix to enchantment format
function RandomSuffixData.ConvertToEnchantment(suffix)
    local description = ""
    local stats = {}
    
    -- Build description from enchant effects
    for _, enchantData in ipairs(suffix.enchants) do
        local enchantId = enchantData[1]
        local allocation = enchantData[2] / 10000 -- Convert to percentage
        local effect = RandomSuffixData.ENCHANT_EFFECTS[enchantId]
        
        if effect then
            -- Calculate approximate bonus (this would vary by item level in-game)
            local statBonus = math.floor(allocation * 100 * effect.multiplier)
            table.insert(stats, string.format("+%d %s", statBonus, effect.stat))
        end
    end
    
    if #stats > 0 then
        description = table.concat(stats, ", ")
    else
        description = "Random enchantment"
    end
    
    -- Create enchantment entry
    return {
        id = 50000 + suffix.id, -- Use high ID range to avoid conflicts
        name = suffix.name,
        description = description,
        isRandomSuffix = true,
        originalId = suffix.id,
        enchantments = suffix.enchants
    }
end

-- Get all random suffix enchantments in enchantment format
function RandomSuffixData.GetAllRandomSuffixEnchantments()
    local enchantments = {}
    
    for _, suffix in ipairs(RandomSuffixData.RANDOM_SUFFIXES) do
        if suffix.name and suffix.name ~= "" then
            table.insert(enchantments, RandomSuffixData.ConvertToEnchantment(suffix))
        end
    end
    
    return enchantments
end

-- Get random suffix by ID
function RandomSuffixData.GetRandomSuffixById(suffixId)
    for _, suffix in ipairs(RandomSuffixData.RANDOM_SUFFIXES) do
        if suffix.id == suffixId then
            return suffix
        end
    end
    return nil
end

-- Export the module
_G.RandomSuffixData = RandomSuffixData
return RandomSuffixData