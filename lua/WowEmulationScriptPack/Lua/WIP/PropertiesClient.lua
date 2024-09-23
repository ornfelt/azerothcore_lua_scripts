local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local PropertyHandlers = AIO.AddHandlers("Properties", {})

-- a list of objects for the link objects dropdown. name = id
	objects = {
--		["None"] = 0,
		["Bed [SPECIAL]"] = 1000005,
		["Training Dummy [SPECIAL]"] = 1000016,
		["Forge [SPECIAL]"] = 1000011,
		["Saw [SPECIAL]"] = 1000012,
		["Loom [SPECIAL]"] = 1000013,
		["Alembic [SPECIAL]"] = 1000014,
		["Boiling Water [SPECIAL]"] = 1000015,
		["Butcher Table [SPECIAL]"] = 1000017,
		["Tanning Rack [SPECIAL]"] = 1000018,
		["Bookshelf [SPECIAL]"] = 1000019,
		["Cooking Fire [SPECIAL]"] = 1000020,
	}

-- a function used later in the objects dropdown
function pairsByKeys(t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if a[i] == nil then return nil
			else return a[i], t[a[i]]
			end
		end
		return iter
end

-- universal frame that every situation will use but unique ones will build onto
local function Create_Frame_Properties()
	Frame_Properties = CreateFrame("Frame", "Frame_Properties", UIParent, "UIPanelDialogTemplate")
	Frame_Properties:SetSize(260, 230)
	Frame_Properties:SetMovable(true)
	Frame_Properties:EnableMouse(true)
	Frame_Properties:SetToplevel(true)
	Frame_Properties:RegisterForDrag("LeftButton")
	Frame_Properties:SetPoint("CENTER")
	Frame_Properties:SetScript("OnDragStart", Frame_Properties.StartMoving)
	Frame_Properties:SetScript("OnHide", Frame_Properties.StopMovingOrSizing)
	Frame_Properties:SetScript("OnDragStop", Frame_Properties.StopMovingOrSizing)
	Frame_Properties:SetScript("OnShow", function() AIO.Handle("Properties", "GetData") PlaySound("igCharacterInfoTab") end)
	Frame_Properties:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") end)
	AIO.SavePosition(Frame_Properties)
	Frame_Properties:SetClampedToScreen(true)
	Frame_Properties:Hide()
	-- top/title text
	local Frame_Properties_Text1 = Frame_Properties:CreateFontString("Frame_Properties_Text1")
	Frame_Properties_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Text1:SetSize(190, 5)
	Frame_Properties_Text1:SetPoint("TOP", 0, -13)
	Frame_Properties_Text1:SetText("Properties UI")

	--editboxes
	local Frame_Properties_Editbox_Name = CreateFrame("EditBox", "Frame_Properties_Editbox_Name", Frame_Properties, "InputBoxTemplate")
	Frame_Properties_Editbox_Name:SetSize(135, 50)
	Frame_Properties_Editbox_Name:SetAutoFocus(false)
	Frame_Properties_Editbox_Name:SetPoint("TOP", "Frame_Properties", "TOP", 0, -40)
	Frame_Properties_Editbox_Name:SetScript("OnEnterPressed", Frame_Properties_Editbox_Name.ClearFocus)
	Frame_Properties_Editbox_Name:SetScript("OnEscapePressed", Frame_Properties_Editbox_Name.ClearFocus)
	local Frame_Properties_Editbox_Name_Text = Frame_Properties:CreateFontString("Frame_Properties_Editbox_Name_Text")
	Frame_Properties_Editbox_Name_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_Properties_Editbox_Name_Text:SetSize(190, 5)
	Frame_Properties_Editbox_Name_Text:SetPoint("CENTER", "Frame_Properties_Editbox_Name", "CENTER", 0, 25)
	Frame_Properties_Editbox_Name_Text:SetText("Property Info: ")
	
	-- if not GM/owner, this text object takes over
	local Frame_Properties_Editbox_Name_Text2 = Frame_Properties:CreateFontString("Frame_Properties_Editbox_Name_Text2")
	Frame_Properties_Editbox_Name_Text2:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Editbox_Name_Text2:SetSize(190, 5)
	Frame_Properties_Editbox_Name_Text2:SetPoint("CENTER", "Frame_Properties_Editbox_Name", "CENTER", 20, 0)
	Frame_Properties_Editbox_Name_Text2:SetText("Test")
	Frame_Properties_Editbox_Name_Text2:SetJustifyH("LEFT")
	
	-- the icons that change by property name text
	local Frame_Properties_Editbox_Name_Icon_Type_List = {
		["Interface/paperdoll/ui-paperdoll-slot-bag"] = "None\nThis property does not have a type.",
		["Interface/images/new_beer"] = "Tavern\nThis establishment provides a healthy rest and good spirits.\nCome and relax.",
		["Interface/images/goldmine"] = "Mine\nMine ores and smelt them down at this property.\nPut your labor to the test.",
		["Interface/images/NightElfBuild"] = "Farm\nCome find what grows in the dirt at this plot of land.\nLet's hope you have a green thumb.",
		["Interface/images/HumanLumber"] = "Lumber Mill\nSawdust follows your every touch in this building.\nWhat are you making?",
		["Interface/images/Horse"] = "Stables\nMounts strong enough for any task are raised here.\nPut your best foot forward.",
		["Interface/ICONS/INV_Misc_Book_06"] = "Library\nScrolls of spells and ancient history fill this property to the brim.\nAre you ready to learn?",
		["Interface/ICONS/Trade_archaeology_troll_voodoodoll"] = "Training Grounds\nSwords clatter as soldiers practice.\nBring your strength.",
		["Interface/ICONS/Inv_misc_1h_innmeatcleaver_a_01"] = "Butcher\nThe air is filled with a stench of death.\nLooks like meat's back on the menu.",
		["Interface/ICONS/Trade_leatherworking"] = "Tannery\nMany hides litter this property, waiting to be processed.\nTake care in your work here.",
		["Interface/ICONS/Inv_misc_paperbundle03d"] = "Papyrus Farm\nThe fields tower with the tall crop of papyrus.",
		["Interface/ICONS/INV_Fabric_Wool_02"] = "Cotton Farm\nWhite cottons flows around these fields.",
		["Interface/ICONS/trade_herbalism"] = "Herb Farm\nHerbs of magical properties are grown here.",
		["Interface/ICONS/inv_misc_key_15"] = "House\nThis is someone's place of residence.\nWill you knock?",
	}
	
	local Frame_Properties_Editbox_Name_Icon_Type = CreateFrame("Button", "Frame_Properties_Editbox_Name_Icon_Type", Frame_Properties, nil)
	Frame_Properties_Editbox_Name_Icon_Type:SetPoint("CENTER", "Frame_Properties_Editbox_Name_Text", -60, 0)
	Frame_Properties_Editbox_Name_Icon_Type:EnableMouse(true)
	Frame_Properties_Editbox_Name_Icon_Type:SetSize(20, 20)
    Frame_Properties_Editbox_Name_Icon_Type:SetNormalTexture("Interface/paperdoll/ui-paperdoll-slot-bag.blp")
	Frame_Properties_Editbox_Name_Icon_Type:SetPushedTexture("Interface/paperdoll/ui-paperdoll-slot-bag.blp")
    Frame_Properties_Editbox_Name_Icon_Type:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")	
	Frame_Properties_Editbox_Name_Icon_Type:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetText(Frame_Properties_Editbox_Name_Icon_Type_List[Frame_Properties_Editbox_Name_Icon_Type:GetNormalTexture():GetTexture()])
	end)
	Frame_Properties_Editbox_Name_Icon_Type:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	local Frame_Properties_Editbox_Name_Icon_Owner = CreateFrame("Button", "Frame_Properties_Editbox_Name_Icon_Owner", Frame_Properties, nil)
	Frame_Properties_Editbox_Name_Icon_Owner:SetPoint("CENTER", "Frame_Properties_Editbox_Name_Text", 60, 0)
	Frame_Properties_Editbox_Name_Icon_Owner:EnableMouse(true)
	Frame_Properties_Editbox_Name_Icon_Owner:SetSize(20, 20)
    Frame_Properties_Editbox_Name_Icon_Owner:SetNormalTexture("Interface/paperdoll/ui-paperdoll-slot-bag.blp")
	Frame_Properties_Editbox_Name_Icon_Owner:SetPushedTexture("Interface/paperdoll/ui-paperdoll-slot-bag.blp")
    Frame_Properties_Editbox_Name_Icon_Owner:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")	
	Frame_Properties_Editbox_Name_Icon_Owner:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetText("Owner:\nNone")
	end)
	Frame_Properties_Editbox_Name_Icon_Owner:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	-- currency buttons
	silver_entry = 1999999
	gold_entry = 1999998
	copper_entry = 1999997
	silver_icon = GetItemIcon(silver_entry)
	copper_icon = GetItemIcon(copper_entry)
	gold_icon = GetItemIcon(gold_entry)
	

	-- gold, copper are anchored to silver. silver is anchored to property name editbox
	local Frame_Properties_Button_Silver = CreateFrame("Button", "Frame_Properties_Button_Silver", Frame_Properties, nil)
	Frame_Properties_Button_Silver:SetPoint("CENTER", "Frame_Properties_Editbox_Name", 0, -60)
	Frame_Properties_Button_Silver:EnableMouse(true)
	Frame_Properties_Button_Silver:SetSize(32, 32)
    Frame_Properties_Button_Silver:SetNormalTexture(silver_icon)
	Frame_Properties_Button_Silver:SetPushedTexture(silver_icon)
    Frame_Properties_Button_Silver:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")
	local Frame_Properties_Button_Silver_Text = Frame_Properties_Button_Silver:CreateFontString("Frame_Properties_Button_Silver_Text")
	Frame_Properties_Button_Silver_Text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Button_Silver_Text:SetSize(190, 5)
	Frame_Properties_Button_Silver_Text:SetPoint("CENTER", "Frame_Properties_Button_Silver")
	Frame_Properties_Button_Silver_Text:SetText("0")
	Frame_Properties_Button_Silver:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	local Frame_Properties_Lease_Text = Frame_Properties:CreateFontString("Frame_Properties_Lease_Text")
	Frame_Properties_Lease_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_Properties_Lease_Text:SetSize(190, 5)
	Frame_Properties_Lease_Text:SetPoint("CENTER", "Frame_Properties_Button_Silver", "CENTER", 0, 33)
	Frame_Properties_Lease_Text:SetText("Property Lease:")
	
	local Frame_Properties_Button_Gold = CreateFrame("Button", "Frame_Properties_Button_Gold", Frame_Properties, nil)
	Frame_Properties_Button_Gold:SetPoint("TOP", "Frame_Properties_Button_Silver", -50, 0)
	Frame_Properties_Button_Gold:EnableMouse(true)
	Frame_Properties_Button_Gold:SetSize(32, 32)
    Frame_Properties_Button_Gold:SetNormalTexture(gold_icon)
	Frame_Properties_Button_Gold:SetPushedTexture(gold_icon)
    Frame_Properties_Button_Gold:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")
	local Frame_Properties_Button_Gold_Text = Frame_Properties_Button_Gold:CreateFontString("Frame_Properties_Button_Gold_Text")
	Frame_Properties_Button_Gold_Text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Button_Gold_Text:SetSize(190, 5)
	Frame_Properties_Button_Gold_Text:SetPoint("CENTER", "Frame_Properties_Button_Gold")
	Frame_Properties_Button_Gold_Text:SetText("0")
	Frame_Properties_Button_Gold:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	local Frame_Properties_Button_Copper = CreateFrame("Button", "Frame_Properties_Button_Copper", Frame_Properties, nil)
	Frame_Properties_Button_Copper:SetPoint("TOP", "Frame_Properties_Button_Silver", 50, 0)
	Frame_Properties_Button_Copper:EnableMouse(true)
	Frame_Properties_Button_Copper:SetSize(32, 32)
    Frame_Properties_Button_Copper:SetNormalTexture(copper_icon)
	Frame_Properties_Button_Copper:SetPushedTexture(copper_icon)
    Frame_Properties_Button_Copper:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")
	local Frame_Properties_Button_Copper_Text = Frame_Properties_Button_Copper:CreateFontString("Frame_Properties_Button_Copper_Text")
	Frame_Properties_Button_Copper_Text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Button_Copper_Text:SetSize(190, 5)
	Frame_Properties_Button_Copper_Text:SetPoint("CENTER", "Frame_Properties_Button_Copper")
	Frame_Properties_Button_Copper_Text:SetText("1")
	Frame_Properties_Button_Copper:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	-- SAME AS ABOVE BUT SERVICE FEE INSTEAD
	-- gold, copper are anchored to silver. silver is anchored to property name editbox
	local Frame_Properties_Button_Silver_Service = CreateFrame("Button", "Frame_Properties_Button_Silver_Service", Frame_Properties, nil)
	Frame_Properties_Button_Silver_Service:SetPoint("CENTER", "Frame_Properties_Editbox_Name", 0, -125)
	Frame_Properties_Button_Silver_Service:EnableMouse(true)
	Frame_Properties_Button_Silver_Service:SetSize(32, 32)
    Frame_Properties_Button_Silver_Service:SetNormalTexture(silver_icon)
	Frame_Properties_Button_Silver_Service:SetPushedTexture(silver_icon)
    Frame_Properties_Button_Silver_Service:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")
	local Frame_Properties_Button_Silver_Service_Text = Frame_Properties_Button_Silver_Service:CreateFontString("Frame_Properties_Button_Silver_Service_Text")
	Frame_Properties_Button_Silver_Service_Text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Button_Silver_Service_Text:SetSize(190, 5)
	Frame_Properties_Button_Silver_Service_Text:SetPoint("CENTER", "Frame_Properties_Button_Silver_Service")
	Frame_Properties_Button_Silver_Service_Text:SetText("0")
	Frame_Properties_Button_Silver_Service:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	local Frame_Properties_Service_Text = Frame_Properties:CreateFontString("Frame_Properties_Service_Text")
	Frame_Properties_Service_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_Properties_Service_Text:SetSize(190, 5)
	Frame_Properties_Service_Text:SetPoint("CENTER", "Frame_Properties_Button_Silver_Service", "CENTER", 0, 33)
	Frame_Properties_Service_Text:SetText("Property Service Charge:")
	
	local Frame_Properties_Button_Gold_Service = CreateFrame("Button", "Frame_Properties_Button_Gold_Service", Frame_Properties, nil)
	Frame_Properties_Button_Gold_Service:SetPoint("TOP", "Frame_Properties_Button_Silver_Service", -50, 0)
	Frame_Properties_Button_Gold_Service:EnableMouse(true)
	Frame_Properties_Button_Gold_Service:SetSize(32, 32)
    Frame_Properties_Button_Gold_Service:SetNormalTexture(gold_icon)
	Frame_Properties_Button_Gold_Service:SetPushedTexture(gold_icon)
    Frame_Properties_Button_Gold_Service:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")
	local Frame_Properties_Button_Gold_Service_Text = Frame_Properties_Button_Gold_Service:CreateFontString("Frame_Properties_Button_Gold_Service_Text")
	Frame_Properties_Button_Gold_Service_Text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Button_Gold_Service_Text:SetSize(190, 5)
	Frame_Properties_Button_Gold_Service_Text:SetPoint("CENTER", "Frame_Properties_Button_Gold_Service")
	Frame_Properties_Button_Gold_Service_Text:SetText("0")
	Frame_Properties_Button_Gold_Service:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	local Frame_Properties_Button_Copper_Service = CreateFrame("Button", "Frame_Properties_Button_Copper_Service", Frame_Properties, nil)
	Frame_Properties_Button_Copper_Service:SetPoint("TOP", "Frame_Properties_Button_Silver_Service", 50, 0)
	Frame_Properties_Button_Copper_Service:EnableMouse(true)
	Frame_Properties_Button_Copper_Service:SetSize(32, 32)
    Frame_Properties_Button_Copper_Service:SetNormalTexture(copper_icon)
	Frame_Properties_Button_Copper_Service:SetPushedTexture(copper_icon)
    Frame_Properties_Button_Copper_Service:SetHighlightTexture("Interface/BUTTONS/ButtonHilight-Square.blp")
	local Frame_Properties_Button_Copper_Service_Text = Frame_Properties_Button_Copper_Service:CreateFontString("Frame_Properties_Button_Copper_Service_Text")
	Frame_Properties_Button_Copper_Service_Text:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Button_Copper_Service_Text:SetSize(190, 5)
	Frame_Properties_Button_Copper_Service_Text:SetPoint("CENTER", "Frame_Properties_Button_Copper_Service")
	Frame_Properties_Button_Copper_Service_Text:SetText("1")
	Frame_Properties_Button_Copper_Service:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	
	
	Frame_Properties:RegisterEvent("PLAYER_TARGET_CHANGED")
	Frame_Properties:SetScript("OnEvent", function(self, event, arg1)
		Frame_Properties:Hide()
	end)
	
	
	-- INVENTORY START
	
	
	Frame_Properties_Inventory = CreateFrame("Frame", "Frame_Properties_Inventory", Frame_Properties, "UIPanelDialogTemplate")
	Frame_Properties_Inventory:SetSize(Frame_Properties:GetWidth(), Frame_Properties:GetHeight())
