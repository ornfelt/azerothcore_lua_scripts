local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]
local player = script.Caster.Value;
local tempChar = game.Workspace:findFirstChild("AlterTime: "..player.Name);
if tempChar then
	tempChar:Destroy();
end