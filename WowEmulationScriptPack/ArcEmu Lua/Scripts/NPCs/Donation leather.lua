local npcid = 123485

function Vendor_OnGossip(pUnit,event,player)
	pUnit:VendorRemoveAllItems()
	pUnit:GossipCreateMenu(100, player, 0)
	pUnit:GossipMenuAddItem(0,"Vip1",1,0)
	pUnit:GossipMenuAddItem(0,"Vip2",2,0)
	pUnit:GossipMenuAddItem(0,"Vip3",3,0)
	pUnit:GossipMenuAddItem(0,"Vip4",4,0)
	pUnit:GossipMenuAddItem(0,"Vip5",5,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

function Vendor_OnSelect(pUnit,event,player,id,intid,code)

if (intid == 1) then
	pUnit:VendorAddItem(130102,1,1959)
	pUnit:VendorAddItem(130103,1,1959)
	pUnit:VendorAddItem(130104,1,1959)
	pUnit:VendorAddItem(130100,1,1959)
	pUnit:VendorAddItem(130101,1,1959)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Vip1",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 2) then
	pUnit:VendorAddItem(51503,1,2348)
	pUnit:VendorAddItem(51504,1,2348)
	pUnit:VendorAddItem(51505,1,2348)
	pUnit:VendorAddItem(51506,1,2348)
	pUnit:VendorAddItem(51508,1,2348)

	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Vip2",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 3) then
	pUnit:VendorAddItem(51482,1,1985)
	pUnit:VendorAddItem(51483,1,1985)
	pUnit:VendorAddItem(51484,1,1985)
	pUnit:VendorAddItem(51485,1,1985)
	pUnit:VendorAddItem(51486,1,1985)

	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Vip3",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 4) then
	pUnit:VendorAddItem(51468,1,1981)
	pUnit:VendorAddItem(51469,1,1981)
	pUnit:VendorAddItem(51470,1,1981)
	pUnit:VendorAddItem(51471,1,1981)
	pUnit:VendorAddItem(51473,1,1981)

	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Vip4",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 5) then
	pUnit:VendorAddItem(51419,1,54)
	pUnit:VendorAddItem(51420,1,54)
	pUnit:VendorAddItem(51421,1,54)
	pUnit:VendorAddItem(51422,1,54)
	pUnit:VendorAddItem(51424,1,54)

	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Vip5",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end




	
if (intid == 100) then
	player:SendVendorWindow(pUnit)
	end

if (intid == 999) then
	player:GossipComplete()
	end
end

RegisterUnitGossipEvent(123485, 1, "Vendor_OnGossip")
RegisterUnitGossipEvent(123485, 2, "Vendor_OnSelect")