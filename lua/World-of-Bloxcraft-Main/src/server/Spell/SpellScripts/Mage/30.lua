local AlterTime = {}
AlterTime.__index = AlterTime

function AlterTime.new(spell)
	local new_toss = {}
	setmetatable(new_toss, AlterTime)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function AlterTime:OnCast()
	if self.caster:HasAura(29) then
		self.caster:RemoveAura(29);
	end
end

function AlterTime:OnHit()
	return
end

function AlterTime:Modify()
	return
end

return AlterTime
