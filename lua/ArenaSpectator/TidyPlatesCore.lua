TidyPlates = {}
local activetheme, activethemename = {}, "None"
local numChildren = -1
local echoUpdate = 0
local echoSelf = {}
local function SetSelfEcho(plate) if plate:IsShown() then echoSelf[plate] = true; end end
local function SetEchoUpdate(echos) echoUpdate = max(echoUpdate,echos) end
SetCVar("threatWarning", 3)
local ForEachPlate        -- Function
local EMPTY_TEXTURE = "Interface\\Addons\\ArenaSpectator\\Media\\Empty"
local useAutohide = false
local select, pairs, tostring = select, pairs, tostring
local select = select
local InCombat, HasTarget = false, false
local Plates, PlatesVisible = {}, {}
local players = {}
SIZENAMEPLATES = { ["WIDTH"] = 100, ["HEIGHT"] = 16, ["TEXTSIZE"] = 8 }

-------------------------------------------------------
-- Object Functions
-------------------------------------------------------
local function IsPlayerGUID(guid)
    return tonumber(guid:sub(5,5)) == 0
end

local function GetPlayerTeamByName(value)
    temp = ATPlayers
    for _, p in pairs(temp) do
        if p.name == value and IsPlayerGUID(p.guid) then
            return p.team
        end
    end
    
    return false
end

local function SetObjectShape(object, width, height) object:SetWidth(width); object:SetHeight(height) end
local function SetObjectFont(object,  font, size, flags) object:SetFont(font, size, flags) end
local function SetObjectJustify(object, horz, vert) object:SetJustifyH(horz); object:SetJustifyV(vert) end
local function SetObjectShadow(object, shadow) if shadow then object:SetShadowColor(0,0,0,1); object:SetShadowOffset(1, -1) else object:SetShadowColor(0,0,0,0) end  end
local function SetObjectAnchor(object, anchor, anchorTo, x, y) object:ClearAllPoints();object:SetPoint(anchor, anchorTo, anchor, x, y) end
local function SetObjectTexture(object, texture) object:SetTexture(texture); object:SetTexCoord(0,1,0,1)  end
local function SetObjectBartexture(object, texture, orientation) object:SetStatusBarTexture(texture); object:SetOrientation(orientation) end
-- SetFontGroupObject
local function SetFontGroupObject(object, objectstyle) 
    SetObjectFont(object, objectstyle.typeface, objectstyle.size, objectstyle.flags) 
    SetObjectJustify(object, objectstyle.align, objectstyle.vertical)
    SetObjectShadow(object, objectstyle.shadow)
end
-- SetAnchorGroupObject
local function SetAnchorGroupObject(object, objectstyle, anchorTo)
    SetObjectShape(object, objectstyle.width, objectstyle.height) --end                
    SetObjectAnchor(object, objectstyle.anchor, anchorTo, objectstyle.x, objectstyle.y) 
end
-- SetBarGroupObject
local function SetBarGroupObject(object, objectstyle, anchorTo)
    SetObjectShape(object, objectstyle.width, objectstyle.height) --end
    SetObjectAnchor(object, objectstyle.anchor, anchorTo, objectstyle.x, objectstyle.y) --end    
    SetObjectBartexture(object, objectstyle.texture, objectstyle.orientation) --end
end
-------------------------------------------------------
-- UpdateStyle
-------------------------------------------------------
local UpdateStyle
do
    -- UpdateStyle Variables
    local index, content, extended, bars, visual, style
    local objectstyle, objectname, objectregion
    -- Style Property Groups
    local fontgroup = {"name", "level", "specialText", "specialText2"}
    local anchorgroup = {"healthborder", "threatborder", "castborder", "castnostop",
                        "name",  "specialText", "specialText2", "level",
                        "specialArt", "spellicon", "raidicon", "dangerskull"}
    local bargroup = {"castbar", "healthbar"}
    -------------------------------------------------------
    -- Main Function: UpdateStyle 
    -------------------------------------------------------
    function UpdateStyle(plate)
        extended = plate.extended
        bars, visual, style, unit = extended.bars, extended.visual, extended.style, extended.unit
        -- Hitbox
        if not InCombat then objectstyle = style.hitbox; SetObjectShape(plate, objectstyle.width, objectstyle.height) end
        -- Frame
        SetAnchorGroupObject(extended, style.frame, plate)
        -- Anchorgroup
        for i = 1, #anchorgroup do objectname = anchorgroup[i]; SetAnchorGroupObject(visual[objectname], style[objectname], extended) end
        -- Bars
        for i = 1, #bargroup do objectname = bargroup[i]; SetBarGroupObject(bars[objectname], style[objectname], extended) end
        -- Texture
        SetObjectTexture(visual.castborder, style.castborder.texture)
        SetObjectTexture(visual.castnostop, style.castnostop.texture)
        -- Font Group
        for i = 1, #fontgroup do objectname = fontgroup[i];SetFontGroupObject(visual[objectname], style[objectname]) end
        -- Show/Hide
        if style.options.showName then visual.name:Show() else visual.name:Hide() end
        if style.options.showSpecialText then visual.specialText:Show() else visual.specialText:Hide() end
        if style.options.showSpecialText2 then visual.specialText2:Show() else visual.specialText2:Hide() end
        if style.options.showSpecialArt then visual.specialArt:Show() else visual.specialArt:Hide() end
        if style.options.showSpellIcon then visual.spellicon:Show() else visual.spellicon:Hide()  end
        if style.options.showLevel and (not unit.isBoss) then visual.level:Show() else visual.level:Hide() end
        if unit.isBoss and style.options.showDangerSkull then visual.dangerskull:Show() else visual.dangerskull:Hide() end

    end
