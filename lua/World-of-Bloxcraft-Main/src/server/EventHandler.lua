local Event = {}
Event.__index = Event;

function Event.new(delayTime, func)
	local self = setmetatable({}, Event);
	
	self.delayTime = delayTime
	self.func = func;
	self.activated = false;
	
	return self;
end

function Event:Update(m_time)
	if self.activated == false then
		if self.delayTime > 0 then
			self.delayTime -= m_time;
		else
			self.delayTime = 0;
			self.func();
			self.activated = true;
		end
	end
end

return Event
