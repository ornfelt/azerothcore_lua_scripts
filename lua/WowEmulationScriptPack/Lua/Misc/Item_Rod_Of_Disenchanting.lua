local function removeEnchants(event, player, item, target)
player:AddItem(38821,1)
local Q = WorldDBQuery("SELECT bonding FROM item_template WHERE entry = "..target:GetEntry())
	if(Q:GetUInt32(0) == 2 or Q:GetUInt32(0) == 0) then
		target:ClearEnchantment(0)
		target:ClearEnchantment(1)
		target:ClearEnchantment(2)
		target:ClearEnchantment(3)
		target:ClearEnchantment(4)
		target:ClearEnchantment(5)
		target:ClearEnchantment(6)
		target:SetBinding(false)
	end
end

RegisterItemEvent(38821,2,removeEnchants)