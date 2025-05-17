local AIO = AIO or require("AIO")
if AIO.AddAddon() then
	return
end

-- AIO handler for the RuneScape skill system skillHandler
local skillHandler = AIO.AddHandlers("RuneScapeSkillSystem", {})

-- SkillClient table to hold all functions
local SkillClient = {}
-- Store milestone data for the selected skill
local currentMilestones = {}

-- Basic RuneScape Skill Window using UIPanelDialogTemplate
function SkillClient.CreateSkillWindow()
	local frame = CreateFrame("Frame", "RuneScapeSkillWindow", UIParent, "UIPanelDialogTemplate")
	frame:SetSize(350, 400)
	frame:SetPoint("CENTER")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:Hide()

	-- Title text
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOP", 0, -8)
	title:SetText("Skills")

	-- -- Create a close button (not automatically included in UIPanelDialogTemplate)
	-- local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	-- closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, -3)
	-- closeButton:SetScript("OnClick", function() frame:Hide() end)

	return frame
end

local skillWindow = SkillClient.CreateSkillWindow()
-- Toggle the skill window: if open, close; if closed, open and request data
function SkillClient.ToggleSkillWindow()
    if skillWindow:IsShown() then
        skillWindow:Hide()
        -- Also hide progression window if open
        if progressionWindow:IsShown() then
            progressionWindow:Hide()
        end
    else
        -- Request skill data from the server when the window is shown
        AIO.Handle("RuneScapeSkillSystem", "RequestSkillData")
        skillWindow:Show()
    end
end

-- Expose for AIO handler if needed
_G.ToggleSkillWindow = SkillClient.ToggleSkillWindow

-- Register a slash command to toggle the RuneScape Skills window
SLASH_RUNESCAPESKILLS1 = "/skills"
SlashCmdList["RUNESCAPESKILLS"] = function()
    SkillClient.ToggleSkillWindow()
end

-- Store skill buttons for later reference
local skillButtons = {}
local skillsPerRow = 4
local skillBoxSize = 72
local skillBoxPadding = 8
local skillBoxFontSize = 12
local skillBoxYOffset = -40
local skillBoxXOffset = 16
local skillBoxYSpacing = skillBoxSize + skillBoxPadding
local skillBoxXSpacing = skillBoxSize + skillBoxPadding
local skillsPerPage = 16
local currentPage = 1
local totalPages = 1
local skillsData = {}
local lastProgressionSkillId = nil

-- Helper to clear skill buttons
function SkillClient.ClearSkillButtons()
	for _, btn in ipairs(skillButtons) do
		btn:Hide()
		btn:SetParent(nil)
	end
	for i = #skillButtons, 1, -1 do
		skillButtons[i] = nil
	end
end

