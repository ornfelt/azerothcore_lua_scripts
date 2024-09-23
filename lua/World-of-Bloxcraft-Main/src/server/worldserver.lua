local World = {}
World.__index = World
-- Get ModuleScripts
local Spell = require(workspace.Spell)
local Unit = require(workspace.Unit)
local Player = require(workspace.Player)
local Config = require(script["worldserver.conf"]);
local Database = require(workspace.DatabaseHandler)
local DuelHandler = require(workspace.DuelHandler);
local Connection = require(workspace.ConnectionHandler)
local AreaTrigger = require(workspace.AreaTriggerHandler);
local DSS = game:service'DataStoreService';
local SS = game:service'ServerStorage';
local Map = require(workspace.Map)

-------------------------------------------------------
function World.new()
	local new_world = {}
	setmetatable(new_world, World)

	new_world.client_opcodes = {}
	new_world.opcodesList = {}
	new_world.MapList = {};
	new_world.connection_list = {}
	new_world.areaTriggerList = {}
	new_world.m_auraKeyCounter = 0;
	
	-- Load map list
	local new_map = Map.new(new_world, 1);
	table.insert(new_world.MapList, new_map);
	
	return new_world
end

function World:Update(m_time)
	for _,v in next,self.MapList do
		if v ~= nil then
			if v.Active == true then
				v:Update(m_time)
			end
		end
	end
end
function World:DisconnectClient(player)
	for i = 1, #self.connection_list do
		if self.connection_list[i].player == player then
			table.remove(self.connection_list, i);
			break;
		end
	end
end

function World:GetCharacter(name)
	local list = Database.Access("characters", "character", nil)
	for _,v in next,list:GetChildren() do
		for i,g in next,v:GetChildren() do
			if g.Name == name then
				return g;
			end
		end
	end
end

function World:BuildCharacter(connection, name, class, map)
	-- We first need to check if we are allowed to build this character as we don't want duplicates
	local char = Instance.new("Folder");
	char.Name = name
	local classId = Instance.new("IntValue", char);
	classId.Value = class
	classId.Name = "classId"
	local factionID = Instance.new("IntValue", char)
	factionID.Value = 2
	factionID.Name = "factionID"
	char.Parent = workspace.Database.characters.character[connection.player.Name];
	for _,v in next, self.MapList do
		print(v.m_mapId, map);
		if tonumber(v.m_mapId) == map then
			map = v;
		end
	end
	local new_unit = map:BuildUnit(connection.player, "Player", name);
	table.insert(connection.characterList, {name, 2, class});
	table.insert(connection.charUnitList, new_unit)
	connection:DisplayCharacters();
end

function World:ForceData(c_ops, opList)
	self.client_opcodes = c_ops
	self.opcodesList = opList
end

function World:GetConnection(player)
	for _,v in next,self.connection_list do
		if v.player == player then
			return v;
		end
	end
end

function World:AddUnit(unit)
	for _,v in next,self.MapList do
		if v == unit.map then
			v:AddUnit(unit);
		end
	end
end

function World:GetMap(mapId)
	for _,v in next,self.MapList do
		if v.m_mapId == mapId then
			return v;
		end
	end
end

function World:AddConnection(connection)
	table.insert(self.connection_list, connection);
end

function World:GetUnit(target)
	if target:IsA("Player") then
		local con = self:GetConnection(target);
		return con:GetLoggedInChar();
	else
		for _,v in next,self.MapList do
			return v:GetUnitFromLink(target);
		end
	end
end

function World:ToWorld()
	return self;
end

local serverPackets={};
local clientPackets={};
local numSuc = 0;
local rs=game:service'ReplicatedStorage';

-- Create World Object
local GameWorld = World.new()

local DSS = game:service'DataStoreService';

local charStore = DSS:GetDataStore("Characters");