--	Frame_Properties_Inventory:SetMovable(true)
	Frame_Properties_Inventory:EnableMouse(true)
	Frame_Properties_Inventory:SetToplevel(true)
	Frame_Properties_Inventory:RegisterForDrag("LeftButton")
	Frame_Properties_Inventory:SetPoint("TOP", "Frame_Properties", Frame_Properties:GetWidth() - 11, 0)
	Frame_Properties_Inventory:SetScript("OnDragStart", Frame_Properties.StartMoving)
	Frame_Properties_Inventory:SetScript("OnHide", Frame_Properties.StopMovingOrSizing)
--	Frame_Properties_Inventory:SetScript("OnShow", function() Frame_Properties_Inventory:SetPoint("TOP", "Frame_Properties", Frame_Properties:GetWidth() - 11, 0) Frame_Properties_Inventory:SetSize(Frame_Properties:GetWidth(), Frame_Properties:GetHeight()) end)
	Frame_Properties_Inventory:SetScript("OnDragStop", Frame_Properties.StopMovingOrSizing)
	Frame_Properties_Inventory:SetScript("OnShow", function() AIO.Handle("Properties", "GetData") PlaySound("igCharacterInfoTab") end)
	Frame_Properties_Inventory:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") Frame_Properties_Inventory_Button_Open:SetButtonState("NORMAL") end)
	Frame_Properties_Inventory:SetClampedToScreen(true)
	Frame_Properties_Inventory:Hide()
	-- top/title text
	local Frame_Properties_Inventory_Text1 = Frame_Properties_Inventory:CreateFontString("Frame_Properties_Inventory_Text1")
	Frame_Properties_Inventory_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
	Frame_Properties_Inventory_Text1:SetSize(190, 5)
	Frame_Properties_Inventory_Text1:SetPoint("TOP", 0, -13)
	Frame_Properties_Inventory_Text1:SetText("Inventory")
	Frame_Properties:SetToplevel(true)
	
	-- button to show inventory
	local Frame_Properties_Inventory_Button_Open = CreateFrame("Button", "Frame_Properties_Inventory_Button_Open", Frame_Properties, "UIPanelButtonTemplate")
	Frame_Properties_Inventory_Button_Open:SetPoint("TOPRIGHT", "Frame_Properties", -6, -25)
	Frame_Properties_Inventory_Button_Open:EnableMouse(true)
	Frame_Properties_Inventory_Button_Open:SetSize(20, 20)
	Frame_Properties_Inventory_Button_Open:SetText("v")
	Frame_Properties_Inventory_Button_Open:SetScript("OnMouseUp", function() 
		if Frame_Properties_Inventory:IsShown() == 1 then
			Frame_Properties_Inventory:Hide() 
			Frame_Properties_Inventory_Button_Open:SetButtonState("NORMAL") 
		else
			Frame_Properties_Inventory:Show() 
			Frame_Properties_Inventory_Button_Open:SetButtonState("PUSHED", true) 			
		end
	end)
	
	local Frame_Properties_Inventory_Button_Temp = CreateFrame("Button", "Frame_Properties_Inventory_Button_Temp", Frame_Properties_Inventory, "UIPanelButtonTemplate")
	Frame_Properties_Inventory_Button_Temp:SetPoint("CENTER", "Frame_Properties_Inventory", 0, 0)
	Frame_Properties_Inventory_Button_Temp:EnableMouse(true)
	Frame_Properties_Inventory_Button_Temp:SetSize(100, 20)
	Frame_Properties_Inventory_Button_Temp:SetText("Get Items!")
	Frame_Properties_Inventory_Button_Temp:SetScript("OnMouseUp", function()
		AIO.Handle("Properties", "Temp_Get_Items")
	end)
	
	
	
