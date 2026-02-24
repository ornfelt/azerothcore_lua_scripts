-- GMClient_05_Models.lua
-- Model management and interaction for Game Master UI client
local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Verify namespace exists
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get module references
local GMModels = _G.GMModels

-- Import namespaces
local GMUtils = _G.GMUtils
local GMData = _G.GMData
local GMConfig = _G.GMConfig
local GMUI = _G.GMUI

-- Constants for model management
local MODEL_CONFIG = {
    POSITION = {
        SPEED = {
            X = 0.001,      -- Horizontal pan speed
            Y = 0.001,      -- Vertical pan speed (with shift)
            Z = 0.001,      -- Depth pan speed
        },
        DEFAULT = {
            X = 0,
            Y = 0,
            Z = 0,
        },
        LIMITS = {
            X = { MIN = -5, MAX = 5 },
            Y = { MIN = -5, MAX = 5 },
            Z = { MIN = -5, MAX = 5 },
        }
    },
    ROTATION = {
        SPEED = {
            YAW = 0.01,     -- Horizontal rotation
            PITCH = 0.008,  -- Vertical rotation (with shift)
        },
        DEFAULT = {
            FACING = 0,
            PITCH = 0,
        }
    },
    SCALE = {
        MIN = 0.25,         -- Extended zoom out
        MAX = 4.0,          -- Extended zoom in
        STEP = 0.05,        -- Smooth stepping
        DEFAULT = 1.0,
        STEP_FAST = 0.1,    -- With shift modifier
    },
    CONTROLS = {
        INVERT_ROTATION = false,
        INVERT_PAN = false,
        DOUBLE_CLICK_TIME = 0.3,  -- Time window for double-click
    }
}

local ITEM_MODEL_CONFIG = {
    DELAY = 0.01,
    POOL_SIZE = 15,
    ROTATION = 0.4,
    ZOOM = {
        MIN = 0.5,
        MAX = 2.0,
        STEP = 0.1,
        DEFAULT = 1.0,
    },
    POSITION = { X = 0, Y = 0, Z = 0 },
    SIZE = {
        WIDTH_OFFSET = 20,
        HEIGHT_FACTOR = 0.6,
    },
}

local VIEW_CONFIG = {
    ICONS = {
        MAGNIFIER = "Interface\\Icons\\INV_Misc_Spyglass_03",
        INFO = "Interface\\Icons\\INV_Misc_Book_09",
        HELP = "Interface\\Icons\\INV_Misc_Book_11",
        CAMERA = "Interface\\Icons\\INV_Misc_Spyglass_02",
        ZOOM = "Interface\\Icons\\Ability_Hunter_MasterMarksman",
    },
    TEXTURES = {
        BACKDROP = "Interface\\DialogFrame\\UI-DialogBox-Background",
        BORDER = "Interface\\Tooltips\\UI-Tooltip-Border",
    },
    SIZES = {
        ICON = 16,
        FULL_VIEW = 500,  -- Increased to accommodate side panels
        FULL_VIEW_HEIGHT = 530,  -- Increased for title bar and instructions panel
        TITLE_BAR_HEIGHT = 30,
        INSTRUCTIONS_HEIGHT = 80,  -- Height of instructions panel at bottom
        SIDE_PANEL_WIDTH = 40,  -- Width of side button panels
        TILE = 16,
        INSETS = 5,
        PRESET_BUTTON_SIZE = 32,
    },
}

-- Initialize model pool
local modelFrameCache = {}
local initializedPool = false

