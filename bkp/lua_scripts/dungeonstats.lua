local enabled = true
local allkills = true -- If True then any kill will give random stat
local minmoblevel = 1
local elites = true
local dungeonbosses = true
local worldbosses = true
local guards = true
local minstat = 1
local maxstat = 10
local statchance = 100
local enablemailreward = true
local mailchance = 20
local mailitemid = {23162, 40896,40897,40899,40900,40901,40902,40903,40906,40908,40909,40912,40913,40914,40915,40916,40919,40920,40921,40922,40923,40924,41092,41094,41095,41096,41097,41098,41099,41100,41101,41102,41103,41104,41105,41106,41107,41108,41109,41110,41517,41518,41524,41526,41527,41529,41530,41531,41532,41533,41534,41535,41536,41537,41538,41539,41540,41541,41542,41547,41552,42396,42397,42398,42399,42400,42401,42402,42403,42404,42405,42406,42407,42408,42409,42410,42411,42412,42414,42415,42416,42417,42453,42454,42455,42456,42457,42458,42459,42460,42461,42462,42463,42464,42465,42466,42467,42468,42469,42470,42471,42472,42473,42734,42735,42736,42737,42738,42739,42740,42741,42742,42743,42744,42745,42746,42747,42748,42749,42750,42751,42752,42753,42754,42897,42898,42899,42900,42901,42902,42903,42904,42905,42906,42907,42908,42909,42910,42911,42912,42913,42914,42915,42916,42917,42954,42955,42956,42957,42958,42959,42960,42961,42962,42963,42964,42965,42966,42967,42968,42969,42970,42971,42972,42973,42974,43316,43331,43332,43334,43335,43338,43339,43340,43342,43343,43344,43350,43351,43354,43355,43356,43357,43359,43360,43361,43364,43365,43366,43367,43368,43369,43370,43371,43372,43373,43374,43376,43377,43378,43379,43380,43381,43385,43386,43388,43389,43390,43391,43392,43393,43394,43395,43396,43397,43398,43399,43400,43412,43413,43414,43415,43416,43417,43418,43419,43420,43421,43422,43423,43424,43425,43426,43427,43428,43429,43430,43431,43432,43533,43534,43535,43536,43537,43538,43539,43541,43542,43543,43544,43545,43546,43547,43548,43549,43550,43551,43552,43553,43554,43671,43672,43673,43674,43725,43825,43826,43827,43867,43868,43869,44684,44920,44922,44923,44928,44955,45601,45602,45603,45604,45622,45623,45625,45731,45732,45733,45734,45735,45736,45737,45738,45739,45740,45741,45742,45743,45744,45745,45746,45747,45753,45755,45756,45757,45758,45760,45761,45762,45764,45766,45767,45768,45769,45770,45771,45772,45775,45776,45777,45778,45779,45780,45781,45782,45783,45785,45789,45790,45792,45793,45794,45795,45797,45799,45800,45803,45804,45805,45806,46372,48720,49084,50045,50077,50125}
local Q = nil
local command = "ds"
local conversionrate = 2 --convert this ammount of unwanted stat to 1 of the wanted stat

local DSSQL = [[ CREATE TABLE IF NOT EXISTS Dungeon_Stats ( `CharID` int(10) unsigned, `Strength` int(10) unsigned, `Agility` int(10) unsigned, `Stamina` int(10) unsigned, `Intellect` int(10) unsigned, `Spirit` int(10) unsigned NOT NULL DEFAULT 1) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
WorldDBExecute(DSSQL)

local function randomChance (player, chance)
local rand = math.random(1,100)
		if  rand <= chance then
			return true
			else
			return false
		end                                    
end

local function getPlayerCharacterGUID(player)
	if player ~= nil then
    query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))
	end

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
  
 local function updatestat(player, stat, value)
player:HandleStatModifier( stat, 2, value, true )

end
  
