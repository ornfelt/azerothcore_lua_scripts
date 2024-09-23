--Misc required variables
playersQueue = {}
local PlayerDeathEvent = 0
local CurrentCard = 0
local maxSize = 0
--Editable Stuff
local QueueCreatureEntry = 829
local maxTime = 120000
local BrawlPointItemID = 600016
local timerAura = 707474
--boss Card Item IDs
local SkonkCard = 600000
local AxisCard = 600001
local TaulixCard = 600002
local RegnarCard = 600003
local FolutanCard = 600004
local ErixCard = 600005
local AbbendisCard = 600006
local NoxeliaCard = 600007
local WendigoCard = 600008
local VengeworthyCard = 600009
local TrustilloCard = 600010
local FargaxCard = 600011
local AgrulothCard = 600012
local VenthrilgonCard = 600013
local TrullaxCard = 600014
local ConnorCard = 600015
local CreatureSpawned = ""
--Boss ID,x,y,z,o,brawl point given
BossList = {
["Skonk"] = {2324600,-11809.36,11982.3,88.84,2.4,1},
["Axis"] = {2324700,-11809.36,11982.3,88.84,2.4,2},
["Taulix"] = {2324800,-11809.36,11982.3,88.84,2.4,3},
["Regnar"] = {2324900,-11809.36,11982.3,88.84,2.4,4},
["Folutan the Damned"] = {2325000,-11809.36,11982.3,88.84,2.4,5},
["Erix"] = {2325100,-11809.36,11982.3,88.84,2.4,6},
["General Abbendis"] = {2325200,-11809.36,11982.3,88.84,2.4,7},
["Priestess Noxelia"] = {2325300,-11809.36,11982.3,88.84,2.4,8},
["Wendigo"] = {2325400,-11809.36,11982.3,88.84,2.4,9},
["Mr. Vengeworthy"] = {2325500,-11809.36,11982.3,88.84,2.4,10},
["Trustillo the Vendetta"] = {2325600,-11809.36,11982.3,88.84,2.4,11},
["Fargax"] = {2325700,-11809.36,11982.3,88.84,2.4,12},
["Agruloth"] = {2325800,-11809.36,11982.3,88.84,2.4,13},
["Venthrilgon"] = {2325900,-11809.36,11982.3,88.84,2.4,14},
["Trullax"] = {2326000,-11809.36,11982.3,88.84,2.4,15},
["Fat Child"] = {2326100,-11809.36,11982.3,88.84,2.4,20}
}
 --map,x,y,z,o
playerTeleport = {
{571,-11828.36,12000.658,88.84,5.53},
}
--Card to boss connection
CardList = {
["Brawl Card: Skonk"] = {BossList["Skonk"]},
["Brawl Card: Axis"] = {BossList["Axis"]},
["Brawl Card: Taulix"] = {BossList["Taulix"]},
["Brawl Card: Regnar"] = {BossList["Regnar"]},
["Brawl Card: Folutan the Damned"] = {BossList["Folutan the Damned"]},
["Brawl Card: Erix"] = {BossList["Erix"]},
["Brawl Card: General Abbendis"] = {BossList["General Abbendis"]},
["Brawl Card: Priestess Noxelia"] = {BossList["Priestess Noxelia"]},
["Brawl Card: Wendigo"] = {BossList["Wendigo"]},
["Brawl Card: Mr. Vengeworthy"] = {BossList["Mr. Vengeworthy"]},
["Brawl Card: Trustillo the Vendetta"] = {BossList["Trustillo the Vendetta"]},
["Brawl Card: Fargax"] = {BossList["Fargax"]},
["Brawl Card: Agruloth"] = {BossList["Agruloth"]},
["Brawl Card: Venthrilgon"] = {BossList["Venthrilgon"]},
["Brawl Card: Trullax"] = {BossList["Trullax"]},
["Brawl Card: Fat Child"] = {BossList["Fat Child"]}
}

function tookTooLong()
	GetPlayerByGUID(playersQueue[1][1]):Teleport(571,-11848.594,12018.8867,88.68,5.53)
	GetPlayerByGUID(playersQueue[1][1]):RegisterEvent(kill, 500)
	GetPlayerByGUID(playersQueue[1][1]):RegisterEvent(nextPlayer, 10000)
end

function kill()
GetPlayerByGUID(playersQueue[1][1]):Kill(GetPlayerByGUID(playersQueue[1][1]))
end

function movePlayerIn()
	if(GetPlayerByGUID(playersQueue[1][1]) == nil ) then
	else
		GetPlayerByGUID(playersQueue[1][1]):Teleport(571,-11828.36,12000.658,88.84,5.53)
		GetPlayerByGUID(playersQueue[1][1]):AddAura( timerAura, GetPlayerByGUID(playersQueue[1][1]) )
		addInBoss()
	end
end

