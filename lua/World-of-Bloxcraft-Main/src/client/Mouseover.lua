local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

local function createHighlight(model)
	local highlight = game:service'ReplicatedStorage'.UnitObjects.MouseoverHighlight:Clone()
	highlight.Parent = model;
	highlight.Adornee = model
end

local function removeHighlight(model)
	local highlight = model:FindFirstChild("MouseoverHighlight")
	if highlight then
		highlight:Destroy()
	end
end

local currentTarget

local function updateHighlight()
	local target = mouse.Target
	if target then
		local model = target.Parent
		if model:IsA("Model") and model:FindFirstChild("Humanoid") then
			if not model:findFirstChild("TargetHighlight") then
				if model ~= currentTarget then
					if currentTarget then
						removeHighlight(currentTarget)
					end
					createHighlight(model)
					currentTarget = model
				end
			end
		else
			if currentTarget then
				removeHighlight(currentTarget)
				currentTarget = nil
			end
		end
	else
		if currentTarget then
			removeHighlight(currentTarget)
			currentTarget = nil
		end
	end
end

RunService.RenderStepped:Connect(updateHighlight)