end
-------------------------------------------------------
-- UpdatePlateIndicators
-------------------------------------------------------
local UpdatePlateIndicators
do
    local color = {}
    local extended, unit, style, bars, visual, threatborder, alpha, forcealpha, scale
    -- SetIndicatorElite     -- Set Border and Aggro Glow Textures
    local function SetIndicatorElite()
        if unit.isElite then visual.healthborder:SetTexture( style.healthborder.elitetexture)
            threatborder:SetTexture(style.threatborder.elitetexture)
        else visual.healthborder:SetTexture( style.healthborder.texture)
            threatborder:SetTexture(style.threatborder.texture) end
    end
    -------------------------------------------------------
    -- UpdatePlateIndicators: Updates the nameplate information depending on unit conditions
    -------------------------------------------------------
    function UpdatePlateIndicators(plate)
        extended = plate.extended
        style, bars, visual, scale, regions = extended.style, extended.bars, extended.visual, extended.scale, extended.regions
        unit, unitcache = extended.unit, extended.unitcache
        threatborder = visual.threatborder
        visual.highlight:SetAlpha(0)
        -- Set Alpha, Scale, Elite, Aggro
        alpha = 1
        if activetheme.SetAlpha then 
            alpha, forcealpha = activetheme.SetAlpha(unit)
            if forcealpha then alpha = (alpha or 1) -- moved * (unit.alpha or 1)  to else
            else alpha = (alpha or 1) * (unit.alpha or 1) end
            extended:SetAlpha(alpha) 
            -- visual.highlight:SetAlpha(0)
        else extended:SetAlpha(unit.alpha or 1) end

        -- If plate is visible, handle indicators
        if alpha > 0 then
            -- visual.name:Hide()
            -- visual.level:Hide()

            if (not IsActiveBattlefieldArena()) then
                bars.healthbar:SetBackdrop(nil)
            else
                teamId = GetPlayerTeamByName(unit.name)
                if (teamId) then
                    bars.healthbar:SetBackdrop({
                        bgFile = "", 
                        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
                        tile = true,
                        tileSize = 1,
                        edgeSize = 1
                    })
                    
                    if (teamId == 67) then
                        bars.healthbar:SetBackdropBorderColor(1.0, 0.0, 0.0, 1.0)
                    else
                        bars.healthbar:SetBackdropBorderColor(0.0, 0.5, 1.0, 1.0)
                    end
                end
            end
            visual.name:SetText(unit.name)
            visual.level:SetText(unit.level)
            local tr, tg, tb = regions.level:GetTextColor()
            visual.level:SetTextColor(tr, tg, tb)
            -- Scale
            if activetheme.SetScale then scale = activetheme.SetScale(unit); if scale then extended:SetScale( scale )end; end
            -- Elite Graphics
            if (unit.isElite == nil ) or unit.isElite ~= unitcache.isElite then SetIndicatorElite() end
            -- Set Aggro Region
            if  style.options.showAggroGlow and InCombat and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
                color = style.threatcolor[unit.threatSituation]
                threatborder:Show()
                threatborder:SetVertexColor(color.r, color.g, color.b, color.a)
            else threatborder:Hide() end
            -- Set Special-Case Regions
            if style.options.showSpecialText and activetheme.SetSpecialText then
                visual.specialText:SetText(activetheme.SetSpecialText(unit)) end
            if style.options.showSpecialText2 and activetheme.SetSpecialText2 then
                visual.specialText2:SetText(activetheme.SetSpecialText2(unit)) end
            if style.options.showSpecialArt and activetheme.SetSpecialArt then
                visual.specialArt:SetTexture(activetheme.SetSpecialArt(unit)) end
            -- Set Health Bar
            if classes[unit.name] ~= nil then
                local class = classes[unit.name]
                local c = RAID_CLASS_COLORS[class]
                bars.healthbar:SetStatusBarColor(c.r, c.g, c.b)
                -- print(c.r .. ", " .. c.g .. ", " .. c.b)
            elseif players[unit.name] ~= nil then
                local class = players[unit.name]
                local c = RAID_CLASS_COLORS[class]
                bars.healthbar:SetStatusBarColor(c.r, c.g, c.b)
            elseif unit.guid then
                local _, class = GetPlayerInfoByGUID(unit.guid)
                if class then
                    players[unit.name] = class
                    local c = RAID_CLASS_COLORS[class]
                    bars.healthbar:SetStatusBarColor(c.r, c.g, c.b)
                end
            else bars.healthbar:SetStatusBarColor(bars.health:GetStatusBarColor()) end    
            
            bars.healthbar:SetMinMaxValues(bars.health:GetMinMaxValues())
            bars.healthbar:SetValue(bars.health:GetValue())
            local min, max = bars.health:GetMinMaxValues()
            bars.healthbar.hptext:SetText(math.ceil(bars.health:GetValue() / max * 100) .. "%")
            bars.healthbar.nametext:SetText(unit.name)
        end
    
    end
