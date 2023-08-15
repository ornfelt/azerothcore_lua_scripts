local npcid = 990001

function SkipNPC_OnGossipTalk(pUnit, event, player, pMisc)
	if (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You are in combat!") 
	else

		
		pUnit:SendChatMessage(12, 0, "You are about to skip the full chainquest from level sixty to eighty. We recommend to atleast get through the chainquest the first time. Skipping the chainquest will not influence your later gaming experience apart from a few miscellaneous items.")
		pUnit:GossipCreateMenu(98, player, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Skip the level sixty to eighty chainquest", 3, 0)	
		pUnit:GossipMenuAddItem(3, "Nevermind", 9, 0)
		pUnit:GossipSendMenu(player)
	end
end

function SkipNPC_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)

if (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You are in combat!") 
	else
		 pUnit:GossipCreateMenu(98, player, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Skip the level sixty to eighty chainquest", 3, 0)
		pUnit:GossipMenuAddItem(3, "Nevermind", 9, 0)

		pUnit:GossipSendMenu(player)
	end

		if(intid == 3) then
		pUnit:Emote(0, 2000)
		player:SetPhase(2)
		player:SendAreaTriggerMessage("Are you sure you want to skip the chainquest from level sixty to eighty? You will miss a great experience... ")
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080I am sure", 4, 0)
		pUnit:GossipMenuAddItem(3, "Nevermind", 9, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 4) then
	
	local levelcount = (player:GetPlayerLevel())
	local levelcount = 80 - levelcount

		player:SetLevel(player:GetPlayerLevel()+levelcount)
	

	pUnit:Emote(53, 2000)
	player:AddItem(94025, 1)
	player:AddItem(90131, 1)
	player:SetPhase(1)
	player:Teleport(619, 524.29, -564.56, 27)
	pUnit:Emote(0, 2000)
	
	end



	if(intid == 9) then
	player:SetPhase(1)
	end
end

RegisterUnitGossipEvent(990001, 1, "SkipNPC_OnGossipTalk")
RegisterUnitGossipEvent(990001, 2, "SkipNPC_OnGossipSelect")