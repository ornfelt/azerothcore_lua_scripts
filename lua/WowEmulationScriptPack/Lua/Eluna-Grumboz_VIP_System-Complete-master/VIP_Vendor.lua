-- i was extremely high when i wrote this so dont ask how the intid or the item_extended_costs works.. it .. just .. does.
-- how exactly does the positrack rear-end on a plymouth work?.. it .. just .. does ..

local npcid = 50000
local Vint = 1000000 -- used for dynamicaly created int's and item_extended_costs starting at 3000 .. the rest of the custom extended start at 3000
local Swords = {};
local Axes = {};
local Staffs = {};
local Wands = {};
local Bows = {};
local guns = {};
local Ammos = {};
local Shirts = {};
local Tabards = {};
local Cloaks = {};
local Trinkets = {};
local Rings = {};
local Amulets = {};
local Armor = {};

Swords = {
	[1] = {
		{{620000,3009}},{{0}},{{40491,3012}},{{0}},{{48513,3014}},{{0}},{{42244,3015}},{{0}},{{51522,3019}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}}
			},
	[2] = {
		{{620010,3010}},{{0}},{{13817,3012}},{{0}},{{24550,3014}},{{0}},{{9372,3015}},{{0}},{{33478,3019}},{{0}}
			},
		};
Axes = {
	[1] = {
		{{620020,3009}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}}
			},
	[2] = {
		{{620030,3010}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}}
			},
		};
Staffs = {{{34540,3009}}};		
Wands = {{{0,0}}};		
Bows = {
	{{34334,3009}},{{0}},{{0}},{{0}},{{22811,3012}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}},{{0}}
		};		
Guns = {{{0,0}}};
Ammos = {{{390007,3000}}};		
Shirts = {{{410014,3012}}};		
Tabards = {{{22999,3012}}};		
Cloaks = {{{0,0}}};		
Trinkets = {
	{410006,3009},{0},{410007,3011},{0},{410008,3013},{0},{410009,3015},{0},{410010,3016},{0},{410011,3017},{0},{410012,3018},{0},{410013,3019}
			};
Rings = {
	{{1077,3012},{32941,3012}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0}}
		};		
Amulets = {
	{{19491,3012},{21529,3012}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}},{{0,0}}
		};		

