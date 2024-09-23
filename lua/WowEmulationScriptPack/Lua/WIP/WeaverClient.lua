local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local WeaverHandlers = AIO.AddHandlers("Weaver", {})


local current_weavers = 0
local max_weavers = 0

-- mainframe
local GuildMasterWeaverMenu = CreateFrame("Frame", "GMWeaverMenu", UIParent, "UIPanelDialogTemplate")
GuildMasterWeaverMenu:SetSize(300, 300)
GuildMasterWeaverMenu:SetMovable(true)
GuildMasterWeaverMenu:EnableMouse(true)
GuildMasterWeaverMenu:SetToplevel(true)
GuildMasterWeaverMenu:RegisterForDrag("LeftButton")
GuildMasterWeaverMenu:SetPoint("CENTER")
GuildMasterWeaverMenu:SetScript("OnDragStart", GuildMasterWeaverMenu.StartMoving)
GuildMasterWeaverMenu:SetScript("OnHide", GuildMasterWeaverMenu.StopMovingOrSizing)
GuildMasterWeaverMenu:SetScript("OnDragStop", GuildMasterWeaverMenu.StopMovingOrSizing)
GuildMasterWeaverMenu:SetScript("OnShow", function() PlaySound("igCharacterInfoTab") end)
GuildMasterWeaverMenu:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") end)
AIO.SavePosition(GuildMasterWeaverMenu)
GuildMasterWeaverMenu:SetClampedToScreen(true)
GuildMasterWeaverMenu:Hide()
local GuildMasterWeaverMenu_Text1 = GuildMasterWeaverMenu:CreateFontString("GuildMasterWeaverMenu_Text1")
GuildMasterWeaverMenu_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
GuildMasterWeaverMenu_Text1:SetSize(190, 5)
GuildMasterWeaverMenu_Text1:SetPoint("CENTER", -10, 135)
GuildMasterWeaverMenu_Text1:SetText("Guild Master Panel")

--name input box
local WeaverMenu_EditBox = CreateFrame("EditBox", "WeaverInput", GuildMasterWeaverMenu, "InputBoxTemplate")
WeaverMenu_EditBox:SetSize(125, 75)
WeaverMenu_EditBox:SetAutoFocus(false)
WeaverMenu_EditBox:SetPoint("LEFT", 30, 90)
WeaverMenu_EditBox:SetScript("OnEnterPressed", WeaverMenu_EditBox.ClearFocus)
WeaverMenu_EditBox:SetScript("OnEscapePressed", WeaverMenu_EditBox.ClearFocus)
local WeaverMenu_EditBox_Text1 = WeaverMenu_EditBox:CreateFontString("WeaverMenu_EditBox_Text1")
WeaverMenu_EditBox_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
WeaverMenu_EditBox_Text1:SetSize(190, 5)
WeaverMenu_EditBox_Text1:SetPoint("RIGHT", 12, 20)
WeaverMenu_EditBox_Text1:SetText("Character Name")

-- "Weavers: ()" text
local WeaverMenu_Available_Text = GuildMasterWeaverMenu:CreateFontString("WeaverMenu_EditBox_Text1")
WeaverMenu_Available_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
WeaverMenu_Available_Text:SetSize(190, 5)
WeaverMenu_Available_Text:SetPoint("LEFT", -30, 65)
WeaverMenu_Available_Text:SetText("|cffFFFF00Weavers: (" ..current_weavers.. "/" ..max_weavers.. ")|r")

-- appoint!
local WeaverMenu_Button_Appoint = CreateFrame("Button", "Button_Appoint", GuildMasterWeaverMenu, "UIPanelButtonTemplate")
WeaverMenu_Button_Appoint:SetPoint("TOPRIGHT", "GMWeaverMenu", "TOPRIGHT", -30, -50)
WeaverMenu_Button_Appoint:EnableMouse(true)
WeaverMenu_Button_Appoint:SetSize(100, 23)
WeaverMenu_Button_Appoint:SetText("Appoint!")


-- appoint! function
WeaverMenu_Button_Appoint:SetScript("OnMouseUp", function() 
	editbox = WeaverMenu_EditBox:GetText()
	if editbox == nil or editbox == "" then
		print("You must enter a name.")
	else
		POPUP_WEAVER(editbox)
	end
end)

-- confirm appointing weaver
function POPUP_WEAVER(editbox)
	StaticPopupDialogs["CONFIRM_WEAVER"] = {
	  text = "Are you sure you want to appoint " ..editbox.. " as a weaver?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		AIO.Handle("Weaver", "WeaverConfirm", editbox)
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_WEAVER")
end

-- confirm demoting weaver
function POPUP_DEMOTE(editbox)
	StaticPopupDialogs["CONFIRM_DEMOTE"] = {
	  text = "This player is already a weaver appointed by you. Are you sure you want to demote " ..editbox.. " as a weaver?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		AIO.Handle("Weaver", "WeaverDemote", editbox)
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_DEMOTE")
end

-- demoting weaver receving function
function WeaverHandlers.ConfirmDemote()
	editbox = WeaverMenu_EditBox:GetText()
	if editbox == nil or editbox == "" then
		print("You must enter a name.")
	else
		POPUP_DEMOTE(editbox)
	end
end

-- text updater for weavers available
function WeaverHandlers.UpdateText(player, current_weavers, max_weavers)
	WeaverMenu_Available_Text:SetText("|cffFFFF00Weavers: (" ..current_weavers.. "/" ..max_weavers.. ")|r")
end

test_array = {
	"Niggerman",
	"H.P LoveCraft"
}



local weavernames_subcontainer = {}

function MakeWeaverNames()
	for x=1,#test_array,1 do
		_G[WeaverMenu_Available_Text[x]] = GuildMasterWeaverMenu:CreateFontString("WeaverMenu_EditBox_Text1")
		WeaverMenu_Available_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
		WeaverMenu_Available_Text:SetSize(190, 5)
		WeaverMenu_Available_Text:SetPoint("CENTER", 0, 70)
		WeaverMenu_Available_Text:SetText("|cffFFFF00Weavers: (" ..current_weavers.. "/" ..max_weavers.. ")|r")
	end
end


function WeaverHandlers.ShowGuildMasterWeaverMenu(player, current_weavers, max_weavers)
	WeaverMenu_Available_Text:SetText("|cffFFFF00Weavers: (" ..current_weavers.. "/" ..max_weavers.. ")|r")
	GuildMasterWeaverMenu:Show()
end