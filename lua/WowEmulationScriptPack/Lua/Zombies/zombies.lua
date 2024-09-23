--/run SendChatMessage("\124cFFDDD000\124Hquest:\124htest\124h\124r", "SAY", nil, nil)

--figure out death mechanic
--zombies need to give player UpgradeCurrency on death
--need to make "upgrade boxes" to either random or choose which item to upgrade
--need boost buffs
--others drop off mobs/chests found in the area(all gear has low stats)

--globals used in all Zombie Scripts
killTracker = {}
local UpgradeCurrency = 6460050 --item/currency ID
local ZombieTypes = { -- use same 1 multiple times for better odds
27059
}

local StarterCreature = 9955000 --creature you talk to to go to the fight
local LeavingCreature = 9955000
local MapID = 0 -- map we use
local rewardItem = 646004 --reward item after it ends
local ParagonSpell1 = 706008
local ParagonSpell2 = 707450
local ParagonSpell3 = 707451
local StartingItems = {
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--1 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--2 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--3 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--4 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--5 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--6 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--7 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--8 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--9 class
{},--10 class
{{3283702,1},{3283703,1},{7631243,1},{7631245,1},{7631246,1}},--11 class
}
local ranges = {
-100,-90,-80-75,-70,-60,-50,50,60,70,75,80,90,100
}
local playerSpawns = {
{-7035.992676,-3577.232910,241.038,1.564},
{-7098.330566,-3455.070557,240.305,0.010},
{-6905.563965,-3435.894755,243.338,1.540},
{-6617.872559,-3535.280762,245.085,1.591},
{-6644.439453,-3706.800049,244.113,3.134},
{-6882.355957,-4011.975342,248.402,6.178},
{-6712.807129,-3859.941162,258.651,1.579},
{-6968.140625,-3017.127197,241.666,2.997},
{-6658.133301,-2748.293213,242.431,0.912},
{-6950.569824,-2470.118896,240.744,5.310},
{-7185.492188,-2561.611328,242.122,5.200},
{-6984.244629,-2821.693115,261.867,2.125},
{-7238.333008,-3475.500488,321.260,3.460},
{-6413.508301,-3379.285889,229.710,3.731}
}
local function splitComma(inputString) -- splits each item set from query
	local returnTable = {}
	for word in inputString:gmatch('[^,%s]+') do
		table.insert(returnTable,word)
	end
return returnTable
end

local function splitHashtag(inputString) --splits itemID and count
	local returnTable = {}
	for word in inputString:gmatch('[^#%s]+') do
		table.insert(returnTable,word)
	end
return returnTable
end

