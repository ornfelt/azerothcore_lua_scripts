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
	
	local caster = self.caster
	
	if caster:IsHostile(unit) == false then
		return;
	end
	
	if not unit:HasAura(49) then
		self.caster:CastSpell(49, unit);
	end
end

function Trigger:OnUnitLeave(unit)
	return;
end

function Trigger:IsRemoved(currentUnits)
	return;
end

return Trigger
