local DR = {}
DR.__index = DR

function DR.new()
	local self = {}
	setmetatable(self, DR)
	
	self.fearDR = 1
	self.stunDR = 1
	self.silenceDR = 1
	self.rootDR = 1
	self.disorientDR = 1
	self.incapDR = 1
	
	self.fearDRTimer = 0
	self.stunDRTimer = 0
	self.silenceDRTimer = 0;
	self.rootDRTimer = 0
	self.disorientDRTimer = 0
	self.incapDRTimer = 0
	
	self.drResetTime = 15
	
	return self
end

function DR:ResetFear()
	self.fearDR = 1
end

function DR:ResetStun()
	self.stunDR = 1
end

function DR:ResetSilence()
	self.silenceDR = 1
end

function DR:ResetRoot()
	self.rootDR = 1
end

function DR:ResetDisorient()
	self.disorientDR = 1
end

function DR:ResetIncap()
	self.incapDR = 1;
end

function DR:ApplyFear()
	self.fearDR = self.fearDR * 0.5
	self.fearDRTimer = self.drResetTime
end

function DR:ApplyStun()
	self.stunDR = self.stunDR * 0.5
	self.stunDRTimer = self.drResetTime
end

function DR:ApplySilence()
	self.silenceDR = self.silenceDR * 0.5
	self.silenceDRTimer = self.drResetTime
end

function DR:ApplyRoot()
	self.rootDR = self.rootDR * 0.5
	self.rootDRTimer = self.drResetTime;
end

function DR:ApplyDisorient()
	self.disorientDR = self.disorientDR * 0.5
	self.disorientDRTimer = self.drResetTime;
end

function DR:ApplyIncap()
	self.incapDR = self.incapDR * 0.5
	self.incapDRTimer = self.drResetTime;
end

function DR:CanStun()
	return self.stunDR >= 0.25
end

function DR:CanSilence()
	return self.silenceDR >= 0.25
end

function DR:CanFear()
	return self.fearDR >= 0.25
end

function DR:CanRoot()
	return self.rootDR >= 0.25
end

function DR:CanDisorient()
	return self.disorientDR >= 0.25
end

function DR:CanIncap()
	return self.incapDR >= 0.25
end


function DR:Update(m_time)
	-- Update DR timers for each CC effect
	if self.fearDRTimer > 0 then
		self.fearDRTimer = self.fearDRTimer - m_time
	end
	if self.stunDRTimer > 0 then
		self.stunDRTimer = self.stunDRTimer - m_time
	end
	if self.silenceDRTimer > 0 then
		self.silenceDRTimer = self.silenceDRTimer - m_time
	end
	if self.rootDRTimer > 0 then
		self.rootDRTimer = self.rootDRTimer - m_time
	end
	if self.disorientDRTimer > 0 then
		self.disorientDRTimer = self.disorientDRTimer - m_time
	end
	if self.incapDRTimer > 0 then
		self.incapDRTimer = self.incapDRTimer - m_time
	end
	if self.fearDRTimer < 0 then
		self:ResetFear()
	elseif self.stunDRTimer < 0 then
		self:ResetStun()
	elseif self.silenceDRTimer < 0 then
		self:ResetSilence()
	elseif self.rootDRTimer < 0 then
		self:ResetRoot()
	elseif self.disorientDRTimer < 0 then
		self:ResetDisorient();
	elseif self.incapDRTimer < 0 then
		self:ResetIncap();
	end
end

return DR
