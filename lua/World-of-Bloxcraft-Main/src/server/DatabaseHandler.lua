local Database = {}

local serverstorage = game.Workspace;

Database.Insert = function(section, data)
	if section and data then
		data.Parent = section;
	end	
end

Database.Access = function(section, tabl, row, ...)
	local db = serverstorage.Database;
	if section and tabl then
		local sect, tab, ro;
		local ext = {...};
		local goodies = {};
		for _,v in next,db:GetChildren() do
			if v.Name == section then
				sect = v
			end
		end
		if not sect then return nil end;
		for _,v in next,sect:GetChildren() do
			if v.Name == tabl then
				tab = v
			end
		end
		if row == nil then return tab end;
		if not tab then return nil end;
		for _,v in next,tab:GetChildren() do
			if v.Name == row then
				ro = v;
			end
		end
		if not ro then return nil end;
		if #ext>0 then
			for i = 1, #ext do
				for _,v in next,ro:GetChildren() do
					if v.Name == ext[i] then
						table.insert(goodies, v);
					end
				end
			end
		end
		if #goodies > 0 then
			return ro,goodies;
		else
			return ro;
		end
	end
end

return Database
