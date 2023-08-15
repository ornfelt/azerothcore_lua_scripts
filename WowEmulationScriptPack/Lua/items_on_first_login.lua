--- Made for fun by Chisou

local bags = true

-- Bags on first login
local function OnFirstLoginBags(e, p)
	if  class ~= 6 then 
		p:EquipItem(p:AddItem(23162), 19)
		p:EquipItem(p:AddItem(23162), 20)
		p:EquipItem(p:AddItem(23162), 21)
		p:EquipItem(p:AddItem(23162), 22)
	end
end
--

if bags then
	RegisterPlayerEvent(30, OnFirstLoginBags)
end