-- GameMaster UI System - Tab Bar Component
-- Categorized dropdown navigation for switching between content panels

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

_G.GMTabBar = {}

local GMTabBar = _G.GMTabBar
local GMData = _G.GMData
local GMConfig = _G.GMConfig
local GMUI = _G.GMUI

local BAR_HEIGHT = 28
local BAR_TOP_OFFSET = -35

-- Tab index -> display name lookup
local TAB_LABELS = {
    [1] = "NPC",
    [2] = "Object",
    [3] = "Spell",
    [4] = "Spell Visual",
    [5] = "Item",
    [6] = "Player",
    [7] = "GM Powers",
    [8] = "Reputation",
    [9] = "Quest",
}

-- Categorized menu structure for the dropdown
local TAB_CATEGORIES = {
    { text = "Database", hasArrow = true, notCheckable = true, menuList = {
        { text = "NPC",          value = 1 },
        { text = "Object",       value = 2 },
        { text = "Spell",        value = 3 },
        { text = "Spell Visual", value = 4 },
        { text = "Item",         value = 5 },
    }},
    { text = "Tools", hasArrow = true, notCheckable = true, menuList = {
        { text = "Player",     value = 6 },
        { text = "Reputation", value = 8 },
        { text = "Quest",      value = 9 },
    }},
    { text = "Admin", hasArrow = true, notCheckable = true, menuList = {
        { text = "GM Powers", value = 7 },
    }},
}

local activeIndex = 1
local dropdownRef = nil

function GMTabBar.Create(parent)
    local bar = CreateFrame("Frame", nil, parent)
    bar:SetHeight(BAR_HEIGHT)
    bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, BAR_TOP_OFFSET)
    bar:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -8, BAR_TOP_OFFSET)

    local DROPDOWN_WIDTH = 150

    local function onSelect(value)
        GMTabBar.SetActive(value)
        if GMUI and GMUI.switchToTab then
            GMUI.switchToTab(value)
        end
    end

    local dropdown = CreateFullyStyledDropdown(
        bar, DROPDOWN_WIDTH, TAB_CATEGORIES, TAB_LABELS[1], onSelect
    )
    dropdown:SetPoint("LEFT", bar, "LEFT", 0, 0)

    dropdownRef = dropdown

    GMTabBar.SetActive(1)

    GMData.frames.tabBar = bar
    return bar
end

function GMTabBar.SetActive(tabIndex)
    activeIndex = tabIndex
    if dropdownRef then
        local label = TAB_LABELS[tabIndex] or ("Tab " .. tabIndex)
        dropdownRef:SetValue(tabIndex, label)
    end
end

function GMTabBar.GetActive()
    return activeIndex
end
