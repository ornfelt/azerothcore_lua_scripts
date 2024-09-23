local Fireball = {}
Fireball.__index = Fireball

function Fireball.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Fireball)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function Fireball:OnCast()
	return
end

function Fireball:OnHit()
	self.caster:CastSpell(35, self.target, nil, false);
end

function Fireball:Modify()
	return
end

return Fireball
