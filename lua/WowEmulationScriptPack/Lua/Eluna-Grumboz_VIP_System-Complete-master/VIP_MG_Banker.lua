local npcid = 60120
 
function MGV_Gossip(eventID, player, unit)

local Paccid = player:GetAccountId()
local MagicGolda = ACCT[Paccid].Mg
local Votes = ACCT[Paccid].Votes
local Vip = ACCT[Paccid].Vip
  
	VendorRemoveAllItems(60120)
	player:GossipClearMenu()
		
    player:GossipMenuAddItem(0, "Currencies", 0, 110)
    player:GossipMenuAddItem(0, "WithDraw 500 Magic Gold. Cost: 5 MG.", 0, 101)
    player:GossipMenuAddItem(0, "WithDraw 1,000 MG. Cost: 10 MG.", 0, 102)
    player:GossipMenuAddItem(0, "WithDraw 5,000 MG. Cost: 50 MG.", 0, 103)
    player:GossipMenuAddItem(0, "WithDraw 10,000 MG. Cost: 100 MG.", 0, 105)
    player:GossipMenuAddItem(0, "WithDraw 50,000 MG. Cost: 500 MG.", 0, 106)
	player:GossipMenuAddItem(0, "WithDraw 100,000 MG. Cost: 1,000 MG.", 0, 107)
    player:GossipMenuAddItem(0, "WithDraw 500,000 MG. Cost: 5,000 MG.", 0, 108)
	player:GossipMenuAddItem(0, "Deposit ALL your MG into the bank.       Cost: 0 MG.", 0, 104)
	player:GossipMenuAddItem(0, "-----------------------------------", 0, 100) 
	player:GossipMenuAddItem(2, "You have "..MagicGolda.." MG's in bank account.", 0, 100)
	player:GossipMenuAddItem(2, "Your votes total: "..Votes.."", 0, 100)
	player:GossipMenuAddItem(2, "Your VIP level: "..Vip.."", 0, 100)
	player:GossipMenuAddItem(0, "-----------------------------------", 0, 100) 
	player:GossipSendMenu(1, unit)
 
end
 
function MGV_Select(eventID, player, unit, sender, intid, code)
-- Making Amt and Sur to be local inside the On_Select, yet still being possible to use as "global" inside the function.
local Paccid = player:GetAccountId();

	if not(ACCT[Paccid]) then Player_Vip_Table(0, player) end;

local Amt;
local wcc;
local Sur;
 
	if (intid == 100) then
		-- this prevents menu freezing and invalid queries due to missing variables
		MGV_Gossip(eventID, player, unit) -- Back to "main" menu
		return -- Do not execute the rest of the code
	
	elseif(intid==110)then
		AddVendorItem(npcid,63030,1,1,3016)
		AddVendorItem(npcid,63031,1,1,3044)
		AddVendorItem(npcid,63032,1,1,3045)
		AddVendorItem(npcid,63033,1,1,3046)
		AddVendorItem(npcid,63034,1,1,3047)
		AddVendorItem(npcid,62006,1,1,0)
		player:SendVendorWindow(unit)
		return
		
	elseif (intid == 104) then
		wcc = player:GetItemCount(44209)
		player:SendBroadcastMessage("you will be depositing "..wcc.." MG.")
		AddMG(player, wcc)
		player:SendBroadcastMessage(""..wcc.." MG have been added to your MG bank.")
	 		player:RemoveItem(44209, wcc)
		MGV_Gossip(eventID, player, unit) -- Back to "main" menu
		return
		
	elseif (intid == 101) then 
		Amt = 500 -- amount requested
		Sur = 5 -- transaction fee of 10 percent
	elseif (intid == 102) then
		Amt = 1000 -- amount requested
		Sur = 10 -- transaction fee of 10 percent
	elseif (intid == 103) then
		Amt = 5000 -- amount requested
		Sur = 50 -- transaction fee of 10 percent
	elseif (intid == 105) then
		Amt = 10000 -- amount requested
		Sur = 100 -- transaction fee of 10 percent
	elseif (intid == 106) then
		Amt = 50000 -- amount requested
		Sur = 500 -- transaction fee of 10 percent
	elseif (intid == 107) then
		Amt = 100000 -- amount requested
		Sur = 1000 -- transaction fee of 10 percent
	elseif (intid == 108) then
		Amt = 500000 -- amount requested
		Sur = 5000 -- transaction fee of 10 percent
	end
	
local CheckMG = ACCT[player:GetAccountId()].Mg

	if(not CheckMG) then -- Check if the query was succesful, if not: error and do nothing more
		print("Query failed")
		return -- Stop executing the rest of the code since the query did not return anything.
	end
	
local MagicGold = ACCT[Paccid].Mg;

	if (MagicGold < Amt + Sur) then
		player:SendAreaTriggerMessage("You don't have enough. Balance: "..MagicGold.." mg.") -- inform pPlayer about balance and errs
	else
		local rest = MagicGold - (Amt + Sur)
		WorldDBQuery("UPDATE auth_434.account SET `mg`=`mg`-'"..(Amt+Sur).."' WHERE `id`='"..Paccid.."';");
		ACCT[Paccid].Mg = (ACCT[Paccid].Mg-(Amt+Sur)) 
 	             
		if(player:AddItem(44209, Amt)) then 
			player:SendBroadcastMessage("You have purchased "..Amt.." Magic Gold.") -- informs pPlayer of amount recieved
		else
			player:SendAreaTriggerMessage("Your inventory is full") -- Adding the item failed. Do no changes to DB and send error msg.
		end
	end
	MGV_Gossip(eventID, player, unit) -- Back to "main" menu
end

RegisterCreatureGossipEvent(npcid, 1, MGV_Gossip)
RegisterCreatureGossipEvent(npcid, 2, MGV_Select)
print("Grumbo'z VIP MG Banker loaded.")
