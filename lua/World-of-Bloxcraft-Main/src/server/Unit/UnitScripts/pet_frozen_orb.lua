local frozen_orb = {}
frozen_orb.__index = frozen_orb

local SPELL_MAGE_FROZEN_ORB_DAMAGE = 58
local SPELL_MAGE_FINGERS_OF_FROST = 60;

function frozen_orb.new(unit, owner)
	local self = {}
	setmetatable(self, frozen_orb);

	self.castTimer = 1;
	self.unit = unit;
	self.owner = owner;
	self.pos = nil;
	self.events = {
		--TODO: Add events to cast multiple things consecutively
	}
	self.combatCheck = false;
	self.m_alive = true;
	self.castTimer = 1;
	return self
end

function frozen_orb:Reset()
	self.unit:MovePositionToFirstCollision(self.owner, 150);
	--self.unit:AddUnitState("UNIT_STATE_IGNORE_PATHFINDING");
end

function frozen_orb:Died()
	self.m_alive = false;
end

function frozen_orb:EnterCombat()
	if self.combatCheck == false then
		self.owner:CastSpell(SPELL_MAGE_FINGERS_OF_FROST, self.owner);
		self.owner:CastSpell(SPELL_MAGE_FINGERS_OF_FROST, self.owner);
		self.unit:SetSpeed(math.round(self.unit:GetSpeed() * 0.1));
		self.combatCheck = true;
	end
end

function frozen_orb:Update(m_time)
	if self.m_alive then
		if self.castTimer > 0 then
			self.castTimer = self.castTimer - m_time;
		else
			self.unit:CastSpell(SPELL_MAGE_FROZEN_ORB_DAMAGE, nil);
			self.castTimer = 1;
		end
	end
end

return frozen_orb