game.Players.PlayerAdded:connect(function(player)
	local char = player.Character or player.CharacterAdded:Wait();
	player.Backpack.Scripts.LoginScript.Enabled = true;
	-- Build new connection
	local con = Connection.new(player, GameWorld);
	local fold = Instance.new("Folder", workspace.Database.characters.character);
	fold.Name = player.Name;
	-- Now, we need to get the data from the player's keys
	-- Starting with accessing this player's individual characters
	local charList = {};
	local new_charList = {}; -- Going to be set for the connection to have access to Testchar, ClassId, and FactionId to be sent to client
	if Config.DataStoreEnabled == true then
		-- Access the char's based on keys 1-11, if key doesn't exist, skip
		local store = tostring(player.UserId).." - "..Config.DBVersion; 
		for i = 1, 11 do
			local nextChar = con:LoadData(store, i); -- Each value is a string, which pertains to a certain Data Store
			if nextChar ~= nil then -- Char exists at this key
				table.insert(charList, nextChar);
			end
		end

		-- Now, we loop through the charList, accessing it's individual data store and loading that data into a new Unit object
		if #charList > 0 then
			for _,v in next, charList do
				local store = v.."-unitInfo - "..Config.DBVersion;
				local mapId = con:LoadData(store, "map");
				local map = GameWorld:GetMap(mapId);
				local new_unit = map:BuildUnit(player, "Player", v); -- Link / Type / World / Name
				--[[new_unit.m_alive = con:LoadData(store, "m_alive")
				new_unit.m_Health = con:LoadData(store, "m_Health")
				new_unit.m_maxHealth = con:LoadData(store, "m_maxHealth")
				new_unit.m_Mana = con:LoadData(store, "m_Mana")
				new_unit.m_maxMana = con:LoadData(store, "m_maxMana")
				new_unit.m_unitState = con:LoadData(store, "m_unitState")
				new_unit.m_Mana = con:LoadData(store, "m_Mana")
				new_unit.m_MaxMana = con:LoadData(store, "m_MaxMana")
				new_unit.m_manaTickAmount = con:LoadData(store, "m_manaTickAmount")
				new_unit.m_factionId = con:LoadData(store, "m_factionId")
				new_unit.m_classId = con:LoadData(store, "m_classId");]]
				--local plr = new_unit:ToPlayer();
				--local store = v.."-Player - "..Config.DBVersion;
				--plr.m_modDamage = con:LoadData(store, "m_modDamage");

				--[[local store = v.."-flags - "..Config.DBVersion;
				local flags = {};
				for i = 1, 10 do
					local new_flag = con:LoadData(store, i);
					if new_flag ~= nil then
						table.insert(flags, new_flag);
					end
					continue;
				end]]

				--[[local store = v.."-Stats - "..Config.DBVersion;
				new_unit.stats["stamina"] = con:LoadData(store, "stamina");
				new_unit.stats["strength"] = con:LoadData(store, "strength");
				new_unit.stats["speed"] = con:LoadData(store, "speed");
				new_unit.stats["intellect"] = con:LoadData(store, "intellect");
				new_unit.stats["agility"] = con:LoadData(store, "agility");]]

				table.insert(new_charList, {new_unit.Name, new_unit.m_factionId, new_unit.m_classId});
				
				GameWorld:BuildCharacter(con, new_unit.Name, new_unit.m_classId, 1);
			end
		end
	end

	con:SetCharList(new_charList);

	-- Add this connection to the game world and display it's available characters to the client
	GameWorld:AddConnection(con);
	con:DisplayCharacters();
end)

