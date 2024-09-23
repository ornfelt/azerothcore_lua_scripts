local player = script.Target.Value
local duration = script.Duration
local barrier = game:service'ReplicatedStorage'.AuraObjects["42"].Barrier.Attachment:Clone()
local char = player:IsA("Player") and player.Character or player
barrier.Position = Vector3.new(0,0,0);
barrier.Parent = char:findFirstChild'UpperTorso';

game:service'RunService'.RenderStepped:connect(function()
	if duration.Value <= 0 then
		barrier:Destroy();
		script.Disabled = true
	end
end)