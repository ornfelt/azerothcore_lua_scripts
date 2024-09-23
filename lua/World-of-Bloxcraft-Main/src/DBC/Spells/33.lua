local next = next
local pcall = pcall
-------------------------
--[[Thus starts spell animation
    This will be copied and placed on a caster for every player that's targeting him.
    This is how it's done.
--]]

local player = script.Caster.Value
local char = player.Character
local obj = game:service'ReplicatedStorage'.SpellObjects["33"]["Cone of Cold"].A0:Clone()

-- Create a new part to attach the Cone of Cold animation
local handPart = Instance.new("Part", char)
handPart.Name = "HandPart"
handPart.Size = Vector3.new(1, 1, 1)
handPart.Transparency = 1
handPart.CanCollide = false
handPart.Anchored = true
handPart.Parent = char

-- Attach the Cone of Cold animation to the new hand part
obj.Parent = handPart

-- Function to update the part's position and orientation
local function updateHandPartPosition()
	handPart.CFrame = char.LeftHand.CFrame
	local lookVector = char.Head.CFrame.lookVector
	handPart.CFrame = CFrame.new(handPart.CFrame.p, handPart.CFrame.p + lookVector + Vector3.new(0,0.5,0))
end

-- Update the hand part's position and orientation on RenderStepped
local runService = game:GetService("RunService")
runService.RenderStepped:Connect(updateHandPartPosition)

-- Enable and disable the Cone of Cold animation
for _, v in next, obj:GetChildren() do
	v.Enabled = true
end
wait(0.75)
for _, v in next, obj:GetChildren() do
	v.Enabled = false
end