function PlayerRemoved(player)
	-- Start by getting player connection object
	local con = GameWorld:GetConnection(player);
	if not con then error("No connection found!") return false end;
	
	if Config.DataStoreEnabled == true then
	
		local chars = con:GetCharacters()

		-- get player's list of characters and their respective units
		for e,v in next,chars do
			-- First, we need to log the names of the characters this player has so the core can access those respective data stores when logging in
			-- We use the player's UserID as the store name to hold them, and each key in the table as the key
			local store = tostring(player.UserId).." - "..Config.DBVersion;
			con:SaveData(store, e, v.Name);
			-- Next, save all data from that unit
			local store = v.Name.."-unitInfo - "..Config.DBVersion;
			con:SaveData(store, "map", v.map.m_mapId);
			--[[con:SaveData(store, "m_alive", v.m_alive)
			con:SaveData(store, "m_Health", v.m_Health)
			con:SaveData(store, "m_maxHealth", v.m_maxHealth)
			con:SaveData(store, "m_Mana", v.m_Mana)
			con:SaveData(store, "m_maxMana", v.m_maxMana)
			con:SaveData(store, "m_Mana", v.m_Mana)
			con:SaveData(store, "m_MaxMana", v.m_MaxMana)
			con:SaveData(store, "m_manaTickAmount", v.m_manaTickAmount)
			con:SaveData(store, "m_factionId", 1)
			con:SaveData(store, "m_classId", v.m_classId)]]

			-- Save all data from player object
			--local Player = v:ToPlayer();
			--local store = v.Name.."-Player - "..Config.DBVersion;
			--con:SaveData(store, "m_modDamage", Player.m_modDamage)

			--[[local store = v.Name.."-flags - "..Config.DBVersion;
			for i,g in next,v.flags do
				con:SaveData(store, i, g);
			end]]

			--[[local store = v.Name.."-Stats - "..Config.DBVersion;
			con:SaveData(store, "stamina", v.stats["stamina"]);
			con:SaveData(store, "strength", v.stats["strength"]);
			con:SaveData(store, "speed", v.stats["speed"]);
			con:SaveData(store, "intellect", v.stats["intellect"]);
			con:SaveData(store, "agility", v.stats["agility"]);]]
		end
	end
	
	if con.loggedInChar ~= nil then
		con.loggedInChar.Active = false;
		con.loggedInChar = nil;
	end
	-- Disconnect the client from the game
	con:Disconnect();
	GameWorld:DisconnectClient(con);
end

game.Players.PlayerRemoving:connect(PlayerRemoved)

function onServerClosing()
	for _,player in next, game.Players:GetPlayers() do
		PlayerRemoved(player);
	end
end

game:BindToClose(onServerClosing)

-- Test npcs. This will be done much better later on but NPCs are meaningless right now, just test dummies
local map = GameWorld:GetMap(1);
local new_todd = map:SpawnNPC(1); 
new_todd.location:Teleport(Vector3.new(153.171, 18.325, -258.396));
new_todd:SetMaxHealth(10000);
new_todd:SetHealth(10000);
new_todd.Active = true;

local new_jobe = map:SpawnNPC(1)
new_jobe.location:Teleport(Vector3.new(119.171, 18.325, -258.396));
new_jobe:SetMaxHealth(10000);
new_jobe:SetHealth(10000);
new_jobe.Active = true;

