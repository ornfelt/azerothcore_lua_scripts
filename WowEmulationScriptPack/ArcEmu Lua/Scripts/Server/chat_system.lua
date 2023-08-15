local chat_prefix		= "#c"
local change_colour		= "#chat change colour"
local chat_enable		= "#chat enable"
local chat_disable		= "#chat disable"
local chat_ban_target	= "#chat ban player"
local chat_unban_target	= "#chat unban player"
local chat_colour_list	= "#chat colour list"
local chat_commands		= "#chat commands"

local forbidden_words = {
	"fuck",
	"damned",
	"cunt",
	"ho",
	"dick",
	"gay",
	"ass"
}

local default_color = "GREEN"

local colours = {
	PINK 	= "|cFFFF00FF",
	WHITE	= "|cffffffff",
	PURPLE	= "|cffDA70D6",
	GOLD	= "|cffffcc00",
	BLUE	= "|cff0000ff",
	GREEN	= "|cff00ff00",
	YELLOW	= "|cffffff00",
	MAGENTA	= "|cffff00ff",
	RED	= "|cffff0000",
	GREY	= "|cff888888",
	CYAN	= "|cff00ffff",
	ORANGE	= "|cffFF4500"
}

local server_tag = "CNA"

local colour_table = {}

function chat_system(_, plr, msg)
	--[[
		
		player = enable = 1, banned = 0, 
		
	]]--
		
	-- Function to get data from the data file.
	local function return_file_data(plr)
		for l in io.lines("scripts/chat_file.txt") do
			if (l:sub(1, l:find("%s")-1) == plr:GetName()) then
				return l;
			end
		end
		return false;
	end	
		
	-- Function to return the actualy data by name.
	local function return_data(str, name)
		if not (str) then return 2; end
		local sp, ep = str:find(name)
		local data
		if not (name == "banned") then
			data = str:sub(ep+4, ep+4)
		elseif (name == "banned") then
			data = str:sub(ep+4, str:len())
		end	
		return data;
	end
	
	-- Function to rewrite a file without a specific line.
	local function rewrite_without_line(line)
		local tbl = {}
		for l in io.lines("scripts/chat_file.txt") do
			if (l ~= "") and (l ~= line) then
				table.insert(tbl, l)
			end	
		end
		local f = io.open("scripts/chat_file.txt", "w+")
		for _, v in ipairs(tbl) do
			f:write(v.."\n")
		end
		f:close()	
	end	
	
	-- Function to modify the data in the data file.
	local function modify_data(plr, name, data)
		for l in io.lines("scripts/chat_file.txt") do
			if (l:sub(1, l:find("%s")-1) == plr:GetName()) then
				local n_data = return_data(l, name)
				rewrite_without_line(l)
				local m_str = l:gsub(name.." = "..n_data, name.." = "..data)
				local file = io.open("scripts/chat_file.txt", "a")
				file:write(m_str.."\n")
				file:close()
				break;
			end
		end
	end
	
	if (msg:find(chat_prefix.." ") == 1) then
		
		-- Gaining data from the file.
		local str = return_file_data(plr)
		local enabled = return_data(str, "enabled")
		local banned = return_data(str, "banned")
		
		-- Is the chat really enabled?
		if (tonumber(enabled) == 0) then
			return 0;
		end
		
		-- Is the player banned?
		if (tonumber(banned) >= 3) then
			return 0;
		end	
		
		local msg = msg:gsub(chat_prefix.." ", "")
		
		-- Function to remove beginning spaces.
		local function remove_spaces(str)
			while (str:find("%s") == 1) do
				str = str:gsub(str:sub(1, 1), "")
			end
			return str;
		end	
		
		-- Removing beginning spaces.
		if (msg:find("%s") == 1) then
			msg = remove_spaces(msg)
		end	
		
		-- Checking if the string is empty.
		if (msg == nil or msg == "") then
			return 0;
		end
				
		-- Function to filter bad language.
		local function filter_msg(str)
			local c_msg = str
			for word in c_msg:gmatch("%w+") do
				for _, f_word in pairs(forbidden_words) do
					if (word:lower() == f_word) then
						c_msg = c_msg:gsub(word, "$!#&")
					end
				end		
			end
			msg = c_msg
		end	
		
		-- Removing bad language.
		filter_msg(msg);
		
		-- Function to return the right colour.
		local function return_colour(plr)
			if (colour_table[plr:GetName()]) then
				return colour_table[plr:GetName()].c_colour;
			end
			return colours[default_color];
		end	

		-- Function to get the rank of the player.
		local function return_rank_tag(plr)
			

