-- Description:
-- This script contains information as to how the client autotrains on a trainer show.
-- Author: grimreapaa

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local AutoTrain = AIO.AddHandlers("Auto_Train", {})

-- by using /framestack in-game, we can see the trainer frame is called ClassTrainerFrame.
-- to target the object correctly, we put it in an array.
local TrainerFrame = {
	ClassTrainerFrame,
}

-- placeholder variable that stops redundant firing of the script
thing = 0

Catch_Frame = CreateFrame("Frame", nil, UIParent)
Catch_Frame:SetScript("OnUpdate", function()
	if (ClassTrainerFrame == nil) then
		return
    elseif (ClassTrainerFrame:IsVisible()) and thing == 0 then
		-- the following script is from the community.
		-- here we forcibly insert the text into the main chat frame, and send it. other methods only send the raw text as a chat, or do not work at all.
		script_to_run = '/run LoadAddOn"Blizzard_TrainerUI" f=ClassTrainerTrainButton f.e = 0 if f:GetScript"OnUpdate" then f:SetScript("OnUpdate", nil)else f:SetScript("OnUpdate", function(f,e) f.e=f.e+e if f.e>.01 then f.e=0 f:Click() end end)end'
		DEFAULT_CHAT_FRAME.editBox:SetText(script_to_run)
		ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0) 
		thing = 1
	elseif (ClassTrainerFrame:IsVisible()) == false and thing == 1 then
		thing = 0
	end
end)