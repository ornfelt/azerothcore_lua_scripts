-- local racialHandler = AIO.AddHandlers("RACIAL_CLIENT", {})
local AIO = AIO or require("AIO")
if AIO.AddAddon() then
	return
end

-- Define a handler function for the "RACIAL_CLIENT" addon
local racialHandler = AIO.AddHandlers("RACIAL_CLIENT", {})

-- Define global UI scale multiplier
local scaleMulti = 0.85

local RacialUI = {
	State = {
		racialButtons = {}, -- storing the buttons
		worldPortIcon = "achievement_dungeon_ulduar77_normal",
		isCommandsOn = true, -- Fixed: Initialize to true to enable commands
		isWorldIconOn = true,
		tableCommands = {
			"rui",
			"RacialUI",
		},
		activeRacialSpells = {},
		tabInfo = {},
		racialSpells = {},
		currentTab = 1, -- Track currently selected tab
		categoryCounters = {}, -- Store counters for each category
		unifiedCost = { -- Add unified cost settings
			enabled = true,
			costType = "gold",
			amount = 0,
		},
	},
}

-- FrameManager to manage frames
local FrameManager = {
	frames = {},
	templates = {},
	itemList = {},
	tabButtonsContentFrame = nil,
}

function FrameManager:AddFrame(frameName, frameTemplate)
	self.frames[frameName] = CreateFrame("Frame", frameName, UIParent, frameTemplate)
end

function FrameManager:GetFrame(frameName)
	return self.frames[frameName]
end

function FrameManager:RemoveFrame(frameName)
	if self.frames[frameName] then
		self.frames[frameName]:Hide()
		self.frames[frameName] = nil
	end
end

function FrameManager:CreateFrame(frameName, frameTemplate, parentFrame)
	local frame = CreateFrame("Frame", frameName, parentFrame, frameTemplate)
	self.frames[frameName] = frame
	return frame
end

function RacialUI.CoordsToTexCoords(size, xTop, yTop, xBottom, yBottom)
	-- Calculate the magic number
	local magic = (1 / size) / 2
	-- Calculate the top and left texture coordinates
	local Top = (yTop / size) + magic
	local Left = (xTop / size) + magic
	-- Calculate the bottom and right texture coordinates
	local Bottom = (yBottom / size) - magic
	local Right = (xBottom / size) - magic

	-- Return the texture coordinates
	return Left, Right, Top, Bottom
end

-- Handler for receiving tab information from server
function racialHandler.ReceiveTabInfo(player, tabData)
	-- Initialize tab state
	RacialUI.State.tabInfo = tabData
	RacialUI.State.currentTab = 1

	-- Create buttons after setting state
	RacialUI.RefreshTabs()
end

-- Handler for receiving racial spells from server
function racialHandler.ReceiveRacialSpells(player, racialSpells)
	-- Create a new table with numeric indices
	RacialUI.State.racialSpells = {}

	for categoryId, spellList in pairs(racialSpells) do
		-- Ensure categoryId is a number
		local numericCategoryId = tonumber(categoryId)
		if numericCategoryId then
			-- Initialize category if it doesn't exist
			RacialUI.State.racialSpells[numericCategoryId] = RacialUI.State.racialSpells[numericCategoryId] or {}

			-- Copy spells to the category
			for _, spell in ipairs(spellList) do
				table.insert(RacialUI.State.racialSpells[numericCategoryId], spell)
			end
		end
	end

	-- Set current tab if not set
	if not RacialUI.State.currentTab then
		RacialUI.State.currentTab = 1
	end

	RacialUI.RefreshSpells()
end

function RacialUI.RefreshTabs()
	-- Clear existing tab buttons safely
	if tabButtons then
		for _, button in ipairs(tabButtons) do
			if button then
				button:Hide()
				button:SetParent(nil)
			end
		end
		wipe(tabButtons)
	else
		tabButtons = {}
	end

	-- Create fresh tab buttons
	if RacialUI.State.tabInfo then
		for i, tab in ipairs(RacialUI.State.tabInfo) do
			if tab and tab.name and tab.icon then
				local button = RacialUI.createTabButton(
					i, -- Use index for positioning
					tab.name,
					tab.icon,
					RacialUI.TabButton_OnClick,
					RacialUI.TabButton_OnEnter,
					RacialUI.TabButton_OnLeave
				)

				if button then
					button:SetID(i)
					button:Show()
					table.insert(tabButtons, button)

					-- Handle highlighting
					if i == RacialUI.State.currentTab then
						button:LockHighlight()
					else
						button:UnlockHighlight()
					end
				end
			end
		end
	end

	-- Update tab buttons frame height
	if RacialUI.State.tabInfo and #RacialUI.State.tabInfo > 0 then
		local contentHeightTab = #RacialUI.State.tabInfo * 35
		FrameManager.tabButtonsContentFrame:SetHeight(contentHeightTab)
	end

	-- Update scrollbar visibility
	if RacialUI.UpdateTabButtonsScrollBarVisibility then
		RacialUI.UpdateTabButtonsScrollBarVisibility()
	end

	-- Refresh spells for current tab
	RacialUI.RefreshSpells()
end

function RacialUI.RefreshSpells()
	if not FrameManager.itemList.contentFrame then
		print("Error: contentFrame is nil")
		return
	end

	-- Clear existing spell buttons
	local children = { FrameManager.itemList.contentFrame:GetChildren() }
	for _, child in ipairs(children) do
		if child then
			child:Hide()
			child:SetParent(nil)
		end
	end

	-- Reset buttons array
	wipe(RacialUI.State.racialButtons)

	-- Check if we have valid current tab
	if not RacialUI.State.currentTab then
		print("Error: currentTab is nil")
		return
	end

	-- Get spells for current tab
	local currentTabSpells = RacialUI.State.racialSpells[RacialUI.State.currentTab]
	if not currentTabSpells then
		-- print("Error: No spells found for tab", RacialUI.State.currentTab)
		return
	end

	-- Calculate content frame size based on number of spells
	local numSpells = #currentTabSpells
	local numColumns = 4
	local rowHeight = 35
	local contentHeight = math.ceil(numSpells / numColumns) * rowHeight

	-- Set content frame size
	FrameManager.itemList.contentFrame:SetSize(FrameManager.itemList.scrollFrame:GetWidth(), contentHeight)

	-- Make sure content frame is properly positioned
	FrameManager.itemList.contentFrame:SetPoint("TOPLEFT", FrameManager.itemList.scrollFrame, "TOPLEFT", 0, 0)

	-- Reset scroll position
	FrameManager.itemList.scrollFrame:SetVerticalScroll(0)

	-- Update scroll bar
	local scrollBar = _G[FrameManager.itemList.scrollFrame:GetName() .. "ScrollBar"]
	if scrollBar then
		scrollBar:SetMinMaxValues(0, math.max(0, contentHeight - FrameManager.itemList.scrollFrame:GetHeight()))
		scrollBar:SetValue(0)

		-- Show/hide scrollbar based on content height
		if contentHeight > FrameManager.itemList.scrollFrame:GetHeight() then
			scrollBar:Show()
		else
			scrollBar:Hide()
		end
	end

	-- Create new spell buttons
	for i, spellInfo in ipairs(currentTabSpells) do
		local icon, itemName = nil, nil

		if spellInfo and spellInfo.id and spellInfo.name then
			if spellInfo.itemType == "item" then
				icon = GetItemIcon(spellInfo.id)
				itemName = GetItemInfo(spellInfo.id) or spellInfo.name
			elseif spellInfo.itemType == "spell" or spellInfo.itemType == "profession" then
				icon = select(3, GetSpellInfo(spellInfo.id))
				itemName = GetSpellInfo(spellInfo.id) or spellInfo.name
			end

			if icon and itemName then
				local button = RacialUI.createItemButton(
					FrameManager.itemList.contentFrame,
					i,
					spellInfo.id,
					spellInfo.name,
					itemName,
					icon,
					spellInfo.itemType,
					spellInfo.costType or "",
					spellInfo.cost or 0
				)

				if button then
					button:SetID(spellInfo.id)
					button:Show()
					table.insert(RacialUI.State.racialButtons, button)
				end
			else
				print("Failed to get icon or name for spell:", spellInfo.id)
			end
		end
	end

	-- Update active racial count
	if RacialUI.activeRacialSpells then
		RacialUI.activeRacialSpells()
	end
