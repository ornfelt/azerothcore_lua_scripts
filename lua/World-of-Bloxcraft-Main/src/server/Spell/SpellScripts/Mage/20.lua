local FireBlast = {}
FireBlast.__index = FireBlast

function FireBlast.new(spell)
	local new_toss = {}
	setmetatable(new_toss, FireBlast)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function FireBlast:OnCast()
	return
end

function FireBlast:OnHit()
	--self.caster:CastSpell(35, self.target);
end

function FireBlast:Modify()
	--self.caster:SetGCDMod(1);
	--self.spell:SetGCDMod(1);
end

return FireBlast
