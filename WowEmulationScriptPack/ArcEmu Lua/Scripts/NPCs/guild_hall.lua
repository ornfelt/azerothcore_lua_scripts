--[[

	TO DO:
	
		Vendor to buy some kind of npc's.

]]--

local p_tbl = {[1] = 1} -- Phases will be stored in here.
local s_tbl = {} -- Guild data will be stored in here.
local n_tbl = { -- Npc coords will be stored in here.
	[16571] = {7319.6, -1534.2, 159.8, 0.48}, -- Guild Npc
	[6740] = {7332.3, -1537.1, 160.6, 0}, -- Innkeeper
	[5193] = {7303.2, -1519.3, 162.8, 5.88}, -- Tabard Designer
	[2456] = {7308.8, -1549.6, 164.6, 0.36} -- Banker
}

local plr_tbl = {} -- To make sure you get phase 1 after leaving.

local guild_hall_coords = {1, 7329.64, -1535.56, 160.2}
local hall_zone = 148

local token_id = cna_token_id

function on_join_hall(_, plr, msg)
	if (msg == "#guild hall enter") then
		if not (CharDBQuery("SELECT * FROM `guild_hall` where `guildname` = '"..plr:GetGuildName().."'")) then
			CharDBQuery("INSERT INTO `guild_hall` (`guildname`, `npcs`) VALUES ('"..plr:GetGuildName().."', '16571')")
		end
		if not (return_phase_by_guild(plr:GetGuildName())) then
			create_hall(plr)
		end
		plr:Teleport(unpack(guild_hall_coords))
		plr:PhaseSet(return_phase_by_guild(plr:GetGuildName()))
		table.insert(plr_tbl, plr)
		return 0;
	elseif (msg == "#guild hall leave") then
		if (plr:GetPhase() >= 2) then
			if (plr:GetTeam() == 0) then
				plr:Teleport(0, -8913, 555, 94)
			elseif (plr:GetTeam() == 1) then
				plr:Teleport(1, 1503, -4415, 22)
			end
			for k, v in pairs(plr_tbl) do
				if (tostring(plr) == tostring(v)) then
					plr_tbl[k] = nil;
				end
			end		
			plr:PhaseSet(1)
		elseif (plr:GetPhase() == 1) then
			plr:SendBroadcastMessage("You aren't in the guild hall.")
		end	
		return 0;
	elseif (msg == "#return guild hall count") then
		plr:SendBroadcastMessage("The are currently "..(#p_tbl - 1).." guild halls active.")
		return 0;
	end	
end

RegisterServerHook(16, "on_join_hall")	
				
function create_hall(plr)
	local query = CharDBQuery("SELECT * FROM `guild_hall`")
	local npc_tbl
	for i=1, query:GetRowCount() do
		if (query:GetColumn(0):GetString() == plr:GetGuildName()) then
			npc_tbl = convert_str(query:GetColumn(1):GetString())
			break;
		end
	end
	local phase = return_phase()
	s_tbl[phase] = {
		guild = plr:GetGuildName(),
		npc = {},
		--creation_time = os.time()
	}
	if (npc_tbl) then
		for _, v in pairs(npc_tbl) do
			for k, coords in pairs(n_tbl) do
				if (tonumber(v) == tonumber(k)) then
					local c = 1
					while (s_tbl[phase].npc[c]) do
						c = c + 1
					end	
					s_tbl[phase].npc[c] = plr:SpawnCreature(k, coords[1], coords[2], coords[3], coords[4], 35, 0)
				end
			end
		end
	elseif not (npc_table) then
		s_tbl[phase].npc[1] = plr:SpawnCreature(16571, 7319.6, -1534.2, 159.8, 0.48, 35, 0)
	end	
	plr:SendBroadcastMessage(s_tbl[phase].guild)
end		

function on_delete_hall()
	for phase, v in pairs(s_tbl) do
		local count = 0
		for _, val in pairs(GetPlayersInArea(hall_zone)) do
			if (val:GetPhase() == phase) then count = count + 1 end
		end
		if (count == 0) then
			if ((os.time() - s_tbl[phase].creation_time) >= 300) then
				for key, val in pairs(s_tbl[phase].npc) do
					val:Despawn(0, 0)
				end
				s_tbl[phase] = nil;
				for key, val in pairs(p_tbl) do
					if (tonumber(val) == tonumber(phase)) then
						p_tbl[key] = nil;
					end
				end
			end
		end
	end
end

--RegisterTimedEvent("on_delete_hall", 5000, 0)

function on_create_hall_after_dc()
	for _, v in pairs(GetPlayersInArea(hall_zone)) do
		if (v:GetPhase() == 1) then
			if not (return_phase_by_guild(v:GetGuildName())) then
				create_hall(v)
			end
			v:PhaseSet(return_phase_by_guild(v:GetGuildName()))
		end	
	end
end

RegisterTimedEvent("on_create_hall_after_dc", 5000, 0)

function on_log_out(_, plr)
	if (plr:GetAreaId() == hall_zone) then
		plr:SendBroadcastMessage("You can't log out in the guild hall, use #guild hall leave first.")
		return 0;
	end	
end		

RegisterServerHook(12, "on_log_out")

function convert_str(str)
	if (not str) or (str == "") then return false; end	
	local sp = 1
	local ep = str:find(",")
	local tbl = {}
	while (ep) do
		table.insert(tbl, str:sub(sp, ep - 1))
		str = str:gsub(str:sub(sp, ep), "")
		ep = str:find(",")
	end	
	table.insert(tbl, str:sub(sp, str:len(str)))
	return tbl;
end

function return_phase()
	local phase
	for k in ipairs(p_tbl) do
		phase = k
	end	
	table.insert(p_tbl, 2^phase)
	return 2^phase;		
end	

function return_phase_by_guild(guild_name)
	for phase in pairs(s_tbl) do
		if (s_tbl[phase].guild == guild_name) then
			return phase;
		end
	end
	return false;
end	

function GetPlayersInArea(area_id)
	local tbl = {}
	for _, v in pairs(GetPlayersInWorld()) do
		if (v:GetAreaId() == area_id) then
			table.insert(tbl, v)
		end
	end
	return tbl;
end	

function on_leave_guild_hall()
	for k, v in pairs(plr_tbl) do
		if not (v:GetAreaId() == hall_zone) then
			v:PhaseSet(1)
			plr_tbl[k] = nil;
		end
	end
end

RegisterTimedEvent("on_leave_guild_hall", 5000, 0)	

function guild_hall_on_talk(pUnit, _, plr)
	if not (CharDBQuery("SELECT * FROM `guild_hall` where `guildname` = '"..plr:GetGuildName().."'")) then
		CharDBQuery("INSERT INTO `guild_hall` (`guildname`, `npcs`) VALUES ('"..plr:GetGuildName().."', '16571')")
	end
	pUnit:GossipCreateMenu(1, plr, 0)
	pUnit:GossipMenuAddItem(1, "Bank.", 2456, 0)
	--pUnit:GossipMenuAddItem(1, "Vendor.", id, 0)
	pUnit:GossipMenuAddItem(1, "Tabard Designer.", 5193, 0)
	pUnit:GossipMenuAddItem(1, "Innkeeper.", 6740, 0)
	--pUnit:GossipMenuAddItem(1, "Blacksmith.", id, 0)
	--pUnit:GossipMenuAddItem(1, "Mount vendor.", id, 0)
	--pUnit:GossipMenuAddItem(1, "Taxi.", id, 0)
	--pUnit:GossipMenuAddItem(1, "Tabard vendor.", id, 0)
	--pUnit:GossipMenuAddItem(1, "Shirt vendor.", id, 0)
	pUnit:GossipMenuAddItem(1, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(plr)
end		

function guild_hall_on_select(pUnit, _, plr, _, intid)
	local query = CharDBQuery("SELECT * FROM `guild_hall`")
	local npc_tbl
	for i=1, query:GetRowCount() do
		if (query:GetColumn(0):GetString() == plr:GetGuildName()) then
			npc_tbl = convert_str(query:GetColumn(1):GetString())
			break;
		end
		query:NextRow()
	end
	for _, v in pairs(npc_tbl) do
		if (tonumber(v) == tonumber(intid)) then
			plr:SendBroadcastMessage("You have already bought this npc.")
			return pUnit:GossipSendMenu(plr);
		end
	end
	for id, coords in pairs(n_tbl) do
		if (id == intid) then
			plr:SpawnCreature(id, coords[1], coords[2], coords[3], coords[4], 35, 0)
			local str
			for i=1, query:GetRowCount() do
				if (query:GetColumn(0):GetString() == plr:GetGuildName()) then
					str = query:GetColumn(1):GetString()
					str = str..", "..intid
				end
				query:NextRow()
			end
			CharDBQuery("UPDATE `guild_hall` SET `npcs` = '"..str.."' WHERE `guildname` = '"..plr:GetGuildName().."'")
		end
	end
	plr:GossipComplete()
end

RegisterUnitGossipEvent(16571, 1, "guild_hall_on_talk")
RegisterUnitGossipEvent(16571, 2, "guild_hall_on_select")

			