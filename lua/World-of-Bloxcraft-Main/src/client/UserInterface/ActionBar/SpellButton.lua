local SB = {}
SB.__index = SB

function SB.new(link, spellId, cooldown)
	local new_button = {}
	setmetatable(new_button, SB)
	
	new_button.link = link
	new_button.spellId = spellId
	new_button.spellLink = game.Lighting.Spells:findFirstChild(tostring(spellId));
	new_button.cooldownValue = cooldown;
	new_button.cooldownTime = new_button.link.CooldownValue;
	new_button.cdVisual = new_button.link.Progress.Percentage.ProgressScript;
	new_button.onGCD = false
	new_button.gcdVal = 1.5;
	new_button.cooldownProgress = 0
	new_button.gcdProgress = 0
	new_button.gcdvis = link.CooldownVisual
	new_button.onCD = link.CooldownBool;
	
	if link:findFirstChild("SpellCharges") then
		new_button.spellCharges = link.SpellCharges
	end
	
	return new_button
end

function SB:Lock()
	self.link.Interrupted.Disabled = false;
end

function SB:Update(deltaTime)
	
end

function SB:SetOnGCD(m_time)
	if self.cooldownValue > 0 then
		if self.onCD.Value == false then
			self.cooldownTime.Value = m_time;
			self.cdVisual.Disabled = false;
			self.onGCD = true;
			return true;
		end
	else
		self.link.Progress.Percentage.Value = 0;
		self.cooldownTime.Value = 0;
		self.cooldownTime.Value = m_time;
		self.cdVisual.Disabled = false;
		self.onGCD = true;
		return true;
	end
end

function SB:SetOnCD()
	self.cdVisual.Disabled = true;
	self.cooldownTime.Value = self.cooldownValue
	self.cdVisual.Disabled = false;
	self.onCD.Value = true;
end

function SB:ResetCD()
	self.cooldownTime.Value = 0;
	self.onCD.Value = false;
	self.cdVisual.Parent.Value = 100;
	self.cdVisual.Disabled = true;
end

function SB:IsOnCD()
	return self.onCD.Value;
end

function SB:UpdateCharges(charges)
	self.spellCharges.Text = tostring(charges);
end

return SB
