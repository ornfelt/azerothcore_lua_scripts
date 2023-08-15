local AIO = AIO or require("AIO")
-- local ShopClient = ShopClient or require("ShopClient")

if AIO.AddAddon() then
	return
end

local ToolBarHandlers = AIO.AddHandlers("ToolBar", {})
-- we have 2 separate handlers because we must embed into shopserver.lua, and rotateobjectserver.lua
local ToolBarHandlers2 = AIO.AddHandlers("ToolBar2", {})
local ToolBarHandlers3 = AIO.AddHandlers("ToolBar3", {})
local ToolBarHandlers4 = AIO.AddHandlers("ToolBar4", {})

-- TOOLBAR CLIENT SIDE
-- SHOWS shop, apt rotation, and guild management buttons.

local ToolBarFrame = CreateFrame("Frame", "ToolBarFrame", UIParent)
ToolBarFrame:SetSize(95, 55)
ToolBarFrame:SetMovable(true)
ToolBarFrame:EnableMouse(true)
ToolBarFrame:RegisterForDrag("LeftButton")
ToolBarFrame:SetPoint("CENTER")
ToolBarFrame:SetBackdrop(
{
    bgFile = "Interface/AchievementFrame/UI-Achievement-Parchment-Horizontal-Desaturated.blp",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    edgeSize = 20,
    insets = { left = 5, right = 5, top = 5, bottom = 5 }
})
ToolBarFrame:SetScript("OnDragStart", ToolBarFrame.StartMoving)
ToolBarFrame:SetScript("OnHide", ToolBarFrame.StopMovingOrSizing)
ToolBarFrame:SetScript("OnDragStop", ToolBarFrame.StopMovingOrSizing)
ToolBarFrame:SetClampedToScreen(true)

local ShopButton = CreateFrame("Button", "ShopButtonFrame", ToolBarFrame, nil)
ShopButton:SetPoint("CENTER", -20, 0)
ShopButton:EnableMouse(true)
ShopButton:SetSize(30, 30)
ShopButton:SetNormalTexture("Interface/images/shop_normal.blp")
ShopButton:SetHighlightTexture("Interface/images/shop_hover.blp")
ShopButton:SetPushedTexture("Interface/images/shop_pressed.blp")
ShopButton:SetScript("OnMouseUp", function() AIO.Handle("ToolBar", "ShowShopUI") end)
ShopButton:SetScript("OnEnter", function() GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT", 0, 200) GameTooltip:SetText("Shop\n|cffFFFFFFClick to open the Shop. This is where you can purchase cosmetics, stat gear, APTs, and much more!|r" , nil, nil, nil, 1, true) end)
ShopButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

local APTRotateButton = CreateFrame("Button", "APTRotateButtonFrame", ToolBarFrame, nil)
APTRotateButton:SetPoint("CENTER", 20, 0)
APTRotateButton:EnableMouse(true)
APTRotateButton:SetSize(30, 30)
APTRotateButton:SetNormalTexture("Interface/images/head_normal.blp")
APTRotateButton:SetHighlightTexture("Interface/images/head_hover.blp")
APTRotateButton:SetPushedTexture("Interface/images/head_pressed.blp")
APTRotateButton:SetScript("OnMouseUp", function() AIO.Handle("ToolBar2", "ShowRotateUI") end)
APTRotateButton:SetScript("OnEnter", function() GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT", 0, 200) GameTooltip:SetText("APT Rotational Tool\n|cffFFFFFFClick to open the Rotational Tool. This is where you can rotate and control your APT. Use command, .gob tar, to get the GUID of your APT.|r" , nil, nil, nil, 1, true) end)
APTRotateButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

function ToolBarHandlers4.ShowGuildMasterButton(player)
-- the gm button is fucked so weve got some really messed up points here
	local GuildMasterButton = CreateFrame("Button", "GuildMasterButton", ToolBarFrame, nil)
	GuildMasterButton:SetPoint("CENTER", 40, 9)
	GuildMasterButton:EnableMouse(true)
	GuildMasterButton:SetSize(37, 51)
	GuildMasterButton:SetNormalTexture("Interface/images/gm_normal.blp")
	GuildMasterButton:SetHighlightTexture("Interface/images/gm_hover.blp")
	GuildMasterButton:SetPushedTexture("Interface/images/gm_pressed.blp")
	GuildMasterButton:SetScript("OnMouseUp", function() AIO.Handle("ToolBar4", "ShowGuildMasterWeaverPanel") end)
	GuildMasterButton:SetScript("OnEnter", function() GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT", 0, 200) GameTooltip:SetText("Guild Master Panel\n|cffFFFFFFClick to open the Guild Master Panel. As a guild master, you can appoint weavers to run events for your guild.|r" , nil, nil, nil, 1, true) end)
	GuildMasterButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	ToolBarFrame:SetSize(135, 55)
	ShopButton:SetPoint("CENTER", -40, 0)
	APTRotateButton:SetPoint("CENTER", 0, 0)
end

--ToolBarHandlers4.ShowGuildMasterButton()
AIO.SavePosition(ToolBarFrame)
ToolBarFrame:Hide()

function ToolBarHandlers3.ShowToolBar(player)
	ToolBarFrame:Show()
end


-- if a weaver leaves, demote them. we use the toolbar frame because it is always showing.
-- ToolBarFrame:RegisterEvent("PLAYER_GUILD_UPDATE")
-- leave = 0
-- ToolBarFrame:SetScript("OnEvent", function() if leave == 0 then AIO.Handle("ToolBar4", "LeaverWeaver") leave = 1 else leave = 0 end end)