end

-- Update RacialUI.TabButton_OnClick to set current tab
function RacialUI.TabButton_OnClick(self)
	local tabID = self:GetID()

	-- Verify we have spells for this category
	if not RacialUI.State.racialSpells[tabID] then
		print("No spells found for tab:", tabID)
		return
	end

	-- Update current tab
	RacialUI.State.currentTab = tabID

	-- Deactivate all tab buttons
	if tabButtons then
		for _, button in pairs(tabButtons) do
			if button then
				button:UnlockHighlight()
			end
		end
	end

	-- Activate clicked tab
	self:LockHighlight()

	-- Refresh spells display
	RacialUI.RefreshSpells()
	RacialUI.updateCategoryCounters() -- Update counters when changing tabs
end

-------------------------------
-- [xXx]
-------------------------------

-- local mainFrame = CreateFrame("Frame", "customRacialFrame", UIParent, "UIPanelDialogTemplate")
local mainFrame = CreateFrame("Frame", "customRacialFrame", UIParent)
mainFrame:SetSize(800, 500)
mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
mainFrame:SetBackdropColor(0, 0, 0, 1)
mainFrame:Hide()

-- Background texture
mainFrame.Background = mainFrame:CreateTexture(nil, "BACKGROUND")
mainFrame.Background:SetSize(mainFrame:GetSize())
mainFrame.Background:SetPoint("CENTER", mainFrame, "CENTER")
mainFrame.Background:SetTexture("Interface/Racial_UI/StoreFrame_Main")
mainFrame.Background:SetTexCoord(RacialUI.CoordsToTexCoords(1024, 0, 0, 1024, 658))

-- Title--

tinsert(UISpecialFrames, mainFrame:GetName()) -- allows frame to be closed with escape key

mainFrame.CloseButton = CreateFrame("Button", nil, mainFrame)
mainFrame.CloseButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -5, 0)
mainFrame.CloseButton:SetScript("OnClick", function()
	mainFrame:Hide()
end)
mainFrame.CloseButton.texture = mainFrame.CloseButton:CreateTexture(nil, "BACKGROUND")
-- mainFrame.CloseButton.texture:SetTexture("Interface/Racial_UI/TitanLogo")
mainFrame.CloseButton.texture:SetTexture("Interface/Racial_UI/Transmogrify")
mainFrame.CloseButton.texture:SetTexCoord(RacialUI.CoordsToTexCoords(512, 485, 85, 511, 115))
mainFrame.CloseButton.texture:SetAllPoints(mainFrame.CloseButton)

mainFrame.CloseButton:SetSize(20, 20)
mainFrame.CloseButton:SetNormalTexture(mainFrame.CloseButton.texture)
-- set alpha to 0.5 when mouse is over button
mainFrame.CloseButton:SetScript("OnEnter", function(self)
	self.texture:SetAlpha(0.5)
end)
-- set alpha to 1 when mouse leaves button
mainFrame.CloseButton:SetScript("OnLeave", function(self)
	self.texture:SetAlpha(1)
end)
mainFrame:SetScript("OnUpdate", function()
	RacialUI.activeRacialSpells()
end)

-------------------------------
-- [tab window for categories]
-------------------------------
local categoryList = CreateFrame("Frame", nil, mainFrame)
categoryList:SetSize(150, 300)
categoryList:SetPoint("TOPLEFT", 15, -35)
-- categoryList:SetBackdrop(
--     {
--         bgFile = "Interface/Tooltips/UI-Tooltip-Background",
--         edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
--         tile = true,
--         tileSize = 16,
--         edgeSize = 16,
--         insets = { left = 4, right = 4, top = 4, bottom = 4 }
--     }
-- )
categoryList:SetBackdropColor(0, 0, 0, 0.8)

FrameManager.itemList = CreateFrame("Frame", nil, mainFrame)
FrameManager.itemList:SetSize(600, 435)
FrameManager.itemList:SetPoint("TOPRIGHT", -15, -45)

-- FrameManager.itemList:SetBackdropColor(0, 0, 0, 0.8)
-- FrameManager.itemList:SetBackdrop({
-- 	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
-- 	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
-- 	tile = true,
-- 	tileSize = 16,
-- 	edgeSize = 16,
-- 	insets = { left = 4, right = 4, top = 4, bottom = 4 },
-- })
-- FrameManager.itemList:SetBackdropColor(0, 0, 0, 0.8)

-- FrameManager.itemList:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, 0)
-- FrameManager.itemList:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0)

-- FrameManager.itemList:SetBackdrop(
--     {
--         bgFile = "Interface/Tooltips/UI-Tooltip-Background",
--         edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
--         tile = true,
--         tileSize = 16,
--         edgeSize = 16,

--         insets = { left = 4, right = 4, top = 4, bottom = 4 }
--     }
-- )

local scrollFrame =
	CreateFrame("ScrollFrame", "CustomRacial_ScrollFrame", FrameManager.itemList, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", FrameManager.itemList, "TOPLEFT", 10, -10)
scrollFrame:SetPoint("BOTTOMRIGHT", FrameManager.itemList, "BOTTOMRIGHT", -30, 10)
scrollFrame:SetScrollChild(contentFrame)
scrollFrame:EnableMouse(true)

FrameManager.itemList.scrollFrame = scrollFrame

contentFrame = CreateFrame("Frame", "contentFrame", scrollFrame)
-- add debug window
-- contentFrame:SetBackdrop(
--     {
--         bgFile = "Interface/Tooltips/UI-Tooltip-Background",
--         edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
--         tile = true,
--         tileSize = 16,
--         edgeSize = 16,
--         insets = { left = 4, right = 4, top = 4, bottom = 4 },
--     })
-- contentFrame:SetBackdropColor(0, 0, 0, 0.8)
-- contentFrame:SetSize(600, 435) -- Set size for contentFrame
-- contentFrame:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, 0)
-- contentFrame:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 0)

