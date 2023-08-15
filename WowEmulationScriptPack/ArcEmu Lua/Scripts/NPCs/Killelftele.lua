local quest_npc_id = 940006
local quest_id = 940014


function KillNPC_OnQuestFinished(event, pPlayer, questId, pQuestGiver)
	if (pQuestGiver:GetEntry() == quest_npc_id) and (questId == quest_id) then


		pQuestGiver:SendChatMessage(12, 0, "You don't deserve to live!")
		pPlayer:FinishQuest(quest_id)
		pPlayer:Teleport(560, 1816.289, 1001.997, 19.4)
		
	end
end

RegisterServerHook(22, "KillNPC_OnQuestFinished")