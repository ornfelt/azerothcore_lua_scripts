-- Items require VIP level to wield/equip/use
-- By slp13at420	 of EmuDevs.com

local function SendPlayerItem(player, itemid)

local subject = "Item returned.";
local text = "It appears you tried to use this item with a lower VIP rank. tsk tsk..";
	
	SendMail(subject, text, player:GetGUIDLow(), 0, 61, 1000, 0, 0, itemid, 1);
	
end

local function OnUseOrEquipItem(event, player, item)
-- This block of code can be added at the start of a function for a `RegisterItemEvent OnUse or DummyEffect or whatever.
-- to control the use of the item or items.
--
local acct_id = player:GetAccountId();
local id = item:GetEntry();

	if not(ACCT[Paccid]) then Player_Vip_Table(0, player) end;
	if not(VIPItems)then LoadItemVIPLevels() end;

local Ivip = VIPItems[id].Vip;
local Pvip = ACCT[acct_id].Vip;

	if(ACCT["SERVER"].ItemRequireVIP)then

		if(Pvip < Ivip)then
		
			player:SendBroadcastMessage("|cffFF0000You dont have the required VIP rank of "..Ivip..". You are VIP"..Pvip..".|r");
			
			player:RemoveItem(item, 1);
			SendPlayerItem(player, id);
			
			player:SendBroadcastMessage("|cffFF0000Please check your mail for this item.|r");

			return false;
			
		end
	end
--
end

RegisterPlayerEvent(29, OnUseOrEquipItem)

local function LoadItems()

	local ItemQuery = WorldDBQuery("SELECT entry, vip FROM item_template;");
	
	if(ItemQuery)then
		
		repeat
		
			local id = ItemQuery:GetUInt32(0);
			
				VIPItems[id] = {
					Id = id,
					Vip = ItemQuery:GetUInt32(1)
				};
	
			RegisterItemEvent(id, 2, OnUseOrEquipItem);
			
		until not ItemQuery:NextRow();
	end
end

RegisterServerEvent(9, LoadItems)
