local smallfolk = smallfolk or require("smallfolk")

local debug = false

local SMH = {}
local datacache = {}
local delim = {"", "", "", "", ""}
local pck = {REQ = "", DAT = ""}

-- HELPERS START
local function debugOut(prefix, x, msg)
	if(debug == true) then
		print("["..os.clock().."][CSMH]["..x.."]["..prefix.."]: "..msg)
	end
end

local function GenerateReqId()
	local length = 6
	local reqId = ""

	for i = 1, length do
		reqId = reqId .. string.char(math.random(97, 122))
	end

	return reqId
end

local function ParseMessage(str)
	str = str or ""
	local output = {}
	local valTemp = {}
	local typeTemp = {}
	
	local valMatch = "[^"..table.concat(delim).."]+"
	local typeMatch = "["..table.concat(delim).."]+"
	
	-- Get values
	for value in str:gmatch(valMatch) do
		table.insert(valTemp, value)
	end
	
	-- Get type from delimiter
	for varType in str:gmatch(typeMatch) do
		for k, v in pairs(delim) do
			if(v == varType) then
				table.insert(typeTemp, k)
			end
		end
	end
	
	-- Convert value to correct type
	for k, v in pairs(valTemp) do
		local varType = typeTemp[k]
		if(varType == 2) then -- strings
			-- special case for empty string parsing
			if(v == string.char(tonumber('1A', 16))) then
				v = ""
			end
		elseif(varType == 3) then -- Ints
			v = tonumber(v)
		elseif(varType == 4) then -- Tables
			v = smallfolk.loads(v)
		elseif(varType == 5) then -- Booleans
			if(v == "true") then v = true else v = false end
		end
		table.insert(output, v)
	end
	
	valTemp = nil
	typeTemp = nil
	
	return output
end

