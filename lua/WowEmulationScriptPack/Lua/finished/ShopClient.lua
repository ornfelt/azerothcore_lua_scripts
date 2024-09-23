-- Owner: grimreapaa

local AIO = AIO or require("AIO")

-- checks if client or not
if AIO.AddAddon() then
	return
end

local ShopHandlers = AIO.AddHandlers("Shop", {})

local ShopButtonFrame = CreateFrame("Frame", nil, UIParent)

--backdrop frame for shop
local ShopMain = CreateFrame("Frame", "FrameShopMain", UIParent, "UIPanelDialogTemplate")
ShopMain:SetSize(500, 550)
ShopMain:SetMovable(true)
ShopMain:EnableMouse(true)
ShopMain:SetToplevel(true)
ShopMain:RegisterForDrag("LeftButton")
ShopMain:SetPoint("CENTER")
ShopMain:SetScript("OnDragStart", ShopMain.StartMoving)
ShopMain:SetScript("OnHide", ShopMain.StopMovingOrSizing)
ShopMain:SetScript("OnDragStop", ShopMain.StopMovingOrSizing)
ShopMain:SetScript("OnShow", function() PlaySound("igCharacterInfoTab") end)
--ShopMain:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") end)
AIO.SavePosition(ShopMain)
ShopMain:SetClampedToScreen(true)
local ShopMain_Text1 = ShopMain:CreateFontString("ShopMain_Text1")
ShopMain_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
ShopMain_Text1:SetSize(190, 5)
ShopMain_Text1:SetPoint("CENTER", "FrameShopMain", "TOP", 0, -15)
ShopMain_Text1:SetText("Walmart of Ember")


-- Create the DropDown_Type, and configure its appearance
local DropDown_Type = CreateFrame("FRAME", "WPDemoDropDown", ShopMain, "UIDropDownMenuTemplate")
DropDown_Type:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 10, -60)
UIDropDownMenu_SetWidth(DropDown_Type, 130)
UIDropDownMenu_SetText(DropDown_Type, "Item Type")
UIDropDownMenu_JustifyText(DropDown_Type, "LEFT") 
local DropDown_Type_text = ShopMain:CreateFontString("DropDown_Type_text")
DropDown_Type_text:SetFont("Fonts\\FRIZQT__.TTF", 10)
DropDown_Type_text:SetSize(190, 5)
DropDown_Type_text:SetPoint("CENTER", "WPDemoDropDown", "TOP", 0, 15)
DropDown_Type_text:SetText("Filter by item type")

--min drop down
local DropDown_Price_Min = CreateFrame("FRAME", "Price_DropDown_Min", ShopMain, "UIDropDownMenuTemplate")
DropDown_Price_Min:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 175, -60)
UIDropDownMenu_SetWidth(DropDown_Price_Min, 40)
UIDropDownMenu_SetText(DropDown_Price_Min, "...")
local DropDown_Price_Min_text = ShopMain:CreateFontString("DropDown_Price_Min_text")
DropDown_Price_Min_text:SetFont("Fonts\\FRIZQT__.TTF", 10)
DropDown_Price_Min_text:SetSize(190, 5)
DropDown_Price_Min_text:SetPoint("CENTER", "Price_DropDown_Min", "TOP", 35, 15)
DropDown_Price_Min_text:SetText("Min/Max cost")
--max dropdown
local DropDown_Price_Max = CreateFrame("FRAME", "Price_DropDown_Max", ShopMain, "UIDropDownMenuTemplate")
DropDown_Price_Max:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 235, -60)
UIDropDownMenu_SetWidth(DropDown_Price_Max, 40)
UIDropDownMenu_SetText(DropDown_Price_Max, "...")

--cost_type dropdown
local DropDown_Price_Item = CreateFrame("FRAME", "DropDown_Price_Item", ShopMain, "UIDropDownMenuTemplate")
DropDown_Price_Item:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 310, -60)
UIDropDownMenu_SetWidth(DropDown_Price_Item, 130)
UIDropDownMenu_SetText(DropDown_Price_Item, "Item Cost")
local DropDown_Price_Item_text = ShopMain:CreateFontString("DropDown_Price_Item_text")
DropDown_Price_Item_text:SetFont("Fonts\\FRIZQT__.TTF", 10)
DropDown_Price_Item_text:SetSize(190, 5)
DropDown_Price_Item_text:SetPoint("CENTER", "DropDown_Price_Item", "TOP", 0, 15)
DropDown_Price_Item_text:SetText("Filter by currency")


--name filter editbox
local ShopFilter_Name = CreateFrame("EditBox", "Filter_Name", ShopMain, "InputBoxTemplate")
ShopFilter_Name:SetSize(135, 50)
ShopFilter_Name:SetAutoFocus(false)
ShopFilter_Name:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 35, -110)
ShopFilter_Name:SetScript("OnEnterPressed", ShopFilter_Name.ClearFocus)
ShopFilter_Name:SetScript("OnEscapePressed", ShopFilter_Name.ClearFocus)
local ShopFilter_Name_text = ShopMain:CreateFontString("ShopFilter_Name_text")
ShopFilter_Name_text:SetFont("Fonts\\FRIZQT__.TTF", 10)
ShopFilter_Name_text:SetSize(190, 5)
ShopFilter_Name_text:SetPoint("CENTER", "Filter_Name", "TOP", 0, 0)
ShopFilter_Name_text:SetText("Filter by name")

