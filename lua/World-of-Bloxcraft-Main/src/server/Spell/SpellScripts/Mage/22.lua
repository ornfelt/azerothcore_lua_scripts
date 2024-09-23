local HotStreak = {}
HotStreak.__index = HotStreak

function HotStreak.new(spell)
	local new_toss = {}
	setmetatable(new_toss, HotStreak)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function HotStreak:OnCast()
	return
end

function HotStreak:OnHit()
	--self.caster:CastSpell(35, self.target);
end

function HotStreak:Modify()
	self.spell:DisablePlayerAnimation();
end

return HotStreak
