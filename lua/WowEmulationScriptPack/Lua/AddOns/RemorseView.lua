local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local RemorseviewHandlers = AIO.AddHandlers("RV", {})

local function GetItemInfoTexture(name)
	local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(name);
	return texture
end

-- ========== Containers ==========
local function ContainerFrame_Update_Hook(frame)
	local id = frame:GetID();
	local name = frame:GetName();
	local itemButton;
	local texture, itemCount, locked, quality, readable;
	for i=1, frame.size, 1 do
		itemButton = getglobal(name.."Item"..i);
		local itemLink = GetContainerItemLink(id, itemButton:GetID());
		
		if (itemLink) then
			texture = GetItemInfoTexture(itemLink);
		else
			texture = nil;
		end
		_, itemCount, locked, quality, readable = GetContainerItemInfo(id, itemButton:GetID());
		
		SetItemButtonTexture(itemButton, texture);
		SetItemButtonCount(itemButton, itemCount);
		SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);

		if ( texture ) then
			ContainerFrame_UpdateCooldown(id, itemButton);
			itemButton.hasItem = 1;
			itemButton.locked = locked;
			itemButton.readable = readable;
		else
			getglobal(name.."Item"..i.."Cooldown"):Hide();
			itemButton.hasItem = nil;
		end
	end
end

-- ========== Action Buttons ==========
local function ActionButton_Update_Hook()
	-- Special case code for bonus bar buttons
	-- Prevents the button from updating if the bonusbar is still in an animation transition
	if ( this.isBonus and this.inTransition ) then
		return;
	end

	local action = this.action;
	local icon = getglobal(this:GetName().."Icon");
	local texture = GetActionTexture(action);
	local name = this:GetName();
	local type, id, subType = GetActionInfo(action);
	if (texture == "Interface\\Icons\\INV_Misc_QuestionMark") and (type == "item") then
		texture = GetItemInfoTexture(id);
	elseif (texture == "Interface\\Icons\\INV_Misc_QuestionMark") and (type == "spell") then
		local spellName = GetSpellName(id, "General");
		if (spellName == "Attack") then
			texture = GetInventoryItemTexture("player",16);
		elseif (spellName == "Auto Shot") then
			texture = GetInventoryItemTexture("player",18);
		end
	end
	
	-- Update icon
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
	else
		icon:Hide();
	end

end

local function ActionButton_OnEvent_Hook(event)
	if (event == "PLAYER_AURAS_CHANGED") then
		ActionButton_Update();
	end
end

-- ========== Spellbook Attack Button ==========
local function SpellButton_UpdateButton_Hook()
	local id = SpellBook_GetSpellID(this:GetID());
	local name = this:GetName();
	local iconTexture = getglobal(name.."IconTexture");
	local spellString = getglobal(name.."SpellName");
	local subSpellString = getglobal(name.."SubSpellName");

	if (SpellBookFrame.bookType == BOOKTYPE_PET) then
		return;
	end

	local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
	local texture = GetSpellTexture(id, SpellBookFrame.bookType);
	if (texture == "Interface\\Icons\\INV_Misc_QuestionMark") then
		if (spellName == "Attack") then
			-- Texture for main hand weapon
			texture = GetInventoryItemTexture("player",16);
		elseif (spellName == "Auto Shot") then
			-- Texture for ranged weapon
			texture = GetInventoryItemTexture("player",18);
		end

		local highlightTexture = getglobal(name.."Highlight");
		local normalTexture = getglobal(name.."NormalTexture");
		-- If no spell, hide everything and return
		if ( not texture or (strlen(texture) == 0) ) then
			iconTexture:Hide();
			spellString:Hide();
			subSpellString:Hide();
			cooldown:Hide();
			autoCastableTexture:Hide();
			autoCastModel:Hide();
			highlightTexture:SetTexture("Interface\\Buttons\\ButtonHilight-Square");
			this:SetChecked(0);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
			return;
		end

		iconTexture:SetTexture(texture);
		iconTexture:Show();
		SpellButton_UpdateSelection();
	end
end
local function SpellButton_OnShow_Hook()
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
end
local function SpellButton_OnHide_Hook()
	this:UnregisterEvent("PLAYER_AURAS_CHANGED");
end
local function SpellButton_OnEvent_Hook(event)
	if (event == "PLAYER_AURAS_CHANGED" ) then
		SpellButton_UpdateButton();
	end
end

