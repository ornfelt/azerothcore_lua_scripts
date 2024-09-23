

local Todd = {}
Todd.__index = Todd

local SPELL_TODD_FLASH_HEAL = 5
local SPELL_TODD_FIRE_BOLT = 1
local SPELL_TODD_DOT = 2
local SPELL_TODD_BURST = 8

function Todd.new(unit)
	local new_todd = {}
	setmetatable(new_todd, Todd);
	
	new_todd.castTimer = 13;
	new_todd.unit = unit;
	new_todd.m_alive = true;
	new_todd.events = {
		[1] = function()
			new_todd.castTimer = 13
			new_todd.unit:CastSpell(SPELL_TODD_DOT, new_todd.unit:GetTarget());
		end,
		[2] = function()
			new_todd.castTimer = 9
			new_todd.unit:CastSpell(SPELL_TODD_DOT, new_todd.unit:GetTarget());
		end,
	}
	return new_todd
end

function Todd:Reset()
	
end

function Todd:Died()
	self.m_alive = false;
end

function Todd:Update(m_time)
	if self.m_alive then
		if self.castTimer > 0 then
			self.castTimer = self.castTimer - m_time;
		else
			--self.unit:UpdateTarget(game.Players.Voreli);
			--self.castTimer = 10
			--self.unit:CastSpell(1, self.unit:GetTarget());
		end
	end
end

return Todd