end
-------------------------------------------------------
-- Update Plate / Gather Data
-- Gathers Information about the unit, and requests updates, if needed
-------------------------------------------------------
local OnShowNameplate, OnHideNameplate, OnMouseoverNameplate, OnUpdateNameplate, OnStartCast, OnStopCast, OnUpdateCast
local UpdateReferences, UpdateUnitStatus, UpdateNameplateStyle
do
    local ClassReference = {}
    local _, stylename, unitchanged, extended, bars, regions, unit, unitcache, style, visual
    -- ColorToString: Converts a color to a string with a C- prefix
    local function ColorToString(r,g,b) return "C"..math.floor((100*r) + 0.5)..math.floor((100*g) + 0.5)..math.floor((100*b) + 0.5) end
    -- GetUnitCombatStatus: Determines if a unit is in combat by checking the name text color
    local function GetUnitCombatStatus(r, g, b) return (r > .5 and g < .5) end
    -- GetUnitAggroStatus: Determines if a unit is attacking, by looking at aggro glow region
    local GetUnitAggroStatus
    do
        local shown 
        local red, green, blue
        function GetUnitAggroStatus( region)
            shown = region:IsShown()
            if not shown then return "LOW" end
            red, green, blue = region:GetVertexColor()
            if green > .7 then return "MEDIUM" end
            if red > .7 then return "HIGH" end
        end
    end
    -- GetUnitReaction: Determines the reaction, and type of unit from the health bar color
    local function GetUnitReaction(red, green, blue)                                                                                                            
        if red < .01 and blue < .01 and green > .99 then return "FRIENDLY", "NPC" 
        elseif red < .01 and blue > .99 and green < .01 then return "FRIENDLY", "PLAYER"
        elseif red > .99 and blue < .01 and green > .99 then return "NEUTRAL", "NPC"
        elseif red > .99 and blue < .01 and green < .01 then return "HOSTILE", "NPC"
        else return "HOSTILE", "PLAYER" end
    end
    --
    local ux, uy
    local RaidIconCoordinate = { --from GetTexCoord. input is ULx and ULy (first 2 values).
        [0]        = { [0]        = "STAR", [0.25]    = "MOON", },
        [0.25]    = { [0]        = "CIRCLE", [0.25]    = "SQUARE",    },
        [0.5]    = { [0]        = "DIAMOND", [0.25]    = "CROSS", },
        [0.75]    = { [0]        = "TRIANGLE", [0.25]    = "SKULL", }, }
    -- Populates the class color lookup table
    for classname, color in pairs(RAID_CLASS_COLORS) do 
        ClassReference[ColorToString(color.r, color.g, color.b)] = classname end
    -- UpdateUnitStatic: Updates Static Information
    local function UpdateUnitStatic()
        unit.name = regions.name:GetText()
        unit.isBoss = regions.dangerskull:IsShown()
        unit.isDangerous = unit.isBoss
        unit.isElite = regions.eliteicon:IsShown()
    end
    -- UpdateUnitStatus: Updates Unit Variables
    function UpdateUnitStatus()
        unit.level = regions.level:GetText() or 1
        unit.health = bars.health:GetValue() or 0
        _, unit.healthmax = bars.health:GetMinMaxValues()
        if InCombat then unit.threatSituation = GetUnitAggroStatus(regions.threatglow) else unit.threatSituation = "LOW" end
        unit.isMarked = regions.raidicon:IsShown()
        unit.isInCombat = GetUnitCombatStatus(regions.name:GetTextColor())
        unit.red, unit.green, unit.blue = bars.health:GetStatusBarColor()
        unit.levelcolorRed, levelcolorGreen, levelcolorBlue = regions.level:GetTextColor()
        unit.reaction, unit.type = GetUnitReaction(unit.red, unit.green, unit.blue)
        unit.class = ClassReference[ColorToString(unit.red, unit.green, unit.blue)] or "UNKNOWN"
        unit.InCombatLockdown = InCombat
        if regions.raidicon:IsShown() then 
            ux, uy = regions.raidicon:GetTexCoord()
            unit.raidIcon = RaidIconCoordinate[ux][uy]
        else unit.raidIcon = false end
    end
    -- UpdateNameplateStyle
    function UpdateNameplateStyle(plate, forceStyleUpdate)
        if activetheme.multiStyle then stylename = activetheme.SetStyle(unit); extended.style = activetheme[stylename]
        else extended.style = activetheme; stylename = tostring(activetheme) end
        if extended.stylename ~= stylename or forceStyleUpdate then UpdateStyle(plate); extended.stylename = stylename; end
        style = extended.style
    end
    -- UpdateUnitCache
    local function UpdateUnitCache() for key, value in pairs(unit) do unitcache[key] = value end end
    -- UpdateReferences
 function UpdateReferences(plate)
        unitchanged = false
        extended = plate.extended
        bars = extended.bars
        regions = extended.regions 
        unit = extended.unit
        unitcache = extended.unitcache
        visual = extended.visual
    end
    -- UpdateSpecialRegions
    local function UpdateSpecialRegions()    
        visual.highlight:SetTexture(style.healthborder.glowtexture)
        visual.highlight:SetAllPoints(visual.healthborder)
        visual.spellicon:SetAlpha(0)
    end
    -- OnShowNameplate
    OnShowNameplate = function(plate)
        PlatesVisible[plate] = true
    
        UpdateReferences(plate)
        UpdateUnitStatic()
        UpdateUnitStatus()
        --visual.highlight:SetAlpha(1)
        unit.isCasting = false
        bars.castbar:Hide()
        plate.alpha = plate:GetAlpha()
        unit.alpha = plate.alpha
        unit.isTarget = false
        visual.highlight:Hide()
        
        --UpdateNameplateStyle(plate, true)
        UpdateNameplateStyle(plate, false)
        UpdateSpecialRegions()
        if activetheme.OnInitialize then activetheme.OnInitialize(extended) end    
        UpdatePlateIndicators(plate)
        SetSelfEcho(plate)
    end
    -- OnHideNameplate
    OnHideNameplate = function(plate)
        UpdateReferences(plate)
        visual.highlight:Hide()
        bars.castbar:Hide()
        PlatesVisible[plate] = nil
        wipe(extended.unit)
        wipe(extended.unitcache)
        if unit.guid then Units[unit.guid] = nil end
    end
    -- OnMouseoverNameplate
    OnMouseoverNameplate = function(plate)
        UpdateReferences(plate)
        unit.isMouseover = regions.highlight:IsShown()
        if unit.isMouseover then unit.guid = UnitGUID("mouseover")end
        UpdatePlateIndicators(plate)
        if activetheme.OnUpdate then activetheme.OnUpdate(extended, unit) end
    end
    -- OnUpdateNameplate
    OnUpdateNameplate = function(plate)
        UpdateReferences(plate)
        UpdateUnitStatus()

        unit.alpha = plate.alpha -- Set in PlateHandler's OnUpdate
        unit.isTarget = HasTarget and unit.alpha == 1
        unit.isMouseover = regions.highlight:IsShown()
        if unit.isTarget then unit.guid = UnitGUID("target") end

        for key, value in pairs(unit) do if unitcache[key] ~= value then unitchanged = true end end
        if unitchanged then 
            UpdateNameplateStyle(plate)
            UpdatePlateIndicators(plate)
        end
        
        if unit.raidIcon then visual.raidicon:Show(); visual.raidicon:SetTexCoord(regions.raidicon:GetTexCoord()) 
        else visual.raidicon:Hide() end
        
        UpdateUnitCache()
        if activetheme.OnUpdate then activetheme.OnUpdate(extended, unit) end

    end

    -- OnStartCastNameplate, OnStopCastNameplate
    OnStartCast = function(plate)    
        UpdateReferences(plate)
        if not bars.cast:IsShown() then return end
        
        local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, notInterruptible 
        spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo("target")
        if not spell then 
            spell, rank, displayName, icon, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo("target")
        end
        
        if spell then
            unit.isCasting = true
            --UpdateUnitStatus()
            UpdateSpecialRegions()
            UpdatePlateIndicators(plate)
            --UpdateUnitCache()

            bars.castbar:SetStatusBarColor(bars.cast:GetStatusBarColor())
            bars.castbar:SetMinMaxValues(bars.cast:GetMinMaxValues())
            bars.castbar:SetValue(bars.cast:GetValue())
            bars.castbar:Show()    

            visual.spellicon:SetTexture(icon)
            if notInterruptible then 
                visual.castnostop:Show(); visual.castborder:Hide()
            else visual.castnostop:Hide(); visual.castborder:Show() end

            --SetSelfEcho(plate)
        end
        --unit.isCasting = false
    end
    
    OnStopCast = function(plate)        
        UpdateReferences(plate)
        UpdatePlateIndicators(plate)
        unit.isCasting = false
        SetSelfEcho(plate)
        bars.castbar:Hide()    
    end
    
    OnUpdateCast = function(plate)    
        UpdateReferences(plate)
        if bars.castbar:IsShown() then 
            local castremain = bars.cast:GetValue()
            UpdateSpecialRegions()
            bars.castbar:SetStatusBarColor(bars.cast:GetStatusBarColor())
            bars.castbar:SetMinMaxValues(bars.cast:GetMinMaxValues())
            bars.castbar:SetValue(castremain)
            bars.castbar:Show()    
        else OnStartCast(plate) end
    end    
