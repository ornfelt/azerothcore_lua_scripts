local Scorch = {}
Scorch.__index = Scorch

function Scorch.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Scorch)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Scorch:OnCast()
	return
end

function Scorch:OnHit()
	return
end

function Scorch:Modify()
	if self.target:GetHealth() < (self.target:GetMaxHealth() * 0.25) --[[Less than 25% health]] then
		self.spell:SetCritChance(100);
	end
end

return Scorch
