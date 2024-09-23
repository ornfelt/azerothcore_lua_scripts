local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local defaultSpeed = 16
local slowSpeed = 8

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Function to slow down the player
local function slowDown()
	humanoid.WalkSpeed = slowSpeed
end

-- Function to speed up the player
local function speedUp()
	humanoid.WalkSpeed = defaultSpeed
end

-- Connect the key press and release events
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.S then
		slowDown()
	end
end

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.S then
		speedUp()
	end
end)
