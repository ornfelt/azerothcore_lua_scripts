-- Owner: grimreapaa

local AIO = AIO or require("AIO")

-- the current version needed to pass. can be edited by client, but the version info already can anyways so who cares about verifying it.
local CURRENT_VERSION = 12346

-- checks if client or not
if AIO.AddAddon() then
	return
end

local PlayerStartHandlers = AIO.AddHandlers("PStart", {})

-- REMOVES LFG BUTTON --
local MicroButtons = {
        AchievementMicroButton,
        QuestLogMicroButton,
        SocialsMicroButton,
        PVPMicroButton,
        LFDMicroButton,
        MainMenuMicroButton,
        HelpMicroButton
}

BI_i = CreateFrame("Frame", nil, UIParent)
BI_i:SetScript("OnUpdate", function()
    if (LFDMicroButton:IsVisible()) then
        LFDMicroButton:Hide()
        PVPMicroButton:Hide()
--        CharUpdatesMicroButton:Show()
    end

end)
BI_i:Show()
-- END REMOVES LFG BUTTON --

-- RUN SLEEP EMOTE ON PLAYER FIRST START --
function PlayerStartHandlers.OnFirst(player)
	DoEmote("sleep")
--	JoinChannelByName("ooc", nil, ChatFrame1:GetID())
--	JoinTemporaryChannel("ooc", nil, ChatFrame1:GetID());
--	JoinPermanentChannel("ooc", nil, ChatFrame1:GetID());
--	SendChatMessage("/join ooc", "SAY")
	DEFAULT_CHAT_FRAME.editBox:SetText("/join ooc")
	ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0) 
end
-- END RUN SLEEP EMOTE ON PLAYER FIRST START --


-- VERSION CHECK
local version, build, date, tocversion = GetBuildInfo()

if tonumber(build) ~= CURRENT_VERSION then
	AIO.Handle("PStart", "VersionCheck", build, CURRENT_VERSION)
end


