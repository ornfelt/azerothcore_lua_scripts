print "--- D.I.D.R.I.K - DIGITAL INTERCHANGEABLE GEOGRAPHICAL DEFERRED REAL-TIME INTUITIVE KARPUS (or gobtp for short) has been LOADED! ---"
-- Owner: Didrik
-- This script allows for: Creating teleports on click for gameobjects. The gameobjects are required to be clickable. 
-- It does this by applying a hook to every entryID of every gameobject that has a teleport, but in the script it checks for the specific gob (DB)GUID.
-- commands: 
-- .gobtp connect (GUID1) (GUID2) -optional (xOffset) (yOffset) (zOffset) - 2 required params, 3 optional
-- .gobtp manual (GUID1) (mapid) (x) (y) (z) (orientation) -- 6 params
-- .gobtp simple (GUID1) -- 1 param
-- .gobtp delete (GUID1) -- 1 param, deletes all links for that ID.


local Teleporter = {}
local ACCOUNT_LEVEL = 2 -- equal and above account levels can use this command.


--- Commands ---
local function TeleporterCommandHandler(event, player, command)
    if (player:GetGMRank() < ACCOUNT_LEVEL) then
        return
    elseif (command:find("gobtp") ~= 1) then
        return
    else
        local parameters = {}
        local parameters = getCommandParameters(command)
        -- .gobtp connect (GUID1) (GUID2) -optional (xOffset) (yOffset) (zOffset) - 2 required params, 3 optional
        if (parameters[2] == "connect" and isNumber(parameters[3]) and isNumber(parameters[4])) then  -- Make sure the two GUID parameters are ints.
            local guid = tonumber(parameters[3])
            local target = tonumber(parameters[4])
            local entry = GetGameObjectEntryID(guid)
            local targetCoords = GetGameObjectXYZ(target) -- Add coordinates of target GUID to variable targetCoords
            local xOffset = tonumber(parameters[5]) or 0
            local yOffset = tonumber(parameters[6]) or 0
            local zOffset = tonumber(parameters[7]) or 0
            if Teleporter.CheckIfGUIDHasLink(guid) then -- Checks if GUID1 has a link defined in the DB already.
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " tried to create a link for a GOB GUID that already exists: ".. guid)
                player:SendBroadcastMessage("A link for that GOB GUID already exists.")
                return false
            else
                player:SendBroadcastMessage("Creating connected link...")
                local query = "INSERT INTO eluna_teleporter (guid,target,entry,map,x,y,z,o) VALUES(".. guid ..", ".. target ..", " .. entry ..", ".. targetCoords["map"] ..", ".. tonumber(targetCoords["x"])+xOffset ..", " .. tonumber(targetCoords["y"])+yOffset ..", " .. tonumber(targetCoords["z"])+zOffset ..", " .. targetCoords["o"] .. ");"
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " is creating a connected link with query: " .. query)
                WorldDBQuery(query)
                ReloadGobTPEvents()
                player:SendBroadcastMessage("Successfully created a connected link for GOB GUID " .. guid .. "!")
                return false
            end
        -- .gobtp manual (GUID1) (mapid) (x) (y) (z) (orientation) -- 6 params
        elseif (parameters[2] == "manual" and isNumber(parameters[3]) and isNumber(parameters[4]) and isNumber(parameters[5]) and isNumber(parameters[6]) and isNumber(parameters[7]) and isNumber(parameters[8])) then -- Make sure the two GUID parameters are ints.
            local guid = tonumber(parameters[3])
            local entry = GetGameObjectEntryID(guid)
            local targetCoords = {
                map = tonumber(parameters[4]),
                x = tonumber(parameters[5]),
                y = tonumber(parameters[6]),
                z = tonumber(parameters[7]),
                o = tonumber(parameters[8]),
            };
            if Teleporter.CheckIfGUIDHasLink(guid) then
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " tried to create a link for a GOB GUID that already exists: ".. guid)
                player:SendBroadcastMessage("A link for that GOB GUID already exists.")
                return false
            else
                player:SendBroadcastMessage("Creating manual link...")
                local query = "INSERT INTO eluna_teleporter (guid,target,entry,map,x,y,z,o) VALUES(".. guid ..", ".."0" ..", ".. entry ..", ".. targetCoords["map"] ..", ".. targetCoords["x"] ..", " .. targetCoords["y"] ..", " .. targetCoords["z"] ..", " .. targetCoords["o"] .. ");"
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " is creating a manual link with query: " .. query)
                WorldDBQuery(query)
                ReloadGobTPEvents()
                player:SendBroadcastMessage("Succesfully created a manual link for GOB GUID " .. guid .. "!")
                return false
            end
        -- .gobtp simple (GUID1) -- 1 param - takes players current position and links it to GUID1.
        elseif (parameters[2] == "simple" and isNumber(parameters[3])) then -- Make sure the two GUID parameters are ints.
            local guid = tonumber(parameters[3])
            local entry = GetGameObjectEntryID(guid)
            local map = player:GetMap()
            local map = map:GetMapId()
            local x, y, z, o = player:GetLocation()

            if Teleporter.CheckIfGUIDHasLink(guid) then
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " tried to create a link for a GOB GUID that already exists: ".. guid)
                player:SendBroadcastMessage("A link for that GOB GUID already exists.")
                return false
            else
                player:SendBroadcastMessage("Creating simple link...")
                local query = "INSERT INTO eluna_teleporter (guid,target,entry,map,x,y,z,o) VALUES(".. guid ..", ".."0" ..", ".. entry ..", ".. map ..", ".. x ..", " .. y ..", " .. z ..", " .. o .. ");"
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " is creating a simple link with query: " .. query)
                WorldDBQuery(query)
                ReloadGobTPEvents()
                player:SendBroadcastMessage("Succesfully created a simple link for GOB GUID " .. guid .. "!")
                return false
            end
        elseif (parameters[2] == "delete" and isNumber(parameters[3])) then
            local guid = tonumber(parameters[3])
            if not Teleporter.CheckIfGUIDHasLink(guid) then
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " tried to delete a link for a GOB GUID that doesn't exist: ".. guid)
                player:SendBroadcastMessage("A link for that GOB GUID doesn't exist.")
                return false
            else
                player:SendBroadcastMessage("Deleting link...")
                local query = "DELETE FROM eluna_teleporter WHERE guid=" .. guid .. ";"
                PrintInfo("[D.I.D.R.I.K Teleporter]: " .. player:GetName() .. " is deleting a link with query: " .. query)
                WorldDBQuery(query)
                ReloadGobTPEvents()
                player:SendBroadcastMessage("Succesfully deleted a link for GOB GUID " .. guid .. "!")
                return false
            end
        else
            player:SendBroadcastMessage("You did something wrong when trying to create or delete a GOB link. Try again!")
            return false
        end
    end