function nextPlayer()
	maxSize = maxSize - 1
	table.remove(playersQueue,1)
	for i in pairs(playersQueue) do
		if (i == 1) then
			GetPlayerByGUID(playersQueue[i][1]):SendBroadcastMessage( "|TInterface/ICONS/Exc:35:35|tYou're up!|TInterface/ICONS/Exc:35:35|t" )
			GetPlayerByGUID(playersQueue[i][1]):SendAreaTriggerMessage( "|TInterface/ICONS/Exc:35:35|tYou're up!|TInterface/ICONS/Exc:35:35|t" )
		else
			GetPlayerByGUID(playersQueue[i][1]):SendBroadcastMessage( "|TInterface/ICONS/exclam:35:35|tYour place in line is: " .. i )
			GetPlayerByGUID(playersQueue[i][1]):SendAreaTriggerMessage( "|TInterface/ICONS/exclam:35:35|tYour place in line is: " .. i )
		end
	end
if(playersQueue[1] ~= nil) then
		movePlayerIn()
	end
end

function addInBoss()
	for i in pairs(playersQueue[1][2]) do
		for j in pairs(playersQueue[1][2][i]) do
			if (playersQueue[1][2][i][j] > 0 and playersQueue[1][2][i][j+4] ~= nil) then
				CreatureSpawned = GetPlayerByGUID(playersQueue[1][1]):SpawnCreature(playersQueue[1][2][i][j], playersQueue[1][2][i][j+1], playersQueue[1][2][i][j+2], playersQueue[1][2][i][j+3],playersQueue[1][2][i][j+4], 2, maxTime ) --may also need to try event ID 9
			end
		end
	end	
	PlayerDeathEvent = CreatureSpawned:RegisterEvent(tookTooLong, maxTime) -- do it after 2 min once
	CreaturedeathEvent = CreatureSpawned:RegisterEvent(function(event, delay, repeats, creature)creature:Kill(creature) end,maxTime)
	
end

function playerDeath(event, creature, victim)
    RemoveEventById(PlayerDeathEvent)
    GetPlayerByGUID(playersQueue[1][1]):Teleport(571,-11848.594,12018.8867,88.68,5.53)
	creature:DespawnOrUnsummon(3000)
    GetPlayerByGUID(playersQueue[1][1]):RegisterEvent(nextPlayer, 10000)
end

function bossDeath(event, creature, killer)
    RemoveEventById(PlayerDeathEvent)
	GetPlayerByGUID(playersQueue[1][1]):RemoveAura(timerAura)
	for i in pairs(playersQueue[1][2]) do
		for j in pairs(playersQueue[1][2][i]) do
			if (playersQueue[1][2][i][j] > 0 and playersQueue[1][2][i][j+4] ~= nil) then
				GetPlayerByGUID(playersQueue[1][1]):AddItem(BrawlPointItemID,playersQueue[1][2][i][j+5])
			end
		end
	end
    GetPlayerByGUID(playersQueue[1][1]):Teleport(571,-11848.594,12018.8867,88.68,5.53)
    GetPlayerByGUID(playersQueue[1][1]):RegisterEvent(nextPlayer, 10000)
end