end
-------------------------------------------------------
    -- ApplyPlateExtension: Applies scripts, hooks, and adds additional frame variables and elements
-------------------------------------------------------
local ApplyPlateExtension
do
    local bars, regions, health, castbar, healthbar, visual
    local region
    function ApplyPlateExtension(plate)
        Plates[plate] = true
        plate.extended = CreateFrame("Frame", nil, plate)
        local extended = plate.extended
        
        extended:SetPoint("CENTER", plate)
        extended.style, extended.unit, extended.unitcache, extended.stylecache, extended.widgets = {}, {}, {}, {}, {}
        extended.regions, extended.bars, extended.visual = {}, {}, {}
        regions = extended.regions
        bars = extended.bars
        bars.health, bars.cast = plate:GetChildren()
        extended.stylename = ""

        -- Set Frame Levels and Parent
        if (select(4, GetBuildInfo()) > 30300) then
            regions.threatglow, regions.healthborder, regions.highlight, regions.name, regions.level,
            regions.dangerskull, regions.raidicon, regions.eliteicon = plate:GetRegions()

            regions.castborder, regions.castnostop = bars.cast:GetRegions()
        else
            regions.threatglow, regions.healthborder, regions.castborder, regions.castnostop,
            regions.spellicon, regions.highlight, regions.name, regions.level,
            regions.dangerskull, regions.raidicon, regions.eliteicon = plate:GetRegions()
        end
        
        regions.threatglow:SetTexCoord( 0, 0, 0, 0 )
        regions.healthborder:SetTexCoord( 0, 0, 0, 0 )
        regions.castborder:SetTexCoord( 0, 0, 0, 0 )
        regions.castnostop:SetTexCoord( 0, 0, 0, 0 )
        regions.dangerskull:SetTexCoord( 0, 0, 0, 0 )
        regions.eliteicon:SetTexCoord( 0, 0, 0, 0 )
        regions.name:SetWidth( 000.1 )
        regions.level:SetWidth( 000.1 )
        regions.raidicon:SetAlpha( 0 )
    
        bars.health:SetStatusBarTexture(EMPTY_TEXTURE) 
        bars.cast:SetStatusBarTexture(EMPTY_TEXTURE) 
        
        -- Create Statusbars
        local level = plate:GetFrameLevel()
        bars.healthbar = CreateTidyPlatesStatusbar(extended) 
        bars.castbar = CreateTidyPlatesStatusbar(extended) 
        
        health, cast, healthbar, castbar = bars.health, bars.cast, bars.healthbar, bars.castbar
        healthbar:SetFrameLevel(level)
        castbar:Hide()
        castbar:SetFrameLevel(level)
        castbar:SetStatusBarColor(1,.8,0)
        
        -- Create Visual Regions
        visual = extended.visual
        visual.threatborder = healthbar:CreateTexture(nil, "ARTWORK")
        visual.specialArt = extended:CreateTexture(nil, "OVERLAY")
        visual.specialText = extended:CreateFontString(nil, "OVERLAY")
        visual.specialText2 = extended:CreateFontString(nil, "OVERLAY")
        --visual.healthborder = extended:CreateTexture(nil, "ARTWORK")
        visual.healthborder = extended:CreateTexture(nil, "BACKGROUND")
        visual.threatborder = extended:CreateTexture(nil, "OVERLAY")
        visual.castborder = castbar:CreateTexture(nil, "ARTWORK")
        visual.castnostop = castbar:CreateTexture(nil, "ARTWORK")
        visual.spellicon = castbar:CreateTexture(nil, "OVERLAY")
        visual.dangerskull = extended:CreateTexture(nil, "OVERLAY")
        visual.raidicon = extended:CreateTexture(nil, "OVERLAY")
        visual.eliteicon = extended:CreateTexture(nil, "OVERLAY")
        visual.name  = healthbar:CreateFontString(nil, "ARTWORK")
        visual.level = healthbar:CreateFontString(nil, "ARTWORK")

        visual.name:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        visual.level:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        visual.specialText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        visual.specialText2:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
        
        visual.highlight = regions.highlight
        
        visual.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
        visual.dangerskull:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull")

        local bg = CreateFrame("StatusBar", nil, extended)
        bg:SetWidth(SIZENAMEPLATES.WIDTH)
        bg:SetHeight(SIZENAMEPLATES.HEIGHT)
        bg:SetStatusBarTexture("Interface\\Addons\\ArenaSpectator\\BarTexture2")
        bg:SetStatusBarColor(0, 0, 0)
        bg:SetPoint("CENTER", 0, -5)
        bg:SetFrameLevel(0)
        bg:Show()

        healthbar.hptext = healthbar:CreateFontString()
        healthbar.hptext:SetFont(STANDARD_TEXT_FONT, SIZENAMEPLATES.TEXTSIZE, "OUTLINE")
        healthbar.hptext:SetPoint("RIGHT", -5, 0)
        healthbar.hptext:SetText("100%")

        healthbar.nametext = healthbar:CreateFontString()
        healthbar.nametext:SetFont(STANDARD_TEXT_FONT, SIZENAMEPLATES.TEXTSIZE, "OUTLINE")
        healthbar.nametext:SetPoint("LEFT", 5, 0)
        healthbar.nametext:SetText("Unknown")

        -- print(bg)

        -- bars.healthbar:SetTexture(0, 0, 0, 1)
        
        -- Update Immediately
        OnShowNameplate(plate)
        UpdateReferences(plate)
        UpdateUnitStatus()
        UpdateNameplateStyle(plate)
        UpdatePlateIndicators(plate)
        
        -- Hook for Updates        
        plate:HookScript("OnShow", OnShowNameplate)
        plate:HookScript("OnHide", OnHideNameplate)
        --cast:HookScript("OnShow", function () OnStartCast(plate) end) 
        cast:HookScript("OnHide", function () OnStopCast(plate) end) 
        cast:HookScript("OnValueChanged", function () OnUpdateCast(plate) end) 
        health:HookScript("OnValueChanged", function () SetSelfEcho(plate) end) 
    end
