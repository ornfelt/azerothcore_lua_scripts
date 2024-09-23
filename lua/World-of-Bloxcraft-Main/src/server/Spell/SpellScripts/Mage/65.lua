local ColdSnap = {}
ColdSnap.__index = ColdSnap

function ColdSnap.new(spell)
	local new_toss = {}
	setmetatable(new_toss, ColdSnap)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function ColdSnap:OnCast()
	local SPELL_MAGE_ICE_BLOCK = 39;
	local SPELL_MAGE_ICE_BARRIER = 42;
	local SPELL_MAGE_FROST_NOVA = 25;
	local SPELL_MAGE_CONE_OF_COLD = 33;
	
	self.caster:ResetCooldown(SPELL_MAGE_ICE_BLOCK);
	self.caster:ResetCooldown(SPELL_MAGE_ICE_BARRIER);
	self.caster:ResetCooldown(SPELL_MAGE_FROST_NOVA);
	self.caster:ResetCooldown(SPELL_MAGE_CONE_OF_COLD);
	
	return;
end

function ColdSnap:OnHit()
	return;
end

function ColdSnap:Modify()
	return;
end

return ColdSnap
