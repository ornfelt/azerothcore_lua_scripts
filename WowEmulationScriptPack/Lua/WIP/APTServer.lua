local AIO = AIO or require("AIO")
local APTHandlers = AIO.AddHandlers("APTStuff", {})

-- Owner: grimreapaa

-- how long should APTs last in seconds. default: 259200 (3 days)
APT_TIME_EXPIRED = 31536000

--how often the server should check for spawned APTs in ms(bigger value may be needed for slower servers). default 1800000 (30mins)
APT_TIME_CHECK = 1800000

-- Zones that APTs are disallowed in.
DISABLE_APT_ZONES = {
    [5000]=true, -- spark
    [1581]=true, -- darkmines outside spark
}


-- The player uses item before casting spell, so we define which item and the GUID.
local function APT_OnUse(event, player, item, target)
	item_entry = tonumber(item:GetEntry())
	item_guid = tonumber(item:GetGUIDLow())
end

-- Registers item events to declare on use hooks.
-- Chronological order of these functions: APTStartUp -> APT_RegisterEvents -> APT_ReloadEvents -> APT_RegisterEvents
local function APT_RegisterEvents()
	APT_Query1 = WorldDBQuery("SELECT item_id, gobject FROM apt_template")
	if (APT_Query1 == nil) then
		-- Create `apt_template` table if not exists. Print error to populate database.
		PrintInfo("[APT]: Table `apt_template` is not populated with any entries. Please create some and restart your server to use the APT system. Afterwards, you may use `.reload apt_template.`")
		return
	else
		APT_objects = {}
		APT_items = {}
		for x=1,APT_Query1:GetRowCount(),1 do
			local APT_Query2 = WorldDBQuery("SELECT entry FROM gameobject_template WHERE entry = " ..APT_Query1:GetInt32(1).. ";")
			if (APT_Query2 == nil) then -- Print error and do not insert into array if gobject entry does not exist in gameobject_template
				PrintInfo("[APT]: Table `apt_template` has incorrect gameobject value: " ..APT_Query1:GetInt32(1).. ".")
			else
				APT_objects[APT_Query1:GetInt32(0)] = APT_Query1:GetInt32(1) -- Insert into array item_id = gobject
				APT_items[APT_Query1:GetInt32(1)] = APT_Query1:GetInt32(0) -- Reverse array. gobject = item_id
				RegisterItemEvent(APT_Query1:GetInt32(0), 2, APT_OnUse) -- Register item events ON_USE. If item does not exist, error prints.
				APT_Query1:NextRow()
			end
		end
	end
end

-- On script load, run function.
local function APTStartUp(event)
	APT_RegisterEvents()
end

-- Deletes item events before re-registering them via `.reload apt_template`
local function APT_ReloadEvents(event, player, command)
	if (command ~= "reload apt_template") then
		return
	else
		for x in pairs(APT_items) do
			ClearItemEvents(APT_items[x], 2) -- table[pos]  [pos]=value
			SendWorldMessage("DB table `apt_template` reloaded.")
		end
		APT_RegisterEvents()
	end
end

-- dummy event to return object if found
local function Dummy_Event()

end

-- TO DO: Create table if not exists without firing the spell hook every time. On reload apt_template?
-- Chronological order -> APT_OnUse -> APT_Spell
local function APT_Spell(event, player, spell, skipCheck)
	-- This event is fired every time a spell is cast, so we must kill the function first.
	if (spell:GetEntry() ~= 2000001) then
		return
	end
	local instanceid = player:GetInstanceId()
	-- here we stop error spam from a nil instanceid
	if (instanceid == nil) then
		instanceid = 0
	end
  	-- If player is placing APT in disabled zone, then stop the script from running.
	if DISABLE_APT_ZONES[player:GetZoneId()] == true then
		player:SendBroadcastMessage("You are not allowed to place APTs in this area.")
    	return
    end
	
	local spell_x, spell_y, spell_z = spell:GetTargetDest()
	local APT_Query3 = WorldDBQuery("SELECT item_instance, gobject_guid, gobject_raw, map, x, y, z, o FROM apt_spawned WHERE item_instance = " ..item_guid.. ";")
	-- spawn APT if item_guid does not have an entry. Spell cannot use GetNearestGameObject, so we get a little hacky by spawning an NPC that can use that method at the spell xyz.
	if (APT_Query3 == nil) then
		-- we put a cooldown here so players cannot spam spawn, as DB issues can happen this way.
		-- if player:GetLuaCooldown(1998) == 0 then
		-- 	player:SetLuaCooldown(0.025, 1998)
		-- else
		-- 	player:SendBroadcastMessage("You must wait a second or two before spawning again.")
		-- 	return
		-- end
		
		PerformIngameSpawn(2, APT_objects[item_entry], player:GetMapId(), instanceid, spell_x, spell_y, spell_z, player:GetO(), true, 0, 1)
		PerformIngameSpawn(1, 32277, player:GetMapId(), player:GetInstanceId(), spell_x, spell_y, spell_z, player:GetO(), false, 0, 3)
	-- this is made to catch any overlap of GUIDs and attempts to fix them.
		local dummy = player:GetNearestCreature(50, 32277, 0, 1)
		local nearestobjects = dummy:GetGameObjectsInRange(10, APT_objects[item_entry], 0)
		local WeaverQuery2 = WorldDBQuery("SELECT `gobject_guid` FROM `apt_spawned` WHERE `gobject_guid` = " ..nearestobjects[1]:GetDBTableGUIDLow().. ";")
		for x=1,#nearestobjects,1 do
			if WeaverQuery2 ~= nearestobjects[x] then
