local command = "menu"

local GMonly = false  --.menu only opens for GM
--If GMonly is true then the options below don't matter
local GMonlymail = false -- if true Only GM can Open Mail
local GMonlybank = false -- if true Only GM can Open Bank
local GMonlyah = false  -- if true Only GM can Open Auction
local GMonlyfly = false  -- if true Only GM can learn to Fly on Azeroth
--Teleports to starter areas
local TeleGMonly = false  -- if true Only GM can access teleports to starting areas
--Heirloom
local OGMCU = false --Only GM can use
local hirenpcbots = false -- True is for when server uses NPC_Bots from trickerer https://github.com/trickerer/Trinity-Bots


local T = {
--  [classId] = {item1, item2, item3m, ...}
	[0] = {},
    [1] = {42943, 48718, 42991, 48716, 42949, 48685, 50255, 51980, 51978, 51982, 51981}, -- Warrior
    [2] = {44100, 48685, 44092, 42992, 50255, 48716, 51980, 51978, 51982, 51981}, -- Paladin
    [3] = {42946, 50255, 48677, 42991, 42950, 42944, 51965, 51964, 51963, 51962}, -- Hunter
    [4] = {42944, 48689, 42952, 42991, 50255, 51965, 51964, 51963, 51962}, -- Rogue
    [5] = {42947, 48691, 44107, 42992, 50255, 51973, 51968, 51967, 51972}, -- Priest
    [6] = {42943, 48685, 42949, 42991, 50255, 51987, 51995, 51985, 51993}, -- Death Knight
    [7] = {48716, 48716, 42992, 48677, 42950, 42951, 48683, 50255, 51965, 51964, 51963, 51962}, -- Shaman
    [8] = {42947, 48691, 44107, 42992, 50255, 51973, 51968, 51967, 51972}, -- Mage
    [9] = {42947, 48691, 44107, 42992, 50255, 51973, 51968, 51967, 51972}, -- Warlock
    [11] = {42947, 48718, 42952, 42991, 44107, 48691, 48689, 50255, 51965, 51964, 51963, 51962}, -- Druid

}


local function SKULY(eventid, delay, repeats, player)

if not GMonly then
    player:SendBroadcastMessage("|cff3399FF You can acces player menu by typing |cff00cc00 .menu |cff3399FF in chat.")
	end
end

local firstlogin = false

local function OnFirstLogin(event, player)
	if event == 30 then
	firstlogin = true
	end
	
	player:RegisterEvent(SKULY, 10000, 1, player)
end

local function OnLogin(event, player)
	if not firstlogin then
	player:RegisterEvent(SKULY, 10000, 1, player)
	else
	firstlogin = false
	end
end


local function getPlayerCharacterGUID(player)
    query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end


  

local function Hello(event, player)
local query = WorldDBQuery(string.format("SELECT * FROM world.heirloom_list WHERE CharID=%i", getPlayerCharacterGUID(player)))
player:GossipClearMenu()
	local mingmrank = 3
		
	
	player:GossipMenuAddItem(0, "Repair All", 0, 11)
	player:GossipMenuAddItem(0, "Morph", 0, 1)
	if not player:HasSpell(31700) then
	if not (GMonlyfly and player:GetGMRank() < mingmrank) then
	player:GossipMenuAddItem(0, "[Flying Mount]", 0, 14)
	end
	end
	if not (GMonlymail and player:GetGMRank() < mingmrank) then
	player:GossipMenuAddItem(0, "[Open Mailbox]", 0, 15)
	end
	if not (GMonlybank and player:GetGMRank() < mingmrank) then
	player:GossipMenuAddItem(0, "[Open Bank]", 0, 16)
	end
	if not (GMonlyah and player:GetGMRank() < mingmrank) then
	player:GossipMenuAddItem(0, "[Open Auction House]", 0, 17)
	end
	if (TeleGMonly and player:GetGMRank() < mingmrank) then
	else
	player:GossipMenuAddItem(0, "Starting Areas", 0, 18)
	end
	
	if (OGMCU and (player:GetGMRank() < mingmrank)) or query then
	else
	player:GossipMenuAddItem(0, "Heirloom", 0, 49)
	end
	
	if hirenpcbots then
	player:GossipMenuAddItem(0, "Spawn Bot Hire NPC (30sec) - 5 Gold", 0, 98)
	else
	end
	player:GossipMenuAddItem(0, "Spawn vendor to sell your junk", 0, 67)
	
	if (player:GetGMRank() >= 3) then -- 3 is GM
	player:GossipMenuAddItem(0, "Give Gold", 0, 97, true, "You want some gold?")
	end
	
	player:GossipMenuAddItem(0, "[Exit Menu]", 0, 99)
	
	player:GossipSendMenu(1, player, 100)


player:GossipSendMenu(1, player, 100)
end