end
-------------------------------------------------------
-- World Update Functions
-------------------------------------------------------
local OnUpdate, UpdateAll
do
    local plate, curChildren
    local PlateSetAlpha, PlateGetAlpha
    -- IsFrameNameplate: Checks to see if the frame is a Blizz nameplate
    local function IsFrameNameplate(frame)
        local region = frame:GetRegions()
        return region and region:GetObjectType() == "Texture" and region:GetTexture() == "Interface\\TargetingFrame\\UI-TargetingFrame-Flash" 
    end
    -- OnWorldFrameChange: Checks for new Blizz Plates
    local function OnWorldFrameChange(...)
        UpdateSelfHealthBar()
        for index = 1, select("#", ...) do
            plate = select(index, ...)
            if not Plates[plate] and IsFrameNameplate(plate) then
                ApplyPlateExtension(plate)
                if not PlateSetAlpha then
                    PlateSetAlpha = plate.SetAlpha
                    PlateGetAlpha = plate.GetAlpha
                end
            end
        end
    end
    -- 
    function ForEachPlate(functionToRun, ...)
        for plate in pairs(PlatesVisible) do
            if plate.extended:IsShown() then -- Plate and extended frame both explicitly visible
                functionToRun(plate, ...)
            end
        end
    end
    --
    do
        -- This is the function that ForEachPlate calls repeatedly after UpdateAll requests an update
        local function CallOnUpdate(plate, force)
            if force then 
                local extended = plate.extended
                extended.unitcache = wipe(extended.unitcache)                
                extended.stylename = ""
                OnShowNameplate(plate)
            else
                OnUpdateNameplate(plate)
            end
        end
        -- UpdateAll: Requests an update on all Tidy Plates Frames
        UpdateAll = function(force)  ForEachPlate(CallOnUpdate, force) end
    end

    -- OnUpdate: This function will look for new frames under the WorldFrame
    OnUpdate = function(self)
        curChildren = WorldFrame:GetNumChildren()
        if (curChildren ~= numChildren) then
            numChildren = curChildren
            OnWorldFrameChange(WorldFrame:GetChildren()) 
        end    
        
        if (HasTarget) then -- Restore full opacity
            for plate in pairs(PlatesVisible) do
                -- Save original alpha before reset
                plate.alpha = PlateGetAlpha(plate)
                PlateSetAlpha(plate, 1) -- Local copies of methods are faster than table method lookups

                if echoSelf[plate] then
                    OnUpdateNameplate(plate)
                    echoSelf[plate] = nil
                end
            end
        else
            for plate in pairs(echoSelf) do
                echoSelf[plate] = nil
                OnUpdateNameplate(plate)
            end
        end
        
        --[[ Testing; If I'm going to be using OnUpdate, why not use it to determine mouseover
        if plate.regions.highlight:IsShown() then
            print(mouseover)
        end
        --]]

        if echoUpdate > 0 then UpdateAll(false);echoUpdate = echoUpdate - 1; end
    end