--search!
local ShopMain_Button_Search = CreateFrame("Button", "Button_Search", ShopMain, "UIPanelButtonTemplate")
ShopMain_Button_Search:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 370, -123)
ShopMain_Button_Search:EnableMouse(true)
ShopMain_Button_Search:SetSize(100, 25)
ShopMain_Button_Search:SetText("Search!")

--results container frame BEGIN
local ShopMain_Results = CreateFrame("ScrollFrame", "FrameShopMain_Results", ShopMain, nil)
ShopMain_Results:SetSize(450, 350)
ShopMain_Results:EnableMouse(false)
ShopMain_Results:SetToplevel(false)
ShopMain_Results:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 25, -175)
ShopMain_Results:SetBackdrop({
	bgFile="Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results:SetBackdropColor(0.37,0,0,0.5)
ShopMain_Results:SetBackdropBorderColor(1,0.82,0,1)

--results textframes (this is where we set item, cost, and purchase, columns
local ShopMain_Results_TextFrame1 = CreateFrame("Frame", "FrameShopMain_Results_TextFrame1", ShopMain_Results, nil)
ShopMain_Results_TextFrame1:SetSize(300, 25)
ShopMain_Results_TextFrame1:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 0, 0)
ShopMain_Results_TextFrame1:SetBackdrop({
	bgFile=nil,
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results_TextFrame1:SetBackdropBorderColor(1,0.82,0,1)
local ShopMain_Results_TextFrame1_Text = ShopMain_Results_TextFrame1:CreateFontString("FrameShopMain_Results_TextFrame1_Text")
ShopMain_Results_TextFrame1_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
ShopMain_Results_TextFrame1_Text:SetSize(190, 5)
ShopMain_Results_TextFrame1_Text:SetPoint("CENTER", "FrameShopMain_Results_TextFrame1", "CENTER", 0, 0)
ShopMain_Results_TextFrame1_Text:SetText("|cffFFD100Item Name|r")



local ShopMain_Results_TextFrame2 = CreateFrame("Frame", "FrameShopMain_Results_TextFrame2", ShopMain_Results, nil)
ShopMain_Results_TextFrame2:SetSize(50, 25)
ShopMain_Results_TextFrame2:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 298, 0)
ShopMain_Results_TextFrame2:SetBackdrop({
	bgFile=nil,
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results_TextFrame2:SetBackdropBorderColor(1,0.82,0,1)
local ShopMain_Results_TextFrame2_Text = ShopMain_Results:CreateFontString("FrameShopMain_Results_TextFrame2_Text")
ShopMain_Results_TextFrame2_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
ShopMain_Results_TextFrame2_Text:SetSize(190, 5)
ShopMain_Results_TextFrame2_Text:SetPoint("CENTER", "FrameShopMain_Results_TextFrame2", "CENTER", 0, 0)
ShopMain_Results_TextFrame2_Text:SetText("|cffFFD100Cost|r")


local ShopMain_Results_TextFrame3 = CreateFrame("Frame", "FrameShopMain_Results_TextFrame3", ShopMain_Results, nil)
ShopMain_Results_TextFrame3:SetSize(104, 25)
ShopMain_Results_TextFrame3:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 346, 0)
ShopMain_Results_TextFrame3:SetBackdrop({
	bgFile=nil,
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results_TextFrame3:SetBackdropBorderColor(1,0.82,0,1)
local ShopMain_Results_TextFrame3_Text = ShopMain_Results:CreateFontString("ShopMain_Results_TextFrame3_Text")
ShopMain_Results_TextFrame3_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
ShopMain_Results_TextFrame3_Text:SetSize(190, 5)
ShopMain_Results_TextFrame3_Text:SetPoint("CENTER", "FrameShopMain_Results_TextFrame3", "CENTER", 0, 0)
ShopMain_Results_TextFrame3_Text:SetText("|cffFFD100Purchase|r")

-- CONTAINER FOR ITEM_NAME RESULTS COLUMN
local ShopMain_Results_TextFrame4 = CreateFrame("Frame", "FrameShopMain_Results_TextFrame4", ShopMain_Results, nil)
ShopMain_Results_TextFrame4:SetSize(300, 350)
ShopMain_Results_TextFrame4:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 0, 0)
ShopMain_Results_TextFrame4:SetBackdrop({
	bgFile=nil,
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results_TextFrame4:SetBackdropBorderColor(1,0.82,0,1)

-- test text for item result, should be commented unless testing


-- all of this below is needed to generate item_name results for container. comment out unless testing.
--[[
local ShopMain_Results_TextFrame4_SubContainer1 = CreateFrame("Button", "ShopMain_Results_TextFrame4_SubContainer1", ShopMain_Results, nil)
ShopMain_Results_TextFrame4_SubContainer1:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight.blp")
ShopMain_Results_TextFrame4_SubContainer1:SetSize(300, 25)
ShopMain_Results_TextFrame4_SubContainer1:SetPoint("TOPLEFT", "FrameShopMain_Results_TextFrame4", "TOPLEFT", 0, -25)
ShopMain_Results_TextFrame4_SubContainer1:EnableMouse(true)
ShopMain_Results_TextFrame4_SubContainer1:SetToplevel(true)
local item_name, item_link, item_quality, _, _, _, _, _, _, item_icon = GetItemInfo("item:18832:2564:0:0:0:0:0:0:80:0:0:0:0")
ShopMain_Results_TextFrame4_SubContainer1:SetScript("OnEnter", function() 
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetHyperlink(item_link)
            GameTooltip:Show()
end)
ShopMain_Results_TextFrame4_SubContainer1:SetScript("OnLeave", function() 
	GameTooltip:Hide()
end)

local ShopMain_Results_TextFrame4_SubContainer1_Icon1 = CreateFrame("Frame", "ShopMain_Results_TextFrame4_SubContainer1_Icon1", ShopMain_Results_TextFrame4_SubContainer1, nil)
ShopMain_Results_TextFrame4_SubContainer1_Icon1:SetSize(25, 25)
ShopMain_Results_TextFrame4_SubContainer1_Icon1:SetPoint("CENTER", "ShopMain_Results_TextFrame4_SubContainer1", "LEFT", 20, 0)
ShopMain_Results_TextFrame4_SubContainer1_Icon1:SetToplevel(true)
ShopMain_Results_TextFrame4_SubContainer1_Icon1:SetBackdrop({
	bgFile=item_icon,
	edgeFile=nil,
	tile=false,
	tileSize=5,
	edgeSize=0,
})


local ShopMain_Results_TextFrame4_Text1 = ShopMain_Results_TextFrame4_SubContainer1:CreateFontString("ShopMain_Results_TextFrame4_Text1")
ShopMain_Results_TextFrame4_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
ShopMain_Results_TextFrame4_Text1:SetSize(250, 5)
ShopMain_Results_TextFrame4_Text1:SetPoint("LEFT", "ShopMain_Results_TextFrame4_SubContainer1", "LEFT", 40, 0) -- this is where all looped rows should start
ShopMain_Results_TextFrame4_Text1:SetText(item_name)
ShopMain_Results_TextFrame4_Text1:SetJustifyH("LEFT")

-- duplicate copy for example of loops

local ShopMain_Results_TextFrame4_SubContainer2 = CreateFrame("Button", "ShopMain_Results_TextFrame4_SubContainer2", ShopMain_Results, nil)
ShopMain_Results_TextFrame4_SubContainer2:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight.blp")
ShopMain_Results_TextFrame4_SubContainer2:SetSize(300, 25)
ShopMain_Results_TextFrame4_SubContainer2:SetPoint("TOPLEFT", "FrameShopMain_Results_TextFrame4", "TOPLEFT", 0, -55)
ShopMain_Results_TextFrame4_SubContainer2:EnableMouse(true)
ShopMain_Results_TextFrame4_SubContainer2:SetToplevel(true)
local item_name, item_link, item_quality, _, _, _, _, _, _, item_icon = GetItemInfo("item:18832:2564:0:0:0:0:0:0:80:0:0:0:0")
ShopMain_Results_TextFrame4_SubContainer2:SetScript("OnEnter", function() 
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetHyperlink(item_link)
            GameTooltip:Show()
end)
ShopMain_Results_TextFrame4_SubContainer2:SetScript("OnLeave", function() 
	GameTooltip:Hide()
end)

local ShopMain_Results_TextFrame4_SubContainer1_Icon2 = CreateFrame("Frame", "ShopMain_Results_TextFrame4_SubContainer1_Icon2", ShopMain_Results_TextFrame4_SubContainer2, nil)
ShopMain_Results_TextFrame4_SubContainer1_Icon2:SetSize(25, 25)
ShopMain_Results_TextFrame4_SubContainer1_Icon2:SetPoint("CENTER", "ShopMain_Results_TextFrame4_SubContainer2", "LEFT", 20, 0)
ShopMain_Results_TextFrame4_SubContainer1_Icon2:SetToplevel(true)
ShopMain_Results_TextFrame4_SubContainer1_Icon2:SetBackdrop({
	bgFile=item_icon,
	edgeFile=nil,
	tile=false,
	tileSize=5,
	edgeSize=0,
})


local ShopMain_Results_TextFrame4_Text2 = ShopMain_Results_TextFrame4_SubContainer2:CreateFontString("ShopMain_Results_TextFrame4_Text2")
ShopMain_Results_TextFrame4_Text2:SetFont("Fonts\\FRIZQT__.TTF", 12)
ShopMain_Results_TextFrame4_Text2:SetSize(250, 5)
ShopMain_Results_TextFrame4_Text2:SetPoint("LEFT", "ShopMain_Results_TextFrame4_SubContainer2", "LEFT", 40, 0) -- this is where all looped rows should start
ShopMain_Results_TextFrame4_Text2:SetText(item_name)
ShopMain_Results_TextFrame4_Text2:SetJustifyH("LEFT")
]]

--end results for item_name container



-- CONTAINER FOR COST RESULTS COLUMN
local ShopMain_Results_TextFrame5 = CreateFrame("Frame", "FrameShopMain_Results_TextFrame5", ShopMain_Results, nil)
ShopMain_Results_TextFrame5:SetSize(50, 350)
ShopMain_Results_TextFrame5:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 298, 0)
ShopMain_Results_TextFrame5:SetBackdrop({
	bgFile=nil,
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results_TextFrame5:SetBackdropBorderColor(1,0.82,0,1)

-- all of this below is needed to generate cost results for container. comment out unless testing.
--[[
local ShopMain_Results_TextFrame5_SubContainer1 = CreateFrame("Button", "ShopMain_Results_TextFrame5_SubContainer1", ShopMain_Results, nil)
ShopMain_Results_TextFrame5_SubContainer1:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight.blp")
ShopMain_Results_TextFrame5_SubContainer1:SetSize(50, 25)
ShopMain_Results_TextFrame5_SubContainer1:SetPoint("TOPLEFT", "FrameShopMain_Results_TextFrame5", "TOPLEFT", 0, -25)
ShopMain_Results_TextFrame5_SubContainer1:EnableMouse(true)
ShopMain_Results_TextFrame5_SubContainer1:SetToplevel(true)
local item_name, item_link, item_quality, _, _, _, _, _, _, item_icon = GetItemInfo("item:18832:2564:0:0:0:0:0:0:80:0:0:0:0")
ShopMain_Results_TextFrame5_SubContainer1:SetScript("OnEnter", function() 
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetHyperlink(item_link)
            GameTooltip:Show()
end)
ShopMain_Results_TextFrame5_SubContainer1:SetScript("OnLeave", function() 
	GameTooltip:Hide()
end)

local ShopMain_Results_TextFrame5_SubContainer1_Icon1 = CreateFrame("Frame", "ShopMain_Results_TextFrame5_SubContainer1_Icon1", ShopMain_Results_TextFrame5_SubContainer1, nil)
ShopMain_Results_TextFrame5_SubContainer1_Icon1:SetSize(25, 25)
ShopMain_Results_TextFrame5_SubContainer1_Icon1:SetPoint("CENTER", "ShopMain_Results_TextFrame5_SubContainer1", "RIGHT", -15, 0)
ShopMain_Results_TextFrame5_SubContainer1_Icon1:SetToplevel(true)
ShopMain_Results_TextFrame5_SubContainer1_Icon1:SetBackdrop({
	bgFile=item_icon,
	edgeFile=nil,
	tile=false,
	tileSize=5,
	edgeSize=0,
})


local ShopMain_Results_TextFrame5_Text1 = ShopMain_Results_TextFrame5_SubContainer1:CreateFontString("ShopMain_Results_TextFrame5_Text1")
ShopMain_Results_TextFrame5_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
ShopMain_Results_TextFrame5_Text1:SetSize(250, 5)
ShopMain_Results_TextFrame5_Text1:SetPoint("LEFT", "ShopMain_Results_TextFrame5_SubContainer1", "LEFT", 2, 0) -- this is where all looped rows should start
ShopMain_Results_TextFrame5_Text1:SetText("10")
ShopMain_Results_TextFrame5_Text1:SetJustifyH("LEFT")
]]

-- CONTAINER FOR PURCHASE COLUMN
local ShopMain_Results_TextFrame6 = CreateFrame("Frame", "FrameShopMain_Results_TextFrame6", ShopMain_Results, nil)
ShopMain_Results_TextFrame6:SetSize(104, 350)
ShopMain_Results_TextFrame6:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 346, 0)
ShopMain_Results_TextFrame6:SetBackdrop({
	bgFile=nil,
	edgeFile="Interface\\ChatFrame\\ChatFrameBackground",
	tile=true,
	tileSize=5,
	edgeSize= 2,
})
ShopMain_Results_TextFrame6:SetBackdropBorderColor(1,0.82,0,1)


-- SCROLLBAR AND THE ACTUAL CONTAINER Frame

local container_frame = CreateFrame("ScrollFrame", "FrameShopMain_Results", ShopMain, nil)
container_frame:SetSize(450, 323)
container_frame:EnableMouse(false)
container_frame:SetToplevel(false)
container_frame:SetPoint("TOPLEFT", "FrameShopMain", "TOPLEFT", 25, -202)

local container_frame2 = CreateFrame("Frame", "container_frame2", ShopMain_Results, nil)
container_frame2:SetSize(450, 323)
container_frame2:SetPoint("TOPLEFT", "FrameShopMain_Results", "TOPLEFT", 0, 0)

scrollbar = CreateFrame("Slider", nil, container_frame, "UIPanelScrollBarTemplate") 
scrollbar:SetPoint("TOPRIGHT", 17, -15) 
scrollbar:SetPoint("BOTTOMRIGHT", 17, 15) 
scrollbar:SetMinMaxValues(1, 2180) 
scrollbar:SetValueStep(1) 
scrollbar:EnableMouse(true)
scrollbar.scrollStep = 1
scrollbar:SetValue(0) 
scrollbar:SetWidth(16) 
scrollbar:SetScript("OnValueChanged", 
function (self, value) 
self:GetParent():SetVerticalScroll(value) 
end) 
local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
scrollbg:SetAllPoints(scrollbar) 
scrollbg:SetTexture(0, 0, 0, 0.4) 
container_frame.scrollbar = scrollbar 
container_frame:SetScrollChild(container_frame2)

-- make scrollwheel work anywhere on ShopMain and adjust scrollbar
ShopMain:EnableMouseWheel(1)
ShopMain:SetScript("OnMouseWheel", function(_, arg1) if arg1 > 0 then scrollbar:SetValue(scrollbar:GetValue() - 15) else scrollbar:SetValue(scrollbar:GetValue() + 15) end end)
 

-- list of items for dropdown_price_item
local item_array_cost = {
--"Copper Coin",
"Silver",
--"Gold Coin",
"Gear Token",
"Starter Token",
"Blacksmith Token",
"Leatherwork Token",
"Tailor Token",
"Alchemy Token",
"Inscription Token",
"Mystic Token",
"First Aid Token",
"Cooking Token",
"Carpenter Token",
"None",
}


-- base menu
local item_type_array_level_0 = {
"PvP Stats", -- pvp -> tier -> slot -> print
"PvE Stats", -- 	
--"Cosmetics", -- -> armor type -> slot -> print
"Head",
"Shoulders",
"Back",
"Chest",
"Shirt",
"Tabard",
"Wrist",
"Hands",
"Waist",
"Legs",
"Feet",
"One-handed Weapon",
"Two-handed Weapon",
"Off-hand",
"Ranged",
"Mounts", -- mounts -> faction/type -> print
"Enchants",
"APT", -- APT -> print
"Crafted"
}

-- 1st tier of nest
local item_type_array_sublevel_0 = {
"Head",
"Necklace",
"Shoulders",
"Back",
"Chest",
"Wrist",
"Hands",
"Waist",
"Legs",
"Feet",
"Finger",
"Trinket",
"One-handed Weapon",
"Two-handed Weapon",
"Shield",
"Off-hand",
"Ranged",
"Relic/Totem/Libram"
}

local item_type_array_sublevel_1 = {
"Head",
"Necklace",
"Shoulders",
"Back",
"Chest",
"Wrist",
"Hands",
"Waist",
"Legs",
"Feet",
"Finger",
"Trinket",
"One-handed Weapon",
"Two-handed Weapon",
"Shield",
"Off-hand",
"Ranged",
"Relic/Totem/Libram"
}

local item_type_array_sublevel_2 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

local item_type_array_sublevel_3 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

-- back
local item_type_array_sublevel_4 = {
}

local item_type_array_sublevel_5 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

-- shirt
local item_type_array_sublevel_6 = {
}

local item_type_array_sublevel_7 = {
}

local item_type_array_sublevel_8 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

local item_type_array_sublevel_9 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

local item_type_array_sublevel_10 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

local item_type_array_sublevel_11 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}

local item_type_array_sublevel_12 = {
"Cloth",
"Leather",
"Mail",
"Plate"
}


-- 1h weapon
local item_type_array_sublevel_13 = {
"Axe",
"Sword",
"Mace",
"Dagger",
"Fist"
}

-- 2h weapon
local item_type_array_sublevel_14 = {
"Axe",
"Sword",
"Mace",
"Staff",
"Polearm"
}

-- off hand
local item_type_array_sublevel_15 = {
"Shield",
"Other"
}

-- ranged
local item_type_array_sublevel_16 = {
"Bow",
"Crossbow",
"Gun",
"Wand",
"Thrown"
}

-- mounts
local item_type_array_sublevel_17 = {
"Alliance",
"Horde",
"Other"
}

-- enchant visuals
local item_type_array_sublevel_18 = {
}

-- apts
local item_type_array_sublevel_19 = {
}

-- crafted
local item_type_array_sublevel_20 = {
}


-- link tier 2 nested arrays
local item_type_link_array = {
item_type_array_sublevel_0,
item_type_array_sublevel_1,
item_type_array_sublevel_2,
item_type_array_sublevel_3,
item_type_array_sublevel_4,
item_type_array_sublevel_5,
item_type_array_sublevel_6,
item_type_array_sublevel_7,
item_type_array_sublevel_8,
item_type_array_sublevel_9,
item_type_array_sublevel_10,
item_type_array_sublevel_11,
item_type_array_sublevel_12,
item_type_array_sublevel_13,
item_type_array_sublevel_14,
item_type_array_sublevel_15,
item_type_array_sublevel_16,
item_type_array_sublevel_17,
item_type_array_sublevel_18,
item_type_array_sublevel_19,
item_type_array_sublevel_20
}
-- Create and bind the initialization function to the DropDown_Type menu
UIDropDownMenu_Initialize(DropDown_Type, function(self, level, menuList)
 local info = UIDropDownMenu_CreateInfo()
 if (level or 1) == 1 then
  -- Display the 0-9, 10-19, ... groups
  for i=1,#item_type_array_level_0,1 do
	new_array = item_type_link_array[i]
	info.func = self.SetValue
	if new_array[1] == nil then
		info.hasArrow = false
		info.arg1 = 100 + i
	else
		info.hasArrow = true
	end
	info.arg1 = 100 + i
	info.text = item_type_array_level_0[i]
	info.menuList = i
	UIDropDownMenu_AddButton(info)
  end

 elseif (level == 2) then
  -- Display a nested group of 10 favorite number options
	info.func = self.SetValue
	for x=0,#item_type_link_array,1 do
		if menuList == x then
			new_array = item_type_link_array[x]
			for z=1,#new_array,1 do
				info.text = new_array[z]
				info.arg1 = 200 + z
				list = z
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
	end
end)

-- this function is called any time a DropDown_Type button is pressed
function DropDown_Type:SetValue(newValue)
	-- if button clicked is main menu, set text = that.
	if ((newValue - 100) > 0) and (newValue - 100 < 99) then
		newValue = newValue - 100
		button_string = item_type_array_level_0[newValue]
	elseif ((newValue - 200) > 0) and (newValue - 200 < 99) then
		newValue = newValue - 200
		button_string = (UIDROPDOWNMENU_MENU_VALUE.. ":" ..new_array[newValue])
	elseif ((newValue - 300) > 0) and (newValue - 300 < 99) then
		newValue = newValue - 300
		button_string = (UIDROPDOWNMENU_MENU_VALUE.. ":" ..new_array[newValue])
	end

	UIDropDownMenu_SetText(DropDown_Type, button_string)
 -- Because this is called from a sub-menu, only that menu level is closed by default. Close the entire menu with this next call
	CloseDropDownMenus()
end


UIDropDownMenu_Initialize(DropDown_Price_Min, function(self, level, menuList)
 local info = UIDropDownMenu_CreateInfo()
 if (level or 1) == 1 then
  -- Display the 0-9, 10-19, ... groups
	for i=0,20,1 do
		if i <= 12 then
		info.func = self.SetValue
		info.hasArrow = false
		info.arg1 = i
		info.text = i
		info.menuList = i
		UIDropDownMenu_AddButton(info)
		end
	end
end
end)

function DropDown_Price_Min:SetValue(newValue)
	UIDropDownMenu_SetText(DropDown_Price_Min, newValue)
	CloseDropDownMenus()
end

UIDropDownMenu_Initialize(DropDown_Price_Max, function(self, level, menuList)
 local info = UIDropDownMenu_CreateInfo()
 if (level or 1) == 1 then
  -- Display the 0-9, 10-19, ... groups
	for i=0,999,1 do
		if i <= 12 or i == 999 then
		info.func = self.SetValue
		info.hasArrow = false
		info.arg1 = i
		info.text = i
		info.menuList = i
		UIDropDownMenu_AddButton(info)
		end
	end
end
end)

function DropDown_Price_Max:SetValue(newValue)
	UIDropDownMenu_SetText(DropDown_Price_Max, newValue)
	CloseDropDownMenus()
end

UIDropDownMenu_Initialize(DropDown_Price_Item, function(self, level, menuList)
 local info = UIDropDownMenu_CreateInfo()
 if (level or 1) == 1 then
  -- Display the 0-9, 10-19, ... groups
	for i=1,#item_array_cost,1 do
		info.func = self.SetValue
		info.hasArrow = false
		info.arg1 = item_array_cost[i]
		info.text = item_array_cost[i]
		info.menuList = i
		UIDropDownMenu_AddButton(info)
	end
end
end)

function DropDown_Price_Item:SetValue(newValue)
	UIDropDownMenu_SetText(DropDown_Price_Item, newValue)
	CloseDropDownMenus()
end


-- SEARCH BUTTON FUNCTION

local shop_link_subcontainers_column1 = {}
local shop_link_subcontainers_column1_additional1 = {}
local shop_link_subcontainers_column1_additional2 = {}
local shop_link_subcontainers_column2 = {}
local shop_link_subcontainers_column2_additional1 = {}
local shop_link_subcontainers_column2_additional2 = {}
local shop_link_subcontainers_column3 = {}

local function FuckTonOfFrames()
	local item_name, item_link, item_quality, _, _, _, _, _, _, item_icon = GetItemInfo("item:18832:2564:0:0:0:0:0:0:80:0:0:0:0")
	
	
	for i=1,100,1 do
		ShopMain_Results_TextFrame4_SubContainer = _G["ShopMain_Results_TextFrame4_SubContainer" ..i]
		shop_link_subcontainers_column1[i] = ShopMain_Results_TextFrame4_SubContainer
		shop_link_subcontainers_column1[i] = CreateFrame("Button", "ShopMain_Results_TextFrame4_SubContainer" ..i, container_frame2, nil)
		shop_link_subcontainers_column1[i]:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight.blp")
		shop_link_subcontainers_column1[i]:SetSize(300, 25)
		if i == 1 then
			shop_link_subcontainers_column1[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 0, 0)
		else
			shop_link_subcontainers_column1[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 0, ((i-1) * -25))
		end
		shop_link_subcontainers_column1[i]:EnableMouse(true)
		shop_link_subcontainers_column1[i]:SetToplevel(true)
		shop_link_subcontainers_column1[i]:SetScript("OnEnter", function() 
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
					GameTooltip:SetHyperlink(item_link)
					GameTooltip:Show()
		end)
		shop_link_subcontainers_column1[i]:SetScript("OnLeave", function() 
			GameTooltip:Hide()
		end)
		
		shop_link_subcontainers_column1[i]:SetScript("OnMouseUp", function() 
			if IsControlKeyDown() then
				item = shop_link_subcontainers_column1_additional2[i]:GetText()
				DressUpItemLink(item)
			end
		end)
		
		ShopMain_Results_TextFrame4_SubContainer1_Icon = _G["ShopMain_Results_TextFrame4_SubContainer1_Icon" ..i]
		shop_link_subcontainers_column1_additional1[i] = ShopMain_Results_TextFrame4_SubContainer1_Icon
		shop_link_subcontainers_column1_additional1[i] = CreateFrame("Frame", "ShopMain_Results_TextFrame4_SubContainer1_Icon" ..i, shop_link_subcontainers_column1[i], nil)
		shop_link_subcontainers_column1_additional1[i]:SetSize(25, 25)
		shop_link_subcontainers_column1_additional1[i]:SetPoint("CENTER", "ShopMain_Results_TextFrame4_SubContainer" ..i, "LEFT", 20, 0)
		shop_link_subcontainers_column1_additional1[i]:SetToplevel(true)
		shop_link_subcontainers_column1_additional1[i]:SetBackdrop({
			bgFile=item_icon,
			edgeFile=nil,
			tile=false,
			tileSize=5,
			edgeSize=0,
		})

		ShopMain_Results_TextFrame4_Text = _G["ShopMain_Results_TextFrame4_Text" ..i]
		shop_link_subcontainers_column1_additional2[i] = ShopMain_Results_TextFrame4_Text
		shop_link_subcontainers_column1_additional2[i] = shop_link_subcontainers_column1[i]:CreateFontString("ShopMain_Results_TextFrame4_Text1")
		shop_link_subcontainers_column1_additional2[i]:SetFont("Fonts\\FRIZQT__.TTF", 12)
		shop_link_subcontainers_column1_additional2[i]:SetSize(250, 5)
		shop_link_subcontainers_column1_additional2[i]:SetPoint("LEFT", "ShopMain_Results_TextFrame4_SubContainer" ..i, "LEFT", 40, 0) -- this is where all looped rows should start
		shop_link_subcontainers_column1_additional2[i]:SetText(item_name)
		shop_link_subcontainers_column1_additional2[i]:SetJustifyH("LEFT")
		
		shop_link_subcontainers_column1[i]:Hide()
		
		
		
		ShopMain_Results_TextFrame5_SubContainer = _G["ShopMain_Results_TextFrame5_SubContainer" ..i]
		shop_link_subcontainers_column2[i] = ShopMain_Results_TextFrame5_SubContainer		
		shop_link_subcontainers_column2[i] = CreateFrame("Button", "ShopMain_Results_TextFrame5_SubContainer" ..i, container_frame2, nil)
		shop_link_subcontainers_column2[i]:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight.blp")
		shop_link_subcontainers_column2[i]:SetSize(50, 25)
		if i == 1 then
			shop_link_subcontainers_column2[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 302, 0)
		else
			shop_link_subcontainers_column2[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 302, ((i-1) * -25))
		end
		shop_link_subcontainers_column2[i]:EnableMouse(true)
		shop_link_subcontainers_column2[i]:SetToplevel(true)
		shop_link_subcontainers_column2[i]:SetScript("OnEnter", function() 
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
					GameTooltip:SetHyperlink(item_link)
					GameTooltip:Show()
		end)
		shop_link_subcontainers_column2[i]:SetScript("OnLeave", function() 
			GameTooltip:Hide()
		end)

		ShopMain_Results_TextFrame5_SubContainer_Icon = _G["ShopMain_Results_TextFrame5_SubContainer_Icon" ..i]
		shop_link_subcontainers_column2_additional1[i] = ShopMain_Results_TextFrame5_SubContainer_Icon			
		shop_link_subcontainers_column2_additional1[i] = CreateFrame("Frame", "shop_link_subcontainers_column2_additional1" ..i, shop_link_subcontainers_column2[i], nil)
		shop_link_subcontainers_column2_additional1[i]:SetSize(25, 25)
		shop_link_subcontainers_column2_additional1[i]:SetPoint("CENTER", "ShopMain_Results_TextFrame5_SubContainer" ..i, "RIGHT", -15, 0)
		shop_link_subcontainers_column2_additional1[i]:SetToplevel(true)
		shop_link_subcontainers_column2_additional1[i]:SetBackdrop({
			bgFile=item_icon,
			edgeFile=nil,
			tile=false,
			tileSize=5,
			edgeSize=0,
		})

		ShopMain_Results_TextFrame5_SubContainer_Text = _G["ShopMain_Results_TextFrame5_SubContainer_Text" ..i]
		shop_link_subcontainers_column2_additional2[i] = ShopMain_Results_TextFrame5_SubContainer_Text		
		shop_link_subcontainers_column2_additional2[i] = shop_link_subcontainers_column2[i]:CreateFontString("shop_link_subcontainers_column2_additional2" ..i)
		shop_link_subcontainers_column2_additional2[i]:SetFont("Fonts\\FRIZQT__.TTF", 10)
		shop_link_subcontainers_column2_additional2[i]:SetSize(30, 5)
		shop_link_subcontainers_column2_additional2[i]:SetPoint("LEFT", "ShopMain_Results_TextFrame5_SubContainer" ..i, "LEFT", -8, 0) -- this is where all looped rows should start
		shop_link_subcontainers_column2_additional2[i]:SetText("10")
		shop_link_subcontainers_column2_additional2[i]:SetJustifyH("RIGHT")
		
		shop_link_subcontainers_column2[i]:Hide()
		




		ShopMain_Results_TextFrame6_SubContainer = _G["ShopMain_Results_TextFrame6_SubContainer" ..i]
		shop_link_subcontainers_column3[i] = ShopMain_Results_TextFrame6_SubContainer	
		shop_link_subcontainers_column3[i] = CreateFrame("Button", "shop_link_subcontainers_column3" ..i, container_frame2, "UIPanelButtonTemplate")
		if i == 1 then
			shop_link_subcontainers_column3[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 353, 0)
		else
			shop_link_subcontainers_column3[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 353, ((i-1) * -25))
		end
		shop_link_subcontainers_column3[i]:EnableMouse(true)
		shop_link_subcontainers_column3[i]:SetToplevel(true)
		shop_link_subcontainers_column3[i]:SetSize(90, 25)
		shop_link_subcontainers_column3[i]:SetText("Purchase")
		shop_link_subcontainers_column3[i]:SetScript("OnMouseUp", function() PlaySound("GAMEDIALOGOPEN", "SFX") end)
	
		shop_link_subcontainers_column3[i]:Hide()
	end
end
FuckTonOfFrames()

-- array for holding confirmation info
confirm_purchase_array1 = {}
confirm_purchase_array2 = {}
confirm_purchase_array3 = {}
confirm_purchase_array4 = {}
confirm_purchase_array5 = {}

-- confirm purchase
function POPUP_PURCHASE(item_name, cost_quantity, link2, entry, cost_name)
	StaticPopupDialogs["CONFIRM_PURCHASE"] = {
	  text = "Are you sure you want to buy " ..item_name.. " for " ..cost_quantity.. " " ..link2.. "?",
	  button1 = "Yes",
	  button2 = "No",
	  OnAccept = function()
		AIO.Handle("Shop", "ShopPurchase", entry, cost_name)
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_PURCHASE")
end

function animateObject(currentRot, rotSpeed)
	FModel:SetRotation(currentRot)
	currentRot = currentRot + rotSpeed
end
-- recieve results
function ShopHandlers.ListResults(player, i, link, name, entry, item_name_entry, link2, cost_quantity, model_name)
	if shop_link_subcontainers_column1[i] == nil then
		print("wtf")
	else
--	item_name, item_link, item_quality, _, _, _, _, _, _, item_icon = GetItemInfo(tostring(link)))
	item_icon = GetItemIcon(entry)
	item_name = name
	shop_link_subcontainers_column1[i]:Show()
	shop_link_subcontainers_column1[i]:SetScript("OnEnter", function() 
				GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(link)
--				print("Hover on item detected!")
--				print(name)
--				print(entry)
--				print(model_name)
                                        local currentRot = 30
                                        local ScaleModel = 400
                                        local rotSpeed = 0.01
                                        FModel = CreateFrame("PlayerModel",nil,isGUI)
                                        FModel:SetModel(tostring(model_name))
                                        FModel:SetHeight(ScaleModel)
                                        FModel:SetWidth(ScaleModel)
                                        FModel:SetRotation(currentRot)
                                        FModel:SetScript("OnUpdate", function()
						        FModel:SetRotation(currentRot)
						        currentRot = currentRot + rotSpeed
						end)
                                        FModel:SetPoint("CENTER", -355, 70)
                                        UIFrameFadeIn(FModel, 1, 0, 1)
                                        FModel:SetScale(0.8)
                                        FModel:Show()
	end)
        shop_link_subcontainers_column1[i]:SetScript("OnLeave", function()
					UIFrameFadeOut(FModel, 1, 0, 1)
                                        FModel:Hide()
					GameTooltip:Hide()
	end)

	shop_link_subcontainers_column1[i]:SetScript("OnMouseUp", function() 
		if IsShiftKeyDown() then
			print("The item link is: " ..link.. ".")
		elseif IsControlKeyDown() then
			DressUpItemLink(link)
		end
	end)
	shop_link_subcontainers_column1_additional1[i]:SetBackdrop({
		bgFile=item_icon,
		edgeFile=nil,
		tile=false,
		tileSize=5,
		edgeSize=0,
	})
	shop_link_subcontainers_column1_additional2[i]:SetText(link)
	
	item_icon = GetItemIcon(item_name_entry)
	item_cost_name = GetItemInfo(item_name_entry)
	shop_link_subcontainers_column2[i]:SetScript("OnEnter", function() 
				GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(link2)	
	end)
	shop_link_subcontainers_column2_additional1[i]:SetBackdrop({
		bgFile=item_icon,
		edgeFile=nil,
		tile=false,
		tileSize=5,
		edgeSize=0,
	})
	shop_link_subcontainers_column2_additional2[i]:SetText(cost_quantity)
	shop_link_subcontainers_column2[i]:Show()
	
	confirm_purchase_array1[i] = item_name
	confirm_purchase_array2[i] = cost_quantity
	confirm_purchase_array3[i] = link2
	confirm_purchase_array4[i] = entry
	confirm_purchase_array5[i] = item_cost_name
	
--	confirm_purchase_array5[i] = item_cost_name
	shop_link_subcontainers_column3[i]:SetScript("OnMouseUp", function() 
--	print(confirm_purchase_array1[i])
--	print(item_name_entry)
	POPUP_PURCHASE(confirm_purchase_array1[i], confirm_purchase_array2[i], confirm_purchase_array3[i], confirm_purchase_array4[i], confirm_purchase_array5[i])
	end)
	shop_link_subcontainers_column3[i]:Show()
	scrollbar:SetValue(0)
	scrollbar:SetMinMaxValues(1, (i * 21.9)) 
	end
end

ShopMain_Button_Search:SetScript("OnMouseUp", function() 
	PlaySound("GAMEDIALOGOPEN", "SFX") 
	for i=1,100,1 do
		if shop_link_subcontainers_column1[i] ~= nil and shop_link_subcontainers_column2[i] ~= nil and shop_link_subcontainers_column3[i] ~= nil then
			shop_link_subcontainers_column1[i]:Hide()
			shop_link_subcontainers_column2[i]:Hide()
			shop_link_subcontainers_column3[i]:Hide()
		elseif shop_link_subcontainers_column1[i] ~= nil then
			shop_link_subcontainers_column1[i]:Hide()
			shop_link_subcontainers_column3[i]:Hide()
		end
	end
	editbox = ShopFilter_Name:GetText()
	item_type = UIDropDownMenu_GetText(DropDown_Type)
	min_cost = UIDropDownMenu_GetText(DropDown_Price_Min)
	max_cost = UIDropDownMenu_GetText(DropDown_Price_Max)
	item_name = UIDropDownMenu_GetText(DropDown_Price_Item)
	AIO.Handle("Shop", "ShopQuery", editbox, item_type, min_cost, max_cost, item_name)
--	print("sent")
end)

ShopMain:Hide()

ShopMain:SetScript("OnHide", function()
	PlaySound("igCharacterInfoClose")
	for i=1,100,1 do
		if shop_link_subcontainers_column1[i] ~= nil then
			shop_link_subcontainers_column1[i]:Hide()
			shop_link_subcontainers_column2[i]:Hide()
			shop_link_subcontainers_column3[i]:Hide()
		end
	end
end)

function ShopHandlers.ShowUI(player)
	ShopMain:Show()
end
