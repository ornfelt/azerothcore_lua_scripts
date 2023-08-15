
local warriorspells = {1180, 201, 196, 198, 202, 197, 199, 227, 200, 266, 264, 5011, 9116}
local paladinspells = {201, 196, 198, 202, 197, 199, 200, 9116}
local hunterspells = {1180, 201, 196, 198, 202, 197, 266, 264, 5011}
local roguespells = {1180, 201, 196, 198, 266, 264, 5011}
local priestspells = {1180, 198, 227, 5009}
local deathknightspells = {1180, 201, 196, 198, 202, 197, 199}
local shamanspells = {1180, 198, 199, 9116}
local magespells = {201, 227, 5009, 1180}
local warlockspells = {227, 5009, 201, 1180}
local druidspells = {227, 198, 1180, 200}




function Chuck_OnGossipTalk(pUnit, event, plr, pMisc)

	pUnit:GossipCreateMenu(3544, plr, 0)
	pUnit:GossipMenuAddItem(2, "Stuff", 1, 0)
	pUnit:GossipSendMenu(plr)

end


function Chuck_OnGossipSelect(pUnit, event, plr, id, intid, code)
	if(intid == 1) then

	pUnit:Emote(70, 2000)
	pUnit:SendChatMessage(12, 0, "Hello there, "..plr:GetName().."! You will have the opportunity to choose between getting level 80 instantly, or by following the questline.")
	pUnit:SendChatMessage(12, 0, "If you want to skip the questline and get level 80, talk to Skipper, although you won't receive any additional rewards then.")
 	pUnit:SendChatMessage(12, 0, "If you choose to run the questline, then talk to Chromie. You will be busy with it around 4 hours, and afterwards, you will be royal rewarded, it is up to you!")



        plr:SetPhase(1)
	plr:SetHealthPct(100)
	plr:SetManaPct(100)       
                
      	plr:AdvanceAllSkills(300)
	end



	end
RegisterUnitGossipEvent(990002, 1, "Chuck_OnGossipTalk")
RegisterUnitGossipEvent(990002, 2, "Chuck_OnGossipSelect")