-- Utility: Clamp helper (WoW 3.3.5 doesn't have math.clamp)
local function Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

-- Helper function to get spell school color based on schoolMask
local function getSpellSchoolColor(schoolMask)
    -- Spell school masks (can be combined with bitwise OR)
    local SPELL_SCHOOL_NORMAL = 1      -- Physical
    local SPELL_SCHOOL_HOLY = 2        -- Holy
    local SPELL_SCHOOL_FIRE = 4        -- Fire
    local SPELL_SCHOOL_NATURE = 8      -- Nature
    local SPELL_SCHOOL_FROST = 16      -- Frost
    local SPELL_SCHOOL_SHADOW = 32     -- Shadow
    local SPELL_SCHOOL_ARCANE = 64     -- Arcane

    -- Check each school (in order of visual preference)
    if schoolMask and schoolMask > 0 then
        -- Check for specific schools using bitwise AND
        if bit.band(schoolMask, SPELL_SCHOOL_FIRE) > 0 then
            return { r = 1.0, g = 0.3, b = 0.0, name = "Fire" }  -- Orange-red
        elseif bit.band(schoolMask, SPELL_SCHOOL_FROST) > 0 then
            return { r = 0.3, g = 0.7, b = 1.0, name = "Frost" }  -- Cyan-blue
        elseif bit.band(schoolMask, SPELL_SCHOOL_NATURE) > 0 then
            return { r = 0.2, g = 1.0, b = 0.2, name = "Nature" }  -- Green
        elseif bit.band(schoolMask, SPELL_SCHOOL_SHADOW) > 0 then
            return { r = 0.5, g = 0.1, b = 0.8, name = "Shadow" }  -- Purple
        elseif bit.band(schoolMask, SPELL_SCHOOL_ARCANE) > 0 then
            return { r = 1.0, g = 0.3, b = 1.0, name = "Arcane" }  -- Pink-purple
        elseif bit.band(schoolMask, SPELL_SCHOOL_HOLY) > 0 then
            return { r = 1.0, g = 0.9, b = 0.2, name = "Holy" }  -- Golden
        end
    end

    -- Default: Physical/Normal
    return { r = 0.8, g = 0.8, b = 0.8, name = "Physical" }  -- Gray
end

-- Player race/gender detection and positioning
local function getPlayerRaceGender()
    local _, race = UnitRace("player")
    local gender = UnitSex("player") -- 2 = male, 3 = female
    local isFemale = (gender == 3)
    return race, isFemale
end

-- Race/gender specific positioning for better model display
local RACE_POSITIONING = {
    ["HUMAN"] = {
        [true] = { point = "CENTER", x = 4, y = -1, width = 169, height = 169 }, -- female
        [false] = { point = "CENTER", x = 4, y = 2, width = 180, height = 180 }  -- male
    },
    ["ORC"] = {
        [true] = { point = "CENTER", x = 0, y = -5, width = 165, height = 165 },
        [false] = { point = "CENTER", x = 0, y = 0, width = 185, height = 185 }
    },
    ["DWARF"] = {
        [true] = { point = "CENTER", x = 2, y = -3, width = 155, height = 155 },
        [false] = { point = "CENTER", x = 2, y = 0, width = 170, height = 170 }
    },
    ["NIGHTELF"] = {
        [true] = { point = "CENTER", x = 0, y = 0, width = 175, height = 175 },
        [false] = { point = "CENTER", x = 0, y = 5, width = 190, height = 190 }
    },
    ["UNDEAD"] = {
        [true] = { point = "CENTER", x = 0, y = -2, width = 165, height = 165 },
        [false] = { point = "CENTER", x = 0, y = 2, width = 175, height = 175 }
    },
    ["TAUREN"] = {
        [true] = { point = "CENTER", x = 0, y = 0, width = 195, height = 195 },
        [false] = { point = "CENTER", x = 0, y = 5, width = 210, height = 210 }
    },
    ["GNOME"] = {
        [true] = { point = "CENTER", x = 0, y = -8, width = 145, height = 145 },
        [false] = { point = "CENTER", x = 0, y = -5, width = 150, height = 150 }
    },
    ["TROLL"] = {
        [true] = { point = "CENTER", x = 0, y = 0, width = 180, height = 180 },
        [false] = { point = "CENTER", x = 0, y = 8, width = 195, height = 195 }
    },
    ["BLOODELF"] = {
        [true] = { point = "CENTER", x = 0, y = 0, width = 170, height = 170 },
        [false] = { point = "CENTER", x = 0, y = 3, width = 175, height = 175 }
    },
    ["DRAENEI"] = {
        [true] = { point = "CENTER", x = 0, y = 2, width = 175, height = 175 },
        [false] = { point = "CENTER", x = 0, y = 8, width = 190, height = 190 }
    }
}

-- Default positioning for unknown races
local DEFAULT_POSITIONING = {
    [true] = { point = "CENTER", x = 0, y = 0, width = 170, height = 170 },
    [false] = { point = "CENTER", x = 0, y = 0, width = 180, height = 180 }
}

-- Initialize model pool
function GMModels.initializeModelPool()
    if not initializedPool then
        for i = 1, ITEM_MODEL_CONFIG.POOL_SIZE do
            local model = CreateFrame("DressUpModel")
            model:SetUnit("player")
            model:Undress()
            model:Hide()
            model.initialized = true
            table.insert(modelFrameCache, model)
        end
        initializedPool = true
        GMUtils.debug("Model pool initialized with", ITEM_MODEL_CONFIG.POOL_SIZE, "models")
    end
end

-- Release model back to pool
function GMModels.releaseModel(model)
    if model then
        model:ClearModel()
        model:SetUnit("player")
        model:Undress()
        model:Hide()
        model:ClearAllPoints()
        model:SetParent(nil)
        table.insert(modelFrameCache, model)
    end
end

-- Acquire model from pool
function GMModels.acquireModel()
    GMModels.initializeModelPool()
    local model = table.remove(modelFrameCache)
    if not model then
        model = CreateFrame("DressUpModel")
        model.initialized = true
    end

    -- Reset model state completely
    model:ClearModel()
    model:SetUnit("player")
    model:Undress()
    model:SetRotation(ITEM_MODEL_CONFIG.ROTATION)
    model:Show()

    return model
end

-- Handle model rotation (horizontal and vertical)
local function handleModelRotation(model, mouseX, mouseY, dragStartX, dragStartY, state, isShiftDown)
    if not model or not state then return state end
    
    local deltaX = (mouseX - dragStartX)
    local deltaY = (mouseY - dragStartY)
    
    -- Apply inversion if configured
    if MODEL_CONFIG.CONTROLS.INVERT_ROTATION then
        deltaX = -deltaX
        deltaY = -deltaY
    end
    
    -- Horizontal rotation (yaw) - always active
    local yawSpeed = MODEL_CONFIG.ROTATION.SPEED.YAW
    state.facing = state.facing + (deltaX * yawSpeed)
    model:SetFacing(state.facing)
    
    -- Vertical rotation (pitch) - only with shift key
    if isShiftDown and MODEL_CONFIG.ROTATION.SPEED.PITCH then
        local pitchSpeed = MODEL_CONFIG.ROTATION.SPEED.PITCH
        state.pitch = (state.pitch or 0) + (deltaY * pitchSpeed)
        -- Clamp pitch to reasonable range
        state.pitch = Clamp(state.pitch, -1.5, 1.5)
        -- Note: SetPitch might not work in 3.3.5, this is for future compatibility
        if model.SetPitch then
            model:SetPitch(state.pitch)
        end
    end
    
    return state
end

-- Handle model position (X, Y, Z movement)
local function handleModelPosition(model, mouseX, mouseY, dragStartX, dragStartY, state, isShiftDown)
    if not model or not state or not state.position then return state end
    
    local deltaX = (mouseX - dragStartX)
    local deltaY = (mouseY - dragStartY)
    
    -- Apply inversion if configured
    if MODEL_CONFIG.CONTROLS.INVERT_PAN then
        deltaX = -deltaX
        deltaY = -deltaY
    end
    
    local speedX = MODEL_CONFIG.POSITION.SPEED.X
    local speedY = MODEL_CONFIG.POSITION.SPEED.Y
    local speedZ = MODEL_CONFIG.POSITION.SPEED.Z
    
    -- Update position based on modifier keys
    if isShiftDown then
        -- Shift + drag: move up/down (Y axis)
        state.position.y = state.position.y + (deltaY * speedY)
    else
        -- Normal drag: move in X/Z plane
        state.position.x = state.position.x + (deltaX * speedX)
        state.position.z = state.position.z + (deltaY * speedZ)
    end
    
    -- Apply position limits
    local limits = MODEL_CONFIG.POSITION.LIMITS
    state.position.x = Clamp(state.position.x, limits.X.MIN, limits.X.MAX)
    state.position.y = Clamp(state.position.y, limits.Y.MIN, limits.Y.MAX)
    state.position.z = Clamp(state.position.z, limits.Z.MIN, limits.Z.MAX)
    
    model:SetPosition(state.position.x, state.position.y, state.position.z)
    
    return state
end

-- Handle model scale (zoom)
local function handleModelScale(model, delta, currentScale, isShiftDown)
    if not model then return currentScale end
    
    local minScale = MODEL_CONFIG.SCALE.MIN
    local maxScale = MODEL_CONFIG.SCALE.MAX
    local step = isShiftDown and MODEL_CONFIG.SCALE.STEP_FAST or MODEL_CONFIG.SCALE.STEP
    
    local newScale = currentScale
    if delta > 0 then
        newScale = math.min(currentScale + step, maxScale)
    elseif delta < 0 then
        newScale = math.max(currentScale - step, minScale)
    end
    
    model:SetModelScale(newScale)
    return newScale
end

-- Reset model to default state
local function resetModelState(model, state)
    if not model or not state then return end
    
    -- Reset position
    state.position.x = MODEL_CONFIG.POSITION.DEFAULT.X
    state.position.y = MODEL_CONFIG.POSITION.DEFAULT.Y
    state.position.z = MODEL_CONFIG.POSITION.DEFAULT.Z
    model:SetPosition(state.position.x, state.position.y, state.position.z)
    
    -- Reset rotation
    state.facing = MODEL_CONFIG.ROTATION.DEFAULT.FACING
    state.pitch = MODEL_CONFIG.ROTATION.DEFAULT.PITCH
    model:SetFacing(state.facing)
    if model.SetPitch then
        model:SetPitch(state.pitch)
    end
    
    -- Reset scale
    state.scale = MODEL_CONFIG.SCALE.DEFAULT
    model:SetModelScale(state.scale)
    
    return state
end

-- Helper function to update status display
local function updateStatusDisplay(model, state)
    if not model or not state then return end

    local parent = model:GetParent()
    if not parent or not parent.statusDisplay then return end

    local statusText = ""

    -- Add mode indicator
    if state.dragMode == "rotate" then
        statusText = "|cFFFFFF00[Rotating]|r"
    elseif state.dragMode == "pan" then
        statusText = "|cFF00FF00[Panning]|r"
    elseif state.dragMode == "zoom" then
        statusText = "|cFF00BFFF[Zooming]|r"
    end

    -- Add zoom level
    local zoomPercent = math.floor(state.scale * 100)
    if statusText ~= "" then
        statusText = statusText .. " "
    end
    statusText = statusText .. string.format("Zoom: %d%%", zoomPercent)

    parent.statusDisplay:SetText(statusText)
end

-- Setup model mouse interaction
function GMModels.setupModelInteraction(model)
    if not model then return end

    local state = {
        facing = MODEL_CONFIG.ROTATION.DEFAULT.FACING,
        pitch = MODEL_CONFIG.ROTATION.DEFAULT.PITCH,
        position = {
            x = MODEL_CONFIG.POSITION.DEFAULT.X,
            y = MODEL_CONFIG.POSITION.DEFAULT.Y,
            z = MODEL_CONFIG.POSITION.DEFAULT.Z,
        },
        scale = MODEL_CONFIG.SCALE.DEFAULT,
        dragMode = nil, -- "rotate", "pan", or nil
        dragStart = { x = 0, y = 0 },
        lastClickTime = 0,
        lastClickButton = nil,
    }

    -- Set initial state
    model:SetPosition(state.position.x, state.position.y, state.position.z)
    model:SetFacing(state.facing)
    model:SetModelScale(state.scale)

    model:EnableMouse(true)
    model:EnableMouseWheel(true)
    model:SetMovable(false)

    -- Update initial status
    updateStatusDisplay(model, state)

    -- Mouse down handler
    model:SetScript("OnMouseDown", function(self, button)
        local currentTime = GetTime()

        -- Check for double-click
        if button == state.lastClickButton and (currentTime - state.lastClickTime) < MODEL_CONFIG.CONTROLS.DOUBLE_CLICK_TIME then
            -- Double-click detected - reset view
            resetModelState(self, state)
            updateStatusDisplay(self, state)
            state.lastClickTime = 0
            return
        end

        state.lastClickTime = currentTime
        state.lastClickButton = button

        -- Set drag mode based on button
        if button == "LeftButton" then
            state.dragMode = "rotate"
        elseif button == "RightButton" then
            state.dragMode = "pan"
        elseif button == "MiddleButton" then
            state.dragMode = "zoom"
        end

        if state.dragMode then
            state.dragStart.x, state.dragStart.y = GetCursorPosition()
            updateStatusDisplay(self, state)
        end
    end)

    -- Mouse up handler
    model:SetScript("OnMouseUp", function(self, button)
        state.dragMode = nil
        updateStatusDisplay(self, state)
    end)

    -- Update handler for dragging
    model:SetScript("OnUpdate", function(self)
        if state.dragMode then
            local mouseX, mouseY = GetCursorPosition()
            local isShiftDown = IsShiftKeyDown()
            
            if state.dragMode == "rotate" then
                -- Left mouse: Rotation
                state = handleModelRotation(self, mouseX, mouseY, state.dragStart.x, state.dragStart.y, state, isShiftDown)
            elseif state.dragMode == "pan" then
                -- Right mouse: Pan
                state = handleModelPosition(self, mouseX, mouseY, state.dragStart.x, state.dragStart.y, state, isShiftDown)
            elseif state.dragMode == "zoom" then
                -- Middle mouse: Alternative zoom (vertical drag)
                local deltaY = (mouseY - state.dragStart.y) * 0.01
                state.scale = handleModelScale(self, deltaY, state.scale, isShiftDown)
            end
            
            -- Update drag start for smooth movement
            state.dragStart.x, state.dragStart.y = mouseX, mouseY
        end
    end)

    -- Mouse wheel zoom
    model:SetScript("OnMouseWheel", function(self, delta)
        state.scale = handleModelScale(self, delta, state.scale, IsShiftKeyDown())
        updateStatusDisplay(self, state)
    end)
    
    -- Store state for external access
    model.viewState = state
end

-- Create full view frame
function GMModels.createFullViewFrame(index)
    local frame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    frame:SetSize(VIEW_CONFIG.SIZES.FULL_VIEW, VIEW_CONFIG.SIZES.FULL_VIEW_HEIGHT)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)

    -- Store state info on frame for status display
    frame.statusText = { mode = "", zoom = "100%" }

    -- Create title bar for dragging
    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetHeight(30)
    titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")

    -- Title bar background using UI style guide colors
    local titleBg = titleBar:CreateTexture(nil, "BACKGROUND")
    titleBg:SetAllPoints()
    titleBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    titleBg:SetVertexColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)

    -- Add a subtle bottom border to the title bar
    local titleBorder = titleBar:CreateTexture(nil, "OVERLAY")
    titleBorder:SetHeight(1)
    titleBorder:SetPoint("BOTTOMLEFT", titleBar, "BOTTOMLEFT", 0, 0)
    titleBorder:SetPoint("BOTTOMRIGHT", titleBar, "BOTTOMRIGHT", 0, 0)
    titleBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
    titleBorder:SetVertexColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    -- Title text (left-aligned to make room for status)
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", titleBar, "LEFT", 10, 0)
    title:SetText("Model Viewer")
    title:SetTextColor(1, 1, 1, 1)

    -- Status display (mode and zoom level) in title bar
    local statusText = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statusText:SetPoint("LEFT", title, "RIGHT", 15, 0)
    statusText:SetTextColor(0.7, 0.9, 1.0, 1)  -- Light blue
    frame.statusDisplay = statusText

    -- Make only title bar draggable
    titleBar:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)
    titleBar:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
    end)

    -- Create instructions panel at bottom
    local instructionsPanel = CreateFrame("Frame", nil, frame)
    instructionsPanel:SetHeight(VIEW_CONFIG.SIZES.INSTRUCTIONS_HEIGHT)
    instructionsPanel:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
    instructionsPanel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)

    -- Instructions panel background
    local instrBg = instructionsPanel:CreateTexture(nil, "BACKGROUND")
    instrBg:SetAllPoints()
    instrBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    instrBg:SetVertexColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 0.95)

    -- Instructions panel border
    local instrBorder = instructionsPanel:CreateTexture(nil, "BORDER")
    instrBorder:SetHeight(1)
    instrBorder:SetPoint("TOPLEFT", instructionsPanel, "TOPLEFT", 0, 0)
    instrBorder:SetPoint("TOPRIGHT", instructionsPanel, "TOPRIGHT", 0, 0)
    instrBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
    instrBorder:SetVertexColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    -- Instructions title
    local instrTitle = instructionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    instrTitle:SetPoint("TOP", instructionsPanel, "TOP", 0, -5)
    instrTitle:SetText("Controls")
    instrTitle:SetTextColor(1, 0.82, 0, 1)  -- Gold

    -- Left column of instructions
    local leftCol = instructionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    leftCol:SetPoint("TOPLEFT", instructionsPanel, "TOPLEFT", 10, -22)
    leftCol:SetJustifyH("LEFT")
    leftCol:SetText("|cFF00FF00Left Drag:|r Rotate\n|cFF00FF00Right Drag:|r Pan\n|cFF00FF00Scroll:|r Zoom")

    -- Right column of instructions
    local rightCol = instructionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rightCol:SetPoint("TOPLEFT", instructionsPanel, "TOP", 10, -22)
    rightCol:SetJustifyH("LEFT")
    rightCol:SetText("|cFF00FF00Double Click:|r Reset\n|cFF00FF00Shift+Drag:|r Advanced\n|cFF00FF00ESC/R:|r Close/Reset")

    frame.instructionsPanel = instructionsPanel

    -- Create side panel for preset buttons (right side)
    local sidePanel = CreateFrame("Frame", nil, frame)
    sidePanel:SetWidth(VIEW_CONFIG.SIZES.SIDE_PANEL_WIDTH)
    sidePanel:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -VIEW_CONFIG.SIZES.TITLE_BAR_HEIGHT)
    sidePanel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, VIEW_CONFIG.SIZES.INSTRUCTIONS_HEIGHT)

    -- Side panel background
    local sideBg = sidePanel:CreateTexture(nil, "BACKGROUND")
    sideBg:SetAllPoints()
    sideBg:SetTexture("Interface\\Buttons\\WHITE8X8")
    sideBg:SetVertexColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 0.8)

    -- Side panel border
    local sideBorder = sidePanel:CreateTexture(nil, "BORDER")
    sideBorder:SetWidth(1)
    sideBorder:SetPoint("TOPLEFT", sidePanel, "TOPLEFT", 0, 0)
    sideBorder:SetPoint("BOTTOMLEFT", sidePanel, "BOTTOMLEFT", 0, 0)
    sideBorder:SetTexture("Interface\\Buttons\\WHITE8X8")
    sideBorder:SetVertexColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    -- Helper function to create preset buttons
    local function createPresetButton(parent, text, yOffset, tooltip, onClick)
        local btn = CreateStyledButton(parent, text, VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE, VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE)
        btn:SetPoint("TOP", parent, "TOP", 0, yOffset)
        btn:SetScript("OnClick", onClick)
        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:AddLine(tooltip, 1, 1, 1)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        return btn
    end

    -- Camera angle preset buttons
    local btnYOffset = -10

    -- Front view button
    createPresetButton(sidePanel, "F", btnYOffset, "Front View", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.facing = 0
            model:SetFacing(model.viewState.facing)
        end
    end)
    btnYOffset = btnYOffset - VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE - 5

    -- Back view button
    createPresetButton(sidePanel, "B", btnYOffset, "Back View", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.facing = math.pi
            model:SetFacing(model.viewState.facing)
        end
    end)
    btnYOffset = btnYOffset - VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE - 5

    -- Left view button
    createPresetButton(sidePanel, "L", btnYOffset, "Left View", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.facing = math.pi / 2
            model:SetFacing(model.viewState.facing)
        end
    end)
    btnYOffset = btnYOffset - VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE - 5

    -- Right view button
    createPresetButton(sidePanel, "R", btnYOffset, "Right View", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.facing = -math.pi / 2
            model:SetFacing(model.viewState.facing)
        end
    end)
    btnYOffset = btnYOffset - VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE - 10

    -- Separator line
    local separator = sidePanel:CreateTexture(nil, "OVERLAY")
    separator:SetHeight(1)
    separator:SetPoint("LEFT", sidePanel, "LEFT", 5, btnYOffset + VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE/2)
    separator:SetPoint("RIGHT", sidePanel, "RIGHT", -5, btnYOffset + VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE/2)
    separator:SetTexture("Interface\\Buttons\\WHITE8X8")
    separator:SetVertexColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 0.5)
    btnYOffset = btnYOffset - 10

    -- Zoom preset buttons
    -- Fit button (default zoom)
    createPresetButton(sidePanel, "Fit", btnYOffset, "Fit to View (100%)", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.scale = MODEL_CONFIG.SCALE.DEFAULT
            model:SetModelScale(model.viewState.scale)
            updateStatusDisplay(model, model.viewState)
        end
    end)
    btnYOffset = btnYOffset - VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE - 5

    -- Zoom 50% button
    createPresetButton(sidePanel, "50%", btnYOffset, "Zoom to 50%", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.scale = 0.5
            model:SetModelScale(model.viewState.scale)
            updateStatusDisplay(model, model.viewState)
        end
    end)
    btnYOffset = btnYOffset - VIEW_CONFIG.SIZES.PRESET_BUTTON_SIZE - 5

    -- Zoom 200% button
    createPresetButton(sidePanel, "200", btnYOffset, "Zoom to 200%", function()
        local model = _G["FullModel" .. index]
        if model and model.viewState then
            model.viewState.scale = 2.0
            model:SetModelScale(model.viewState.scale)
            updateStatusDisplay(model, model.viewState)
        end
    end)

    frame.sidePanel = sidePanel

    -- Enable keyboard input for shortcuts
    frame:EnableKeyboard(true)

    -- Keyboard handler for shortcuts (WoW 3.3.5 compatible)
    frame:SetScript("OnKeyDown", function(self, key)
        local model = _G["FullModel" .. index]

        if key == "ESCAPE" then
            -- ESC to close
            self:Hide()
        elseif key == "R" then
            -- R to reset
            if model and model.viewState and GMModels and GMModels.resetModelState then
                GMModels.resetModelState(model, model.viewState)
                updateStatusDisplay(model, model.viewState)
            end
        elseif key == "EQUALS" or key == "+" then
            -- + to zoom in
            if model and model.viewState then
                model.viewState.scale = handleModelScale(model, 1, model.viewState.scale, IsShiftKeyDown())
                updateStatusDisplay(model, model.viewState)
            end
        elseif key == "MINUS" or key == "-" then
            -- - to zoom out
            if model and model.viewState then
                model.viewState.scale = handleModelScale(model, -1, model.viewState.scale, IsShiftKeyDown())
                updateStatusDisplay(model, model.viewState)
            end
        elseif key == "LEFT" then
            -- Left arrow to rotate left
            if model and model.viewState then
                model.viewState.facing = model.viewState.facing - 0.1
                model:SetFacing(model.viewState.facing)
            end
        elseif key == "RIGHT" then
            -- Right arrow to rotate right
            if model and model.viewState then
                model.viewState.facing = model.viewState.facing + 0.1
                model:SetFacing(model.viewState.facing)
            end
        elseif key == "UP" then
            -- Up arrow to rotate up (pitch)
            if model and model.viewState then
                model.viewState.pitch = (model.viewState.pitch or 0) + 0.05
                model.viewState.pitch = Clamp(model.viewState.pitch, -1.5, 1.5)
                if model.SetPitch then
                    model:SetPitch(model.viewState.pitch)
                end
            end
        elseif key == "DOWN" then
            -- Down arrow to rotate down (pitch)
            if model and model.viewState then
                model.viewState.pitch = (model.viewState.pitch or 0) - 0.05
                model.viewState.pitch = Clamp(model.viewState.pitch, -1.5, 1.5)
                if model.SetPitch then
                    model:SetPitch(model.viewState.pitch)
                end
            end
        end
    end)

    -- Add custom name for identification
    _G["FullViewFrame" .. index] = frame
    
    -- Add OnHide handler for cleanup
    frame:SetScript("OnHide", function(self)
        -- Clean up any associated model resources
        local model = _G["FullModel" .. index]
        if model then
            -- Clean up icon frame if it exists
            if model.iconFrame then
                model.iconFrame:Hide()
                -- Don't set parent to nil to preserve for next use
                -- model.iconFrame:SetParent(nil)
                -- model.iconFrame = nil
            end
            -- Stop any OnUpdate scripts for animations
            if not model.isSpellVisual and not model.isGameObject then
                model:SetScript("OnUpdate", nil)
            end
            -- Don't clear model to preserve it for when shown again
            -- model:ClearModel()
        end
    end)
    
    return frame