local function OnSelect(event, player, _, sender, intid, code)
player:GossipClearMenu()
		local x = player:GetX()
		local y = player:GetY()
		local z = player:GetZ()
		local o = player:GetO()
		local level = player:GetLevel()
		local currentgold = player:GetCoinage()
		local mingmrank = 3
		local class = player:GetClass()
		local gold = 10000
		
		
	if(intid == 1) then	
	player:GossipMenuAddItem(0, "[Morph by Name- 10 Gold]", 0, 2, true, "Enter the name of the NPC")
	player:GossipMenuAddItem(0, "[Morph by ID#- 10 Gold]", 0, 3, true, "Enter the ID of the NPC")
	player:GossipMenuAddItem(0, "[Random Morph - 10 Gold]", 0, 4)
	player:GossipMenuAddItem(0, "[Remove Morph]", 0, 13)
	player:GossipSendMenu(1, player, 100)
	end
		
	if(intid == 11) then
	player:DurabilityRepairAll(false,100)
	player:SendBroadcastMessage("|cff00cc00 All of your items have been repaired!|r")
	Hello(event, player)
		return false
	end
	
	if(intid == 4) then
	local curentmodel = player:GetDisplayId()
	local defaultdisplayId = player:GetNativeDisplayId()
	local randmodel = WorldDBQuery(string.format("SELECT modelid1 FROM creature_template ORDER BY RAND() LIMIT 1"))
	
	if randmodel ~= nil then 
      local row = randmodel:GetRow()

     randmodelnumber = tonumber(row["modelid1"])
    end

	--local rand = math.random(20000,30000)
		if (currentgold >= gold*10) then
			if player:GetDisplayId() ~= randmodelnumber then
            player:SetDisplayId(randmodelnumber)
			player:ModifyMoney( -gold*10 )
			else
			player:SetDisplayId(randmodelnumber)
			player:ModifyMoney( -gold*10 )
			end
			
		player:GossipComplete()

	end
	end
	
	
	if(intid == 2) then
	if code ~= nil then
	local name = code:gsub("'", "''")

	local modelname = WorldDBQuery(string.format("SELECT modelid1 FROM creature_template WHERE name='%s'", tostring(name)))
	local modelnamenum = nil
	
    if modelname ~= nil then 
      local row = modelname:GetRow()

     modelnamenum = tonumber(row["modelid1"])
    end
	
	
	if modelnamenum ~= nil then
	if (currentgold >= gold*10) then
	if player:GetDisplayId() ~= modelnamenum then
	player:SetDisplayId(modelnamenum)
	player:ModifyMoney( -gold*10 )
	else
	player:SendAreaTriggerMessage("You are already using the "..code.." model")
	end
	else
	player:SendAreaTriggerMessage("You don't have enough gold!")
	end
	else
	player:SendAreaTriggerMessage("Invalid NPC name")
	end
	end
	player:GossipComplete()
	end
	
	if(intid == 3) then
	local getmodelid = WorldDBQuery(string.format("SELECT modelid1 FROM creature_template WHERE entry='%s'", tonumber(code)))
	local getmodelname = WorldDBQuery(string.format("SELECT name FROM creature_template WHERE entry='%s'", tonumber(code)))
	local themodelid = nil
	local themodelname = nil
	
	if code ~= nil then
	if getmodelid ~= nil then 
      local rowid = getmodelid:GetRow()
     themodelid = tonumber(rowid["modelid1"])
    end
	
	if getmodelname ~= nil then 
      local rowname = getmodelname:GetRow()

	 themodelname = tostring(rowname["name"])
    end
	
	if themodelid  ~= nil then
	if (currentgold >= gold*10) then
	if player:GetDisplayId() ~= themodelid then
	player:SetDisplayId(themodelid)
	player:ModifyMoney( -gold*10 )
	else
	player:SendAreaTriggerMessage("You are already using the "..themodelname.." model")

	end
	else
	player:SendAreaTriggerMessage("You don't have enough gold!")
	end
	else
	player:SendAreaTriggerMessage("Invalid NPC ID #")
	end
	end
	player:GossipComplete()
	end
	
	
	
	if(intid == 13) then
	local defaultdisplayId = player:GetNativeDisplayId()
             player:SetDisplayId(defaultdisplayId)
			 Hello(event, player)
			 player:GossipComplete()
		return false
	end

	if(intid == 14) then
	--player:RemoveSpell(31700)
	--player:AddItem(987654, 1)
	
	player:LearnSpell(31700)
	
	Hello(event, player)
		return false
	end
	
	if(intid== 15) then 
		local pgid = getPlayerCharacterGUID(player)
		player:SendShowMailBox( pgid )
	end
	
	if(intid== 16) then 
	player:SendShowBank( player )
	end
	
	if(intid== 17) then 
	player:SendAuctionMenu( player )
	end
	
	if(intid == 99) then
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
	
	
	if(intid== 18) then
	if player:IsHorde() then
	player:GossipMenuAddItem(0, "Tauren Starting Area", 0, 69)
	player:GossipMenuAddItem(0, "Undead Starting Area", 0, 70)
	player:GossipMenuAddItem(0, "Bloode Elf Starting Area", 0, 71)
	player:GossipMenuAddItem(0, "Orc/Troll Starting Area", 0, 72)
	else
	player:GossipMenuAddItem(0, "Gnome/Dwarf Starting Area", 0, 73)
	player:GossipMenuAddItem(0, "Night Elf Starting Area", 0, 74)
	player:GossipMenuAddItem(0, "Draenei Starting Area", 0, 75)
	player:GossipMenuAddItem(0, "Human Starting Area", 0, 76)
	end
	
	
	
	
	
	player:GossipMenuAddItem(0, "Back", 0, 59)
	player:GossipSendMenu(1, player, 100)

	end
	
	if(intid == 69) then
		player:Teleport( 1, -2921, -244, 53.33, 4.62 )
		player:GossipComplete()
	end

	if(intid == 70) then
		player:Teleport( 0, 1662, 1663, 141.89, 6.26 )
		player:GossipComplete()
	end
	if(intid == 71) then
		player:Teleport( 530, 10345, -6372, 35.89, 1.40 )
		player:GossipComplete()
	end
	
	if(intid == 72) then
		player:Teleport( 1, -601, -4266, 39, 1.79 )
		player:GossipComplete()
	end
	if(intid == 73) then
		player:Teleport( 0, -6240, 342, 383.22, 5.36 )
		player:GossipComplete()
	end
	
	
	if(intid == 74) then
		player:Teleport( 1, 10311.30, 831.46, 1326.41, 5.48 )
		player:GossipComplete()
	end
	if(intid == 75) then
		player:Teleport( 530, -3963, -13934, 100.26, 1.64 )
		player:GossipComplete()
	end
	
	if(intid == 76) then
		player:Teleport( 0, -8950, -132.50, 83.53, 0 )
		player:GossipComplete()
	end
	if(intid == 59) then
		Hello(event, player)
		return false
	end
	
