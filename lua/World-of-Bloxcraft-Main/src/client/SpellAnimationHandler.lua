local SAH = {}
SAH.__index = SAH

function SAH.new(caster, target, spell, pos, UI)
	local new_visual = {}
	setmetatable(new_visual, SAH)
	
	new_visual.spell = spell
	new_visual.caster = caster;
	new_visual.target = target;
	new_visual.timeLeft = 1;
	new_visual.pos = pos
	new_visual.UI = UI;
	new_visual.script = nil;
	
	return new_visual
end

function SAH:Cast()
	local spellVisual = self.spell:findFirstChild("SpellAnimation"):Clone()
	spellVisual.Parent = game.Players.LocalPlayer.Backpack
	if spellVisual:findFirstChild("Caster")then
		spellVisual.Caster.Value = self.caster
		if spellVisual:findFirstChild("Target") then
			spellVisual.Target.Value = self.target
		end
	else
		-- Spell has no inherent target or is AoE, check for location information
		if spellVisual:findFirstChild("Position") then
			local position = spellVisual:findFirstChild("Position")
			position.Value = self.pos + Vector3.new(0, -1, 0)
		end
	end
	spellVisual.Enabled = true;
	self.script = spellVisual;
end

function SAH:Cancel()
	if self.script ~= nil then
		if self.script:findFirstChild'Interrupted' ~= nil then
			self.script.Interrupted.Value = true;
			print(self.script.Interrupted.Value)
			print(self.script.Name);
		end
	end
end

return SAH
