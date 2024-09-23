local Opcodes = require(workspace.Opcodes);
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = script.Caster.Value;
local character = player.Character
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local explosion = ReplicatedStorage.SpellObjects["34"].Explosion:Clone()
explosion.Parent = Workspace
explosion.Position = humanoidRootPart.Position + Vector3.new(0,-2,0);
explosion.Transparency = 0.75
explosion.CanCollide = false

local startSize = 5
local endSize = 40
local duration = 0.25
local startTime = tick()
local endTime = startTime + duration

-- Update the size and transparency of the explosion during the animation
RunService.RenderStepped:Connect(function()
	local currentTime = tick()
	if currentTime > endTime then
		explosion:Destroy()
		script.Disabled = true;
		return
	end

	local t = (currentTime - startTime) / duration
	local currentSize = startSize + t * (endSize - startSize)
	--local transparency = t

	explosion.Size = Vector3.new(currentSize, currentSize, currentSize)
	--explosion.Transparency = transparency
end)