--	Frame_Properties_Inventory_Container_Subcontainer = _G["ShopMain_Results_TextFrame6_SubContainer" ..i]
--	shop_link_subcontainers_column3[i] = ShopMain_Results_TextFrame6_SubContainer	
--	shop_link_subcontainers_column3[i] = CreateFrame("Button", "shop_link_subcontainers_column3" ..i, container_frame2, "UIPanelButtonTemplate")
--	if i == 1 then
--		shop_link_subcontainers_column3[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 353, 0)
--	else
--		shop_link_subcontainers_column3[i]:SetPoint("TOPLEFT", "container_frame2", "TOPLEFT", 353, ((i-1) * -25))
--	end
--	shop_link_subcontainers_column3[i]:EnableMouse(true)
--	shop_link_subcontainers_column3[i]:SetToplevel(true)
--	shop_link_subcontainers_column3[i]:SetSize(90, 25)
--	shop_link_subcontainers_column3[i]:SetText("Purchase")
--	shop_link_subcontainers_column3[i]:SetScript("OnMouseUp", function() PlaySound("GAMEDIALOGOPEN", "SFX") end)
--	
--	shop_link_subcontainers_column3[i]:Hide()	

	
	
	-- INVENTORY END
end

Create_Frame_Properties()
-- Frame_Properties:Show()
Frame_Properties_Editbox_Name:Hide()

