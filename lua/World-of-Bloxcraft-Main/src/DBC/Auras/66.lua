local player = script.Target.Value
local duration = script.Duration
local barrier = game:service'ReplicatedStorage'.AuraObjects["66"].Aura:Clone()
local char = player:IsA("Player") and player.Character or player
barrier.Parent = char:findFirstChild'UpperTorso'

game:service'RunService'.RenderStepped:connect(function()
	if duration.Value <= 0 then
		barrier:Destroy();
	end
	
	barrier.Position = char.HumanoidRootPart.Position
end)