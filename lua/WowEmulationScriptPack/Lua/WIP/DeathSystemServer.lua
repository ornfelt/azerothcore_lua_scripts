-- Owner: grimreapaa

local AIO = AIO or require("AIO")
local DeathHandlers = AIO.AddHandlers("DeathStuff", {})

-- TO DO:
-- work on `.ban execute` function,


-- time required to execute from player. default: 64800 (18 hrs)
-- REQUIRED_TIME = 64800
-- currently 15 hours = 43200
REQUIRED_TIME = 54000

-- equal and above account levels can use `.ban execute`
ACCOUNT_LEVEL = 3

-- the role_id that is mentioned from injury/deathsystem messages. if user, change & to !
ROLE_ID = "&621758566667386887" -- wake team
--ROLE_ID = "!153737236821704704" -- grimreapaa

-- CURRENCY IDS
SILVER_COIN = 1999999
COPPER_COIN = 1999997
GOLD_COIN = 1999998

-- SISTER SVALNA CREATURE ID
SISTER_SVALNA = 1000028

-- ADMIN RANK FOR BYPASSING EXECUTE TIME REQUIREMENT
ADMIN_RANK = 3

-- death broadcast to GMs and discord
local function DeathBroadcast(killer, killed, action)
	message = ("|cffFF0000[Death System]|r: |cff66ffcc" ..killer:GetName().. "|r has " ..tostring(action).. " |cff66ffcc" ..killed:GetName().. "|r.")
	discordmessage = ("[Death System]: " ..killer:GetName().. " has " ..tostring(action).. " " ..killed:GetName().. ".")
	SendToDiscordAlert(tostring(discordmessage))
	GMBroadcast(message)
end
-- steal broadcast to GMs and discord
local function StealBroadcast(killer, killed, action, gold_amount, silver_amount, copper_amount)
    moneymessage = (" Stole coins: " .. gold_amount .. " gold, " .. silver_amount .. " silver and " .. copper_amount .. " copper.")
	message = ("|cffFF0000[Death System]|r: |cff66ffcc" ..killer:GetName().. "|r has " ..tostring(action).. " |cff66ffcc" ..killed:GetName().. "|r.")
	discordmessage = ("[Death System]: " ..killer:GetName().. " has " ..tostring(action).. " " ..killed:GetName().. "." .. moneymessage)
	SendToDiscordAlert(tostring(discordmessage))
	GMBroadcast(message)
end

