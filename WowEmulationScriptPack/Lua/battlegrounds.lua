-- Configuration

local Lives = 50 -- The amount of lives each team has
local HordeLives = 50 -- The amount of lives to start with
local AllianceLives = 50 -- The amount of lives to start with

local RequiredPlayersTable = 2 -- The amount of PlayersTable required to start the battleground (THIS IS NOT PER TEAM, THIS IS TOTAL)

local RewardID = 0 -- Change this to a value to add 1 of them to all of the winning team - leave as 0 for no reward

local BroadcastKills = true -- Set this to false if you do not want kills to be broadcasted to the rest of the BG

-- Battleground Start Locations
local AMap, AX, AY, AZ = 1, 16223, 16265, 15 -- Map, x, y, z for Alliance
local HMap, HX, HY, HZ = 1, 16223, 16265, 15 -- Map x, y, z for Horde

-- Where to teleport once battleground ends
local HomeMA, HomeXA, HomeYA, HomeZA = 1, 0, 0, 0 -- Map, x, y, Z for Alliance
local HomeMH, HomeXH, HomeYH, HomeZH = 1, 0, 0, 0 -- Map, X, Y, Z for Horde

----------------------------------------------------------------------------------------------------------
-- Do Not Touch Below This Line Unless You Know What Your Doing P.S. Starting Letters With Caps Is Cool --
----------------------------------------------------------------------------------------------------------
-- Just don't touch
local PlayersTable = {}
local Horde = {}
local Alliance = {}
local InGame = false

-- Do not touch unless you know what your doing
local message = 4
local CountDown = 60

-- Only touch this if you are not using 3.3.5a, find the right values in Opcodes.h
local SMSG_INIT_WORLD_STATES = 0x2C2
local SMSG_UPDATE_WORLD_STATE = 0x2C3

local function Game_Start_Battleground_Countdown()
	CountDown = CountDown - 10
	for place, plrs in pairs(PlayersTable) do
		if CountDown == 0 then
			if plrs ~= nil then
				GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00The battle has begun!")
				GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00The battle has begun!")
				GetPlayerByGUID(plrs):PlayDirectSound(6077) -- War music
				-- Update people left
				local pack = CreatePacket(SMSG_INIT_WORLD_STATES, 18) -- HORDE
				pack:WriteULong(1) -- Map
				pack:WriteULong(1377) -- Zone
				pack:WriteULong(0)
				pack:WriteUShort(2)
				pack:WriteULong(0) -- ID
				pack:WriteULong(1) -- Value
				pack:WriteULong(0) -- ID
				pack:WriteULong(1) -- Value
				GetPlayerByGUID(plrs):SendPacket(pack)
				local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
				pack:WriteULong(2317) -- ID, total
				pack:WriteULong(Lives) -- Value
				GetPlayerByGUID(plrs):SendPacket(pack)
				local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
				pack:WriteULong(2314) -- ID
				pack:WriteULong(HordeLives) -- Amount, Horde
				GetPlayerByGUID(plrs):SendPacket(pack)		
				local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
				pack:WriteULong(2313) -- ID
				pack:WriteULong(AllianceLives) -- Amount, Alliance
				GetPlayerByGUID(plrs):SendPacket(pack)
				--
			end
		else
			if plrs ~= nil then
				GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00The battleground will begin in "..CountDown.." seconds!")
				GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00The battleground will begin in "..CountDown.." seconds!")
			end
		end
	end
end

