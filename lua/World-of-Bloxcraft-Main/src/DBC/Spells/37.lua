local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]

local Database = require(workspace.DatabaseHandler);
local Opcodes = require(workspace.Opcodes);
local char = script.Caster.Value;
if char:IsA("Player") then
	char = char.Character;
end
local target = script.Target.Value;
if target:IsA("Player") then
	target = target.Character;
end
local Speed = 50;
local StartPos = char.LeftHand.Position;
local EndPos = target.PrimaryPart.Position;
local movingObject = Instance.new("Part",workspace);
movingObject.Name = "MovingObject"
movingObject.Anchored = true;
movingObject.Size = Vector3.new(1,1,1);
movingObject.CanCollide = false;
movingObject.Transparency = 1;
local tect1, tect2 = Database.Access("world","spell_animation_objects", "1");
if tect1 then
	for _,v in next,tect1:GetChildren() do
		local newAnim = v:Clone();
		newAnim.Parent = movingObject;
		newAnim:Emit();
	end
end
movingObject.Position = char.PrimaryPart.Position;
movingObject.Position = StartPos
local Tween = game:GetService("TweenService"):Create(movingObject, TweenInfo.new(1), {Position = EndPos})
Tween:Play()
Tween.Completed:Wait();
movingObject:Destroy()

script.Disabled = true;
script:Destroy();