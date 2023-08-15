-- a coin purchased by donating or in game that will display your vip stats.
-- by Black Wolf of EmuDevs.com
-- this item will modify votes count and vip level in db then delete itself
-- from the inventory (when item is clicked on)
-- with many thanks to rochet2 of ac-web.org for getting it all working
local itemid = ACCT["SERVER"].Vip_coin;

function Vipcoin_Trigger(event, caster, item)
local Paccid = caster:GetAccountId();

	caster:SendBroadcastMessage("------------------------------------------------------")
	caster:SendBroadcastMessage("|cff00cc00You are VIP: "..ACCT[Paccid].Vip.." of "..ACCT["SERVER"].Vip_max..".|r")
	caster:SendBroadcastMessage("|cff00cc00You have: "..ACCT[Paccid].Mg.." MG's in your bank acct.|r")
	caster:SendBroadcastMessage("|cff00cc00You have voted: "..ACCT[Paccid].Votes..".|r")

		if(ACCT[Paccid].Vip < ACCT["SERVER"].Vip_max)then
		
			if(ACCT[Paccid].Vip == 1)then
				caster:SendBroadcastMessage("|cff00cc00You must vote "..(((ACCT[Paccid].Vip*ACCT["SERVER"].Vote_count))-ACCT[Paccid].Votes).." times to earn next VIP level.|r")
				caster:SendBroadcastMessage("------------------------------------------------------")
			else
				caster:SendBroadcastMessage("|cff00cc00You must vote "..(((ACCT[Paccid].Vip*ACCT["SERVER"].Vote_count))-ACCT[Paccid].Votes).." times to earn next VIP level.|r")
				caster:SendBroadcastMessage("------------------------------------------------------")
			end
		else
			caster:SendBroadcastMessage("------------------------------------------------------")
		end
	return false;
end

RegisterItemGossipEvent(itemid, 1, Vipcoin_Trigger)
print("Grumbo'z VIP Coin loaded.")