local PlayerName = plr:GetName()
local GetPlayerACCT = CharDBQuery("SELECT acct FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
local GmRank = CharDBQuery("SELECT gm FROM accounts WHERE acct = '"..GetPlayerACCT.."'"):GetColumn(0):GetString()






				if (GmRank == 'v') then
					return "|cFFD2B48C[Vip]";
				elseif (GmRank == 'a') then
					return "|cFF00FFFF[GM]";
				elseif (GmRank == 'az') then
					return "|cFFFFA500[Admin]";
				elseif (GmRank == 'p1') then
					return "|cFFCC00FF[Donator]";	
				elseif (GmRank == 'p2') then
					return "|cFF9900FF[Donator]";
				elseif (GmRank == 'p3') then
					return "|cFF6600FF[Donator]";
				elseif (GmRank == nil) then
					return nil;


				end
			
		end		
		
		-- Preparing the string.
		local msg = return_colour(plr)..msg
		local m_rank = return_rank_tag(plr)
		local m_msg
		if (m_rank) then
			m_msg = "|cffffff00["..server_tag.."]"..m_rank.."|cFFFF1493["..plr:GetName().."]: "..msg..""
		elseif not (m_rank) then
			m_msg = "|cffffff00["..server_tag.."]|cFFFF1493["..plr:GetName().."]: "..msg..""
		end
		
		-- Sending the message.
		for _, v in pairs(GetPlayersInWorld()) do
			local str = return_file_data(v)
			local enabled = return_data(str, "enabled")
			if (tonumber(enabled) >= 1) then
				v:SendBroadcastMessage(m_msg)
			end
		end
		return 0;	
		
	elseif (msg:find(change_colour.." ") == 1) then
		
		local color = msg:gsub(change_colour.." ", "")
		
		-- Function to return the colour code or nil.
		local function return_colour_code(str)
			for k in pairs(colours) do
				if (str:upper() == tostring(k)) then
					return colours[k];
				end
			end
			return false;
		end
		
		-- Checking if colour exist.
		color = return_colour_code(color)
		if not (color) then
			plr:SendBroadcastMessage("This colour doesn't exist.")
			return 0;
		end

		-- Bind colour to the player.
		colour_table[plr:GetName()] = {c_colour = color}
		return 0;	
		
	elseif (msg == chat_enable) then
		
		-- Gaining data from the file.
		local str = return_file_data(plr)
		local enabled = return_data(str, "enabled")
		
		-- Is the chat really enabled?
		if (tonumber(enabled) >= 1) then
			return 0;
		end
	
		--Enabling the chat.
		modify_data(plr, "enabled", 1);

		plr:SendBroadcastMessage("You have enabled the chat.")
		return 0;
	
	elseif (msg == chat_disable) then
		
		-- Gaining data from the file.
		local str = return_file_data(plr)
		local enabled = return_data(str, "enabled")
		
		-- Is the chat really disabled?
		if (tonumber(enabled) == 0) then
			return 0;
		end
		
		-- Disabling the chat
		if (tonumber(enabled) == 1) then
			modify_data(plr, "enabled", 0);
		elseif (tonumber(enabled) == 2) then
			local file = io.open("scripts/chat_file.txt", "a")
			file:write(plr:GetName().." = enabled = 0, banned = "..return_data(str, "banned").."\n")
			file:close()
		end
		
		plr:SendBroadcastMessage("You have disabled the chat.")
		return 0;
		
	elseif (msg:find(chat_ban_target.." ") == 1) then
		
		-- Is the player atleast a GM.
		if not (plr:CanUseCommand("a")) then
			return 0;
		end
		
		-- Gaining the arguments.
		local words = {}
		msg:gsub(chat_ban_target.." ", ""):gsub("(%w+)", function(arg) table.insert(words, arg) end)
		
		-- Checking if we have 2 arguments.
		if not (#words == 2) then
			plr:SendBroadcastMessage("Wrong usage of the command use "..chat_ban_target.." plrname duration.")
			return 0;
		end

		-- Function to check if duration is really a number.
		local function number_check(str)
			local c = 1
			while (str:len()+1 ~= c) do
				if (str:sub(c, c):find("%d")) then c = c + 1 else return false; end	
			end
			return true;
		end
		
		-- Is duration a number?
		if not (number_check(words[2])) then
			plr:SendBroadcastMessage("Argument duration has to be a number.")
			return 0;
		end	
	
		-- Function to check if the player is online.
		local function is_player_online()
			for _, v in pairs(GetPlayersInWorld()) do
				if (v:GetName() == words[1]) then
					return v;
				end
			end
			return false;	
		end

		-- Checking if the player is online.
		if not (is_player_online(words[1])) then
			plr:SendBroadcastMessage("This player isn't online.")
			return 0;
		end
		
		local player = is_player_online(words[1])

		-- Gaining data from the file.
		local str = return_file_data(player)
		local banned = return_data(str, "banned")
		
		-- Is the player already banned?
		if (tonumber(banned) >= 1) then
			plr:SendBroadcastMessage("This player is already banned from the chat.")
			return 0;
		end
		
		-- Checking if the max duration is reached.
		if (tonumber(words[2]) > 86400) then
			plr:SendBroadcastMessage("You can't ban a player any longer then 24h (86400 seconds)")
			return 0;
		end	
		
		-- Banning the plr
		if (tonumber(banned) == 0) then
			modify_data(player, "banned", os.time()+words[2]);
		elseif (tonumber(banned) == 2) then
			local file = io.open("scripts/chat_file.txt", "a")
			file:write(player:GetName().." = enabled = "..return_data(str, "enabled")..", banned = "..os.time()+words[2].."\n")
			file:close()
		end	
		
		-- Broadcast Message
		SendWorldMessage("|cffff0000"..words[1].." has been banned from the chat by "..plr:GetName().." for "..words[2].." seconds.", 2) 
		return 0;
	elseif (msg:find(chat_unban_target.." ") == 1) then
	
		-- Is the player atleast a GM.
		if not (plr:CanUseCommand("a")) then
			return 0;
		end
		
		local player = msg:gsub(chat_unban_target.." ", "")
		
		-- Gaining userdata.
		for _, v in pairs(GetPlayersInWorld()) do
			if (v:GetName() == player) then
				player = v
			end
		end		
		
		-- Gaining data from the file.
		local str = return_file_data(player)
		
		-- Is the player in the file?
		if not (str) then
			SendBroadcastMessage("This player isn't banned.")
			return 0;
		end
		
		local banned = return_data(str, "banned")
		
		-- Is the player banned?
		if (tonumber(banned) == 0) then
			SendBroadcastMessage("This player isn't banned.")
			return 0;
		end
		
		-- Removing the ban.
		modify_data(player, "banned", 0);
		plr:SendBroadcastMessage("Player: "..player:GetName().." is no longer banned.")
		return 0;
		
	elseif (msg == chat_colour_list) then
		
		for k, v in pairs(colours) do
			local str = k:lower()
			local m_str = str:gsub(str:sub(1, 1), str:sub(1, 1):upper(), 1)
			plr:SendBroadcastMessage(v..""..m_str)
		end
		return 0;

	elseif (msg == chat_commands) then
		
		plr:SendBroadcastMessage("|cffff0000Available commands:")
		plr:SendBroadcastMessage(chat_prefix.." [msg] - Sends a global msg.")
		if (plr:CanUseCommand("a")) then
			plr:SendBroadcastMessage(chat_ban_target.." [plrname duration] - Bans a player.")
			plr:SendBroadcastMessage(chat_unban_target.." [plrname] - Unbans a player.")
		end
		plr:SendBroadcastMessage(chat_enable.." - Enabling the chat after disabling it.")
		plr:SendBroadcastMessage(chat_disable.." - Disables the chat, you can't see or use the chat.")
		plr:SendBroadcastMessage(change_colour.." [color] - Colours your messages in the chat.")
		plr:SendBroadcastMessage(chat_colour_list.." - Shows a list of available colours.")
		return 0;
	end
	
end

-- Function to remove bans from players whose ban time is expired.
function remove_ban_timers()

	local function return_data(str, name)
		if not (str) then return 2; end
		local sp, ep = str:find(name)
		local data
		if not (name == "banned") then
			data = str:sub(ep+4, ep+4)
		elseif (name == "banned") then
			data = str:sub(ep+4, str:len())
		end	
		return data;
	end
	
	local function rewrite_without_line(line)
		local tbl = {}
		for l in io.lines("scripts/chat_file.txt") do
			if (l ~= "") and (l ~= line) then
				table.insert(tbl, l)
			end	
		end
		local f = io.open("scripts/chat_file.txt", "w+")
		for _, v in ipairs(tbl) do
			f:write(v.."\n")
		end
		f:close()	
	end	
	
	local function modify_data(plr, name, data)
		for l in io.lines("scripts/chat_file.txt") do
			if (l:sub(1, l:find("%s")-1) == plr) then
				local n_data = return_data(l, name)
				rewrite_without_line(l)
				local m_str = l:gsub(name.." = "..n_data, name.." = "..data)
				local file = io.open("scripts/chat_file.txt", "a")
				file:write(m_str.."\n")
				file:close()
				break;
			end
		end
	end

	for l in io.lines("scripts/chat_file.txt") do
		if (l ~= "") or (l ~= nil) then
			local plr = l:sub(1, l:find("%s")-1)
			local banned = return_data(l, "banned")
			if (os.time() >= tonumber(banned)) then
				modify_data(plr, "banned", 0)
			end
		end	
	end
end

RegisterTimedEvent("remove_ban_timers", 20000, 0)
		
RegisterServerHook(16, "chat_system")
	