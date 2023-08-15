TABLE = {}

function GetClass(pPlayer)
	assert(type(pPlayer)=="userdata","Bad argument to GetClass - expected userdata, got "..type(pPlayer)..".");
        local q = CharDBQuery("SELECT `class` FROM `characters` WHERE `name` = '"..pPlayer:GetName().."';");
        if not q or not q:GetColumn(0):GetString() then return nil; end 
        return q:GetColumn(0):GetUShort();
end

local ITEMID = 99994

function TABLE.TrainerStone(pItem, event, player)
	pItem:GossipCreateMenu(1, player, 0)
	pItem:GossipMenuAddItem(0, "Spawn my trainer.", 1, 0)
	pItem:GossipMenuAddItem(2, "Weapon Trainer.", 12, 0)
	pItem:GossipMenuAddItem(2, "Food & Drink Vendor.", 14, 0)
	pItem:GossipMenuAddItem(2, "Remove Ressurection Sickness.", 13, 0)
	pItem:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pItem:GossipSendMenu(player)
end

function TABLE.TrainerStoneSelect(pItem, event, player, id, intid, pmisc)
	if(intid == 1) then
		if(TABLE[player:GetName()] ~= nil) and ((os.clock()-TABLE[player:GetName()])) <= 30 then
				player:SendAreaTriggerMessage("|cFFFF0000You cannot use this item yet!")
				player:GossipComplete()
		else
		TABLE[player:GetName()] = os.clock()
			if(GetClass(player) == 1) then
				player:SpawnCreature(16771, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 3) then
				player:SpawnCreature(5115, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 2) then
				player:SpawnCreature(16761, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 4) then
				player:SpawnCreature(1411, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 5) then
				player:SpawnCreature(4606, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 12) then
				player:SpawnCreature(28471, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 7) then
				player:SpawnCreature(3032, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 8) then
				player:SpawnCreature(16653, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 9) then
				player:SpawnCreature(3326, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 11) then
				player:SpawnCreature(4218, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
			elseif(GetClass(player) == 6) then
				player:SpawnCreature(28471, player:GetX(), player:GetY(), player:GetZ(), 0, 35, 60000)
				player:GossipComplete()
				end
	   	end
		 
	end

	if(intid == 2) then
		player:GossipComplete()
end




	if(intid == 12) then
		if(TABLE[player:GetName()] ~= nil) and ((os.clock()-TABLE[player:GetName()])) <= 30 then
			player:SendAreaTriggerMessage("|cFFFF0000You cannot use this item yet!")
			player:GossipComplete()
else
			TABLE[player:GetName()] = os.clock()
			player:GossipComplete()
			player:SpawnCreature(500011, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 35, 30000)
			end
end

	


	if (intid == 13) then
       		if (player:HasAura(15007) == true) then
           		player:SendBroadcastMessage("Resurrection Sickness has been removed. Be careful next time!")
         		player:RemoveAura(15007)
            		player:GossipComplete()
       		else
			player:SendBroadcastMessage("You do not have Resurrection Sickness!")
          		player:GossipComplete()
       		end
	end


	if(intid == 14) then
		if(TABLE[player:GetName()] ~= nil) and ((os.clock()-TABLE[player:GetName()])) <= 30 then
			player:SendAreaTriggerMessage("|cFFFF0000You cannot use this item yet!")
			player:GossipComplete()
else
			TABLE[player:GetName()] = os.clock()
			player:GossipComplete()
			player:SpawnCreature(29547, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 35, 30000)
			end
end
end	
RegisterItemGossipEvent(94026, 1, "TABLE.TrainerStone")
RegisterItemGossipEvent(94026, 2, "TABLE.TrainerStoneSelect")