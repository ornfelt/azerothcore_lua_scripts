local Map = {}
Map.__index = Map

local Unit = require(workspace.Unit);
local Database = require(workspace.DatabaseHandler)

function Map.new(world, mapId)
	local self = {}
	
	self.unitList = {};
	self.areaTriggerList = {};
	self.world = world;
	self.Active = true;
	self.m_mapId = mapId;
	self.m_auraKeyCounter = 0;
	
	setmetatable(self, Map);
	
	return self;
end

function Map:ToWorld()
	return self.world
end

function Map:SummonCreature(entryId, position, duration, summoner, spell)
	local new_npc = self:SpawnNPC(entryId, spell, summoner)
	
	local creature = new_npc:ToCreature();
	if creature == nil then return end;
	creature:UpdateData(duration, summoner, spell);
	
	new_npc.location:Teleport(position)
	new_npc.Active = true
	
	creature:Reset();
	
	return new_npc;
end

function Map:AddTrigger(trigger)
	table.insert(self.areaTriggerList, trigger);
end

function Map:AddUnit(unit)
	table.insert(self.unitList, unit);
end

function Map:GetUnitFromLink(link)
	for _,v in next,self.unitList do
		if v.link == link then
			return v;
		end
	end
	return nil;
end

function Map:GetUnitsInRange(position, distance)
	local list = {}
	for _,v in next, self.unitList do
		local charPos = v.m_HRP.Position
		local mag = (charPos - position).magnitude
		if mag <= distance then
			table.insert(list, v)
		end
	end
	return list
end

function Map:GetUnitsInRing(position, distance)
	local outterRadius = distance
	local innerRadius = distance - 10;
	local list = {}
	for _,v in next, self.unitList do
		local charPos = v.m_HRP.Position
		local mag = (charPos - position).magnitude
		if mag > innerRadius and mag < outterRadius then
			table.insert(list, v)
		end
	end
	return list
end

function Map:SpawnNPC(entryId, spell, summoner)
	local fol = Database.Access("world", "creature_template", tostring(entryId));
	if not fol then return end;
	local name = fol.NPCName.Value;
	local model;

	-- Clone
	if spell == 43 then
		summoner.link.Character.Archivable = true
		model = summoner.link.Character:Clone()
	else
		model = game.Lighting.NPCs:findFirstChild(tostring(entryId)):Clone();
		model.Name = name;
	end
	
	if spell == 57 then
		model.Parent = summoner.link.Character;
	else
		model.Parent = workspace;
	end
	
	local unit = self:BuildUnit(model, "Creature", name, entryId)
	unit.m_entryId = entryId;
	unit.summoner = summoner;
	
	return unit
end

function Map:BuildUnit(link, typ, name, entryId)
	local new_unit = Unit.new(link, typ, self, name, entryId);
	table.insert(self.unitList, new_unit);
	return new_unit
end

function Map:GetUnits()
	return self.unitList;
end

function Map:Update(m_time)
	for _,v in next,self.areaTriggerList do
		if v ~= nil then
			v:Update(m_time)
		end;
	end
	for _,v in next,self.unitList do
		if v ~= nil then
			if v.Active == true then
				v:Update(m_time);
			end
		end
	end
end

function Map:DespawnCreature()
	
end

return Map
