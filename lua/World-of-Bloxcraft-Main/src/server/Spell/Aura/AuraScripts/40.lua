local Invisibility = {}
Invisibility.__index = Invisibility

function Invisibility.new(aura)
	local new_toss = {}
	setmetatable(new_toss, Invisibility)
	
	new_toss.spell = aura
	new_toss.caster = aura.caster
	new_toss.target = aura.target
	new_toss.spell = aura.spell
	new_toss.spellObj = aura.spell.spell;
	
	return new_toss
end

function Invisibility:OnApply()
	return
end

function Invisibility:AfterRemove()
	self.caster:CastSpell(41, self.caster);
end

function Invisibility:Modify()
	return
end

return Invisibility
