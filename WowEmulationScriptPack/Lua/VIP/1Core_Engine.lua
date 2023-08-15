local VIPMAX = 3; -- you can set it to what ever your little heart desires.
local InventoryStone = 630200;
local LevelupStone = 630201;

ACCT = {};
ACCT["SERVER"] = {
	Vip_max = VIPMAX,
	Inventory_Stone = InventoryStone,
	Level_Up_Stone = LevelupStone,
	};

function SetVip(player, vip)
	if(vip==nil)then return end
	local Paccnm = player:GetAccountName()
	ACCT[Paccnm].Vip = vip
	AuthDBQuery("UPDATE account SET `vip`='"..vip.."' WHERE `username`='"..Paccnm.."';");
end

function Player_Vip_Table(event, player)
	local Paccnm = player:GetAccountName()
	local Q = AuthDBQuery("SELECT vip FROM account WHERE `username`='"..Paccnm.."';");
	ACCT[Paccnm] = {
		chat = 0,
		Vip = Q:GetUInt32(0),
		};
	SetVip(player,Vip)
end
RegisterPlayerEvent(3, Player_Vip_Table)