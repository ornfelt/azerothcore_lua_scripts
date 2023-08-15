function CryptQuest_OnSpawn(pUnit, Event)
	pUnit:CastSpell(1784)
end

RegisterUnitEvent(930004, 18, "CryptQuest_OnSpawn")

function CryptQuest_OnAccept(event, pPlayer, QuestId, pQuestGiver)
	if(QuestId == 930000) then
		pQuestGiver:RemoveAura(1784)
		pQuestGiver:CastSpell(8696)
		pQuestGiver:SendChatMessage(12, 0, "Well.. goodbye then!")
		pQuestGiver:MoveTo(0, -11060, -1783, 52, 3)
		pQuestGiver:RegisterEvent("MoveTo_Vanish", 3000, 1)
		end
end

function MoveTo_Vanish(pUnit, event)
	pUnit:MoveTo(0, -11067.853516, -1820.536743, 57.830597)
	pUnit:Despawn(1000, 1)
end

RegisterServerHook(14, "CryptQuest_OnAccept")
	
	