local function SKULY(eventid, delay, repeats, player)
    local PUID = getPlayerCharacterGUID(player)
	if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
	end
	
	if Q then
	local CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		player:SendBroadcastMessage(string.format("|cff9CC243Dungeons Stat Totals: Str("..Strength..") Agility("..Agility..") Stam("..Stamina..") Int("..Intellect..") Spirit("..Spirit..")|r"))
		player:HandleStatModifier( 0, 2, Strength, true )
		player:HandleStatModifier( 1, 2, Agility, true )
		player:HandleStatModifier( 2, 2, Stamina, true )
		player:HandleStatModifier( 3, 2, Intellect, true )
		player:HandleStatModifier( 4, 2, Spirit, true )
		
	return false
	else 
	WorldDBExecute(string.format("DELETE FROM Dungeon_Stats WHERE CharID = %i", PUID))
	WorldDBExecute(string.format("INSERT INTO Dungeon_Stats VALUES (%i, 0, 0, 0, 0, 0)", PUID))
	return false
	end
end

local function OnLogin(event, player)

player:RegisterEvent(SKULY, 5000, 1, player)
	
end 

local function HandleplayerRewarding(player, creature)
local r = math.random(minstat,maxstat)
local randomstatval = 0
local statval = nil
local myTable = { 'Strength', 'Agility', 'Stamina', 'Intellect', 'Spirit' }
local randomstat = myTable[ math.random( #myTable ) ]
local PUID = getPlayerCharacterGUID(player)

if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
	if Q then
		local CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		
		if randomstat == "Strength" then
			randomstatval = Strength
			statval = 0
			elseif randomstat == "Agility" then
				randomstatval = Agility
				statval = 1
			elseif randomstat == "Stamina" then
				randomstatval = Stamina
				statval = 2
			elseif randomstat == "Intellect" then
				randomstatval = Intellect
				statval = 3
			elseif randomstat == "Spirit" then
				randomstatval = Spirit
				statval = 4
		end
		
		WorldDBExecute(string.format("UPDATE Dungeon_Stats SET "..randomstat.."=%i WHERE CharID=%i", randomstatval + r, PUID))
		--killer:HandleStatModifier( statval, 2, randomstatval, false )
		player:SendBroadcastMessage("|cffe9b518You recived".."|r |cff9CC243"..r.."|r |cffe9b518"..randomstat.." for killing "..creature:GetName().."|r")
		updatestat(player, statval, r )
		end
end




end


local function HandleplayerMailing(player, creature)
	player:SendBroadcastMessage("|cffe9b518You recived a reward for killing".."|r |cff5af304"..creature:GetName().."|r(You've Got Mail!)")
	local receiver = GetGUIDLow(GetPlayerByName(player:GetName()):GetGUID());
	local chosenmailitemid = mailitemid[math.random(1, #mailitemid)]
	SendMail( "Dungeon Reward", "You killed "..creature:GetName()..", here is a random reward.", tonumber(receiver), 1, 61, 1, 0, 0, chosenmailitemid, 1 )
end


local function BossKilled (event, killer, killed)
	if (allkills == true) or (worldbosses == true and killed:IsWorldBoss() == true) or (dungeonbosses == true and killed:IsDungeonBoss() == true) or (elites == true and killed:IsElite() == true) or (guards == true and killed:IsGuard() == true) and (killed:GetLevel() >= minmoblevel) then 
		if randomChance(killer, statchance) then	
			if killer:IsInGroup() then
				local group = killer:GetGroup()
				local groupPlayers = group:GetMembers()
				
				for k,v in pairs(groupPlayers) do
					if randomChance(v , statchance) then
						HandleplayerRewarding (v, killed)
					end
					
					if enablemailreward and randomChance(v, mailchance) then
						HandleplayerMailing(v, killed)
					end
				end
			else
					if randomChance(killer , statchance) then
						HandleplayerRewarding (killer, killed)
					end
					if enablemailreward and randomChance(killer, mailchance) then
						HandleplayerMailing(killer, killed)
					end
			end
			
			
			
		end
			
	end
end

local function OnSelectConvertStr(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end
if Agility >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Agility to 1 Strength", 0, 9, true, "You can trade Agility for upto "..(math.floor(Agility / conversionrate)).." Strength")
end
if Stamina >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Stamina to 1 Strength", 0, 10, true, "You can trade Stamina for upto "..(math.floor(Stamina / conversionrate)).." Strength")
end
if Intellect >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Intellect to 1 Strength", 0, 11, true, "You can trade Intellect for upto "..(math.floor(Intellect / conversionrate)).." Strength")
end
if Spirit >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Spirit to 1 Strength", 0, 12, true, "You can trade Spirit for upto "..(math.floor(Spirit / conversionrate)).." Strength")
end
player:GossipMenuAddItem(0, "Back", 0, 991)


if(intid == 9) then
	if isnum then
		if Agility >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength + isnum, PUID))
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			updatestat(player, Agilitystring, Agility - (isnum * conversionrate))
			updatestat(player, Strengthstring, Strength + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Agility to convert to "..isnum.." Strength|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 10) then
if isnum then
		if Stamina >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength + isnum, PUID))
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			updatestat(player, Staminastring, Stamina - (isnum * conversionrate))
			updatestat(player, Strengthstring, Strength + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Stamina to convert to "..isnum.." Strength|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 11) then
if isnum then
		if Intellect >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength + isnum, PUID))
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			updatestat(player, Intellectstring, Intellect - (isnum * conversionrate))
			updatestat(player, Strengthstring, Strength + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Intellect to convert to "..isnum.." Strength|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 12) then
