local timeTillDeletion = 86400 --requirement in seconds before ban on next cleanDatabase
local timeToCallCleaning = 300000 -- in ms
local requiredItem = 1
local requiredItemAmount = 1
local respawnerNPC = 1
local function playerDeath(event, killer, killed)
	Ban("BAN_CHARACTER",killed:getName(),999999999,"killed by " ..killer:getName(),"Server")
	SendWorldMessage(killer:getName() .. " has killed " .. killed:GetName())
	CharDBQuery("INSERT INTO savedDeaths VALUES (" .. killed:getGUIDLow() .. "," .. string.lower(killed:getName()) .. "," .. killer:getGUIDLow() .. "," .. string.lower(killer:getName()) .. "," .. os.time() .. ")")
end

local function unbanAcc(killerGUID)
	CharDBQuery("DELETE FROM character_banned WHERE guid = " .. killerGUID)
	CharDBQuery("DELETE FROM savedDeaths WHERE killedGUID = " .. Q:GetUInt32(0))
end

local function cleanDatabase()
	local Q = CharDBQuery("SELECT * FROM savedDeaths")
	if Q then
		repeat
		if((Q:GetUInt32(4)+timeTillDeletion) <= os.time()) then
			CharDBQuery("DELETE FROM savedDeaths WHERE killedGUID = " .. Q:GetUInt32(0))
		end
		until not Q:NextRow()
	end
end

local function onHello(event, player, object)
	player:GossipMenuAddItem(0, "So you wish to Revive a teammate?", 0, 1, true, "Input your teammate's name")
	player:GossipMenuAddItem(0, "So you wish to DESTROY A SOUL?", 0, 2, true, "Input a soul's name to destroy")
	player:GossipSendMenu(1, object)
end

local function onSelect(event, player, object, sender, intid, code, menu_id)
	if(player:HasItem(requiredItem,requiredItemAmount)) then
		local charName = string.lower(tostring(code))
		local Q = CharDBQuery("SELECT FROM savedDeaths WHERE killedName = " .. charName)
		if Q then
			player:RemoveItem(requiredItem,requiredItemAmount)
			repeat
				if(intid == 1) then
					unbanAcc(Q:GetUInt32(0))
				else if(intid == 2) then
					CharDBQuery("UPDATE savedDeaths SET deathTime = " .. os.time() + 99999999 .. " WHERE killedName = " .. charName)
					cleanDatabase()
				end
			until not Q:NextRow()
		else
			player:SendBroadcastMessage("That name was incorrect!")
		end
	else
		player:SendBroadcastMessage("You need the correct items! Hurry along now")
	end
	player:GossipComplete()
end

RegisterCreatureGossipEvent(respawnerNPC,OnHello)
RegisterCreatureGossipEvent(respawnerNPC,OnSelect)
CreateLuaEvent( cleanDatabase, delay )
RegisterPlayerEvent( 6, playerDeath )