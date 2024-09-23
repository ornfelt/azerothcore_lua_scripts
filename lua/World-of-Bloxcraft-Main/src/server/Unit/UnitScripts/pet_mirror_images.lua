local mirror_images = {}
mirror_images.__index = mirror_images

local SPELL_IMAGES_FROST_BOLT = 44

function mirror_images.new(unit)
	local self = {}
	setmetatable(self, mirror_images);

	self.castTimer = 0;
	self.unit = unit;
	self.owner = nil;
	self.m_alive = false;
	self.events = {
		--TODO: Add events to cast multiple things consecutively
	}
	return self
end

function mirror_images:Reset()
	self.m_alive = true;
end

function mirror_images:Died()
	self.m_alive = false;
end

function mirror_images:Update(m_time)
	if self.m_alive then
		if self.castTimer > 0 then
			self.castTimer = self.castTimer - m_time;
		else
			self.unit:UpdateTarget(self.owner:GetTarget())
			self.unit:FaceTarget();
			self.unit:CastSpell(SPELL_IMAGES_FROST_BOLT, self.owner:GetTarget());
			self.castTimer = 2.5;
		end
	end
end

return mirror_images
