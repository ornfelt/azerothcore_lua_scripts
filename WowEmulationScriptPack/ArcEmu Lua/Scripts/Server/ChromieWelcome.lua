local NPC_ID = 940000
local QUEST_ID = 940000


function OnQuestAccept_A(event, pPlayer, pQuestGiver, questId)
	if(pQuestGiver == NPC_ID) then
		local quest_giver
		for _, v in pairs(pPlayer:GetInRangeUnits()) do
			if (v:GetEntry() == NPC_ID) then
				quest_giver = v;
			end
		end		
		quest_giver:SendChatMessage(12, 0, "Welcome to CNA WoW. You will follow the full chainquest to get level eighty, this will take around 2-3 hours depending on your experience with World of Warcraft. Everytime you are completing a quest, you will automatically get offered a new one. Always accept a quest if you see one!.")
    end
end

RegisterServerHook(14, "OnQuestAccept_A")