if isnum then
		if Spirit >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength + isnum, PUID))
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			updatestat(player, Spiritstring, Spirit - (isnum * conversionrate))
			updatestat(player, Strengthstring, Strength + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Spirit to convert to "..isnum.." Strength|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 991) then
		OnSelectConvertMain(event, player)
		player:GossipSendMenu(1, player, 1980)
		return false
end
end

local function OnSelectConvertAgil(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end
if Strength >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Strength to 1 Agility", 0, 13, true, "You can trade Strength for upto "..(math.floor(Strength / conversionrate)).." Agility")
end
if Stamina >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Stamina to 1 Agility", 0, 14, true, "You can trade Stamina for upto "..(math.floor(Stamina / conversionrate)).." Agility")
end
if Intellect >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Intellect to 1 Agility", 0, 15, true, "You can trade Intellect for upto "..(math.floor(Intellect / conversionrate)).." Agility")
end
if Spirit >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Spirit to 1 Agility", 0, 16, true, "You can trade Spirit for upto "..(math.floor(Spirit / conversionrate)).." Agility")
end
player:GossipMenuAddItem(0, "Back", 0, 992)



if(intid == 13) then
if isnum then
		if Strength >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility + isnum, PUID))
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			updatestat(player, Strengthstring, Strength - (isnum * conversionrate))
			updatestat(player, Agilitystring, Agility + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Strength to convert to "..isnum.." Agility|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 14) then
if isnum then
		if Stamina >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility + isnum, PUID))
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			updatestat(player, Staminastring, Stamina - (isnum * conversionrate))
			updatestat(player, Agilitystring, Agility + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Stamina to convert to "..isnum.." Agility|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 15) then
if isnum then
		if Intellect >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility + isnum, PUID))
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			updatestat(player, Intellectstring, Intellect - (isnum * conversionrate))
			updatestat(player, Agilitystring, Agility + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Intellect to convert to "..isnum.." Agility|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 16) then
