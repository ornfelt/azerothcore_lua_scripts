local player = game.Players.LocalPlayer;
local char = player.Character or player.CharacterAdded:Wait();
local humanoid = char:WaitForChild("Humanoid")
humanoid.AutoRotate = false
-- Locate the player's local camera
local player = game.Players.LocalPlayer

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local mouse = player:GetMouse()
local rightMouseDown = false
local leftMouseDown = false
mouse.Icon = "rbxassetid://13683540690"
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton1 then -- check if the right mouse button was clicked
		mouse.Icon = "rbxassetid://13683159215" -- replace with your transparent image asset id
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton1 then -- check if the right mouse button was released
		mouse.Icon = "rbxassetid://13683540690" -- reset the mouse icon to default
	end
end)

mouse.Button1Down:Connect(function()
	leftMouseDown = true
end)

mouse.Button1Up:Connect(function()
	leftMouseDown = false
end)
local lastMousePosition = nil

UserInputService.InputChanged:Connect(function(input)
	if leftMouseDown then
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			if lastMousePosition then
				local delta = input.Position - lastMousePosition
				local sensitivity = 1 -- Adjust this value to control the camera panning sensitivity
				local rotationX = delta.y * sensitivity
				local rotationY = -delta.x * sensitivity
				local currentCFrame = workspace.CurrentCamera.CFrame
				local rotateX = CFrame.Angles(math.rad(rotationX), 0, 0)
				local rotateY = CFrame.Angles(0, math.rad(rotationY), 0)
				workspace.CurrentCamera.CFrame = rotateX * rotateY * currentCFrame
			end
			lastMousePosition = input.Position
		elseif input.UserInputType == Enum.UserInputType.MouseWheel then
			local zoomAmount = input.Position.Z * 0.001 -- Adjust this value to control the zoom sensitivity
			local zoomVector = Vector3.new(0, 0, zoomAmount)
			workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame + zoomVector
		end
	end
end)


UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		lastMousePosition = nil
	end
end)
