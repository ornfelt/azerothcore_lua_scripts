local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]
local player = script.Caster.Value;
local char = player.Character
char.Archivable = true;
local tempChar = char:Clone()
tempChar.Parent = workspace
tempChar.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
-- Remove the character's clothing
for _, child in ipairs(tempChar:GetChildren()) do
	if child:IsA("Clothing") or child:IsA("ShirtGraphic") then
		child:Remove()
	end
end

tempChar.Humanoid:Destroy();

-- Set the character's transparency
for _, part in ipairs(tempChar:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Transparency = 0.90
		part.BrickColor = BrickColor.new("Ghost grey")
		part.Anchored = true;
		part.CanCollide = false;
	elseif part:IsA("Part") then
		part.Transparency = 0.90
		part.BrickColor = BrickColor.new("Ghost grey")
		part.Anchored = true;
		part.CanCollide = false;
	elseif part:IsA("MeshPart") then
		part.Transparency = 0.90
		part.BrickColor = BrickColor.new("Ghost grey")
		part.Anchored = true;
		part.CanCollide = false;
	elseif part:IsA("UnionOperation") then
		part.CanCollide = false
	end
end

-- Create a ghostly effect
local ghostEffect = Instance.new("ParticleEmitter")
ghostEffect.Parent = tempChar.Head
ghostEffect.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
ghostEffect.Size = NumberSequence.new(2, 3)
ghostEffect.Texture = "rbxassetid://6789599119"
ghostEffect.EmissionDirection = Enum.NormalId.Top
ghostEffect.Lifetime = NumberRange.new(2, 3)
ghostEffect.Speed = NumberRange.new(5, 7)
ghostEffect.Rate = 10
ghostEffect.Enabled = true

tempChar.Name = "AlterTime: "..player.Name;