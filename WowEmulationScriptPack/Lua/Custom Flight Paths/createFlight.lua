local isTrack = false
local newPath = {}
local trackNum = 1
local allPathIDs = {}
local allPathxy = {}
local mountA = 541 
local mountH = 541
local NpcID = 19057 --flight master ID

function string:split( inSplitPattern, outResults )
	if not outResults then
		outResults = { }
	end
	local theStart = 1
	local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	while theSplitStart do
		table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
		theStart = theSplitEnd + 1
		theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	end
	table.insert( outResults, string.sub( self, theStart ) )
	return outResults
end

local function LoadAllPaths()
	allPathxy = {}
	allPathIDs = {}
	local Q = WorldDBQuery("SELECT name, paths FROM FlightPaths LIMIT 1000")
	local all = 1
	if Q then
		repeat
			local name, path = Q:GetString(0), Q:GetString(1)
			local returnedSlash = path:split("/")
			local start = 1
			
			local allPaths = {}
			for i,v in pairs(returnedSlash) do
				local returnedComma = v:split("m")
				allPaths[start] = {returnedComma[1],returnedComma[2],returnedComma[3],returnedComma[4]}
				start = start +1
				
			end
			local returnedComma = returnedSlash[1]:split("m")
			allPathxy[all] = {returnedComma[2],returnedComma[3]}
			allPathIDs[all] = {name,AddTaxiPath(allPaths,mountA,mountH)}
			all = all +1
		until not Q:NextRow()
	end
end

local function startTracking(event, player, command)
local splitCommand = command:split(" ")
	if(splitCommand[1] == "starttrack") then	
		if(splitCommand[2] ~= nil) then
			newName = command:sub(12, #command)
		else
			newName = "Replace Me In DB"
		end
		isTrack = true
		newPath[trackNum] = {player:GetMapId(),player:GetX(),player:GetY(),player:GetZ()}
		trackNum = trackNum + 1
		return false
	end
end

local function eachPoint(event, player, command)
	if(command == "track" and isTrack) then
		newPath[trackNum] = {player:GetMapId(),player:GetX(),player:GetY(),player:GetZ()}
		trackNum = trackNum + 1
		return false
	end
end

local function endTracking(event, player, command)
	if(command == "stoptrack") then
		local conc = ""
		for i,v in pairs(newPath)do
			conc = conc .. v[1] .. "m" .. v[2].."m" .. v[3] .. "m" .. v[4] .. "/"
		end
		local conc = conc:sub(1, #conc - 1) --remove last slash
		WorldDBQuery("INSERT INTO FlightPaths (name,paths) VALUES ('" .. newName .. "','" .. conc .. "')")
		trackNum = 1
		newPath = {}
		return false
	end
end

local function flightOnGossip(event, player, object)
	LoadAllPaths()
	for i in pairs(allPathIDs) do
		if((math.abs(allPathxy[i][1] - player:GetX()) < 10) and (math.abs(allPathxy[i][2] - player:GetY()) < 10)) then
			player:GossipMenuAddItem(9, allPathIDs[i][1], 0, i)	
		end
	end
	player:GossipMenuAddItem(1, "Never Mind", 100, 0)
	player:GossipSendMenu(1, object)
end

local function flightOnSelect(event, player, object, sender, intid, code, menu_id)
	if(intid ~= 100) then
		player:StartTaxi(allPathIDs[intid][2])
	end
	player:GossipComplete()
end

RegisterPlayerEvent( 42, startTracking )
RegisterPlayerEvent( 42, eachPoint )
RegisterPlayerEvent( 42, endTracking )
RegisterCreatureGossipEvent(NpcID, 1, flightOnGossip)
RegisterCreatureGossipEvent(NpcID, 2, flightOnSelect)