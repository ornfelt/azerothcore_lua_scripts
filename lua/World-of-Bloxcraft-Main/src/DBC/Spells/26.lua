--[[Thus starts spell animation
    This will be copied and placed on a caster for every player that's targetting him.
    This is how it's done.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = script.Caster.Value
local char = player.Character

local dragon = ReplicatedStorage.SpellObjects["26"].Dragon:Clone()
dragon.Parent = char
dragon.Mesh.Scale = Vector3.new(1.5, 1.5, 1.5)
local timer = 1.5

local prevTick = tick()

local function updateDragonPosition()
	local currentTick = tick()
	local deltaTime = currentTick - prevTick
	prevTick = currentTick

	local head = char.Head
	dragon.Position = head.Position + head.CFrame:vectorToWorldSpace(Vector3.new(0, 0, -3))
	local upAngle = 20 -- Change this value to adjust the upward angle in degrees
	dragon.CFrame = (head.CFrame * CFrame.new(0, 3.5, -3)) * CFrame.Angles(math.rad(upAngle), 0, 0)
	timer = timer - deltaTime
	if timer <= 0 then
		dragon:Destroy()
		script:Destroy()
		script.Disabled = true
	end
end


RunService.RenderStepped:Connect(updateDragonPosition)

local A0 = dragon.A0;
for _,v in next,A0:GetChildren() do
	v.Enabled = true
end
wait(1)
for _,v in next,A0:GetChildren() do
	v.Enabled = false;
end
