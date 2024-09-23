local Lance = {}
Lance.__index = Lance

function Lance.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Lance)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Lance:OnCast()
	if self.caster:HasAura(60) then
		-- Fingers of Frost
		self.caster:RemoveAura(60);
		
		-- Fingers of Frost tooltip:
		-- Causes your Ice Lance to deal damage as if the target was frozen
		self.spell:MultiplyDamage(3);
		self.spell:SetCritChance(100);
	end
end

function Lance:OnHit()
	if self.target:IsFrozen() then
		self.spell:MultiplyDamage(3);
		
		-- Thermal Void
		
		if self.caster:HasAura(66) then -- Icy Veins
			-- Increase duration by 1 second;
			self.caster:GetAura(66):IncreaseDuration(1);
		end
	end
	
end

function Lance:Modify()
	return;
end

return Lance
