local timer = 1 -- speed to eliminate the chance of double clicking exploit.
local Max_Level = 80;
local Reward_Level = Max_Level; -- You can change this to an amount like 3. set to `Max_Level` to max a players Level.
local LvLItem = 1; -- put the item id of your leveling item.

local function RemoveLvLItem(event, _, _, player)
	local New_Level = player:GetLevel() + Reward_Level;
	
		if(New_Level > Max_Level)then New_Level = Max_Level;end
	
	player:RemoveItem(LvLItem, 1);
	player:SetLevel(New_Level);
end

local function PlrLvLItem(event, player, spellID, effindex, item)

	if(player:GetLevel() < Max_Level)then
		player:RegisterEvent(RemoveLvLItem, timer, 1, player)
	
	else
		player:SendBroadcastMessage("you are Max Level "..Max_Level..".")
	return
	end
end
		
RegisterItemEvent(LvLItem, 2, PlrLvLItem)