FrameManager.itemList.scrollFrame:SetScript("OnMouseWheel", function(self, delta)
	local currentValue = _G[FrameManager.itemList.scrollFrame:GetName() .. "ScrollBar"]:GetValue()
	local newValue = currentValue - (delta * 30) -- Change '30' to adjust the scroll speed
	-- local contentHeight = FrameManager.itemList.contentFrame:GetHeight() -- Get the content height from FrameManager.itemList.contentFrame
	local contentHeight = contentFrame:GetHeight() -- Get the content height from FrameManager.itemList.contentFrame
	_G[FrameManager.itemList.scrollFrame:GetName() .. "ScrollBar"]:SetValue(
		math.min(math.max(newValue, 0), math.max(0, contentHeight - FrameManager.itemList.scrollFrame:GetHeight())) -- Clamp(newValue, 0, math.max(0, contentHeight - FrameManager.itemList.scrollFrame:GetHeight()))
	)
end)

FrameManager.itemList.contentFrame = contentFrame

FrameManager.tabButtonsScrollFrame =
	CreateFrame("ScrollFrame", "CustomShop_FrameManager.TabButtonsScrollFrame", categoryList)
FrameManager.tabButtonsScrollFrame:SetSize(200, 385)
FrameManager.tabButtonsScrollFrame:SetPoint("TOPLEFT", categoryList, "TOPRIGHT", -150, -30)

FrameManager.tabButtonsContentFrame = CreateFrame("Frame", nil, FrameManager.tabButtonsScrollFrame)
FrameManager.tabButtonsScrollFrame:SetScrollChild(FrameManager.tabButtonsContentFrame)
FrameManager.tabButtonsContentFrame:SetSize(200, 385) -- Set size for FrameManager.tabButtonsContentFrame

local tabInfo = RacialUI.State.tabInfo
local contentHeightTab = #tabInfo * 35 -- assuming each tab button is 40 pixels high
FrameManager.tabButtonsContentFrame:SetSize(200, contentHeightTab)

FrameManager.tabButtonsScrollBar =
	CreateFrame("Slider", nil, FrameManager.tabButtonsScrollFrame, "UIPanelScrollBarTemplate")
FrameManager.tabButtonsScrollBar:SetPoint("TOPLEFT", categoryList, "TOPRIGHT", 0, -40)
FrameManager.tabButtonsScrollBar:SetPoint("BOTTOMLEFT", categoryList, "BOTTOMRIGHT", 0, -100)
local contentHeightTab = FrameManager.tabButtonsContentFrame:GetHeight() -- calculate the length of the content frame and set the max value
FrameManager.tabButtonsScrollBar:SetMinMaxValues(0, contentHeightTab)

-- local contentHeightTab = FrameManager.tabButtonsContentFrame:GetHeight() * 2
local contentHeightTab = FrameManager.tabButtonsContentFrame:GetHeight()
FrameManager.tabButtonsScrollBar:SetMinMaxValues(0, contentHeightTab)
FrameManager.tabButtonsScrollBar:SetValueStep(1)
FrameManager.tabButtonsScrollBar:SetValue(0)
FrameManager.tabButtonsScrollBar:SetWidth(16)
FrameManager.tabButtonsScrollFrame:EnableMouseWheel(true)

function RacialUI.onScroll(self, delta)
	-- create a way to use mouse wheel to scroll the tab buttons frame
	local currentValue = FrameManager.tabButtonsScrollBar:GetValue()
	local newValue = currentValue - (delta * 30) -- Change '30' to adjust the scroll speed
	-- local contentHeightTab = FrameManager.tabButtonsContentFrame:GetHeight() -- Get the content height from FrameManager.itemList.contentFrame
	FrameManager.tabButtonsScrollBar:SetValue(math.min(math.max(newValue, 0), math.max(0, contentHeightTab)))
end

FrameManager.tabButtonsScrollBar:SetScript("OnValueChanged", function(self, value)
	FrameManager.tabButtonsScrollFrame:SetVerticalScroll(value)
end)

function RacialUI.UpdateTabButtonsScrollBarVisibility()
	-- hide if if less then 15 tabinfo is active and show if more then 15 tabinfo is active
	if #RacialUI.State.tabInfo > 10 then
		FrameManager.tabButtonsScrollBar:Show()
		FrameManager.tabButtonsScrollFrame:SetScript("OnMouseWheel", RacialUI.onScroll)
	else
		FrameManager.tabButtonsScrollBar:Hide()
	end
end

RacialUI.UpdateTabButtonsScrollBarVisibility()

-- Setups the tabs to the left side.
function RacialUI.createTabButton(id, text, icon, onClick, OnEnter, OnLeave)
	local button = CreateFrame("Button", nil, FrameManager.tabButtonsContentFrame)
	-- Main button
	local size = 200
	button:SetSize(size * scaleMulti, (size / 4) * scaleMulti)

	-- Fix tab positioning to match category ID
	-- button:SetPoint("TOPLEFT", 0, -35 * (id - 1)) -- Changed from -35 - (id - 2) * 35
	button:SetPoint("TOPLEFT", 0, -38 * (id - 1))
	-- Set tab textures
	button:SetNormalTexture("Interface/Racial_UI/StoreFrame_Main")
	button:SetHighlightTexture("Interface/Racial_UI/StoreFrame_Main")
	button:GetNormalTexture():SetTexCoord(RacialUI.CoordsToTexCoords(1024, 770, 900, 1024, 960))
	button:GetHighlightTexture():SetTexCoord(RacialUI.CoordsToTexCoords(1024, 770, 960, 1024, 1024))

	-- Set Category name
	button.Name = button:CreateFontString()
	button.Name:SetFont("Fonts\\FRIZQT__.TTF", 14)
	button.Name:SetShadowOffset(1, -1)
	button.Name:SetPoint("CENTER", button, "CENTER", 5, 0)
	button.Name:SetText(text)

	-- Set Icon
	button.Icon = button:CreateTexture(nil, "BACKGROUND")
	button.Icon:SetSize(31, 31)
	button.Icon:SetPoint("LEFT", button, "LEFT", 2, 0)
	button.Icon:SetTexture("Interface/Icons/" .. icon)

	button:SetScript("OnClick", onClick)
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", OnLeave)

	return button
end

function RacialUI.IsTotalMaxActive()
	-- Initialize a variable to keep track of the total maximum number of active spells
	local totalMaxActive = 0

	-- Loop through the values in the   RacialUI.State.tabInfo table and add the maxActiveSpells values together
	for _, tabInfo in pairs(RacialUI.State.tabInfo) do
		totalMaxActive = totalMaxActive + tabInfo.maxActiveSpells
	end
	return totalMaxActive
end

--  show the text on how many is active.
function RacialUI.activeRacialSpells()
	local count = 0
	for k, v in pairs(RacialUI.State.racialSpells) do
		for numSpells, spell in pairs(v) do
			if (spell.itemType == "spell" or spell.itemType == "profession") and IsSpellKnown(spell.id, false) then
				count = count + 1
			elseif spell.itemType == "item" and GetItemCount(spell.id) > 0 then
				count = count + 1
			end
		end
	end
	-- activeRacialNumber:SetText(count .. "/" .. RacialUI.IsTotalMaxActive())