end
-------------------------------------------------------
-- Event Handlers
-------------------------------------------------------
do
    local events = {}
    local PlateHandler = CreateFrame("Frame", nil, WorldFrame)
    PlateHandler:SetFrameStrata("TOOLTIP") -- When parented to WorldFrame, causes OnUpdate handler to run close to last
    PlateHandler:SetScript("OnEvent", function(self, event, ...) events[event]() end)
    -- Events
    function events:PLAYER_ENTERING_WORLD() PlateHandler:SetScript("OnUpdate", OnUpdate) end
    function events:PLAYER_REGEN_ENABLED() InCombat = false; SetEchoUpdate(1); if useAutoHide then SetCVar("nameplateShowEnemies", 0) end end
    function events:PLAYER_REGEN_DISABLED() InCombat = true; SetEchoUpdate(1); if useAutoHide then SetCVar("nameplateShowEnemies", 1) end end
    function events:PLAYER_TARGET_CHANGED()
        HasTarget = UnitExists("target") == 1 -- Must be bool, never nil!
        if (not HasTarget) then
            for plate in pairs(PlatesVisible) do
                plate.alpha = 1
            end
        end
        SetEchoUpdate(1)
    end
    function events:RAID_TARGET_UPDATE() SetEchoUpdate(1) end
    function events:UNIT_THREAT_SITUATION_UPDATE() SetEchoUpdate(1) end
    function events:UNIT_LEVEL() SetEchoUpdate(1) end
    function events:UPDATE_MOUSEOVER_UNIT() ForEachPlate(OnMouseoverNameplate) end
    --function events:UNIT_AURA(arg1, arg2) ForEachPlate(OnMouseoverNameplate); SetEchoUpdate(1)end    
    function events:PLAYER_CONTROL_LOST() SetEchoUpdate(1) end
    function events:PLAYER_CONTROL_GAINED() SetEchoUpdate(1) end        
    function events:UNIT_FACTION() SetEchoUpdate(1) end    
    
    --function events:SPELL_AURA_APPLIED() end
    --function events:SPELL_AURA_APPLIED() end
    
    -- Event Registration
    for eventname in pairs(events) do PlateHandler:RegisterEvent(eventname) end    
