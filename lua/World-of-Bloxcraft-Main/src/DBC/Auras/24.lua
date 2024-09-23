local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]

local player = script.Target.Value
local char;
if player:IsA("Player") then
	char = player.Character
else
	char = player
end

local fire = game.ReplicatedStorage.AuraObjects["24"]
local aura = game.Lighting.Auras["24"];

local objList = {}

for _,v in next, fire:GetChildren() do
	local newobj = v:Clone()
	newobj.Parent = char.LowerTorso
	table.insert(objList, newobj);
end

game:service'RunService'.RenderStepped:connect(function()
	if script.Duration.Value <= 0 then
		for _,v in next,objList do
			v:Destroy();
		end
		script.Disabled = true;
	end
end)
