local player = game.Players.LocalPlayer
local Opcodes = require(workspace.Opcodes)
local mouse = player:GetMouse()
local spell = script.Spell.Value
local size = script.Size.Value
----------

local part = Instance.new("Part", workspace)
part.Size = Vector3.new(size, 0.1, size);
part.Anchored = true
part.Transparency = 1
part.CanCollide = false;
local partObject = script.PartObject
partObject.Value = part;
local decal = Instance.new("Decal", part)
decal.Face = Enum.NormalId.Top
decal.Texture = "rbxassetid://13009140506"
local char = player.Character
local spell = script.Spell
local HRP = char.HumanoidRootPart;
game:service'RunService'.RenderStepped:connect(function()
	mouse.TargetFilter = part
	part.Position = mouse.Hit.Position
	local dist = spell.Value.MaxRange.Value
	if (mouse.Hit.Position - HRP.Position).magnitude > dist then
		decal.Color3 = Color3.new(0.75, 0, 0);
	else
		decal.Color3 = Color3.new(0, 0.85, 0);
	end
	
end)

mouse.Button1Down:connect(function()
	local data, packet = {},Opcodes.FindServerPacket("CMSG_MOUSE_CLICKED")
	data.Pos = mouse.Hit.Position + Vector3.new(0, 1, 0);
	data.Spell = script.Spell.Value
	packet:FireServer(data);
	part:Destroy();
	wait(0.5)
	script.Disabled = true;
end)

mouse.Button2Down:connect(function()
	part:Destroy();
	script.Disabled = true;
end)
