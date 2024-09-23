local Meteor = {}
Meteor.__index = Meteor

function Meteor.new(spell)
	local new_toss = {}
	setmetatable(new_toss, Meteor)
	
	new_toss.spell = spell
	new_toss.caster = spell.caster
	new_toss.target = spell.target
	new_toss.spellObj = spell.spell
	
	return new_toss
end

function Meteor:OnCast()
	return
end

function Meteor:OnHit()
	return
end

function Meteor:Modify()
	return
end

return Meteor
