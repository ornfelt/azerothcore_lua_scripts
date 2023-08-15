local timer = 1 -- speed to eliminate the chance of double clicking exploit.
local itemid = 63022
local VIP_Title_Start = 400

local VIP_TITLE = {
			[1] = {"<`name` The VIP>",},
			[2] = {"<VIP>`name`",},
			[3] = {"`name`<VIP>",},
			[4] = {"<VIP>`name`<VIP>",},
			[5] = {"<TANK>`name`",},
			[6] = {"<HEALER>`name`",},
			[7] = {"<RUNNER>`name`",},
			[8] = {"<MASTER>`name`",},
			[9] = {"<LORD>`name`",},
			[10] = {"<OVERLOARD>`name`",},
			[11] = {"<Evil Doer>`name`",},
			[12] = {"`name` The Destroyer",},
			[13] = {"`name` The Monster",},
--			[14] = {"<GuildMaster>%s",},
				};
				

local function RemoveVIP_Title_Stone(event, timer, cycles, player)
	player:RemoveItem(itemid, 1)
	player:SendBroadcastMessage("!! You Have Been Titled !!")
end

local function VIP_Title_Stone_On_Hello(event, player, unit)
	for a=1,#VIP_TITLE do

		if(player:HasTitle((VIP_Title_Start + (a - 1)))==false)then
			player:GossipMenuAddItem(5,VIP_TITLE[a][1], 0, a)
		else
		end
	end
	
	
	player:GossipMenuAddItem(5,"good bye.", 0, 1000)
	player:GossipSendMenu(1, unit)
end

function VIP_Title_Stone_On_Select(event, player, item, effindex, intid)

	if(intid==1000)then
	
		player:GossipComplete()

	else

		player:GossipComplete(title)
		player:SetKnownTitle(VIP_Title_Start + (intid - 1))
		player:RegisterEvent(RemoveVIP_Title_Stone, timer, 1, player)
		
	end
end
		
RegisterItemGossipEvent(itemid, 1, VIP_Title_Stone_On_Hello)
RegisterItemGossipEvent(itemid, 2, VIP_Title_Stone_On_Select)
print("Grumbo'z VIP Title Stone loaded.")