local client_opcodes={
	["CMSG_CAST_SPELL"]=function(player, keyCode)
		if not player then return false end; -- Should never happen
		local m_unit = GameWorld:GetUnit(player)
		
		local clientSpell = m_unit:getClientSpell(keyCode)
		if not clientSpell then return end

		local spellId = tostring(clientSpell.m_spellId)
		local spell = clientSpell.spellInfo
		
		if not spell then return false end; -- Should never happen
		
		local newSpell = m_unit:BuildSpell(spell, m_unit:GetTarget(), nil, nil, true)
		
		-- Check for spells not allowed to be cast(passives)
		if newSpell:IsPassive() then
			newSpell = nil;
			return;
		end
		
		newSpell:Prepare()
	end,
	["CMSG_UPDATE_WORLD"]=function(player)
		--Working: Ignore for now
	end,
	["CMSG_CHATMESSAGE_SAY"]=function(player,msg)
		local unit = GameWorld:GetUnit(player);
		unit:HandleMessage(msg);
	end,
	["CMSG_MOVE_JUMP"]=function(player, active)
		--Working: Ignore for now
	end,
	["CMSG_MOVE_FALL_LAND"]=function(player, active)
		--Working: Ignore for now
	end,
	["CMSG_STAT_CHANGED"]=function(player, stat, newVal)
		--Working: deprecated
	end,
	["CMSG_UPDATE_STATS"]=function(player, target, stat, value)
		--Working: deprecated
	end,
	["CMSG_CAST_SUCCEEDED"]=function(player, scr, secondScr)
		--Working: deprecated
	end,
	["CMSG_DISABLE_SCRIPT"]=function(player, ...)
		--Working: Pointless
	end,
	["CMSG_UPDATE_TARGET"]=function(player, target)
		local m_unit = GameWorld:GetUnit(player)
		local m_target = GameWorld:GetUnit(target)
		m_unit:UpdateTarget(m_target)
	end,
	["CMSG_PLAYER_LOGIN"]=function(player)
		local Id = player:WaitForChild'Backpack':WaitForChild'Id';
		Id.Value = player.UserId;
		local fol = Database.Access("characters", "character", player.Name);
		if fol then return false end;
		local folder = Instance.new("Folder");
		folder.Name = player.Name;
		local faction = Instance.new("IntValue");
		faction.Name = "factionID";
		faction.Value = 1;
		faction.Parent = folder;
		Database.Insert("characters","character",folder);
	end,
	["CMSG_ANIMATION_FINISHED"]=function(player, caster, spellName, target)
		-- Working: Pointless
	end,
	["CMSG_INIT_DUEL"]=function(player, data)
		local m_unit = GameWorld:GetUnit(data.Initiator)
		local m_player = m_unit:ToPlayer();
		if m_player then
			m_player:InitiateDuel(m_unit:GetTarget());
		else
			error("Player not found!")
		end
	end,
	["CMSG_ACCEPTED_DUEL"]=function(player)
		local m_player = GameWorld:GetUnit(player):ToPlayer()
		if m_player:HasDuel() then
			m_player:AcceptDuel();
		end
	end,
	["CMSG_DECLINED_DUEL"]=function(player)
		local m_player = GameWorld:GetUnit(player):ToPlayer()
		if m_player:HasDuel() then
			m_player:DeclineDuel();
		end
	end,
	["CMSG_DUEL_FINISHED"]=function(player, target, winner)
		-- Deprecated
	end,
	["CMSG_SELECTED_CLASS"]=function(player, class)
		-- Deprecated
	end,
	["CMSG_JOIN_WORLD"]=function(player, charName)
		local char = GameWorld:GetCharacter(charName);
		local con = GameWorld:GetConnection(player)
		for _,v in next, con:GetCharList() do
			if v.Name == charName then
				con:SetLoggedInChar(v);
				v:LoadClass();
				v.Active = true;
				v:LoadHealthPool();
				player.Backpack.Scripts.LoginScript.Enabled = false;
				player.Backpack.Scripts.LoadScript.Enabled = true;
				break;
			end
		end
	end,
	["CMSG_CREATE_CHAR"]=function(player, data)
		--TODO: Handle Character Creation
		local class = data.Class
		local con = GameWorld:GetConnection(player);
		if not con then return error("No connection found!") end;
		GameWorld:BuildCharacter(con, data.Name, class, 1);
	end,
	["CMSG_MOUSE_CLICKED"]=function(player, data)
		local pos = data.Pos
		local spell = data.Spell
		local char = GameWorld:GetUnit(player);
		if not char then return error("Something weird happened") end;
		local spell = char:BuildSpell(spell, nil, pos, nil, false)
		spell:Prepare();
	end,
	["CMSG_SELECT_ELECTIVES"]=function(player, data)
		local spellId1 = data.SpellId1
		local spellId2 = data.SpellId2
		local unit = GameWorld:GetUnit(player);
		if not unit then return error("Something weird happened") end;
		unit:SetElectiveSlotIds(spellId1, spellId2);
		local new_spell = unit:BuildSpell(game.Lighting.Spells["13"], nil, false, nil);
		new_spell:Prepare();
	end,
	["CMSG_SPELL_HIT"] = function(player, data)
		local target = data.Target
		local spell = data.Spell;
		print("worked");
	end,
	["CMSG_UPDATE_BINDS"]=function(player, data)
		local binds = data.Binds
		local unit = GameWorld:GetUnit(player);
		if not unit then return error("Something weird happened") end;
		unit:UpdateBinds(binds);
	end,
	["CMSG_UPDATE_BARS"]=function(player, data)
		local spellId = data.SpellId
		local bind = data.Bind
		local unit = GameWorld:GetUnit(player);
		if not unit then return error("Something weird happened") end;
		unit:UpdateBind(spellId, bind);
	end,
}
local opcodes={
	"CMSG_CAST_SPELL",
	"CMSG_UPDATE_WORLD",
	"CMSG_CHATMESSAGE_SAY",
	"CMSG_MOVE_JUMP"	,
	"CMSG_MOVE_FALL_LAND",
	"CMSG_STAT_CHANGED",
	"CMSG_UPDATE_STATS",
	"CMSG_CAST_SUCCEEDED",
	"CMSG_CAST_CANCELED",
	"CMSG_DISABLE_SCRIPT",
	"CMSG_UPDATE_TARGET",
	"CMSG_DEAL_DAMAGE",
	"CMSG_DEAL_HEALING",
	"CMSG_PLAYER_LOGIN",
	"CMSG_ANIMATION_FINISHED",
	"CMSG_INIT_DUEL",
	"CMSG_ACCEPTED_DUEL",
	"CMSG_DUEL_FINISHED",
	"CMSG_SELECTED_CLASS",
	"CMSG_DECLINED_DUEL",
	"CMSG_JOIN_WORLD",
	"CMSG_CREATE_CHAR",
	"CMSG_MOUSE_CLICKED",
	"CMSG_SELECT_ELECTIVES",
	"CMSG_SPELL_HIT",
	"CMSG_UPDATE_BINDS",
	"CMSG_UPDATE_BARS"
}

