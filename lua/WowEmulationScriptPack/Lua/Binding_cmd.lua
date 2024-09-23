local enabled = true

local GMonly = false  -- only opens for GM

local BINDSQL = [[ CREATE TABLE IF NOT EXISTS world.skuly_teleport ( `CharID` int(10) unsigned, `mappId` int(10) unsigned, `xCoord` varchar(12), `yCoord` varchar(12), `zCoord` varchar(12), `orientation` varchar(12), `CharName` varchar(12), `BindName` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL);]]
WorldDBExecute(BINDSQL)

local function SKULYBIND(eventid, delay, repeats, player)
local mingmrank = 3
local IsGM = (player:GetGMRank() >= mingmrank)

if not GMonly or IsGM then
    player:SendBroadcastMessage("|cff3399FF You can type|cff00cc00 .bind name|cff3399FF in chat to save your current location and set a name for it.")
	player:SendBroadcastMessage("|cff3399FF You can type|cff00cc00 .return name|cff3399FF in chat to sreturn to that location at anytime.")
	player:SendBroadcastMessage("|cff3399FF You can type|cff00cc00 .clearbind name |cff3399FF or|cff00cc00 .clearbind all|cff3399FF in chat to clear locations.")
	end
end

local firstlogin = false

local function OnFirstLogin(event, player)
	if event == 30 then
	firstlogin = true
	end
	
	player:RegisterEvent(SKULYBIND, 60000, 1, player)
end

local function OnLogin(event, player)
	if not firstlogin then
	player:RegisterEvent(SKULYBIND, 20000, 1, player)
	else
	firstlogin = false
	end
end

local function getPlayerCharacterGUID(player)
    local query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
  
local function PlrMenu(event, player, message, Type, lang)
	local map = player:GetMap()
	
	local commandbind = "^bind.*"
	local commandgoto = "^return.*"
	local commandclear = "^clearbind."
	local text = message:lower()
	

	local mingmrank = 3
	local IsGM = (player:GetGMRank() >= mingmrank)
	local NotGM = (player:GetGMRank() < mingmrank)
	
	
		
	
	if text:find(commandbind) ~= nil then
		
		if NotGM then
		player:SendBroadcastMessage("|cff5af304Only a GM can use this command.|r")
		return false
		else
		

		local xstring = string.sub(tostring(player:GetX()),1,10)
		local ystring = string.sub(tostring(player:GetY()),1,10)
		local zstring = string.sub(tostring(player:GetZ()),1,10)
		local ostring = string.sub(tostring(player:GetO()),1,10)
		
		local getbind = string.sub(text,6,65)
		local extractedname = tostring(getbind:gsub("%s+%d+", ""))

		local query = WorldDBQuery(string.format("SELECT * FROM world.skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		
		
		if not query then
		WorldDBExecute(string.format("INSERT INTO world.skuly_teleport (CharName, BindName, CharID, mappId, xCoord, yCoord, zCoord, orientation) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')", player:GetName(), extractedname, getPlayerCharacterGUID(player), tostring(map:GetMapId()), xstring, ystring, zstring, ostring))
		
		
		player:SendBroadcastMessage("|cff5af304Location saved as |cff3399FF"..extractedname.."|cff5af304 (type .return |cff3399FF"..extractedname.."|cff5af304 to return to this location at any time)|r")
		else
		local query2 = WorldDBQuery(string.format("SELECT BindName FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		if query2 then
		local mapID = WorldDBQuery(string.format("SELECT mappId FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		local x = WorldDBQuery(string.format("SELECT xCoord FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		local y = WorldDBQuery(string.format("SELECT yCoord FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		local z = WorldDBQuery(string.format("SELECT zCoord FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		local O = WorldDBQuery(string.format("SELECT orientation FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedname, getPlayerCharacterGUID(player)))
		player:SendBroadcastMessage("|cff5af304 Bind location |cff3399FF"..extractedname.."|cff5af304 already exists (|cff3399FFMap|cff5af304:"..mapID:GetString(0).."|cff3399FF X|cff5af304:"..x:GetString(0).."|cff3399FF Y|cff5af304:"..y:GetString(0).."|cff3399FF Z|cff5af304:"..z:GetString(0).."|cff3399FF O|cff5af304:"..O:GetString(0)..")|r")
		player:SendBroadcastMessage("|cff5af304 Type|cff3399FF .clearbind "..extractedname.." |cff5af304if you would like to remove the bind location.|r")
		end
		
		end
		return false
	end
	end
	
	
	if text:find(commandgoto) ~= nil then
		local getgo = string.sub(text,8,65)
		local extractedgo = tostring(getgo:gsub("%s+%d+", ""))
		if NotGM then
		player:SendBroadcastMessage("|cff5af304Only a GM can use this command.|r")
		return false
		else

		local query3 = WorldDBQuery(string.format("SELECT BindName FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedgo, getPlayerCharacterGUID(player)))
		if query3 then
		local mapID = WorldDBQuery(string.format("SELECT mappId FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedgo, getPlayerCharacterGUID(player)))
		local x = WorldDBQuery(string.format("SELECT xCoord FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedgo, getPlayerCharacterGUID(player)))
		local y = WorldDBQuery(string.format("SELECT yCoord FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedgo, getPlayerCharacterGUID(player)))
		local z = WorldDBQuery(string.format("SELECT zCoord FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedgo, getPlayerCharacterGUID(player)))
		local o = WorldDBQuery(string.format("SELECT orientation FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedgo, getPlayerCharacterGUID(player)))
		
		player:Teleport( mapID:GetInt32(0), x:GetInt32(0), y:GetInt32(0), z:GetInt32(0)+0.75, o:GetInt32(0) )
		end
		return false
	end
	end
	
	
	if text:find(commandclear) ~= nil then
		local getclear = string.sub(text,11,65)
		local extractedclear = tostring(getclear:gsub("%s+%d+", ""))
		local query4 = WorldDBQuery(string.format("SELECT BindName FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedclear, getPlayerCharacterGUID(player)))
		if NotGM then
		player:SendBroadcastMessage("|cff5af304Only a GM can use this command.|r")
		return false
		else
		
		if extractedclear == "all" then
		WorldDBQuery(string.format("DELETE FROM skuly_teleport WHERE CharName='%s' AND CharID='%i'", player:GetName(), getPlayerCharacterGUID(player)))
		player:SendBroadcastMessage("|cff5af304ALL bind locations cleared.|r")
		else
		if query4 then
		WorldDBQuery(string.format("DELETE FROM skuly_teleport WHERE CharName='%s' AND BindName='%s' AND CharID='%i'", player:GetName(), extractedclear, getPlayerCharacterGUID(player)))
		player:SendBroadcastMessage("|cff5af304Bind location |cff3399FF"..extractedclear.."|cff5af304 was cleared.|r")
		else
		player:SendBroadcastMessage("|cff5af304Bind location |cff3399FF"..extractedclear.."|cff5af304 does NOT exist.|r")
		end
		end
		
		return false
	end
	end
	
	
	
	
	
	
end

if enabled then
RegisterPlayerEvent(30, OnFirstLogin)
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(42, PlrMenu)
end