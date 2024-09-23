local Flurry = {}
Flurry.__index = Flurry

function Flurry.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Flurry)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Flurry:OnCast()
	local caster = self.caster
	if caster then
		caster:CastSpell(55, self.target);
		
		caster:AddDelayedEvent(0.3, function()
			local target = self.target;
			if not target then return end;
			
			caster:CastSpell(55, target);
		end)
		
		caster:AddDelayedEvent(0.6, function()
			local target = self.target;
			if not target then return end;

			caster:CastSpell(55, target);
		end)
	end
end

function Flurry:OnHit()
	return
end

function Flurry:Modify()
	return
end

return Flurry