-- confirm execute
function DeathHandlers.ExecuteConfirm(player, action)
	local ExecuteConfirm_Query1 = CharDBQuery("SELECT accid FROM `character_execute_ban` WHERE accid = " ..player:GetAccountId().. ";")
	target = player:GetSelection()
	if (ExecuteConfirm_Query1 ~= nil) then
		player:SendBroadcastMessage("You are banned from this action.")
		return false
	elseif (target == nil) then
		--player SHOULD have a target unless manipulating the aio client.
		player:SendBroadcastMessage("You must have a target. Wait a minute, how did you get this error?")
		return false
	elseif (target == player) then
		player:SendBroadcastMessage("You cannot target yourself.")
		return false
	elseif (target:ToPlayer() == nil) then
		player:SendBroadcastMessage("You must target a player.")
		return false
	elseif (target:HasAura(2000002) == false) then
		player:SendBroadcastMessage("Your target must be death stunned.")
		return false
	elseif (player:HasAura(2000002) == true) then
		player:SendBroadcastMessage("You cannot be death stunned yourself.")
		return false
	elseif (target:IsWithinDistInMap(player, 2) == false) then
		player:SendBroadcastMessage("You must be closer to your target.")
		return false
		--checked clientside but can be triggered by logic exploit
	elseif (player:IsInCombat() == true) then
		player:SendBroadcastMessage("You cannot be in combat.")
		return false
		--also checked clientside but can be triggered by logic exploit
	elseif (player:HasAura(1784) == true) then
		player:SendBroadcastMessage("You cannot be in stealth.")
		return false
	elseif (action == "freed") then
		target:RemoveAura(2000002)
		DeathBroadcast(player, target, action)
		player:SendBroadcastMessage("|cffFF0000[Death System]|r: You have " ..action.. " |cff66ffcc" ..target:GetName().. "|r.")
		target:SendBroadcastMessage("|cffFF0000[Death System]|r: You have been " ..action.. " by |cff66ffcc" ..player:GetName().. "|r.")
		target:SetHealth(1)
		return false
	elseif (player:GetGroup() ~= nil) and (target:GetGroup() ~= nil) and (target:GetGroup() == player:GetGroup()) then
		player:SendBroadcastMessage("Your target cannot be in your group.")
		return false
	elseif (player:GetTotalPlayedTime() <= REQUIRED_TIME) and (player:GetGMRank() < ADMIN_RANK) then
		player:SendBroadcastMessage("You do not have enough /played time to " ..action.. ".")
		return false
	elseif (action == "stole") then
		silver_amount = target:GetItemCount(SILVER_COIN)
		copper_amount = target:GetItemCount(COPPER_COIN)
		gold_amount = target:GetItemCount(GOLD_COIN)
        StealBroadcast(player, target, "robbed", gold_amount, silver_amount, copper_amount)
		player:AddItem(SILVER_COIN, silver_amount)
		player:AddItem(COPPER_COIN, copper_amount)
		player:AddItem(GOLD_COIN, gold_amount)
		target:RemoveItem(SILVER_COIN, silver_amount)
		target:RemoveItem(COPPER_COIN, copper_amount)
		target:RemoveItem(GOLD_COIN, gold_amount)
		player:SendBroadcastMessage("|cffFF0000[Death System]|r: You " ..action.. " "  ..gold_amount.. " " ..GetItemLink(GOLD_COIN).. ", " ..silver_amount.. " " ..GetItemLink(SILVER_COIN).. ", " ..copper_amount.. " " ..GetItemLink(COPPER_COIN).. " from " ..target:GetName().. ".")
		target:SendBroadcastMessage("|cffFF0000[Death System]|r: " ..player:GetName().. " " ..action.. " "  ..gold_amount.. " " ..GetItemLink(GOLD_COIN).. ", " ..silver_amount.. " " ..GetItemLink(SILVER_COIN).. ", " ..copper_amount.. " " ..GetItemLink(COPPER_COIN).. " from you.")
		action = action.. " " ..silver_amount.. " SILVER, " ..copper_amount.. " COPPER, " ..gold_amount.. " GOLD"
		WorldDBExecute("INSERT INTO `elunacharacters`.`character_execute` (`attacker_name`, `attacker_account`, `a_x`, `a_y`, `a_z`, `a_o`, `victim_name`, `victim_account`, `v_x`, `v_y`, `v_z`, `v_o`, `map`, `action`, `timestamp`) VALUES ('" ..player:GetName().. "', '" ..player:GetAccountId().. "', '" ..player:GetX().. "', '" ..player:GetY().. "', '" ..player:GetZ().. "', '" ..player:GetO().. "', '" ..target:GetName().. "', '" ..target:GetAccountId().. "', '" ..target:GetX().. "', '" ..target:GetY().. "', '" ..target:GetZ().. "', '" ..target:GetO().. "', '" ..player:GetMapId().. "', '" ..action.. "', '" ..tostring(GetGameTime()).. "');")
		AIO.Handle(player, "DeathStuff", "TakeScreenShot")
		AIO.Handle(target, "DeathStuff", "TakeScreenShot")
		return false
	-- we have checked if banned, if target, if target=player, if target is a player, if target has death stun, if target is in group, if target is in range, if player in combat, if player in stealth, played time
	else
--		action = "executed"
		DeathBroadcast(player, target, action)
		player:SendBroadcastMessage("|cffFF0000[Death System]|r: You have executed |cff66ffcc" ..target:GetName().. "|r.")
		target:SendBroadcastMessage("|cffFF0000[Death System]|r: You have been executed by |cff66ffcc" ..player:GetName().. "|r.")
		target:RemoveAura(2000002)
		--ToCorpse() is broken. used to work as CreateCorpse() but update broke it looks like. we keep it in cause why tf not.
		--target:Kill(target)
		--target:ToCorpse()
		AwardAchievement(target, 65517)
		AwardAchievement(player, 65515)
		target:CreateCorpse()
		target:SpawnBones()
		target:ResurrectPlayer(100)
		-- teleport to coords of graveyard
		target:Teleport(36, -1843.2357, 976.8452, 934.3845, 1.5708)
		target:AddAura(2000008, target)