end

-------------------------------------------------------
-- External Commands
-------------------------------------------------------
function TidyPlates:ForceUpdate() UpdateAll(true) end
TidyPlates.Update = function() SetEchoUpdate(1) end
function TidyPlates:UseAutoHide(option) useAutoHide = option; if useAutoHide and (not InCombat) then SetCVar("nameplateShowEnemies", 0) end end
function TidyPlates:ActivateTheme(theme) if theme and type(theme) == 'table' then activetheme = theme; end end

-------------------------------------------------------
-- Performance Monitoring
-------------------------------------------------------
TidyPlatesUsageMonitorLink = {}

TidyPlatesUsageMonitorLink.UpdateStyle = UpdateStyle
TidyPlatesUsageMonitorLink.UpdatePlateIndicators = UpdatePlateIndicators
TidyPlatesUsageMonitorLink.OnShowNameplate = OnShowNameplate
TidyPlatesUsageMonitorLink.OnUpdateNameplate = OnUpdateNameplate
TidyPlatesUsageMonitorLink.OnMouseoverNameplate = OnMouseoverNameplate
TidyPlatesUsageMonitorLink.ApplyPlateExtension = ApplyPlateExtension
TidyPlatesUsageMonitorLink.OnUpdate = OnUpdate

local healthbar, border

