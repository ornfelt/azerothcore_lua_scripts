local AIO = AIO or require("AIO")
local TransmogEnchantHandler = AIO.AddHandlers("TMogEnchant", {})

local vanilla_scrolls = {
	38868,
	38925,
	38948,
	38963,
	38965,
	38972,
	38995,
	43987,
	44463,
	44466,
	44467,
	44493,
	45056,
	46026,
	46098,
	42500,
	44936,
}

local scroll_items = {
	1999000,
	1999001,
	1999000,
	1999001,
	1999002,
	1999003,
	1999004,
	1999005,
	1999006,
	1999007,
	1999008,
	1999009,
	1999010,
	1999011,
	1999012,
	1999013,
	1999014,
	1999015,
	1999016,
	1999017,
	1999018,
	1999019,
	1999020,
	1999021,
	1999022,
	1999023,
}

local scroll_items_enchant_ids = {
	[1999000] = 3884,
	[1999001] = 3889,
	[1999002] = 3890,
	[1999003] = 3891,
	[1999004] = 3892,
	[1999005] = 3893,
	[1999006] = 3894,
	[1999007] = 3895,
	[1999008] = 3896,
	[1999009] = 3897,
	[1999010] = 3898,
	[1999011] = 3899,
	[1999012] = 3901,
	[1999013] = 3902,
	[1999014] = 3903,
	[1999015] = 3904,
	[1999016] = 3905,
	[1999017] = 3906,
	[1999018] = 3907,
	[1999019] = 3908,
	[1999020] = 3898,
	[1999021] = 3885,
	[1999022] = 3886,
	[1999023] = 3887,
	
}

-- on item use, send to AIO the popup of mainhand or offhand
local function EnchantItemOnUse(event, player, item, target)
	scroll_entry = tonumber(item:GetEntry())
	scroll_guid = tonumber(item:GetGUIDLow())
	AIO.Handle(player, "TMogEnchant", "ShowPopUp", scroll_entry)
end

-- here we will always make the weapon do +1 damage enchant, to override their old enchant slot 5 entry, which will always be a vanilla enchant if it exists.
local function Enchant_Check(event, player, item, target)
	target_guid = target:GetGUID()
	new_item = player:GetItemByGUID(target_guid)
	print(new_item:GetEntry())
	new_item:SetEnchantment(3909, 5)
end

-- on start, register item events based on entries.
local function RegisterScrollEvents()
	z = 0
	for x=1,#scroll_items,1 do
		RegisterItemEvent(scroll_items[x], 2, EnchantItemOnUse)
		z = z + 1
	end
	for n=1,#vanilla_scrolls,1 do
		RegisterItemEvent(vanilla_scrolls[n], 2, Enchant_Check)
		z = z + 1
	end
	print("[Transmog Enchants]: " ..tonumber(z).. " enchant scroll items properly loaded.")
end

-- recieve response from client and enchant visual ID to slot, swapping any enchant previous from enchant(0) to enchant(5).
function TransmogEnchantHandler.EnchantApply(player, hand, scroll_entry)
	if hand == "offhand" then
		slot = 16
	elseif hand == "mainhand" then
		slot = 15
	else
		return false
	end
	
	item = player:GetEquippedItemBySlot(slot)
	if (item == nil) then
		player:SendBroadcastMessage("You do not have an item in that hand.")
		return false
	end
	
	old_enchant = item:GetEnchantmentId(0)
	for b=1,#scroll_items,1 do
		m = scroll_items[b]
		if old_enchant == scroll_items_enchant_ids[m] then
			item:SetEnchantment(scroll_items_enchant_ids[scroll_entry], 0)
			print("visual found")
			return false
		end
	end
	
	item:SetEnchantment(old_enchant, 5)
	item:SetEnchantment( scroll_items_enchant_ids[scroll_entry], 0)
end

local function EnchantStartUp(event)
	RegisterScrollEvents()
end

RegisterServerEvent(33, EnchantStartUp)