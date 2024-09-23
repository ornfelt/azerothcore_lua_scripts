local AlterTime = {}
AlterTime.__index = AlterTime

function AlterTime.new(aura)
	local new_toss = {}
	setmetatable(new_toss, AlterTime)
	
	new_toss.spell = aura
	new_toss.caster = aura.caster
	new_toss.target = aura.target
	new_toss.spell = aura.spell
	new_toss.spellObj = aura.spell.spell;
	
	-- Custom Vars
	new_toss._health = 0;
	new_toss._pos = nil;
	
	return new_toss
end

function AlterTime:OnApply()
	self._health = self.caster:GetHealth()
	self._pos = self.caster.m_HRP.Position;
end

function AlterTime:AfterRemove()
	local unit = self.caster;
	local _pos = self._pos
	local _health = self._health
	if unit.location:IsWithinRange(_pos, 100) then
		unit:SetHealth(_health);
		unit:NearTeleportTo(_pos);
	end
	
	self.caster:CancelOverride(29);
	self.caster:SpellCooldown(29);
	self.caster:CastSpell(30, self.caster);
end

function AlterTime:Modify()
	return
end

return AlterTime