--		PerformIngameSpawn(2, 509483, target:GetMapId(), 0, target:GetX(), target:GetY(), target:GetZ(), target:GetO(), true)
		WorldDBExecute("INSERT INTO `elunacharacters`.`character_execute` (`attacker_name`, `attacker_account`, `a_x`, `a_y`, `a_z`, `a_o`, `victim_name`, `victim_account`, `v_x`, `v_y`, `v_z`, `v_o`, `map`, `action`, `timestamp`) VALUES ('" ..player:GetName().. "', '" ..player:GetAccountId().. "', '" ..player:GetX().. "', '" ..player:GetY().. "', '" ..player:GetZ().. "', '" ..player:GetO().. "', '" ..target:GetName().. "', '" ..target:GetAccountId().. "', '" ..target:GetX().. "', '" ..target:GetY().. "', '" ..target:GetZ().. "', '" ..target:GetO().. "', '" ..player:GetMapId().. "', '" ..action.. "', '" ..tostring(GetGameTime()).. "');")
		AIO.Handle(player, "DeathStuff", "TakeScreenShot")
		AIO.Handle(target, "DeathStuff", "TakeScreenShot")
	end
end


-- function that attempts to make a transition between death and tp for pve deaths
local function PvE_Death(eventid, delay, repeats, killed)
	killed:Teleport(36, -1843.2357, 976.8452, 934.3845, 1.5708)
	killed:AddAura(2000003, killed)
	killed:RemoveAura(2000002)
	return false
end

-- apply death stun on pvp kill
local function DeathStun(event, killer, killed)
	-- if killer is not a player and has no owner (pet situation), tp to death zone.
	if not(killer:GetOwner()) and (killer:ToPlayer() == nil) then
		killed:SendBroadcastMessage("|cffFF0000[Death System]|r: You have died to the wilderness.")
		killed:ResurrectPlayer(1, false)
		killed:AddAura(2000002, killed)
		killed:RegisterEvent(PvE_Death, 5000, 1)
	else
		killed:ResurrectPlayer(1, false)
		killed:AddAura(2000002, killed)
		killed:AddAura(2000003, killed)
		action = "death stunned"
		DeathBroadcast(killer, killed, action)
	end
end

-- on zone update, see if a death player somehow escaped and teleport them back to prevent hackers
local function DeathCheck(event, player, newZone, newArea)
	if (player:HasAura(2000008) == false) then
		return false
	elseif (player:GetZoneId() == 5000) then
		return false
	else
		player:Teleport(36, -1843.2357, 976.8452, 934.3845, 1.5708)
	end
end


