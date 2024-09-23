local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]
local target = script.Target.Value
local explosion = game.ReplicatedStorage.SpellObjects["20"].Explode.A0:Clone()
explosion.Parent = target:findFirstChild("UpperTorso");
for _,v in next,explosion:GetChildren() do
	v:Emit();
end