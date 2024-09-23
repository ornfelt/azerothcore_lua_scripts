local Opcodes = {}
local Config = require(workspace.worldserver["worldserver.conf"]);

Opcodes.FindClientPacket = function(opcode)
	for _,v in next, game:service'ReplicatedStorage':GetChildren() do
		if v:IsA("RemoteEvent") and v.Name == opcode then
			if (Config.Logs.Opcodes == "1") then
				print(v.Name);
			end
			return v;
		end
	end
end

Opcodes.FindServerPacket = function(n)
	for i,v in next, game.Workspace:GetChildren() do
		if v:IsA("RemoteEvent") then
			if v.Name == n then
				if (Config.Logs.Opcodes == "1") then
					print(v.Name);
				end
				return v;
			end
		end
	end
end

Opcodes.SendMessageToSet = function(sender, packet, data)
	local set = {};
	if sender:IsA("Player") then sender = sender.Character end;
	if sender and packet then
		for _,v in next,game.Players:GetPlayers() do
			if game.Workspace:findFirstChild(v.Name) then
				local char = v.Character;
				if char and v:DistanceFromCharacter(sender.HumanoidRootPart.Position) < 1000 then
					table.insert(set, v);
				end
			end
		end
	end
	for i=1,#set do
		packet:FireClient(set[i], data);
	end
end

return Opcodes
