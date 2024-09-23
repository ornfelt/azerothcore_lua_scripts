local DH = {}
DH.__index = DH

local previousSecond = 0;

local Opcodes = require(workspace.Opcodes);

function DH.new(player1, player2)
	local new_duel = {}
	setmetatable(new_duel, DH)
	
	new_duel.initiator = player1
	new_duel.target = player2
	new_duel.m_timer = 3;
	new_duel.m_accepted = false;
	new_duel.m_started = false;
	
	return new_duel
end

function DH:Accept()
	self.m_accepted = true;
end

function DH:End()
	self.m_started = false
	self.initiator:CancelDuel();
	self.target:CancelDuel();
end

function DH:Update(m_time)
	if self.m_accepted == true then
		if self.m_timer > 0 then
			self.m_timer = self.m_timer - m_time;
		else
			self.m_timer = 0
			self.m_accepted = false;
			self.m_started = true;
		end
	end
end

return DH