end

local itemTooltip = CreateFrame("GameTooltip", "itemTooltip", UIParent, "GameTooltipTemplate")
itemTooltip:SetOwner(UIParent, "ANCHOR_NONE")

function RacialUI.unlearnSkill(name)
	local numSkills = GetNumSkillLines()
	for i = 1, numSkills do
		local skillName, isHeader, _, _, _, _, _, _, _, _, _, _, _ = GetSkillLineInfo(i)

		if not isHeader then
			-- find what skill player is trying to unlearn then unlearn it in the table it has a name

			if skillName == name then
				AbandonSkill(i)
				break
			end
			-- AbandonSkill(i)
		end
	end
end

StaticPopupDialogs["CONFIRM_UNLEARN_PROFESSION"] = {
	text = "Are you sure you want to unlearn this profession?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function(self)
		RacialUI.unlearnSkill(self.data.name)
		AIO.Handle("RACIAL_SERVER", "unlearnFeature", self.data.id, self.data.itemType)
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

-- Call this function when you want to show the popup
function ShowUnlearnProfessionPopup(name, id, itemType)
	local dialog = StaticPopup_Show("CONFIRM_UNLEARN_PROFESSION")
	if dialog then
		dialog.data = { name = name, id = id, itemType = itemType }
	end
end

-- -- Button for the spells it create
function RacialUI.createItemButton(parent, index, id, name, text, icon, itemType, costType, cost, classType)
	-- isPassive = IsPassiveSpell(index, "bookType") or IsPassiveSpell("name")

	local button = CreateFrame("Button", nil, parent)
	button:SetSize(120, 25)
	button:EnableMouse(true)

	-- button:SetPoint("TOPLEFT", 0, -5 - (index - 1) * 35)
	local numColumns = 4
	local xIndex = (index - 1) % numColumns
	local yIndex = math.floor((index - 1) / numColumns)

	local xOffset = xIndex * 145
	-- local xOffset = xIndex * 130
	local yOffset = -15 - yIndex * 35

	button:SetPoint("TOPLEFT", xOffset + 10, yOffset)
	-- cet so it goes left to right and then down

	local iconTexture = button:CreateTexture(nil, "ARTWORK")
	iconTexture:SetSize(32, 32)
	iconTexture:SetTexture(icon)
	iconTexture:SetPoint("LEFT", 0, 0)

	local textLabel = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	textLabel:SetText(text)
	textLabel:SetFontObject("GameFontNormal")
	textLabel:SetPoint("LEFT", iconTexture, "RIGHT", 5, 0)
	textLabel:SetTextColor(1, 1, 1, 1)
	textLabel:SetWidth(100)
	textLabel:SetHeight(40)
	textLabel:SetWordWrap(true)
	textLabel:SetJustifyH("LEFT")

	-- button:SetScript("OnClick", OnClick)
	-- button:SetScript("OnEnter", OnEnter)
	-- button:SetScript("OnLeave", OnLeave)
	-- button:SetScript("OnUpdate", OnUpdate)

	-- -- Set the button click script
	-- Register the button for drag and click events
	button:RegisterForDrag("LeftButton")
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	button:SetScript("OnClick", function(self, button, down)
		-- Store the original OnEnter function to call later
		local originalOnEnter = self:GetScript("OnEnter")
		-- Store the original OnUpdate function
		local originalOnUpdate = self:GetScript("OnUpdate")
		local tooltipRefreshTimer = nil -- Timer for delayed tooltip refresh

		-- Find category ID for spell
		local categoryId
		for catId, spells in pairs(RacialUI.State.racialSpells) do -- Changed from ipairs to pairs
			for _, spellInfo in ipairs(spells) do
				if spellInfo.id == id then
					categoryId = catId
					break
				end
			end
			if categoryId then
				break
			end
		end

		if not categoryId then
			print("Spell not found in any category")
			return
		end

		-- Calculate current active count in the category (real-time check)
		local currentActiveCount = 0
		local spellsInCategory = RacialUI.State.racialSpells[categoryId]
		if spellsInCategory then
			for _, spellInfo in ipairs(spellsInCategory) do
				local checkActive = false
				if spellInfo.itemType == "spell" then
					checkActive = IsSpellKnown(spellInfo.id, false)
				elseif spellInfo.itemType == "profession" then
					if spellInfo.id == 50300 then -- Herbalism check
						checkActive = IsSpellKnown(2383, false)
					else
						checkActive = IsSpellKnown(spellInfo.id, false)
					end
				elseif spellInfo.itemType == "item" then
					checkActive = GetItemCount(spellInfo.id, true) > 0
				end
				if checkActive then
					currentActiveCount = currentActiveCount + 1
				end
			end
		end

		local spellCategory = RacialUI.State.tabInfo[categoryId].name:lower()
		local maximumActive = RacialUI.State.tabInfo[categoryId].maxActiveSpells

		-- Determine the current active state of *this* specific button's item/spell
		local isCurrentlyActive = false
		if itemType == "spell" then
			isCurrentlyActive = IsSpellKnown(id, false)
		elseif itemType == "profession" then
			if id == 50300 then
				isCurrentlyActive = IsSpellKnown(2383, false)
			else
				isCurrentlyActive = IsSpellKnown(id, false)
			end
		elseif itemType == "item" then
			isCurrentlyActive = GetItemCount(id, true) > 0
		end
		self.active = isCurrentlyActive -- Ensure self.active is up-to-date before logic

		-- Learn Action (Left Click)
		if button == "LeftButton" then
			if not isCurrentlyActive then
				if currentActiveCount < maximumActive then
					AIO.Handle("RACIAL_SERVER", "learnFeature", id, itemType)
					print(string.format("Learning %s", text))

					print(string.format("Item Type: %s", itemType))
					-- Optimistically update state, server will confirm
					self.active = true
					table.insert(RacialUI.State.activeRacialSpells, id)
				else
					print(string.format("You can only have %d active %s", maximumActive, spellCategory))
				end
			end
		-- Unlearn Action (Right Click)
		elseif button == "RightButton" then
			if isCurrentlyActive then
				if itemType == "profession" then
					ShowUnlearnProfessionPopup(name, id, itemType)
					-- Note: Actual AIO.Handle call for profession unlearn is in the popup's OnAccept
				else
					AIO.Handle("RACIAL_SERVER", "unlearnFeature", id, itemType)
					-- Optimistically update state
					self.active = false
					for i, activeId in ipairs(RacialUI.State.activeRacialSpells) do
						if activeId == id then
							table.remove(RacialUI.State.activeRacialSpells, i)
							break
						end
					end
				end
			end
		end

		-- Force Tooltip Update after a short delay using OnUpdate
		if itemTooltip:IsShown() and self:IsMouseOver() then
			itemTooltip:Hide() -- Hide immediately
			tooltipRefreshTimer = 0.1 -- Set the delay timer

			-- Temporarily replace OnUpdate to handle the delay
			self:SetScript("OnUpdate", function(self, elapsed)
				if tooltipRefreshTimer then
					tooltipRefreshTimer = tooltipRefreshTimer - elapsed
					if tooltipRefreshTimer <= 0 then
						tooltipRefreshTimer = nil -- Clear the timer
						self:SetScript("OnUpdate", originalOnUpdate) -- Restore original OnUpdate

						if self:IsMouseOver() then -- Check if mouse is still over
							originalOnEnter(self) -- Call the original OnEnter to rebuild tooltip
						end
					end
				else
					-- If timer is somehow nil, restore original OnUpdate just in case
					self:SetScript("OnUpdate", originalOnUpdate)
					-- Optionally call the original OnUpdate if it exists
					if originalOnUpdate then
						originalOnUpdate(self, elapsed)
					end
				end
			end)
		end

		-- Update category counters after spell activation/deactivation attempt
		RacialUI.updateCategoryCounters()
	end)

	button:SetScript("OnEnter", function(self)
		local success, result = pcall(function()
			itemTooltip:SetOwner(self, "ANCHOR_CURSOR")

			local link
			if itemType == "spell" or itemType == "profession" then
				link = "spell:" .. id
			elseif itemType == "item" then
				link = "item:" .. id
			else
				itemTooltip:SetText("Invalid item type: " .. tostring(itemType), 1, 1, 1, 1, true)
				itemTooltip:Show()
				return
			end

			local checkName = link and (itemType == "spell" or itemType == "profession") and GetSpellInfo(id)
				or GetItemInfo(id)
			if not checkName then
				itemTooltip:SetText("Invalid " .. itemType .. " ID: " .. tostring(id), 1, 1, 1, 1, true)
				itemTooltip:Show()
				return
			end

			itemTooltip:SetHyperlink(link)

			-- Determine the real-time active status directly
			local isActive = false
			if itemType == "spell" then
				isActive = IsSpellKnown(id, false)
			elseif itemType == "profession" then
				if id == 50300 then -- Special case for Herbalism
					isActive = IsSpellKnown(2383, false) -- Check for Find Herbs
				else
					isActive = IsSpellKnown(id, false)
				end
			elseif itemType == "item" then
				isActive = GetItemCount(id, true) > 0
			end

			-- Check if player can afford to unlearn if spell is active
			local canAffordUnlearn = true
			if isActive and costType and cost then -- Use isActive instead of self.active
				if costType == "gold" then
					local playerMoney = GetMoney()
					canAffordUnlearn = playerMoney >= cost
				elseif costType == "item" then
					local itemCount = GetItemCount(cost, true)
					canAffordUnlearn = itemCount > 0 -- Check if player has at least one required item
				elseif costType == "spell" then
					canAffordUnlearn = IsSpellKnown(cost)
				end
			end

			-- Get current tab info
			local currentTab = RacialUI.State.currentTab
			local maxActive = RacialUI.State.tabInfo[currentTab].maxActiveSpells

			-- Count active spells in current category (using real-time checks)
			local activeCount = 0
			local spells = RacialUI.State.racialSpells[currentTab]
			if spells then
				for _, spellInfo in ipairs(spells) do
					if spellInfo.itemType == "spell" and IsSpellKnown(spellInfo.id, false) then
						activeCount = activeCount + 1
					elseif spellInfo.itemType == "profession" then
						if spellInfo.id == 50300 and IsSpellKnown(2383, false) then -- Herbalism check
							activeCount = activeCount + 1
						elseif spellInfo.id ~= 50300 and IsSpellKnown(spellInfo.id, false) then
							activeCount = activeCount + 1
						end
					elseif spellInfo.itemType == "item" and GetItemCount(spellInfo.id, true) > 0 then
						activeCount = activeCount + 1
					end
				end
			end

			-- Show active status and learn/unlearn info based on real-time isActive
			if isActive then -- Use isActive instead of self.active
				itemTooltip:AddLine("This ability is active", 0, 1, 0)
				itemTooltip:AddLine("Right-click to unlearn", 1, 0, 0)
				if costType and cost then
					local costText = "Cost to Unlearn: "
					if costType == "gold" then
						local gold = math.floor(cost / 10000)
						local silver = math.floor((cost % 10000) / 100)
						local copper = cost % 100
						costText = costText .. gold .. "g " .. silver .. "s " .. copper .. "c"
						if not canAffordUnlearn then
							costText = costText .. " |cFFFF0000(Not enough gold)|r"
						end
					elseif costType == "item" then
						local itemName = GetItemInfo(cost)
						costText = costText .. "1x " .. (itemName or "Item #" .. cost)
						if not canAffordUnlearn then
							costText = costText .. " |cFFFF0000(Missing item)|r"
						end
					elseif costType == "spell" then
						local spellName = GetSpellInfo(cost)
						costText = costText .. (spellName or "Spell #" .. cost)
						if not canAffordUnlearn then
							costText = costText .. " |cFFFF0000(Required spell missing)|r"
						end
					end
					itemTooltip:AddLine(costText, 1, 0.82, 0)
				end
			else
				if activeCount >= maxActive then
					itemTooltip:AddLine(
						string.format("Maximum abilities (%d) already active in this category", maxActive),
						1,
						0,
						0
					)
				else
					itemTooltip:AddLine("Left-click to learn (Free)", 0, 1, 0)
				end
			end

			itemTooltip:Show()
		end)
		if not success then
			print("Error in OnEnter tooltip: " .. tostring(result)) -- Changed error message
		end
	end)

	button:SetScript("OnLeave", function()
		itemTooltip:Hide()
	end)

	button:SetScript("OnUpdate", function(self, elapsed, ...)
		local isActive = false

		-- Determine active state based on item type
		if itemType == "spell" then
			isActive = IsSpellKnown(id, false)
		elseif itemType == "profession" then
			-- Special case for Herbalism (Find Herbs)
			if id == 50300 then
				isActive = IsSpellKnown(2383, false)
			else
				isActive = IsSpellKnown(id, false)
			end
		elseif itemType == "item" then
			isActive = GetItemCount(id, true) > 0
		end

		-- Update button state and alpha
		self.active = isActive
		self:SetAlpha(isActive and 1 or 0.5)

		-- Manage overlay texture for active/inactive state
		-- Create overlay if it doesn't exist
		if not self.overlay then
			self.overlay = self:CreateTexture(nil, "OVERLAY")
			self.overlay:SetTexture("Interface/Racial_UI/DressingRoom") -- Set base texture
			self.overlay:SetWidth(32)
			self.overlay:SetHeight(32)
			self.overlay:SetPoint("CENTER", iconTexture, "CENTER", 0, 0)
		end

		-- Set appropriate texture coordinates based on active state
		if isActive then
			-- Active state texture coordinates
			self.overlay:SetTexCoord(RacialUI.CoordsToTexCoords(512, 358, 42, 399, 84))
		else
			-- Inactive state texture coordinates
			self.overlay:SetTexCoord(RacialUI.CoordsToTexCoords(512, 441, 0, 483, 42))
		end
	end)

	-- button:SetScript("OnMouseDown", function(self, button)
	--     -- if IsShiftKeyDown() then
	--     --     local spellName = GetSpellInfo(id)
	--     --     PickupSpell(spellName)
	--     -- end
	--     if button == "LeftButton" then
	--         if IsShiftKeyDown() then
	--             local spellName = GetSpellInfo(id)
	--             if spellName then
	--                 PickupSpell(spellName)
	--             end
	--         elseif IsControlKeyDown() then
	--             local itemName = GetItemInfo(id)
	--             if itemName then
	--                 PickupItem(id)
	--             end
	--         end
	--     end
	-- end)

	--  Set the button drag start script
	button:SetScript("OnDragStart", function(self)
		local spellName = GetSpellInfo(id)
		local itemName = GetItemInfo(id)
		if spellName then
			PickupSpell(spellName)
		elseif itemName then
			PickupItem(id)
		end
	end)

	-- Set the button drag stop script
	button:SetScript("OnDragStop", function(self) end)

	button:SetAttribute("itemType", itemType)
	button:SetAttribute("itemCost", cost)
	button:SetAttribute("costType ", costType)
	button:SetAttribute("cost", cost)

	table.insert(RacialUI.State.racialButtons, button)

	button.costLabel = costLabel
	return button, costLabel
end

-- adds all the racial spells to the list
function RacialUI.populateList(categoryId)
	if not RacialUI.State.tabInfo[categoryId] then
		return -- Invalid category ID
	end

	-- Reset the scrollbar position
	FrameManager.itemList.scrollFrame:SetVerticalScroll(0)

	-- Get spells for this category
	local spells = RacialUI.State.racialSpells[categoryId]
	if not spells then
		return
	end

	-- Calculate content height
	local numSpells = #spells
	local numColumns = 4
	local contentHeight = math.ceil(numSpells / numColumns) * 35

	-- Clear existing item buttons
	for _, child in ipairs({ FrameManager.itemList.contentFrame:GetChildren() }) do
		child:Hide()
	end

	-- Update the contentFrame's size
	FrameManager.itemList.contentFrame:SetSize(FrameManager.itemList.scrollFrame:GetWidth(), contentHeight)

	-- Update scrollbar
	local slider = _G[FrameManager.itemList.scrollFrame:GetName() .. "ScrollBar"]
	slider:SetMinMaxValues(0, math.max(0, contentHeight - FrameManager.itemList.scrollFrame:GetHeight()))
	slider:SetValue(0)

	-- Show/hide scrollbar based on content height
	if contentHeight > FrameManager.itemList.scrollFrame:GetHeight() then
		slider:Show()
	else
		slider:Hide()
	end

	-- Create buttons for each spell in this category
	if spells then
		for i, spellInfo in ipairs(spells) do
			local icon, itemName = nil, nil

			if spellInfo.itemType == "item" then
				icon = GetItemIcon(spellInfo.id)
				itemName = GetItemInfo(spellInfo.id) or "Unknown Item"
			elseif spellInfo.itemType == "spell" or spellInfo.itemType == "profession" then
				icon = select(3, GetSpellInfo(spellInfo.id))
				itemName = GetSpellInfo(spellInfo.id) or "Unknown Spell"
			end

			if icon and itemName then
				local button = RacialUI.createItemButton(
					FrameManager.itemList.contentFrame,
					i,
					spellInfo.id,
					spellInfo.name,
					itemName,
					icon,
					spellInfo.itemType,
					spellInfo.costType,
					spellInfo.cost
				)
				if button then
					button:SetAttribute("costType", spellInfo.costType)
					button:SetAttribute("itemCost", spellInfo.cost)
					button:SetID(spellInfo.id)
					table.insert(RacialUI.State.racialButtons, button)
				end
			end
		end
	end
end
-- load first tab
RacialUI.populateList(1)

function RacialUI.TabButton_OnEnter(self)
	-- Handle mouse entering the tab button
	-- local tabID = self:GetID()

	-- local text = RacialUI.State.tabInfo[tabID].name .. " tab"

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	-- GameTooltip:SetText(text, 1, 1, 1)
	GameTooltip:Show()
end

function RacialUI.TabButton_OnLeave(self)
	-- Handle mouse leaving the tab button
	-- print(" RacialUI.TabButton_OnLeave")
	GameTooltip:Hide()
end

for i, tab in ipairs(RacialUI.State.tabInfo) do
	-- log tab info
	local button = RacialUI.createTabButton(
		tab.id,
		tab.name,
		tab.icon,
		RacialUI.TabButton_OnClick,
		RacialUI.TabButton_OnEnter,
		RacialUI.TabButton_OnLeave
	)
	button:SetID(tab.id)
	table.insert(tabButtons, button)
end

-- Function to unlearn spells and clear the active state
function RacialUI.resetSpells()
	for tabIndex, spellList in ipairs(RacialUI.State.racialSpells) do
		for _, spellInfo in ipairs(spellList) do
			if RacialUI.IsTotalMaxActive() then
				RacialUI.RacialUI.activeRacialSpells = {}
			end

			-- Check spell type and handle accordingly
			if spellInfo.itemType == "spell" then
				if IsSpellKnown(spellInfo.id, false) then
					AIO.Handle("RACIAL_SERVER", "unLearnAllRacials", spellInfo.id, spellInfo.itemType)
				end
			elseif spellInfo.itemType == "profession" then
				if spellInfo.id == 50300 then
					if IsSpellKnown(2383, false) then
						AIO.Handle("RACIAL_SERVER", "unLearnAllRacials", 50300, spellInfo.itemType)
						RacialUI.unlearnSkill("Herbalism") -- unlearn profession
					end
				else
					if IsSpellKnown(spellInfo.id, false) then
						AIO.Handle("RACIAL_SERVER", "unLearnAllRacials", spellInfo.id, spellInfo.itemType)
						RacialUI.unlearnSkill(spellInfo.name) -- unlearn profession
					end
				end
			elseif spellInfo.itemType == "item" then
				local itemCount = GetItemCount(spellInfo.id, true)
				if itemCount > 0 then
					AIO.Handle("RACIAL_SERVER", "unLearnAllRacials", spellInfo.id, spellInfo.itemType)
				end
			end

			local button = RacialUI.racialButtons[tabIndex][spellInfo.id]
			if button then
				button.active = false
				button:SetAlpha(0.5)
				if button.overlay then
					button.overlay:Hide()
				end
			end
		end
	end
end

-- Add function to calculate total reset costs
function RacialUI.calculateTotalResetCosts()
	local totalGoldCost = 0
	local requiredItems = {}
	local requiredSpells = {}
	local playerMoney = GetMoney()

	-- Loop through all active racials
	for categoryId, spells in pairs(RacialUI.State.racialSpells) do
		for _, spellInfo in ipairs(spells) do
			local isActive = false

			-- Check if spell is active
			if spellInfo.itemType == "spell" then
				isActive = IsSpellKnown(spellInfo.id, false)
			elseif spellInfo.itemType == "profession" then
				if spellInfo.id == 50300 then
					isActive = IsSpellKnown(2383, false)
				else
					isActive = IsSpellKnown(spellInfo.id, false)
				end
			elseif spellInfo.itemType == "item" then
				isActive = GetItemCount(spellInfo.id, true) > 0
			end

			-- If active, add its cost
			if isActive then
				if spellInfo.costType == "gold" then
					totalGoldCost = totalGoldCost + (spellInfo.cost or 0)
				elseif spellInfo.costType == "item" then
					requiredItems[spellInfo.cost] = (requiredItems[spellInfo.cost] or 0) + 1
				elseif spellInfo.costType == "spell" then
					requiredSpells[spellInfo.cost] = true
				end
			end
		end
	end

	return totalGoldCost, requiredItems, requiredSpells, playerMoney
end

-- Create the reset button
local resetButton = CreateFrame("Button", nil, mainFrame, "UIPanelButtonTemplate")
resetButton:SetSize(175, 20)
resetButton:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMLEFT", 10, 26)

resetButton:SetNormalTexture("Interface/Racial_UI/StoreFrame_Main")
resetButton:SetHighlightTexture("Interface/Racial_UI/StoreFrame_Main")
resetButton:SetPushedTexture("Interface/Racial_UI/StoreFrame_Main")
resetButton:GetNormalTexture():SetTexCoord(RacialUI.CoordsToTexCoords(1024, 709, 849, 837, 873))
resetButton:GetHighlightTexture():SetTexCoord(RacialUI.CoordsToTexCoords(1024, 709, 849, 837, 873))
resetButton:GetPushedTexture():SetTexCoord(RacialUI.CoordsToTexCoords(1024, 709, 873, 837, 897))

-- Buy now button text
resetButton.ButtonText = resetButton:CreateFontString()
resetButton.ButtonText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
resetButton.ButtonText:SetPoint("CENTER", resetButton, 0, 0)
resetButton.ButtonText:SetText("Reset All")

-- Create confirmation dialog for reset
StaticPopupDialogs["CONFIRM_RESET_ALL_RACIALS"] = {
	text = "Are you sure you want to reset all racial abilities? This will cost the removal fee for each active racial.",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		AIO.Handle("RACIAL_SERVER", "resetAllRacials")
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
	showAlert = true,
}

-- Modify the reset button click handler
resetButton:SetScript("OnClick", function(self)
	StaticPopup_Show("CONFIRM_RESET_ALL_RACIALS")
end)

--  the reset button tooltip
resetButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddLine("Reset All Racial Abilities", 1, 1, 1)
	GameTooltip:AddLine(" ")

	-- Display which tabs will be reset
	GameTooltip:AddLine("Will reset abilities from:", 1, 0.82, 0)
	local hasResettableTabs = false
	for _, tab in ipairs(RacialUI.State.tabInfo) do
		if tab.reset then
			GameTooltip:AddLine("- " .. tab.name, 0.9, 0.9, 0.9)
			hasResettableTabs = true
		end
	end

	if not hasResettableTabs then
		GameTooltip:AddLine("No tabs are marked for reset!", 1, 0, 0)
		GameTooltip:Show()
		return
	end

	GameTooltip:AddLine(" ")

	-- Check if unified cost system is enabled
	if RacialUI.State.unifiedCost.enabled then
		-- Display unified cost information
		local costType = RacialUI.State.unifiedCost.costType
		local amount = RacialUI.State.unifiedCost.amount
		local canAfford = true
		local costString = "Unified Reset Cost: "

		-- Format cost based on type
		if costType == "gold" then
			local gold = math.floor(amount / 10000)
			local silver = math.floor((amount % 10000) / 100)
			local copper = amount % 100
			costString = costString .. string.format("%dg %ds %dc", gold, silver, copper)

			-- Check if player can afford
			local playerMoney = GetMoney()
			canAfford = playerMoney >= amount

			if canAfford then
				GameTooltip:AddLine(costString, 0, 1, 0)
			else
				GameTooltip:AddLine(costString, 1, 0, 0)
				local missing = amount - playerMoney
				local missingGold = math.floor(missing / 10000)
				local missingSilver = math.floor((missing % 10000) / 100)
				local missingCopper = missing % 100
				GameTooltip:AddLine(
					string.format("Missing: %dg %ds %dc", missingGold, missingSilver, missingCopper),
					1,
					0,
					0
				)
			end
		elseif costType == "item" then
			local itemName = GetItemInfo(amount) or ("Item #" .. amount)
			costString = costString .. itemName

			-- Check if player has the item
			local playerCount = GetItemCount(amount, true)
			canAfford = playerCount > 0

			GameTooltip:AddLine(costString, canAfford and 0 or 1, canAfford and 1 or 0, 0)
			if not canAfford then
				GameTooltip:AddLine("Missing required item", 1, 0, 0)
			end
		elseif costType == "spell" then
			local spellName = GetSpellInfo(amount) or ("Spell #" .. amount)
			costString = costString .. spellName

			-- Check if player has the spell
			canAfford = IsSpellKnown(amount)

			GameTooltip:AddLine(costString, canAfford and 0 or 1, canAfford and 1 or 0, 0)
			if not canAfford then
				GameTooltip:AddLine("Required spell not known", 1, 0, 0)
			end
		end
	else
		-- Calculate costs for active spells in resettable tabs
		local totalGoldCost = 0
		local requiredItems = {}
		local requiredSpells = {}

		-- Loop through all spells in resettable tabs
		for tabId, spells in pairs(RacialUI.State.racialSpells) do
			-- Check if this tab is marked for reset
			if RacialUI.State.tabInfo[tabId] and RacialUI.State.tabInfo[tabId].reset then
				for _, spellInfo in ipairs(spells) do
					-- Check if spell is active
					local isActive = false
					if spellInfo.itemType == "spell" then
						isActive = IsSpellKnown(spellInfo.id)
					elseif spellInfo.itemType == "profession" then
						if spellInfo.id == 50300 then
							isActive = IsSpellKnown(2383)
						else
							isActive = IsSpellKnown(spellInfo.id)
						end
					elseif spellInfo.itemType == "item" then
						isActive = GetItemCount(spellInfo.id, true) > 0
					end

					-- If active, add its cost
					if isActive then
						if spellInfo.costType == "gold" then
							totalGoldCost = totalGoldCost + (spellInfo.cost or 0)
						elseif spellInfo.costType == "item" then
							requiredItems[spellInfo.cost] = (requiredItems[spellInfo.cost] or 0) + 1
						elseif spellInfo.costType == "spell" then
							requiredSpells[spellInfo.cost] = true
						end
					end
				end
			end
		end

		-- Show total gold cost
		if totalGoldCost > 0 then
			local gold = math.floor(totalGoldCost / 10000)
			local silver = math.floor((totalGoldCost % 10000) / 100)
			local copper = totalGoldCost % 100
			local costString = string.format("Total Cost: %dg %ds %dc", gold, silver, copper)
			local playerMoney = GetMoney()

			if playerMoney >= totalGoldCost then
				GameTooltip:AddLine(costString, 0, 1, 0)
			else
				GameTooltip:AddLine(costString, 1, 0, 0)
				local missing = totalGoldCost - playerMoney
				local missingGold = math.floor(missing / 10000)
				local missingSilver = math.floor((missing % 10000) / 100)
				local missingCopper = missing % 100
				GameTooltip:AddLine(
					string.format("Missing: %dg %ds %dc", missingGold, missingSilver, missingCopper),
					1,
					0,
					0
				)
			end
		end

		-- Show required items
		if next(requiredItems) then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("Required Items:", 1, 0.82, 0)
			for itemId, count in pairs(requiredItems) do
				local itemName = GetItemInfo(itemId) or ("Item #" .. itemId)
				local playerCount = GetItemCount(itemId, true)
				local color = playerCount >= count and "|cFF00FF00" or "|cFFFF0000"
				GameTooltip:AddLine(string.format("%s%s x%d (%d/%d)", color, itemName, count, playerCount, count))
			end
		end

		-- Show required spells
		if next(requiredSpells) then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("Required Spells:", 1, 0.82, 0)
			for spellId in pairs(requiredSpells) do
				local spellName = GetSpellInfo(spellId) or ("Spell #" .. spellId)
				local hasSpell = IsSpellKnown(spellId)
				local color = hasSpell and "|cFF00FF00" or "|cFFFF0000"
				GameTooltip:AddLine(string.format("%s%s", color, spellName))
			end
		end
	end

	-- Add instructions
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("Click to reset all active racial abilities", 1, 0.82, 0)

	GameTooltip:Show()
end)

