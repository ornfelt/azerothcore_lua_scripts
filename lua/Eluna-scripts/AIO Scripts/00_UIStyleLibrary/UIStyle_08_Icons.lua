local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY ICONS MODULE
-- ===================================
-- Icon helper functions and utilities

--[[
Safely retrieves an item's icon texture from GetItemInfo
@param itemId - The item ID to get icon for
@return texture path or fallback question mark icon
]]
function GetItemIconSafe(itemId)
    if not itemId then 
        return "Interface\\Icons\\INV_Misc_QuestionMark" 
    end
    
    local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(itemId)
    return texture or "Interface\\Icons\\INV_Misc_QuestionMark"
end

--[[
Safely retrieves a spell's icon texture from GetSpellInfo
@param spellId - The spell ID to get icon for
@return icon path or fallback spell book icon
]]
function GetSpellIconSafe(spellId)
    if not spellId then 
        return "Interface\\Icons\\INV_Misc_Book_09" 
    end
    
    local _, _, icon = GetSpellInfo(spellId)
    return icon or "Interface\\Icons\\INV_Misc_Book_09"
end

--[[
Creates a properly configured icon texture with border trimming
@param parent - Parent frame
@param size - Icon size (width and height)
@param iconPath - Path to icon texture (optional)
@param drawLayer - Draw layer (optional, defaults to "ARTWORK")
@return texture object
]]
function CreateIconTexture(parent, size, iconPath, drawLayer)
    local icon = parent:CreateTexture(nil, drawLayer or "ARTWORK")
    icon:SetSize(size or 32, size or 32)
    
    if iconPath then
        icon:SetTexture(iconPath)
    else
        icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    
    -- Trim default WoW icon borders
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    
    return icon
end

--[[
Creates a styled icon button with proper border trimming and highlight effects
@param parent - Parent frame
@param size - Button size
@param iconPath - Path to icon texture (optional)
@param onClick - Click handler function (optional)
@param tooltip - Tooltip text (optional)
@return button frame with icon
]]
function CreateIconButton(parent, size, iconPath, onClick, tooltip)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(size or 32, size or 32)
    
    -- Icon texture
    button.icon = CreateIconTexture(button, size, iconPath)
    button.icon:SetAllPoints()
    
    -- Border backdrop
    button:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 2,
    })
    button:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
    
    -- Highlight texture
    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
    highlight:SetBlendMode("ADD")
    highlight:SetAllPoints()
    
    -- Pushed texture offset
    button:SetPushedTextureOffset(1, -1)
    
    -- Click handler
    if onClick then
        button:SetScript("OnClick", onClick)
    end
    
    -- Tooltip
    if tooltip then
        SetupTooltip(button, tooltip)
    end
    
    -- Helper methods
    button.SetIcon = function(self, newIconPath)
        if newIconPath then
            self.icon:SetTexture(newIconPath)
        else
            self.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        end
    end
    
    button.SetItemIcon = function(self, itemId)
        self.icon:SetTexture(GetItemIconSafe(itemId))
    end
    
    button.SetSpellIcon = function(self, spellId)
        self.icon:SetTexture(GetSpellIconSafe(spellId))
    end
    
    return button
end

--[[
Updates an existing texture to display an item icon safely
@param texture - The texture object to update
@param itemId - The item ID
]]
function SetTextureToItemIcon(texture, itemId)
    texture:SetTexture(GetItemIconSafe(itemId))
    texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
end

--[[
Updates an existing texture to display a spell icon safely
@param texture - The texture object to update
@param spellId - The spell ID
]]
function SetTextureToSpellIcon(texture, spellId)
    texture:SetTexture(GetSpellIconSafe(spellId))
    texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
end

--[[
Extracts the icon filename from a full icon path
@param iconPath - The full icon path (e.g., "Interface\\Icons\\Spell_Nature_MoonKey")
@return string - Just the filename (e.g., "Spell_Nature_MoonKey")
]]
function ExtractIconFilename(iconPath)
    if not iconPath or iconPath == "" then
        return ""
    end
    
    -- Match the last part after the last backslash
    local filename = iconPath:match("([^\\]+)$")
    
    -- If no backslash found, return the original string
    return filename or iconPath
end

-- Common fallback icon paths
ICON_FALLBACKS = {
    QUESTION_MARK = "Interface\\Icons\\INV_Misc_QuestionMark",
    SPELL_BOOK = "Interface\\Icons\\INV_Misc_Book_09",
    CURRENCY = "Interface\\Icons\\INV_Misc_Coin_01",
    EMPTY_SLOT = "Interface\\PaperDoll\\UI-Backpack-EmptySlot",
    GEAR = "Interface\\Icons\\Trade_Engineering",
    POTION = "Interface\\Icons\\INV_Potion_01",
    FOOD = "Interface\\Icons\\INV_Misc_Food_01",
    WEAPON = "Interface\\Icons\\INV_Sword_01",
    ARMOR = "Interface\\Icons\\INV_Chest_Chain",
}

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Icons"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Icons module loaded")
end