local function ProcessVariables(sender, reqId, ...)
	local splitLength = 200
	local arg = {...}
	local msg = ""
	
	for _, v in pairs(arg) do
		if(type(v) == "string") then
			-- Special case for empty string parsing
			if(#v == 0) then
				v = string.char(tonumber('1A', 16))
			end
			msg = msg .. delim[2]
		elseif(type(v) == "number") then
			msg = msg .. delim[3]
		elseif(type(v) == "table") then
			-- use Smallfolk to convert table structure to string
			v = Smallfolk.dumps(v)
			msg = msg .. delim[4]
		elseif(type(v) == "boolean") then
			v = tostring(v)
			msg = msg .. delim[5]
		end
		msg = msg .. v
	end
	
	datacache[sender:GetGUIDLow()] = datacache[sender:GetGUIDLow()] or {}
	
	if not datacache[sender:GetGUIDLow()][reqId] then
		datacache[sender:GetGUIDLow()][reqId] = { count = 0, data = {}}
	end
	
	for i=1, msg:len(), splitLength do
		datacache[sender:GetGUIDLow()][reqId].count = datacache[sender:GetGUIDLow()][reqId].count + 1
		datacache[sender:GetGUIDLow()][reqId]["data"][datacache[sender:GetGUIDLow()][reqId].count] = msg:sub(i,i+splitLength - 1)
	end
	
	return datacache[sender:GetGUIDLow()][reqId]
end

-- HELPERS END

-- Rx START

function SMH.OnReceive(event, sender, _type, header, data, target)
	-- Make sure the sender and receiver of the addon message is set and is the correct type.
	-- Prevents error spam in the console
	if not sender or not target or not sender.GetName or not target.GetName or type(sender) ~= "userdata" or type(target) ~= "userdata" then
		return
	end
	
	-- Ensure the sender and receiver is the same, and the message type is WHISPER
	if sender:GetName() == target:GetName() and _type == 7 then
		-- unpack and validate addon message structure
		local pfx, source, pckId = header:match("(.)(%u)(.)")
		if not pfx or not source or not pckId then
			return
		end
		
		-- Make sure we're only processing addon messages using our framework prefix character as well as client messages
		if(pfx == delim[1] and source == "C") then
			if(pckId == pck.REQ) then
				debugOut("REQ", "Rx", "REQ received, data: "..data)
				SMH.OnREQ(sender, data)
			elseif(pckId == pck.DAT) then
				debugOut("DAT", "Rx", "DAT received, data: "..data)
				SMH.OnDAT(sender, data)
			else
				debugOut("ERR", "Rx", "Invalid packet type, aborting")
				return
			end
		end
	end
end

RegisterServerEvent(30, SMH.OnReceive)

function SMH.OnREQ(sender, data)
	debugOut("REQ", "Rx", "Processing data..")
	-- split header string into proper variables and ensure the string is the expected format
	local functionId, linkCount, reqId, addon = data:match("(%d%d)(%d%d%d)(%w%w%w%w%w%w)(.+)");
	if not functionId or not linkCount or not reqId or not addon then
		debugOut("REQ", "Rx", "Malformed data, aborting.")
		return
	end
	
	-- make sure the functionId and linkCount is converted to a number
	functionId, linkCount = tonumber(functionId), tonumber(linkCount);
	
	-- if the addon does not exist, abort
	if not SMH[addon] then
		debugOut("REQ", "Rx", "Invalid addon, aborting.")
		return
	end
	
	-- if the functionId does not exist for said addon, abort
	if not SMH[addon][functionId] then
		debugOut("REQ", "Rx", "Invalid addon function, aborting.")
		return
	end
	
	-- header is OK, create cache
	datacache[sender:GetGUIDLow()] = datacache[sender:GetGUIDLow()] or {}
	
	-- the request cache already exists, this should not happen. 
	-- abort and send error to the client, as well as purge id from cache.
	if(datacache[sender:GetGUIDLow()][reqId]) then
		datacache[sender:GetGUIDLow()][reqId] = nil
		debugOut("REQ", "Rx", "Cache already exists, aborting.")
		return
	end
	
	-- Insert header info for request id and prepare temporary data storage
	datacache[sender:GetGUIDLow()][reqId] = {addon = addon, funcId = functionId, count = linkCount, data = {}}
	
	debugOut("REQ", "Rx", "Header validated, cache created. Awaitng data..")
end


function SMH.OnDAT(sender, data)
	debugOut("DAT", "Rx", "Validating data..")
	-- Separate REQ ID from payload and verify
	local reqId = data:sub(1, 6)
	local payload = data:sub(#reqId+1)
	if not reqId then
		debugOut("DAT", "Rx", "Request ID missing, aborting.")
		return
	end
	
	-- If no REQ header info has been cached, abort
	if not datacache[sender:GetGUIDLow()][reqId] then
		debugOut("DAT", "Rx", "Cache does not exist, aborting.")
		return
	end
	
	local reqTable = datacache[sender:GetGUIDLow()][reqId]
	local sizeOfDataCache = #reqTable.data
	
	-- Some functions are trigger functions and expect no payload
	-- Skip the rest of the functionality and call the expected function
	if reqTable.count == 0 then
		debugOut("DAT", "Rx", "Function expects no data, triggering function..")
		
		-- Retrieve the function from global namespace and pass variables if it exists 
		local func = SMH[reqTable.addon][reqTable.funcId]
		if func then
			_G[func](sender, {})
			datacache[sender:GetGUIDLow()][reqId] = nil
			debugOut("DAT", "Rx", "Function "..func.." @ "..reqTable.addon.." executed, cache cleared.")
		end
		return
	end
	
	-- If the size of the cache is larger than expected, abort
	if sizeOfDataCache+1 > reqTable.count then
		debugOut("DAT", "Rx", "Received more data than expected. Aborting.")
		return
	end
	
	-- Add payload to cache and update size variable
	reqTable["data"][sizeOfDataCache+1] = payload
	sizeOfDataCache = #reqTable.data
	debugOut("DAT", "Rx", "Data part "..sizeOfDataCache.." of "..reqTable.count.." added to cache.")
	
	-- If the last expected message has been received, process it
	if(sizeOfDataCache == reqTable.count) then
		debugOut("DAT", "Rx", "All expected data received, processing..")
		-- Concatenate the cache and parse the full payload for function variables to return
		local fullPayload = table.concat(reqTable.data);
		local VarTable = ParseMessage(fullPayload)
		
		-- Retrieve the function from global namespace and pass variables if it exists 
		local func = SMH[reqTable.addon][reqTable.funcId]
		if func then
			_G[func](sender, VarTable)
			datacache[sender:GetGUIDLow()][reqId] = nil
			debugOut("DAT", "Rx", "Function "..func.." @ "..reqTable.addon.." executed, cache cleared.")
		end
	end
end

-- Rx END

-- Tx START

function SMH.SendREQ(sender, functionId, linkCount, reqId, addon)
	local header = string.format("%01s%01s%01s", delim[1], "S", pck.REQ)
	local data = string.format("%02d%03d%06s%0"..tostring(#addon).."s", functionId, linkCount, reqId, addon)
	sender:SendAddonMessage(header, data, 7, sender)
	debugOut("REQ", "Tx", "Sent REQ with ID "..reqId..", sending DAT..")
end

function SMH.SendDAT(sender, reqId)
	-- Build data message header
	local header = string.format("%01s%01s%01s", delim[1], "S", pck.DAT)
	
	-- iterate all items in the message data cache and send
	-- functions can also be trigger functions without any data, only send header and no payload
	if(#datacache[sender:GetGUIDLow()][reqId]["data"] == 0) then
		sender:SendAddonMessage(header, reqId, 7, sender)
	else
		for _, v in pairs (datacache[sender:GetGUIDLow()][reqId]["data"]) do
			local payload = reqId..v
			sender:SendAddonMessage(header, payload, 7, sender)
		end
	end
	
	-- all items have been sent, cache can be purged
	datacache[sender:GetGUIDLow()][reqId] = nil
	debugOut("DAT", "Tx", "Sent all DAT for ID "..reqId..", cache cleared, closing.")
end

-- Tx END

-- API START

function RegisterClientRequests(config)
	-- If a config table with the Prefix already exists, abort loading it into the register.
	if(SMH[config.Prefix]) then
		return;
	end
	
	-- Create subtable for PrefixName
	SMH[config.Prefix] = {}
	
	-- Insert function ID and function name into the register table.
	for functionId, functionName in pairs(config.Functions) do
		SMH[config.Prefix][functionId] = functionName
	end
end

function Player:SendServerResponse(prefix, functionId, ...)
	local reqId = GenerateReqId()
	local varTable = ProcessVariables(self, reqId, ...)
	SMH.SendREQ(self, functionId, varTable.count, reqId, prefix)
	SMH.SendDAT(self, reqId)
end

-- API END