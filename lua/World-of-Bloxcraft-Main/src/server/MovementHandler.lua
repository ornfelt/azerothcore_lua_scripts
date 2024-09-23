local Movement = {}
Movement.__index = Movement

function Movement.new(unit)
	local self = {}
	setmetatable(self, Movement)
	
	self.unit = unit
	self.model = nil
	self.human = nil
	
	return self
end

function Movement:Update(m_time)
	if self.human.MoveDirection.Magnitude > 0 then
		self.unit.m_isMoving = true;
	else
		self.unit.m_isMoving = false;
	end
end

local storage = game:service'ReplicatedStorage';
local mathf = require(workspace.Mathf);
Movement.HandleRush = function(humanoid, target, speed, targetPosition)
	local targetReached = false
	local player;
	local controls;
	local disableChar;
	local targetPoint = target.PrimaryPart.Position;
	local char = humanoid.Parent;
	--local humanoid = unit:WaitForChild'Humanoid';
	if game.Players:GetPlayerFromCharacter(humanoid.Parent) then
		player = game.Players:GetPlayerFromCharacter(humanoid.Parent);
		disableChar = storage.DisableChar:Clone();
		local val = disableChar.On;
		val.Value = true;
		disableChar.Parent = player.Backpack;
		disableChar.Disabled = false;
	end
	local oldWalkspeed = humanoid.WalkSpeed
 	if speed then
		humanoid.WalkSpeed = speed;
	end		
	if targetPosition == "TARGET_DEST_NEAR" then	
		targetPoint = mathf.GetPointNear(char.PrimaryPart.Position, targetPoint);
	elseif targetPosition == "TARGET_DEST_FRONT" then
		targetPoint = mathf.GetPointInFront(char.PrimaryPart, targetPoint);
	elseif targetPosition == "TARGET_DEST_BACK" then
		targetPoint = mathf.GetPointBehind(char.PrimaryPart, targetPoint);
	end
	-- start walking
	wait(0.1);
	humanoid:MoveTo(targetPoint)
 	humanoid.MoveToFinished:Wait();
	targetReached = true
	disableChar.On.Value = false;
	--disableChar.Disabled = true;
	--disableChar:Destroy();
	humanoid.WalkSpeed = oldWalkspeed;
	for _,v in next,char:GetChildren() do
		if v:findFirstChild'Fire' then
			v.Fire:Destroy();
		end
	end
end

return Movement
