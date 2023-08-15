--[[

	Mob fight arena script
	Script made by Grandelf.
	
]]--

--[[

##################################################################################################
#                                                                                                #
#   Emap, Ex, Ey, Ez, Ezone this are the coords of the easy battle zone.	                     #
#   Just define it by putting in the coords as follow.                                           #
#   Map, X, Y, Z, Zone, so for e.g.: local Emap, Ex, Ey, Ez = 1, 4235.43, 3145.32, 12.3, 14      #
#                                                                                                #
#   Nmap, Nx, Ny, Nz, Nzone                                                                      #
#   Same as above but then for the normal battle zone.                                           #
#                                                                                                #
#   Hmap, Hx, Hy, Hz, Hzone                                                                      #  
#   Same as above but then for the hard battle zone.                                             #
#                                                                                                #
##################################################################################################

]]--

local Emap, Ex, Ey, Ez, Ezone = 0, -13205, 278, 22, 33
local Nmap, Nx, Ny, Nz, Nzone = 0, -13205, 278, 22, 33
local Hmap, Hx, Hy, Hz, Hzone = 0, -13205, 278, 22, 33

--[[

##################################################################################################
#                                                                                                #
#   EasyMob --> Id for the mobs that will spawn at easy mode 	                                 #
#                                                                                                #
#   NormalMob --> Id for the mobs that will spawn at easy mode                                   #
#                                                                                                #
#   HardMob --> Id for the mobs that will spawn at easy mode                                     #
#                                                                                                # 
#   GossipGuy --> Id for the gossip npc.                                                         #
#                                                                                                #
##################################################################################################

]]--

local EasyMob = 4316
local NormalMob = 4316
local HardMob = 4316
local GossipGuy = 4316

--[[

##################################################################################################
#                                                                                                #
#   Maximum --> Enter the maximum amount of mobs a player can fight. 	                         #
#                                                                                                #
#   Emax --> Max amount of players that can join easy mode.                                      #
#   Nmax --> Max amount of players that can join normal mode.                                    #
#   Hmax --> Max amount of players that can join hard mode.                                      #
#                                                                                                #
#   Wmap, Wx, Wy, Wz --> map, x, y, z coords where player gets ported to if he won.              #
#   Lmap, Lx, Ly, Lz --> map, x, y, z coords where player gets ported to if he lost.             #
#                                                                                                #
##################################################################################################

]]--

local Maximum = 15
local Emax = 30
local Nmax = 30
local Hmax = 30
local Wmap, Wx, Wy, Wz = 0, -13205, 278, 22
local Lmap, Lx, Ly, Lz = 0, -13205, 278, 22

ARENA = {}

ARENA["Battle"] = {
	["Easy"] = {
		["In"] = 0,
		["Players"] = {}
	},
	["Normal"] = {
		["In"] = 0,
		["Players"] = {}
	},
	["Hard"] = {
		["In"] = 0,
		["Players"] = {}
	},
	["Phase"] = {
	}	
}	
	
function ARENA.BattleNpc(pUnit, event, player)
	pUnit:GossipCreateMenu(100, player, 0)
	pUnit:GossipMenuAddItem(0, "Enter the amount of mobs you want to fight.", 1, 1)
	pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
	pUnit:GossipSendMenu(player)
end

function ARENA.BattleNpcOnGossip(pUnit, event, player, id, intid, code, pMisc)
	if (intid == 1) then
		if (code ~= nil) and (NumberCheck(code) == true) then
			if (tonumber(code) <= Maximum) then
				pUnit:GossipCreateMenu(100, player, 0)
				pUnit:GossipMenuAddItem(0, "Easy mode.", 2, 0)
				pUnit:GossipMenuAddItem(0, "Normal mode.", 3, 0)
				pUnit:GossipMenuAddItem(0, "Hard mode.", 4, 0)
				pUnit:GossipMenuAddItem(0, "Nevermind.", 5, 0)
				pUnit:GossipSendMenu(player)
				ARENA[tostring(player)] = {}
				ARENA[tostring(player)].Code = code
			else
				player:SendBroadcastMessage("The limit is "..Maximum..".")
				player:GossipComplete()
			end	
		else
			player:SendBroadcastMessage("You can only use numbers.")
			player:GossipComplete()
		end
	end
	if (intid == 2) then
		if (ARENA["Battle"]["Easy"]["In"] <= Emax) then
			ARENA["Battle"]["Easy"]["Players"][GetFreeSlot("Easy", "Players")] = player
			ARENA["Battle"]["Easy"]["In"] = ARENA["Battle"]["Easy"]["In"] + 1
			local t = GetPhaseNr()
			ARENA["Battle"]["Phase"][t] = 1
			player:PhaseSet(t)
			player:Teleport(Emap, Ex, Ey, Ez)
			ARENA[tostring(player)].Mob = {}
			local p = FindPlayer(player, "Easy", "Players")
			local code = ARENA[tostring(player)].Code
			RegisterTimedEvent("StartBattle", 5000, 1, "Easy", player, code, p) -- Triggers mob spawning.
			player:GossipComplete()
			player:Root()
		else
			player:SendBroadcastMessage("Easy mode is full at this moment, try another mode or come back later.")
			player:GossipComplete()
		end	
	end	
	if (intid == 3) then
		if (ARENA["Battle"]["Easy"]["In"] <= Nmax) then
			ARENA["Battle"]["Normal"]["Players"][GetFreeSlot("Normal", "Players")] = player
			ARENA["Battle"]["Normal"]["In"] = ARENA["Battle"]["Normal"]["In"] + 1
			local t = GetPhaseNr()
			ARENA["Battle"]["Phase"][t] = 1
			player:PhaseSet(t)
			player:Teleport(Nmap, Nx, Ny, Nz)
			ARENA[tostring(player)].Mob = {}
			local p = FindPlayer(player, "Normal", "Players")
			local code = ARENA[tostring(player)].Code
			RegisterTimedEvent("StartBattle", 5000, 1, "Normal", player, code, p)
			player:GossipComplete()
			player:Root()
		else
			player:SendBroadcastMessage("Normal mode is full at this moment, try another mode or come back later.")
			player:GossipComplete()
		end	
	end	
	if (intid == 4) then
		if (ARENA["Battle"]["Easy"]["In"] <= Hmax) then
			ARENA["Battle"]["Hard"]["Players"][GetFreeSlot("Hard", "Players")] = player
			ARENA["Battle"]["Hard"]["In"] = ARENA["Battle"]["Hard"]["In"] + 1
			local t = GetPhaseNr()
			ARENA["Battle"]["Phase"][t] = 1
			player:PhaseSet(t)
			player:Teleport(Hmap, Hx, Hy, Hz)
			ARENA[tostring(player)].Mob = {}
			local p = FindPlayer(player, "Hard", "Players")
			local code = ARENA[tostring(player)].Code
			RegisterTimedEvent("StartBattle", 5000, 1, "Hard", player, code, p)
			player:GossipComplete()
			player:Root()
		else
			player:SendBroadcastMessage("Hard mode is full at this moment, try another mode or come back later.")
			player:GossipComplete()
		end				
	end	
	if (intid == 5) then
		player:GossipComplete()
	end	
