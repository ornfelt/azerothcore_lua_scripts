SummonAllModule = {}

SummonAllModule.maps = {}

-- Eastern kingdoms
table.insert(SummonAllModule.maps, 0)
-- Kalimdor
table.insert(SummonAllModule.maps, 1)
-- Outland
table.insert(SummonAllModule.maps, 530)
-- Northrend
table.insert(SummonAllModule.maps, 571)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local function summonAll(event, player, command, chatHandler)
	if command == 'summonall' then
		if player == nil then
			chatHandler:SendSysMessage('summonall can not be used from the console.')
		end
		mapId = player:GetMapId()
		--allow to proceed if the player is on one of the maps listed above
		if has_value(SummonAllModule.maps, mapId) then
			--allow to proceed if the player is not in combat
			if not player:IsInCombat() then
				group = player:GetGroup()
				groupPlayers = group:GetMembers()
				for _, v in pairs(groupPlayers) do
					if v ~= player then
						v:SummonPlayer(player)
					end
				end
			else
				chatHandler:SendSysMessage("Summoning is not possible in combat.")
			end
			return false
		else
			chatHandler:SendSysMessage("Summoning is not possible here.")
		end
		return false
	end
end

RegisterPlayerEvent(42, summonAll)
