-- Path Node Coords Get Script.

PathNodeCoordsGet = {} -- Main Table.

-- Command.

PathNodeCoordsGet.Command = "#pathnode"
PathNodeCoordsGet.ClearFile = "#clearfile"

-- On Chat Event.

function PathNodeCoordsGet.OnChatEvent(event, player, message, type, language)
	PathNodeCoordsGet.Message = message:lower()
		if (PathNodeCoordsGet.Message:find(PathNodeCoordsGet.Command.." ") == 1) then
			if (player:GetGmRank() == 'az') then
				PathNodeCoordsGet.PathNodeName = message:gsub(PathNodeCoordsGet.Command.." ", "")
				PathNodeCoordsGet.File = assert(io.open("PathNodes.txt", "a+"))
				PathNodeCoordsGet.File:write(PathNodeCoordsGet.PathNodeName..":AddPathNode("..player:GetMapId()..", "..player:GetX()..", "..player:GetY()..", "..player:GetZ()..")\n")
				PathNodeCoordsGet.File:flush()
				return 0
			end
		end
		if (PathNodeCoordsGet.Message:find(PathNodeCoordsGet.ClearFile) == 1) then
			if (player:GetGmRank() == 'az') then
				PathNodeCoordsGet.File = assert(io.open("PathNodes.txt", "w+"))
				PathNodeCoordsGet.File:flush()
				return 0
			end
		end
end

-- Server Hook.

RegisterServerHook(16, "PathNodeCoordsGet.OnChatEvent")