-- shown when is gm == true and is_confirmed == 0
local function Is_GM_SETUP()
	local descriptors = {
		"Tavern",
		"Library",
		"Training Grounds",
		"Mine",
		"Lumber Mill",
		"Butcher",
		"Tannery",
		"Papyrus Farm",
		"Cotton Farm",
		"Herb Farm",
		"Farm",
		"House",
	}

	--descriptor dropdown
	local Frame_PropertiesGM_DropDown_Descriptor = CreateFrame("FRAME", "Frame_PropertiesGM_DropDown_Descriptor", Frame_Properties, "UIDropDownMenuTemplate")
	Frame_PropertiesGM_DropDown_Descriptor:SetPoint("TOP", "Frame_Properties", "TOP", 0, -235)
	UIDropDownMenu_SetWidth(Frame_PropertiesGM_DropDown_Descriptor, 130)
	UIDropDownMenu_SetText(Frame_PropertiesGM_DropDown_Descriptor, "None")
	local Frame_PropertiesGM_DropDown_Descriptor_Text = Frame_PropertiesGM_DropDown_Descriptor:CreateFontString("Frame_PropertiesGM_DropDown_Descriptor_Text")
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetSize(190, 5)
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetPoint("CENTER", "Frame_PropertiesGM_DropDown_Descriptor", "TOP", 0, 13)
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetText("Descriptor:")
	
	UIDropDownMenu_Initialize(Frame_PropertiesGM_DropDown_Descriptor, function(self, level, menuList)
	local info = UIDropDownMenu_CreateInfo()
	if (level or 1) == 1 then
	-- Display the 0-9, 10-19, ... groups
		for i=1,#descriptors,1 do
			info.func = self.SetValue
			info.hasArrow = false
			info.arg1 = descriptors[i]
			info.text = descriptors[i]
			info.menuList = i
			UIDropDownMenu_AddButton(info)
		end
	end
	end)

	function Frame_PropertiesGM_DropDown_Descriptor:SetValue(newValue)
		UIDropDownMenu_SetText(Frame_PropertiesGM_DropDown_Descriptor, newValue)
		CloseDropDownMenus()
	end		

	--editboxes
	-- items produced
	local Frame_PropertiesGM_Editbox_Item_Entry = CreateFrame("EditBox", "Frame_PropertiesGM_Editbox_Item_Entry", Frame_PropertiesGM_DropDown_Descriptor, "InputBoxTemplate")
	Frame_PropertiesGM_Editbox_Item_Entry:SetSize(135, 50)
	Frame_PropertiesGM_Editbox_Item_Entry:SetAutoFocus(false)
	Frame_PropertiesGM_Editbox_Item_Entry:SetPoint("TOP", "Frame_PropertiesGM_DropDown_Descriptor", "TOP", 0, -40)
	Frame_PropertiesGM_Editbox_Item_Entry:SetScript("OnEnterPressed", Frame_PropertiesGM_Editbox_Item_Entry.ClearFocus)
	Frame_PropertiesGM_Editbox_Item_Entry:SetScript("OnEscapePressed", Frame_PropertiesGM_Editbox_Item_Entry.ClearFocus)
	local Frame_Properties_Editbox_Name_Text_Entry = Frame_PropertiesGM_Editbox_Item_Entry:CreateFontString("Frame_Properties_Editbox_Name_Text_Entry")
	Frame_Properties_Editbox_Name_Text_Entry:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_Properties_Editbox_Name_Text_Entry:SetSize(190, 5)
	Frame_Properties_Editbox_Name_Text_Entry:SetPoint("CENTER", "Frame_PropertiesGM_Editbox_Item_Entry", "CENTER", 0, 25)
	Frame_Properties_Editbox_Name_Text_Entry:SetText("Items Produced: ")
	
	-- item quantities
	local Frame_PropertiesGM_Editbox_Item_Quantities = CreateFrame("EditBox", "Frame_PropertiesGM_Editbox_Item_Quantities", Frame_PropertiesGM_DropDown_Descriptor, "InputBoxTemplate")
	Frame_PropertiesGM_Editbox_Item_Quantities:SetSize(135, 50)
	Frame_PropertiesGM_Editbox_Item_Quantities:SetAutoFocus(false)
	Frame_PropertiesGM_Editbox_Item_Quantities:SetPoint("TOP", "Frame_PropertiesGM_DropDown_Descriptor", "TOP", 0, -90)
	Frame_PropertiesGM_Editbox_Item_Quantities:SetScript("OnEnterPressed", Frame_PropertiesGM_Editbox_Item_Quantities.ClearFocus)
	Frame_PropertiesGM_Editbox_Item_Quantities:SetScript("OnEscapePressed", Frame_PropertiesGM_Editbox_Item_Quantities.ClearFocus)
	local Frame_Properties_Editbox_Name_Text_Quantities = Frame_PropertiesGM_Editbox_Item_Quantities:CreateFontString("Frame_Properties_Editbox_Name_Text_Quantities")
	Frame_Properties_Editbox_Name_Text_Quantities:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_Properties_Editbox_Name_Text_Quantities:SetSize(190, 5)
	Frame_Properties_Editbox_Name_Text_Quantities:SetPoint("CENTER", "Frame_PropertiesGM_Editbox_Item_Quantities", "CENTER", 0, 25)
	Frame_Properties_Editbox_Name_Text_Quantities:SetText("Item Quantities: ")
	
	-- link objects dropdown
	local Frame_PropertiesGM_DropDown_Link = CreateFrame("FRAME", "Frame_PropertiesGM_DropDown_Link", Frame_Properties, "UIDropDownMenuTemplate")
	Frame_PropertiesGM_DropDown_Link:SetPoint("TOP", "Frame_PropertiesGM_DropDown_Descriptor", "TOP", 0, -150)
	UIDropDownMenu_SetWidth(Frame_PropertiesGM_DropDown_Link, 130)
	UIDropDownMenu_SetText(Frame_PropertiesGM_DropDown_Link, "None")
	local Frame_PropertiesGM_DropDown_Descriptor_Text = Frame_PropertiesGM_DropDown_Link:CreateFontString("Frame_PropertiesGM_DropDown_Descriptor_Text")
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetSize(190, 5)
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetPoint("CENTER", "Frame_PropertiesGM_DropDown_Link", "TOP", 0, 13)
	Frame_PropertiesGM_DropDown_Descriptor_Text:SetText("Link Nearby Objects:")
	
	UIDropDownMenu_Initialize(Frame_PropertiesGM_DropDown_Link, function(self, level, menuList)
	local info = UIDropDownMenu_CreateInfo()
	if (level or 1) == 1 then
	-- Display the 0-9, 10-19, ... groups
		for name, line in pairsByKeys(objects) do
			info.func = self.SetValue
			info.hasArrow = false
			info.arg1 = name
			info.text = name
			info.menuList = i
			UIDropDownMenu_AddButton(info)
		end
	end
	end)

	function Frame_PropertiesGM_DropDown_Link:SetValue(newValue)
		UIDropDownMenu_SetText(Frame_PropertiesGM_DropDown_Link, newValue)
		CloseDropDownMenus()
	end	

	-- confirm button
	local Frame_Properties_Button1 = CreateFrame("Button", "Frame_Properties_Button1", Frame_PropertiesGM_DropDown_Descriptor, "UIPanelButtonTemplate")
	Frame_Properties_Button1:SetPoint("TOP", 0, -190)
	Frame_Properties_Button1:EnableMouse(true)
	Frame_Properties_Button1:SetSize(125, 30)
	Frame_Properties_Button1:SetText("Confirm")
	Frame_Properties_Button1:SetScript("OnMouseUp", function() POPUP_GM_CONFIRM() PlaySound("GAMEDIALOGOPEN", "SFX") end)
	-- link objects button
	local Frame_Properties_Link_Button = CreateFrame("Button", "Frame_Properties_Link_Button", Frame_PropertiesGM_DropDown_Link, "UIPanelButtonTemplate")
	Frame_Properties_Link_Button:SetPoint("CENTER", "Frame_PropertiesGM_DropDown_Link", 97, 3)
	Frame_Properties_Link_Button:EnableMouse(true)
	Frame_Properties_Link_Button:SetSize(40, 20)
	Frame_Properties_Link_Button:SetText("Link")
	Frame_Properties_Link_Button:SetScript("OnMouseUp", function() POPUP_GM_LINK() PlaySound("GAMEDIALOGOPEN", "SFX") end)	
	Frame_PropertiesGM_DropDown_Link:Hide()
	
