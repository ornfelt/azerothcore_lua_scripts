local Burn = {}
Burn.__index = Burn

function Burn.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Burn)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function Burn:OnCast()
	return
end

function Burn:OnHit()
	return
end

function Burn:Modify()
	self.spell:DisablePlayerAnimation();
end

return Burn
