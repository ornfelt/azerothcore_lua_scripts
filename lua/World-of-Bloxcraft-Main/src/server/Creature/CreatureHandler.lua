local CreatureHandler = {}
CreatureHandler.__index = CreatureHandler

local Database = require(workspace.DatabaseHandler);

function CreatureHandler.new(link, unitLink, entryId)
	local new_creature = {}
	setmetatable(new_creature, CreatureHandler)
	
	new_creature.link = link
	new_creature.unitLink = unitLink;
	new_creature.owner = nil
	new_creature.spell = nil
	new_creature.duration = 10000;
	new_creature.m_script = nil;
	new_creature.m_entryId = entryId
	
	return new_creature;
end

function CreatureHandler:ToScript()
	return self.script;
end

function CreatureHandler:UpdateData(duration, summoner, spell)
	local fol = Database.Access("world", "creature_template", tostring(self.m_entryId));
	if fol then
		if fol.CreatureScript.Value ~= nil then
			local creature_script = require(fol.CreatureScript.Value)
			self.m_script = creature_script.new(self.unitLink, summoner)
		end
	end
	self.duration = duration
	self.summoner = summoner
	self.m_script.owner = summoner;
	self.spell = spell;
end

function CreatureHandler:Reset()
	self.m_script:Reset();
end

function CreatureHandler:Spawn()
	if self.link then
		local link = self.link
		if link.Parent == nil then
			link.Parent = workspace;
			self.unitLink.Active = true;
		end
	end
end

function CreatureHandler:Died()
	if self.m_script ~= nil then
		self.m_script:Died()
	end
end

function CreatureHandler:Fear(duration)
	-- TODO: Fear Handling for NPCs
	print("Made it!")
end

function CreatureHandler:Stun(duration)
	-- TODO: Stun Handling for NPCs
	print("Made it!")
end

function CreatureHandler:Silence(duration)
	-- TODO: Disorient Handling for NPCS
	print("Made it!")
end

function CreatureHandler:AddToWorld()
	self.unitLink.Active = true;
end

function CreatureHandler:RemoveFromWorld()
	self.unitLink.Active = false;
end

function CreatureHandler:Despawn()
	self.link:Destroy();
	self.m_script:Died();
	self.unitLink.Active = false;
end

function CreatureHandler:Update(m_time)
	if self.m_script ~= nil then
		self.m_script:Update(m_time);
	end
	
	if self.duration > 0 then
		if self.duration > 9999 then
			return;
		end
		self.duration = self.duration - m_time
	else
		self.duration = 0;
		self:Despawn();
	end
end

return CreatureHandler