Armor =	{ -- class bundles 1-11
			{
		{600000,600010,600020,600030},{600040,600050,600060,600070},{600100,600110,600120,600130},{600140,600150,600160,600170},-- <-- vip bundles 1-20 of items 1-8
		{600200,600210,600220,600230},{600240,600250,600260,600270},{600300,600310,600320,600330},{600340,600350,600360,600370},
		{600400,600410,600420,600430},{600440,600450,600460,600470},{600500,600510,600520,600130},{600540,600550,600560,600570},
		{600600,600610,600620,600630},{600640,600650,600660,600670},{600700,600710,600720,600730},{600740,600750,600760,600770},
		{600800,600810,600820,600830},{600840,600850,600860,600870},{600900,600910,600920,600930},{600940,600950,600960,600970}
			};
			{
		{605000,605010,605020,605030},{605040,605050,605060,605070},{605100,605110,605120,605130},{605140,605150,605160,605170},
		{605200,605210,605220,605230},{605240,605250,605260,605270},{605300,605310,605320,605330},{605340,605350,605360,605370},
		{605400,605410,605420,605430},{605440,605450,605460,605470},{605500,605510,605520,605130},{605540,605550,605560,605570},
		{605600,605610,605620,605630},{605640,605650,605660,605670},{605700,605710,605720,605730},{605740,605750,605760,605770},
		{605800,605810,605820,605830},{605840,605850,605860,605870},{605900,605910,605920,605930},{605940,605950,605960,605970}
			};
			{
		{607000,607010,607020,607030},{607040,607050,607060,607070},{607000,607110,607120,607130},{607140,607150,607160,607170},
		{607200,607210,607220,607230},{607240,607250,607260,607270},{607300,607310,607320,607330},{607340,607350,607360,607370},
		{607400,607410,607420,607430},{607440,607450,607460,607470},{607500,607510,607520,607130},{607540,607550,607560,607570},
		{607600,607610,607620,607630},{607640,607650,607660,607670},{607700,607710,607720,607730},{607740,607750,607760,607770},
		{607800,607810,607820,607830},{607840,607850,607860,607870},{607900,607910,607920,607930},{607940,607950,607960,607970}
			};
			{
		{603000,603010,603020,603030},{603040,603050,603060,603070},{603100,603110,603120,603130},{603140,603150,603160,603170},
		{603200,603210,603220,603230},{603240,603250,603260,603270},{603300,603310,603320,603330},{603340,603350,603360,603370},
		{603400,603410,603420,603430},{603440,603450,603460,603470},{603500,603510,603520,603130},{603540,603550,603560,603570},
		{603600,603610,603620,603630},{603640,603650,603660,603670},{603700,603710,603720,603730},{603740,603750,603760,603770},
		{603800,603810,603820,603830},{603840,603850,603860,603870},{603900,603910,603920,603930},{603940,603950,603960,603970}
			};
			{
		{604000,604010,604020,604030},{604040,604050,604060,604070},{604000,604110,604120,607130},{604140,604150,604160,604170},
		{604200,604210,604220,604230},{604240,604250,604260,604270},{604300,604310,604320,607330},{604340,604350,604360,604370},
		{604400,604410,604420,604430},{604440,604450,604460,604470},{604500,604510,604520,607130},{604540,604550,604560,604570},
		{604600,604610,604620,604630},{604640,604650,604660,604670},{604700,604710,604720,607730},{604740,604750,604760,604770},
		{604800,604810,604820,604830},{604840,604850,604860,604870},{604900,604910,604920,607930},{604940,604950,604960,604970}
			};
			{
		{609000,609010,609020,609030},{609040,609050,609060,609070},{609100,609110,609120,609130},{609140,609150,609160,609170},
		{609200,609210,609220,609230},{609240,609250,609260,609270},{609300,609310,609320,609330},{609340,609350,609360,609370},
		{609400,609410,609420,609430},{609440,609450,609460,609470},{609500,609510,609520,609130},{609540,609550,609560,609570},
		{609600,609610,609620,609630},{609640,609650,609660,609670},{609700,609710,609720,609730},{609740,609750,609760,609770},
		{609800,609810,609820,609830},{609840,609850,609860,609870},{609900,609910,609920,609930},{609940,609950,609960,609970}
			};
			{
		{602000,602010,602020,602030},{602040,602050,602060,602070},{602000,602110,602120,602130},{602140,602150,602160,602170},
		{602200,602210,602220,602230},{602240,602250,602260,602270},{602300,602310,602320,602330},{602340,602350,602360,602370},
		{602400,602410,602420,602430},{602440,602450,602460,602470},{602500,602510,602520,602130},{602540,602550,602560,602570},
		{602600,602610,602620,602630},{602640,602650,602660,602670},{602700,602710,602720,602730},{602740,602750,602760,602770},
		{602800,602810,602820,602830},{602840,602850,602860,602870},{602900,602910,602920,602930},{602940,602950,602960,602970}
			};
			{
		{606000,606010,606020,606030},{606040,606050,606060,606070},{606100,606110,606120,606130},{606140,606150,606160,606170},
		{606200,606210,606220,606230},{606240,606250,606260,606270},{606300,606310,606320,606330},{606340,606350,606360,606370},
		{606400,606410,606420,606430},{606440,606450,606460,606470},{606500,606510,606520,606130},{606540,606550,606560,606570},
		{606600,606610,606620,606630},{606640,606650,606660,606670},{606700,606710,606720,606730},{606740,606750,606760,606770},
		{606800,606810,606820,606830},{606840,606850,606860,606870},{606900,606910,606920,606930},{606940,606950,606960,606970}
			};
			{
		{601000,601010,601020,601030},{601040,601050,601060,601070},{601000,601110,601120,601130},{601140,601150,601160,601170},
		{601200,601210,601220,601230},{601240,601250,601260,601270},{601300,601310,601320,601330},{601340,601350,601360,601370},
		{601400,601410,601420,601430},{601440,601450,601460,601470},{601500,601510,601520,601130},{601540,601550,601560,601570},
		{601600,601610,601620,601630},{601640,601650,601660,601670},{601700,601710,601720,601730},{601740,601750,601760,601770},
		{601800,601810,601820,601830},{601840,601850,601860,601870},{601900,601910,601920,601930},{601940,601950,601960,601970}
			};
			{ -- no class 10 so KEY 10 empty table = nil . unless you have a custom using id 10 then populate this KEY 10 table with data.all gear teeth must exist.
			};
			{
		{608000,608010,608020,608030},{608040,608050,608060,608070},{608000,608110,608120,608130},{608140,608150,608160,608170},
		{608200,608210,608220,608230},{608240,608250,608260,608270},{608300,608310,608320,608330},{608340,608350,608360,608370},
		{608400,608410,608420,608430},{608440,608450,608460,608470},{608500,608510,608520,608130},{608540,608550,608560,608570},
		{608600,608610,608620,608630},{608640,608650,608660,608670},{608700,608710,608720,608730},{608740,608750,608760,608770},
		{608800,608810,608820,608830},{608840,608850,608860,608870},{608900,608910,608920,608930},{608940,608950,608960,608970}
			};
		};