resetButton:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- Add handler for when reset is complete
function racialHandler.OnResetComplete()
	-- Refresh the UI
	RacialUI.RefreshSpells()
	RacialUI.updateCategoryCounters()
	-- Play sound effect
	PlaySound("igQuestListComplete")
end

-- Create a container frame for category counters at the bottom
local categoryCountersContainer = CreateFrame("Frame", nil, mainFrame)
categoryCountersContainer:SetSize(600, 20)
categoryCountersContainer:SetPoint("BOTTOM", mainFrame, "BOTTOM", 100, 26)

-- Create counter text for the current category
local categoryCounterText = categoryCountersContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
categoryCounterText:SetPoint("LEFT", 0, 0)
categoryCounterText:SetText("")

-- Function to update category counters
function RacialUI.updateCategoryCounters()
	local currentTab = RacialUI.State.currentTab
	if not currentTab or not RacialUI.State.tabInfo[currentTab] then
		return
	end

	local activeCount = 0
	local maxActiveCount = RacialUI.State.tabInfo[currentTab].maxActiveSpells or 0

	-- Get spells for current category
	local spells = RacialUI.State.racialSpells[currentTab]
	if spells then
		for _, spellInfo in ipairs(spells) do
			local isActive = false

			if spellInfo.itemType == "spell" then
				isActive = IsSpellKnown(spellInfo.id, false)
			elseif spellInfo.itemType == "profession" then
				if spellInfo.id == 50300 then
					isActive = IsSpellKnown(2383, false)
				else
					isActive = IsSpellKnown(spellInfo.id, false)
				end
			elseif spellInfo.itemType == "item" then
				isActive = GetItemCount(spellInfo.id, true) > 0
			end

			if isActive then
				activeCount = activeCount + 1
			end
		end
	end

	local categoryName = RacialUI.State.tabInfo[currentTab].name
	-- Update display format to show active/maximum instead of active/total
	categoryCounterText:SetText(string.format("%s: %d/%d Active", categoryName, activeCount, maxActiveCount))
	categoryCounterText:SetTextColor(1, 1, 1, 1)
	categoryCounterText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	categoryCounterText:SetShadowOffset(1, -1)
	categoryCounterText:SetShadowColor(0, 0, 0, 1)
