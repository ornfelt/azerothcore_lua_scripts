local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local PlayerInventory = _G.PlayerInventory
if not PlayerInventory then
    print("[ERROR] PlayerInventory namespace not found! Check load order.")
    return
end

local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig

-- ================================================================================
-- ENCHANTMENT DATA FUNCTIONS
-- This module provides enchantment data-related functionality including:
-- - Item slot type determination
-- - Enchant categorization
-- - Popular enchant data
-- - Enchant icon mapping
-- ================================================================================

-- Determine item slot type for menu categorization
function PlayerInventory.determineItemSlotTypeForMenu(itemData, isEquipment, slot)
    if isEquipment then
        return PlayerInventory.INVENTORY_CONFIG.EQUIPMENT_SLOTS[slot.slotId] or "UNKNOWN"
    else
        local _, _, _, _, _, iType, iSubType, _, equipLoc = GetItemInfo(itemData.entry)
        return equipLoc or "UNKNOWN"
    end
end

-- Get categorized enchants for an item
function PlayerInventory.getEnchantCategoriesForItem(slotType, itemData, isEquipment, slot)
    local categories = {}
    
    -- Check if it's a weapon
    local isWeapon = string.find(string.upper(slotType), "WEAPON") or 
                     string.find(string.upper(slotType), "HAND") or
                     slotType == "INVTYPE_2HWEAPON" or
                     slotType == "INVTYPE_WEAPONMAINHAND" or
                     slotType == "INVTYPE_WEAPONOFFHAND" or
                     slotType == "INVTYPE_RANGED" or
                     slotType == "INVTYPE_THROWN" or
                     slotType == "INVTYPE_RANGEDRIGHT"
    
    if isWeapon then
        -- Weapon enchant categories
        table.insert(categories, {
            name = "|cffff6060[DPS]|r Damage Enchants",
            icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
            enchants = {
                { id = 3789, name = "Berserking", icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge" },
                { id = 3827, name = "Massacre", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 3788, name = "Accuracy", icon = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge" },
                { id = 2673, name = "Mongoose", icon = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge" },
                { id = 3225, name = "Executioner", icon = "Interface\\Icons\\INV_Enchant_EssenceFireLarge" }
            }
        })
        
        table.insert(categories, {
            name = "|cff4080ff[Tank]|r Defensive Enchants",
            icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge",
            enchants = {
                { id = 3869, name = "Blade Ward", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 3870, name = "Blood Draining", icon = "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge" },
                { id = 3847, name = "Stoneskin Gargoyle", icon = "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge" },
                { id = 3368, name = "Fallen Crusader", icon = "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge" }
            }
        })
        
        table.insert(categories, {
            name = "|cffa060ff[Caster]|r Magic Enchants",
            icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
            enchants = {
                { id = 3834, name = "Mighty Spellpower", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" },
                { id = 3854, name = "Greater Spellpower", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" },
                { id = 3790, name = "Black Magic", icon = "Interface\\Icons\\INV_Enchant_EssenceNetherlarge" },
                { id = 3830, name = "Exceptional Spellpower", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" }
            }
        })
    elseif slotType == "INVTYPE_CHEST" or slotType == "INVTYPE_ROBE" then
        -- Chest enchant categories
        table.insert(categories, {
            name = "|cff60ff60[Stats]|r All Stats",
            icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
            enchants = {
                { id = 3832, name = "Powerful Stats", icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge" },
                { id = 3252, name = "Super Stats", icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge" },
                { id = 3233, name = "Exceptional Stats", icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge" }
            }
        })
        
        table.insert(categories, {
            name = "|cffff6060[Health]|r Health & Mana",
            icon = "Interface\\Icons\\INV_Enchant_EssenceLifeLarge",
            enchants = {
                { id = 3297, name = "Super Health", icon = "Interface\\Icons\\INV_Enchant_EssenceLifeLarge" },
                { id = 3236, name = "Mighty Health", icon = "Interface\\Icons\\INV_Enchant_EssenceLifeLarge" },
                { id = 3233, name = "Exceptional Mana", icon = "Interface\\Icons\\INV_Enchant_EssenceWaterLarge" }
            }
        })
    elseif slotType == "INVTYPE_FEET" then
        -- Boot enchant categories
        table.insert(categories, {
            name = "|cffffff00[Movement]|r Speed & Agility",
            icon = "Interface\\Icons\\INV_Enchant_EssenceAirLarge",
            enchants = {
                { id = 3826, name = "Icewalker", icon = "Interface\\Icons\\INV_Enchant_EssenceFrostLarge" },
                { id = 3232, name = "Tuskarr's Vitality", icon = "Interface\\Icons\\INV_Enchant_EssenceAirLarge" },
                { id = 983, name = "Superior Agility", icon = "Interface\\Icons\\INV_Enchant_EssenceNatureLarge" },
                { id = 1147, name = "Greater Agility", icon = "Interface\\Icons\\INV_Enchant_EssenceNatureLarge" }
            }
        })
    elseif slotType == "INVTYPE_HAND" then
        -- Glove enchant categories
        table.insert(categories, {
            name = "|cffff6060[Combat]|r Attack Power",
            icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge",
            enchants = {
                { id = 3829, name = "Greater Assault", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 3231, name = "Expertise", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 3234, name = "Precision", icon = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge" },
                { id = 3222, name = "Greater Agility", icon = "Interface\\Icons\\INV_Enchant_EssenceNatureLarge" }
            }
        })
        
        table.insert(categories, {
            name = "|cffa060ff[Caster]|r Spell Power",
            icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
            enchants = {
                { id = 3246, name = "Exceptional Spellpower", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" },
                { id = 3840, name = "Greater Blasting", icon = "Interface\\Icons\\INV_Enchant_EssenceFireLarge" }
            }
        })
    elseif slotType == "INVTYPE_CLOAK" then
        -- Cloak enchant categories
        table.insert(categories, {
            name = "|cff4080ff[Defense]|r Resistances",
            icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge",
            enchants = {
                { id = 3825, name = "Greater Defense", icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge" },
                { id = 3860, name = "Superior Arcane Resistance", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 3812, name = "Superior Fire Resistance", icon = "Interface\\Icons\\INV_Enchant_EssenceFireLarge" },
                { id = 3859, name = "Superior Frost Resistance", icon = "Interface\\Icons\\INV_Enchant_EssenceFrostLarge" },
                { id = 3858, name = "Superior Nature Resistance", icon = "Interface\\Icons\\INV_Enchant_EssenceNatureLarge" },
                { id = 3824, name = "Superior Shadow Resistance", icon = "Interface\\Icons\\INV_Enchant_EssenceNetherlarge" }
            }
        })
        
        table.insert(categories, {
            name = "|cffff6060[Offense]|r Attack Stats",
            icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
            enchants = {
                { id = 3831, name = "Greater Speed", icon = "Interface\\Icons\\INV_Enchant_EssenceAirLarge" },
                { id = 3222, name = "Greater Agility", icon = "Interface\\Icons\\INV_Enchant_EssenceNatureLarge" },
                { id = 3296, name = "Wisdom", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" },
                { id = 3243, name = "Spell Piercing", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" }
            }
        })
    elseif slotType == "INVTYPE_WRIST" then
        -- Bracer enchant categories
        table.insert(categories, {
            name = "|cff60ff60[Stats]|r Bracer Stats",
            icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
            enchants = {
                { id = 3850, name = "Major Stamina", icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge" },
                { id = 3845, name = "Greater Assault", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 2332, name = "Superior Spellpower", icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge" },
                { id = 3231, name = "Expertise", icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge" },
                { id = 2326, name = "Greater Stats", icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge" }
            }
        })
    elseif slotType == "INVTYPE_LEGS" then
        -- Leg enchant categories (typically not traditional enchants but armor kits/threads)
        table.insert(categories, {
            name = "|cffffcc00[Leg]|r Armor Kits",
            icon = "Interface\\Icons\\INV_Fabric_SpellFire",
            enchants = {
                { id = 3853, name = "Earthen Leg Armor", icon = "Interface\\Icons\\INV_Misc_ArmorKit_33" },
                { id = 3822, name = "Icescale Leg Armor", icon = "Interface\\Icons\\INV_Misc_ArmorKit_34" },
                { id = 3823, name = "Frosthide Leg Armor", icon = "Interface\\Icons\\INV_Misc_ArmorKit_35" },
                { id = 3719, name = "Brilliant Spellthread", icon = "Interface\\Icons\\INV_Fabric_SpellFire" },
                { id = 3720, name = "Sapphire Spellthread", icon = "Interface\\Icons\\INV_Fabric_SpellWater" }
            }
        })
    elseif slotType == "INVTYPE_HEAD" then
        -- Head enchant categories (typically reputation-based)
        table.insert(categories, {
            name = "|cffa335ee[Head]|r Arcanums",
            icon = "Interface\\Icons\\INV_Misc_Gem_01",
            enchants = {
                { id = 3817, name = "Arcanum of Torment", icon = "Interface\\Icons\\INV_Misc_Gem_01" },
                { id = 3818, name = "Arcanum of Triumph", icon = "Interface\\Icons\\INV_Misc_Gem_02" },
                { id = 3819, name = "Arcanum of Dominance", icon = "Interface\\Icons\\INV_Misc_Gem_03" },
                { id = 3820, name = "Arcanum of the Savage Gladiator", icon = "Interface\\Icons\\INV_Misc_Gem_04" }
            }
        })
    elseif slotType == "INVTYPE_SHOULDER" then
        -- Shoulder enchant categories (typically reputation-based)
        table.insert(categories, {
            name = "|cffa335ee[Shoulder]|r Inscriptions",
            icon = "Interface\\Icons\\INV_Inscription_ArmorScroll03",
            enchants = {
                { id = 3808, name = "Greater Inscription of the Axe", icon = "Interface\\Icons\\INV_Inscription_ArmorScroll03" },
                { id = 3809, name = "Greater Inscription of the Crag", icon = "Interface\\Icons\\INV_Inscription_ArmorScroll03" },
                { id = 3810, name = "Greater Inscription of the Pinnacle", icon = "Interface\\Icons\\INV_Inscription_ArmorScroll03" },
                { id = 3811, name = "Greater Inscription of the Storm", icon = "Interface\\Icons\\INV_Inscription_ArmorScroll03" }
            }
        })
    elseif slotType == "INVTYPE_SHIELD" then
        -- Shield enchant categories
        table.insert(categories, {
            name = "|cff4080ff[Shield]|r Block & Defense",
            icon = "Interface\\Icons\\INV_Shield_06",
            enchants = {
                { id = 3849, name = "Titanium Plating", icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge" },
                { id = 2655, name = "Shield Block", icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge" },
                { id = 3229, name = "Resilience", icon = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge" },
                { id = 1128, name = "Greater Stamina", icon = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge" }
            }
        })
    else
        -- Generic popular enchants
        table.insert(categories, {
            name = "|cffffcc00[Popular]|r Common Enchants",
            icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
            enchants = PlayerInventory.getPopularEnchantsForSlot(itemData, isEquipment, slot)
        })
    end
    
    -- Add recent enchants category if available
    local recentEnchants = PlayerInventory.getRecentlyUsedEnchants()
    if recentEnchants and #recentEnchants > 0 then
        table.insert(categories, 1, {
            name = "|cff808080[Recent]|r Recently Used",
            icon = "Interface\\Icons\\INV_Misc_PocketWatch_01",
            enchants = recentEnchants
        })
    end
    
    return categories
end

-- Get recently used enchants
function PlayerInventory.getRecentlyUsedEnchants()
    -- This would be populated from server data or local storage
    PlayerInventory.recentEnchants = PlayerInventory.recentEnchants or {}
    
    local enchants = {}
    for i = 1, math.min(5, #PlayerInventory.recentEnchants) do
        local enchantId = PlayerInventory.recentEnchants[i]
        local enchantName = PlayerInventory.ENCHANT_NAMES[enchantId] or string.format("Enchant %d", enchantId)
        table.insert(enchants, {
            id = enchantId,
            name = enchantName,
            icon = PlayerInventory.getEnchantIcon(enchantId, enchantName)
        })
    end
    
    return enchants
end

-- Get popular enchants for specific item slot
function PlayerInventory.getPopularEnchantsForSlot(itemData, isEquipment, slot)
    local enchants = {}
    
    -- Determine item type/slot
    local itemType = nil
    if isEquipment then
        itemType = PlayerInventory.INVENTORY_CONFIG.EQUIPMENT_SLOTS[slot.slotId]
    else
        -- Try to determine from item data
        local _, _, _, _, _, iType, iSubType, _, equipLoc = GetItemInfo(itemData.entry)
        itemType = equipLoc
    end
    
    -- Try to use server enchantment data if available
    if _G.EnchantmentData and _G.EnchantmentData.GetEnchantsBySlot then
        local serverEnchants = _G.EnchantmentData.GetEnchantsBySlot(itemType or "UNKNOWN")
        if serverEnchants and #serverEnchants > 0 then
            -- Take only the first 15 popular enchants to avoid overwhelming the context menu
            local maxEnchants = math.min(15, #serverEnchants)
            for i = 1, maxEnchants do
                local enchant = serverEnchants[i]
                table.insert(enchants, {
                    id = enchant.id,
                    name = enchant.name,
                    description = enchant.description,
                    icon = PlayerInventory.getEnchantIcon and PlayerInventory.getEnchantIcon(enchant.id, enchant.name) or "Interface\\Icons\\INV_Enchant_EssenceMagicLarge"
                })
            end
            return enchants
        end
    end
    
    -- Popular weapon enchants - expanded list
    if itemType == "Main Hand" or itemType == "Off Hand" or itemType == "INVTYPE_WEAPON" or 
       itemType == "INVTYPE_2HWEAPON" or itemType == "INVTYPE_WEAPONMAINHAND" or 
       itemType == "INVTYPE_WEAPONOFFHAND" then
        -- Melee DPS
        table.insert(enchants, {id = 3789, name = "Berserking", description = "Chance to increase AP by 400"})
        table.insert(enchants, {id = 3827, name = "Massacre", description = "+110 Attack Power"})
        table.insert(enchants, {id = 3788, name = "Accuracy", description = "+25 Hit and +25 Critical Strike"})
        table.insert(enchants, {id = 2673, name = "Mongoose", description = "+120 Agility and attack speed"})
        table.insert(enchants, {id = 3225, name = "Executioner", description = "Armor penetration proc"})
        -- Caster DPS
        table.insert(enchants, {id = 3790, name = "Black Magic", description = "Chance to increase haste by 250"})
        table.insert(enchants, {id = 3834, name = "Mighty Spellpower", description = "+63 Spell Power"})
        table.insert(enchants, {id = 3854, name = "Greater Spellpower", description = "+50 Spell Power (Staff)"})
        -- Tank/Hybrid
        table.insert(enchants, {id = 3869, name = "Blade Ward", description = "Chance to increase parry"})
        table.insert(enchants, {id = 3870, name = "Blood Draining", description = "Chance to heal for 400-600"})
        table.insert(enchants, {id = 3241, name = "Lifeward", description = "Chance to heal for 300"})
        -- DK Runes
        table.insert(enchants, {id = 3368, name = "Rune of the Fallen Crusader", description = "DK: Heal and +Str"})
        table.insert(enchants, {id = 3847, name = "Rune of Stoneskin Gargoyle", description = "DK: +25 Def +2% Stam"})
        
    -- Shield enchants
    elseif itemType == "Shield" or itemType == "INVTYPE_SHIELD" then
        table.insert(enchants, {id = 3849, name = "Titanium Plating", description = "+36 Block Value"})
        table.insert(enchants, {id = 1952, name = "Major Intellect", description = "+25 Intellect"})
        table.insert(enchants, {id = 3229, name = "Resilience", description = "+12 Defense"})
        table.insert(enchants, {id = 2655, name = "Greater Stamina", description = "+18 Stamina"})
        
    -- Popular chest enchants
    elseif itemType == "Chest" or itemType == "INVTYPE_CHEST" or itemType == "INVTYPE_ROBE" then
        table.insert(enchants, {id = 3832, name = "Powerful Stats", description = "+10 All Stats"})
        table.insert(enchants, {id = 3297, name = "Super Health", description = "+275 Health"})
        table.insert(enchants, {id = 3245, name = "Exceptional Resilience", description = "+20 Resilience"})
        table.insert(enchants, {id = 3252, name = "Super Stats", description = "+8 All Stats"})
        table.insert(enchants, {id = 1953, name = "Greater Defense", description = "+22 Defense"})
        table.insert(enchants, {id = 3233, name = "Exceptional Mana", description = "+250 Mana"})
        
    -- Popular boots enchants
    elseif itemType == "Feet" or itemType == "INVTYPE_FEET" then
        table.insert(enchants, {id = 3232, name = "Tuskarr's Vitality", description = "+15 Stamina and minor speed"})
        table.insert(enchants, {id = 3826, name = "Icewalker", description = "+12 Hit and +12 Critical Strike"})
        table.insert(enchants, {id = 3244, name = "Greater Vitality", description = "+7 MP5 and +7 HP5"})
        table.insert(enchants, {id = 3824, name = "Greater Assault", description = "+32 Attack Power"})
        table.insert(enchants, {id = 1597, name = "Greater Fortitude", description = "+22 Stamina"})
        table.insert(enchants, {id = 983, name = "Superior Agility", description = "+16 Agility"})
        table.insert(enchants, {id = 3606, name = "Nitro Boosts", description = "Engineering: Rocket boost"})
        
    -- Popular gloves enchants
    elseif itemType == "Hands" or itemType == "INVTYPE_HAND" then
        table.insert(enchants, {id = 3222, name = "Greater Agility", description = "+20 Agility"})
        table.insert(enchants, {id = 3231, name = "Expertise", description = "+15 Expertise"})
        table.insert(enchants, {id = 3234, name = "Precision", description = "+20 Hit"})
        table.insert(enchants, {id = 3829, name = "Greater Assault", description = "+44 Attack Power"})
        table.insert(enchants, {id = 3246, name = "Exceptional Armor", description = "+240 Armor"})
        table.insert(enchants, {id = 3253, name = "Armsman", description = "+2% Threat and +10 Parry"})
        table.insert(enchants, {id = 3604, name = "Hyperspeed Accelerators", description = "Engineering: +340 Haste"})
        
    -- Popular cloak enchants
    elseif itemType == "Back" or itemType == "INVTYPE_CLOAK" then
        table.insert(enchants, {id = 3831, name = "Greater Speed", description = "+23 Haste"})
        table.insert(enchants, {id = 1099, name = "Major Agility", description = "+22 Agility"})
        table.insert(enchants, {id = 3243, name = "Spell Piercing", description = "+35 Spell Penetration"})
        table.insert(enchants, {id = 3296, name = "Superior Dodge", description = "+18 Dodge"})
        table.insert(enchants, {id = 3294, name = "Superior Defense", description = "+16 Defense"})
        table.insert(enchants, {id = 3256, name = "Shadow Armor", description = "+155 Armor"})
        table.insert(enchants, {id = 3230, name = "Titanweave", description = "+16 Defense"})
        table.insert(enchants, {id = 3728, name = "Flexweave Underlay", description = "Engineering: Parachute"})
        
    -- Bracer enchants
    elseif itemType == "Wrist" or itemType == "INVTYPE_WRIST" then
        table.insert(enchants, {id = 3850, name = "Major Stamina", description = "+40 Stamina"})
        table.insert(enchants, {id = 2332, name = "Superior Spellpower", description = "+30 Spell Power"})
        table.insert(enchants, {id = 3845, name = "Greater Assault", description = "+50 Attack Power"})
        table.insert(enchants, {id = 3231, name = "Expertise", description = "+15 Expertise"})
        table.insert(enchants, {id = 2326, name = "Major Spirit", description = "+18 Spirit"})
        -- Fur Lining (LW only)
        table.insert(enchants, {id = 3757, name = "Fur Lining - Attack Power", description = "LW: +130 Attack Power"})
        table.insert(enchants, {id = 3758, name = "Fur Lining - Stamina", description = "LW: +102 Stamina"})
        table.insert(enchants, {id = 3759, name = "Fur Lining - Spell Power", description = "LW: +76 Spell Power"})
        
    -- Leg enchants
    elseif itemType == "Legs" or itemType == "INVTYPE_LEGS" then
        table.insert(enchants, {id = 3853, name = "Earthen Leg Armor", description = "+40 Stamina and +28 Resilience"})
        table.insert(enchants, {id = 3325, name = "Frosthide Leg Armor", description = "+55 Stamina and +22 Agility"})
        table.insert(enchants, {id = 3326, name = "Icescale Leg Armor", description = "+75 Attack Power and +22 Crit"})
        table.insert(enchants, {id = 3822, name = "Nerubian Leg Armor", description = "+55 Attack Power and +15 Crit"})
        table.insert(enchants, {id = 3719, name = "Azure Spellthread", description = "+35 Spell Power and +20 Stamina"})
        table.insert(enchants, {id = 3721, name = "Brilliant Spellthread", description = "+50 Spell Power and +20 Spirit"})
        table.insert(enchants, {id = 3872, name = "Sapphire Spellthread", description = "+50 Spell Power and +30 Stamina"})
    end
    
    -- Add generic enchants if no specific ones found
    if #enchants == 0 then
        table.insert(enchants, {id = 3832, name = "Powerful Stats", description = "Generic powerful enchant"})
        table.insert(enchants, {id = 3222, name = "Greater Agility", description = "Generic agility enchant"})
    end
    
    return enchants
end

-- Get appropriate icon for enchant (shared with dialogs module)
function PlayerInventory.getEnchantIcon(enchantId, enchantName)
    -- Define icon mapping based on enchant type/name
    local iconMap = {
        -- Weapon enchants
        [3789] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",  -- Berserking
        [3827] = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge",  -- Massacre
        [3788] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge", -- Accuracy
        [2673] = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",  -- Mongoose
        [3790] = "Interface\\Icons\\INV_Enchant_EssenceNetherlarge",  -- Black Magic
        [3834] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",   -- Mighty Spellpower
        [3854] = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",   -- Greater Spellpower
        [3869] = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge",  -- Blade Ward
        [3870] = "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge",  -- Blood Draining
        [3368] = "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge",  -- Rune of Fallen Crusader
        [3847] = "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge",  -- Rune of Stoneskin Gargoyle

        -- Armor enchants
        [3832] = "Interface\\Icons\\INV_Enchant_EssenceAstralLarge",  -- Powerful Stats
        [3222] = "Interface\\Icons\\INV_Enchant_EssenceNatureLarge",  -- Greater Agility
        [3231] = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge",  -- Expertise
        [3234] = "Interface\\Icons\\INV_Enchant_EssenceMysticalLarge", -- Precision
        [3831] = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",  -- Greater Speed
        [3850] = "Interface\\Icons\\INV_Enchant_EssenceEarthLarge",   -- Major Stamina
    }
    
    -- Return specific icon if available, otherwise generic enchant icon
    return iconMap[enchantId] or PlayerInventory.getGenericEnchantIcon(enchantName)
end

-- Get generic enchant icon based on name/type (shared with dialogs module)  
function PlayerInventory.getGenericEnchantIcon(enchantName)
    if not enchantName then
        return "Interface\\Icons\\INV_Enchant_EssenceMagicLarge"
    end
    
    local name = string.lower(enchantName)
    
    -- Weapon enchants
    if string.find(name, "weapon") or string.find(name, "striking") or string.find(name, "crusader") then
        return "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge"
    elseif string.find(name, "spellpower") or string.find(name, "spell") or string.find(name, "magic") then
        return "Interface\\Icons\\INV_Enchant_EssenceMagicLarge"
    elseif string.find(name, "agility") or string.find(name, "mongoose") then
        return "Interface\\Icons\\INV_Enchant_EssenceNatureLarge"
    elseif string.find(name, "strength") or string.find(name, "attack") then
        return "Interface\\Icons\\INV_Enchant_EssenceAstralLarge"
    elseif string.find(name, "unholy") or string.find(name, "rune") or string.find(name, "death") then
        return "Interface\\Icons\\INV_Enchant_EssenceUnholyLarge"
    elseif string.find(name, "fire") or string.find(name, "flame") then
        return "Interface\\Icons\\INV_Enchant_EssenceFireLarge"
    elseif string.find(name, "frost") or string.find(name, "ice") then
        return "Interface\\Icons\\INV_Enchant_EssenceFrostLarge"
    elseif string.find(name, "shadow") or string.find(name, "nether") then
        return "Interface\\Icons\\INV_Enchant_EssenceNetherlarge"
    elseif string.find(name, "earth") or string.find(name, "stamina") then
        return "Interface\\Icons\\INV_Enchant_EssenceEarthLarge"
    elseif string.find(name, "air") or string.find(name, "haste") or string.find(name, "speed") then
        return "Interface\\Icons\\INV_Enchant_EssenceAirLarge"
    elseif string.find(name, "water") or string.find(name, "mana") or string.find(name, "spirit") then
        return "Interface\\Icons\\INV_Enchant_EssenceWaterLarge"
    end
    
    -- Default enchant icon
    return "Interface\\Icons\\INV_Enchant_EssenceMagicLarge"
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[PlayerInventory] Enchantment data module loaded")
end