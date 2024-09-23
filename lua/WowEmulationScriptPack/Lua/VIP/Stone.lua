function LevelupStone_Trigger(item, caster, event)
local Vip = ACCT[caster:GetAccountName()].Vip;

	if (Vip >= 1)and(Vip <= ACCT["SERVER"].Vip_max-1) then
		caster:RemoveItem(ACCT["SERVER"].Level_Up_Stone, 1)
		SetVip(caster, Vip + 1)
		return false;
	end
	if(Vip == ACCT["SERVER"].Vip_max)then
		caster:SendBroadcastMessage("You are unable to level up your VIP level anymore. You are VIP level "..Vip..".")
		return false;
	end
end
RegisterItemGossipEvent(ACCT["SERVER"].Level_Up_Stone, 1, LevelupStone_Trigger)
