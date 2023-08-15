local pvp = {}
local pvp_mt = {}

local token_id = 90007

local ks_tbl = {
	[10] = 10,
	[20] = 15,
	[30] = 20,
	[40] = 30,
	[50] = 50
};

local token_tbl = {
	[1] = {kill_streak = 10, reward = 1},
	[2] = {kill_streak = 20, reward = 4},
	[3] = {kill_streak = 30, reward = 5},
	[4] = {kill_streak = 40, reward = 8},
	[5] = {kill_streak = 50, reward = 10}
};

local ann_tbl = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100};	

function pvp_mt:Create(plr, victim)			
	local obj = {
		plr = plr,
		last_killed = victim,
		last_killed_count = 1,
		kill_streak = 1
	};
	self.__index = self
	setmetatable(obj, self)
	return obj;
end

function Update(plr, victim)
	for k, v in pairs(pvp) do
		if (k == tostring(plr)) then
			if (tostring(pvp[k].last_killed) == tostring(victim)) then
				if (pvp[k].last_killed_count == 3) then return false; end	
				pvp[k].last_killed_count = pvp[k].last_killed_count + 1
			elseif not (tostring(pvp[k].last_killed) == tostring(victim)) then	
				pvp[k].last_killed = victim
			end	
			pvp[k].kill_streak = pvp[k].kill_streak + 1
		elseif (k == tostring(victim)) then
			pvp[k].kill_streak = 0
		end
	end
	if not (pvp[tostring(plr)]) then
		pvp[tostring(plr)] = pvp_mt:Create(plr, victim)
	end
	return true;
end

function on_trigger_pvp_system(_, plr, victim)
	-- Checking if the player didn't kill himself.
	if (plr:GetName() == victim:GetName()) then return; end

	-- Updating killstreak info.
	local update = Update(plr, victim)
	local kill_streak = pvp[tostring(plr)].kill_streak
	
	-- Sending messages.
	plr:SendBroadcastMessage("You have killed player: |cFF90EE90"..victim:GetName().."")
	if (update) then
		plr:SendBroadcastMessage("Killstreak: |cFF90EE90"..kill_streak.."")
	elseif not (update) then
		plr:SendBroadcastMessage("Your killstreak remains: |cFF90EE90"..kill_streak.."")
	end	
	victim:SendBroadcastMessage("You have been killed by: |cFF90EE90"..plr:GetName().."")
	
	-- Rewarding player.
	if not (update) then return; end
	for k, v in pairs(ks_tbl) do
		if (kill_streak == k) then
			plr:AddItem(token_id, v)
		end
	end
	local found
	for k, v in ipairs(token_tbl) do
		if (v.kill_streak > kill_streak) then
			plr:AddItem(token_id, token_tbl[k].reward)
			found = true; break;
		end	
	end
	
	-- Plr has a killstreak beyond 50.
	if not (found) then
		plr:AddItem(token_id, 12)
	end
	
	-- Checking for an announce.
	for _, v in pairs(ann_tbl) do
		if (kill_streak == v) then
			for _, world in pairs(GetPlayersInWorld()) do
				world:SendBroadcastMessage("|cFFADD8E6[PvP System]: |cFFFFFF00"..plr:GetName().." is on a "..kill_streak.." killstreak.") 
			end
		end
	end
end

RegisterServerHook(2, "on_trigger_pvp_system")