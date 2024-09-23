local module = {}

local Database = require(workspace.DatabaseHandler);

module.CastSpellVisual = function(player, spell)
	if player and spell then
		if spell:IsA("ObjectValue") then
			spell = spell.Value;
		end
		local char;
		if player:IsA("Player") then
			char = player.Character;
		else
			char = player;
		end
		if char:findFirstChild'LeftHand' and char:findFirstChild'RightHand' then
			local tect1 = game.Workspace.Database.world["spell_script_visual_objects"]:findFirstChild(spell.Name);
			if tect1 then
				local part = tect1.Part
				local A0 = part.A0:Clone()
				local A1 = part.A0:Clone()
				A0.Parent = char:findFirstChild'LeftHand'
				A1.Parent = char:findFirstChild'RightHand'
			end
		end
	end
end

module.HasSpellVisual = function(player)
	if player then
		for _,v in next,player.Character:GetChildren() do
			if v.Name == "LeftHand" or v.Name == "RightHand" then
				for i,g in next,v:GetChildren() do
					if g:IsA("ParticleEmitter") then
						return true;
					end
				end
			end
		end
	end
end

module.EndSpellVisual = function(player)
	local char;
	if player:IsA("Player") then
		char = player.Character;
	else
		char = player;
	end
	
	for _,v in next,char:GetChildren() do
		if v:IsA("BasePart") and (v.Name == "LeftHand" or v.Name == "RightHand") then
			if v:findFirstChild("A0") then
				v.A0:Destroy();
			end
		end
	end
end

return module