-- ========== Bank buttons ==========
local function BankFrameItemButton_Update_Hook(button)
	local texture = getglobal(button:GetName().."IconTexture");
	local inventoryID = button:GetInventorySlot();
	local textureName = GetInventoryItemTexture("player",inventoryID);
	local slotName = button:GetName();
	local id;
	local slotTextureName;
	button.hasItem = nil;

	if( button.isBag ) then
		id, slotTextureName = GetInventorySlotInfo(strsub(slotName,10));
		local itemLink = GetInventoryItemLink("player",id) 
		if (itemLink) then
			slotTextureName = GetItemInfoTexture(itemLink);
		end
	end
	
	local itemLink = GetInventoryItemLink("player",inventoryID) 
	if (itemLink) then
		textureName = GetItemInfoTexture(itemLink);
	end


	if ( textureName ) then
		texture:SetTexture(textureName);
		texture:Show();
		SetItemButtonCount(button,GetInventoryItemCount("player",inventoryID));
		button.hasItem = 1;
	elseif ( slotTextureName and button.isBag ) then
		texture:SetTexture(slotTextureName);
		SetItemButtonCount(button,0);
		texture:Show();
	else 
		texture:Hide();
		SetItemButtonCount(button,0);
	end

	BankFrameItemButton_UpdateLocked(button);
end

-- ========== Bag Slot Buttons ==========
local f = CreateFrame("Frame", nil, UIParent);
local nextUpdate = 1;
local function SetBagButtonTexture(id)
	local frame = getglobal("CharacterBag"..(id - 1).."SlotIconTexture");
	local name = GetBagName(id);
	if (name) and (frame) then
		local texture = GetItemInfoTexture(name);
		if (frame:GetTexture() ~= texture) then
			frame:SetTexture(texture);
		end
	end
end
local function BagSlotButton_UpdateChecked_Hook()
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		SetBagButtonTexture(i);
	end
end
function BagSlotButton_OnModifiedClick()
	if ( IsModifiedClick("OPENALLBAGS") ) then
		OpenAllBags();
	end
	BagSlotButton_UpdateChecked();
end
f:SetScript("OnUpdate", function (self, elapsed)
	nextUpdate = nextUpdate - elapsed;
	if (nextUpdate < 0) then
		BagSlotButton_UpdateChecked_Hook();
		nextUpdate = 1;
	end
end);

-- =========== Autoequip custom items on right-clicks to bag slots ==========
local origItemLink;
local function ContainerFrameItemButton_OnEnter_Hook(self)
	-- DEFAULT_CHAT_FRAME:AddMessage("(ContainerFrameItemButton_OnEnter) "..tostring(self), 1.0, 1.0, 0.2, 1);
	origItemLink = GetContainerItemLink(this:GetParent():GetID(), this:GetID());
end
local function ContainerFrameItemButton_OnClick_Hook(button)
	local bagID = this:GetParent():GetID();
	local slot = this:GetID();
	itemLink = GetContainerItemLink(bagID, slot);
	-- DEFAULT_CHAT_FRAME:AddMessage("(ContainerFrameItemButton_OnClick) "..tostring(itemLink)..", "..tostring(origItemLink), 1.0, 1.0, 0.2, 1);
	if (button == "RightButton") and (itemLink == origItemLink) then
		local _, _, _, _, _, itemType = GetItemInfo(itemLink);
		if (itemType == "Armor") or (itemType == "Weapon") then
			PickupContainerItem(bagID,slot)
			AutoEquipCursorItem();
			-- origItemLink = GetContainerItemLink(this:GetParent():GetID(), this:GetID());
		end
	end
	origItemLink = itemLink;
end


-- Secure Hooks
hooksecurefunc("ActionButton_OnEvent", ActionButton_OnEvent_Hook);
hooksecurefunc("ActionButton_Update", ActionButton_Update_Hook);
hooksecurefunc("BankFrameItemButton_Update", BankFrameItemButton_Update_Hook);
hooksecurefunc("BagSlotButton_UpdateChecked", BagSlotButton_UpdateChecked_Hook);
hooksecurefunc("ContainerFrame_Update", ContainerFrame_Update_Hook);
hooksecurefunc("ContainerFrameItemButton_OnEnter", ContainerFrameItemButton_OnEnter_Hook);
hooksecurefunc("ContainerFrameItemButton_OnClick", ContainerFrameItemButton_OnClick_Hook);
hooksecurefunc("SpellButton_OnEvent", SpellButton_OnEvent_Hook);
hooksecurefunc("SpellButton_OnHide", SpellButton_OnHide_Hook);
hooksecurefunc("SpellButton_OnShow", SpellButton_OnShow_Hook);
-- hooksecurefunc("SpellButton_UpdateButton", SpellButton_UpdateButton_Hook);

if( DEFAULT_CHAT_FRAME ) then
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8000Remorse View has loaded.|r");
end

WOW_GetContainerItemInfo = GetContainerItemInfo;

function GetContainerItemInfo(index, id)

local texture, itemCount, locked, quality, readable;
texture, itemCount, locked, quality, readable = WOW_GetContainerItemInfo(index, id);

if( texture and string.find(texture,"INV_Misc_QuestionMark") ) then
	local itemlink = GetContainerItemLink(index, id);
	local itemid = 0;

	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
	itemEquipLoc, itemTexture = GetItemInfo(itemlink)

	if( itemlink ) then
		_, _, itemid = string.find(itemlink, "Hitem:(%d+):");
		texture = itemTexture;
	end
end

return texture, itemCount, locked, quality, readable;

end