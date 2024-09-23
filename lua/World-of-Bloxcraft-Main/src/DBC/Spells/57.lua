local orb = game:service'ReplicatedStorage'.SpellObjects["57"].VFX.Orb:Clone()
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait();

local frozen_orb_npc = char:WaitForChild'Frozen Orb'

orb.Parent = frozen_orb_npc;

game:service'RunService'.RenderStepped:connect(function()
	if frozen_orb_npc:findFirstChild'Head' ~= nil then
		orb.Position = frozen_orb_npc.HumanoidRootPart.Position;
	else
		script.Disabled = true;
		script:Destroy();
	end
end)