if isnum then
		if Spirit >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility + isnum, PUID))
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			updatestat(player, Spiritstring, Spirit - (isnum * conversionrate))
			updatestat(player, Agilitystring, Agility + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Spirit to convert to "..isnum.." Agility|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
end

if(intid == 992) then
		OnSelectConvertMain(event, player)
		player:GossipSendMenu(1, player, 1980)
		return false
end
end

local function OnSelectConvertStam(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end

if Strength >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Strength to 1 Stamina", 0, 17, true, "You can trade Strength for upto "..(math.floor(Strength / conversionrate)).." Stamina")
end
if Agility >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Agility to 1 Stamina", 0, 18, true, "You can trade Agility for upto "..(math.floor(Agility / conversionrate)).." Stamina")
end
if Intellect >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Intellect to 1 Stamina", 0, 19, true, "You can trade Intellect for upto "..(math.floor(Intellect / conversionrate)).." Stamina")
end
if Spirit >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Spirit to 1 Stamina", 0, 20, true, "You can trade Spirit for upto "..(math.floor(Spirit / conversionrate)).." Stamina")
end
player:GossipMenuAddItem(0, "Back", 0, 993)

if(intid == 17) then
if isnum then
		if Strength >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina + isnum, PUID))
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			updatestat(player, Strengthstring, Strength - (isnum * conversionrate))
			updatestat(player, Staminastring, Stamina + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Strength to convert to "..isnum.." Stamina|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 18) then
if isnum then
		if Agility >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina + isnum, PUID))
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			updatestat(player, Agilitystring, Agility - (isnum * conversionrate))
			updatestat(player, Staminastring, Stamina + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Agility to convert to "..isnum.." Stamina|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 19) then
if isnum then
		if Intellect >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina + isnum, PUID))
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			updatestat(player, Intellectstring, Intellect - (isnum * conversionrate))
			updatestat(player, Staminastring, Stamina + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Intellect to convert to "..isnum.." Stamina|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 20) then
if isnum then
		if Spirit >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina + isnum, PUID))
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			updatestat(player, Spiritstring, Spirit - (isnum * conversionrate))
			updatestat(player, Staminastring, Stamina + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Spirit to convert to "..isnum.." Stamina|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 993) then
		OnSelectConvertMain(event, player)
		player:GossipSendMenu(1, player, 1980)
		return false
end
end

local function OnSelectConvertInt(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end

if Strength >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Strength to 1 Intellect", 0, 21, true, "You can trade Strength for upto "..(math.floor(Strength / conversionrate)).." Intellect")
end
if Agility >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Agility to 1 Intellect", 0, 22, true, "You can trade Agility for upto "..(math.floor(Agility / conversionrate)).." Intellect")
end
if Stamina >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Stamina to 1 Intellect", 0, 23, true, "You can trade Stamina for upto "..(math.floor(Stamina / conversionrate)).." Intellect")
end
if Spirit >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Spirit to 1 Intellect", 0, 24, true, "You can trade Spirit for upto "..(math.floor(Spirit / conversionrate)).." Intellect")
end

player:GossipMenuAddItem(0, "Back", 0, 994)

if(intid == 21) then
if isnum then
		if Strength >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect + isnum, PUID))
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			updatestat(player, Strengthstring, Strength - (isnum * conversionrate))
			updatestat(player, Intellectstring, Intellect + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Strength to convert to "..isnum.." Intellect|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 22) then
if isnum then
		if Agility >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect + isnum, PUID))
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			updatestat(player, Agilitystring, Agility - (isnum * conversionrate))
			updatestat(player, Intellectstring, Intellect + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Agility to convert to "..isnum.." Intellect|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 23) then
if isnum then
		if Stamina >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET "..Intellect.."=%i WHERE CharID=%i", Intellect + isnum, PUID))
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			updatestat(player, Staminastring, Stamina - (isnum * conversionrate))
			updatestat(player, Intellectstring, Intellect + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Stamina to convert to "..isnum.." Intellect|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 24) then