GameWorld:ForceData(client_opcodes, opcodes)

-------------------------------------------------------
--[[Build necessary packets]]--
function BuildServerPacket(n,p,pl,newobj)
	local remev=Instance.new("RemoteEvent",p);
	remev.Name=n;
	if newobj then
		newobj.Parent=remev
	end
	table.insert(serverPackets,remev);
	return remev;
end

for i=1,#GameWorld.opcodesList do wait()
	BuildServerPacket(GameWorld.opcodesList[i],workspace);
end
-------------------------------------------------------
function ParseClientPacket(p,...)
	if p then
		if GameWorld.client_opcodes[p.Name] then
			GameWorld.client_opcodes[p.Name](...);
			--print(p.Name..": Send to server!");
		end
	end
end
function InvokeClientPacket(p,...)
	if p then
		p:FireClient(...);
	end
end

---------- TODO: Make separate core scripts to handle opcodes
-- Create the function handling the opcode
function PlayerJoinedWorld(...)
	ParseClientPacket(game.Workspace["CMSG_JOIN_WORLD"],...);
end
function PlayerCreatedChar(...)
	ParseClientPacket(game.Workspace["CMSG_CREATE_CHAR"],...);
end
function PlayerCastedSpell(...)
	ParseClientPacket(game.Workspace["CMSG_CAST_SPELL"],...);
end
function PlayerUpdateWorld(...)
	ParseClientPacket(game.Workspace["CMSG_UPDATE_WORLD"],...);
