local Kick = {}
Kick.__index = Kick

function Kick.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Kick)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	new_toss.Proc = new_toss.spellObj.Procs:findFirstChild("PROC_SPELL_TYPE_DOT");
	
	if new_toss.Proc then
		new_toss.ProcChance = new_toss.Proc.Value
	end
	
	
	return new_toss
end

function Kick:OnCast()
	return
end

function Kick:OnHit()
	local x = math.random(1,100)
	if x <= self.ProcChance then
		self.caster:CastSpell(35, self.target);
	end
end

function Kick:Modify()
	return
end

return Kick
