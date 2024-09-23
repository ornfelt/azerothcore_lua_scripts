local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

-- Function to turn a player into a sheep
function turnPlayerIntoSheep(player, duration)
	local character = player.Character
	if not character then return end

	character.Parent = game:GetService("Lighting")
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local originalPos = humanoidRootPart.Position

	local sheepModel = game.ReplicatedStorage.SpellObjects["38"].Sheep:Clone()
	sheepModel.Parent = workspace;
	sheepModel:SetPrimaryPartCFrame(CFrame.new(originalPos))

	local sheepHumanoid = sheepModel:FindFirstChild("Humanoid")
	sheepHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	local currentCamera = workspace.CurrentCamera
	currentCamera.CameraSubject = sheepHumanoid
	wait(duration)
	character.Parent = game.Workspace
	humanoidRootPart.Position = originalPos
	currentCamera.CameraSubject = character.Humanoid
	sheepModel:Destroy()
end
local player = script.Target.Value
turnPlayerIntoSheep(player, 8);