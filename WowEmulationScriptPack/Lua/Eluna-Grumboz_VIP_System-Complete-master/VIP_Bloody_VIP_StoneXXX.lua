function Bloodyvipcoinxxx_Trigger(item, caster, event)
local Vip = ACCT[caster:GetAccountId()].Vip;

	if (Vip >= 1)and(Vip <= ACCT["SERVER"].Vip_max-1) then
		caster:RemoveItem(63021, 1)
		SetVip(caster, Vip + 1)
		return false;
	end
	if(Vip == ACCT["SERVER"].Vip_max)then
		caster:SendBroadcastMessage("you cannot levelup your VIP with this stone anymore. You are VIP"..Vip..".")
		return false;
	end
end
RegisterItemGossipEvent(63021, 1, Bloodyvipcoinxxx_Trigger)
