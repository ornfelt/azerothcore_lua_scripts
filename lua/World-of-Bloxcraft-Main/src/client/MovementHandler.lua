local Move = {}
Move.__index = Move

local ContextActionService = game:GetService("ContextActionService")
local FREEZE_ACTION = "freezeMovement"

function Move.new(link, moveType, duration, spellLink)
	local new_move = {}
	setmetatable(new_move, Move)
	
	new_move.link = link
	new_move.moveType = moveType;
	new_move.duration = duration
	new_move.fearLoc = nil;
	new_move.frozen = false;
	new_move.spellLink = spellLink
	
	return new_move
end

function Move:Make()
	if self.moveType == "Fear" then
		self:Fear(self.duration)
	elseif self.moveType == "Stun" then
		self:Stun(self.duration);
	elseif self.moveType == "Silence" then
		print("Made it here, as well!")
	elseif self.moveType == "Root" then
		self:Root(self.duration);
	elseif self.moveType == "Disorient" then
		self:Disorient(self.duration);
	elseif self.moveType == "Slow" then
		self:Slow(self.duration, self.spellLink);
	elseif self.moveType == "Incap" then
		self:Incap(self.duration);
	end
end

function Move:Update(m_time)
	if self.duration > 0 then
		self.duration = self.duration - m_time
	else
		if script.Fear.Disabled == false then
			script.Fear.Disabled = true
		end
		if self.frozen == true then
			self:Unfreeze()
		end
		self.link.Character.HumanoidRootPart.Anchored = false;
		self.link.Character.Humanoid.WalkSpeed = 16;
	end
end

function Move:Fear(duration)
	self:Freeze()
	
	if script.Fear.Disabled == true then
		script.Fear.Disabled = false
	end
	
	-- Start fear timer
	script.Fear.PosVal.Value = 3;
end

function Move:Disorient(duration)
	self:Freeze()
	
	if script.Disorient.Disabled == true then
		script.Disorient.Disabled = false;
		
		-- Start Disorient Timer
		script.Disorient.PosVal.Value = 1;
	end
end

function Move:Stun(duration)
	self:Freeze()
end

function Move:Incap(duration)
	self:Freeze();
end

function Move:Root(duration)
	local player = self.link
	local char = player.Character
	local PrimaryPart = char.PrimaryPart
	PrimaryPart.Anchored = true;
end

function Move:Unroot()
	local player = self.link
	local char = player.Character
	local PrimaryPart = char.PrimaryPart
	PrimaryPart.Anchored = false;
end

function Move:Cancel()
	if self.moveType == "Fear" or self.moveType == "Stun" or self.moveType == "Disorient" or self.moveType == "Incap" then
		self:Unfreeze();
	elseif self.moveType == "Root" then
		self:Unroot();
	elseif self.moveType == "Disorient" then
		self:Unfreeze();
	elseif self.moveType == "Slow" then
		self.link.Character.Humanoid.WalkSpeed = 16;
	end
end

function Move:Slow(duration, spellInfo)
	local speed = spellInfo.SpellFlags:findFirstChild("SPELL_FLAG_SLOW").Value;
	local player = self.link
	local char = player.Character
	char.Humanoid.WalkSpeed = char.Humanoid.WalkSpeed * (1 - speed)
end

function Move:Freeze()
	self.frozen = true
	local controls = require(self.link.PlayerScripts.PlayerModule):GetControls();
	controls:Disable()
end

function Move:Unfreeze()
	self.frozen = false
	local controls = require(self.link.PlayerScripts.PlayerModule):GetControls();
	controls:Enable();
end

return Move