-- print(#Armor) -- posts amount by Class
-- print(#Armor[11]) -- posts amount by Class-VIP
-- print(#Armor[11][15]) -- posts amount by class-VIP-Items
-- print(Armor[11][15][4]) -- posts id by Class-VIP-Items-ID
-- current dynamic range values --> Armor CLASS[1-11] VIP[1-20] ITEMS[1-4] .value ranges atm. 
-- its dynamic so add more or take away the vendor will dynamicly adapt.

function VIP_Armor_OnGossip(eventid, player, object)

		VendorRemoveAllItems(50000)
		player:GossipClearMenu()
		player:GossipMenuAddItem(1,"Starter",0,11)
		player:GossipMenuAddItem(1,"misc Vip items",0,12)
		player:GossipMenuAddItem(1,"1HD Swords",0,16)
		player:GossipMenuAddItem(1,"2HD Swords",0,17)
		player:GossipMenuAddItem(1,"1HD Axes",0,18)
		player:GossipMenuAddItem(1,"2HD Axes",0,19)
		player:GossipMenuAddItem(1,"Staffs",0,20)
		player:GossipMenuAddItem(1,"Wands",0,21)
		player:GossipMenuAddItem(1,"Bows",0,22)
		player:GossipMenuAddItem(1,"Guns",0,23)
		player:GossipMenuAddItem(1,"Ammo",0,24)
		player:GossipMenuAddItem(1,"Shirts",0,50)
		player:GossipMenuAddItem(1,"Tabards",0,51)
		player:GossipMenuAddItem(1,"Cloaks",0,52)
		player:GossipMenuAddItem(1,"Trinkets",0,53)
		player:GossipMenuAddItem(1,"Rings",0,54)
		player:GossipMenuAddItem(1,"Amulets",0,55)
		player:GossipMenuAddItem(1,"VIP Armor",0,100)
		player:GossipMenuAddItem(5,"Repair",0,13)
		player:GossipMenuAddItem(2,"All Done",0,99)
		player:GossipSendMenu(1, object)
	end

local function Armor_Select(player, object)
local Paccid = player:GetAccountId()

player:GossipClearMenu()
	for vip=1, ACCT[Paccid].Vip do
		player:GossipMenuAddItem(1,"VIP "..vip.." Gear",0,Vint+vip) -- 
	end
	player:GossipSendMenu(1, object)
end

function VIP_Armor_OnSelect(eventid, player, object, sender, intid, code)

local Paccid = player:GetAccountId()
local Pcid = player:GetClass()
local Pvip = ACCT[Paccid].Vip

	if (intid == 11) then -- starter gear (custom items or what ever you want to put here .)
		AddVendorItem(npcid,6400000,1,1,3006)
		AddVendorItem(npcid,6400001,1,1,3006)
		AddVendorItem(npcid,6400002,1,1,3006)
		AddVendorItem(npcid,6400003,1,1,3006)
		AddVendorItem(npcid,6400004,1,1,3006)
		AddVendorItem(npcid,6400005,1,1,3006)
		AddVendorItem(npcid,6400006,1,1,3006)
		AddVendorItem(npcid,6400007,1,1,3006)
		player:SendVendorWindow(object)
	end

	if (intid == 12) then -- misc vip items or whatever you want
		AddVendorItem(npcid,ACCT["SERVER"].Vip_coin,1,1,3008) -- entry for vip coin 
		AddVendorItem(npcid,40582,1,1,0)
		player:SendVendorWindow(object)
	end

	if (intid == 13) then
		player:DurabilityRepairAll(100,100)
		player:GossipComplete()
	end

	if (intid == 16) then
	
		for a=1,Pvip do
		
			if(Swords[1][a])then
			
				for b=1,#Swords[1][a] do
				
					if(Swords[1][a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Swords[1][a][b][1],1,1,Swords[1][a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 17) then
	
		for a=1,Pvip do
		
			if(Swords[2][a])then
			
				for b=1,#Swords[2][a] do
				
					if(Swords[2][a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Swords[2][a][b][1],1,1,Swords[2][a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 18) then
	
		for a=1,Pvip do
		
			if(Axes[1][a])then
			
				for b=1,#Axes[1][a] do
				
					if(Axes[1][a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Axes[1][a][b][1],1,1,Axes[1][a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 19) then
	
		for a=1,Pvip do
		
			if(Axes[2][a])then
			
				for b=1,#Axes[2][a] do
				
					if(Axes[2][a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Axes[2][a][b][1],1,1,Axes[2][a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 20) then
	
		for a=1,Pvip do
		
			if(Staffs[a])then
			
				for b=1,#Staffs[a] do
				
					if(Staffs[a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Staffs[a][b][1],1,1,Staffs[a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 21) then
	
		for a=1,Pvip do
		
			if(Wands[a])then
			
				for b=1,#Wands[a] do
				
					if(Wands[a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Wands[a][b][1],1,1,Wands[a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 22) then
	
		for a=1,Pvip do
		
			if(Bows[a])then
			
				for b=1,#Bows[a] do
				
					if(Bows[a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Bows[a][b][1],1,1,Bows[a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 23) then
	
		for a=1,Pvip do
		
			if(Guns[a])then
			
				for b=1,#Guns[a] do
				
					if(Guns[a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Guns[a][b][1],1,1,Guns[a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 24) then
	
		for a=1,Pvip do
		
			if(Ammos[a])then
			
				for b=1,#Ammos[a] do
				
					if(Ammos[a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Ammos[a][b][1],1,1,Ammos[a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 50) then
	
		for a=1,Pvip do
		
			if(Shirts[a])then
			
				for b=1,#Shirts[a] do
				
					if(Shirts[a][b][1]~=(nil or 0))then
		
						if(a<=Pvip)then
						
							AddVendorItem(npcid,Shirts[a][b][1],1,1,Shirts[a][b][2])
	
						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 51) then
	
		for a=1,Pvip do
		
			if(Tabards[a])then
			
				for b=1,#Tabards[a] do
				
					if(Tabards[a][b][1]~=(nil or 0))then
		
						if(a<=Pvip)then
						
							AddVendorItem(npcid,Tabards[a][b][1],1,1,Tabards[a][b][2])
	
						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 52) then
	
		for a=1,Pvip do
		
			if(Cloaks[a])then
			
				for b=1,#Cloaks[a] do
				
					if(Cloaks[a][b][1]~=(nil or 0))then
		
						if(a<=Pvip)then
						
							AddVendorItem(npcid,Cloaks[a][b][1],1,1,Cloaks[a][b][2])
	
						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 53) then
	
		for a=1,Pvip do
		
			if(Trinkets[a])then
			
				if(Trinkets[a][1]~=(nil or 0))then
	
					if(a<=Pvip)then
					
						AddVendorItem(npcid,Trinkets[a][1],1,1,Trinkets[a][2])

					else
					end
				else
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 54) then
	
		for a=1,Pvip do
		
			if(Rings[a])then
			
				for b=1,#Rings[a] do
				
					if(Rings[a][b][1]~=(nil or 0))then
	
						if(a<=Pvip)then
					
							AddVendorItem(npcid,Rings[a][b][1],1,1,Rings[a][b][2])

						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 55) then
	
		for a=1,Pvip do
		
			if(Amulets[a])then

				for b=1,#Amulets[a] do
				
					if(Amulets[a][b][1]~=(nil or 0))then
		
						if(a<=Pvip)then
						
							AddVendorItem(npcid,Amulets[a][b][1],1,1,Amulets[a][b][2])
	
						else
						end
					else
					end
				end
			else
			end
		end
		player:SendVendorWindow(object)
	end

	if (intid == 99) then
		player:GossipComplete()
	end
	if (intid == 100) then
		Armor_Select(player, object)
	end
	
	if (intid > Vint) then -- item extended costs start at 3000 for VIP 1 and rise +1 for each level of VIP gear.
		for item = 1, #Armor[Pcid][intid-Vint] do
			AddVendorItem(npcid,Armor[Pcid][intid-Vint][item],1,1,3010+(intid-Vint))
		end
		player:SendVendorWindow(object)
	end
end
			

RegisterCreatureGossipEvent(npcid, 1, VIP_Armor_OnGossip)
RegisterCreatureGossipEvent(npcid, 2, VIP_Armor_OnSelect)
print("Grumbo'z VIP Vendor loaded.")
