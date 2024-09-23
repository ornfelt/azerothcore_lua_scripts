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

local speed = game.Lighting.Spells["55"].Speed.Value;
local amplitude = 17 -- Amplitude of the wave, adjust as needed
local frequency = 20 -- Frequency of the wave, adjust as needed
local startPos = char.LeftHand.Position
local endPos = target.PrimaryPart.Position
local movingObject = game.ReplicatedStorage.SpellObjects["55"].VFX.Projectile:Clone()

movingObject.Parent = workspace
movingObject.CanCollide = false
movingObject.Anchored = true
movingObject.Position = startPos

local explosion = game.ReplicatedStorage.SpellObjects["55"].VFX.Explode.A0:Clone()

local function lerp(a, b, t)
	return a + (b - a) * t
end

local function getTravelTime(distance, speed)
	return distance / speed
end

local waveDirection = math.random() > 0.5 and 1 or -1

local maxOffset = 20 -- for example
local waveStart = 0.45
local endPosOffsetMax = 5

local function smoothStep(t)
	return t * t * (3 - 2 * t)
end

local function moveToTarget()
	-- Add this line to offset the end position before calculating the distance
	endPos = endPos + Vector3.new(math.random(-endPosOffsetMax, endPosOffsetMax), 0, 0)

	local distance = (movingObject.Position - endPos).Magnitude
	local travelTime = getTravelTime(distance, speed)
	local startTime = tick()

	local function updateProjectile()
		local elapsedTime = tick() - startTime
		local t = elapsedTime / travelTime

		if t >= 1 then
			movingObject.Position = endPos
			for _,v in next, movingObject:GetChildren() do
				if v:IsA("ParticleEmitter") then
					v.Parent = target:findFirstChild("UpperTorso");
				end
			end
			return false
		end

		local linearPosition = lerp(startPos, endPos, t)
		local offset = Vector3.new(0, 0, 0)
		if t > waveStart then
			local adjustedT = (t - waveStart) / (1 - waveStart)
			adjustedT = smoothStep(adjustedT) -- Apply smoothstep to adjustedT
			local P1 = maxOffset * waveDirection
			local P2 = 0
			local Bt = (1 - adjustedT)^2 * 0 + 2 * (1 - adjustedT) * adjustedT * P1 + adjustedT^2 * P2
			offset = Vector3.new(Bt, 0, 0)
		end
		movingObject.Position = linearPosition + offset
		return true
	end

	local connection
	connection = game:GetService("RunService").RenderStepped:Connect(function()
		if not updateProjectile() then
			connection:Disconnect()
			movingObject:Destroy()
			explosion.Parent = target:findFirstChild("UpperTorso");
			for _,v in next,explosion:GetChildren() do
				v:Emit();
			end
			wait(1);
			for _,v in next,target:findFirstChild'UpperTorso':GetChildren() do
				if v:IsA("ParticleEmitter") then
					v:Destroy();
				end
			end
			script.Disabled = true
			script:Destroy()
		end
	end)
end

moveToTarget()
