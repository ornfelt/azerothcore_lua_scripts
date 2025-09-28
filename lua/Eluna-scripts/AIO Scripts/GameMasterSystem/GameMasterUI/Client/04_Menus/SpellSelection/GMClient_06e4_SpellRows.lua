local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus or not GMMenus.SpellSelection then
    print("[ERROR] SpellSelection module not found! Check load order.")
    return
end

local SpellSelection = GMMenus.SpellSelection
local Rows = SpellSelection.Rows
local GMConfig = _G.GMConfig

-- Smart spell icon patterns based on common WoW spell ID ranges and patterns
local function getSmartSpellIcon(spellId)
    -- Convert to number for range checks
    local id = tonumber(spellId)
    if not id then return nil end
    
    -- Common spell icon patterns based on WoW 3.3.5 spell ranges
    local iconPatterns = {
        -- Paladin spells (Blessing, Seal, etc.)
        { min = 20100, max = 20500, icon = "Interface\\Icons\\Spell_Holy_SealOfMight" },
        { min = 48930, max = 48950, icon = "Interface\\Icons\\Spell_Holy_FistsOfFury" }, -- Blessings
        
        -- Priest spells (Power Word, Divine, etc.)
        { min = 48160, max = 48170, icon = "Interface\\Icons\\Spell_Holy_WordFortitude" }, -- Power Word
        { min = 48070, max = 48080, icon = "Interface\\Icons\\Spell_Holy_DivineSpirit" }, -- Divine Spirit
        
        -- Druid spells (Mark of the Wild, etc.)
        { min = 48460, max = 48480, icon = "Interface\\Icons\\Spell_Nature_Regeneration" }, -- Mark of the Wild
        
        -- Mage spells (Arcane, Fire, Frost)
        { min = 42890, max = 42920, icon = "Interface\\Icons\\Spell_Arcane_Blast" }, -- Arcane spells
        { min = 47610, max = 47650, icon = "Interface\\Icons\\Spell_Fire_Fireball" }, -- Fire spells
        { min = 42840, max = 42860, icon = "Interface\\Icons\\Spell_Frost_Frostbolt" }, -- Frost spells
        
        -- Warlock spells
        { min = 47860, max = 47890, icon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" }, -- Shadow Bolt
        { min = 47810, max = 47830, icon = "Interface\\Icons\\Spell_Fire_Immolation" }, -- Immolate
        
        -- Warrior spells
        { min = 47440, max = 47470, icon = "Interface\\Icons\\Ability_Warrior_Sunder" }, -- Sunder Armor
        { min = 47500, max = 47520, icon = "Interface\\Icons\\Ability_ThunderBolt" }, -- Thunder Clap
        
        -- Hunter spells
        { min = 49000, max = 49030, icon = "Interface\\Icons\\Ability_Hunter_AimedShot" }, -- Aimed Shot
        { min = 49050, max = 49080, icon = "Interface\\Icons\\Ability_Hunter_MultiShot" }, -- Multi-Shot
        
        -- Rogue spells
        { min = 48650, max = 48680, icon = "Interface\\Icons\\Ability_BackStab" }, -- Backstab
        { min = 48630, max = 48650, icon = "Interface\\Icons\\Ability_Rogue_Eviscerate" }, -- Eviscerate
        
        -- Shaman spells
        { min = 49270, max = 49290, icon = "Interface\\Icons\\Spell_Nature_Lightning" }, -- Lightning Bolt
        { min = 49230, max = 49250, icon = "Interface\\Icons\\Spell_Fire_Elemental_Totem" }, -- Earth Shock
    }
    
    -- Check if spell ID falls within any known pattern range
    for _, pattern in pairs(iconPatterns) do
        if id >= pattern.min and id <= pattern.max then
            return pattern.icon
        end
    end
    
    -- School-based fallbacks for unknown spells
    -- Use modulo to create some variety based on spell ID
    local mod = id % 10
    if mod >= 0 and mod <= 2 then
        return "Interface\\Icons\\Spell_Holy_Heal" -- Holy/Light magic
    elseif mod >= 3 and mod <= 4 then
        return "Interface\\Icons\\Spell_Fire_Fireball" -- Fire magic
    elseif mod >= 5 and mod <= 6 then
        return "Interface\\Icons\\Spell_Frost_Frostbolt" -- Frost/Ice magic
    elseif mod >= 7 and mod <= 8 then
        return "Interface\\Icons\\Spell_Nature_Lightning" -- Nature magic
    else
        return "Interface\\Icons\\Spell_Arcane_Blast" -- Arcane magic
    end
end

-- Enhanced icon resolution with multiple fallback strategies
local function resolveSpellIcon(spellId, fallbackIcon)
    -- Debug mode toggle (can be enabled/disabled as needed)
    local debugIcons = GMConfig and GMConfig.config and GMConfig.config.debug or false
    
    -- Strategy 1: Try GetSpellInfo API (more reliable than GetSpellTexture)
    -- GetSpellInfo returns: name, rank, icon, castTime, minRange, maxRange
    local name, rank, spellIcon = GetSpellInfo(spellId)
    if spellIcon and spellIcon ~= "" then
        return spellIcon
    end
    
    -- Strategy 1b: Fallback to GetSpellTexture API
    local spellTexture = GetSpellTexture(spellId)
    if spellTexture and spellTexture ~= "" then
        return spellTexture
    end
    
    -- Strategy 2: Use provided fallback icon (for predefined spells)
    if fallbackIcon and fallbackIcon ~= "" then
        return fallbackIcon
    end
    
    -- Strategy 3: Smart icon patterns based on spell ID ranges
    local smartIcon = getSmartSpellIcon(spellId)
    if smartIcon then
        return smartIcon
    end
    
    -- Strategy 4: Final fallback
    return "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- Create a spell row
function Rows.createSpellRow(parent, spellData, index)
    local state = SpellSelection.state
    local modal = state.spellSelectionModal
    
    local row = CreateStyledFrame(parent, UISTYLE_COLORS.SectionBg)
    row:SetHeight(30)
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, -5 - ((index - 1) * 35))
    row:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -25, -5 - ((index - 1) * 35))
    
    -- Enable mouse for selection
    row:EnableMouse(true)
    
    -- Icon with enhanced resolution
    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(24, 24)
    icon:SetPoint("LEFT", row, "LEFT", 5, 0)
    
    local resolvedIcon = resolveSpellIcon(spellData.spellId, spellData.icon)
    icon:SetTexture(resolvedIcon)
    
    -- Spell name
    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", icon, "RIGHT", 5, 0)
    nameText:SetText(spellData.name)
    nameText:SetTextColor(1, 1, 1)
    
    -- Spell ID
    local idText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    idText:SetPoint("LEFT", nameText, "RIGHT", 10, 0)
    idText:SetText("(ID: " .. spellData.spellId .. ")")
    idText:SetTextColor(0.7, 0.7, 0.7)
    
    -- Category
    if spellData.category then
        local categoryText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        categoryText:SetPoint("RIGHT", row, "RIGHT", -10, 0)
        categoryText:SetText(spellData.category)
        categoryText:SetTextColor(0.6, 0.8, 1)
    end
    
    -- Selection highlight
    local highlight = row:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
    highlight:SetBlendMode("ADD")
    highlight:SetAlpha(0.3)
    
    -- Click handler
    row:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            -- Deselect all other rows
            if modal and modal.spellRows then
                for _, otherRow in ipairs(modal.spellRows) do
                    if otherRow.selected then
                        otherRow.selected = false
                        otherRow:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
                    end
                end
            end
            
            -- Select this row
            self.selected = true
            self:SetBackdropBorderColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
            
            -- Store selected spell
            state.selectedSpells = {spellData}
        elseif button == "RightButton" then
            -- Show context menu for advanced spell operations
            SpellSelection.ContextMenu.showSpellContextMenu(spellData)
        end
    end)
    
    row.spellData = spellData
    
    return row
end