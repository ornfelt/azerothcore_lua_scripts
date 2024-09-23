local next=next
local pcall=pcall
-----------------------------------------
local Math = require(workspace.Mathf);
local Opcodes = require(workspace.Opcodes);
local player = game.Players.LocalPlayer;
local lab=script.Parent
local labbar=script.Parent.Parent
local cbc = script.Parent.Parent.Parent
local bar=script.Parent.Parent.Parent.Parent
local p = 0;
local render;
labbar.Size = UDim2.new(0, 190, 0, 15);
render = game:service'RunService'.RenderStepped:connect(function(deltaTime)
	local t = Math.lerp(0, 1, p);
	if p >= 1 then
		script.Disabled = true;
		bar.Visible = false;
		render:Disconnect();
	end
	lab.TextTransparency = t;
	labbar.BackgroundTransparency = t;
	cbc.BackgroundTransparency = t;
	--bar.BackgroundTransparency = t;
	p = p + (deltaTime*3);
end)
