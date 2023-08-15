--[[ 

Metadata - TAB_SIZE=4

File:			custom_commands_r6
Author:			Daniel (comstation11 / wraithx2)
Email:			wraithx2@gmail.com
Description:	Allows for easy creation of custom commands for extending interactivity and extendability on your ArcEmu server.
Version:		r6

	Revision History
	
	r1		Initial Version

	r2		Updated Core - commands can now be typed "shorthand" for quick usage

	r3		Updated Core - commands stored in a table and iterated through "for" loop for a more modular feel

	r4		Updated Core - commands can now include an example usage
			Added "house" and "stairs" commands
			
	r5		Fixed Bugs for HoF re-release
			Added gobject saving support for default commands
			
	r6		Fixed duration issues
	
--]]

local commandprefix = "#" -- Other common options (Use what you want, just let your users know!): ? - + ` ( { [ / \ _ 

-- Command Functions - These are the functions that each command calls.

function CC_Help(player, args, command, commands)
	for i, k in ipairs(commands) do
		local aliases = "Aliases: "
		for j, v in ipairs(k[1]) do
			aliases = aliases..v.." "
		end
		player:SendBroadcastMessage("-- "..aliases)
		player:SendBroadcastMessage(k[3])
		player:SendBroadcastMessage(k[4])
		player:SendBroadcastMessage(k[5])
	end
end -- End CC_Help

function CC_MovePlayer(player, args, command)
	if (table.getn(args) <= 2) then
		player:SendBroadcastMessage(command[3])
		player:SendBroadcastMessage(command[4])
		player:SendBroadcastMessage(command[5])
	else
		local target = 0
		if (player:GetPrimaryCombatTarget() ~= 0) then
			target = player:GetPrimaryCombatTarget()
		end
		local x = player:GetX()
		local y = player:GetY()
		local z = player:GetZ()
		local o = player:GetO()
		if (args[2] == "x") then x = x + args[3]
		elseif (args[2] == "y") then y = y + args[3]
		elseif (args[2] == "z") then z = z + args[3]
		elseif (args[2] == "o") then o = args[3]
		end
		player:Teleport(player:GetMapId(), x, y, z)
		player:SetFacing(o)
		if (args[4] ~= "true") then		
			player:SendBroadcastMessage("CC_MovePlayer: Teleporting "..target.." to Map "..player:GetMapId()..", "..x..", "..y..", "..z..", "..o..".")
		end
	end
end -- End CC_MovePlayer

function CC_BuildHouse(player, args, command)
	if (table.getn(args) <= 3) then
		player:SendBroadcastMessage(command[3])
		player:SendBroadcastMessage(command[4])
		player:SendBroadcastMessage(command[5])
	else
		local mpArgs = {"", "o", "0"}
		CC_MovePlayer(player, mpArgs, command)
		local x = args[2]
		local y = args[3]
		local z = args[4]
		local doorloc = args[5]
		local offset = args[6]
		player:SendBroadcastMessage("Building House with dimensions: "..x..", "..y..", "..z..".")
		-- Floor
		for i = 1, x do	
			if (cancel == true) then
				cancel = false
				return
			end
			for j = 1, y do		
				if (cancel == true) then
					cancel = false
					return
				end
				player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
				local mpArgs = {"", "x", 3, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
			local mpArgs = {"", "y", 3, "true"}
			CC_MovePlayer(player, mpArgs, command)
			local tmpmoveback = x * -3
			local mpArgs = {"", "x", tmpmoveback, "true"}
			CC_MovePlayer(player, mpArgs, command)
		end
		-- Fix position
		local mpArgs = {"", "y", -3, "true"}
		CC_MovePlayer(player, mpArgs, command)
		x = x - 1
		y = y - 1
		-- Walls
		for j = 1, z do		
			if (cancel == true) then
				cancel = false
				return
			end
			local mpArgs = {"", "z", .39, "true"}
			CC_MovePlayer(player, mpArgs, command)
			for i = 1, x do
				if (cancel == true) then
					cancel = false
					return
				end
				if (CC_CommandMatch(doorloc, "east") == true) then
					if (i / offset == 1) then
						
					else
						player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
					end						
				else
					player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
				end
				local mpArgs = {"", "x", 3, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
			for i = 1, y do		
				if (cancel == true) then
					cancel = false
					return
				end
				if (CC_CommandMatch(doorloc, "north") == true) then
					if (i / offset == 1) then
						
					else
						player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
					end						
				else
					player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
				end
				local mpArgs = {"", "y", -3, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
			for i = 1, x do
				if (cancel == true) then
					cancel = false
					return
				end
				if (CC_CommandMatch(doorloc, "west") == true) then
					if (i / offset == 1) then
						
					else
						player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
					end						
				else
					player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
				end		
				local mpArgs = {"", "x", -3, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
			for i = 1, y do
				if (cancel == true) then
					cancel = false
					return
				end
				if (CC_CommandMatch(doorloc, "south") == true) then
					if (i / offset == 1) then
					else
						player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
					end						
				else
					player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
				end
				local mpArgs = {"", "y", 3, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
		end
		local q = y * -3
		local mpArgs = {"", "y", q, "true"}
		CC_MovePlayer(player, mpArgs, command)
	end
end -- End CC_BuildHouse

function CC_BuildStairs(player, args, command)
	if (table.getn(args) <= 3) then
		player:SendBroadcastMessage(command[3])
		player:SendBroadcastMessage(command[4])
		player:SendBroadcastMessage(command[5])
	else
		local x = args[2]
		local y = args[3]        
		local z = args[4]        
		local spiral = args[5]   
		if (spiral == null) then 
			for j = 1, z do	  
				if (cancel == true) then
					cancel = false
					return
				end   
				player:SpawnGameObject(185301, player:GetX(), player:GetY(), player:GetZ(), 0, 0, 100, 1, 1)
				local mpArgs = {"", "z", .39, "true"}
				CC_MovePlayer(player, mpArgs, command)
				local mpArgs = {"", "y", y, "true"}
				CC_MovePlayer(player, mpArgs, command)
				local mpArgs = {"", "x", x, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
		elseif (CC_CommandMatch(spiral, "fences") == true) then
			local zheight = .43
			if (args[6] ~= null) then
				zheight = args[6]
			end
			for j = 1, z do	  
				if (cancel == true) then
					cancel = false
					return
				end   
				player:SpawnGameObject(186252, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 0, 100, 1, 1)
				local mpArgs = {"", "z", zheight, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
		else
			local zheight = .43
			if (args[6] ~= null) then
				zheight = args[6]
			end
			for j = 1, z do
				if (cancel == true) then
					cancel = false
					return
				end
				player:SpawnGameObject(186252, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 0, 100, 1, 1)
				local mpArgs = {"", "z", zheight, "true"}
				CC_MovePlayer(player, mpArgs, command)
				local o = player:GetO() + (math.pi / spiral)
				player:SetFacing(o)
				local mpArgs = {"", "y", y, "true"}
				CC_MovePlayer(player, mpArgs, command)
				local mpArgs = {"", "x", x, "true"}
				CC_MovePlayer(player, mpArgs, command)
			end
		end
	end
end -- End CC_BuildStairs

function CC_SetLevel(player, args, command)
	if (table.getn(args) <= 1) then
		player:SendBroadcastMessage(command[3])
		player:SendBroadcastMessage(command[4])
		player:SendBroadcastMessage(command[5])
	else
		player:SetPlayerLevel(args[2])
		player:SendBroadcastMessage("CC_SetLevel: Set player's level to "..args[2]..".")
	end
end -- End CC_AdjustLevel

-- End Command Functions

local commands = { --[[ To add your own command, simply copy and paste the code below and modify it to fit your command:
	
	{
		{ "alias1", "alias2" }, 					-- Aliases - what to type to trigger the Command Function
		CC_CommandFunction, 						-- Command Function (above)
		"Description: Does something interesting!",	-- Description of command - this is displayed when the user uses the help command
		"Usage: "..commandprefix.."command", 		-- Usage text - this is displayed when the user uses the help command
		true/false 									-- Requires GM status
	},

	We show you where to paste below! ]]--
	
	-- Paste here!

	{
		{ "help", "commands" }, 																		-- ALiases
		CC_Help, 																						-- Command Function
		"Description: Displays a list of all custom commands, a description, and their proper usage.",	-- Description
		"Usage: "..commandprefix.."help, "..commandprefix.."commands",									-- Usage
		"Example: "..commandprefix.."help",																-- Example Usage
		false																							-- Requires GM
	},	
	
	{
		{ "moveplayer", "moveme" }, 																	-- ALiases
		CC_MovePlayer,																					-- Command Function
		"Description: Moves the player's target the specified amount in the specified direction.",		-- Description
		"Usage: "..commandprefix.."moveplayer dir[x/y/z/o] amount#",									-- Usage
		"Example: "..commandprefix.."moveplayer x 3",													-- Example Usage
		true																							-- Requires GM
	},
	
	{
		{ "building", "house", "buildhouse" }, 															-- Aliases - what to type to trigger the Command Function
		CC_BuildHouse,		 																			-- Command Function (above)
		"Description: Builds a house of gObjects out of the specified dimensions in panels.",			-- Description of command
		"Usage: "..commandprefix.."buildhouse xsize# ysize# zsize# doorside[n/s/e/w] offset#", 			-- Usage text
		"Example: "..commandprefix.."buildhouse 8 8 20 s 2",											-- Example Usage
		true																							-- Requires GM status
	},
	
	{
		{ "stairs", "buildstairs" }, 																	-- Aliases - what to type to trigger the Command Function
		CC_BuildStairs,				 																	-- Command Function (above)
		"Description: Builds a set of stairs of gObjects out of the specified dimensions in panels.",	-- Description of command
		"Usage: "..commandprefix.."stairs xdistance# ydistance# zpanels# [rotpoints/f] [zheight]", 		-- Usage text
		"Example: "..commandprefix.."stairs .3 0 20, "..commandprefix.."stairs 0 0 20 32 .33",			-- Example Usage
		true																							-- Requires GM status
	},
	
	-- Or even here!
	
	{
		{ "setlevel" }, 																				-- ALiases
		CC_SetLevel,																					-- Command Function
		"Description: Set's the player's target's level to the specified integer.",						-- Description
		"Usage: "..commandprefix.."setlevel level#",													-- Usage
		"Example: "..commandprefix.."setlevel 1",														-- Example Usage
		true																							-- Requires GM
	}
}

function OnChat_ParseCommand(event, player, message, type, language)
	args = CC_SplitString(" ", message)
	command = args[1]
	if (string.sub(command, 1, 1) == commandprefix) then
		command = string.sub(command, 2)
		for i, k in ipairs(commands) do
			for j, v in pairs(k[1]) do
				if (CC_CommandMatch(command, v)) then
					if (k[5] == true) then
						if (player:IsGm() == true) then
							k[2](player, args, k, commands)
							return 0
						end
					else
						k[2](player, args, k, commands)
						return 0
					end
				end
			end
		end
		return 0
	end
	return 1
end -- End OnChat_ParseCommand
	
RegisterServerHook(16, "OnChat_ParseCommand")
	
-- Utility Functions - Do not modify!

--[[ function CC_SplitString(str, pat)
	local t = {n = 0} -- NOTE: use {n = 0} in Lua-5.0
	local fpat = "(.-)" .. pat
	local last_end = 1
	local s, e, cap = str:find(fpat, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t,cap)
		end
		last_end = e+1
		s, e, cap = str:find(fpat, last_end)
	end
	if last_end <= #str then
		cap = str:sub(last_end)
		table.insert(t, cap)
	end
	return t
	return str;
end -- End CC_SplitString ]]--

function CC_SplitString(div,str) -- Props to Icefreze™ from WoW-V for the core of this function!
	local pos,arr = 0,{}
	for st,sp in function() return string.find(str,div,pos,true) end do
		table.insert(arr,string.sub(str,pos,st-1))
		pos = sp + 1
	end
	table.insert(arr,string.sub(str,pos))
	return arr
end

function CC_CommandMatch(msg, cmd)
	if (msg ~= null) then
	if (cmd ~= null) then
		msg = string.lower(msg)
		cmd = string.lower(cmd)
		if (msg == cmd) then
			return true
		end
		if (string.sub(cmd, 1, string.len(msg)) == msg) then
			return true
		end
	end 
	end
	return false
end -- End CC_CommandMatch