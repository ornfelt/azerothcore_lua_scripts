local DH = {}
DH.__index = DH

local Database = require(workspace.DatabaseHandler);
local DSS = game:GetService("DataStoreService")

function DH.new(player, dataStore)
	local new_data = {}
	setmetatable(new_data, DH)
	
	new_data.Player = player;
	new_data.Key = player.UserId.."-"..dataStore;
	new_data.Value = {};
	new_data.DataStore = DSS:GetDataStore(dataStore);
	new_data.DataStoreString = dataStore;
	
	return new_data;
	
end

function DH:Save()
	local data = {}
	if self.DataStoreString == "Characters" then
		local folder = Database.Access("characters", "character", nil);
		for _,v in next,folder:GetChildren() do
			if v.Name == self.player.Name then
				for _,v in next, v:GetChildren() do
					table.insert(data, v.Name);
				end
			end
		end
	end
	local newJson
end


return DH
