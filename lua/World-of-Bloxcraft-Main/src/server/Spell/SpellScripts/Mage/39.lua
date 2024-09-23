local Ice_Block = {}
Ice_Block.__index = Ice_Block

function Ice_Block.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Ice_Block)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Ice_Block:OnCast()
	return
end

function Ice_Block:OnHit()
	return
end

function Ice_Block:Modify()
	if self.caster:HasAura(39) then
		self.caster:RemoveAura(39);
	end
end

return Ice_Block
