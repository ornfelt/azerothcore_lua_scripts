function OnQuestAccept(event, pPlayer, pQuestGiver, questId)
pUnit:GetPhase()
pUnit:PhaseSet(2, 1, 241, 47)
pUnit:PhaseAdd(2, 1, 241, 47)
pUnit:PhaseDelete(2, 1, 241, 47)
end

RegisterQuestEvent(14, 1, "OnQuestAccept")