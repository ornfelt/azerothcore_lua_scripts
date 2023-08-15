local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

local Quest = AIO.AddHandlers("Quest", {})


FrameTest = CreateFrame("Frame", "FrameQuest", UIParent, "UIPanelDialogTemplate")
local frame = FrameTest

frame:SetSize(200, 100)
frame:RegisterForDrag("LeftButton")
frame:SetPoint("CENTER")
frame:SetToplevel(true)
frame:SetClampedToScreen(true)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnHide", frame.StopMovingOrSizing)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:Hide()

local title = frame:CreateFontString("fntTitle")
title:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE, MONOCHROME")
title:SetShadowOffset(1, -1)
title:SetPoint("TOP", frame, "TOP", 0, -8)
title:SetText("Sidequest")
title:Show()

local can_complete = 0

local function click_complete(self, motion)
	--if(can_complete)then
	AIO.Handle("Quest", "CompleteQuest")
	--end
end

local prog_text = FrameTest:CreateFontString("fntTitle")
prog_text:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE, MONOCHROME")
prog_text:SetShadowOffset(1, -1)
prog_text:SetPoint("CENTER", FrameTest, "TOP", 0,-40)
prog_text:SetText("Get a Quest")
prog_text:Show()

local function CompleteButtonOnEnter(self, motion)
	if(can_complete)then
		FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Down.blp")
	else
		FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Disabled.blp")
	end
end 

local function CompleteButtonOnLeave(self, motion)
	if(can_complete)then
		FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Up.blp")
	else
		FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Disabled.blp")
	end
end

local FrameCompleteQuest = CreateFrame("Button", "FrameCompleteQuest", frame, nil)
FrameCompleteQuest:SetSize(100, 35)
FrameCompleteQuest:SetPoint("BOTTOMLEFT", 11, 1)
FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Disabled.blp")
FrameCompleteQuest:RegisterForDrag("LeftButton")
FrameCompleteQuest:SetToplevel(false)
FrameCompleteQuest:SetClampedToScreen(true)
FrameCompleteQuest:SetMovable(false)
FrameCompleteQuest:EnableMouse(true)
FrameCompleteQuest:SetScript("OnClick", click_complete)
FrameCompleteQuest:SetScript("OnDragStart", frame.StartMoving)
FrameCompleteQuest:SetScript("OnHide", frame.StopMovingOrSizing)
FrameCompleteQuest:SetScript("OnDragStop", frame.StopMovingOrSizing)
FrameCompleteQuest:SetScript("OnEnter", CompleteButtonOnEnter) 
FrameCompleteQuest:SetScript("OnLeave", CompleteButtonOnLeave)
FrameCompleteQuest:Show()

local reward_item_id;

local function ItemTooltipOnEnter1(self, motion)
	PlaySound(814)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM") 
	GameTooltip:SetHyperlink("item:"..reward_item_id)
   GameTooltip:Show() 
end 


local FrameRewardIcon = CreateFrame("Button", "FrameCompleteQuest", frame, nil)
FrameRewardIcon:SetSize(32, 32)
FrameRewardIcon:SetPoint("BOTTOMRIGHT", -10, 13)
FrameRewardIcon:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Disabled.blp")
FrameRewardIcon:RegisterForDrag("LeftButton")
FrameRewardIcon:SetToplevel(false)
FrameRewardIcon:SetClampedToScreen(true)
FrameRewardIcon:SetMovable(true)
FrameRewardIcon:EnableMouse(true)
FrameRewardIcon:SetScript("OnClick", click_complete)
FrameRewardIcon:SetScript("OnDragStart", frame.StartMoving)
FrameRewardIcon:SetScript("OnHide", frame.StopMovingOrSizing)
FrameRewardIcon:SetScript("OnDragStop", frame.StopMovingOrSizing)
FrameRewardIcon:SetScript("OnEnter", ItemTooltipOnEnter1) 
FrameRewardIcon:SetScript("OnLeave", function() GameTooltip:Hide() end)
FrameRewardIcon:Show()

local complete_text = FrameCompleteQuest:CreateFontString("fntTitle")
complete_text:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE, MONOCHROME")
complete_text:SetShadowOffset(1, -1)
complete_text:SetPoint("CENTER", FrameCompleteQuest, "CENTER", 0, 6)
complete_text:SetText("Complete")
complete_text:Show()

function Quest.Close()
	frame:Hide()
end



function Quest.ShowFrameQuest(p, name, current, required, reward_id, reward_amt)
    frame:Show()
    prog_text:SetText(name.." ("..current.."/"..required..")")
    if(current >= required)then
    	can_complete = 1;
    	FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Down.blp")
    else
    	can_complete = 0;
    	FrameCompleteQuest:SetNormalTexture("Interface\\BUTTONS\\UI-DialogBox-Button-Disabled.blp")
    end
	itemIcon = GetItemIcon(reward_id)
    FrameRewardIcon:SetNormalTexture(itemIcon)
	FrameRewardIcon:Show()
    reward_item_id = reward_id
end

function swapListValues(list, v1, v2)

end
