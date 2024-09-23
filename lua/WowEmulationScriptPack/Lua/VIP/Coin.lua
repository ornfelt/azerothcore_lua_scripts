local itemid = ACCT["SERVER"].Inventory_Stone;

function Vipcoin_Trigger(event, caster, item)
local PaccName = caster:GetAccountName();
	caster:SendBroadcastMessage("|cff00cc00VIP Rank: "..ACCT[PaccName].Vip.." of "..ACCT["SERVER"].Vip_max..".|r")
	return false;
end

RegisterItemGossipEvent(itemid, 1, Vipcoin_Trigger)
