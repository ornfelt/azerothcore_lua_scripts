local Phoenix = {}
Phoenix.__index = Phoenix

function Phoenix.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Phoenix)

	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell

	return new_toss
end

function Phoenix:OnCast()
	return
end

function Phoenix:OnHit()
	-- Get list of nearby enemies
	local list = self.caster.location:GetNearestEnemyUnitsFromUnit(self.target, 10);
	
	for _,target in next, list do
		
		-- Check one more time to make sure target is hostile
		if target:IsHostile(self.caster) == false then continue end;
		
		-- Cast explosion spell on target
		self.caster:CastSpell(52, self.target);
	end
	
end

function Phoenix:Modify()
	return
end

return Phoenix