end

-- Update counter in real-time using OnUpdate
categoryCountersContainer:SetScript("OnUpdate", function(self, elapsed)
	if mainFrame:IsShown() then
		RacialUI.updateCategoryCounters()
	end
end)

-- Initial update when frame is shown
mainFrame:SetScript("OnShow", function()
	RacialUI.updateCategoryCounters()
end)

-- Handle receiving unified cost settings from server
function racialHandler.ReceiveUnifiedCostSettings(player, settings)
	RacialUI.State.unifiedCost = settings
end

-- Function to toggle the window visibility
function RacialUI.toggleWindow()
	if mainFrame:IsShown() then
		mainFrame:Hide()
		PlaySound("igSpellBookClose")
	else
		mainFrame:Show()
		PlaySound("igSpellBookOpen")
		RacialUI.updateCategoryCounters()
	end
end

-- AIO handler to open/toggle the UI window
function racialHandler.racialOpenUI()
	RacialUI.toggleWindow()
end

-- AIO handler to explicitly close the UI window
function racialHandler.racialCloseUI()
	if mainFrame:IsShown() then -- Only hide and play sound if it's currently shown
		mainFrame:Hide()
		PlaySound("igSpellBookClose")
	end
end

-- handle the /commands
if RacialUI.State.isCommandsOn then
	-- add slash commands
	for i, command in ipairs(RacialUI.State.tableCommands) do
		_G["SLASH_RacialUI" .. i] = "/" .. command
		SlashCmdList["RacialUI" .. i] = function()
			RacialUI.toggleWindow()
		end
	end

	SlashCmdList["RacialUI"] = function()
		RacialUI.toggleWindow()
	end