end
--- END COMMANDS ---

--- GameObjectGossipEvent Handler ---
function Teleporter.OnClick(event, player, object)
    local t = Teleporter["Options"]
    local objectguid = object:GetDBTableGUIDLow()
    -- object:UseDoorOrButton() -- Opens the door or pushes the button, otherwise nothing happens since we overwrite the "default" behavior. It won't TP you to chairs though.
    for _, v in ipairs(Teleporter["GUIDs"]) do
        if v == objectguid then
            player:Teleport(t[objectguid]["map"], t[objectguid]["x"], t[objectguid]["y"], t[objectguid]["z"], t[objectguid]["o"])
            -- return true -- SEE BELOW
        end
    -- return false -- TEST THIS! Maybe we won't overwrite the behavior of "non" linked objects with this.
    end
end
--- END GameObjectGossipEvent Handler ---

--- SQL ---
function Teleporter.CheckIfGUIDHasLink(objguid)
    local guid = tonumber(objguid)
    local query = "SELECT COUNT(*) from eluna_teleporter WHERE guid = " .. guid
    local queryresult = WorldDBQuery(query)
    if (queryresult:GetUInt32(0) >= 1) then
        return true
    else
        return false
    end
end

function Teleporter.LoadEntryIDs()
    Teleporter["EntryIDs"] = {}
    local Query = WorldDBQuery("SELECT DISTINCT entry FROM eluna_teleporter;")
    if(Query) then
        repeat
            table.insert(Teleporter["EntryIDs"], Query:GetUInt32(0))
        until not Query:NextRow()
        PrintInfo("[D.I.D.R.I.K Teleporter]: Entry list initialized. Loaded "..Query:GetRowCount().." results.")
    else
        PrintInfo("[D.I.D.R.I.K Teleporter]: Entry list initialized. No results found.")
    end
