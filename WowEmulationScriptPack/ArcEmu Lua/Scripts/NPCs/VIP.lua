function Menu_OnGossip(pItem, event, player)

	local PlayerName = player:GetName()
	local GetPlayerACCT = CharDBQuery("SELECT acct FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	local GmRank = CharDBQuery("SELECT gm FROM accounts WHERE acct = '"..GetPlayerACCT.."'"):GetColumn(0):GetString()


	
	


	if (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You Can't use this in combat!")

	else
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(1, "Access VIP panel.", 1, 0)
		pItem:GossipMenuAddItem(1, "Nevermind.", 2, 0)
		pItem:GossipSendMenu(player)
	end
end

function Menu_OnGossipSelect(pItem, event, player, id, intid, pmisc)
	if(intid == 1) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(0, "Morph Tab.", 3, 0)
	--	pItem:GossipMenuAddItem(0, "VIP Locations.", 4, 0)
		pItem:GossipMenuAddItem(0, "Repair my gear.", 5, 0)
		pItem:GossipMenuAddItem(0, "Change Gender.", 6, 0)
		pItem:GossipMenuAddItem(0, "Set Title.", 101, 0)
		pItem:GossipMenuAddItem(0, "Redeem.", 7, 1)
		pItem:GossipMenuAddItem(0, "Nevermind.", 2, 0)
		pItem:GossipSendMenu(player)
	end
	if(intid == 2) then
		player:GossipComplete()
	end
	if(intid == 3) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(0, "Fat Human.", 23, 0)
		pItem:GossipMenuAddItem(0, "Fel Orc.", 24, 0)
		pItem:GossipMenuAddItem(0, "Male Goblin.", 25, 0)
		pItem:GossipMenuAddItem(0, "Female Goblin.", 26, 0)
		pItem:GossipMenuAddItem(0, "BE Male.", 28, 0)
		pItem:GossipMenuAddItem(0, "BE Female.", 29, 0)
		pItem:GossipMenuAddItem(0, "Gnome Male.", 30, 0)
		pItem:GossipMenuAddItem(0, "Gnome Female.", 31, 0)
		pItem:GossipMenuAddItem(0, "Demorph.", 20, 0)
		pItem:GossipMenuAddItem(0, "Nevermind.", 2, 0)
		pItem:GossipSendMenu(player)
	end
	if(intid == 4) then
		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(0, "Chill Out.", 10, 0)
		pItem:GossipMenuAddItem(0, "Nevermind.", 2, 0)
		pItem:GossipSendMenu(player)
	end
	if(intid == 10) then
		player:Teleport(530, -1866, 5423, 1530)
		player:GossipComplete()
	end
	if(intid == 5) then
		player:RepairAllPlayerItems()
		player:SendBroadcastMessage("All items repaired.")
		player:GossipComplete()
	end
	if(intid == 6) then
		local gender = player:GetGender()
		if (gender == 1) then
			player:SetGender(0)
			player:SendBroadcastMessage("Gender set to male, please relog.")
		else
			player:SetGender(1)
			player:SendBroadcastMessage("Gender set to female, please relog.")
		end
	end
	if(intid == 7) then
		local CQuery = WorldDBQuery("SELECT * FROM `redeem_codes`")
		for i=1, CQuery:GetRowCount() do
			if (CQuery:GetColumn(0):GetString() == pmisc) then
				if not (tonumber(CQuery:GetColumn(1):GetString()) == 1) then
					player:AddItem(tonumber(CQuery:GetColumn(2):GetString()), 1)
					player:SendBroadcastMessage("Well done!")
					WorldDBQuery("UPDATE `redeem_codes` SET `used` = '1' WHERE `code` = '"..pmisc.."'")
				else
					player:SendBroadcastMessage("This code is already used.")
				end
				return player:GossipComplete();
			end
			CQuery:NextRow()
		end
		player:SendBroadcastMessage("Wrong code.")
		player:GossipComplete()
	end
	if(intid == 8) then
		player:SetModel(21105)
		player:GossipComplete()
	end
	if(intid == 20) then
		player:DeMorph()
		player:GossipComplete()
	end
	if(intid == 21) then
		player:SetModel(18718)
		player:GossipComplete()
	end
	if(intid == 22) then
		player:SetModel(3597)
		player:GossipComplete()
	end
	if(intid == 23) then
		player:SetModel(103)
		player:GossipComplete()
	end
	if(intid == 24) then
		player:SetModel(21267)
		player:GossipComplete()
	end
	if(intid == 25) then
		player:SetModel(20582)
		player:GossipComplete()
	end
	if(intid == 26) then
		player:SetModel(20583)
		player:GossipComplete()
	end
	if(intid == 27) then
		player:SetModel(20585)
		player:GossipComplete()
	end
	if(intid == 28) then
		player:SetModel(20578)
		player:GossipComplete()
	end
	if(intid == 29) then
		player:SetModel(20579)
		player:GossipComplete()
	end
	if(intid == 30) then
		player:SetModel(20580)
		player:GossipComplete()
	end
	if(intid == 31) then
		player:SetModel(20581)
		player:GossipComplete()
	end
	if(intid == 9) then
		player:SetModel(21976)
		player:GossipComplete()
	end












if(intid == 101) then
		
player:SendBroadcastMessage("Please choose the Title you wish to have.") 


		pItem:GossipCreateMenu(1, player, 0)
		pItem:GossipMenuAddItem(0, "Further explanation.", 110, 0)
		pItem:GossipMenuAddItem(0, "Salty.", 52, 0)
		pItem:GossipMenuAddItem(0, "Starcaller.", 129, 0)
		pItem:GossipMenuAddItem(0, "The pilgrim.", 133, 0)
		pItem:GossipMenuAddItem(0, "Remove current Title.", 113, 0)
		pItem:GossipMenuAddItem(0, "Nevermind.", 2, 0)
		pItem:GossipSendMenu(player)

local PlayerName = player:GetName()
local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	

	local IsPlayerNil = CharDBQuery("SELECT guid FROM donate WHERE guid = '"..GetPlayerGUID.."'")
	
		if (IsPlayerNil == nil) then
			CharDBQuery("INSERT INTO donate VALUES ('"..GetPlayerGUID.."','"..PlayerName.."','')")		
		
	

		end

		

end

	if(intid == 110) then
		player:SendBroadcastMessage("You choose the Title you wish to have, till you choose another one.")
		player:SendBroadcastMessage("If you would like to choose another, self earned Title, then click at -Remove current Title- and relog.")
		player:GossipComplete()

	end


	if (intid == 113) then
		
		local PlayerName = player:GetName()
		local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()


	
			player:UnsetKnownTitle(intid)
			CharDBQuery("UPDATE donate SET current_title= '"..intid.."' WHERE guid="..GetPlayerGUID.."")
			player:SendAreaTriggerMessage("Removed Title!")
			player:GossipComplete()
	end


	if(intid == 52) or (intid == 129) or (intid == 133) then
		
		local PlayerName = player:GetName()
		local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()



			player:SetKnownTitle(intid)
			CharDBQuery("UPDATE donate SET current_title= '' WHERE guid='"..GetPlayerGUID.."'")
			player:SendAreaTriggerMessage("Changed Title!")
			player:GossipComplete()
	end
		


-- :UnsetKnownTitle(id)
-- :HasTitle(id)







end

RegisterItemGossipEvent(133337, 1, "Menu_OnGossip")
RegisterItemGossipEvent(133337, 2, "Menu_OnGossipSelect")