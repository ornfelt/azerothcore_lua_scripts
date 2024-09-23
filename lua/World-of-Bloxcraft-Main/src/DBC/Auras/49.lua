-- It's good to ensure the player and character are not nil before using them
local player = script.Target.Value
assert(player, "Player not found")
local char;
if player:IsA("Model") == false then
	char = player.Character
else
	char = player;
end

-- Good to use camelCase for variables
local timer = script.Duration
timer.Value = 10;

-- Remember to use :GetService instead of :service, it's recommended
local block = game:GetService('ReplicatedStorage').AuraObjects["49"].Block:Clone()

-- Good to check if block is not nil before using it
assert(block, "Block not found")
block.Parent = workspace
block.Part.Position = char.HumanoidRootPart.Position + Vector3.new(0,1,0);

game:GetService("RunService").RenderStepped:Connect(function()
	if timer.Value <= 0 then
		if block then
			block:Destroy()
			block = nil  -- It's good to nil out references to destroyed objects
		end
	end
end)
