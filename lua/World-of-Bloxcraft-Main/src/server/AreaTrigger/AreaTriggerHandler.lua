local AreaTrigger = {}
AreaTrigger.__index = AreaTrigger

local TO = game.Lighting.AreaTriggers

function AreaTrigger.new(caster, spell, distance, duration)
	local new_trig = {}
	setmetatable(new_trig, AreaTrigger)
	
	new_trig.caster = spell.caster
	new_trig.position = spell.pos
	new_trig.dist = distance
	new_trig.spellId = spell
	new_trig.MaxDuration = duration
	new_trig.active = false
	new_trig.gobj = spell.m_atInfo.Gobject:Clone()
	new_trig.unitsInside = {}
	new_trig.timeLeft = duration
	
	--AreaTrigger custom script
	local Areascript = script.Scripts:findFirstChild(tostring(spell.spellId))
	if Areascript then
		local as = require(Areascript)
		new_trig.script = as.new(new_trig.caster, new_trig)
	end
	
	return new_trig;
end

function AreaTrigger:AddUnit(unit)
	table.insert(self.unitsInside, unit)
end

function AreaTrigger:AddToWorld()
	self.gobj.Parent = workspace
	if self.gobj:findFirstChild'Base' ~= nil then
		self.gobj.Base.Position = self.position + Vector3.new(0, -2, 0);
	else
		self.gobj:MoveTo(self.position);
	end
	
	self.active = true
	self.caster:ToMap():AddTrigger(self);
end

function AreaTrigger:OnUnitEnter(unit)
	self.script:OnUnitEnter(unit)
end

function AreaTrigger:OnUnitLeave(unit)
	self.script:OnUnitLeave(unit)
end

function AreaTrigger:GetCaster()
	return self.caster
end

function AreaTrigger:IsWithinInnerRange(unit)
	if unit.location:IsWithinInnerRange(self.position, self.dist) then
		return true
	else
		return false;
	end
end

function AreaTrigger:IsWithinRange(unit)
	if unit.location:IsWithinRange(self.position, self.dist) then
		return true
	else
		return false;
	end
end

function AreaTrigger:Update(m_time)
	-- We start by updating the list of units within the range of the Location we have
	if self.active == true then
		local previousUnits = self.unitsInside -- Store the previous state of unitsInside
		self.unitsInside = {} -- Clear unitsInside table
		local currentUnits;
		local ring = false;
		local spell = self.spellId;
		-- Specific spell check (TODO: Create cleaner function)
		if self.spellId.spellId == 48 then -- Ring of Frost
			currentUnits = self.caster:ToMap():GetUnitsInRing(self.position, self.dist);
			ring = true;
		else
			currentUnits = self.caster:ToMap():GetUnitsInRange(self.position, self.dist);
		end
		
		for _, v in next, currentUnits do
			self.unitsInside[v] = true
		end

		self.timeLeft = self.timeLeft - m_time
		if self.timeLeft < 0 then
			self.active = false
			self:Remove(currentUnits)
			return;
		end

		for _, unit in next, currentUnits do
			if not previousUnits[unit] and unit:IsAlive() then -- Check if the unit was not already inside
				self:OnUnitEnter(unit)
			end
		end

		for unit, _ in next, previousUnits do
			if ring then
				if unit.location:IsWithinInnerRange(self.position, self.dist - 10) then
					self:OnUnitLeave(unit)
				elseif not unit.location:IsWithinRange(self.position, self.dist) then
					self:OnUnitLeave(unit)
				elseif unit:IsAlive() == false then
					self:OnUnitLeave(unit);
				end
			end
		end

	else
		return
	end
end

function AreaTrigger:GetUnitsInsideCount()
	local count = 0
	for _, _ in next, self.unitsInside do
		count = count + 1
	end
	return count
end

function AreaTrigger:Remove(currentUnits)
	self.active = false
	self.gobj:Destroy();
	self:IsRemoved(currentUnits);
end

function AreaTrigger:IsRemoved(currentUnits)
	self.script:IsRemoved(currentUnits);
end

function AreaTrigger:GetSpellId()
	return self.spellId
end

return AreaTrigger
