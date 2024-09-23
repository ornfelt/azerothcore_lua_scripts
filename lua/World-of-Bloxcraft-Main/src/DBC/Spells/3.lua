local next=next
local pcall=pcall
-------------------------
local Database = require(workspace.DatabaseHandler);
local Opcodes = require(workspace.Opcodes);
local target = Vector3.new(script.Position.X.Value, script.Position.Y.Value, script.Position.Z.Value);
local StartPos = target + Vector3.new(0, 50, 50);
local EndPos = target
movingObject = game:service'ReplicatedStorage'.SpellObjects["3"].Meteor:Clone()
movingObject.Parent = workspace;
movingObject.Position = StartPos
local Tween = game:GetService("TweenService"):Create(movingObject, TweenInfo.new(1), {Position = EndPos})
Tween:Play()
Tween.Completed:Wait();
movingObject:Destroy();
script.Disabled = true;
script:Destroy();