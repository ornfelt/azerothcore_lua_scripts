local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local DeathHandlers = AIO.AddHandlers("DeathStuff", {})

local DeathMain = CreateFrame("Frame", "FrameDeathMain", UIParent, "UIPanelDialogTemplate")
DeathMain:SetSize(150, 165)
DeathMain:SetMovable(true)
DeathMain:EnableMouse(true)
DeathMain:SetToplevel(true)
DeathMain:RegisterForDrag("LeftButton")
DeathMain:SetPoint("CENTER")
DeathMain:SetScript("OnDragStart", DeathMain.StartMoving)
DeathMain:SetScript("OnHide", DeathMain.StopMovingOrSizing)
DeathMain:SetScript("OnDragStop", DeathMain.StopMovingOrSizing)
DeathMain:SetScript("OnShow", function() PlaySound("igCharacterInfoTab") end)
DeathMain:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") end)
AIO.SavePosition(DeathMain)
DeathMain:SetClampedToScreen(true)
DeathMain:Hide()
local DeathMain_Text1 = DeathMain:CreateFontString("DeathMain_Text1")
DeathMain_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
DeathMain_Text1:SetSize(190, 5)
DeathMain_Text1:SetPoint("TOP", 0, -13)
DeathMain_Text1:SetText("Injury UI")

--empty frame to listen to when to open based on target change
local DeathListen = CreateFrame("Frame", "ListenDeath", UIParent, nil)
DeathListen:SetSize(1, 1)
DeathListen:SetMovable(false)
DeathListen:EnableMouse(false)
DeathListen:SetPoint("BOTTOMLEFT", 1, 1)
DeathListen:RegisterEvent("PLAYER_TARGET_CHANGED")
DeathListen:SetScript("OnEvent", function(event)
local death_stun = UnitAura("target", "Death Stun", nil, "HARMFUL")
local stealth = UnitAura("player", "Stealth")
local combat = UnitAffectingCombat("player")
	-- check if unit in stealth, combat, and death_stunned
	if (stealth ~= nil) then
		DeathMain:Hide()
		return false
	elseif (combat ~= nil) then
		DeathMain:Hide()
		return false
	elseif (death_stun == nil) then
		DeathMain:Hide()
		return false
	else
		DeathMain:Show()
	end
end)
DeathListen:Show()

--empty frame to listen to when to open based on combat update
local DeathListen2 = CreateFrame("Frame", "ListenDeath2", UIParent, nil)
DeathListen2:SetSize(1, 1)
DeathListen2:SetMovable(false)
DeathListen2:EnableMouse(false)
DeathListen2:SetPoint("BOTTOMLEFT", 1, 1)
DeathListen2:RegisterEvent("UNIT_AURA")
DeathListen2:SetScript("OnEvent", function(event)
local death_stun = UnitAura("target", "Death Stun", nil, "HARMFUL")
local stealth = UnitAura("player", "Stealth")
	-- check if unit in stealth, and death_stunned
	if (stealth ~= nil) then
		DeathMain:Hide()
		return false
	elseif (death_stun == nil) then
		DeathMain:Hide()
		return false
	else
		DeathMain:Show()
	end
end)
DeathListen2:Show()


-- confirmation menus
function POPUP_EXECUTE()
	StaticPopupDialogs["CONFIRM_EXECUTE"] = {
	  text = "You are about to execute " ..UnitName("target").. ", doing so will send this player to their death and end their journey. Are you sure you want to continue?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		action = "executed"
		AIO.Handle("DeathStuff", "ExecuteConfirm", action)
		DeathMain:Hide()
	  end,
	  OnDecline = function()
		  DeathMain:Hide()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_EXECUTE")
end

function POPUP_FREE()
	StaticPopupDialogs["CONFIRM_FREE"] = {
	  text = "You are about to free " ..UnitName("target").. ", doing so will make the player wake up. Are you sure you want to continue?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		action = "freed"
		AIO.Handle("DeathStuff", "ExecuteConfirm", action)
		DeathMain:Hide()
	  end,
	  OnDecline = function()
		  DeathMain:Hide()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_FREE")
end

function DeathHandlers.POPUP_STEAL(player, gold_amount, silver_amount, copper_amount)
	StaticPopupDialogs["CONFIRM_STEAL"] = {
	  text = "You are about to steal from " ..UnitName("target").. ", doing so will give you " ..gold_amount.. " gold, " ..silver_amount.. " silver, " ..copper_amount.. " copper. Are you sure you want to continue?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		action = "stole"
		AIO.Handle("DeathStuff", "ExecuteConfirm", action)
		DeathMain:Hide()
	  end,
	  OnDecline = function()
		  DeathMain:Hide()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_STEAL")
end

function DeathHandlers.POPUP_SVALNA(player, token_amount)
	StaticPopupDialogs["CONFIRM_SVALNA"] = {
	  text = "You are about to submit yourself to the realm of death. Doing so will create " ..token_amount.. " gear tokens for your next character. Continue?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		AIO.Handle("DeathStuff", "SvalnaConfirm")
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_SVALNA")
end

-- buttons
local DeathButton1 = CreateFrame("Button", "ButtonDeath1", DeathMain, "UIPanelButtonTemplate")
DeathButton1:SetPoint("TOP", 0, -35)
DeathButton1:EnableMouse(true)
DeathButton1:SetSize(125, 30)
DeathButton1:SetText("Execute")
DeathButton1:SetScript("OnMouseUp", function() PlaySound("GAMEDIALOGOPEN", "SFX") POPUP_EXECUTE() end)
local DeathButton2 = CreateFrame("Button", "ButtonDeath2", DeathMain, "UIPanelButtonTemplate")
DeathButton2:SetPoint("TOP", 0, -75)
DeathButton2:EnableMouse(true)
DeathButton2:SetSize(125, 30)
DeathButton2:SetText("Free")
DeathButton2:SetScript("OnMouseUp", function() PlaySound("GAMEDIALOGOPEN", "SFX") POPUP_FREE() end)
local DeathButton3 = CreateFrame("Button", "ButtonDeath3", DeathMain, "UIPanelButtonTemplate")
DeathButton3:SetPoint("TOP", 0, -115)
DeathButton3:EnableMouse(true)
DeathButton3:SetSize(125, 30)
DeathButton3:SetText("Steal")
DeathButton3:SetScript("OnMouseUp", function() PlaySound("GAMEDIALOGOPEN", "SFX") AIO.Handle("DeathStuff", "StealGetInfo") end)

-- aio recieved functions
function DeathHandlers.TakeScreenShot(player)
	print("|cffFF0000[Death System]|r: Screenshot taken.")
    Screenshot()
end