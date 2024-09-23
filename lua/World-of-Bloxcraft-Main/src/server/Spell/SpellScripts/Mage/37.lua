local Chain_Lightning = {}
Chain_Lightning.__index = Chain_Lightning

local SPELL_MAGE_SHOCK = 36

function Chain_Lightning.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Chain_Lightning)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Chain_Lightning:OnCast()
	local tarList = self.caster.location:GetNearestEnemyUnitsFromUnit(self.target, 40);
	for _,v in next,tarList do
		self.caster:CastSpell(SPELL_MAGE_SHOCK, v);
	end
end

function Chain_Lightning:OnHit()
	return
end

function Chain_Lightning:Modify()
	
end

return Chain_Lightning