end	

function CheckIfPlayerWon(player, Mode, p)
	if (ARENA[tostring(player)].Mob ~= nil) then
		if (player:IsInCombat() == false) and (player:IsAlive() == true) then -- mobs dead
			player:SendBroadcastMessage("Congratulations, you have won this battle")
			player:Teleport(Wmap, Wx, Wy, Wz)
			player:PhaseSet(1)
			ARENA["Battle"][Mode]["In"] = ARENA["Battle"][Mode]["In"] - 1
			ARENA["Battle"][Mode]["Players"][p] = nil
			ARENA["Battle"]["Phase"][p] = nil	
			for _, s in pairs(ARENA[tostring(player)].Mob) do
				s:Despawn(1000, 0)
			end	
			ARENA[tostring(player)] = {}
		else
			RegisterTimedEvent("CheckIfPlayerWon", 1000, 1, player, Mode, p)
		end
	else
		return;
	end		
end	

function StartBattle(mode, player, code, p)
	local t = 0
	while (t ~= tonumber(code)) do
		t = t + 1
		if (mode == "Easy") then
			ARENA[tostring(player)].Mob[t] = player:SpawnCreature(EasyMob, player:GetX() + 5, player:GetY(), player:GetZ(), 3, 14, 0)
		elseif (mode == "Normal") then
			ARENA[tostring(player)].Mob[t] = player:SpawnCreature(NormalMob, player:GetX() + 5, player:GetY(), player:GetZ(), 3, 14, 0)
		elseif (mode == "Hard") then
			ARENA[tostring(player)].Mob[t] = player:SpawnCreature(HardMob, player:GetX() + 5, player:GetY(), player:GetZ(), 3, 14, 0)
		end
	end
	RegisterTimedEvent("CheckIfPlayerWon", 2000, 1, player, mode, p)
	RegisterTimedEvent("Checks", 1000, 1, player, mode, p)
	player:Unroot()
end	

function Checks(player, mode, p)
	local Zone = 0
	if (mode == "Easy") then
		Zone = Ezone	
	elseif (mode == "Normal") then
		Zone = Nzone
	elseif (mode == "Hard") then
		Zone = Hzone
	end	
	if (player:IsAlive() == false) or (player:GetZoneId() ~= Zone) then
		ARENA["Battle"][mode]["In"] = ARENA["Battle"][mode]["In"] - 1
		ARENA["Battle"][mode]["Players"][p] = nil
		ARENA["Battle"]["Phase"][p] = nil
		for _, s in pairs(ARENA[tostring(player)].Mob) do
			s:Despawn(1000, 0)
		end	
		ARENA[tostring(player)] = {}
		player:Teleport(Lmap, Lx, Ly, Lz)
		player:CastSpell(18976) -- Resurrect
	else	
		RegisterTimedEvent("Checks", 1000, 1, player, mode, p)
	end	
end	

function NumberCheck(str)
	local len, t = string.len(str) + 1, 1
	while (t ~= len) do
		local p = string.find(str, "%d", t)
		if (p ~= nil) then
			t = t + 1
		else
			return false
		end
	end
	return true
end	

function GetFreeSlot(Mode, Tbl)
	local t = 1
	while (ARENA["Battle"][Mode][Tbl][t] ~= nil) do -- Checking for a free slot.
		t = t + 1
	end
	return t;
end	

function GetPhaseNr()
	local t = 1
	while (ARENA["Battle"]["Phase"][t] ~= nil) do -- Checking for an unused phase.
		t = t + 1
	end	
	return t;	
end

function FindPlayer(player, Mode, Tbl)			
	for k, v in pairs(ARENA["Battle"][Mode][Tbl]) do
		if (v == player) then
			return k;
		end
	end
end	
	
logcol(4)
print("   [Arena]: Loaded succesfully.")
print("   [Arena]: Script made by Grandelf.")
logcol(7)

RegisterUnitGossipEvent(GossipGuy, 129130, "ARENA.BattleNpc")
RegisterUnitGossipEvent(GossipGuy, 129130, "ARENA.BattleNpcOnGossip")