function ProcessQueForBattleground()
	if InGame == false then
        if PlayersTable ~= nil then
            if #PlayersTable >= RequiredPlayersTable then
                InGame = true
                local team = 0
                for place, plrs in pairs(PlayersTable) do -- Randomly make PlayersTable join alliance/horde teams rather than horde vs alliance
                    -- Update people left
                    local pack = CreatePacket(SMSG_INIT_WORLD_STATES, 18) -- HORDE
                    pack:WriteULong(1) -- Map
                    pack:WriteULong(1377) -- Zone
                    pack:WriteULong(0)
                    pack:WriteUShort(2)
                    pack:WriteULong(0) -- ID
                    pack:WriteULong(1) -- Value
                    pack:WriteULong(0) -- ID
                    pack:WriteULong(1) -- Value
                    GetPlayerByGUID(plrs):SendPacket(pack)
                    local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
                    pack:WriteULong(2317) -- ID, total
                    pack:WriteULong(Lives) -- Value
                    GetPlayerByGUID(plrs):SendPacket(pack)
                    local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
                    pack:WriteULong(2314) -- ID
                    pack:WriteULong(HordeLives) -- Amount, Horde
                    GetPlayerByGUID(plrs):SendPacket(pack)		
                    local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
                    pack:WriteULong(2313) -- ID
                    pack:WriteULong(AllianceLives) -- Amount, Alliance
                    GetPlayerByGUID(plrs):SendPacket(pack)
                    --
                    team = team + 1
                    if team == 1 then
                        GetPlayerByGUID(plrs):SetFaction(team)
                        GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00You are fighting |cff007CFFAlliance!")
                        GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00You are fighting for the |cff007CFFAlliance!")
                        table.insert(Alliance, plrs)
                        GetPlayerByGUID(plrs):Teleport(AMap, AX, AY, AZ, 0)
                    elseif team == 2 then
                        GetPlayerByGUID(plrs):SetFaction(team)
                        GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00You are fighting for the |cffFF0000Horde!")
                        GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00You are fighting for the |cffFF0000Horde!")
                        table.insert(Horde, plrs)
                        GetPlayerByGUID(plrs):Teleport(HMap, HX, HY, HZ, 0)
                    elseif team == 3 then
                        team = 1
                        GetPlayerByGUID(plrs):SetFaction(team)
                        GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00You are fighting for the |cff007CFFAlliance!")
                        GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00You are fighting for the |cff007CFFAlliance!")
                        table.insert(Alliance, plrs)
                        GetPlayerByGUID(plrs):Teleport(AMap, AX, AY, AZ, 0)
                    end
                end
                CountDown = 60
                CreateLuaEvent(Game_Start_Battleground_Countdown, 10000, 6)
            else
                for place, plrs in pairs(PlayersTable) do
                    if plrs ~= nil then
                        GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00Waiting for more PlayersTable...")
                    end
                end
            end
    end
	else
		message = message + 1
		if message == 5 then
			message = 0
			for place, plrs in pairs(PlayersTable) do
				if plrs ~= nil then
					GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00The battleground is currently in progress!")
				end
			end
		end
	end
end

CreateLuaEvent( ProcessQueForBattleground, 10000, 0 )

function JoinQue(plr)
	if InGame then
		plr:SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00You can't join the que while the game is in progress!")
		plr:SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00You can't join the que while the game is in progress!")		
	else
		local Disable = false
		for place, plrs in pairs(PlayersTable) do
			if GetPlayerByGUID(plrs):GetName() == plr:GetName() then -- Since the bloody thing refuses to compare GUID's
				Disable = true
				--break
			end
		end
		if Disable then
			plr:SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00You are already in the que for the battleground!")
			plr:SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00You are already in the que for the battleground!")
		else
			table.insert(PlayersTable, plr:GetGUID()) -- Insert into PlayersTable with value plr
			plr:SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00You are in the que for the battleground!")
			plr:SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00You are in the que for the battleground!")
		end
	end
end

function ResetBG()
	for place, plrs in pairs(PlayersTable) do
		if GetPlayerByGUID(plrs) ~= nil then
			local pack = CreatePacket(SMSG_INIT_WORLD_STATES, 18) -- HORDE
			pack:WriteULong(0) -- Map
			pack:WriteULong(0) -- Zone
			pack:WriteULong(0)
			pack:WriteUShort(0)
			pack:WriteULong(0) -- ID
			pack:WriteULong(0) -- Value
			pack:WriteULong(0) -- ID
			pack:WriteULong(0) -- Value
			GetPlayerByGUID(plrs):SendPacket(pack)
			local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(0)
			pack:WriteULong(0)
			GetPlayerByGUID(plrs):SendPacket(pack)
			GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00The battleground has ended!")
			GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00The battleground has ended!")
			-- GetPlayerByGUID(plrs):SetPlayerLock(0)
			GetPlayerByGUID(plrs):ResurrectPlayer(100, false)
			local race = GetPlayerByGUID(plrs):GetRace()
			if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then -- Alliance
				GetPlayerByGUID(plrs):SetFaction(1)
				GetPlayerByGUID(plrs):Teleport(HomeMA, HomeXA, HomeYA, HomeZA, 0)
			else
				GetPlayerByGUID(plrs):SetFaction(2)
				GetPlayerByGUID(plrs):Teleport(HomeMH, HomeXH, HomeYH, HomeZH, 0)
			end
		end
	end
	InGame = false
	for place,plrs in pairs(PlayersTable) do -- Clean old table rather than overwriting with a new table
		PlayersTable[place] = nil
	end
	for place,plrs in pairs(Horde) do -- Clean old table rather than overwriting with a new table
		PlayersTable[place] = nil
	end
	for place,plrs in pairs(Alliance) do -- Clean old table rather than overwriting with a new table
		PlayersTable[place] = nil
	end
end

