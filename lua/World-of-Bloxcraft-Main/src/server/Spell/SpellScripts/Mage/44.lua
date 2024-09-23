local Frostbolt = {}
Frostbolt.__index = Frostbolt

function Frostbolt.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Frostbolt)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Frostbolt:OnCast()
	return;
end

function Frostbolt:OnHit()
	-- Fingers of Frost
	local chance = 15;
	
	if math.random(100)<= chance then
		-- Give proc
		self.caster:CastSpell(60, self.caster);
		return;
	end
end

function Frostbolt:Modify()
	return;
end

return Frostbolt