function MakeZombies(eventid, delay, repeats, player)
	if(player:GetMapId() == MapID) then
	local Start = 0
	local Ending = 20
		if(killTracker[player:GetName()] ~= nil) then
		local kills = killTracker[player:GetName()]
		Ending = Ending + math.floor(kills/5)
		else
		killTracker[player:GetName()] = 0
		end
		while Start <= Ending do
			local CurrentCreature = player:SpawnCreature( ZombieTypes[math.random(#ZombieTypes)], player:GetX()+ranges[math.random(#ranges)], player:GetY()+ranges[math.random(#ranges)], player:GetZ(), player:GetO(), 4, 120000 )
			CurrentCreature:AttackStart( player )
			Start = Start + 1
		end
	end
end

local function onHelloZombies(event, player, object)
	player:GossipMenuAddItem(0,"Take me into the FFA Zombie Area!", 0, 100, false, "Are you sure? This will temporarily take away all items to bring you to the zombie area. You can bank your items for safe-keeping. You WILL LOSE your random enchants. This is also a PvP area. It is suggested to make a new character for this.")
	player:GossipSendMenu(100,object)	
end

local function onSelectZombies(event, player, object, sender, intid, code, menu_id)
	if(intid == 100) then
		local i = 0
		local v = 0
		local itemString = ""
		while i <= 255 do
			while v <= 255 do--possible issue 1
	if(player:GetItemByPos( i, v ) ~= nil) then
	print("Name: "..player:GetItemByPos( i, v ):GetName().." i: "..i.." v: "..v)
	end
				if (i == 255 and (v == 19 or v == 20 or v == 21 or v == 22)) then
				else
					local currentItem = player:GetItemByPos( i, v )
					if(currentItem ~= nil and IsBankPos( i, v ) ~= true) then-- and IsBagPos(i,v) ~= true
						local currentItemID = currentItem:GetEntry()
						local Amount = player:GetItemCount(currentItemID)
						player:RemoveItem(currentItemID,Amount)
						if(itemString == "") then
						itemString = tostring(currentItemID).."#"..tostring(Amount)
						else
						itemString = itemString..","..tostring(currentItemID).."#"..tostring(Amount)
						end
					end
				end
				v = v +1
			end
			v = 0
			i = i +1
		end
		for k,v in pairs(StartingItems[player:GetClass()]) do 
			player:AddItem(v[1],v[2]) --gives them their Starting gear
		end
		 --WorldDBQuery( "INSERT INTO `Zombie_Table` SET `valueString` = \""..tostring(itemString).."\" WHERE `guid` = "..tostring(player:GetGUID())..";")
		 WorldDBQuery("INSERT INTO `Zombie_Table` (guid,valueString) VALUES ("..tostring(player:GetGUID())..",\""..tostring(itemString).."\");")
		 WorldDBQuery("INSERT INTO `Zombie_Table_backups` (guid,valueString,Name,timestamp) VALUES ("..tostring(player:GetGUID())..",\""..tostring(itemString).."\",\""..player:GetName().."\",\""..os.date('%Y-%m-%d %H:%M:%S').."\");")
		if(player:HasAura(ParagonSpell1)) then
			WorldDBQuery( "UPDATE `Zombie_Table` SET `spell1` = "..player:GetAura(ParagonSpell1):GetStackAmount().." WHERE `guid` = "..tostring(player:GetGUID())..";")
			WorldDBQuery( "UPDATE `Zombie_Table_backups`` SET `spell1` = "..player:GetAura(ParagonSpell1):GetStackAmount().." WHERE `guid` = "..tostring(player:GetGUID())..";")
			player:RemoveAura(ParagonSpell1)
		end
		if(player:HasAura(ParagonSpell2)) then
			WorldDBQuery( "UPDATE `Zombie_Table` SET `spell2` = "..player:GetAura(ParagonSpell2):GetStackAmount().." WHERE `guid` = "..tostring(player:GetGUID())..";")
			WorldDBQuery( "UPDATE `Zombie_Table_backups` SET `spell2` = "..player:GetAura(ParagonSpell2):GetStackAmount().." WHERE `guid` = "..tostring(player:GetGUID())..";")
			player:RemoveAura(ParagonSpell2)
		end
		if(player:HasAura(ParagonSpell3)) then
			WorldDBQuery( "UPDATE `Zombie_Table` SET `spell3` = "..player:GetAura(ParagonSpell3):GetStackAmount().." WHERE `guid` = "..tostring(player:GetGUID())..";")
			WorldDBQuery( "UPDATE `Zombie_Table_backups` SET `spell3` = "..player:GetAura(ParagonSpell3):GetStackAmount().." WHERE `guid` = "..tostring(player:GetGUID())..";")
			player:RemoveAura(ParagonSpell3)
		end
		local choice = math.random(#playerSpawns)
		player:Teleport(MapID,playerSpawns[choice][1],playerSpawns[choice][2],playerSpawns[choice][3],playerSpawns[choice][4])
		player:RemoveEvents()
		killTracker[player:GetName()] = 0
		player:RegisterEvent(MakeZombies, 60000, 0)
	end
end
local function onHelloZombiesLeave(event, player, object)
	player:GossipMenuAddItem(0,"Take me home!", 0, 80)
	player:GossipSendMenu(100,object)	
end

local function onSelectZombiesLeave(event, player, object, sender, intid, code, menu_id)
	if(intid == 80) then
		if(killTracker[player:GetName()] ~= nil) then
			local totalKills = killTracker[player:GetName()]
			player:AddItem(rewardItem,totalKills)
			killTracker[player:GetName()] = nil
			player:RemoveEvents()
			player:RemoveItem(UpgradeCurrency,player:GetItemCount(UpgradeCurrency))
			local Q = WorldDBQuery("SELECT valueString,spell1,spell2,spell3 FROM `Zombie_Table` WHERE `guid` = "..tostring(player:GetGUID()))
			local commaSplitTable = splitComma(Q:GetString(0))
			for i,v in pairs(commaSplitTable) do
				local hashtagSplitTable = splitHashtag(v)
				player:AddItem(tonumber(hashtagSplitTable[1]),tonumber(hashtagSplitTable[2]))
			end
			if(Q:GetUInt32(1) ~= 0) then
				player:AddAura(ParagonSpell1,player)
			end
			if(Q:GetUInt32(2) ~= 0) then
				player:AddAura(ParagonSpell2,player)
			end
			if(Q:GetUInt32(3) ~= 0) then
				player:AddAura(ParagonSpell3,player)
			end
			WorldDBExecute("DELETE FROM `Zombie_Table` WHERE `guid` = "..tostring(player:GetGUID()))
		end
	player:Teleport(571,-11848.594,12018.8867,88.68,5.53)
	end
end

function onPlayerDeath (event, killer, killed)
	if(killTracker[killed:GetName()] ~= nil) then
	local totalKills = killTracker[killed:GetName()]
			killed:AddItem(rewardItem,totalKills)
			killTracker[killed:GetName()] = nil
			killed:RemoveEvents()
			killed:RemoveItem(UpgradeCurrency,killed:GetItemCount(UpgradeCurrency))
			local Q = WorldDBQuery("SELECT valueString,spell1,spell2,spell3 FROM `Zombie_Table` WHERE `guid` = "..tostring(killed:GetGUID()))
			local commaSplitTable = splitComma(Q:GetString(0))
			for i,v in pairs(commaSplitTable) do
				local hashtagSplitTable = splitHashtag(v)
				local ifAdded = killed:AddItem(tonumber(hashtagSplitTable[1]),tonumber(hashtagSplitTable[2]))
				if(ifAdded == nil)then
					SendMail( "Return of a Zombie Item", "Return of your item", killed:GetGUIDLow(), 61)
				end
			end
			if(Q:GetUInt32(1) ~= 0) then
				killed:AddAura(ParagonSpell1,killed)
			end
			if(Q:GetUInt32(2) ~= 0) then
				killed:AddAura(ParagonSpell2,killed)
			end
			if(Q:GetUInt32(3) ~= 0) then
				killed:AddAura(ParagonSpell3,killed)
			end
			WorldDBExecute("DELETE FROM `Zombie_Table` WHERE `guid` = "..tostring(killed:GetGUID()))
	end
	killed:Teleport(571,-11848.594,12018.8867,88.68,5.53)
end
		
		
RegisterPlayerEvent( 8, onPlayerDeath )
RegisterCreatureGossipEvent( StarterCreature, 1, onHelloZombies )
RegisterCreatureGossipEvent( StarterCreature, 2, onSelectZombies )
RegisterCreatureGossipEvent( LeavingCreature, 1, onHelloZombiesLeave )
RegisterCreatureGossipEvent( LeavingCreature, 2, onSelectZombiesLeave )