function CreateSelfHealthBar()
    local yOffset = 22

    bg = CreateFrame("StatusBar", nil, WorldFrame)
    bg:SetWidth(SIZENAMEPLATES.WIDTH + 2)
    bg:SetHeight(SIZENAMEPLATES.HEIGHT + 2)
    bg:SetStatusBarTexture("Interface\\Addons\\ArenaSpectator\\BarTexture2")
    bg:SetStatusBarColor(0, 0, 0)
    bg:SetPoint("CENTER", 0, yOffset)
    bg:SetFrameLevel(0)
    bg:Show()

    healthbar = CreateFrame("StatusBar", nil, bg)
    healthbar:SetWidth(SIZENAMEPLATES.WIDTH)
    healthbar:SetHeight(SIZENAMEPLATES.HEIGHT)
    healthbar:SetStatusBarTexture("Interface\\Addons\\ArenaSpectator\\BarTexture2")
    healthbar:SetPoint("CENTER", 0, 0)
    healthbar:Show()


    healthbar.hptext = healthbar:CreateFontString()
    healthbar.hptext:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
    healthbar.hptext:SetPoint("RIGHT", -5, 0)
    healthbar.hptext:SetText("100%")

    healthbar.nametext = healthbar:CreateFontString()
    healthbar.nametext:SetFont(STANDARD_TEXT_FONT, 8, "OUTLINE")
    healthbar.nametext:SetPoint("LEFT", 5, 0)

    border = CreateFrame("frame", nil, bg)
    border:SetPoint("TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", 1, -1)
    -- healthbar.nametext:SetText(players[watch].name)
end

function UpdateSelfHealthBar()
    if watch ~= nil then

        local hasPlatesEnabled = false

        for plate in pairs(PlatesVisible) do
            hasPlatesEnabled = true
            break
        end

        if hasPlatesEnabled then
            bg:Show()
            if ATPlayers[watch].name ~= nil then
                healthbar.nametext:SetText(ATPlayers[watch].name)
            end
            local health, maxhealth = ATPlayers[watch].health, ATPlayers[watch].maxhealth
            healthbar.hptext:SetText(math.ceil(health / maxhealth * 100) .. "%")
            healthbar:SetMinMaxValues(0, maxhealth)
            healthbar:SetValue(health)
            if ATPlayers[watch].class ~= nil then
                teamId = GetPlayerTeamByName(ATPlayers[watch].name)
                if (teamId) then
                    border:SetBackdrop({
                        bgFile = "", 
                        edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
                        tile = true,
                        tileSize = 2,
                        edgeSize = 2,
                    })
                    
                    if (teamId == 67) then
                        border:SetBackdropBorderColor(1.0, 0.0, 0.0, 0.75)
                    else
                        border:SetBackdropBorderColor(0.0, 0.5, 1.0, 0.75)
                    end
                end
                local class = ClassToTexture(ATPlayers[watch].class)
                local c = RAID_CLASS_COLORS[class]
                healthbar:SetStatusBarColor(c.r, c.g, c.b)
            end
        else
            border:SetBackdrop(nil)
            bg:Hide()
        end
    else
        bg:Hide()
        -- healthbar.nametext:SetText(UnitName("player"))
        -- local health, maxhealth = UnitHealth("player"), UnitHealthMax("player")
        -- healthbar.hptext:SetText(math.ceil(health / maxhealth * 100) .. "%")
        -- healthbar:SetMinMaxValues(0, maxhealth)
        -- healthbar:SetValue(health)

        -- _, class = UnitClass("player")
        -- local c = RAID_CLASS_COLORS[class]
        -- healthbar:SetStatusBarColor(c.r, c.g, c.b)
    end
end

CreateSelfHealthBar()