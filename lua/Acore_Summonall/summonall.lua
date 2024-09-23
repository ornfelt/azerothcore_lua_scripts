--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 29/01/2021
-- Time: 21:34
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module

maps = {}

-- Summoning your party is allowed on the maps listed below. You can add more by providing
-- the related map id in its own line. Find map ids e.g. in ./data/map.dbc

-- Eastern kingdoms
table.insert(maps, 0)
-- Kalimdor
table.insert(maps, 1)
-- Outland
table.insert(maps, 530)
-- Northrend
table.insert(maps, 571)

------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------

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
		if has_value(maps, mapId) then
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
