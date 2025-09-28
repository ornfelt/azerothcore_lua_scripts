local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY TOASTS MODULE
-- ===================================
-- Toast notification system

-- Toast notification stack managers for different anchor points
local ToastManagers = {}

-- Toast manager prototype with shared methods
local ToastManagerMethods = {}

-- Create a toast manager for a specific anchor
local function GetOrCreateToastManager(anchor)
    anchor = anchor or "TOP"
    
    if not ToastManagers[anchor] then
        local anchorX, anchorY = 0, -20
        
        -- Set default positions for each anchor
        if anchor == "BOTTOM" then
            anchorY = -20
        elseif anchor == "TOPRIGHT" then
            anchorX = -50
            anchorY = -20
        elseif anchor == "BOTTOMRIGHT" then
            anchorX = -50
            anchorY = -20
        elseif anchor == "TOPLEFT" then
            anchorX = 50
            anchorY = -20
        elseif anchor == "BOTTOMLEFT" then
            anchorX = 50
            anchorY = -20
        end
        
        local manager = {
            activeToasts = {},
            toastSpacing = 5,
            toastHeight = 40,
            anchorPoint = anchor,
            anchorX = anchorX,
            anchorY = anchorY,
            maxToasts = 5
        }
        
        -- Set metatable to inherit methods
        setmetatable(manager, { __index = ToastManagerMethods })
        
        ToastManagers[anchor] = manager
    end
    
    return ToastManagers[anchor]
end

-- Default manager for backward compatibility
local ToastManager = GetOrCreateToastManager("TOP")

-- Update positions of all active toasts
function ToastManagerMethods:UpdatePositions()
    local yOffset = self.anchorY
    
    for i, toastData in ipairs(self.activeToasts) do
        local toast = toastData.frame
        local targetY
        
        -- Stack direction based on anchor
        if self.anchorPoint:find("BOTTOM") then
            -- Stack upward for bottom anchors
            targetY = yOffset + (i - 1) * (toast:GetHeight() + self.toastSpacing)
        else
            -- Stack downward for top anchors
            targetY = yOffset - (i - 1) * (toast:GetHeight() + self.toastSpacing)
        end
        
        -- Animate to new position using OnUpdate
        if not toast.moveElapsed then
            toast.moveElapsed = 0
            toast.startY = select(5, toast:GetPoint())
            toast.targetY = targetY
        else
            toast.targetY = targetY
        end
        
        -- Start or update movement animation
        toast:SetScript("OnUpdate", function(self, delta)
            -- Handle both fade and movement animations
            if self.fadeElapsed then
                self.fadeElapsed = self.fadeElapsed + delta
                
                local fadeInDuration = 0.2
                local displayDuration = toastData.duration
                local fadeOutDuration = toastData.fadeTime
                local totalDuration = fadeInDuration + displayDuration + fadeOutDuration
                
                if self.fadeElapsed < fadeInDuration then
                    self:SetAlpha(self.fadeElapsed / fadeInDuration)
                elseif self.fadeElapsed < fadeInDuration + displayDuration then
                    self:SetAlpha(1)
                elseif self.fadeElapsed < totalDuration then
                    local fadeOutProgress = (self.fadeElapsed - fadeInDuration - displayDuration) / fadeOutDuration
                    self:SetAlpha(1 - fadeOutProgress)
                else
                    self:SetScript("OnUpdate", nil)
                    self:Hide()
                    -- Find and remove from the correct manager
                    for anchor, mgr in pairs(ToastManagers) do
                        for _, toastData in ipairs(mgr.activeToasts) do
                            if toastData.frame == self then
                                mgr:RemoveToast(self)
                                return
                            end
                        end
                    end
                    return
                end
            end
            
            -- Handle movement animation
            if self.moveElapsed and self.targetY and self.startY then
                self.moveElapsed = self.moveElapsed + delta
                local moveDuration = 0.2
                
                if self.moveElapsed < moveDuration then
                    local progress = self.moveElapsed / moveDuration
                    -- Smooth easing
                    progress = progress * progress * (3 - 2 * progress)
                    local currentY = self.startY + (self.targetY - self.startY) * progress
                    self:SetPoint(ToastManager.anchorPoint, UIParent, ToastManager.anchorPoint, ToastManager.anchorX, currentY)
                else
                    self:SetPoint(ToastManager.anchorPoint, UIParent, ToastManager.anchorPoint, ToastManager.anchorX, self.targetY)
                    self.moveElapsed = nil
                    self.startY = nil
                    self.targetY = nil
                end
            end
        end)
    end