function SERVER_HOOK_KILL_PLAYER_BG(event, killer, victim)
	local playingBG = false
    -- so here we check if player is from our battleground
	for place, plrs in pairs(PlayersTable) do
		if plrs == victim:GetGUID() then -- Since the bloody thing refuses to compare GUID's
			playingBG = true
			--break
		end
	end
    
    -- if our player is from our battleground
	if playingBG then
		local Continue = true
		if HordeLives == 1 then
			for place, plrs in pairs(PlayersTable) do
				-- GetPlayerByGUID(plrs):SetPlayerLock(1)
				GetPlayerByGUID(plrs):ResurrectPlayer(100, false)
				GetPlayerByGUID(plrs):SetHealth(GetPlayerByGUID(plrs):GetMaxHealth())
				GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00The Horde have won!")
				GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00The Horde have won!")
				GetPlayerByGUID(plrs):PlayDirectSound(8454, GetPlayerByGUID(plrs)) -- Horde Victory
			end
			for place, plrs in pairs(Horde) do
				if RewardID ~= 0 then
					GetPlayerByGUID(plrs):AddItem(RewardID, 1)
				end
			end
			CreateLuaEvent(ResetBG, 10000, 1)
		elseif AllianceLives == 1 then
			for place, plrs in pairs(PlayersTable) do
				-- GetPlayerByGUID(plrs):SetPlayerLock(1)
				GetPlayerByGUID(plrs):ResurrectPlayer(100, false)
				GetPlayerByGUID(plrs):SetHealth(GetPlayerByGUID(plrs):GetMaxHealth())
				GetPlayerByGUID(plrs):SendBroadcastMessage("|cff00ff00[Battleground] |cffffff00The Alliance have won!")
				GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00The Alliance have won!")
				GetPlayerByGUID(plrs):PlayDirectSound(8455, GetPlayerByGUID(plrs)) -- Alliance Victory
			end
			for place, plrs in pairs(Alliance) do
				if RewardID ~= 0 then
					GetPlayerByGUID(plrs):AddItem(RewardID, 1)
				end
			end
			CreateLuaEvent(ResetBG, 10000, 1)
		end
        
        -- here we update battlegroundscore
		if Continue then
            local updateSide = 1 -- horde
            
            for place, plrs in pairs(Horde) do
                if GetPlayerByGUID(plrs):GetName() == victim:GetName() then
                    updateSide = 0 -- alliance
                end
            end
            
			if updateSide == 1 then -- There Horde
				HordeLives = HordeLives - 1
				for place, plrs in pairs(PlayersTable) do
					local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
					pack:WriteULong(2314) -- ID
					pack:WriteULong(HordeLives) -- Amount, Horde
					GetPlayerByGUID(plrs):SendPacket(pack)
				end
			else
				AllianceLives = AllianceLives - 1
				for place, plrs in pairs(PlayersTable) do
					local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
					pack:WriteULong(2313) -- ID
					pack:WriteULong(AllianceLives) -- Amount, Alliance
					GetPlayerByGUID(plrs):SendPacket(pack)
				end
			end
            
            -- here we show pvp message on kill
			if BroadcastKills then
				for place, plrs in pairs(PlayersTable) do
					GetPlayerByGUID(plrs):SendAreaTriggerMessage("|cff00ff00[Battleground] |cffffff00"..killer:GetName().." has killed "..victim:GetName().."!")
				end
			end
		end
	end
end

RegisterPlayerEvent(6, SERVER_HOOK_KILL_PLAYER_BG)

-----------
-- Debug --
-----------
--[[
  The functions below should be removed, they are used for debugging the system.
]]

local function OnChat_Hook_ToJoinBG(event, plr, message, Type, lang) -- Can return false, newMessage
	local message = string.lower(message)
	if message == "#joinbg" then
		JoinQue(plr)
	elseif message == "#finbg" then
		ResetBG()
	end
	if message == "#ftest" then
        if plr:IsHorde() then
            plr:SendBroadcastMessage("you are horde"..plr:GetTeam())
        else
            plr:SendBroadcastMessage("you are ally"..plr:GetTeam())
        end
    end
	if message == "#test" then
		if math.random(1,1) == 1 then
			local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2314) -- ID
			HordeLives = HordeLives - 1
			pack:WriteULong(HordeLives) -- Amount, Horde
			plr:SendPacket(pack)
		else
			local pack = CreatePacket(SMSG_UPDATE_WORLD_STATE, 8)
			pack:WriteULong(2313) -- ID
			AllianceLives = AllianceLives - 1
			pack:WriteULong(AllianceLives) -- Amount, Alliance
            plr:SendPacket( pack )
		end
	end
end

RegisterPlayerEvent(18, OnChat_Hook_ToJoinBG)