if(intid== 49) then
	local bag1 = player:GetItemByPos(255, 19)
	local bag2 = player:GetItemByPos(255, 20)
	local bag3 = player:GetItemByPos(255, 21)
	local bag4 = player:GetItemByPos(255, 22)
	
	if class == 3 and bag1 ~= nil then
	player:AddItem(41600, 1)
	player:AddItem(2512, 1800)
	end
	
	
	player:LearnSpell(34091)
	player:LearnSpell(73324)
	if (class == 3) then
	player:LearnSpell(5300)
	player:LearnSpell(1579)
	end
	
		if bag1 == nil then
		player:EquipItem( 41600, 19 )
		end
		if bag2 == nil then
		player:EquipItem( 41600, 20 )
		end
		if bag3 == nil then
		player:EquipItem( 41600, 21 )
		end
		if bag4 == nil then
		player:EquipItem( 41600, 22 )
		end
		
		player:AddItem(51996, 1)
		player:AddItem(51992, 1)
		player:AddItem(51994, 1)
	
	

	for _,v in ipairs(T[class]) do
			player:RemoveItem(v, 9)
			if v == 42992 or v == 42991 or v == 42944 then
            player:AddItem(v, 2)
			else
			player:AddItem(v, 1)
			end
        end
	WorldDBExecute(string.format("INSERT INTO world.heirloom_list VALUES (%i)", getPlayerCharacterGUID(player)))
	player:GossipComplete()
	end
	
	if player:HasSpell(71342) then
	player:RemoveItem(50250, 1)
	end

	
	if(intid== 67) then
	player:SpawnCreature( 2832, x+1, y+1, z+0.5, o-3.5, 1, 20 )
	end
	
	if(intid== 98) then
	if (currentgold >= gold*5) then
	player:ModifyMoney( -gold*5 )
	player:SpawnCreature( 70000, x+1, y+1, z+0.5, o-3.5, 1, 60 )
	else
	player:SendAreaTriggerMessage("You don't have enough gold!")
	end
	player:GossipComplete()
	end
	
	if(intid== 97) then
	if code ~= nil then
	local isnum = tonumber(code)
	if isnum then
		if isnum >= -214748 and isnum <= 214748 then
	    player:ModifyMoney( gold*isnum )
		else
		if isnum <= -214748 then 
		player:SendAreaTriggerMessage("Value must be greater than -214748")
		end
		if isnum >= 214748 then 
		player:SendAreaTriggerMessage("Value must be less than 214748")
		end
		end

		player:GossipComplete()
	else
	    player:SendAreaTriggerMessage(""..tostring(code).." is not a number.")
		player:GossipComplete()
	end
	
	
	end
	end
	
	

end


local function PlrMenu(event, player, message, Type, lang)
	
	if (message:lower() == command) then
		local mingmrank = 3
		if (GMonly and player:GetGMRank() < mingmrank) then
		player:SendBroadcastMessage("|cff5af304Only a GM can use this command.|r")
		return false
		else
		Hello(event, player)
		return false
	end
	end
end


RegisterPlayerEvent(30, OnFirstLogin)
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(42, PlrMenu)
RegisterPlayerGossipEvent(100, 2, OnSelect)