end

function Teleporter.LoadGUIDs()
    Teleporter["GUIDs"] = {}
    local Query = WorldDBQuery("SELECT DISTINCT guid FROM eluna_teleporter;")
    if(Query) then
        repeat
            table.insert(Teleporter["GUIDs"], Query:GetUInt32(0))
        until not Query:NextRow()
        PrintInfo("[D.I.D.R.I.K Teleporter]: GUID list initialized. Loaded "..Query:GetRowCount().." results.")
    else
        PrintInfo("[D.I.D.R.I.K Teleporter]: GUID list initialized. No results found.")
    end
end

function Teleporter.LoadCache() -- Loads the entire eluna_teleporter table from the world DB and 'caches' the locations into an array called Teleporter.
    Teleporter["Options"] = {}

    if not(WorldDBQuery("SHOW TABLES LIKE 'eluna_teleporter';")) then -- Create table if it doesn't exist. Doesn't work, I think?
        PrintInfo("[D.I.D.R.I.K Teleporter]: eluna_teleporter table missing from world database.")
        PrintInfo("[D.I.D.R.I.K Teleporter]: Inserting table structure, initializing cache.")
        WorldDBQuery("CREATE TABLE `eluna_teleporter` (`guid` int(8) NOT NULL,`target` int(8) NOT NULL,`entry` int(8) NOT NULL,`map` int(8) DEFAULT NULL,`x` decimal(10,3) DEFAULT NULL,`y` decimal(10,3) DEFAULT NULL,`z` decimal(10,3) DEFAULT NULL,`o` decimal(10,3) DEFAULT NULL,`offsetx` decimal(10,3) DEFAULT NULL,`offsety` decimal(10,3) DEFAULT NULL,`offsetz` decimal(10,3) DEFAULT NULL,PRIMARY KEY (`guid`) ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;")
        return Teleporter.LoadCache();
    end
    
    local Query = WorldDBQuery("SELECT * FROM eluna_teleporter;")
    if(Query) then
        repeat
            Teleporter["Options"][Query:GetUInt32(0)] = {
                target = Query:GetUInt32(1),
                entry = Query:GetUInt32(2),
                map = Query:GetUInt32(3),
                x = Query:GetFloat(4),
                y = Query:GetFloat(5),
                z = Query:GetFloat(6),
                o = Query:GetFloat(7),
                offsetx = Query:GetFloat(8),
                offsety = Query:GetFloat(9),
                offsetz = Query:GetFloat(10),
            };
        until not Query:NextRow()
        PrintInfo("[D.I.D.R.I.K Teleporter]: Cache initialized. Loaded "..Query:GetRowCount().." results.")
    else
        PrintInfo("[D.I.D.R.I.K Teleporter]: Cache initialized. No results found.")
    end
end
--- END SQL ---

--- Reloader ---
function ReloadGobTPEvents()
    Teleporter.LoadGUIDs()
    Teleporter.LoadEntryIDs()
    Teleporter.LoadCache()
    --
    for i, entry in ipairs(Teleporter["EntryIDs"]) do ClearGameObjectGossipEvents(entry, 1) end -- Clear all events.
    --
    for i, entry in ipairs(Teleporter["EntryIDs"]) do RegisterGameObjectGossipEvent(entry, 1, Teleporter.OnClick) end -- Re-create all the events.
    --
end
--- END Reloader ---

--- Cleanup ---
function CleanupGobTP(eventId, delay, repeats)
    local Query = "DELETE FROM eluna_teleporter WHERE guid IN (SELECT eluna_teleporter.guid FROM eluna_teleporter LEFT JOIN gameobject ON eluna_teleporter.guid = gameobject.guid WHERE gameobject.guid IS NULL);"
    --- ^ Deletes any teleport rows where the guid (of the object you click) doesn't exist in the gameobject table anymore.
    WorldDBExecute(Query)
    PrintInfo("[D.I.D.R.I.K Teleporter]: Ran cleanup.")
end
--- END Cleanup ---

CreateLuaEvent(CleanupGobTP, 1800000, 0) -- we'll run cleanup every 30 minutes.
CleanupGobTP()
RegisterPlayerEvent(42, TeleporterCommandHandler)
ReloadGobTPEvents()
