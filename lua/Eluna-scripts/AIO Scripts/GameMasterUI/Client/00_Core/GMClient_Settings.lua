-- GameMaster UI System - Settings
-- Persistent user settings with SavedVariables support
-- Loads after Config (alphabetical: Settings > 01_Config)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- Settings namespace
_G.GMSettings = {}

local GMSettings = _G.GMSettings
local GMData = _G.GMData
local GMConfig = _G.GMConfig

-- Default values
GMSettings.defaults = {
    position = "RIGHT",
    width = GMConfig.config.sidePanel.width.default,
    opacity = 1.0,
    compactMode = false,
    autoOpenObjectEditor = GMConfig.config.autoOpenObjectEditor,
    shortcutBarVisible = false,
}

-- Current active settings (initialized from defaults)
GMSettings.current = {}
for k, v in pairs(GMSettings.defaults) do
    GMSettings.current[k] = v
end

-- Save current settings to SavedVariables
function GMSettings.Save()
    _G.GMSettingsSaved_DB = {}
    for k, v in pairs(GMSettings.current) do
        _G.GMSettingsSaved_DB[k] = v
    end
end

-- Load settings from SavedVariables, merging with defaults for missing keys
function GMSettings.Load()
    local saved = _G.GMSettingsSaved_DB
    if not saved or type(saved) ~= "table" then
        -- No saved data, reset to defaults
        for k, v in pairs(GMSettings.defaults) do
            GMSettings.current[k] = v
        end
        return
    end

    -- Merge: use saved value if present, default otherwise
    for k, v in pairs(GMSettings.defaults) do
        if saved[k] ~= nil then
            GMSettings.current[k] = saved[k]
        else
            GMSettings.current[k] = v
        end
    end
end

-- Apply current settings to the main frame
function GMSettings.Apply()
    local cur = GMSettings.current

    -- Compact mode → update PlayerList view mode (independent of mainFrame)
    local GMCards = _G.GMCards
    if GMCards and GMCards.PlayerList and GMCards.PlayerList.SetViewMode then
        GMCards.PlayerList.SetViewMode(cur.compactMode and "compact" or "detailed")
    end

    local frames = GMData and GMData.frames
    local mainFrame = frames and frames.mainFrame
    if not mainFrame then return end

    -- Reposition
    mainFrame:ClearAllPoints()
    if cur.position == "LEFT" then
        mainFrame:SetPoint("LEFT", UIParent, "LEFT", 0, 0)
    else
        mainFrame:SetPoint("RIGHT", UIParent, "RIGHT", 0, 0)
    end

    -- Resize width
    mainFrame:SetWidth(cur.width)

    -- Opacity
    mainFrame:SetAlpha(cur.opacity)

    -- Refresh child layouts that can't use two-point anchoring
    local GMUI = _G.GMUI
    if GMUI and GMUI.refreshLayout then
        GMUI.refreshLayout()
    end

    -- Reposition the side tab when settings change (e.g. LEFT↔RIGHT)
    if GMUI and GMUI.repositionSideTab then
        GMUI.repositionSideTab()
    end
    if GMUI and GMUI.updateSideTabArrow then
        GMUI.updateSideTabArrow()
    end

    -- Reposition shortcut bar when settings change (e.g. LEFT↔RIGHT)
    local GMShortcutBar = _G.GMShortcutBar
    if GMShortcutBar and GMShortcutBar.Reposition then
        GMShortcutBar.Reposition()
    end
end

-- Set a single setting and apply
function GMSettings.Set(key, value)
    if GMSettings.defaults[key] == nil then return end
    GMSettings.current[key] = value
    GMSettings.Apply()
    GMSettings.Save()
end

-- Toggle a boolean setting
function GMSettings.Toggle(key)
    if type(GMSettings.current[key]) ~= "boolean" then return end
    GMSettings.current[key] = not GMSettings.current[key]
    GMSettings.Apply()
    GMSettings.Save()
end

-- Get a setting value
function GMSettings.Get(key)
    return GMSettings.current[key]
end

-- Reset all settings to defaults
function GMSettings.Reset()
    for k, v in pairs(GMSettings.defaults) do
        GMSettings.current[k] = v
    end
    GMSettings.Apply()
    GMSettings.Save()
end

-- Load saved settings on initialization
GMSettings.Load()

-- Settings system initialized
