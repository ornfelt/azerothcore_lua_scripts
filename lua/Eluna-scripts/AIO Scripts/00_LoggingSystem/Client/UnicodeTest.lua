local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

-- Unicode Character Test — FINAL (all confirmed working in WoW 3.3.5)
-- 83 confirmed glyphs across 8 groups (Rounds 1-4)
-- Type /unicode in chat to open

local CHAR_GROUPS = {
    { name = "Punctuation and Quotes", chars = {
        {"·", "MIDDLE DOT - separators"},
        {"•", "BULLET - list items"},
        {"‐", "HYPHEN"},
        {"–", "EN DASH"},
        {"—", "EM DASH"},
        {"…", "ELLIPSIS"},
        {"«", "LEFT GUILLEMET"},
        {"»", "RIGHT GUILLEMET"},
        {"‹", "SINGLE LEFT ANGLE"},
        {"›", "SINGLE RIGHT ANGLE"},
        {"†", "DAGGER"},
        {"‡", "DOUBLE DAGGER"},
        {"‰", "PER MILLE"},
        {"⁄", "FRACTION SLASH"},
        {"'", "LEFT SINGLE QUOTE"},
        {"'", "RIGHT SINGLE QUOTE"},
        {[["]], "LEFT DOUBLE QUOTE"},
        {[["]], "RIGHT DOUBLE QUOTE"},
        {[[„]], "DOUBLE LOW-9 QUOTE"},
    }},
    { name = "Math and Operators", chars = {
        {"×", "MULTIPLY"},
        {"÷", "DIVISION"},
        {"±", "PLUS-MINUS"},
        {"−", "MINUS SIGN"},
        {"≈", "APPROX EQUAL"},
        {"≠", "NOT EQUAL"},
        {"≤", "LESS OR EQUAL"},
        {"≥", "GREATER OR EQUAL"},
        {"∞", "INFINITY"},
        {"√", "SQUARE ROOT"},
        {"∂", "PARTIAL DIFF"},
        {"∏", "N-ARY PRODUCT"},
        {"∑", "N-ARY SUM"},
        {"∙", "BULLET OPERATOR"},
    }},
    { name = "Latin Supplement", chars = {
        {"©", "COPYRIGHT"},
        {"®", "REGISTERED"},
        {"™", "TRADEMARK"},
        {"°", "DEGREE"},
        {"¹", "SUPERSCRIPT 1"},
        {"²", "SUPERSCRIPT 2"},
        {"³", "SUPERSCRIPT 3"},
        {"µ", "MICRO"},
        {"¶", "PILCROW"},
        {"§", "SECTION SIGN"},
        {"¡", "INVERTED EXCLAM"},
        {"¿", "INVERTED QUESTION"},
        {"¤", "CURRENCY SIGN"},
        {"¥", "YEN"},
        {"£", "POUND"},
        {"¢", "CENT"},
        {"¼", "QUARTER"},
        {"½", "HALF"},
        {"¾", "THREE QUARTERS"},
    }},
    { name = "Latin Extended and Accented", chars = {
        {"Æ", "AE"},
        {"æ", "ae"},
        {"Ø", "O-STROKE"},
        {"ß", "SHARP S"},
        {"ƒ", "LATIN F HOOK"},
        {"Œ", "OE"},
        {"À", "A GRAVE"},
        {"Á", "A ACUTE"},
        {"Â", "A CIRCUMFLEX"},
        {"Ã", "A TILDE"},
        {"Ä", "A DIAERESIS"},
        {"Å", "A RING"},
        {"Ç", "C CEDILLA"},
        {"È", "E GRAVE"},
        {"É", "E ACUTE"},
        {"Ñ", "N TILDE"},
        {"Ö", "O DIAERESIS"},
        {"Ü", "U DIAERESIS"},
    }},
    { name = "Spacing Modifiers", chars = {
        {"ˆ", "CIRCUMFLEX"},
        {"ˇ", "CARON"},
        {"˘", "BREVE"},
        {"˙", "DOT ABOVE"},
        {"˚", "RING ABOVE"},
        {"˜", "SMALL TILDE"},
        {"˝", "DOUBLE ACUTE"},
    }},
    { name = "Greek", chars = {
        {"Δ", "DELTA"},
        {"Σ", "SIGMA"},
        {"Ω", "OMEGA"},
        {"π", "PI"},
    }},
    { name = "Geometric Shapes", chars = {
        {"◊", "LOZENGE"},
    }},
    { name = "Letterlike Symbols", chars = {
        {"Ω", "OHM (same as Greek Omega)"},
        {"K", "KELVIN"},
        {"Å", "ANGSTROM"},
    }},
}

local frame = nil

local function CreateTestPanel()
    if frame then frame:Show() return end

    frame = CreateFrame("Frame", "UnicodeTestFrame", UIParent)
    frame:SetSize(380, 480)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)

    local fname = "UnicodeTestFrame"
    _G[fname] = frame
    tinsert(UISpecialFrames, fname)

    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    frame:SetBackdropColor(0.06, 0.06, 0.06, 0.95)
    frame:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetHeight(28)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    titleBar:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    titleBar:SetBackdropColor(0.12, 0.12, 0.12, 1)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function() frame:StartMoving() end)
    titleBar:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)

    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("CENTER")
    title:SetText("Working Unicode Chars (WoW 3.3.5)")
    title:SetTextColor(1, 1, 1)

    local closeBtn = CreateFrame("Button", nil, titleBar)
    closeBtn:SetSize(20, 20)
    closeBtn:SetPoint("TOPRIGHT", -4, -4)
    closeBtn:SetNormalFontObject("GameFontNormal")
    closeBtn:SetText("X")
    closeBtn:SetScript("OnClick", function() frame:Hide() end)

    local scroll = CreateFrame("ScrollFrame", nil, frame)
    scroll:SetPoint("TOPLEFT", 8, -35)
    scroll:SetPoint("BOTTOMRIGHT", -8, 8)
    scroll:EnableMouseWheel(true)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetWidth(360)
    scroll:SetScrollChild(content)

    local yOff = 0
    local ROW_H = 18
    local FONT = "Fonts\\FRIZQT__.TTF"

    for _, group in ipairs(CHAR_GROUPS) do
        local header = content:CreateFontString(nil, "OVERLAY")
        header:SetFont(FONT, 11, "OUTLINE")
        header:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOff)
        header:SetText("|cff4eb8ff" .. group.name .. "|r")
        yOff = yOff + ROW_H + 4

        for _, charDef in ipairs(group.chars) do
            local char, desc = charDef[1], charDef[2]

            local charLabel = content:CreateFontString(nil, "OVERLAY")
            charLabel:SetFont(FONT, 14)
            charLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -yOff)
            charLabel:SetText("|cffffffff" .. char .. "|r")
            charLabel:SetWidth(30)

            local descLabel = content:CreateFontString(nil, "OVERLAY")
            descLabel:SetFont(FONT, 10)
            descLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 45, -yOff)
            descLabel:SetText("|cff888888" .. desc .. "|r")

            yOff = yOff + ROW_H
        end
        yOff = yOff + 6
    end

    content:SetHeight(yOff + 10)

    local scrollPos = 0
    local maxScroll = math.max(0, yOff - scroll:GetHeight())
    scroll:SetScript("OnMouseWheel", function(self, delta)
        scrollPos = math.max(0, math.min(maxScroll, scrollPos - delta * 30))
        self:SetVerticalScroll(scrollPos)
    end)
end

SLASH_UNICODE1 = "/unicode"
SlashCmdList["UNICODE"] = function()
    CreateTestPanel()
end