function onHello(event, player, object)
	if(player:HasItem(SkonkCard)) then
		player:GossipMenuAddItem(0,"|TInterface/ICONS/Brawler_Card_01:35:35|tBrawl Card: Skonk", 0, 50)
	end
	if(player:HasItem(AxisCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_02:35:35|tBrawl Card: Axis", 0, 51)
	end
	if(player:HasItem(TaulixCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_03:35:35|tBrawl Card: Taulix", 0, 52)
	end
	if(player:HasItem(RegnarCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_04:35:35|tBrawl Card: Regnar", 0, 53)
	end
	if(player:HasItem(FolutanCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_05:35:35|tBrawl Card: Folutan the Damned", 0, 54)
	end
	if(player:HasItem(ErixCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_06:35:35|tBrawl Card: Erix", 0, 55)
	end
	if(player:HasItem(AbbendisCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_07:35:35|tBrawl Card: General Abbendis", 0, 56)
	end
	if(player:HasItem(NoxeliaCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_08:35:35|tBrawl Card: Priestess Noxelia", 0, 57)
	end
	if(player:HasItem(WendigoCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_09:35:35|tBrawl Card: Wendigo", 0, 58)
	end
	if(player:HasItem(VengeworthyCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_10:35:35|tBrawl Card: Mr. Vengeworthy", 0, 59)
	end
	if(player:HasItem(TrustilloCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_11:35:35|tBrawl Card: Trustillo the Vendetta", 0, 60)
	end
	if(player:HasItem(FargaxCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_12:35:35|tBrawl Card: Fargax", 0, 61)
	end
	if(player:HasItem(AgrulothCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_13:35:35|tBrawl Card: Agruloth", 0, 62)
	end
	if(player:HasItem(VenthrilgonCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_14:35:35|tBrawl Card: Venthrilgon", 0, 63)
	end
	if(player:HasItem(TrullaxCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_15:35:35|tBrawl Card: Trullax", 0, 64)
	end
	if(player:HasItem(ConnorCard)) then
		player:GossipMenuAddItem( 0, "|TInterface/ICONS/Brawler_Card_16:35:35|tBrawl Card: Fat Child", 0, 65)
	end
	--player:GossipMenuAddItem( 0, "|TInterface/ICONS/nope:35:35|tRemove Me From Queue", 0, 100)
	player:GossipSendMenu(100,object)	
end

function onSelect(event, player, unit, sender, intid, code, id)
	if (intid == 50) then
		CurrentCard = CardList["Brawl Card: Skonk"]
		player:RemoveItem(SkonkCard,1)
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 51) then
		player:RemoveItem(AxisCard,1)
		CurrentCard = CardList["Brawl Card: Axis"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 52) then
		player:RemoveItem(TaulixCard,1)
		CurrentCard = CardList["Brawl Card: Taulix"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 53) then
		player:RemoveItem(RegnarCard,1)
		CurrentCard = CardList["Brawl Card: Regnar"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 54) then
		player:RemoveItem(FolutanCard,1)
		CurrentCard = CardList["Brawl Card: Folutan the Damned"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 55) then
		player:RemoveItem(ErixCard,1)
		CurrentCard = CardList["Brawl Card: Erix"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 56) then
		player:RemoveItem(AbbendisCard,1)
		CurrentCard = CardList["Brawl Card: General Abbendis"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 57) then
		player:RemoveItem(NoxeliaCard,1)
		CurrentCard = CardList["Brawl Card: Priestess Noxelia"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 58) then
		player:RemoveItem(WendigoCard,1)
		CurrentCard = CardList["Brawl Card: Wendigo"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 59) then
		player:RemoveItem(VengeworthyCard,1)
		CurrentCard = CardList["Brawl Card: Mr. Vengeworthy"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 60) then
		player:RemoveItem(TrustilloCard,1)
		CurrentCard = CardList["Brawl Card: Trustillo the Vendetta"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 61) then
		player:RemoveItem(FargaxCard,1)
		CurrentCard = CardList["Brawl Card: Fargax"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 62) then
		player:RemoveItem(AgrulothCard,1)
		CurrentCard = CardList["Brawl Card: Agruloth"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 63) then
		player:RemoveItem(VenthrilgonCard,1)
		CurrentCard = CardList["Brawl Card: Venthrilgon"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 64) then
		player:RemoveItem(TrullaxCard,1)
		CurrentCard = CardList["Brawl Card: Trullax"]
		onSelectionFinish(player,CurrentCard)
	elseif (intid == 65) then
		player:RemoveItem(ConnorCard,1)
		CurrentCard = CardList["Brawl Card: Fat Child"]
		onSelectionFinish(player,CurrentCard)
	end
	player:GossipComplete()
end

function onSelectionFinish(player)
	playersQueue[#playersQueue + 1] = {player:GetGUID(),CurrentCard}
	if(maxSize == 0) then
		movePlayerIn()
	end
	maxSize = maxSize + 1
end

function onlog(event, player)
    if(playersQueue[1] ~= nil) then
    local id = tostring(playersQueue[1][1])
        if(player:GetGUID() == playersQueue[1][1]) then 
            CharDBQuery( "UPDATE `characters` SET `position_x` = (-11850.1) WHERE `guid` = "..id..";")
            CharDBQuery( "UPDATE `characters` SET `position_y` = (12020.1) WHERE `guid` = "..id..";")
            CharDBQuery( "UPDATE `characters` SET `position_z` = (90) WHERE `guid` = "..id..";")
            CharDBQuery( "UPDATE `characters` SET `map` = (571) WHERE `guid` = "..id..";")
        elseif(player == GetPlayerByGUID(playersQueue[1][1])) then 
            CharDBQuery( "UPDATE `characters` SET `position_x` = (-11850.1) WHERE `guid` = "..id..";")
            CharDBQuery( "UPDATE `characters` SET `position_y` = (12020.1) WHERE `guid` = "..id..";")
            CharDBQuery( "UPDATE `characters` SET `position_z` = (90) WHERE `guid` = "..id..";")
            CharDBQuery( "UPDATE `characters` SET `map` = (571) WHERE `guid` = "..id..";")
        end
    end
end


RegisterPlayerEvent( 4, onlog )
for i in pairs(BossList) do
	RegisterCreatureEvent(BossList[i][1],3,playerDeath)
	RegisterCreatureEvent(BossList[i][1],4,bossDeath)
end
RegisterCreatureGossipEvent( QueueCreatureEntry, 1, onHello)
RegisterCreatureGossipEvent( QueueCreatureEntry, 2, onSelect)