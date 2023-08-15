local PLAYER_EVENT_ON_LOGIN = 3
local PLAYER_EVENT_ON_LOGOUT = 4
local PLAYER_EVENT_ON_KILLED_BY_CREATURE = 8
local PLAYER_EVENT_ON_KILL_PLAYER = 6

local function OnLogin(event, player)
	local playerName = player:GetName()
	local isHorde = player:IsHorde()
	if(isHorde == true) then
		SendWorldMessage("|cfffc0303" .. playerName .. " from the Horde logged in.")
	elseif (isHorde == false) then
		SendWorldMessage("|cfffc0303" .. playerName .. " from the Alliance logged in.")
	end
end

local function OnExitWorld(event, player)
	local playerName = player:GetName()
	local isHorde = player:IsHorde()
	if(isHorde == true) then
		SendWorldMessage("|cfffc0303" .. playerName .. "|r from the Horde logged off.")
	elseif (isHorde == false) then
		SendWorldMessage("|cfffc0303" .. playerName .. " from the Alliance logged off.")
	end
end

local function OnDeadByMob(event, killer, killed)
	local deadpl = killed:GetName()
	local deathby = killer:GetName()
	SendWorldMessage("|cfffc0303" .. deadpl .. " was killed by a " .. deathby)
end

local function OnKillPlayer(event, killer, killed)
	local deadpl = killed:GetName()
	local deathby = killer:GetName()
	SendWorldMessage("|cfffc0303" .. deadpl .. "|r was killed by " .. "|cfffc0303" ..deathby.."|r")
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGOUT, OnExitWorld)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILLED_BY_CREATURE, OnDeadByMob)
RegisterPlayerEvent(PLAYER_EVENT_ON_KILL_PLAYER, OnKillPlayer)