local Trigger = {}
Trigger.__index = Trigger

function Trigger.new(caster, handle)
	local new_trigger = {}
	setmetatable(new_trigger, Trigger)
	
	new_trigger.caster = caster
	new_trigger.handle = handle
	
	return new_trigger
end

function Trigger:OnUnitEnter(unit)
	if not unit:HasAura(62) then
		self.caster:CastSpell(62, unit)
	end
end

function Trigger:OnUnitLeave(unit)
	if unit:HasAura(62) then
		unit:RemoveAura(62);
	end
end

function Trigger:IsRemoved(currentUnits)
	--if self.handle.GetUnitsInsideCount() > 0 then
	for _, unit in next, currentUnits do
		if unit:HasAura(62) then
			unit:RemoveAura(62);
		end
	end
	--end
end

return Trigger
