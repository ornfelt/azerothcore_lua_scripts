local quest_npc_id = 940008
local quest_id = 940015


function KillNPC_OnQuestFinished_A(event, pPlayer, questId, pQuestGiver)
	if (pQuestGiver:GetEntry() == quest_npc_id) then
		pQuestGiver:SendChatMessage(12, 0, "Thanks for helping, you could help my friend Gulrap now.")
		pPlayer:Teleport(560, 2564.408, 1833.5685, 55.1)
		pPlayer:FinishQuest(quest_id)
	end
end

RegisterServerHook(22, "KillNPC_OnQuestFinished_A")