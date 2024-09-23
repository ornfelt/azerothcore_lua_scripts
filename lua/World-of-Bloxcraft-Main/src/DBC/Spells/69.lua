local Database = require(workspace.DatabaseHandler)
local Opcodes = require(workspace.Opcodes)
local char = script.Caster.Value
if char:IsA("Player") then
	char = char.Character
end
local target = script.Target.Value
if target:IsA("Player") then
	target = target.Character
end
local speed = game.Lighting.Spells["1"].Speed.Value
local startPos = char.LeftHand.Position
local endPos = target.PrimaryPart.Position
local movingObject1 = game.ReplicatedStorage.SpellObjects["69"].Orb1:Clone()
local movingObject2 = game.ReplicatedStorage.SpellObjects["69"].Orb2:Clone()
movingObject1.Position = char.PrimaryPart.Position
movingObject1.Position = startPos
movingObject2.Position = char.PrimaryPart.Position
movingObject2.Position = startPos
movingObject1.Parent = workspace
movingObject2.Parent = workspace

local function lerp(a, b, t)
	return a + (b - a) * t
end

local function getTravelTime(distance, speed)
	return distance / speed
end

local maxRadius = 3  -- The maximum distance the orbs should reach from the center
local rotationSpeed = 15 -- the speed of rotation
local arcHeight = 3;

-- our two objects
local obj1, obj2 = movingObject1, movingObject2

local function updateOrbs(pos, dir, t)
	local oscillation
	if t <= 0.35 then
		oscillation = 0
	elseif t >= 1 then
		oscillation = 0
	else
		local x = (t - 0.35) * 2 
		if x < 1 then
			oscillation = 1 - (1 - x) ^ 4 
		else
			oscillation = (x - 2) ^ 4
		end
	end
	local radius = 0.25 + (maxRadius - 1) * oscillation
	local rotation = tick() * rotationSpeed
	local perpVector = Vector3.new(dir.z, 0, -dir.x)

	-- compute an upward displacement that increases until t = 0.5, then decreases
	local upwardDisplacement = arcHeight * (4 * t * (1 - t))  -- parabola peak at t = 0.5

	local pos1 = pos + perpVector * radius * math.cos(rotation) + Vector3.new(0, radius * math.sin(rotation) + upwardDisplacement, 0)
	local pos2 = pos + perpVector * radius * math.cos(rotation + math.pi) + Vector3.new(0, radius * math.sin(rotation + math.pi) + upwardDisplacement, 0)

	obj1.Position = pos1
	obj2.Position = pos2
end


local function moveToTarget()
	local distance = (startPos - endPos).Magnitude
	local travelTime = getTravelTime(distance, speed)
	local startTime = tick()

	local function updateProjectile()
		local elapsedTime = tick() - startTime
		local t = elapsedTime / travelTime

		if t >= 1 then
			updateOrbs(endPos, (endPos - startPos).Unit, t)

			for _,v in next, obj1:GetChildren() do
				if v:IsA("ParticleEmitter") then
					v.Parent = target:findFirstChild("UpperTorso")
				end
			end

			for _,v in next, obj2:GetChildren() do
				if v:IsA("ParticleEmitter") then
					v.Parent = target:findFirstChild("UpperTorso")
				end
			end
			return false
		end

		local newPos = lerp(startPos, endPos, t)
		updateOrbs(newPos, (endPos - startPos).Unit, t)

		return true
	end

	-- Connect updateProjectile function to RenderStepped
	local connection
	connection = game:GetService("RunService").RenderStepped:Connect(function()
		if not updateProjectile() then
			connection:Disconnect()
			wait(0.35)
			obj1:Destroy()
			obj2:Destroy()
			for _,v in next,target:findFirstChild'UpperTorso':GetChildren() do
				if v:IsA("ParticleEmitter") then
					v:Destroy()
				end
			end
			script.Disabled = true
			script:Destroy()
		end
	end)
end

moveToTarget()
