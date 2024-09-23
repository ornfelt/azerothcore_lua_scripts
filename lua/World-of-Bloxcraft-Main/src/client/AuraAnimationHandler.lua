local AAH = {}
AAH.__index = AAH

function AAH.new(caster, target, spell, duration, UI)
	local new_visual = {}
	setmetatable(new_visual, AAH)
	
	new_visual.aura = spell
	new_visual.caster = caster;
	new_visual.target = target;
	new_visual.UI = UI;
	new_visual.m_duration = duration
	new_visual.auraVisual = new_visual.aura:findFirstChild("AuraAnimation"):Clone();
	return new_visual
end

function AAH:Cast()
	local auraVisual = self.auraVisual
	auraVisual.Parent = game.Players.LocalPlayer.Backpack
	if auraVisual:findFirstChild("Target") then
		auraVisual.Target.Value = self.target
	end
	auraVisual.Enabled = true;
end

function AAH:Update(m_time)
	if self.m_duration > 0.01 then
		if self.m_duration >= 10000 then
			return;
		else
			self.m_duration = self.m_duration - m_time;
			local aura = self.auraVisual;
			aura.Duration.Value = self.auraVisual.Duration.Value - m_time;
		end
	else
		self.m_duration = 0;
		self.auraVisual.Duration.Value = 0;
	end
end

return AAH
