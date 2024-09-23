local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]

local player = script.Caster.Value
local char = player.Character
local nova = game:service'ReplicatedStorage'.SpellObjects["25"]["Frost Nova"].A0:Clone();
nova.Parent = char.HumanoidRootPart;
wait(0.15);
for _,v in next,nova:GetChildren() do
	v:Emit();
end