-- syntax: .execute ban <accid> "<reason>" 
-- reason is anything after accid.
local function ExecuteBan(event, player, command)
	if (command:find("execute") ~= 1) then
		return
	elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
		return
	else
		local parameters = {}
		local parameters = getCommandParameters(command)
		-- does the second argument exist? =ban? =unban?
		if (parameters[2] == nil) or (parameters[2] ~= "ban") and (parameters[2] ~= "unban") then
			player:SendBroadcastMessage("The command uses the following subcommands:\nunban\nban")
			return false
		elseif (parameters[3] == nil) and (parameters[2] == "unban") then
			player:SendBroadcastMessage("The command takes the following syntax: `.execute unban <accid>`")
			return false
		elseif (parameters[3] == nil) and (parameters[2] == "ban") then
			player:SendBroadcastMessage("The command takes the following syntax: `.execute ban <accid> <reason>` reason being anything after the account ID.")
			return false
		end
		
		local ExecuteBan_Query1 = CharDBQuery("SELECT reason FROM `character_execute_ban` WHERE accid = " ..parameters[3].. ";")
		local ExecuteBan_Query2 = AuthDBQuery("SELECT username FROM `account` WHERE id = " ..parameters[3].. ";")
		parameters[3] = sterilize.generic(parameters[3])
		if (parameters[2] == "ban") then
			command = string.gsub(command,"execute ban","")
			command = string.gsub(command,parameters[3],"")
			-- now command = reason. sterilize.
			command = sterilize.generic(command)
			local ExecuteBan_Query1 = CharDBQuery("SELECT reason FROM `character_execute_ban` WHERE accid = " ..parameters[3].. ";")
			if (ExecuteBan_Query1 ~= nil) then
				player:SendBroadcastMessage("The account " ..parameters[3].. " is already banned for " ..ExecuteBan_Query1:GetString(0).. ";")
				return false
			elseif (parameters[4] == nil) then
				player:SendBroadcastMessage("You must have a reason to ban an account. Anything after the account ID is the reason.")
				return false
			elseif (ExecuteBan_Query2 == nil) then
				player:SendBroadcastMessage("You must enter a valid account ID.")
				return false
			else
				CharDBExecute("INSERT INTO `elunacharacters`.`character_execute_ban` (`accid`, `acc_name`, `gm_id`, `reason`) VALUES ('" ..parameters[3].. "', '" ..ExecuteBan_Query2:GetString(0).. "', '" ..player:GetAccountId().. "', '" ..tostring(command).. "');")
				discordmessage = ("[Death System]: <@" ..ROLE_ID.. "> " ..player:GetAccountName().. " has banned the account " ..parameters[3].. ":" ..ExecuteBan_Query2:GetString(0).. " for reason:" ..tostring(command).. ".")
				message = ("|cffFF0000[Death System]|r: " ..player:GetAccountName().. " has banned the account " ..parameters[3].. ":" ..ExecuteBan_Query2:GetString(0).. " for reason:" ..tostring(command).. ".")
				SendToDiscordAlert(discordmessage)
				GMBroadcast(message)
				return false
			end
		elseif (parameters[2] == "unban") then
			if (ExecuteBan_Query1 == nil) then
				player:SendBroadcastMessage("That account is not banned.")
				return false
			else
				CharDBExecute("DELETE FROM `character_execute_ban` WHERE accid = " ..parameters[3].. ";")
				discordmessage = ("[Death System]: <@" ..ROLE_ID.. "> " ..player:GetAccountName().. " has unbanned the account " ..parameters[3].. ":" ..ExecuteBan_Query2:GetString(0).. ".")
				message = ("|cffFF0000[Death System]|r: " ..player:GetAccountName().. " has unbanned the account " ..parameters[3].. ":" ..ExecuteBan_Query2:GetString(0).. ".")
				SendToDiscordAlert(discordmessage)
				GMBroadcast(message)
				return false
			end
		end
	end
end


-- get coin amount on UI when clicking steal
function DeathHandlers.StealGetInfo(player)
	target = player:GetSelection()
	silver_amount = target:GetItemCount(SILVER_COIN)
	copper_amount = target:GetItemCount(COPPER_COIN)
	gold_amount = target:GetItemCount(GOLD_COIN)
	AIO.Handle(player, "DeathStuff", "POPUP_STEAL", gold_amount, silver_amount, copper_amount)
	print("sending info")
end

-- SISTER SVALNA gear token redemption
local function SvalnaHello(event, player, creature)
	if player:HasAura(2000008) == true then
		player:GossipMenuAddItem(0, "I'd like to submit myself to the realm of death.", 65022, 1)
		player:GossipMenuAddItem(0, "Nevermind.", 65022, 0)
	else
		player:GossipMenuAddItem(0, "I have souls to redeem.", 65022, 2)
		player:GossipMenuAddItem(0, "You terrify me. I'd like to go now.", 65022, 0)
	end
	
	player:GossipSendMenu(65022, creature, MenuId)
end

