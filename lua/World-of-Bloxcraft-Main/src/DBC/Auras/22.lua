local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = script.Target.Value -- You can change this to the desired player if needed
local character = player.Character
local humanoidRootPart = character.HumanoidRootPart

-- Create the fireball part
local function createFireball()
	local fireball = game:service'ReplicatedStorage'.AuraObjects["22"].FireBall:Clone()
	fireball.Parent = character;
	return fireball
end

local fireball1 = createFireball()
local fireball2 = createFireball()

local duration = 0.35 -- The duration of the animation in seconds (set to half a second)
local height = 3 -- The height where the fireballs will stop
local radius = 2 -- The radius of the spiraling movement
local yOffset = 0;
local startTime = tick()
local endTime = startTime + duration

-- Bezier Curve Lerp function
local function Bezier(p0, p1, p2, t)
	local a = p0:Lerp(p1, t)
	local b = p1:Lerp(p2, t)
	return a:Lerp(b, t)
end

-- Update the positions of the fireballs during the animation
local function updateControlPoints()
	local lookDirection = humanoidRootPart.CFrame.LookVector
	local upDirection = Vector3.new(0, 1, 0)
	local rightDirection = lookDirection:Cross(upDirection).Unit

	local p0_1 = humanoidRootPart.Position - radius * rightDirection + yOffset * upDirection
	local p1_1 = humanoidRootPart.Position + (height / 2 + yOffset) * upDirection + radius * lookDirection
	local p2_1 = humanoidRootPart.Position + radius * rightDirection + (height + yOffset) * upDirection

	local p0_2 = humanoidRootPart.Position + radius * rightDirection + yOffset * upDirection
	local p1_2 = humanoidRootPart.Position + (height / 2 + yOffset) * upDirection - radius * lookDirection
	local p2_2 = humanoidRootPart.Position - radius * rightDirection + (height + yOffset) * upDirection

	return p0_1, p1_1, p2_1, p0_2, p1_2, p2_2
end

-- Update the positions of the fireballs during the animation
local function updateFireballPositions()
	local currentTime = tick()
	if currentTime > endTime then
		local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear)
		local tween = game:GetService("TweenService"):Create(fireball1, tweenInfo, { Transparency = 1 })
		tween:Play()
		local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear)
		local tween = game:GetService("TweenService"):Create(fireball2, tweenInfo, { Transparency = 1 })
		tween:Play()
		wait(0.25);
		for _,v in next,fireball1.A0:GetChildren() do
			v.Enabled = false
		end
		for _,v in next,fireball2.A0:GetChildren() do
			v.Enabled = false;
		end
		fireball1:Destroy()
		fireball2:Destroy()
		script.Disabled = true
		return
	end

	local t = (currentTime - startTime) / duration
	local p0_1, p1_1, p2_1, p0_2, p1_2, p2_2 = updateControlPoints()

	fireball1.Position = Bezier(p0_1, p1_1, p2_1, t)
	fireball2.Position = Bezier(p0_2, p1_2, p2_2, t)
	RunService.RenderStepped:Wait()
end


RunService.RenderStepped:Connect(updateFireballPositions)
