local orb_spike = {}
orb_spike.__index = orb_spike

function orb_spike.new(spell)
	local new_toss = {}
	setmetatable(new_toss, orb_spike)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function orb_spike:OnCast()
	return;
end

function orb_spike:OnHit()
	-- Fingers of Frost
	local chance = 10;
	
	if math.random(100) <= chance then
		-- Give proc
		self.caster:CastSpell(60, self.caster);
		return;
	end
end

function orb_spike:Modify()
	return;
end

return orb_spike