end

-- Create model view
function GMModels.createModelView(parent, entity, type, index)
    local model = CreateFrame("DressUpModel", "FullModel" .. index, parent)
    -- Position model between title bar, instructions panel, and side panel
    model:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -VIEW_CONFIG.SIZES.TITLE_BAR_HEIGHT)
    model:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -VIEW_CONFIG.SIZES.SIDE_PANEL_WIDTH, VIEW_CONFIG.SIZES.INSTRUCTIONS_HEIGHT)
    model:SetFrameStrata("DIALOG")
    model:SetFrameLevel(parent:GetFrameLevel() + 1)
    model:EnableMouse(true)
    model:SetMovable(false)  -- Model itself should not be movable
    model:ClearModel()

    -- Store entity data for restoration
    model.entityData = entity
    model.entityType = type
    
    -- Forward declare RestoreModelData
    local RestoreModelData
    
    -- Set model based on type
    local modelSetters = {
        NPC = function()
            model:SetCreature(entity.entry)
        end,
        GameObject = function()
            if entity.modelName then
                model:SetModel(entity.modelName)
            else
                -- Fallback to cube if no model
                model:SetModel("World\\Generic\\human\\passive doodads\\genericdoodads\\g_cube_01.mdx")
            end
        end,
        Spell = function()
            -- Try to load 3D spell visual from FilePath (if available from database JOIN)
            local visualSuccess = false

            -- Try FilePath from visualID1 (spellVisual1)
            if entity.visualFilePath1 and entity.visualFilePath1 ~= "" then
                visualSuccess = pcall(function()
                    model:SetModel(entity.visualFilePath1)
                    model:SetModelScale(1.5)  -- Scale up spell effects for better visibility
                end)
                if visualSuccess and GMConfig.config.debug then
                    GMUtils.debug("Spell visual loaded from visualFilePath1:", entity.visualFilePath1)
                end
            end

            -- Try FilePath from visualID2 (spellVisual2) if first failed
            if not visualSuccess and entity.visualFilePath2 and entity.visualFilePath2 ~= "" then
                visualSuccess = pcall(function()
                    model:SetModel(entity.visualFilePath2)
                    model:SetModelScale(1.5)
                end)
                if visualSuccess and GMConfig.config.debug then
                    GMUtils.debug("Spell visual loaded from visualFilePath2:", entity.visualFilePath2)
                end
            end

            -- Fallback: Show spell icon with school-based visual effects
            if not visualSuccess then
                -- Try to get spell icon
                local spellName, _, spellIcon = GetSpellInfo(entity.spellID)
                if spellIcon then
                    -- Get spell school color for themed effects
                    local schoolColor = getSpellSchoolColor(entity.schoolMask)

                    -- Create a simple model with the spell icon
                    model:SetModel("Interface\\Buttons\\TalkToMeQuestion.mdx")
                    model:SetModelScale(2.0)

                    -- Create icon frame overlaid on model
                    local iconFrame = CreateFrame("Frame", nil, model:GetParent())
                    iconFrame:SetSize(192, 192)  -- Increased from 128 to 192
                    iconFrame:SetPoint("CENTER", model, "CENTER", 0, 0)
                    iconFrame:SetFrameStrata("FULLSCREEN")  -- Ensure it's above model
                    iconFrame:SetFrameLevel(model:GetFrameLevel() + 10)

                    -- Layer 1: Outer glow (behind everything)
                    local outerGlow = iconFrame:CreateTexture(nil, "BACKGROUND")
                    outerGlow:SetSize(280, 280)
                    outerGlow:SetPoint("CENTER")
                    outerGlow:SetTexture("Interface\\GLUES\\MODELS\\UI_Draenei\\GenericGlow64")
                    outerGlow:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)
                    outerGlow:SetBlendMode("ADD")
                    outerGlow:SetDrawLayer("BACKGROUND", -3)

                    -- Layer 2: Middle glow
                    local middleGlow = iconFrame:CreateTexture(nil, "BACKGROUND")
                    middleGlow:SetSize(240, 240)
                    middleGlow:SetPoint("CENTER")
                    middleGlow:SetTexture("Interface\\GLUES\\MODELS\\UI_Draenei\\GenericGlow64")
                    middleGlow:SetVertexColor(schoolColor.r * 0.8, schoolColor.g * 0.8, schoolColor.b * 0.8, 1)
                    middleGlow:SetBlendMode("ADD")
                    middleGlow:SetDrawLayer("BACKGROUND", -2)

                    -- Layer 3: Inner glow
                    local innerGlow = iconFrame:CreateTexture(nil, "BACKGROUND")
                    innerGlow:SetSize(200, 200)
                    innerGlow:SetPoint("CENTER")
                    innerGlow:SetTexture("Interface\\GLUES\\MODELS\\UI_Draenei\\GenericGlow64")
                    innerGlow:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)
                    innerGlow:SetBlendMode("ADD")
                    innerGlow:SetDrawLayer("BACKGROUND", -1)

                    -- Layer 4: Dark background circle (behind icon)
                    local darkBg = iconFrame:CreateTexture(nil, "BORDER")
                    darkBg:SetSize(194, 194)
                    darkBg:SetPoint("CENTER")
                    darkBg:SetTexture("Interface\\Buttons\\WHITE8X8")
                    darkBg:SetVertexColor(0.1, 0.1, 0.1, 0.9)
                    darkBg:SetDrawLayer("BORDER", 0)

                    -- Layer 5: Main spell icon (MOST IMPORTANT - must be visible!)
                    local icon = iconFrame:CreateTexture(nil, "ARTWORK")
                    icon:SetSize(180, 180)
                    icon:SetPoint("CENTER")
                    icon:SetTexture(spellIcon)
                    icon:SetDrawLayer("ARTWORK", 5)  -- High sublevel to ensure visibility

                    -- Layer 6: School-colored border frame
                    local borderFrame = CreateFrame("Frame", nil, iconFrame)
                    borderFrame:SetAllPoints()
                    borderFrame:SetFrameLevel(iconFrame:GetFrameLevel() + 1)

                    local borderTexture = borderFrame:CreateTexture(nil, "OVERLAY")
                    borderTexture:SetSize(196, 196)
                    borderTexture:SetPoint("CENTER")
                    borderTexture:SetTexture("Interface\\Buttons\\WHITE8X8")
                    borderTexture:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 0)
                    borderTexture:SetDrawLayer("OVERLAY", 1)

                    -- Create border by drawing 4 rectangles (top, bottom, left, right)
                    local borderThickness = 4

                    -- Top border
                    local borderTop = iconFrame:CreateTexture(nil, "OVERLAY")
                    borderTop:SetSize(196, borderThickness)
                    borderTop:SetPoint("TOP", icon, "TOP", 0, borderThickness/2 + 10)
                    borderTop:SetTexture("Interface\\Buttons\\WHITE8X8")
                    borderTop:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)

                    -- Bottom border
                    local borderBottom = iconFrame:CreateTexture(nil, "OVERLAY")
                    borderBottom:SetSize(196, borderThickness)
                    borderBottom:SetPoint("BOTTOM", icon, "BOTTOM", 0, -(borderThickness/2 + 10))
                    borderBottom:SetTexture("Interface\\Buttons\\WHITE8X8")
                    borderBottom:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)

                    -- Left border
                    local borderLeft = iconFrame:CreateTexture(nil, "OVERLAY")
                    borderLeft:SetSize(borderThickness, 196)
                    borderLeft:SetPoint("LEFT", icon, "LEFT", -(borderThickness/2 + 10), 0)
                    borderLeft:SetTexture("Interface\\Buttons\\WHITE8X8")
                    borderLeft:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)

                    -- Right border
                    local borderRight = iconFrame:CreateTexture(nil, "OVERLAY")
                    borderRight:SetSize(borderThickness, 196)
                    borderRight:SetPoint("RIGHT", icon, "RIGHT", borderThickness/2 + 10, 0)
                    borderRight:SetTexture("Interface\\Buttons\\WHITE8X8")
                    borderRight:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)

                    -- Layer 7: Corner accents
                    local function createCornerAccent(point, xOff, yOff)
                        local accent = iconFrame:CreateTexture(nil, "OVERLAY")
                        accent:SetSize(40, 40)
                        accent:SetPoint(point, icon, point, xOff, yOff)
                        accent:SetTexture("Interface\\GLUES\\MODELS\\UI_Draenei\\GenericGlow64")
                        accent:SetVertexColor(schoolColor.r, schoolColor.g, schoolColor.b, 0.8)
                        accent:SetBlendMode("ADD")
                        accent:SetDrawLayer("OVERLAY", 5)
                        return accent
                    end

                    local topLeftAccent = createCornerAccent("TOPLEFT", -15, 15)
                    local topRightAccent = createCornerAccent("TOPRIGHT", 15, 15)
                    local bottomLeftAccent = createCornerAccent("BOTTOMLEFT", -15, -15)
                    local bottomRightAccent = createCornerAccent("BOTTOMRIGHT", 15, -15)

                    -- Layer 8: School name badge
                    local schoolBadge = iconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
                    schoolBadge:SetPoint("TOP", iconFrame, "TOP", 0, 30)
                    schoolBadge:SetText(schoolColor.name)
                    schoolBadge:SetTextColor(schoolColor.r, schoolColor.g, schoolColor.b, 1)
                    schoolBadge:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")

                    -- Pulsing animation for all glows
                    local animationTime = 0
                    iconFrame:SetScript("OnUpdate", function(self, elapsed)
                        animationTime = animationTime + elapsed
                        local pulse = 0.5 + math.abs(math.sin(animationTime * 1.5)) * 0.5

                        -- Pulse the glows
                        outerGlow:SetAlpha(pulse * 0.3)
                        middleGlow:SetAlpha(pulse * 0.5)
                        innerGlow:SetAlpha(pulse * 0.7)

                        -- Pulse the corner accents
                        local accentPulse = 0.4 + math.abs(math.sin(animationTime * 2)) * 0.4
                        topLeftAccent:SetAlpha(accentPulse)
                        topRightAccent:SetAlpha(accentPulse)
                        bottomLeftAccent:SetAlpha(accentPulse)
                        bottomRightAccent:SetAlpha(accentPulse)
                    end)

                    -- Store reference for cleanup
                    model.iconFrame = iconFrame

                    if GMConfig.config.debug then
                        GMUtils.debug("Spell fallback: Using enhanced icon display for", entity.spellName or entity.spellID)
                    end
                else
                    -- Last resort: generic spell model
                    model:SetModel("World\\Generic\\activedoodads\\spellportals\\mageportal_dalaran.mdx")
                end
            end
        end,
        SpellVisual = function()
            if entity.FilePath and entity.FilePath ~= "" then
                local success = pcall(function()
                    model:SetModel(entity.FilePath)
                end)
                if not success then
                    -- Try as spell visual kit ID
                    pcall(function()
                        model:SetSpellVisualKit(entity.entry)
                    end)
                end
            else
                -- Try using entry as spell visual kit ID
                pcall(function()
                    model:SetSpellVisualKit(entity.entry)
                end)
            end
        end,
        Item = function()
            -- Get detailed item information
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, 
                  itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(entity.entry)
            
            -- Debug logging
            if GMConfig.config.debug then
                GMUtils.debug("Item magnifier:", 
                    "itemID=" .. tostring(entity.entry),
                    "name=" .. tostring(itemName),
                    "equipLoc=" .. tostring(itemEquipLoc),
                    "type=" .. tostring(itemType))
            end
            
            local displaySuccess = false
            
            -- Check if item is equippable
            if itemEquipLoc and itemEquipLoc ~= "" and itemEquipLoc ~= "INVTYPE_BAG" then
                -- Equippable item - use character model
                model:SetUnit("player")
                model:Undress()
                
                -- Get race/gender for positioning
                local race, isFemale = getPlayerRaceGender()
                local positioning = RACE_POSITIONING[race] and RACE_POSITIONING[race][isFemale] or DEFAULT_POSITIONING[isFemale]
                
                -- Apply race-specific positioning
                model:SetSize(positioning.width, positioning.height)
                model:SetPoint(positioning.point, positioning.x, positioning.y)
                
                -- Apply slot-specific rotation (like transmogrification)
                local rotationConfig = {
                    INVTYPE_CLOAK = 10,      -- Show cloak from behind
                    INVTYPE_WEAPON = 1,      -- Slight angle for weapons
                    INVTYPE_WEAPONMAINHAND = 1,
                    INVTYPE_WEAPONOFFHAND = 1, 
                    INVTYPE_2HWEAPON = 1,
                    INVTYPE_RANGED = 1,
                    INVTYPE_SHIELD = 1,
                    INVTYPE_HOLDABLE = 1,
                }
                
                local rotation = rotationConfig[itemEquipLoc] or 0
                model:SetRotation(rotation, false)
                
                -- Simple scale for better visibility
                model:SetModelScale(1.0)
                
                -- Try to equip the item
                displaySuccess = pcall(function()
                    model:TryOn(entity.entry)
                end)
                
                -- Additional positioning for weapons is handled by rotation above
                -- No need for SetPosition or SetFacing adjustments
            else
                -- Non-equippable item or special handling needed
                
                -- First, try to use item's displayID if available
                if entity.displayid and entity.displayid > 0 then
                    displaySuccess = pcall(function()
                        -- Try to load the display model
                        local displayInfo = "Item\\ObjectComponents\\Weapon\\" .. entity.displayid .. ".mdx"
                        model:SetModel(displayInfo)
                    end)
                    
                    if not displaySuccess then
                        -- Try alternate path
                        displaySuccess = pcall(function()
                            model:SetDisplayInfo(entity.displayid)
                        end)
                    end
                end
                
                -- If display model failed, show icon with effects
                if not displaySuccess and itemTexture then
                    -- Create a pedestal or container model
                    local pedestalModel = "World\\Generic\\goblin\\go_goblin_treasure_chest_01.mdx"
                    local success = pcall(function()
                        model:SetModel(pedestalModel)
                    end)
                    
                    if not success then
                        -- Fallback to simple box
                        model:SetModel("World\\Generic\\human\\passive doodads\\genericdoodads\\g_cube_01.mdx")
                    end
                    
                    model:SetModelScale(0.5)
                    model:SetPosition(0, 0, -0.5)
                    
                    -- Add item icon as texture overlay
                    local iconFrame = CreateFrame("Frame", nil, model:GetParent())
                    iconFrame:SetSize(128, 128)
                    iconFrame:SetPoint("CENTER", model, "CENTER", 0, 50)
                    iconFrame:SetFrameLevel(model:GetFrameLevel() + 5)
                    
                    -- Icon background
                    local iconBg = iconFrame:CreateTexture(nil, "BACKGROUND")
                    iconBg:SetAllPoints()
                    iconBg:SetTexture("Interface\\Buttons\\UI-EmptySlot")
                    iconBg:SetDesaturated(true)
                    
                    -- Item icon
                    local icon = iconFrame:CreateTexture(nil, "ARTWORK")
                    icon:SetSize(120, 120)
                    icon:SetPoint("CENTER")
                    icon:SetTexture(itemTexture)
                    
                    -- Quality border
                    if itemRarity and itemRarity > 1 then
                        local qualityR, qualityG, qualityB = GetItemQualityColor(itemRarity)
                        local border = iconFrame:CreateTexture(nil, "OVERLAY")
                        border:SetSize(140, 140)
                        border:SetPoint("CENTER")
                        border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
                        border:SetVertexColor(qualityR, qualityG, qualityB)
                        border:SetBlendMode("ADD")
                        
                        -- Add glow effect for rare+ items
                        if itemRarity >= 3 then
                            local glow = iconFrame:CreateTexture(nil, "BACKGROUND")
                            glow:SetSize(180, 180)
                            glow:SetPoint("CENTER")
                            glow:SetTexture("Interface\\Cooldown\\starburst")
                            glow:SetVertexColor(qualityR, qualityG, qualityB, 0.3)
                            glow:SetBlendMode("ADD")
                        end
                    end
                    
                    -- Store reference for cleanup
                    model.iconFrame = iconFrame
                    displaySuccess = true
                end
            end
            
            -- Final fallback
            if not displaySuccess then
                model:SetModel("World\\Generic\\human\\passive doodads\\genericdoodads\\g_cube_01.mdx")
                model:SetModelScale(1.0)
            end
            
            -- Add rotation animation for all items
            model:SetRotation(0)
            local rotationSpeed = 0.5 -- radians per second
            model:SetScript("OnUpdate", function(self, elapsed)
                if self:IsVisible() then
                    local currentRotation = self:GetFacing() or 0
                    self:SetFacing(currentRotation + (elapsed * rotationSpeed))
                end
            end)
        end,
    }

    -- Define RestoreModelData function
    RestoreModelData = function()
        if model.entityData and model.entityType and modelSetters[model.entityType] then
            model:ClearModel()
            modelSetters[model.entityType]()
            model:SetRotation(math.rad(30))
        end
    end
    
    if modelSetters[type] then
        modelSetters[type]()
    else
        -- Unknown type, try generic model
        model:SetModel("World\\Generic\\human\\passive doodads\\genericdoodads\\g_cube_01.mdx")
    end

    -- Set initial rotation for better default view
    model:SetRotation(0, false)
    GMModels.setupModelInteraction(model)
    
    -- Add OnShow handler to restore model when shown
    model:SetScript("OnShow", RestoreModelData)
    
    -- Add debug info in tooltip
    model:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Model Viewer", 1, 1, 1)
        GameTooltip:AddLine("Type: " .. (type or "Unknown"), 0.7, 0.7, 0.7)
        if entity then
            if entity.entry then GameTooltip:AddLine("Entry: " .. entity.entry, 0.7, 0.7, 0.7) end
            if entity.spellID then GameTooltip:AddLine("Spell ID: " .. entity.spellID, 0.7, 0.7, 0.7) end
            if entity.name or entity.spellName then GameTooltip:AddLine("Name: " .. (entity.name or entity.spellName), 0.7, 0.7, 0.7) end
            if entity.visualID then GameTooltip:AddLine("Visual ID: " .. entity.visualID, 0.7, 0.7, 0.7) end
            if entity.visualID2 then GameTooltip:AddLine("Visual ID2: " .. entity.visualID2, 0.7, 0.7, 0.7) end
            if entity.FilePath then GameTooltip:AddLine("Path: " .. entity.FilePath, 0.7, 0.7, 0.7) end
        end
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Controls:", 1, 0.82, 0)
        GameTooltip:AddLine("Left-click drag: Rotate model", 0.8, 0.8, 0.8)
        GameTooltip:AddLine("Right-click drag: Pan model", 0.8, 0.8, 0.8)
        GameTooltip:AddLine("Mouse wheel: Zoom in/out", 0.8, 0.8, 0.8)
        GameTooltip:AddLine("Middle-click drag: Alternative zoom", 0.8, 0.8, 0.8)
        GameTooltip:AddLine("Double-click: Reset view", 0.8, 0.8, 0.8)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Modifiers:", 1, 0.82, 0)
        GameTooltip:AddLine("Shift + Left drag: Vertical rotation", 0.6, 0.6, 0.6)
        GameTooltip:AddLine("Shift + Right drag: Move up/down", 0.6, 0.6, 0.6)
        GameTooltip:AddLine("Shift + Mouse wheel: Fast zoom", 0.6, 0.6, 0.6)
        GameTooltip:Show()
    end)
    
    model:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    return model
end


-- Make resetModelState available globally
GMModels.resetModelState = resetModelState

-- Store ModelManager functions in GMData
GMData.models = GMData.models or {}
GMData.models.ModelManager = {
    acquireModel = GMModels.acquireModel,
    releaseModel = GMModels.releaseModel,
    resetModelState = resetModelState,
}

GMUtils.debug("Models module loaded")