-- GameMaster UI System - Side Tab (Edge Strip)
-- A thin vertical strip on the screen edge that toggles the GM panel on click.
-- Always visible after login, glows on hover, arrow flips with panel state.

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

local GMData = _G.GMData
local GMUI = _G.GMUI

-- Constants
local TAB_WIDTH = 16
local TAB_HEIGHT = 80

-- Get current panel position setting
local function getPosition()
    local GMSettings = _G.GMSettings
    return GMSettings and GMSettings.current
        and GMSettings.current.position or "RIGHT"
end

-- Get arrow character based on position and panel visibility
local function getArrowText()
    local mainFrame = GMData.frames.mainFrame
    local isOpen = mainFrame and mainFrame:IsShown()
    local pos = getPosition()

    if pos == "LEFT" then
        return isOpen and "<" or ">"
    else
        return isOpen and ">" or "<"
    end
end

-- Create the side tab button
-- Can be called even before mainFrame exists; defaults to screen edge
function GMUI.createSideTab()
    local tab = CreateFrame("Button", "GMSideTab", WorldFrame)
    tab:SetSize(TAB_WIDTH, TAB_HEIGHT)
    tab:SetFrameStrata("HIGH")
    tab:SetClampedToScreen(true)

    -- Background texture (solid black)
    local bg = tab:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0, 0, 0, 0.9)
    tab.bg = bg

    -- Arrow text
    local arrow = tab:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arrow:SetPoint("CENTER", tab, "CENTER", 0, 0)
    arrow:SetTextColor(1, 1, 1, 0.8)
    tab.arrow = arrow

    -- Store reference
    GMData.frames.sideTab = tab

    -- Position and arrow
    GMUI.repositionSideTab()
    GMUI.updateSideTabArrow()

    -- Click handler: toggle panel (creates UI on demand if needed)
    tab:SetScript("OnClick", function()
        if GMUI.isSlideAnimating and GMUI.isSlideAnimating() then return end

        -- Create UI on first click if it doesn't exist yet
        if not GMData.frames.mainFrame and GMUI.initializeUI then
            GMUI.initializeUI()
        end
        if not GMData.frames.mainFrame then return end

        if GMData.frames.mainFrame:IsShown() then
            GMUI.slideOut()
        else
            GMUI.slideIn()
            local GMDataHandler = _G.GMDataHandler
            if GMDataHandler and GMDataHandler.RequestDataForCurrentTab then
                GMDataHandler.RequestDataForCurrentTab()
            end
        end
    end)

    -- Hover: brighten slightly
    tab:SetScript("OnEnter", function(self)
        self.bg:SetVertexColor(0.15, 0.15, 0.15, 1)
    end)
    tab:SetScript("OnLeave", function(self)
        self.bg:SetVertexColor(0, 0, 0, 0.9)
    end)
end

-- Update arrow direction based on panel visibility
function GMUI.updateSideTabArrow()
    local tab = GMData.frames.sideTab
    if not tab then return end
    tab.arrow:SetText(getArrowText())
end

-- Reposition the side tab to the correct screen edge
function GMUI.repositionSideTab()
    local tab = GMData.frames.sideTab
    if not tab then return end

    local mainFrame = GMData.frames.mainFrame
    local isOpen = mainFrame and mainFrame:IsShown()
    local pos = getPosition()

    tab:ClearAllPoints()
    if isOpen then
        -- Anchor flush against the panel's outer edge
        if pos == "LEFT" then
            tab:SetPoint("LEFT", mainFrame, "RIGHT", 0, 0)
        else
            tab:SetPoint("RIGHT", mainFrame, "LEFT", 0, 0)
        end
    else
        -- Anchor flush at screen edge
        if pos == "LEFT" then
            tab:SetPoint("LEFT", WorldFrame, "LEFT", 0, 0)
        else
            tab:SetPoint("RIGHT", WorldFrame, "RIGHT", 0, 0)
        end
    end
end

-- Update side tab position during slide animation
-- Anchor directly to the moving panel so the tab follows it
function GMUI.updateSideTabPosition()
    local tab = GMData.frames.sideTab
    if not tab then return end

    local mainFrame = GMData.frames.mainFrame
    local pos = getPosition()
    tab:ClearAllPoints()

    if pos == "LEFT" then
        tab:SetPoint("LEFT", mainFrame, "RIGHT", 0, 0)
    else
        tab:SetPoint("RIGHT", mainFrame, "LEFT", 0, 0)
    end
end
