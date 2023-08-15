--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

dkenchants = {53341, 53343} -- not going to do all your work

function DonkeyKong_Runeforging(event, plr, spellid)
	if(plr:HasQuest(12842) == true) then -- If the player has the quest	
		if(questcomplete[plr:GetName()] == nil) then
			questcomplete[plr:GetName()] = 0;
		end
		if(questcomplete[plr:GetName()] == 1) then return end -- False proof
		if(spellid == dkenchants[1] or spellid == dkenchants[2]) then
			questcomplete[plr:GetName()] = 1;
			plr:AdvanceQuestObjective(12842, 1) -- +1 quest objective, fuck yeah
		end
	end
end

RegisterServerHook(10, "DonkeyKong_Runeforging")