if isnum then
		if Spirit >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect + isnum, PUID))
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			updatestat(player, Spiritstring, Spirit - (isnum * conversionrate))
			updatestat(player, Intellectstring, Intellect + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Spirit to convert to "..isnum.." Intellect|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 994) then
		OnSelectConvertMain(event, player)
		player:GossipSendMenu(1, player, 1980)
		return false
end
end

local function OnSelectConvertSp(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end

if Strength >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Strength to 1 Spirit", 0, 25, true, "You can trade Strength for upto "..(math.floor(Strength / conversionrate)).." Spirit")
end
if Agility >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Agility to 1 Spirit", 0, 26, true, "You can trade Agility for upto "..(math.floor(Agility / conversionrate)).." Spirit")
end
if Stamina >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Stamina to 1 Spirit", 0, 27, true, "You can trade Stamina for upto "..(math.floor(Stamina / conversionrate)).." Spirit")
end
if Intellect >= conversionrate then
player:GossipMenuAddItem(0, "Convert "..conversionrate.." Intellect to 1 Spirit", 0, 28, true, "You can trade Intellect for upto "..(math.floor(Intellect / conversionrate)).." Spirit")
end

player:GossipMenuAddItem(0, "Back", 0, 995)

if(intid == 25) then
if isnum then
		if Strength >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=%i WHERE CharID=%i", Strength - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit + isnum, PUID))
			player:HandleStatModifier( Strengthstring, 2, Strength, false )
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			updatestat(player, Strengthstring, Strength - (isnum * conversionrate))
			updatestat(player, Spiritstring, Spirit + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Strength to convert to "..isnum.." Spirit|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 26) then
if isnum then
		if Agility >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=%i WHERE CharID=%i", Agility - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit + isnum, PUID))
			player:HandleStatModifier( Agilitystring, 2, Agility, false )
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			updatestat(player, Agilitystring, Agility - (isnum * conversionrate))
			updatestat(player, Spiritstring, Spirit + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Agility to convert to "..isnum.." Spirit|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 27) then
if isnum then
		if Stamina >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=%i WHERE CharID=%i", Stamina - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit + isnum, PUID))
			player:HandleStatModifier( Staminastring, 2, Stamina, false )
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			updatestat(player, Staminastring, Stamina - (isnum * conversionrate))
			updatestat(player, Spiritstring, Spirit + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Stamina to convert to "..isnum.." Spirit|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 28) then
if isnum then
		if Intellect >= (isnum * conversionrate) then
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=%i WHERE CharID=%i", Intellect - (isnum * conversionrate), PUID))
			WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=%i WHERE CharID=%i", Spirit + isnum, PUID))
			player:HandleStatModifier( Intellectstring, 2, Intellect, false )
			player:HandleStatModifier( Spiritstring, 2, Spirit, false )
			updatestat(player, Intellectstring, Intellect - (isnum * conversionrate))
			updatestat(player, Spiritstring, Spirit + isnum)
		else
			player:SendBroadcastMessage("|cffD3664F You don't have enough Intellect to convert to "..isnum.." Spirit|r")
			Hello(event, player)
		end
	else
			player:SendBroadcastMessage("|cffD3664F"..code.." isn't a number|r")
	end
	Hello(event, player)
end

if(intid == 995) then
		OnSelectConvertMain(event, player)
		player:GossipSendMenu(1, player, 1980)
		return false
end
end

function OnSelectConvertMain(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end
player:GossipMenuAddItem(0, "Convert to Strength", 0, 4)
player:GossipMenuAddItem(0, "Convert to Agility", 0, 5)
player:GossipMenuAddItem(0, "Convert to Stamina", 0, 6)
player:GossipMenuAddItem(0, "Convert to Intellect", 0, 7)
player:GossipMenuAddItem(0, "Convert to Spirit", 0, 8)
player:GossipMenuAddItem(0, "Back", 0, 990)


if(intid == 4) then
OnSelectConvertStr(event, player)
player:GossipSendMenu(1, player, 1981)
end

if(intid == 5) then
OnSelectConvertAgil(event, player)
player:GossipSendMenu(1, player, 1982)
end

if(intid == 6) then
OnSelectConvertStam(event, player)
player:GossipSendMenu(1, player, 1983)
end

if(intid == 7) then
OnSelectConvertInt(event, player)
player:GossipSendMenu(1, player, 1984)
end

if(intid == 8) then
OnSelectConvertSp(event, player)
player:GossipSendMenu(1, player, 1985)
end

if(intid == 990) then
		Hello(event, player)
		return false
end

end

function Hello(event, player)
player:GossipClearMenu()
	player:GossipMenuAddItem(0, "View Dungeon Stats", 0, 1)
	player:GossipMenuAddItem(0, "Convert Dungeon Stats", 0, 2)
	--player:GossipMenuAddItem(0, "Reset Dungeon Stats", 0, 3, false, "Dungeon Stats will be Reset!")
	
	player:GossipSendMenu(1, player, 1979)
end

local function OnSelect(event, player, _, sender, intid, code)
player:GossipClearMenu()
local Strengthstring = 0 
local Agilitystring = 1
local Staminastring = 2
local Intellectstring = 3
local Spiritstring = 4 


local CharID, Strength, Agility, Stamina, Intellect, Spirit
local Q
local isnum
if code ~= nil then
	 isnum = tonumber(code)
end
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
	Q = WorldDBQuery(string.format("SELECT * FROM Dungeon_Stats WHERE CharID=%i", PUID))
		if Q then
			CharID, Strength, Agility, Stamina, Intellect, Spirit = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3), Q:GetUInt32(4), Q:GetUInt32(5)
		end
end


if(intid== 1) then
	if Q then
		player:SendBroadcastMessage(string.format("|cff9CC243Dungeon Stats Totals: Str("..Strength..") Agility("..Agility..") Stam("..Stamina..") Int("..Intellect..") Spirit("..Spirit..")|r"))
		Hello(event, player)
	return false
	end
	
end

if(intid== 2) then
OnSelectConvertMain(event, player)
player:GossipSendMenu(1, player, 1980)
end

if(intid== 3) then
	if PUID ~= nil then
	if Q then
	player:HandleStatModifier( 0, 2, Strength, false )
	player:HandleStatModifier( 1, 2, Agility, false )
	player:HandleStatModifier( 2, 2, Stamina, false )
	player:HandleStatModifier( 3, 2, Intellect, false )
	player:HandleStatModifier( 4, 2, Spirit, false )
	
	WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Strength=0 WHERE CharID=%i", PUID))
	WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Agility=0 WHERE CharID=%i", PUID))
	WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Stamina=0 WHERE CharID=%i", PUID))
	WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Intellect=0 WHERE CharID=%i", PUID))
	WorldDBExecute(string.format("UPDATE Dungeon_Stats SET Spirit=0 WHERE CharID=%i", PUID))
	player:SendBroadcastMessage(string.format("|cff9CC243Dungeon Stats Reset"))
	end


	Hello(event, player)
	end
end

end


local function PlrMenu(event, player, message)
	
	if (message:lower() == command) then
		Hello(event, player)
		return false
	end
end

if enabled then
RegisterPlayerEvent(42, PlrMenu)
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(7, BossKilled)
RegisterPlayerGossipEvent(1979, 2, OnSelect)
RegisterPlayerGossipEvent(1980, 2, OnSelectConvertMain)
RegisterPlayerGossipEvent(1981, 2, OnSelectConvertStr)
RegisterPlayerGossipEvent(1982, 2, OnSelectConvertAgil)
RegisterPlayerGossipEvent(1983, 2, OnSelectConvertStam)
RegisterPlayerGossipEvent(1984, 2, OnSelectConvertInt)
RegisterPlayerGossipEvent(1985, 2, OnSelectConvertSp)
end