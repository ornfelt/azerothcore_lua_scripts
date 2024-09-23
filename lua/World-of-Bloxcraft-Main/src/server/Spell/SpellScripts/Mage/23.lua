local PyroBlast = {}
PyroBlast.__index = PyroBlast

function PyroBlast.new(spell)
	local new_toss = {}
	setmetatable(new_toss, PyroBlast)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function PyroBlast:OnCast()
	return
end

function PyroBlast:OnHit()
	if self.caster:HasAura(22) then
		self.caster:RemoveAura(22);
	end
end

function PyroBlast:Modify()
	if self.caster:HasAura(22) then
		self.spell:SetCastTime(0);
	end
end

return PyroBlast
