local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- DROPDOWN HELPERS
-- ===================================
-- Reusable helper functions for dropdown components

--- Creates a dropdown arrow indicator on any button
-- Repositions the button's .text to make room for the arrow
-- @param button - A styled button frame with a .text FontString
-- @return arrow - The arrow FontString
function CreateDropdownArrow(button)
    local arrow = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arrow:SetPoint("RIGHT", -8, 0)
    arrow:SetText("v")
    arrow:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    button.arrow = arrow

    -- Adjust text to make room for arrow
    if button.text then
        button.text:ClearAllPoints()
        button.text:SetPoint("LEFT", 8, 0)
        button.text:SetPoint("RIGHT", arrow, "LEFT", -5, 0)
        button.text:SetJustifyH("LEFT")
    end

    return arrow
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["DropdownHelpers"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: DropdownHelpers module loaded")
end