end

Is_GM_SETUP()

-- shown when is gm == false and is confirmed == 1
local function Is_Viewer_SETUP()
	-- purchase property button
	local Frame_Properties_Button_Purchase_Property = CreateFrame("Button", "Frame_Properties_Button_Purchase_Property", Frame_Properties, "UIPanelButtonTemplate")
	Frame_Properties_Button_Purchase_Property:EnableMouse(true)
	Frame_Properties_Button_Purchase_Property:SetSize(125, 30)
	Frame_Properties_Button_Purchase_Property:SetText("Buy Property")
	Frame_Properties_Button_Purchase_Property:SetScript("OnMouseUp", function() POPUP_PURCHASE_PROPERTY_CONFIRM() PlaySound("GAMEDIALOGOPEN", "SFX") end)
	Frame_Properties_Button_Purchase_Property:SetPoint("CENTER", "Frame_Properties_Editbox_Name", 0, -170)
	Frame_Properties_Button_Purchase_Property:Hide()
end

Is_Viewer_SETUP()


-- shows when is_owner == true
local function Is_Owner_SETUP()
	local Frame_Properties_Editbox_Name_Button = CreateFrame("Button", "Frame_Properties_Editbox_Name_Button", Frame_Properties, "UIPanelButtonTemplate")
	Frame_Properties_Editbox_Name_Button:SetPoint("CENTER", "Frame_Properties_Editbox_Name_Text", 0, 0)
	Frame_Properties_Editbox_Name_Button:EnableMouse(true)
	Frame_Properties_Editbox_Name_Button:SetSize(90, 20)
	Frame_Properties_Editbox_Name_Button:SetText("Property Info:")
	Frame_Properties_Editbox_Name_Button:SetScript("OnMouseUp", function() POPUP_CONFIRM_NAME() PlaySound("GAMEDIALOGOPEN", "SFX") end)
	
	local Frame_Properties_Lease_Text_Button = CreateFrame("Button", "Frame_Properties_Lease_Text_Button", Frame_Properties_Editbox_Name_Button, "UIPanelButtonTemplate")
	Frame_Properties_Lease_Text_Button:SetPoint("CENTER", "Frame_Properties_Lease_Text", 0, 0)
	Frame_Properties_Lease_Text_Button:EnableMouse(true)
	Frame_Properties_Lease_Text_Button:SetSize(100, 20)
	Frame_Properties_Lease_Text_Button:SetText("Property Lease:")
	Frame_Properties_Lease_Text_Button:SetScript("OnMouseUp", function() POPUP_CONFIRM_LEASE() PlaySound("GAMEDIALOGOPEN", "SFX") end)
	
	local Frame_Properties_Service_Text_Button = CreateFrame("Button", "Frame_Properties_Service_Text_Button", Frame_Properties_Editbox_Name_Button, "UIPanelButtonTemplate")
	Frame_Properties_Service_Text_Button:SetPoint("CENTER", "Frame_Properties_Service_Text", 0, 0)
	Frame_Properties_Service_Text_Button:EnableMouse(true)
	Frame_Properties_Service_Text_Button:SetSize(150, 20)
	Frame_Properties_Service_Text_Button:SetText("Property Service Charge:")
	Frame_Properties_Service_Text_Button:SetScript("OnMouseUp", function() POPUP_CONFIRM_SERVICE_CHARGE() PlaySound("GAMEDIALOGOPEN", "SFX") end)
	Frame_Properties_Editbox_Name_Button:Hide()
	
	
end

Is_Owner_SETUP()

-- called when determining which menu to show


