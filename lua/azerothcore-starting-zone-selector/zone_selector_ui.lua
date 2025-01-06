local AIO = AIO or require("AIO")

-- Ensure this script runs only on the client
if AIO.AddAddon() then return end

-- Register the ShowUI function to respond to the server's "ShowUI" command
AIO.AddHandlers("ZoneSelector", {
    ShowUI = function(player, zones)
        ZoneSelector_ShowUI(zones)
    end
})

-- Persistent frame
local frame

function ZoneSelector_ShowUI(zones)
    if not frame then
        frame = CreateFrame("Frame", "ZoneSelectorFrame", UIParent)
        frame:SetPoint("CENTER")
        
        -- Add a darkened background texture
        frame:SetBackdrop({
            bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark", -- Background texture
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",        -- Border texture
            tile = true, tileSize = 32, edgeSize = 32,                     -- Tile and edge size
            insets = { left = 8, right = 8, top = 8, bottom = 8 },         -- Insets for padding
        })
        
        -- frame:SetBackdropColor(0, 0, 0, 1) -- Solid black background, fully opaque

        frame:SetFrameStrata("FULLSCREEN_DIALOG")
        frame:SetFrameLevel(100)

        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")

        frame:SetScript("OnDragStart", frame.StartMoving)
        frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

        -- Add the frame to UISpecialFrames for ESC behavior
        tinsert(UISpecialFrames, frame:GetName())

        -- Close button
        local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
        closeButton:SetScript("OnClick", function()
            frame:Hide()
        end)

        -- Custom font for Title
        local titleFont = CreateFont("TitleFont")
        titleFont:SetFont("Interface/Fonts/friz-quadrata-regular.ttf", 28, "OUTLINE")
        titleFont:SetShadowOffset(1, -1)
        titleFont:SetShadowColor(0, 0, 0, 0.5)

        -- Title
        local title = frame:CreateFontString(nil, "OVERLAY")
        title:SetPoint("TOP", 0, -30)
        title:SetFontObject(titleFont)
        title:SetText("Embark on your Journey")
        title:SetTextColor(209 / 255, 163 / 255, 14 / 255)

        -- Store buttons for reuse
        frame.buttons = {}
        frame.title = title
    end

    -- Remove old buttons if they exist
    for _, button in ipairs(frame.buttons) do
        button:Hide()
    end

    -- Custom font for button labels
    local buttonLabelFont = CreateFont("ButtonLabelFont")
    buttonLabelFont:SetFont("Interface/Fonts/friz-quadrata-regular.ttf", 14)

    -- Layout settings
    local buttonWidth = 300
    local buttonHeight = 150
    local horizontalSpacing = 30
    local verticalSpacing = 50
    local buttonsPerRow = math.min(#zones, 2)
    local totalRows = math.ceil(#zones / buttonsPerRow)

    -- Dynamically resize the frame
    local dynamicWidth = (buttonsPerRow * buttonWidth) + ((buttonsPerRow - 1) * horizontalSpacing) + 70
    local dynamicHeight = (totalRows * (buttonHeight + verticalSpacing)) + 90
    frame:SetSize(dynamicWidth, dynamicHeight)

    local buttonStartX = (dynamicWidth - (buttonWidth * buttonsPerRow + horizontalSpacing * (buttonsPerRow - 1))) / 2
    local buttonStartY = -80

    -- Create buttons
    for i, zone in ipairs(zones) do
        local row = math.floor((i - 1) / buttonsPerRow)
        local col = (i - 1) % buttonsPerRow

        local button = CreateFrame("Button", nil, frame)
        button:SetSize(buttonWidth, buttonHeight)
        button:SetPoint("TOPLEFT", buttonStartX + col * (buttonWidth + horizontalSpacing), buttonStartY - row * (buttonHeight + verticalSpacing))
        button:SetNormalTexture(zone.image)
        button:SetHighlightTexture(nil)

        -- Glow effect texture
        local glow = button:CreateTexture(nil, "OVERLAY")
        glow:SetSize(buttonWidth + 185, buttonHeight + 265)
        glow:SetPoint("CENTER", button, "CENTER", 62, -80)
        glow:SetTexture("Interface/Buttons/UI-Panel-Button-Glow")
        glow:SetBlendMode("ADD")
        glow:SetAlpha(0)
        button.glow = glow

        -- Border
        local border = CreateFrame("Frame", nil, button, BackdropTemplateMixin and "BackdropTemplate")
        border:SetPoint("TOPLEFT", -3, 3)
        border:SetPoint("BOTTOMRIGHT", 3, -3)
        border:SetBackdrop({
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 15,
        })

        -- Mouse hover effects
        button:SetScript("OnEnter", function(self)
            self.glow:SetAlpha(0.8)
        end)
        button:SetScript("OnLeave", function(self)
            self.glow:SetAlpha(0)
        end)
        button:SetScript("OnClick", function()
            AIO.Handle("ZoneSelector", "SelectZone", i)
            frame:Hide()
        end)

        -- Add label text
        local label = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        label:SetPoint("TOP", button, "BOTTOM", 0, -10)
        label:SetFontObject(buttonLabelFont)
        label:SetText(zone.name)
        label:SetTextColor(209 / 255, 163 / 255, 14 / 255)

        -- Store button for cleanup
        table.insert(frame.buttons, button)
    end

    frame:Show()
end