end
function PlayerChatMessageSay(...)
	ParseClientPacket(game.Workspace["CMSG_CHATMESSAGE_SAY"],...);
end
function PlayerMoveJump(...)
	ParseClientPacket(game.Workspace["CMSG_MOVE_JUMP"],...);
end
function PlayerDeclinedDuel(...)
	ParseClientPacket(game.Workspace["CMSG_DECLINED_DUEL"],...);
end
function PlayerMoveFallLand(...)
	ParseClientPacket(game.Workspace["CMSG_MOVE_FALL_LAND"],...);
end
function PlayerStatChanged(...)
	ParseClientPacket(game.Workspace["CMSG_STAT_CHANGED"],...);
end
function PlayerUpdateStats(...)
	ParseClientPacket(game.Workspace["CMSG_UPDATE_STATS"],...);
end
function PlayerCastSucceeded(...)
	ParseClientPacket(game.Workspace["CMSG_CAST_SUCCEEDED"],...);
end
function PlayerCastCanceled(...)
	ParseClientPacket(game.Workspace["CMSG_CAST_CANCELED"],...);
end
function PlayerDisableScript(...)
	ParseClientPacket(game.Workspace["CMSG_DISABLE_SCRIPT"],...);
end
function PlayerUpdateTarget(...)
	ParseClientPacket(game.Workspace["CMSG_UPDATE_TARGET"],...);
end
function PlayerDealDamage(...)
	ParseClientPacket(game.Workspace["CMSG_DEAL_DAMAGE"],...);
end
function PlayerDealHealing(...)
	ParseClientPacket(game.Workspace["CMSG_DEAL_HEALING"],...);
end
function PlayerLoggedIn(...)
	ParseClientPacket(game.Workspace["CMSG_PLAYER_LOGIN"],...)
end
function SpellAnimationFinished(...)
	ParseClientPacket(game.Workspace["CMSG_ANIMATION_FINISHED"],...);
end
function PlayerRequestDuel(...)
	ParseClientPacket(game.Workspace["CMSG_INIT_DUEL"],...);
end
function PlayerAcceptedDuel(...)
	ParseClientPacket(game.Workspace["CMSG_ACCEPTED_DUEL"],...);
end
function PlayerFinishedDuel(...)
	ParseClientPacket(game.Workspace["CMSG_DUEL_FINISHED"],...);
end
function PlayerSelectedClass(...)
	ParseClientPacket(game.Workspace["CMSG_SELECTED_CLASS"],...);
end
function PlayerClickedMouse(...)
	ParseClientPacket(game.Workspace["CMSG_MOUSE_CLICKED"],...);
end
function PlayerSelectedElectives(...)
	ParseClientPacket(game.Workspace["CMSG_SELECT_ELECTIVES"],...);
end
function PlayerSpellHit(...)
	ParseClientPacket(game.Workspace["CMSG_SPELL_HIT"],...);
end
function PlayerUpdateBinds(...)
	ParseClientPacket(game.Workspace["CMSG_UPDATE_BINDS"], ...);
end
function PlayerUpdateBind(...)
	ParseClientPacket(game.Workspace["CMSG_UPDATE_BARS"],...);
