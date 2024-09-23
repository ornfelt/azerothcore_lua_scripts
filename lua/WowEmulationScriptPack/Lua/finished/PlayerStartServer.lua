-- Owner: grimreapaa

-- AIO is defined here. Require requires the file/folder.
local AIO = AIO or require("AIO")
local PlayerStartHandlers = AIO.AddHandlers("PStart", {})

-- define mapid of spark
SPARK_ID = 36

-- admin rank to bypass version check
ADMIN_RANK = 3

-- list of accounts from last phase
local legacy_accounts = {60,30,37,68,31,55,28,49,56,44,58,41,65,33,35,34,67,51,29,24,38,27,66,48,26,32,39,52,59,13}

-- skin IDs and their reps associated
local skin_reps_male = {
}

local skin_reps_female = {
--	[10] = {10, 11, 12, 13, 14}, -- high elf
}

-- race = {{factionid, amount}, {factionid, amount}}
local skin_reps_faction = {
--	[10] = {{}, { }},
}

local function PlayerLogin(event, player)
	-- inflation for update
--[[
	local InflateQuery = WorldDBQuery("SELECT `value_1` FROM `eluna_counters` WHERE `script_name` = 'PlayerStartServer.lua - InflateQuery' AND `value_1` = " ..player:GetGUIDLow().. ";")
	if InflateQuery == nil then
		local old_money = GetCurrency(player)
		local new_money = old_money * 15
		ChangeCurrency(player, new_money)
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_counters` (`value_1`, `script_name`) VALUES ('" ..player:GetGUIDLow().. "', 'PlayerStartServer.lua - InflateQuery');")
		PrintInfo("Player " ..player:GetName().. " logged in and got inflated from " ..old_money.. " to " ..new_money.. ".")
	end
]]

	-- on login, if has wake: red chapter, give veteran + donkey
	if player:HasAchieved(65530) == false then
		return
	else
		local Legacy_Query2 = WorldDBQuery("SELECT `value_1` FROM `eluna_counters` WHERE `script_name` = 'PlayerStartServer.lua - Red Chapter' AND `value_1` = " ..player:GetAccountId().. ";")
		if Legacy_Query2 ~= nil then
			return
		else
			WorldDBExecute("INSERT INTO `elunaworld`.`eluna_counters` (`value_1`, `script_name`) VALUES ('" ..player:GetAccountId().. "', 'PlayerStartServer.lua - Red Chapter');")
			player:AddItem(1999993, 1) -- donkey saddle
			player:SetKnownTitle(225) -- veteran title
			player:SendBroadcastMessage("Thank you for attending our last phase. Your reward for your heroic deeds is a donkey and a title!")
		end
	end
end

function PlayerLogin_First(event, player)
	-- send AIO handle to /sleep
	AIO.Handle(player, "PStart", "OnFirst")
	player:AddItem(1999940, 14) -- starter tokens, given here instead so we can run a query to set at_login flags to 32 and properly redistribute wealth.
	player:LearnSpell(43944) -- beer goggles 
	player:LearnSpell(2000007) -- summon warpweaver
	player:LearnSpell(59752) -- human racial trinket
	player:LearnSpell(33389) -- learn apprentice (75) riding
	player:LearnSpell(33392) -- learn journeyman (150) riding
	-- tremendous spirit racial for humans. DB entry did not seem to work.
	if (player:GetRace() == 1) then
		player:LearnSpell(55915)
		player:RemoveSpell(67596)
	end
	
	-- eluna_playercreateinfo_reputation SUPPORT
	local Eluna_PlayerCreateInfo_Reputation_Query1 = WorldDBQuery("SELECT `faction`,`value` FROM `eluna_playercreateinfo_reputation` WHERE `race` = '" ..player:GetRace().. "';")
	if Eluna_PlayerCreateInfo_Reputation_Query1 ~= nil then
		for m=1,Eluna_PlayerCreateInfo_Reputation_Query1:GetRowCount(),1 do
			local faction_id = Eluna_PlayerCreateInfo_Reputation_Query1:GetInt32(0)
			local reputation_value = Eluna_PlayerCreateInfo_Reputation_Query1:GetInt32(1)
			player:SetReputation(faction_id, reputation_value)
			Eluna_PlayerCreateInfo_Reputation_Query1:NextRow()
		end
	end
	
	
	
	-- cool thing here to distribute items to legacy player accounts
--	for x=1,#legacy_accounts,1 do
--		if player:GetAccountId() == x then
--			AwardAchievement(player, 65521)
--			local LegacyAccountQuery1 = WorldDBQuery("SELECT value_1 FROM `eluna_counters` WHERE script_name = 'PlayerStartServer.lua' AND value_1 = " ..player:GetAccountId().. ";")
--			if (LegacyAccountQuery1 ~= nil) then
--				return
--			else
--				player:AddItem(1999993)
--				WorldDBExecute("INSERT INTO `elunaworld`.`eluna_counters` (`value_1`, `script_name`) VALUES ('" ..player:GetAccountId().. "', 'PlayerStartServer.lua');")
--				player:SendBroadcastMessage("Wake would like to thank your contribution to Sholazar with a donkey mount! Enjoy")
--			end
--		end
--	end

	
	-- here we apply reputations based on skins
	--[[
	if player:GetGender() == 0 and skin_reps_male[player:GetRace()] ~= nil then
		
	end
	]]
end

local function Kick(eventid, delay, repeats, player)
	player:KickPlayer()
end

function PlayerStartHandlers.VersionCheck(player, build, CURRENT_VERSION)
	player:SendBroadcastMessage("Incorrect game version. Your client is " ..build.. " and the server is on " ..CURRENT_VERSION..". You will be kicked in 60 seconds. Please see #announcements or #dev-updates for more information.")
	if (player:GetGMRank() >= ADMIN_RANK) then
		player:SendBroadcastMessage("Because your account rank is higher than " ..ADMIN_RANK.. " you will not be kicked.")
		return false
	else
		player:RegisterEvent(Kick, 60000, 1)
		PrintInfo("[Version Check]: " ..player:GetName().. " has incorrect game version and will be kicked in 60 seconds.")
		return false
	end
end

RegisterPlayerEvent(30, PlayerLogin_First)
-- RegisterServerEvent(33, PlayerLogin_StartUp)
RegisterPlayerEvent(3, PlayerLogin)