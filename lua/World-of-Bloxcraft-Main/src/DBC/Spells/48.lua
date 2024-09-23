local AT = game.Lighting.AreaTriggers["48"].Gobject.Base:Clone()
AT.Parent = workspace;
AT.Position = script.Position.Value
AT.Anchored = true
AT.CanCollide = false;

local interruptedAT = game:service'ReplicatedStorage'.SpellObjects["48"].Gobject.Base:Clone()
interruptedAT.Parent = workspace;
interruptedAT.Position = script.Position.Value
interruptedAT.Anchored = true;
interruptedAT.CanCollide = false;

for _,v in next, AT:GetDescendants() do
	if v:IsA("ParticleEmitter") then
		v:Emit(2);
	end
end

game:service'RunService'.RenderStepped:connect(function()
	if script.Interrupted.Value == true then
		for _,v in next, interruptedAT:GetDescendants() do
			if v:IsA("ParticleEmitter") then
				v:Emit(2);
			end
		end
		AT:Destroy()
		script.Disabled = true;
		script:Destroy();
	end
end)
