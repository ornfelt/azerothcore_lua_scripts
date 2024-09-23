local LH = {}
LH.__index = LH

function LH.new(unit, map)
	local new_location = {}
	setmetatable(new_location, LH)
	if unit ~= nil then
		new_location.Position = unit.m_HRP.Position;
		new_location.unit = unit
	end
	new_location.m_zoneId = 1;
	new_location.m_instanceId = 1;
	new_location.map = map
	
	return new_location
end

function LH:GetNearestUnitList(dist)
	local list = {}
	for _,v in next, self.map:GetUnits() do
		if v.location:IsWithinDist(dist, self.unit) then
			table.insert(list, v);
		end
	end
	return list;
end

function LH:GetMapId()
	return self.m_mapId;
end

function LH:GetDistanceFrom(target)
	local distance = (self.unit.m_HRP.Position - target.m_HRP.Position).Magnitude
	return distance
end

function LH:GetPetSummonPosition(typ, sumNum)
	if sumNum > 0 then
		if sumNum == 1 then
			if typ == "NPC" then
				return self.unit.m_HRP.Position + self.unit.m_HRP.CFrame:vectorToWorldSpace(Vector3.new(0, 0, -5));
			end
			return self.unit.m_HRP.Position + self.unit.m_HRP.CFrame:vectorToWorldSpace(Vector3.new(-5, 0, 0))
		elseif sumNum == 2 then
			return self.unit.m_HRP.Position + self.unit.m_HRP.CFrame:vectorToWorldSpace(Vector3.new(5, 0, 0))
		elseif sumNum == 3 then
			return self.unit.m_HRP.Position + self.unit.m_HRP.CFrame:vectorToWorldSpace(Vector3.new(0, 0, 5))
		end
	end
end

function LH:Teleport(position)
	local link;
	if self.unit:ToPlayer() then
		link = self.unit.link.Character
	else
		link = self.unit.link
	end
	
	link:MoveTo(position);
end

function LH:LeapForward(character, range)
	
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	local forwardVector = humanoidRootPart.CFrame.LookVector

	local blinkDistance = 40
	local targetPosition = humanoidRootPart.Position + (forwardVector * blinkDistance)

	local ray = Ray.new(humanoidRootPart.Position, (targetPosition - humanoidRootPart.Position).Unit * blinkDistance)
	local hit, hitPosition = workspace:FindPartOnRay(ray, character, false, true)

	if hit then
		targetPosition = hitPosition - forwardVector * 1 -- Adjust the position slightly before the wall
	end

	-- Starting angle in radians (75 degrees)
	local startAngle = math.rad(60)
	local endAngle = 0
	local angleStep = 2

	local foundGround = false

	local numSteps = 20
	local stepDistance = blinkDistance / numSteps
	local currentPosition = humanoidRootPart.Position

	for i = 1, numSteps do
		local nextPosition = currentPosition + forwardVector * stepDistance

		-- Check for obstacles
		local rayToObstacle = Ray.new(currentPosition, forwardVector * stepDistance)
		local hitObstacle, hitPositionObstacle = workspace:FindPartOnRay(rayToObstacle, character, false, true)

		if hitObstacle then
			targetPosition = hitPositionObstacle - forwardVector * 8
			break
		end

		-- Check for ground
		local rayToGround = Ray.new(nextPosition, Vector3.new(0, -blinkDistance, 0))
		local hitGround, hitPositionGround = workspace:FindPartOnRay(rayToGround, character, false, true)

		if hitGround then
			currentPosition = hitPositionGround + Vector3.new(0, character.HumanoidRootPart.Size.Y / 2 + 3, 0)
		else
			currentPosition = nextPosition
		end
	end


	targetPosition = currentPosition

	return targetPosition
	
end

function LH:GetNearestEnemiesFromPosition(position, range)
	local units = self.map:GetUnits();
	local list = {}
	local unit = self.unit;
	for _,v in next, units do
		if v.location:IsWithinRange(position, range) then
			if unit:IsHostile(v) then
				if v:IsAlive() then
					table.insert(list, v);
				end
			end
		end
	end
	return list;
end

function LH:GetEnemiesInCone(coneAngle, coneRange)
	local list = {}
	local unitForward = self.unit.m_HRP.CFrame.LookVector
	local unitPosition = self.unit.m_HRP.Position

	for _, v in next, self:GetNearestEnemyUnitList(coneRange) do
		local targetPosition = v.location.unit.m_HRP.Position
		local targetDirection = (targetPosition - unitPosition).Unit

		local dotProduct = unitForward:Dot(targetDirection)
		local angle = math.acos(dotProduct)

		if angle <= (math.rad(coneAngle) / 2) then
			table.insert(list, v)
		end
	end

	return list
end

function LH:NearTeleportTo(location)
	local unit = self.unit;
	local char;
	if unit.link:IsA("Player") then
		char = unit.link.Character
	else
		char = unit.link
	end
	
	char:MoveTo(location);
end

function LH:IsWithinDist(dist, target)
	local distance = (target.location.unit.m_HRP.Position - self.unit.m_HRP.Position).Magnitude
	return distance < dist
end

function LH:IsWithinRange(position, range)
	local distance = (position - self.unit.m_HRP.Position).Magnitude
	return distance < range
end

function LH:IsWithinInnerRange(position, innerRange)
	local distance = (position - self.unit.m_HRP.Position).Magnitude
	return distance < innerRange
end

function LH:GetNearestEnemyUnitsFromUnit(unit, dist)
	local list = {}
	for _, v in next, self.map:GetUnits() do
		if v.location:IsWithinDist(dist, unit) then
			if self.unit:IsHostile(v) then
				if v:IsAlive() then
					table.insert(list, v)
				end
			end
		end
	end
	return list
end


function LH:GetNearestEnemyUnitList(dist)
	local list = {}
	for _,v in next, self:GetNearestUnitList(dist) do
		if v:IsHostile(self.unit) then
			table.insert(list, v);
		end
	end
	return list;
end

function LH:Update(HRP)
	
end

return LH