local function EnableButtons(bool)
	updated_count_silver_lease =  0
	updated_count_gold_lease =  0
	updated_count_copper_lease =  0
	updated_count_silver_fee =  0
	updated_count_gold_fee =  0
	updated_count_copper_fee =  0
	silver_entry = 1999999
	gold_entry = 1999998
	copper_entry = 1999997
	if bool == true then
		Frame_Properties_Button_Silver:SetScript("OnMouseUp", function(self, button) 
			local Quantity = tonumber(Frame_Properties_Button_Silver_Text:GetText())
			modifier = 1
			if IsShiftKeyDown() then
				modifier = 5
			end
			
			if button == "LeftButton" then
				if Quantity + modifier >= 100 then
					print("[Property System]: You cannot go any higher.")
					return false
				end
				
				updated_count_silver_lease = updated_count_silver_lease + modifier
				
				Frame_Properties_Button_Silver_Text:SetText(Quantity + modifier) 
				GameTooltip:SetText("(" ..updated_count_silver_lease.. ") " ..Frame_Properties_Button_Silver_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMEOPEN", "SFX")
			elseif button == "RightButton" then 
				if Quantity - modifier <= -1 then
					print("[Property System]: You cannot go any lower.")
					return false
				end
				
				updated_count_silver_lease = updated_count_silver_lease - modifier
				
				Frame_Properties_Button_Silver_Text:SetText(Quantity - modifier) 
				GameTooltip:SetText("(" ..updated_count_silver_lease.. ") " ..Frame_Properties_Button_Silver_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMECLOSE", "SFX") 
			end 
		end)
		Frame_Properties_Button_Silver:SetScript("OnEnter", function(self, button)
			itemName, itemLink = GetItemInfo(silver_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText("(" ..updated_count_silver_lease.. ") " ..Frame_Properties_Button_Silver_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Gold:SetScript("OnMouseUp", function(self, button) 
			local Quantity = tonumber(Frame_Properties_Button_Gold_Text:GetText())
			modifier = 1
			if IsShiftKeyDown() then
				modifier = 5
			end
			
			
			if button == "LeftButton" then		
				updated_count_gold_lease = updated_count_gold_lease + modifier
				
				Frame_Properties_Button_Gold_Text:SetText(Quantity + modifier) 
				GameTooltip:SetText("(" ..updated_count_gold_lease.. ") " ..Frame_Properties_Button_Gold_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMEOPEN", "SFX") 
			elseif button == "RightButton" then 
				if Quantity - modifier <= -1 then
					print("[Property System]: You cannot go any lower.")
					return false
				end
				
				updated_count_gold_lease = updated_count_gold_lease - modifier
				
				Frame_Properties_Button_Gold_Text:SetText(Quantity - modifier) 
				GameTooltip:SetText("(" ..updated_count_gold_lease.. ") " ..Frame_Properties_Button_Gold_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMECLOSE", "SFX") 
			end 
		end)
		Frame_Properties_Button_Gold:SetScript("OnEnter", function(self, button)
			itemName, itemLink = GetItemInfo(gold_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText("(" ..updated_count_gold_lease.. ") " ..Frame_Properties_Button_Gold_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Copper:SetScript("OnMouseUp", function(self, button) 
			local Quantity = tonumber(Frame_Properties_Button_Copper_Text:GetText())
			modifier = 1
			if IsShiftKeyDown() then
				modifier = 5
			end
			
			if button == "LeftButton" then
				if Quantity + modifier >= 100 then
					print("[Property System]: You cannot go any higher.")
					return false
				end
				
				updated_count_copper_lease = updated_count_copper_lease + modifier
				
				Frame_Properties_Button_Copper_Text:SetText(Quantity + modifier) 
				GameTooltip:SetText("(" ..updated_count_copper_lease.. ") " ..Frame_Properties_Button_Copper_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMEOPEN", "SFX") 
			elseif button == "RightButton" then 
				if Quantity - modifier <= 0 then
					print("[Property System]: You cannot go any lower.")
					return false
				end
				
				updated_count_copper_lease = updated_count_copper_lease - modifier
				
				Frame_Properties_Button_Copper_Text:SetText(Quantity - modifier) 
				GameTooltip:SetText("(" ..updated_count_copper_lease.. ") " ..Frame_Properties_Button_Copper_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMECLOSE", "SFX") 
			end 
		end)
		Frame_Properties_Button_Copper:SetScript("OnEnter", function(self, button)
			itemName, itemLink = GetItemInfo(copper_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText("(" ..updated_count_copper_lease.. ") " ..Frame_Properties_Button_Copper_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Silver_Service:SetScript("OnMouseUp", function(self, button) 
			local Quantity = tonumber(Frame_Properties_Button_Silver_Service_Text:GetText())
			modifier = 1
			if IsShiftKeyDown() then
				modifier = 5
			end
			
			if button == "LeftButton" then
				if Quantity + modifier >= 100 then
					print("[Property System]: You cannot go any higher.")
					return false
				end
				
				updated_count_silver_fee = updated_count_silver_fee + modifier
				
				Frame_Properties_Button_Silver_Service_Text:SetText(Quantity + modifier) 
				GameTooltip:SetText("(" ..updated_count_silver_fee.. ") " ..Frame_Properties_Button_Silver_Service_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMEOPEN", "SFX") 
			elseif button == "RightButton" then 
				if Quantity - modifier <= -1 then
					print("[Property System]: You cannot go any lower.")
					return false
				end
				
				updated_count_silver_fee = updated_count_silver_fee - modifier
				
				Frame_Properties_Button_Silver_Service_Text:SetText(Quantity - modifier) 
				GameTooltip:SetText("(" ..updated_count_silver_fee.. ") " ..Frame_Properties_Button_Silver_Service_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMECLOSE", "SFX") 
			end 
		end)
		Frame_Properties_Button_Silver_Service:SetScript("OnEnter", function(self, button)
			itemName, itemLink = GetItemInfo(silver_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText("(" ..updated_count_silver_fee.. ") " ..Frame_Properties_Button_Silver_Service_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Gold_Service:SetScript("OnMouseUp", function(self, button) 
			local Quantity = tonumber(Frame_Properties_Button_Gold_Service_Text:GetText())
			modifier = 1
			if IsShiftKeyDown() then
				modifier = 5
			end
			
			if button == "LeftButton" then	

				updated_count_gold_fee = updated_count_gold_fee + modifier
			
				Frame_Properties_Button_Gold_Service_Text:SetText(Quantity + modifier) 
				GameTooltip:SetText("(" ..updated_count_gold_fee.. ") " ..Frame_Properties_Button_Gold_Service_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMEOPEN", "SFX") 
			elseif button == "RightButton" then 
				if Quantity - modifier <= -1 then
					print("[Property System]: You cannot go any lower.")
					return false
				end
				
				updated_count_gold_fee = updated_count_gold_fee - modifier
				
				Frame_Properties_Button_Gold_Service_Text:SetText(Quantity - modifier) 
				GameTooltip:SetText("(" ..updated_count_gold_fee.. ") " ..Frame_Properties_Button_Gold_Service_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMECLOSE", "SFX") 
			end 
		end)
		Frame_Properties_Button_Gold_Service:SetScript("OnEnter", function(self, button)
			itemName, itemLink = GetItemInfo(gold_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText("(" ..updated_count_gold_fee.. ") " ..Frame_Properties_Button_Gold_Service_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Copper_Service:SetScript("OnMouseUp", function(self, button) 
			local Quantity = tonumber(Frame_Properties_Button_Copper_Service_Text:GetText())
			modifier = 1
			if IsShiftKeyDown() then
				modifier = 5
			end
			
			if button == "LeftButton" then
				if Quantity + modifier >= 100 then
					print("[Property System]: You cannot go any higher.")
					return false
				end
				
				updated_count_copper_fee = updated_count_copper_fee + modifier
				
				Frame_Properties_Button_Copper_Service_Text:SetText(Quantity + modifier) 
				GameTooltip:SetText("(" ..updated_count_copper_fee.. ") " ..Frame_Properties_Button_Copper_Service_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMEOPEN", "SFX") 
			elseif button == "RightButton" then 
				if Quantity - modifier <= 0 then
					print("[Property System]: You cannot go any lower.")
					return false
				end
				
				updated_count_copper_fee = updated_count_copper_fee - modifier
				
				Frame_Properties_Button_Copper_Service_Text:SetText(Quantity - modifier) 
				GameTooltip:SetText("(" ..updated_count_copper_fee.. ") " ..Frame_Properties_Button_Copper_Service_Text:GetText().. "x " ..itemLink)
				PlaySound("INTERFACESOUND_MONEYFRAMECLOSE", "SFX") 
			end 
		end)	
		Frame_Properties_Button_Copper_Service:SetScript("OnEnter", function(self, button)
			itemName, itemLink = GetItemInfo(copper_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText("(" ..updated_count_copper_fee.. ") " ..Frame_Properties_Button_Copper_Service_Text:GetText().. "x " ..itemLink)
		end)
	else
		Frame_Properties_Button_Silver:SetScript("OnMouseUp", function(self, button) end)
		Frame_Properties_Button_Gold:SetScript("OnMouseUp", function(self, button) end)
		Frame_Properties_Button_Copper:SetScript("OnMouseUp", function(self, button) end)
		Frame_Properties_Button_Silver_Service:SetScript("OnMouseUp", function(self, button) end)
		Frame_Properties_Button_Gold_Service:SetScript("OnMouseUp", function(self, button) end)
		Frame_Properties_Button_Copper_Service:SetScript("OnMouseUp", function(self, button) end)
		Frame_Properties_Button_Silver:SetScript("OnEnter", function(self)
			itemName, itemLink = GetItemInfo(silver_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText(Frame_Properties_Button_Silver_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Gold:SetScript("OnEnter", function(self)
			itemName, itemLink = GetItemInfo(gold_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText(Frame_Properties_Button_Gold_Text:GetText().. "x " ..itemLink)
		end)	
		Frame_Properties_Button_Copper:SetScript("OnEnter", function(self)
			itemName, itemLink = GetItemInfo(copper_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText(Frame_Properties_Button_Copper_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Silver_Service:SetScript("OnEnter", function(self)
			itemName, itemLink = GetItemInfo(silver_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText(Frame_Properties_Button_Silver_Service_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Gold_Service:SetScript("OnEnter", function(self)
			itemName, itemLink = GetItemInfo(gold_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText(Frame_Properties_Button_Gold_Service_Text:GetText().. "x " ..itemLink)
		end)
		Frame_Properties_Button_Copper_Service:SetScript("OnEnter", function(self)
			itemName, itemLink = GetItemInfo(copper_entry)
			GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
			GameTooltip:SetText(Frame_Properties_Button_Copper_Service_Text:GetText().. "x " ..itemLink)
		end)	
	end
end

function PropertyHandlers.Show_Frame_Properties(player, is_gm, is_confirmed, property_name, gold_count_fee, silver_count_fee, copper_count_fee, gold_count_lease, silver_count_lease, copper_count_lease, property_type, gender, race, is_owner, character)
	-- converts the property type to an image when used
	race = tostring(race)
	
	local type_to_image = {
		["None"] = "Interface/paperdoll/ui-paperdoll-slot-bag.blp",
		["Tavern"] = "Interface/images/new_beer.blp",
		["Mine"] = "Interface/images/goldmine.blp",
		["Farm"] = "Interface/images/NightElfBuild.blp",
		["Lumber Mill"] = "Interface/images/HumanLumber.blp",
		["Stables"] = "Interface/images/Horse.blp",
		["Library"] = "Interface/ICONS/INV_Misc_Book_06.blp",
		["Training Grounds"] = "Interface/ICONS/Trade_archaeology_troll_voodoodoll.blp",
		["Butcher"] = "Interface/ICONS/Inv_misc_1h_innmeatcleaver_a_01.blp",
		["Tannery"] = "Interface/ICONS/Trade_leatherworking.blp",
		["Papyrus Farm"] = "Interface/ICONS/Inv_misc_paperbundle03d.blp",
		["Cotton Farm"] = "Interface/ICONS/INV_Fabric_Wool_02.blp",
		["Herb Farm"] = "Interface/ICONS/trade_herbalism.blp",
		["House"] = "Interface/ICONS/inv_misc_key_15.blp",
	}
	
	-- array set for character portrait icons. 2 = male, 3 = female
	char_icons_male = {
	["0"] = "Interface/paperdoll/ui-paperdoll-slot-bag.blp",
	["1"] = "Interface/ICONS/Achievement_Character_Human_Male.blp",
	["3"] = "Interface/ICONS/Achievement_Character_Dwarf_Male.blp",
	["4"] = "Interface/ICONS/Achievement_Character_Nightelf_Male.blp",
	["7"] = "Interface/ICONS/Achievement_Character_Gnome_Male.blp",
	["11"] = "Interface/ICONS/Achievement_Character_Draenei_Male.blp",
	["2"] = "Interface/ICONS/Achievement_Character_Orc_Male.blp",
	["5"] = "Interface/ICONS/Achievement_Character_Undead_Male.blp",
	["5"] = "Interface/ICONS/Achievement_Character_Undead_Male.blp",
	["6"] = "Interface/ICONS/Achievement_Character_Tauren_Male.blp",
	["10"] = "Interface/ICONS/Achievement_Character_Bloodelf_Male.blp",
	["8"] = "Interface/ICONS/Achievement_Character_Troll_Male.blp",
	}
	
	char_icons_female = {
	["0"] = "Interface/paperdoll/ui-paperdoll-slot-bag.blp",
	["1"] = "Interface/ICONS/Achievement_Character_Human_Female.blp",
	["3"] = "Interface/ICONS/Achievement_Character_Dwarf_Female.blp",
	["4"] = "Interface/ICONS/Achievement_Character_Nightelf_Female.blp",
	["7"] = "Interface/ICONS/Achievement_Character_Gnome_Female.blp",
	["11"] = "Interface/ICONS/Achievement_Character_Draenei_Female.blp",
	["2"] = "Interface/ICONS/Achievement_Character_Orc_Female.blp",
	["5"] = "Interface/ICONS/Achievement_Character_Undead_Female.blp",
	["5"] = "Interface/ICONS/Achievement_Character_Undead_Female.blp",
	["6"] = "Interface/ICONS/Achievement_Character_Tauren_Female.blp",
	["10"] = "Interface/ICONS/Achievement_Character_Bloodelf_Female.blp",
	["8"] = "Interface/ICONS/Achievement_Character_Troll_Female.blp",
	}	

	Frame_Properties_Editbox_Name_Icon_Type:SetNormalTexture(type_to_image[property_type])
	Frame_Properties_Editbox_Name_Icon_Type:SetPushedTexture(type_to_image[property_type])
	
	if gender == 0 then
		-- male
		Frame_Properties_Editbox_Name_Icon_Owner:SetNormalTexture(char_icons_male[race])
		Frame_Properties_Editbox_Name_Icon_Owner:SetPushedTexture(char_icons_male[race])
	else
		Frame_Properties_Editbox_Name_Icon_Owner:SetNormalTexture(char_icons_female[race])
		Frame_Properties_Editbox_Name_Icon_Owner:SetPushedTexture(char_icons_female[race])		
	end
	
	Frame_Properties_Editbox_Name_Icon_Owner:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetText("Owner:\n" ..character)
	end)
	Frame_Properties_Editbox_Name_Icon_Owner:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	Frame_Properties_Button_Gold_Service_Text:SetText(gold_count_fee)
	Frame_Properties_Button_Silver_Service_Text:SetText(silver_count_fee)
	Frame_Properties_Button_Copper_Service_Text:SetText(copper_count_fee)
	Frame_Properties_Button_Gold_Text:SetText(gold_count_lease)
	Frame_Properties_Button_Silver_Text:SetText(silver_count_lease)
	Frame_Properties_Button_Copper_Text:SetText(copper_count_lease)
	
	-- when the editbox should be shown
	-- when gm is true and in setup modifiere
	Frame_Properties_Inventory:Hide()
	if is_gm == true and is_confirmed == 0 then
		Frame_Properties_Editbox_Name:SetText(property_name)
		Frame_Properties_Editbox_Name:Show()
		Frame_Properties_Editbox_Name_Text2:Hide()	
		Frame_Properties:SetSize(260, 470)
		Frame_PropertiesGM_DropDown_Descriptor:Show()
		Frame_Properties_Text1:SetText("[GM modifierE] Properties UI")
		bool = true
		EnableButtons(bool)
		Frame_Properties_Button_Purchase_Property:Hide()
		Frame_Properties_Editbox_Name_Button:Hide()
		Frame_PropertiesGM_DropDown_Link:Show()
		Frame_PropertiesGM_DropDown_Link:SetPoint("TOP", "Frame_PropertiesGM_DropDown_Descriptor", "TOP", 0, -150)
	-- when player is owner
	elseif is_owner == true and is_confirmed == 1 then
		Frame_Properties_Editbox_Name:SetText(property_name)
		Frame_Properties_Editbox_Name:Show()
		Frame_Properties_Editbox_Name_Text2:Hide()	
		Frame_Properties_Text1:SetText("[OWNER] Properties UI")
		bool = true
		EnableButtons(bool)
		Frame_Properties:SetSize(260, 230)
		Frame_Properties_Button_Purchase_Property:Hide()	
		Frame_PropertiesGM_DropDown_Descriptor:Hide()
		Frame_Properties_Editbox_Name_Button:Show()
		Frame_PropertiesGM_DropDown_Link:Hide()
		Frame_Properties_Inventory_Button_Open:Show()
		if is_gm == true then
			Frame_PropertiesGM_DropDown_Link:Show()
			Frame_Properties:SetSize(260, 280)
			Frame_PropertiesGM_DropDown_Link:SetPoint("TOP", "Frame_Properties", "TOP", 0, -235)
		end
	elseif is_confirmed == 1 then
	-- when player is not owner or gm
		Frame_Properties_Editbox_Name_Text2:SetText(property_name)
		Frame_Properties_Editbox_Name:Hide()
		Frame_Properties_Editbox_Name_Text2:Show()
--		Frame_Properties:SetSize(260, 230)
		Frame_Properties:SetSize(260, 270)
		Frame_PropertiesGM_DropDown_Descriptor:Hide()
		Frame_Properties_Text1:SetText("Properties UI")
		bool = false
		EnableButtons(bool)
		Frame_Properties_Button_Purchase_Property:Show()
		Frame_Properties_Editbox_Name_Button:Hide()
		Frame_PropertiesGM_DropDown_Link:Hide()
		Frame_Properties_Inventory_Button_Open:Hide()
		if is_gm == true then
			Frame_PropertiesGM_DropDown_Link:Show()
			Frame_Properties:SetSize(260, 320)
			Frame_PropertiesGM_DropDown_Link:SetPoint("TOP", "Frame_Properties", "TOP", 0, -275)
		end
	else
		print("[Property System]: This property is not entirely setup yet.")
		return false
	end

	Frame_Properties:Show()
end

function PropertyHandlers.POPUP_SERVICE(player, service_fee, object_guid, object_entry, spell)
	spell_link = GetSpellLink(spell)
	StaticPopupDialogs["CONFIRM_SERVICE"] = {
	  text = "You are about to operate within a property and will be required to pay a service fee of " ..service_fee.. ". Doing so will cast spell " ..spell_link.. " Continue?",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		object_guid = object_guid
		object_entry = object_entry
		AIO.Handle("Properties", "Service_Confirm", object_guid, object_entry)
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_SERVICE")
end

function POPUP_GM_CONFIRM()
	StaticPopupDialogs["POPUP_GM_CONFIRM"] = {
	  text = "You are about to confirm a property with the shown settings. Please make sure these are correct before continuing, as this menu will be lost.",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		property_name = Frame_Properties_Editbox_Name:GetText()
		lease_gold = Frame_Properties_Button_Gold_Text:GetText()
		lease_silver = Frame_Properties_Button_Silver_Text:GetText()
		lease_copper = Frame_Properties_Button_Copper_Text:GetText()
		fee_gold = Frame_Properties_Button_Gold_Service_Text:GetText()
		fee_silver = Frame_Properties_Button_Silver_Service_Text:GetText()
		fee_copper = Frame_Properties_Button_Copper_Service_Text:GetText()
		property_type = UIDropDownMenu_GetText(Frame_PropertiesGM_DropDown_Descriptor)
		item_entries = Frame_PropertiesGM_Editbox_Item_Entry:GetText()
		item_quantities = Frame_PropertiesGM_Editbox_Item_Quantities:GetText()
		print(property_name, lease_gold, lease_silver, lease_copper, fee_gold, fee_silver, fee_copper, property_type, item_entries, item_quantities)
		if property_name == "" or property_name == "None" then
			print("[Property System]: You must input a name.")
			return false
		elseif item_entries == nil or item_entries == "" then
			print("[Property System]: You must input item entries. You can input multiple, separated by spaces.")
			return false
		elseif item_quantities == nil  or item_quantities == "" then
			print("[Property System]: You must input quantities related to your item. If your first item produces 1, then the first entry here is 1.")
			return false
		elseif property_type == "None" then
			print("[Property System]: You must define a property descriptor.")
			return false
		end
		AIO.Handle("Properties", "GM_Confirm", property_name, lease_gold, lease_silver, lease_copper, fee_gold, fee_silver, fee_copper, property_type, item_entries, item_quantities, property_type)
		Frame_Properties:Hide()
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("POPUP_GM_CONFIRM")
end

function POPUP_GM_LINK()
	object = UIDropDownMenu_GetText(Frame_PropertiesGM_DropDown_Link)
	object_entry = objects[object]
	StaticPopupDialogs["POPUP_CONFIRM_LEASE"] = {
	  text = "You are about to scan for objects in a 300 yard radius with the object name:entry " ..object.. ":" ..objects[object].. " and bind them to this property NPC. Continue?",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		if object == "None" then
			print("[Property System]: You cannot link no gameobjects.")
			return false
		end
		
		AIO.Handle("Properties", "GM_Link", object_entry)
		Frame_Properties:Hide()
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("POPUP_CONFIRM_LEASE")	
end

function POPUP_PURCHASE_PROPERTY_CONFIRM()
	property_name = Frame_Properties_Editbox_Name_Text2:GetText()
	lease_gold = Frame_Properties_Button_Gold_Text:GetText()
	lease_silver = Frame_Properties_Button_Silver_Text:GetText()
	lease_copper = Frame_Properties_Button_Copper_Text:GetText()
	StaticPopupDialogs["POPUP_PURCHASE_PROPERTY_CONFIRM"] = {
	  text = "You are about to purchase this property for " ..lease_gold.. " Gold " ..lease_silver.. " Silver " ..lease_copper.. " Copper. Continue?",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		AIO.Handle("Properties", "Purchase_Property_Confirm")
		Frame_Properties:Hide()
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("POPUP_PURCHASE_PROPERTY_CONFIRM")
end

function POPUP_CONFIRM_NAME()
	property_name = Frame_Properties_Editbox_Name:GetText()
	StaticPopupDialogs["POPUP_CONFIRM_NAME"] = {
	  text = "You are about to rename this property to '" ..property_name.. "'. Continue?",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		AIO.Handle("Properties", "Property_Name_Confirm", property_name)
		Frame_Properties:Hide()
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("POPUP_CONFIRM_NAME")
end

function POPUP_CONFIRM_LEASE()
	lease_gold = Frame_Properties_Button_Gold_Text:GetText()
	lease_silver = Frame_Properties_Button_Silver_Text:GetText()
	lease_copper = Frame_Properties_Button_Copper_Text:GetText()
	StaticPopupDialogs["POPUP_CONFIRM_LEASE"] = {
--	  text = "You are about to deposit " ..updated_count_gold_lease.. " Gold " ..updated_count_silver_lease.. " Silver " ..updated_count_copper_lease.. " Copper to increase the lease of this property to " ..lease_gold.. " Gold " ..lease_silver.. " Silver " ..lease_copper.. " Copper. Continue?",
	  text = "You are about to set the price of this property to " ..lease_gold.. " Gold " ..lease_silver.. " Silver" ..lease_copper.. " Copper. This will toggle availability for your property to be sold. Continue?",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		AIO.Handle("Properties", "Property_Lease_Confirm", lease_gold, lease_silver, lease_copper)
		Frame_Properties:Hide()
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("POPUP_CONFIRM_LEASE")
end

function POPUP_CONFIRM_SERVICE_CHARGE()
	fee_gold = Frame_Properties_Button_Gold_Service_Text:GetText()
	fee_silver = Frame_Properties_Button_Silver_Service_Text:GetText()
	fee_copper = Frame_Properties_Button_Copper_Service_Text:GetText()
	StaticPopupDialogs["POPUP_CONFIRM_SERVICE_CHARGE"] = {
	  text = "You are about to set the service charge of this property to " ..fee_gold.. " Gold " ..fee_silver.. " Silver " ..fee_copper.. " Copper. Continue?",
	  button1 = "Continue",
	  button2 = "Decline",
	  OnAccept = function()
		AIO.Handle("Properties", "Property_Service_Confirm", fee_gold, fee_silver, fee_copper)
		Frame_Properties:Hide()
	  end,
	  OnDecline = function()
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("POPUP_CONFIRM_SERVICE_CHARGE")
end



-- called to close menus on confirm etc
function PropertyHandlers.Close_Menus(player)
	Frame_Properties:Hide()
end

Frame_Properties:Hide()