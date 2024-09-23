-- Requiring of Client Message Handler not needed
-- Handled by addon dependency

local config = {
	Prefix = "StatPointUI",
	Functions = {
		[1] = "OnCacheReceived"
	}
}

local StatPointUI = {
	cache = {}
}

function StatPointUI.OnLogin()
	-- Load all UI assets before requesting cache from server
	StatPointUI.OnLoad()
	SendClientRequest(config.Prefix, 1)
end

function StatPointUI.OnLoad()
	-- Create the main UI frame
	StatPointUI.mainFrame = CreateFrame("Frame", config.Prefix, CharacterFrame)
	StatPointUI.mainFrame:SetToplevel(true)
	StatPointUI.mainFrame:SetSize(200, 260)
	StatPointUI.mainFrame:SetBackdrop({
		bgFile = [[Interface\TutorialFrame\TutorialFrameBackground]],
		edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
		edgeSize = 16,
		tileSize = 32,
		insets = {left = 5, right = 5, top = 5, bottom = 5}
	})
	StatPointUI.mainFrame:SetPoint("TOPRIGHT",170,-20)
	StatPointUI.mainFrame:Hide()
	
	-- Title bar
	StatPointUI.titleBar = CreateFrame("Frame", config.Prefix.."TitleBar", StatPointUI.mainFrame)
	StatPointUI.titleBar:SetSize(135, 25)
	StatPointUI.titleBar:SetBackdrop(
	{
		bgFile = [[Interface/CHARACTERFRAME/UI-Party-Background]],
		edgeFile = [[Interface/DialogFrame/UI-DialogBox-Border]],
		tile = true,
		edgeSize = 16,
		tileSize = 16,
		insets = {left = 5, right = 5, top = 5, bottom = 5}
	})
	StatPointUI.titleBar:SetPoint("TOP", 0, 9)
	
	-- Titlebar text
	StatPointUI.titleBarText = StatPointUI.titleBar:CreateFontString(config.Prefix.."TitleBarText")
	StatPointUI.titleBarText:SetFont("Fonts\\FRIZQT__.TTF", 13)
	StatPointUI.titleBarText:SetSize(190, 5)
	StatPointUI.titleBarText:SetPoint("CENTER", 0, 0)
	StatPointUI.titleBarText:SetText("|cffFFC125Attribute Points|r")
	
	-- Generate row tables
	local rowOffset = -30
	local titleOffset = -100
	local btnOffset = 40
	local rowContent = {"Strength", "Agility", "Stamina", "Intellect", "Spirit"}
	
	for k, v in pairs(rowContent) do
		
		StatPointUI[v] = {}
		-- Value (dummy, overwritten by server values
		StatPointUI[v].Val = StatPointUI.mainFrame:CreateFontString(config.Prefix..v.."Val")
		StatPointUI[v].Val:SetFont("Fonts\\FRIZQT__.TTF", 15)
		
		if(k == 1) then
			StatPointUI[v].Val:SetPoint("CENTER", StatPointUI.titleBar, "CENTER", 30, rowOffset)
		else
			StatPointUI[v].Val:SetPoint("CENTER", StatPointUI[rowContent[k-1]].Val, "CENTER", 0, rowOffset)
		end
		StatPointUI[v].Val:SetText("0")
		
		-- Title
		StatPointUI[v].Title = StatPointUI.mainFrame:CreateFontString(config.Prefix..v.."Title")
		StatPointUI[v].Title:SetFont("Fonts\\FRIZQT__.TTF", 15)
		StatPointUI[v].Title:SetPoint("LEFT", StatPointUI[v].Val, "LEFT", titleOffset, 0)
		StatPointUI[v].Title:SetText(v..":")
		
		-- Increase button
		StatPointUI[v].Button = CreateFrame("Button", config.Prefix..v.."Button", StatPointUI.mainFrame)
		StatPointUI[v].Button:SetSize(20, 20)
		StatPointUI[v].Button:SetPoint("RIGHT", StatPointUI[v].Val, "RIGHT", btnOffset, 0)
		StatPointUI[v].Button:EnableMouse(false)
		StatPointUI[v].Button:Disable()
		StatPointUI[v].Button:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Up")
		StatPointUI[v].Button:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
		StatPointUI[v].Button:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
		StatPointUI[v].Button:SetDisabledTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Disabled")
		StatPointUI[v].Button:SetScript("OnMouseUp", function() SendClientRequest(config.Prefix, 2, k); PlaySound("UChatScrollButton"); end)
	end
	
	-- Attribute points left
	StatPointUI.pointsLeftVal = StatPointUI.mainFrame:CreateFontString(config.Prefix.."PointsLeftVal")
	StatPointUI.pointsLeftVal:SetFont("Fonts\\FRIZQT__.TTF", 15)
	StatPointUI.pointsLeftVal:SetPoint("CENTER", StatPointUI[rowContent[#rowContent]].Val, "CENTER", 0, rowOffset)
	StatPointUI.pointsLeftVal:SetText("0")
	
	StatPointUI.pointsLeftTitle = StatPointUI.mainFrame:CreateFontString(config.Prefix.."PointsLeftVal")
	StatPointUI.pointsLeftTitle:SetFont("Fonts\\FRIZQT__.TTF", 15)
	StatPointUI.pointsLeftTitle:SetPoint("LEFT", StatPointUI.pointsLeftVal, "LEFT", titleOffset, 0)
	StatPointUI.pointsLeftTitle:SetText("Points left:")
	
	-- Reset button
	StatPointUI.resetButton = CreateFrame("Button", config.Prefix.."ResetButton", StatPointUI.mainFrame)
	StatPointUI.resetButton:SetSize(100, 25)
	StatPointUI.resetButton:SetPoint("CENTER", StatPointUI.titleBar, "CENTER", 0, -220)
	StatPointUI.resetButton:EnableMouse(true)
	StatPointUI.resetButton:SetText("RESET")
	StatPointUI.resetButton:SetNormalFontObject("GameFontNormalSmall")
	
	local ntex = StatPointUI.resetButton:CreateTexture()
	ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()	
	StatPointUI.resetButton:SetNormalTexture(ntex)
	
	local htex = StatPointUI.resetButton:CreateTexture()
	htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	htex:SetTexCoord(0, 0.625, 0, 0.6875)
	htex:SetAllPoints()
	StatPointUI.resetButton:SetHighlightTexture(htex)
	
	local ptex = StatPointUI.resetButton:CreateTexture()
	ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	ptex:SetAllPoints()
	StatPointUI.resetButton:SetPushedTexture(ptex)
	
	StatPointUI.resetButton:SetScript("OnMouseUp", function() SendClientRequest(config.Prefix, 3); PlaySound("UChatScrollButton"); end)
	
	-- Hook the character frame and hide/show with the char frame
	PaperDollFrame:HookScript("OnShow", function() StatPointUI.mainFrame:Show() end)
	PaperDollFrame:HookScript("OnHide", function() StatPointUI.mainFrame:Hide() end)
end

function OnCacheReceived(sender, argTable)
	StatPointUI.cache = argTable[1]
	local rowContent = {"Strength", "Agility", "Stamina", "Intellect", "Spirit"}
	for i = 1, 5 do
		StatPointUI[rowContent[i]].Val:SetText(StatPointUI.cache[i])
		
		-- If a point has been spent in the stat row, set color to green, otherwise white
		if(StatPointUI.cache[i] > 0) then
			StatPointUI[rowContent[i]].Val:SetTextColor(0,1,0,1)
		else
			StatPointUI[rowContent[i]].Val:SetTextColor(1,1,1,1)
		end
		
		-- Disable buttons if the player has no more stats to spend
		if(StatPointUI.cache[6] > 0) then
			StatPointUI[rowContent[i]].Button:EnableMouse(true)
			StatPointUI[rowContent[i]].Button:Enable()
		else
			StatPointUI[rowContent[i]].Button:EnableMouse(false)
			StatPointUI[rowContent[i]].Button:Disable()
		end
	end
	
	StatPointUI.pointsLeftVal:SetText(StatPointUI.cache[6])
end

RegisterServerResponses(config)

-- Event frame to trigger cache request on both login and reload
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LOGIN")
EventFrame:SetScript("OnEvent", function() StatPointUI.OnLogin() end)