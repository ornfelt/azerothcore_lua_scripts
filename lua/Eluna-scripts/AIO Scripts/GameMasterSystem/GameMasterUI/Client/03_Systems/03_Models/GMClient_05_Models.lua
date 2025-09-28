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
    },
    TEXTURES = {
        BACKDROP = "Interface\\DialogFrame\\UI-DialogBox-Background",
        BORDER = "Interface\\Tooltips\\UI-Tooltip-Border",
    },
    SIZES = {
        ICON = 16,
        FULL_VIEW = 400,
        FULL_VIEW_HEIGHT = 430,  -- Extra height for title bar
        TITLE_BAR_HEIGHT = 30,
        TILE = 16,
        INSETS = 5,
    },
}

-- Initialize model pool
local modelFrameCache = {}
local initializedPool = false

-- Utility: Clamp helper (WoW 3.3.5 doesn't have math.clamp)
local function Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

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

    -- Mouse down handler
    model:SetScript("OnMouseDown", function(self, button)
        local currentTime = GetTime()
        
        -- Check for double-click
        if button == state.lastClickButton and (currentTime - state.lastClickTime) < MODEL_CONFIG.CONTROLS.DOUBLE_CLICK_TIME then
            -- Double-click detected - reset view
            resetModelState(self, state)
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
        end
    end)

    -- Mouse up handler
    model:SetScript("OnMouseUp", function(_, button)
        state.dragMode = nil
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
    
    -- Title text centered to avoid covering UI elements
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER", titleBar, "CENTER", 0, 0)
    title:SetText("Model Viewer")
    title:SetTextColor(1, 1, 1, 1)
    
    -- Make only title bar draggable
    titleBar:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)
    titleBar:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
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
                model.iconFrame:SetParent(nil)
                model.iconFrame = nil
            end
            -- Stop any OnUpdate scripts
            model:SetScript("OnUpdate", nil)
            -- Clear model
            model:ClearModel()
        end
    end)
    
    return frame
end

-- Create model view
function GMModels.createModelView(parent, entity, type, index)
    local model = CreateFrame("DressUpModel", "FullModel" .. index, parent)
    -- Position model below title bar
    model:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -30)
    model:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0)
    model:SetFrameStrata("DIALOG")
    model:SetFrameLevel(parent:GetFrameLevel() + 1)
    model:EnableMouse(true)
    model:SetMovable(false)  -- Model itself should not be movable
    model:ClearModel()

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
            -- Debug logging
            if GMConfig.config.debug then
                GMUtils.debug("Spell magnifier:", 
                    "spellID=" .. tostring(entity.spellID),
                    "visualID=" .. tostring(entity.visualID),
                    "visualID2=" .. tostring(entity.visualID2),
                    "name=" .. tostring(entity.spellName))
            end
            
            -- Try to show spell visual if available
            local visualSuccess = false
            
            -- First try primary visual ID
            if entity.visualID and entity.visualID > 0 then
                visualSuccess = pcall(function()
                    model:SetSpellVisualKit(entity.visualID)
                end)
            end
            
            -- If primary failed, try secondary visual ID
            if not visualSuccess and entity.visualID2 and entity.visualID2 > 0 then
                visualSuccess = pcall(function()
                    model:SetSpellVisualKit(entity.visualID2)
                end)
            end
            
            -- If visuals failed, try spell ID directly (some spells work this way)
            if not visualSuccess and entity.spellID then
                visualSuccess = pcall(function()
                    model:SetSpellVisualKit(entity.spellID)
                end)
            end
            
            -- Ultimate fallback: show spell icon
            if not visualSuccess then
                -- Try to get spell icon
                local spellName, _, spellIcon = GetSpellInfo(entity.spellID)
                if spellIcon then
                    -- Create a simple model with the spell icon
                    model:SetModel("Interface\\Buttons\\TalkToMeQuestion.mdx")
                    model:SetModelScale(2.0)
                    
                    -- Add spell icon as texture overlay
                    local iconTexture = model:CreateTexture(nil, "OVERLAY")
                    iconTexture:SetSize(128, 128)
                    iconTexture:SetPoint("CENTER")
                    iconTexture:SetTexture(spellIcon)
                    
                    -- Add glow effect
                    local glowTexture = model:CreateTexture(nil, "BACKGROUND")
                    glowTexture:SetSize(160, 160)
                    glowTexture:SetPoint("CENTER")
                    glowTexture:SetTexture("Interface\\Cooldown\\star4")
                    glowTexture:SetVertexColor(0.5, 0.5, 1, 0.3)
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
                
                -- Set appropriate camera distance based on slot
                local cameraDistances = {
                    INVTYPE_HEAD = 0.8,
                    INVTYPE_NECK = 0.8,
                    INVTYPE_SHOULDER = 1.0,
                    INVTYPE_CHEST = 1.2,
                    INVTYPE_ROBE = 1.5,
                    INVTYPE_WAIST = 1.2,
                    INVTYPE_LEGS = 1.5,
                    INVTYPE_FEET = 1.8,
                    INVTYPE_WRIST = 1.0,
                    INVTYPE_HAND = 1.0,
                    INVTYPE_FINGER = 0.6,
                    INVTYPE_TRINKET = 0.8,
                    INVTYPE_CLOAK = 1.5,
                    INVTYPE_WEAPON = 1.2,
                    INVTYPE_WEAPONMAINHAND = 1.2,
                    INVTYPE_WEAPONOFFHAND = 1.2,
                    INVTYPE_2HWEAPON = 1.5,
                    INVTYPE_RANGED = 1.5,
                    INVTYPE_SHIELD = 1.2,
                    INVTYPE_HOLDABLE = 1.0,
                }
                
                local distance = cameraDistances[itemEquipLoc] or 1.0
                model:SetCamera(0)
                model:SetModelScale(distance)
                
                -- Try to equip the item
                displaySuccess = pcall(function()
                    model:TryOn(entity.entry)
                end)
                
                -- For weapons, adjust positioning
                if itemEquipLoc:find("WEAPON") or itemEquipLoc == "INVTYPE_RANGED" then
                    model:SetPosition(0, 0, -0.3)
                    -- Add a slight rotation to show weapon better
                    model:SetFacing(math.rad(-30))
                end
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

    if modelSetters[type] then
        modelSetters[type]()
    else
        -- Unknown type, try generic model
        model:SetModel("World\\Generic\\human\\passive doodads\\genericdoodads\\g_cube_01.mdx")
    end

    model:SetRotation(math.rad(30))
    GMModels.setupModelInteraction(model)
    
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