-- Helper to create a skill box
function SkillClient.CreateSkillBox(parent, skill, idx, onClick)
	local btn = CreateFrame("Button", nil, parent)
	btn:SetSize(skillBoxSize, skillBoxSize)
	local row = math.floor((idx - 1) / skillsPerRow)
	local col = (idx - 1) % skillsPerRow
	btn:SetPoint(
		"TOPLEFT",
		parent,
		"TOPLEFT",
		skillBoxXOffset + col * skillBoxXSpacing,
		skillBoxYOffset - row * skillBoxYSpacing
	)
	btn:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 },
	})

	-- Set normal background color or highlight if this is the selected skill
	if lastProgressionSkillId and skill.id == lastProgressionSkillId then
		btn:SetBackdropColor(0.7, 0.6, 0.1, 0.8) -- Yellow-gold highlight for selected skill
	else
		btn:SetBackdropColor(0.1, 0.1, 0.1, 0.8) -- Normal dark background
	end
	-- btn:SetScript("OnClick", function()
	-- 	onClick(skill)
	-- end)
	btn:SetScript("OnClick", function()
		-- Request milestones from server for this skill
		AIO.Handle("RuneScapeSkillSystem", "RequestSkillMilestones", skill.id)
		if onClick then
			onClick(skill)
		end
	end)

	btn:EnableMouse(true)

	-- Icon
	local icon = btn:CreateTexture(nil, "ARTWORK")
	icon:SetSize(36, 36)
	icon:SetPoint("TOP", 0, -6)
	icon:SetTexture("Interface/Icons/" .. (skill.icon or "INV_Misc_QuestionMark"))

	-- Level text
	local levelText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	levelText:SetFont(levelText:GetFont(), skillBoxFontSize)
	levelText:SetPoint("BOTTOM", 0, 4)
	levelText:SetText((skill.level or 1) .. "/" .. (skill.max_level or 99))

	-- Name text
	local nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	nameText:SetPoint("BOTTOM", levelText, "TOP", 0, 2)
	nameText:SetText(skill.name or "?")

	-- Tooltip
	btn:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(skill.name or "?", 1, 1, 1)
		if skill.description then
			GameTooltip:AddLine(skill.description, 0.8, 0.8, 0.8, true)
		end
		GameTooltip:AddLine("Level: " .. (skill.level or 1) .. "/" .. (skill.max_level or 99), 1, 1, 0.5)
		GameTooltip:Show()
	end)
	btn:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)

	table.insert(skillButtons, btn)
	return btn
end

-- Helper to update skill buttons for the current page
function SkillClient.UpdateSkillButtons()
	SkillClient.ClearSkillButtons()
	local startIdx = (currentPage - 1) * skillsPerPage + 1
	local endIdx = math.min(startIdx + skillsPerPage - 1, #skillsData)
	for i = startIdx, endIdx do
		local skill = skillsData[i]
		local btn = SkillClient.CreateSkillBox(skillWindow, skill, i - startIdx + 1, function(clickedSkill)
			print("Clicked skill:", clickedSkill.name, "Level:", clickedSkill.level)
		end)
		btn:Show()
	end
	SkillClient.UpdatePaginationControls()
end

-- Pagination controls
function SkillClient.UpdatePaginationControls()
	if not skillWindow.nextPageBtn then
		local prevBtn = CreateFrame("Button", nil, skillWindow, "UIPanelButtonTemplate")
		prevBtn:SetSize(24, 24)
		prevBtn:SetPoint("BOTTOMLEFT", 16, 12)
		prevBtn:SetText("<")
		prevBtn:SetScript("OnClick", function()
			if currentPage > 1 then
				currentPage = currentPage - 1
				SkillClient.UpdateSkillButtons()
			end
		end)
		skillWindow.prevPageBtn = prevBtn

		local nextBtn = CreateFrame("Button", nil, skillWindow, "UIPanelButtonTemplate")
		nextBtn:SetSize(24, 24)
		nextBtn:SetPoint("BOTTOMRIGHT", -16, 12)
		nextBtn:SetText(">")
		nextBtn:SetScript("OnClick", function()
			if currentPage < totalPages then
				currentPage = currentPage + 1
				SkillClient.UpdateSkillButtons()
			end
		end)
		skillWindow.nextPageBtn = nextBtn

		local pageText = skillWindow:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		pageText:SetPoint("BOTTOM", 0, 16)
		skillWindow.pageText = pageText
	end
	skillWindow.pageText:SetText("Page " .. currentPage .. "/" .. totalPages)
	if currentPage > 1 then
		skillWindow.prevPageBtn:Enable()
	else
		skillWindow.prevPageBtn:Disable()
	end
	if currentPage < totalPages then
		skillWindow.nextPageBtn:Enable()
	else
		skillWindow.nextPageBtn:Disable()
	end
end

-- Add mouse wheel support for page switching
skillWindow:EnableMouseWheel(true)
skillWindow:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 and currentPage > 1 then
		currentPage = currentPage - 1
		SkillClient.UpdateSkillButtons()
	elseif delta < 0 and currentPage < totalPages then
		currentPage = currentPage + 1
		SkillClient.UpdateSkillButtons()
	end
end)

