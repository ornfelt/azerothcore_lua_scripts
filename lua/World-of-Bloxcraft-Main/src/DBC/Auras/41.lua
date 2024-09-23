local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local player = script.Target.Value
if player ~= game.Players.LocalPlayer then
	script.Disabled = true;
end
local humanoid = nil

-- Change the Lighting properties to create a grayscale effect
local cc = Instance.new("ColorCorrectionEffect", game.Lighting);
local blur = Instance.new("BlurEffect", game.Lighting);
cc.TintColor = Color3.new(0.301961, 0.607843, 0.909804)
cc.Contrast = 0.25
blur.Size = 7.5;
game.Lighting.Brightness = 5;
-- Change the Transparency of the character to make it invisible
for _, child in pairs(player.Character:GetChildren()) do
	if (child:IsA("BasePart") and child.Name ~= "HumanoidRootPart") or child:IsA("Hat") then
		if child:IsA("Hat") then
			child.Handle.Transparency = 0.5
		else
			child.Transparency = 0.5
		end
	end
end

game:service'RunService'.RenderStepped:connect(function()
	if script.Duration.Value == 0 then
		cc.Enabled = false
		blur.Enabled = false
		game.Lighting.Brightness = 1;
		for _, child in pairs(player.Character:GetChildren()) do
			if (child:IsA("BasePart") and child.Name ~= "HumanoidRootPart") or child:IsA("Hat") then
				if child:IsA("Hat") then
					child.Handle.Transparency = 0
				else
					child.Transparency = 0
				end
			end
		end
		script.Enabled = false;
	end
end)