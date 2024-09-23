local next=next
local pcall=pcall
-------------------------
--[[Thus starts spell animation
	This will be copied and placed on a caster for every player that's targetting him.
	This is how it's done.
--]]

local Database = require(workspace.DatabaseHandler);
local Opcodes = require(workspace.Opcodes);
local mathf = require(workspace.Mathf);
local char = script.Caster.Value;
if char:IsA("Player") then
	char = char.Character;
end
local target = script.Target.Value;
if target:IsA("Player") then
	target = target.Character;
end

if char:IsA("Player") then
	char = char.Character;
end
local target = script.Target.Value;
if target:IsA("Player") then
	target = target.Character;
end
local newEmitter;
local size;
local bool = target.UpperTorso:findFirstChild'Glow';
local tect1,tect2 = Database.Access("world", "spell_animation_objects", "2");
if tect1 then
	for _,v in next,tect1:GetChildren() do
		if v:IsA("ParticleEmitter") then
			newEmitter = v:Clone();
			newEmitter.Parent = target.UpperTorso;
			newEmitter:Emit(3);
		end
	end
end
wait(1)
if bool then
	newEmitter:Destroy();
end

repeat wait()
	
until not target:findFirstChild("2");

if newEmitter then newEmitter:Destroy(); end

script.Disabled = true;
script:Destroy();