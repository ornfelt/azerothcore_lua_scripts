local next=next
local pcall=pcall
-------------------------
--[[Thus starts aura animation
	This will be copied and placed on a caster for every player that can see him.
--]]

local player = script.Target.Value;
local character;
if player:IsA("Player") then
	character = player.Character
else
	character = player;
end

local originalColors = {}
local ELECTRIC_BLUE = BrickColor.new("Electric blue")

local function changeBrickColor(part)
	if part:IsA("BasePart") and not part:IsA("HumanoidRootPart") then
		originalColors[part] = part.BrickColor
		part.BrickColor = ELECTRIC_BLUE
	end
end

local function revertBrickColor(part)
	if originalColors[part] then
		part.BrickColor = originalColors[part]
	end
end

-- Change parts to Electric Blue
for _, part in ipairs(character:GetDescendants()) do
	changeBrickColor(part)
end

-- Revert parts back to original colors when duration ends
game:service'RunService'.RenderStepped:connect(function()
	if script.Duration.Value <= 0 then
		for _, part in ipairs(character:GetDescendants()) do
			revertBrickColor(part)
		end
		script.Enabled = false;
	end
end)
