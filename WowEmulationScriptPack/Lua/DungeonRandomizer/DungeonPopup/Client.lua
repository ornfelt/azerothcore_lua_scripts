local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

local MyHandlers = AIO.AddHandlers("DungeonBuffHander", {})

local function createFrame()
	frame:SetSize(150, 210)
	frame:RegisterForDrag("LeftButton")
	frame:SetPoint("CENTER")
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame.text = frame:CreateFontString(nil,"ARTWORK") 
	frame.text:SetFont("Fonts\\ARIALN.ttf", 12, "OUTLINE")
	frame.text:SetPoint("TOP",-10,-10)
	frame.text:SetText("Choose Your Reward!")
	frame:Hide()
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnHide", frame.StopMovingOrSizing)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	AIO.SavePosition(frame)

end

local function makeAllButtons()
	setupButton(CreateFrame("Button", nil, frame),"Health+",1,1)
	setupButton(CreateFrame("Button", nil, frame),"Speed+",2,2)
	setupButton(CreateFrame("Button", nil, frame),"Augment!",3,3)
	setupButton(CreateFrame("Button", nil, frame),"Loot!",4,4)
end

local function setupButton(btn,text,argValue,btnNum)
	btn:SetSize(110, 35)
	btn:SetPoint("TOP", frame, "TOP",0,(-38*btnNum))
	local fontstring = btn:CreateFontString("FontTest")
		fontstring:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		fontstring:SetShadowOffset(1, -1)
		fontstring:SetTextColor(1, 0.8, 0)
	btn:SetFontString(fontstring)
	btn:SetText(text)
	setButtonTextures(btn)
	btn:SetScript("OnClick", function() AIO.Handle("DungeonBuffHander", "onClickButton", argValue) end)
	table.insert(allButtons,btn)
end

local function setButtonTextures(btn)
	local ntex = btn:CreateTexture()
		ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
		ntex:SetTexCoord(0, 0.625, 0, 0.6875)
		ntex:SetAllPoints()	
		btn:SetNormalTexture(ntex)
	local htex = btn:CreateTexture()
		htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
		htex:SetTexCoord(0, 0.625, 0, 0.6875)
		htex:SetAllPoints()
		btn:SetHighlightTexture(htex)
	local ptex = btn:CreateTexture()
		ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
		ptex:SetTexCoord(0, 0.625, 0, 0.6875)
		ptex:SetAllPoints()
		btn:SetPushedTexture(ptex)
end

function MyHandlers.ShowFrame(player)
    frame:Show()
end

function MyHandlers.HideFrame(player)
    frame:Hide()
end

function MyHandlers.RemoveButtons(player)
	for i,v in pairs(allButtons) do
		v:Hide()
	end
	allButtons = {}
end

function MyHandlers.MakeButtons(player)
    makeAllButtons()
end

allButtons = {}
frame = CreateFrame("Frame", "DungLooterFrame", UIParent, "UIPanelDialogTemplate")
createFrame()