end

-- World Port Icon
if RacialUI.State.isWorldIconOn then
	-- add icon on worldframe for easy access
	local icon = CreateFrame("Button", nil, WorldFrame)
	icon:SetSize(32, 32)
	icon:SetPoint("TOP", WorldFrame, "TOP", 100, -40)

	-- icon:SetNormalTexture("Interface\\Icons\\wowtoken")
	-- set a racial icon
	icon:SetNormalTexture("Interface/Icons/" .. RacialUI.State.worldPortIcon)
	-- icon:SetHighlightTexture("Interface/Icons/" ..  RacialUI.State.worldPortIcon)
	-- icon:SetPushedTexture("Interface/Icons/" ..  RacialUI.State.worldPortIcon)

	SetPortraitToTexture(icon:GetNormalTexture(), "Interface/Icons/" .. RacialUI.State.worldPortIcon)
	icon:SetAlpha(0.5)
	local tex = icon:CreateFontString(nil, "OVERLAY")
	tex:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	tex:SetPoint("CENTER", icon, "BOTTOM", 0, -5)
	tex:SetText("Custom Racial")
	icon:SetFrameStrata("HIGH")
	icon:SetClampedToScreen(true)
	icon:SetScript("OnClick", function(self, button, down)
		RacialUI.toggleWindow()
	end)
	icon:SetScript("OnEnter", function(self)
		icon:SetAlpha(1)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText("Click to open Custom Racial")
		GameTooltip:Show()
	end)
	icon:SetScript("OnLeave", function(self)
		icon:SetAlpha(0.5)
		GameTooltip:Hide()
	end)
	-- drag able
	icon:SetMovable(true)
	icon:EnableMouse(true)
	icon:RegisterForDrag("LeftButton")
	icon:SetScript("OnDragStart", function(self)
		self:StartMoving()
	end)
	icon:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
	end)

	if not icon:IsVisible() then
		icon:ClearAllPoints()
		icon:SetPoint("TOP", WorldFrame, "TOP", 0, -100)
	end
end
