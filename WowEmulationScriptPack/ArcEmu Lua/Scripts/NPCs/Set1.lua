local npcid = 200108

function Vendor_OnGossip(pUnit,event,player)
	pUnit:VendorRemoveAllItems()
	pUnit:GossipCreateMenu(100, player, 0)
	pUnit:GossipMenuAddItem(0,"Warrior",1,0)
	pUnit:GossipMenuAddItem(0,"Shaman",2,0)
	pUnit:GossipMenuAddItem(0,"Priest",3,0)
	pUnit:GossipMenuAddItem(0,"Paladin",4,0)
	pUnit:GossipMenuAddItem(0,"Druid",5,0)
	pUnit:GossipMenuAddItem(0,"Mage",6,0)
	pUnit:GossipMenuAddItem(0,"Death Knight",7,0)
	pUnit:GossipMenuAddItem(0,"Hunter",8,0)
	pUnit:GossipMenuAddItem(0,"Warlock",9,0)
	pUnit:GossipMenuAddItem(0,"Rogue",10,0)
	pUnit:GossipMenuAddItem(0,"Weapons",11,0)
	pUnit:GossipMenuAddItem(0,"Misc",12,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

function Vendor_OnSelect(pUnit,event,player,id,intid,code)

if (intid == 1) then
	pUnit:VendorAddItem(130020,1,2741)
	pUnit:VendorAddItem(130021,1,2741)
	pUnit:VendorAddItem(130022,1,2741)
	pUnit:VendorAddItem(130023,1,2741)
	pUnit:VendorAddItem(130024,1,2741)
        pUnit:VendorAddItem(130025,1,2741)
	pUnit:VendorAddItem(130026,1,2741)
	pUnit:VendorAddItem(130027,1,2741)
	pUnit:VendorAddItem(130028,1,2741)
	pUnit:VendorAddItem(130029,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Warriors",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 2) then
	pUnit:VendorAddItem(51503,1,2741)
	pUnit:VendorAddItem(51504,1,2741)
	pUnit:VendorAddItem(51505,1,2741)
	pUnit:VendorAddItem(51506,1,2741)
	pUnit:VendorAddItem(51508,1,2741)
	pUnit:VendorAddItem(51509,1,2741)
	pUnit:VendorAddItem(51510,1,2741)
	pUnit:VendorAddItem(51511,1,2741)
	pUnit:VendorAddItem(51512,1,2741)
	pUnit:VendorAddItem(51514,1,2741)
	pUnit:VendorAddItem(51497,1,2741)
	pUnit:VendorAddItem(51498,1,2741)
	pUnit:VendorAddItem(51499,1,2741)
	pUnit:VendorAddItem(51500,1,2741)
	pUnit:VendorAddItem(51502,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Shamans",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 3) then
	pUnit:VendorAddItem(51482,1,2741)
	pUnit:VendorAddItem(51483,1,2741)
	pUnit:VendorAddItem(51484,1,2741)
	pUnit:VendorAddItem(51485,1,2741)
	pUnit:VendorAddItem(51486,1,2741)
	pUnit:VendorAddItem(51487,1,2741)
	pUnit:VendorAddItem(51488,1,2741)
	pUnit:VendorAddItem(51489,1,2741)
	pUnit:VendorAddItem(51490,1,2741)
	pUnit:VendorAddItem(51491,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Priest",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 4) then
	pUnit:VendorAddItem(51468,1,2741)
	pUnit:VendorAddItem(51469,1,2741)
	pUnit:VendorAddItem(51470,1,2741)
	pUnit:VendorAddItem(51471,1,2741)
	pUnit:VendorAddItem(51473,1,2741)
	pUnit:VendorAddItem(51474,1,2741)
	pUnit:VendorAddItem(51475,1,2741)
	pUnit:VendorAddItem(51476,1,2741)
	pUnit:VendorAddItem(51477,1,2741)
	pUnit:VendorAddItem(51479,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Paladin",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 5) then
	pUnit:VendorAddItem(51419,1,2741)
	pUnit:VendorAddItem(51420,1,2741)
	pUnit:VendorAddItem(51421,1,2741)
	pUnit:VendorAddItem(51422,1,2741)
	pUnit:VendorAddItem(51424,1,2741)
	pUnit:VendorAddItem(51425,1,2741)
	pUnit:VendorAddItem(51426,1,2741)
	pUnit:VendorAddItem(51427,1,2741)
	pUnit:VendorAddItem(51428,1,2741)
	pUnit:VendorAddItem(51430,1,2741)
	pUnit:VendorAddItem(51433,1,2741)
	pUnit:VendorAddItem(51434,1,2741)
	pUnit:VendorAddItem(51435,1,2741)
	pUnit:VendorAddItem(51436,1,2741)
	pUnit:VendorAddItem(51438,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Druid",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 6) then
	pUnit:VendorAddItem(130010,1,2741)
	pUnit:VendorAddItem(130011,1,2741)
	pUnit:VendorAddItem(130013,1,2741)
	pUnit:VendorAddItem(130012,1,2741)
	pUnit:VendorAddItem(130014,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Mage",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 7) then
	pUnit:VendorAddItem(51413,1,2741)
	pUnit:VendorAddItem(51414,1,2741)
	pUnit:VendorAddItem(51415,1,2741)
	pUnit:VendorAddItem(51416,1,2741)
	pUnit:VendorAddItem(51418,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Death Knight",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 8) then
	pUnit:VendorAddItem(130000,1,)
	pUnit:VendorAddItem(130001,1,)
	pUnit:VendorAddItem(130002,1,)
	pUnit:VendorAddItem(130003,1,)
	pUnit:VendorAddItem(130004,1,)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Hunter",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 9) then
	pUnit:VendorAddItem(130015,1,2741)
	pUnit:VendorAddItem(130016,1,2741)
	pUnit:VendorAddItem(130017,1,2741)
	pUnit:VendorAddItem(130018,1,2741)
	pUnit:VendorAddItem(130019,1,2741)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Warlock",100,0)
	pUnit:GossipMenuAddItem(4, "Nevermind",999,0)
	pUnit:GossipSendMenu(player)
end

if (intid == 10) then
	pUnit:VendorAddItem(130005,1,)
	pUnit:VendorAddItem(130006,1,)
	pUnit:VendorAddItem(130007,1,)
	pUnit:VendorAddItem(130008,1,)
	pUnit:VendorAddItem(130009,1,)
	pUnit:GossipCreateMenu(101, player, 0)
	pUnit:GossipMenuAddItem(0,"Wrathful For Rogue",100,0)
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

RegisterUnitGossipEvent(200108, 1, "Vendor_OnGossip")
RegisterUnitGossipEvent(200108, 2, "Vendor_OnSelect")