-- Helper to create the progression window
function SkillClient.CreateProgressionWindow()
	local frame = CreateFrame("Frame", "SkillProgressionWindow", UIParent, "UIPanelDialogTemplate")
	frame:SetSize(320, 380)
	-- frame:SetPoint("CENTER", 0, 40)
	frame:SetPoint("LEFT", skillWindow, "RIGHT", 24, 0)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:Hide()

	-- Title
	frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.title:SetPoint("TOP", 0, -8)
	frame.title:SetText("Skill Progression")

	-- -- Close button
	-- local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	-- closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, -3)
	-- closeBtn:SetScript("OnClick", function()
	-- 	frame:Hide()
	-- end)

	-- Scroll area for milestones
	local scrollFrame = CreateFrame("ScrollFrame", "SkillProgressionScrollFrame", frame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 16, -36)
	scrollFrame:SetPoint("BOTTOMRIGHT", -30, 50) -- Adjusted to make room for XP bar at bottom

	local content = CreateFrame("Frame", nil, scrollFrame)
	content:SetSize(1, 1)
	scrollFrame:SetScrollChild(content)
	frame.content = content

	-- Create XP Bar at bottom
	local xpBarHeight = 16
	local xpBarWidth = frame:GetWidth() - 32

	-- XP Bar background/container
	local xpBarBg = CreateFrame("Frame", nil, frame)
	xpBarBg:SetSize(xpBarWidth, xpBarHeight)
	xpBarBg:SetPoint("BOTTOM", 0, 16)
	xpBarBg:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 8,
		edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 },
	})
	xpBarBg:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
	frame.xpBarBg = xpBarBg

	-- XP Bar (Status Bar)
	local xpBar = CreateFrame("StatusBar", nil, xpBarBg)
	xpBar:SetPoint("TOPLEFT", 2, -2)
	xpBar:SetPoint("BOTTOMRIGHT", -2, 2)
	xpBar:SetStatusBarTexture("Interface/TargetingFrame/UI-StatusBar")
	xpBar:SetStatusBarColor(0.25, 0.78, 0.92) -- Light blue for XP
	xpBar:SetMinMaxValues(0, 1)
	xpBar:SetValue(0)
	frame.xpBar = xpBar

	-- XP Text
	local xpText = xpBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	xpText:SetPoint("CENTER", xpBar, "CENTER", 0, 0)
	xpText:SetTextColor(1, 1, 1)
	xpText:SetText("0/1000 XP")
	xpText:SetShadowOffset(1, -1)
	frame.xpText = xpText

	-- XP Label
	local xpLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	xpLabel:SetPoint("BOTTOM", xpBarBg, "TOP", 0, 4)
	xpLabel:SetText("Experience")
	frame.xpLabel = xpLabel

	return frame
end

 progressionWindow = SkillClient.CreateProgressionWindow()