local function SvalnaSelect(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	player:GossipComplete()
	if (intid == 0) then
		return false
	end
	
	local Svalna_Query2 = WorldDBQuery("SELECT `value_1` FROM `eluna_counters` WHERE `value_2` = " ..player:GetAccountId().. " AND `script_name` = 'WageCuckServer.lua - Death Redemption';")
	
	if (intid == 1) then
		local Svalna_Query1 = WorldDBQuery("SELECT `value_1` FROM `eluna_counters` WHERE `value_2` = " ..player:GetGUIDLow().. " AND `script_name` = 'WageCuckServer.lua';")
		if Svalna_Query1 == nil then
			player:SendBroadcastMessage("Something broke. You do not have a wage counter.")
			return false
		elseif Svalna_Query1:GetInt32(0) == 0 then
			player:SendBroadcastMessage("You have already sacrificed your gear tokens on this character.")
			return false
		else
			local token_amount = math.floor(Svalna_Query1:GetInt32(0) * 0.75)
			AIO.Handle(player, "DeathStuff", "POPUP_SVALNA", token_amount)
		end
	elseif (intid == 2) then
		if Svalna_Query2 == nil then
			player:SendBroadcastMessage("You do not have any souls to redeem.")
		elseif (player:HasAchieved(65530) == true) then
			player:SendBroadcastMessage("Redemption is only permitted for new characters.")
		else
			local token_amount = Svalna_Query2:GetInt32(0)
			player:AddItem(1999996, token_amount)
			WorldDBExecute("DELETE FROM `eluna_counters` WHERE `value_2` = " ..player:GetAccountId().. " AND `script_name` = 'WageCuckServer.lua - Death Redemption';")
			player:SendBroadcastMessage("You have acquired " ..token_amount.. " gear tokens from previous lives.")
		end
	end
end

-- flavor for after 10 seconds, do cool shit
local function SvalnaFlavor(eventid, delay, repeats, svalna)
	svalna:SendUnitSay("It is done.", 0)
end

local function SvalnaFlavor_player(eventid, delay, repeats, player)
	player:RemoveAura(9454)
	player:RemoveAura(58012)
	player:CastSpell(player, 40387)
	player:CastSpell(player, 39180)
end

-- the aio confirmation listener
function DeathHandlers.SvalnaConfirm(player)
	local Svalna_Query1 = WorldDBQuery("SELECT `value_1` FROM `eluna_counters` WHERE `value_2` = " ..player:GetGUIDLow().. " AND `script_name` = 'WageCuckServer.lua';")
	local Svalna_Query2 = WorldDBQuery("SELECT `value_1` FROM `eluna_counters` WHERE `value_2` = " ..player:GetAccountId().. " AND `script_name` = 'WageCuckServer.lua - Death Redemption';")
	local token_amount = math.floor(Svalna_Query1:GetInt32(0) * 0.75)
	player:SendBroadcastMessage(token_amount)
	if Svalna_Query2 == nil then
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_counters` (`value_1`, `value_2`, `script_name`) VALUES ('" ..token_amount.. "', '" ..player:GetAccountId().. "', 'WageCuckServer.lua - Death Redemption');")
	else
		WorldDBExecute("UPDATE `eluna_counters` SET `value_1` = `value_1` + " ..token_amount.. " WHERE `value_2` = " ..player:GetAccountId().. " AND `script_name` = 'WageCuckServer.lua - Death Redemption';")
	end
	WorldDBExecute("UPDATE `eluna_counters` SET `value_1` = 0 WHERE `value_2` = " ..player:GetGUIDLow().. " AND `script_name` = 'WageCuckServer.lua';")
	
	
	local svalna = player:GetNearestCreature(10, SISTER_SVALNA)
	svalna:SendUnitSay("This will rupture your very soul, " ..player:GetName().. ".", 0)
	player:AddAura(9454, player)
	svalna:CastSpell(player, 58012)
	svalna:RegisterEvent(SvalnaFlavor, 10000, 1)
	player:RegisterEvent(SvalnaFlavor_player, 10000, 1)
end
-- END SISTER SVALNA

RegisterPlayerEvent(42, ExecuteBan)
RegisterPlayerEvent(27, DeathCheck)
RegisterPlayerEvent(6, DeathStun)
RegisterPlayerEvent(8, DeathStun)
RegisterCreatureGossipEvent(SISTER_SVALNA, 1, SvalnaHello)
RegisterCreatureGossipEvent(SISTER_SVALNA, 2, SvalnaSelect)