--				player:SendBroadcastMessage("Detecting break. Fixing?")
				nearestobject_guid = nearestobjects[x]:GetDBTableGUIDLow()
				nearestobject_raw = nearestobjects[x]:GetGUIDLow()
				map = nearestobjects[x]:GetMapId()
				break
			end
		end
--		local object_guid = dummy:GetNearestGameObject(5, APT_objects[item_entry])
		WorldDBExecute("INSERT INTO `elunaworld`.`apt_spawned` (`item_instance`, `gobject_guid`, `gobject_raw`, `gobject_entry`, `map`, `x`, `y`, `z`, `o`, `timestamp`, `owner_character`, `owner_account`,`owner_guid`) VALUES ('" ..item_guid.. "', '" ..nearestobject_guid.. "', '" ..nearestobject_raw.. "', '" ..APT_objects[item_entry].. "', '" ..map.. "', '" ..spell_x.. "', '" ..spell_y.. "', '" ..spell_z.. "', '" ..player:GetO().. "', '" ..tostring(GetGameTime()).. "', '" ..player:GetName().. "', '" ..player:GetAccountName().. "', '" ..player:GetGUIDLow().. "');")
		dummy:DespawnOrUnsummon(0)
		AwardAchievement(player, 65498)
		return
	else
	-- delete APT if already spawned
--		local low_guid = GetGUIDLow( APT_Query3:GetInt32(2) )
--		print(low_guid)
--		print(APT_Query3:GetInt32(2))
--		local map = GetMapById(APT_Query3:GetInt32(3))
--		local build = GetObjectGUID(APT_Query3:GetInt32(2), APT_objects[item_entry])
--		print(build)
--		gameObjectsInRange = player:GetGameObjectsInRange( 100, APT_objects[item_entry] )
--		for x=1,#gameObjectsInRange,1 do
--			if gameObjectsInRange[x]:GetDBTableGUIDLow() == APT_Query3:GetInt32(1) then
--				print(gameObjectsInRange[x]:GetGUID())
--				print(gameObjectsInRange[x]:GetGUIDLow())
--			end
--		end
--		local object = map:GetWorldObject(build)
		if APT_Query3:GetInt32(3) == player:GetMapId() then
			local x, y, z, o = player:GetLocation()
			local range = player:GetDistance2d(APT_Query3:GetInt32(4), APT_Query3:GetInt32(5)) + 10
--			print("searching range: " ..range)
			local gameObjectsInRange = player:GetGameObjectsInRange( range, APT_objects[item_entry] )
--			print(APT_Query3:GetInt32(1))
--			print("game objects in range " ..#gameObjectsInRange)
			for x=1,#gameObjectsInRange,1 do
				if gameObjectsInRange[x]:GetDBTableGUIDLow() == APT_Query3:GetInt32(1) then
---					print(APT_Query3:GetInt32(1))
---					print(gameObjectsInRange[x]:GetGUID())
---					print(gameObjectsInRange[x]:GetGUIDLow())
					object = gameObjectsInRange[x]
				end
			end
		else
			player:SendBroadcastMessage("[APT System]: The APT you are trying to pick up is not on the same map as you.")
			return false
		end
		PrintInfo("[APT]: Player " .. player:GetName() .. " just deleted APT with itemID " .. item_guid .. ".")
		object:RemoveFromWorld(true)
		WorldDBExecute("DELETE FROM apt_spawned WHERE item_instance = " ..item_guid.. ";")
		return
	end
end

local function APT_CleanUp(eventId, delay, repeats)
	local APT_CleanUp_Query2 = WorldDBQuery("SELECT gobject_guid, gobject_raw, map, `timestamp`, `gobject_entry` FROM apt_spawned;")
	GamerTime = GetGameTime()
	if (APT_CleanUp_Query2 == nil) then
		return false
	else
		for x=1,APT_CleanUp_Query2:GetRowCount(),1 do
			-- if gametime - time apt was placed is bigger than 3 days, then remove.
			if (GamerTime - APT_CleanUp_Query2:GetInt32(3) > APT_TIME_EXPIRED) then
				local map = GetMapById(APT_CleanUp_Query2:GetInt32(2))
				local build = GetObjectGUID(APT_CleanUp_Query2:GetInt32(1), APT_CleanUp_Query2:GetInt32(4))
--				print(APT_CleanUp_Query2:GetInt32(1).. ":" ..APT_CleanUp_Query2:GetInt32(4))
				local object = map:GetWorldObject(build)			
				object:RemoveFromWorld(true)
				WorldDBExecute("DELETE FROM apt_spawned WHERE gobject_guid = " ..APT_CleanUp_Query2:GetInt32(0).. ";")
				APT_CleanUp_Query2:NextRow()
			end
		end
	end
end

CreateLuaEvent(APT_CleanUp, APT_TIME_CHECK, 0) -- every half hour we check for APTs over expired time before deleting. 1800000
RegisterPlayerEvent(5, APT_Spell)
RegisterPlayerEvent(42, APT_ReloadEvents)
RegisterServerEvent(33, APTStartUp)