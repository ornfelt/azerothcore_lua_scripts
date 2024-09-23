-- Require the Server Message Handler
require("SMH")

local config = {
	Prefix = "StatPointUI",
	Functions = {
		[1] = "OnFullCacheRequest",
		[2] = "OnSpendPointRequest",
		[3] = "OnStatResetRequest"
	}
}

local StatPointUI = {
	cache = {}
}

function StatPointUI.LoadData(guid)
	local query = CharDBQuery("SELECT `str`, `agi`, `stam`, `int`, `spirit`, `points` FROM character_stats_extra WHERE `guid`="..guid..";");
	if(query) then
		StatPointUI.cache[guid] = {
			query:GetUInt32(0), -- Strength
			query:GetUInt32(1), -- Agility
			query:GetUInt32(2), -- Stamina
			query:GetUInt32(3), -- Intellect
			query:GetUInt32(4), -- Spirit
			query:GetUInt32(5)  -- statpoints
		}
	else
		StatPointUI.cache[guid] = {0, 0, 0, 0, 0, 0};
		CharDBQuery("INSERT INTO character_stats_extra(`guid`, `str`, `agi`, `stam`, `int`, `spirit`, `points`) VALUES ("..guid..", 0, 0, 0, 0, 0, 0);");
	end
end

function StatPointUI.OnLogin(event, player)
	if not(StatPointUI.cache[player:GetGUIDLow()]) then
		StatPointUI.LoadData(player:GetGUIDLow())
	end
	StatPointUI.SetStats(player:GetGUIDLow())
end

function StatPointUI.AddStatPoint(guid)
	local player = GetPlayerByGUID(guid)
	if(player) then
		StatPointUI.cache[guid][6] = StatPointUI.cache[guid][6]+1
		CharDBQuery("UPDATE character_stats_extra SET `points`=`points`+1 WHERE `guid`="..guid..";")
		player:SendServerResponse(config.Prefix, 1, StatPointUI.cache[guid])
	end
end

function StatPointUI.SetStats(guid, stat)
	stat = stat or nil
	local player = GetPlayerByGUID(guid)
	local auras = {7464, 7471, 7477, 7468, 7474}
	if(player) then
		if stat == nil then
			for i = 1, 5 do
				local aura = player:GetAura(auras[i])
				if (aura) then
					aura:SetStackAmount(StatPointUI.cache[guid][i])
				else
					if(StatPointUI.cache[guid][i] > 0) then
						player:AddAura(auras[i], player):SetStackAmount(StatPointUI.cache[guid][i])
					end
				end
			end
		else
			local aura = player:GetAura(auras[stat])
			if (aura) then
				aura:SetStackAmount(StatPointUI.cache[guid][stat])
			else
				if(StatPointUI.cache[player:GetGUIDLow()][stat] > 0) then
					player:AddAura(auras[stat], player):SetStackAmount(StatPointUI.cache[guid][stat])
				end
			end
		end
	end
end

function StatPointUI.ResetStats(guid)
	local player = GetPlayerByGUID(guid)
	local auras = {7464, 7471, 7477, 7468, 7474}
	for _, aura in pairs(auras) do
		player:RemoveAura(aura)
	end
end

function StatPointUI.OnElunaStartup(event)
	-- Re-cache online players' data in case of a hot reload
	for _, player in pairs(GetPlayersInWorld()) do
		StatPointUI.LoadData(player:GetGUIDLow())
	end
end

function StatPointUI.OnPointSpent(guid, stat)
	local inttostr = {"str", "agi", "stam", "int", "spirit"}
	CharDBQuery("UPDATE character_stats_extra SET `"..inttostr[stat].."` = `"..inttostr[stat].."` + 1, `points`=`points`-1 WHERE `guid`="..guid..";")
	StatPointUI.cache[guid][stat] = StatPointUI.cache[guid][stat]+1
	StatPointUI.cache[guid][6] = StatPointUI.cache[guid][6]-1
	StatPointUI.SetStats(guid, stat)
end

function StatPointUI.OnPointsReset(guid)
	local total = 0
	for _, points in pairs(StatPointUI.cache[guid]) do
		total = total+points
	end
	CharDBQuery("UPDATE character_stats_extra SET `str`=0, `agi`=0, `stam`=0, `int`=0, `spirit`=0, `points`="..total.." WHERE `guid`="..guid..";");
	StatPointUI.cache[guid] = {0, 0, 0, 0, 0, total};
	StatPointUI.ResetStats(guid)
end

function OnFullCacheRequest(player, argTable)
	player:SendServerResponse(config.Prefix, 1, StatPointUI.cache[player:GetGUIDLow()])
end

function OnSpendPointRequest(player, argTable)
	if(StatPointUI.cache[player:GetGUIDLow()][6] > 0) then
		-- Double check that the stat requested is actually a valid number
		if(tonumber(argTable[1]) <= 5 and tonumber(argTable[1]) >= 0) then
			StatPointUI.OnPointSpent(player:GetGUIDLow(), argTable[1])
		end
	else
		player:SendBroadcastMessage("You have no points left!")
	end
	player:SendServerResponse(config.Prefix, 1, StatPointUI.cache[player:GetGUIDLow()])
end

function OnStatResetRequest(player, argTable)
	StatPointUI.OnPointsReset(player:GetGUIDLow())
	player:SendServerResponse(config.Prefix, 1, StatPointUI.cache[player:GetGUIDLow()])
end

-- Helper function to add a stat point to the player through other scripts
function Player:AddPoint()
	StatPointUI.AddStatPoint(self:GetGUIDLow())
end

RegisterPlayerEvent(3, StatPointUI.OnLogin)
RegisterServerEvent(33, StatPointUI.OnElunaStartup)
RegisterClientRequests(config)