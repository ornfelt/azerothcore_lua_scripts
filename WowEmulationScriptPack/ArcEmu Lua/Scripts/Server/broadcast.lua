--[[

	Broadcast System
	By Grandelf.

]]--	

local broadcast_add = "#broadcast add"
local broadcast_remove = "#broadcast remove"
local broadcast_list = "#broadcast list"
local broadcast_modify = "#broadcast modify"

function broadcast_system(_, plr, msg)
	if (plr:CanUseCommand("a")) then 
		if (msg:find(broadcast_add.." ") == 1) then
			local str = msg:gsub(broadcast_add.." ", "")
			local tbl = string_split(str, "str")
			if (tbl[1]) then
				local interval = number_check(tbl[1]) and tonumber(tbl[1]) or nil
				local color
				if (tbl[#tbl]:upper():sub(1, 2) == "CF") then
					color = "|"..tbl[#tbl]
					tbl[#tbl] = nil;
				end
				local broadcast_msg = ""
				for k, v in ipairs(tbl) do	
					if (k ~= 1) then
						broadcast_msg = broadcast_msg.." "..v
					end
				end
				local file = io.open("scripts/broadcast_file.txt", "a")
				if (not interval) then
					plr:SendBroadcastMessage("Interval number expected as first argument.")
				elseif (not broadcast_msg) then
					plr:SendBroadcastMessage("Broadcast message expected after inverval.")
				elseif (not color) then
					file:write(interval..","..broadcast_msg.."\n")
					plr:SendBroadcastMessage("You succesfully added a message.")
				elseif (color) then
					file:write(interval..","..broadcast_msg..", "..color.."\n")
					plr:SendBroadcastMessage("You succesfully added a message.")
				end
				file:close()
				restart_script()
			end	
			return 0;
		end
		if (msg:find(broadcast_remove.." ") == 1) then
			local str = msg:gsub(broadcast_remove.." ", "")
			local id = number_check(str) and tonumber(str) or nil
			if (id) then
				local tbl = {}
				local file = io.open("scripts/broadcast_file.txt", "a")
				local line = return_line_by_id(id)
				for l in io.lines("scripts/broadcast_file.txt") do
					if (l ~= "") and (l ~= line) then
						table.insert(tbl, l)
					end
					local f = io.open("scripts/broadcast_file.txt", "w+")
					for _, v in ipairs(tbl) do
						f:write(v.."\n")
					end
					f:close()
				end
				plr:SendBroadcastMessage("The message has been deleted.")
				file:close()
				restart_script()
			else	
				plr:SendBroadcastMessage("Number expected as argument.")
			end
			return 0;	
		end	
		if (msg:find(broadcast_modify.." ") == 1) then
			local str = msg:gsub(broadcast_modify.." ", "")	
			local file = io.open("scripts/broadcast_file.txt", "a")
			local tbl = {}
			if (str:upper():sub(1, 1) == "|") then
				local str_tbl = string_split(str, "str")
				local color, id = unpack(str_tbl)
				if (color) and (id) then
					local msg_tbl = string_split(return_line_by_id(id), "file") 
					rewrite_without_line(return_line_by_id(id), file)
					file:write(msg_tbl[1]..", "..msg_tbl[2]..", |"..color.."\n")
					file:close()
					restart_script()
				elseif (not id) then
					plr:SendBroadcastMessage("Id expected as second argument.")
				end	
			elseif (str ~= "") then
				local str_tbl = string_split(str, "str")
				if (number_check(str_tbl[1])) then
					local interval, id = unpack(str_tbl)
					local broadcast_msg
					if (interval) and (id) then
						local msg_tbl = string_split(return_line_by_id(id), "file") 
						if (not msg_tbl[3]) then
							broadcast_msg = interval..", "..msg_tbl[2]
						elseif (msg_tbl[3]) then
							broadcast_msg = interval..", "..msg_tbl[2]..", "..msg_tbl[3]
						end
						rewrite_without_line(return_line_by_id(id), file)
						file:write(broadcast_msg.."\n")
						file:close()
						restart_script()
					elseif (not id) then
						plr:SendBroadcastMessage("Id expected as second argument.")
					end	
				elseif (str ~= "") then
					local message, id = ""
					for k, v in ipairs(str_tbl) do if (k ~= #str_tbl) then message = message.." "..v else id = v end end		
					local broadcast_msg
					if (message) and (id) then
						local msg_tbl = string_split(return_line_by_id(id), "file")
						if (not msg_tbl[3]) then
							broadcast_msg = msg_tbl[1]..","..message
						elseif (msg_tbl[3]) then
							broadcast_msg = msg_tbl[1]..","..message..", "..msg_tbl[3]
						end
						rewrite_without_line(return_line_by_id(id), file)
						file:write(broadcast_msg.."\n")
						file:close()
						restart_script()
					elseif (not id) then
						plr:SendBroadcastMessage("Id expected as second argument.")
					end	
				end
			end	
			return 0;
		end		
		if (msg == broadcast_list) then
			local count = 1
			for l in io.lines("scripts/broadcast_file.txt") do
				if (count <= 11) and (l ~= "") then
					local tbl = string_split(l, "file")
					plr:SendBroadcastMessage(count.." - "..tbl[2])
					count = count + 1
				else
					plr:SendBroadcastMessage("|cffff0000More than 10 results returned, aborting.")
				end
			end
			if (count == 1) then
				plr:SendBroadcastMessage("No results found.")
			end
			return 0;
		end
	end		
end	
		
function string_split(str, type)
	local words = {}
	if (type == "file") then
		local sp = str:find(",")
		while (sp) do
			table.insert(words, str:sub(1, sp-1))
			str = str:gsub(str:sub(1, sp+1), "")
			sp = str:find(",")
		end	
		table.insert(words, str)
	elseif (type == "str") then	
		str:gsub("(%w+)", function(arg) table.insert(words, arg) end)
	end
	return words;
end

function return_line_by_id(id)
	local count = 1
	local line
	for l in io.lines("scripts/broadcast_file.txt") do
		if (count == tonumber(id)) then
			line = l
			break;
		elseif (l ~= "") then
			count = count + 1
		end	
	end
	return line;
end

function rewrite_without_line(line, file)
	local tbl = {}
	for l in io.lines("scripts/broadcast_file.txt") do
		if (l ~= "") and (l ~= line) then
			table.insert(tbl, l)
		end
		local f = io.open("scripts/broadcast_file.txt", "w+")
		for _, v in ipairs(tbl) do
			f:write(v.."\n")
		end
		f:close()
	end
end	

function number_check(str)
	local c = 1
	while (str:len()+1 ~= c) do
		if (str:sub(c, c):find("%d")) then c = c + 1 else return false; end	
	end
	return true;
end	

function load_strings()
	local file = io.open("scripts/broadcast_file.txt", "a")
	if (file) then
		local loaded = 0
		for l in io.lines("scripts/broadcast_file.txt") do
			if (l ~= "") then
				local tbl = string_split(l, "file")
				local interval, broadcast_msg, color
				if (#tbl == 2) then
					interval, broadcast_msg = unpack(tbl)
				elseif (#tbl == 3) then	
					interval, broadcast_msg, color = unpack(tbl)
				end
				if (color) then
					broadcast_msg = color..broadcast_msg
				end
				loaded = loaded + 1
				RegisterTimedEvent("broadcast_msg", tonumber(interval), 0, broadcast_msg)
			end	
		end
		print("[Broadcast System]: Loaded "..loaded.." messages.")
		file:close()
	else
		print("Could not open file.")
	end	
end	
load_strings()

function broadcast_msg(str)
	for _, v in pairs(GetPlayersInWorld()) do
		v:SendBroadcastMessage("|cffff0000[System Message]|cFFFFFF00: "..str)
	end
end	

function restart_script()
	RemoveTimedEventsWithName("broadcast_msg")
	load_strings()
	--local file = loadfile("scripts/broadcast_script.lua")
	--return file();
end	

RegisterServerHook(16, "broadcast_system")