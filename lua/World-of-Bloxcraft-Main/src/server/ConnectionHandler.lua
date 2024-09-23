local Connection = {}
Connection.__index = Connection

local Database = require(workspace.DatabaseHandler);
local Opcodes = require(workspace.Opcodes)
local DSS = game:GetService("DataStoreService")

--[[
	Here lies the ConnectionHandler
	When a player joins the game, 
	this object is created to represent 
	the connection between the client and 
	the server. 
	
]]

function Connection.new(player, world)
	local new_connection = {}
	setmetatable(new_connection, Connection)
	
	new_connection.player = player
	new_connection.characterList = {}
	new_connection.loggedInChar = nil
	new_connection.world = world
	new_connection.charUnitList = {}
	
	return new_connection
end

function Connection:SetCharList(list)
	self.characterList = list;
end
function Connection:GetCharList()
	return self.charUnitList;
end
function Connection:SetLoggedInChar(char)
	self.loggedInChar = char;
	local data, packet = {},Opcodes.FindClientPacket("SMSG_JOIN_WORLD");
	data.CharacterName = char.Name;
	packet:FireClient(self.player, data);
end

function Connection:GetLoggedInChar()
	return self.loggedInChar;
end

function Connection:SaveData(dataStore, key, data)
	local DS = DSS:GetDataStore(dataStore);
	local savedData
	local success, err = pcall(function()
		savedData = DS:SetAsync(key, data)
	end)
	
	if not success then
		error(err);
	end
end

function Connection:LoadData(dataStore, key)
	local DS = DSS:GetDataStore(dataStore)
	local savedData
	local success, err = pcall(function()
		savedData = DS:GetAsync(key);
	end)
	
	if not success then return error(err) end;
	return savedData;
end

function Connection:ToWorld()
	return self.world
end

function Connection:DisplayCharacters()
	local data, packet = {},Opcodes.FindClientPacket("SMSG_CHAR_LIST");
	data.List = self.characterList;
	packet:FireClient(self.player, data);
end

function Connection:Disconnect()
	local fol = Database.Access("characters", "character", nil);
	if fol:findFirstChild(self.player.Name) then
		fol[self.player.Name]:Destroy();
	end
end

function Connection:GetCharacters()
	local chars = {}
	local folder = Database.Access("characters", "character", nil);
	for _,v in next,folder:GetChildren() do
		if v.Name == self.player.Name then
			for _,v in next, v:GetChildren() do
				for i,g in next,self:ToWorld().UnitList do
					if g.Name == v.Name then
						table.insert(chars, g);
					end
				end
			end
		end
	end
	return chars;
end

return Connection
