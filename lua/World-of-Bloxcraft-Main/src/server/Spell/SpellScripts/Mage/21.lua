local HeatingUp = {}
HeatingUp.__index = HeatingUp

function HeatingUp.new(spell)
	local new_toss = {}
	setmetatable(new_toss, HeatingUp)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function HeatingUp:OnCast()
	return
end

function HeatingUp:OnHit()
	--self.caster:CastSpell(35, self.target);
end

function HeatingUp:Modify()
	self.spell:DisablePlayerAnimation();
end

return HeatingUp
