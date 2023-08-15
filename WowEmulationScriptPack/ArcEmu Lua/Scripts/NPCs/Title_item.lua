function Menu_OnGossip2(item, event, player)

local PlayerName = player:GetName()
local GetPlayerACCT = CharDBQuery("SELECT acct FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
local GmRank = CharDBQuery("SELECT gm FROM accounts WHERE acct = '"..GetPlayerACCT.."'"):GetColumn(0):GetString()

if not (GmRank == 'az') or (GmRank == 'p2') or (GmRank == 'p3') then
	player:SendAreaTriggerMessage("You aren't a [Package 2] donator!")
	player:GossipComplete()


elseif (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You Can't use this in combat!")
	else
		item:GossipCreateMenu(1, player, 0)
		item:GossipMenuAddItem(1, "Choose Title.", 1, 0)
		item:GossipMenuAddItem(1, "Nevermind.", 2, 0)
		item:GossipSendMenu(player)
	end
end



function Menu_OnGossipSelect2(pItem, event, player, id, intid, pmisc)
	
	
		
player:SendBroadcastMessage("Please choose the Title you wish to have.") 

if (intid == 1) then
		pItem:GossipCreateMenu(2345, player, 0)
		pItem:GossipMenuAddItem(0, "Further explanation.", 110, 0)
		pItem:GossipMenuAddItem(0, "Salty.", 51, 0)
		pItem:GossipMenuAddItem(0, "Starcaller.", 129, 0)
		pItem:GossipMenuAddItem(0, "The pilgrim.", 133, 0)
		pItem:GossipMenuAddItem(0, "Remove current Title.", 113, 0)
		pItem:GossipMenuAddItem(0, "Nevermind.", 2, 0)
		pItem:GossipSendMenu(player)

end
local PlayerName = player:GetName()
local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	

	local IsPlayerNil = CharDBQuery("SELECT guid FROM donate WHERE guid = '"..GetPlayerGUID.."'")
	
		if (IsPlayerNil == nil) then
			CharDBQuery("INSERT INTO donate VALUES ('"..GetPlayerGUID.."','"..PlayerName.."','')")		
		
	

		

		

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
			CharDBQuery("UPDATE donate SET current_title= '0' WHERE guid="..GetPlayerGUID.."")
			player:SendAreaTriggerMessage("Removed Title!")
			player:GossipComplete()
	end


	if(intid == 51) or (intid == 129) or (intid == 133) then
		
		local PlayerName = player:GetName()
		local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()



			player:SetKnownTitle(intid)
			CharDBQuery("UPDATE donate SET current_title= '..intid..' WHERE guid='"..GetPlayerGUID.."'")
			player:SendAreaTriggerMessage("Changed Title!")
			player:GossipComplete()
	end
		
	if(intid == 2) then
		player:GossipComplete()
	end

-- :UnsetKnownTitle(id)
-- :HasTitle(id)







end

RegisterItemGossipEvent(90013, 1, "Menu_OnGossip2")
RegisterItemGossipEvent(90013, 2, "Menu_OnGossipSelect2")