end
-- Create the listener of the opcode
game.Workspace["CMSG_JOIN_WORLD"].OnServerEvent:connect(PlayerJoinedWorld);
game.Workspace["CMSG_CREATE_CHAR"].OnServerEvent:connect(PlayerCreatedChar);
game.Workspace["CMSG_CAST_SPELL"].OnServerEvent:connect(PlayerCastedSpell);
game.Workspace["CMSG_UPDATE_WORLD"].OnServerEvent:connect(PlayerUpdateWorld);
game.Workspace["CMSG_CHATMESSAGE_SAY"].OnServerEvent:connect(PlayerChatMessageSay);
game.Workspace["CMSG_MOVE_JUMP"].OnServerEvent:connect(PlayerMoveJump);
game.Workspace["CMSG_MOVE_FALL_LAND"].OnServerEvent:connect(PlayerMoveFallLand);
game.Workspace["CMSG_STAT_CHANGED"].OnServerEvent:connect(PlayerStatChanged);
game.Workspace["CMSG_UPDATE_STATS"].OnServerEvent:connect(PlayerUpdateStats);
game.Workspace["CMSG_CAST_SUCCEEDED"].OnServerEvent:connect(PlayerCastSucceeded);
game.Workspace["CMSG_CAST_CANCELED"].OnServerEvent:connect(PlayerCastCanceled);
game.Workspace["CMSG_DISABLE_SCRIPT"].OnServerEvent:connect(PlayerDisableScript);
game.Workspace["CMSG_UPDATE_TARGET"].OnServerEvent:connect(PlayerUpdateTarget);
game.Workspace["CMSG_DEAL_DAMAGE"].OnServerEvent:connect(PlayerDealDamage);
game.Workspace["CMSG_DEAL_HEALING"].OnServerEvent:connect(PlayerDealHealing);
game.Workspace["CMSG_PLAYER_LOGIN"].OnServerEvent:connect(PlayerLoggedIn);
game.Workspace["CMSG_ANIMATION_FINISHED"].OnServerEvent:connect(SpellAnimationFinished);
game.Workspace["CMSG_INIT_DUEL"].OnServerEvent:connect(PlayerRequestDuel);
game.Workspace["CMSG_ACCEPTED_DUEL"].OnServerEvent:connect(PlayerAcceptedDuel);
game.Workspace["CMSG_DECLINED_DUEL"].OnServerEvent:connect(PlayerDeclinedDuel);
game.Workspace["CMSG_DUEL_FINISHED"].OnServerEvent:connect(PlayerFinishedDuel);
game.Workspace["CMSG_SELECTED_CLASS"].OnServerEvent:connect(PlayerSelectedClass);
game.Workspace["CMSG_MOUSE_CLICKED"].OnServerEvent:connect(PlayerClickedMouse);
game.Workspace["CMSG_SELECT_ELECTIVES"].OnServerEvent:connect(PlayerSelectedElectives);
game.Workspace["CMSG_SPELL_HIT"].OnServerEvent:connect(PlayerSpellHit);
game.Workspace["CMSG_UPDATE_BINDS"].OnServerEvent:connect(PlayerUpdateBinds);
game.Workspace["CMSG_UPDATE_BARS"].OnServerEvent:connect(PlayerUpdateBind);


--Update World Function

game:service'RunService'.Heartbeat:connect(function(m_time)
	GameWorld:Update(m_time)
end)





-------------------------------------

local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

local playerCollisionGroupName = "Units";
PhysicsService:CreateCollisionGroup(playerCollisionGroupName)
PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, playerCollisionGroupName, false)
local previousCollisionGroups = {}

local function setCollisionGroup(object)
	if object:IsA("BasePart") then
		previousCollisionGroups[object] = object.CollisionGroupId
		PhysicsService:SetPartCollisionGroup(object, playerCollisionGroupName)
	end
end

local function setCollisionGroupRecursive(object)
	setCollisionGroup(object)

	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end

local function resetCollisionGroup(object)
	local previousCollisionGroupId = previousCollisionGroups[object]
	if not previousCollisionGroupId then return end 

	local previousCollisionGroupName = PhysicsService:GetCollisionGroupName(previousCollisionGroupId)
	if not previousCollisionGroupName then return end

	PhysicsService:SetPartCollisionGroup(object, previousCollisionGroupName)
	previousCollisionGroups[object] = nil
end

local function onCharacterAdded(character)
	setCollisionGroupRecursive(character)

	character.DescendantAdded:Connect(setCollisionGroup)
	character.DescendantRemoving:Connect(resetCollisionGroup)
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end

Players.PlayerAdded:Connect(onPlayerAdded)