end

-- Add a new toast to the stack
function ToastManagerMethods:AddToast(frame, duration, fadeTime)
    -- Remove oldest toast if at max capacity
    if #self.activeToasts >= self.maxToasts then
        local oldestToast = self.activeToasts[1].frame
        oldestToast:Hide()
        self:RemoveToast(oldestToast)
    end
    
    -- Add new toast
    table.insert(self.activeToasts, {
        frame = frame,
        duration = duration,
        fadeTime = fadeTime
    })
    
    -- Update all positions
    self:UpdatePositions()
end

-- Remove a toast from the stack
function ToastManagerMethods:RemoveToast(frame)
    for i, toastData in ipairs(self.activeToasts) do
        if toastData.frame == frame then
            table.remove(self.activeToasts, i)
            self:UpdatePositions()
            break
        end
    end
end

-- Set anchor point for toasts
function ToastManagerMethods:SetAnchor(point, x, y)
    self.anchorPoint = point or "TOP"
    self.anchorX = x or 0
    self.anchorY = y or -20
    self:UpdatePositions()
end

--[[
Creates a toast notification that appears and fades out
@param text - Notification text
@param duration - How long to show (defaults to 3 seconds)
@param fadeTime - Fade out duration (defaults to 0.5 seconds)
@param anchor - Where to show the toast (defaults to top center)
@return Toast frame
]]
function CreateStyledToast(text, duration, fadeTime, anchor)
    duration = duration or 3
    fadeTime = fadeTime or 0.5
    anchor = anchor or "TOP"
    
    -- Get the appropriate toast manager for this anchor
    local manager = GetOrCreateToastManager(anchor)
    
    -- Create toast frame uniformly for all anchors
    local toast = CreateFrame("Frame", nil, UIParent)
    toast:SetFrameStrata("TOOLTIP")
    toast:SetFrameLevel(200)
    toast:SetToplevel(true)  -- Ensure it stays on top
    
    -- Set backdrop directly to avoid any parent frame issues
    toast:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    toast:SetBackdropColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 1)
    toast:SetBackdropBorderColor(0, 0, 0, 1)
    
    -- Ensure the frame doesn't expand beyond its content
    toast:SetClampedToScreen(true)
    
    -- Text
    local message = toast:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    message:SetPoint("CENTER", 0, 0)
    message:SetText(text)
    message:SetTextColor(1, 1, 1, 1)
    
    -- Auto-size
    local padding = 20
    toast:SetWidth(message:GetStringWidth() + padding * 2)
    toast:SetHeight(message:GetStringHeight() + padding)
    
    -- Set initial position from the manager
    toast:SetPoint(manager.anchorPoint, UIParent, manager.anchorPoint, manager.anchorX, manager.anchorY)
    toast:SetAlpha(0)
    toast:Show()
    
    -- Initialize animation values and add to manager
    toast.fadeElapsed = 0
    manager:AddToast(toast, duration, fadeTime)
    
    return toast
end

--[[
Configure toast notification settings
@param settings - Table with optional fields: maxToasts, spacing, anchorPoint, anchorX, anchorY
]]
function ConfigureToasts(settings)
    if not settings then return end
    
    if settings.maxToasts then
        ToastManager.maxToasts = settings.maxToasts
    end
    if settings.spacing then
        ToastManager.toastSpacing = settings.spacing
    end
    if settings.anchorPoint or settings.anchorX or settings.anchorY then
        ToastManager:SetAnchor(settings.anchorPoint, settings.anchorX, settings.anchorY)
    end
end

--[[
Clear all active toast notifications
]]
function ClearAllToasts()
    -- Clear toasts from all managers
    for anchor, manager in pairs(ToastManagers) do
        for i = #manager.activeToasts, 1, -1 do
            local toast = manager.activeToasts[i].frame
            toast:SetScript("OnUpdate", nil)
            toast:Hide()
        end
        manager.activeToasts = {}
    end
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Toasts"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Toasts module loaded")
end