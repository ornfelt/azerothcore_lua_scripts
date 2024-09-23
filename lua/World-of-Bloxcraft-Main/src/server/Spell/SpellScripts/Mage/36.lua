local Shock = {}

Shock.__index = Shock

function Shock.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Shock)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Shock:OnCast()
	return
end

function Shock:OnHit()
	return
end

function Shock:Modify()
	self.spell:DisablePlayerAnimation();
end

return Shock