function skillHandler.UpdateSkills(player, skills)
	skillsData = skills
	totalPages = math.max(1, math.ceil(#skillsData / skillsPerPage))
	currentPage = math.min(currentPage, totalPages)
	SkillClient.UpdateSkillButtons()

	-- Refresh milestones if progression window is open
	if progressionWindow:IsShown() and lastProgressionSkillId then
		local updatedSkill = nil
		for _, s in ipairs(skillsData) do
			if s.id == lastProgressionSkillId then
				updatedSkill = s
				break
			end
		end
		if updatedSkill then
			AIO.Handle("RuneScapeSkillSystem", "RequestSkillMilestones", lastProgressionSkillId)
			progressionWindow.title:SetText(updatedSkill.name .. " Progression")
		end
	end
end

-- Helper function to format large numbers with commas
function SkillClient.FormatNumber(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    return minus .. int .. fraction
end

-- Animation system for smoother XP bar updates
function SkillClient.AnimateXPBar(oldData, newData)
    -- If we don't have a progression window or it's not visible, do nothing
    if not progressionWindow or not progressionWindow:IsShown() then
        return
    end

    -- If we're at max level, just update immediately without animation
    if newData.isMaxLevel then
        progressionWindow.xpBar:SetValue(1)
        progressionWindow.xpBar:SetStatusBarColor(1, 0.84, 0) -- Gold for max level
        progressionWindow.xpText:SetText("MAX LEVEL")
        return
    end

    -- Calculate old progress
    local oldCurrentLevelXP = (oldData and oldData.currentLevelExp) or 0
    local oldNextLevelXP = (oldData and oldData.nextLevelExp) or (oldCurrentLevelXP + 1000)
    local oldCurrentXP = (oldData and oldData.currentExp) or oldCurrentLevelXP

    -- Calculate new progress
    local newCurrentLevelXP = newData.currentLevelExp or 0
    local newNextLevelXP = newData.nextLevelExp or (newCurrentLevelXP + 1000)
    local newCurrentXP = newData.currentExp or newCurrentLevelXP

    -- Calculate old and new progress values
    local oldLevelXPGained = oldCurrentXP - oldCurrentLevelXP
    local oldLevelXPNeeded = oldNextLevelXP - oldCurrentLevelXP
    local oldProgress = oldLevelXPNeeded > 0 and oldLevelXPGained / oldLevelXPNeeded or 0

    local newLevelXPGained = newCurrentXP - newCurrentLevelXP
    local newLevelXPNeeded = newNextLevelXP - newCurrentLevelXP
    local newProgress = newLevelXPNeeded > 0 and newLevelXPGained / newLevelXPNeeded or 0    -- Only animate if there's a change to animate
    if oldProgress == newProgress then
        return
    end

    -- Stop any existing animation by removing OnUpdate script
    if progressionWindow.animFrame then
        progressionWindow.animFrame:SetScript("OnUpdate", nil)
    end

    -- Setup animation parameters
    local duration = 0.75 -- Animation duration in seconds
    local animStartTime = GetTime()
    local startProgress = progressionWindow.xpBar:GetValue() -- Start from current value
    local endProgress = newProgress

    -- Create a smooth easing function
    local function easeOutQuad(t, b, c, d)
        t = t / d
        return -c * t * (t - 2) + b
    end

    -- Setup animation frame
    local animFrame = progressionWindow.animFrame or CreateFrame("Frame")
    progressionWindow.animFrame = animFrame

    -- Color function based on progress
    local function updateColor(progress)
        if progress >= 0.9 then
            progressionWindow.xpBar:SetStatusBarColor(1, 0.5, 0) -- Orange-gold for near level
        else
            progressionWindow.xpBar:SetStatusBarColor(0.25, 0.78, 0.92) -- Default blue
        end
    end

    -- Animation update function
    animFrame:SetScript("OnUpdate", function(self, elapsed)
        local currentTime = GetTime()
        local elapsedTime = currentTime - animStartTime

        if elapsedTime >= duration then
            -- Animation complete - set final values
            progressionWindow.xpBar:SetValue(endProgress)
            updateColor(endProgress)

            -- Format the final display text
            local formattedCurrent = SkillClient.FormatNumber(newLevelXPGained)
            local formattedNeeded = SkillClient.FormatNumber(newLevelXPNeeded)
            progressionWindow.xpText:SetText(formattedCurrent .. "/" .. formattedNeeded .. " XP")

            -- Stop animation
            self:SetScript("OnUpdate", nil)
            return
        end

        -- Calculate progress using easing
        local animProgress = easeOutQuad(elapsedTime, 0, 1, duration)
        local currentValue = startProgress + (endProgress - startProgress) * animProgress

        -- Update bar value
        progressionWindow.xpBar:SetValue(currentValue)
        updateColor(currentValue)

        -- Calculate interpolated XP values for text display
        local interpolatedXPGained = math.floor(oldLevelXPGained + (newLevelXPGained - oldLevelXPGained) * animProgress)

        -- Format the text
        local formattedCurrent = SkillClient.FormatNumber(interpolatedXPGained)
        local formattedNeeded = SkillClient.FormatNumber(newLevelXPNeeded)
        progressionWindow.xpText:SetText(formattedCurrent .. "/" .. formattedNeeded .. " XP")
    end)

    -- Store reference to animation
    progressionWindow.xpBarAnim = animFrame
end

-- Helper to update progression window with milestones
function SkillClient.ShowProgression(skill, milestones, expInfo)
	lastProgressionSkillId = skill.id
	-- Update title to include level information
	-- progressionWindow.title:SetText(skill.name .. " Progression (Level " .. skill.level .. ")")
    progressionWindow.title:SetText(skill.name .. " (Level " .. skill.level .. ")")
	local content = progressionWindow.content

	-- Clear previous milestone lines
	for i = 1, #(content.lines or {}) do
		content.lines[i]:Hide()
	end
	content.lines = content.lines or {}

	local y = -4
	local idx = 1
	for _, milestone in ipairs(milestones or {}) do
		local lineBtn = content.lines and content.lines[idx] or CreateFrame("Button", nil, content)
		lineBtn:SetSize(progressionWindow:GetWidth() - 40, 18)
		lineBtn:SetPoint("TOPLEFT", 0, y)

		if not lineBtn.text then
			lineBtn.text = lineBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
			lineBtn.text:SetPoint("LEFT", 0, 0)
			lineBtn.text:SetJustifyH("LEFT")
			lineBtn.text:SetJustifyV("TOP")
			lineBtn.text:SetWordWrap(true)
		end

		local color, prefix
		if milestone.unlocked then
			color = milestone.milestone_type == "major" and "|cffffd700" or "|cffb0ffb0"
			prefix = "C "
		else
			color = "|cff888888"
			prefix = "X "
		end

		local displayText = color
			.. prefix
			.. "Level "
			.. milestone.level
			.. ": "
			.. (milestone.description or "")
			.. "|r"
		lineBtn.text:SetText(displayText)
		lineBtn.text:SetWidth(progressionWindow:GetWidth() - 40)
		lineBtn.text:SetHeight(18)

		-- Always show tooltip with full description on hover
		lineBtn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(milestone.description or "", 1, 1, 1)
			GameTooltip:Show()
		end)
		lineBtn:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		lineBtn:Show()
		content.lines = content.lines or {}
		content.lines[idx] = lineBtn
		y = y - 18
		idx = idx + 1
	end
	content:SetHeight(math.abs(y) + 18)

	-- Update XP Bar if we have experience info
	if expInfo then
		-- If max level, show special display
		if expInfo.isMaxLevel then
			progressionWindow.xpBar:SetValue(1)
			progressionWindow.xpBar:SetStatusBarColor(1, 0.84, 0) -- Gold for max level
			progressionWindow.xpText:SetText("MAX LEVEL")
		else
			-- Calculate current level progress
			local currentLevelXP = expInfo.currentLevelExp or 0
			local nextLevelXP = expInfo.nextLevelExp or (currentLevelXP + 1000) -- Fallback
			local currentXP = expInfo.currentExp or 0

			-- Calculate XP needed for this level
			local levelXPNeeded = nextLevelXP - currentLevelXP
			local levelXPGained = currentXP - currentLevelXP

			-- Calculate percentage and set the bar
			local progress = levelXPNeeded > 0 and levelXPGained / levelXPNeeded or 0
			progressionWindow.xpBar:SetValue(progress)

			-- Format the display text
			local formattedCurrent = SkillClient.FormatNumber(levelXPGained)
			local formattedNeeded = SkillClient.FormatNumber(levelXPNeeded)
			progressionWindow.xpText:SetText(formattedCurrent .. "/" .. formattedNeeded .. " XP")

			-- Color the bar based on progress
			if progress >= 0.9 then
				progressionWindow.xpBar:SetStatusBarColor(1, 0.5, 0) -- Orange-gold for near level
			else
				progressionWindow.xpBar:SetStatusBarColor(0.25, 0.78, 0.92) -- Default blue
			end
		end

		-- Set up tooltip for more detailed XP info
		progressionWindow.xpBarBg:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOP")
			GameTooltip:SetText(skill.name .. " Experience", 1, 1, 1)

			if not expInfo.isMaxLevel then
				GameTooltip:AddLine("Current Level: " .. skill.level, 1, 0.82, 0)
				GameTooltip:AddLine("Total XP: " .. SkillClient.FormatNumber(expInfo.currentExp), 1, 1, 1)

				local levelXPNeeded = (expInfo.nextLevelExp or 0) - (expInfo.currentLevelExp or 0)
				local levelXPGained = (expInfo.currentExp or 0) - (expInfo.currentLevelExp or 0)
				local remaining = levelXPNeeded - levelXPGained

				GameTooltip:AddLine("XP to next level: " .. SkillClient.FormatNumber(remaining), 0.25, 0.78, 0.92)
				local progress = math.floor((levelXPGained / levelXPNeeded) * 100)
				GameTooltip:AddLine("Progress: " .. progress .. "%", 0.5, 0.5, 0.8)
			else
				GameTooltip:AddLine("Maximum level reached!", 1, 0.84, 0)
				GameTooltip:AddLine("Total XP: " .. SkillClient.FormatNumber(expInfo.currentExp), 1, 1, 1)
			end

			GameTooltip:Show()
		end)
		progressionWindow.xpBarBg:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	else
		-- No XP info available
		progressionWindow.xpBar:SetValue(0)
		progressionWindow.xpText:SetText("No XP Data")
	end

	progressionWindow:Show()
end

-- Request milestones from server (add this handler on both client and server)
function skillHandler.RequestSkillMilestones(player, skillId)
	-- This is a stub for the client; server will respond with milestones
end
-- Handler to receive milestones from server
function skillHandler.UpdateSkillMilestones(player, skillId, milestones, expInfo)
	-- Find the skill in skillsData
	local skill
	for _, s in ipairs(skillsData) do
		if s.id == skillId then
			skill = s
			break
		end
	end
	if skill then
		-- Store the previous selected skill ID
		local previousSkillId = lastProgressionSkillId

		-- Show progression for the new skill
		SkillClient.ShowProgression(skill, milestones, expInfo)

		-- If the selected skill has changed, update skill button highlights
		if previousSkillId ~= lastProgressionSkillId then
			SkillClient.UpdateSkillButtons()
		end
	end
end

-- Store current XP data for skills to track changes
local skillXPData = {}

-- Dedicated handler just for XP updates (more efficient than full milestone updates)
function skillHandler.UpdateSkillXP(player, xpInfo)
	if not xpInfo or not xpInfo.skillId then return end

	-- Store the old XP data for animation
	local oldXPData = skillXPData[xpInfo.skillId] or {}

	-- Find the skill in skillsData and update its local data
	for i, skill in ipairs(skillsData) do
		if skill.id == xpInfo.skillId then
			-- Update local skill data
			skillsData[i].level = xpInfo.level or skillsData[i].level
			skillsData[i].experience = xpInfo.currentExp or skillsData[i].experience
			break
		end
	end

	-- Only update UI if progression window is visible and showing this skill
	if progressionWindow:IsShown() and lastProgressionSkillId == xpInfo.skillId then
		-- Get reference to skill
		local skill
		for _, s in ipairs(skillsData) do
			if s.id == xpInfo.skillId then
				skill = s
				break
			end
		end

		if skill then
			SkillClient.AnimateXPBar(oldXPData, xpInfo)
		end
	end

	-- Store the new XP data
	skillXPData[xpInfo.skillId] = xpInfo
end
