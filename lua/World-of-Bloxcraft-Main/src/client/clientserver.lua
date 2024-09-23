wait(1)
local player=game.Players.LocalPlayer
local mouse=player:GetMouse()
local rs=game:service'ReplicatedStorage';
local uis = game:service("UserInputService")
local UI = require(player.PlayerGui.UIHandler);
local Opcodes = require(workspace.Opcodes);
local Player = require(workspace.Player);
local Unit = require(workspace.Unit)
local pGUI = player.PlayerGui
local CombatText = require(workspace.CombatText)
local MovementHandler = require(script.MovementHandler);
local Animation = require(script.Parent.AnimationHandler)
local Control = require(player.PlayerScripts.PlayerModule):GetControls();
--------------

local Client = {}
Client.__index = Client

function Client.new()
	local self = {}
	setmetatable(self, Client)
	
	self.m_gcdTimer = 0;
	self.m_casting = false;
	self.m_waitingForClick = false;
	self.m_moveList = {}
	self.m_target = nil;
	self.loggedIn = false;
	self.m_spellList = nil;
	self.m_animationList = {};
	self.m_vfxList = {};
	self.m_spellList = {};
	
	return self
end

function Client:GetSpellList()
	return self.m_spellList;
end

function Client:GetMoves()
	return self.m_moveList;
end

function Client:Update(m_time)
	if self.m_gcdTimer > 0 then
		self.m_gcdTimer = self.m_gcdTimer - m_time;
	else
		self.m_gcdTimer = 0;
	end
	
	-- Movements
	if #self.m_moveList > 0 then
		for _,v in next,self.m_moveList do
			v:Update(m_time);
		end
	end
	
	-- Visuals
	for _,v in next, self.m_animationList do
		if v ~= nil then
			v:Update(m_time);
		end
	end
end

function Client:IsCasting()
	return self.m_casting;
end

function Client:IsOnGCD()
	return self.m_gcdTimer > 0;
end

function Client:SetCasting(cTime)
	self.m_castTime = cTime;
end

function Client:StopCasting(spell)
	self.m_casting = false;
	
	if spell == nil then return end;
	
	if spell.Name == "48" then
		for _,v in next, self.m_vfxList do
			if v.spell.Name == "48" then
				v:Cancel();
			end
		end
	end
end

function Client:SetOnGCD(m_time)
	self.m_gcdTimer = m_time;
end

function Client:GetTarget()
	return self.m_target;
end

-- Objects --
local client = Client.new();
local m_playerGUI = UI.new(player, pGUI.MainGui.Frame.Player, pGUI.MainGui.Frame.Target, pGUI.ActionBar, pGUI.CastBar, pGUI.LoginGUI)

function Client:UpdateTarget(data)
	m_playerGUI:UpdateTarget(data);
	self.m_target = data.link
end

function Client:LoadClass(Name, SpellList)
	self.m_spellList = SpellList;
	self.m_className = Name;
	m_playerGUI:LoadClass(Name, SpellList);
end

game:service'RunService'.Heartbeat:connect(function(deltaTime)
	client:Update(deltaTime)
	m_playerGUI:Update(deltaTime)
end)

local character = game.Workspace:WaitForChild(player.Name)
local server_opcodes={
	["SMSG_SEND_COMBAT_TEXT"]=function(message, object, combat, positive_negative, absorb)
		if message == 0 and absorb == false then
			message = "Immune"
		elseif absorb == true then
			message = "Absorb"
		end
		CombatText.sendMessage(message, object, combat, positive_negative);
	end,
	["SMSG_SEND_CAST_REQUEST"]=function(player, spell, target, ...)
		local packet = Opcodes.FindServerPacket("SMSG_CAST_SPELL");
		if packet then packet:FireServer(spell, target, ...); end
	end,
	["SMSG_CAST_FAILED"]=function(spell, reason)
		if reason  == "global cooldown" or reason == "casting" then
			m_playerGUI:HandleError("Spell is not ready yet");
		elseif reason == "moving" then
			m_playerGUI:HandleError("Can't do that while moving");
		elseif reason == "mana" then
			m_playerGUI:HandleError("You can't do that yet");
		elseif reason == "disabled" then
			m_playerGUI:HandleError("You can't do that yet");
		elseif reason == "needs_target" then
			m_playerGUI:HandleError("You have no target");
		elseif reason == "dead_target" or reason == "invalid_target" then
			m_playerGUI:HandleError("Invalid target");
		elseif reason == "silenced" then
			m_playerGUI:HandleError("You are silenced");
		elseif reason == "dead" then
			m_playerGUI:HandleError("You are dead");
		elseif reason == "distance" then
			m_playerGUI:HandleError("Out of range");
		elseif reason == "facing" then
			m_playerGUI:HandleError("You must face your target");
		end
	end,
	["SMSG_UPDATE_TARGET"]=function(data)
		client:UpdateTarget(data);
	end,
	["SMSG_CAST_CANCELED"]=function(data)
		local caster = data.caster
		local spell = data.spell;
		
		for _,v in next, client.m_spellList do
			if v.spell == spell then
				v.canceled = true;
			end
		end
		
		Animation.ClearAnimation(caster)
		if caster == game.Players.LocalPlayer then
			client:StopCasting(spell);
			m_playerGUI:CancelCast();
		end
		-- Not elseif because the player may be targetting himself
		if caster == m_playerGUI:GetTarget() then
			m_playerGUI:CancelTargetCast();
		end
	end,
	["SMSG_UPDATE_STAT"]=function(data)
		m_playerGUI:UpdateStat(data)
	end,
	["SMSG_INIT_DUEL"]=function(data)
		local caster = data.Initiator
		local target = data.Target;
		if target == player then
			-- We are the target of the duel, ask if we want to accept or decline
			m_playerGUI:AskDuel(caster);
		end
	end,
	["SMSG_CHAR_LIST"]=function(data)
		local list = data.List;
		
		-- Disable Character creation if max chars are made
		if #list == 6 then
			m_playerGUI:DisableCharCreation();
		else
			m_playerGUI:EnableCharCreation();
		end
		
		m_playerGUI:DisplayCharacters(list);
	end,
	["SMSG_UPDATE_STATE"]=function(data)
		if data.State == "UNIT_STATE_STUNNED" then
			if data.Bool == true then
				local new_move = MovementHandler.new(game.Players.LocalPlayer, "Stun", data.Duration);
				table.insert(client.m_moveList, new_move);
				new_move:Make();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Stun" then
						v:Cancel();
						table.remove(client.m_moveList, i);
					end
				end
			end
		elseif data.State == "UNIT_STATE_FEARED" then
			if data.Bool == true then
				local new_move = MovementHandler.new(game.Players.LocalPlayer, "Fear", data.Duration);
				table.insert(client.m_moveList, new_move);
				new_move:Make();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Fear" then
						v:Cancel();
						table.remove(client.m_moveList, i);
					end
				end
			end
		elseif data.State == "UNIT_STATE_SILENCED" then
			if data.Bool == true then
				local new_move = MovementHandler.new(game.Players.LocalPlayer, "Silence", data.Duration);
				table.insert(client.m_moveList, new_move);
				new_move:Make();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Silence" then
						v:Cancel();
						table.remove(client.m_moveList, i);
					end
				end
			end
		elseif data.State == "UNIT_STATE_ROOTED" then
			if data.Bool == true then
				Control:Root();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Root" then
						Control:Unroot();
						table.remove(client.m_moveList, i);
					end
				end
			end
		elseif data.State == "UNIT_STATE_DISORIENTED" then
			if data.Bool == true then
				local new_move = MovementHandler.new(game.Players.LocalPlayer, "Disorient", data.Duration);
				table.insert(client.m_moveList, new_move);
				new_move:Make();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Disorient" then
						v:Cancel();
						table.remove(client.m_moveList, i);
					end
				end
			end
		elseif data.State == "UNIT_STATE_SLOWED" then
			if data.Bool == true then
				local new_move = MovementHandler.new(game.Players.LocalPlayer, "Slowed", data.Duration);
				table.insert(client.m_moveList, new_move);
				new_move:Make();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Slowed" then
						v:Cancel();
						table.remove(client.m_moveList, i);
					end
				end
			end
		elseif data.State == "UNIT_STATE_INCAPACITATED" then
			if data.Bool == true then
				local new_move = MovementHandler.new(game.Players.LocalPlayer, "Incapped", data.Duration);
				table.insert(client.m_moveList, new_move);
				new_move:Make();
			else
				for i,v in next, client:GetMoves() do
					if v.moveType == "Incapped" then
						v:Cancel();
						table.remove(client.m_moveList, i);
					end
				end
			end
		end
	end,
	["SMSG_DUEL_ACCEPTED"]=function(data)
		if data.initiator == player or data.target == player then
			m_playerGUI:DuelAccepted();
		end
	end,
	["SMSG_JOIN_WORLD"]=function(data)
		--TODO: Make this more sophisticated
		local charName = data.CharacterName
		m_playerGUI:UpdateCharacter(charName);
		client.loggedIn = true;
	end,
	["SMSG_SELECT_ELECTIVES"]=function(data)
		m_playerGUI:UpdateElectives(data);
	end,
	["SMSG_SPELL_COOLDOWN"]=function(data)
		local spell = data.Spell
		m_playerGUI:SetOnCooldown(spell);
	end,
	["SMSG_SPELL_RESET_COOLDOWN"]=function(data)
		local spell = data.Spell
		m_playerGUI:ResetCooldown(spell);
	end,
	["SMSG_UPDATE_CHARGES"]=function(data)
		local spell = data.Spell
		local charges = data.Charges
		m_playerGUI:UpdateCharges(spell, charges);
	end,
	["SMSG_LOCK_SCHOOL"]=function(data)
		local School = data.School
		local Duration = data.Duration;
		m_playerGUI:LockSchool(School, Duration);
	end,
	["SMSG_LOAD_CLASS"]=function(data)
		local Name = data.Name
		local SpellList = data.SpellList
		client:LoadClass(Name, SpellList);
		m_playerGUI:LoadBars();
	end,
	["SMSG_LOAD_SPELLBOOK"]=function(data)
		m_playerGUI:LoadSpellBook();
	end,
}

--------------------------------------------------
-- Get a reference to the UserInputService
local UserInputService = game:GetService("UserInputService")

local function getClientSpell(keyCombination, player)
	for spell,v in next, client:GetSpellList() do
		if v.m_keyBinding == keyCombination then
			return v;
		end
	end
end

local function CanCast()
	if game.Players.LocalPlayer.PlayerGui.MenuGui.MenuBox.Visible == true or game.Players.LocalPlayer.PlayerGui.MenuGui.Keybindings.Visible == true then
		return false
	end
	return true
end

local keyNameToNumeral = {
	["One"] = "1",
	["Two"] = "2",
	["Three"] = "3",
	["Four"] = "4",
	["Five"] = "5",
	["Six"] = "6",
	["Seven"] = "7",
	["Eight"] = "8",
	["Nine"] = "9",
	["Zero"] = "0",
	["Backquote"] = "`",
	["Tab"] = "nil";
}

UserInputService.InputBegan:Connect(function(input)
	if client.loggedIn == false then return nil end;

	if not CanCast() then return nil end;
	
	
	
	-- Determine the key combination
	local keyCombination
	local keyPressed = keyNameToNumeral[input.KeyCode.Name] or input.KeyCode.Name
	if (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) then
		keyCombination = "Shift + " .. keyPressed
	else
		keyCombination = keyPressed
	end
	keyCombination = string.lower(keyCombination);
	
	local clientSpell = getClientSpell(keyCombination, player)
	if not clientSpell then return end

	local spellId = tostring(clientSpell.m_spellId)
	local spell = clientSpell.spellInfo;
	local spellFlags = spell.SpellFlags
	
	if spellFlags:FindFirstChild("SPELL_FLAG_MOUSE") then
		local scr = player.Backpack.Scripts.clientserver.MousePosition
		if scr.Enabled == false then
			if clientSpell.m_cooldownTime == 0 and client:IsOnGCD() == false then
				scr.Spell.Value = spell
				scr.Size.Value = spell:FindFirstChild("CircleSize").Value
				scr.Enabled = true
				return;
			else
				return;
			end
		end
	end
	
	if not spell then return end

	--[[if client:IsOnGCD() or clientSpell:GetAttribute("m_cooldownTime") > 0 or client:IsCasting() then
		return
	end]]

	local packet = Opcodes.FindServerPacket("CMSG_CAST_SPELL")
	packet:FireServer(keyCombination)
end)


---------------------------------------------------------

function OnChatted(msg)
	if client.loggedIn == false then return nil end;
	if msg then
		local packet=Opcodes.FindServerPacket("CMSG_CHATMESSAGE_SAY");
		packet:FireServer(msg);
	end
end

player.Chatted:connect(OnChatted);

------------------------------------------------------------



----------------------------------------------------------------

-- Build packet and invoke it
function PlayerMoveFreefall(active)
	if client.loggedIn == nil then return end;
	if not active then
		local packet=Opcodes.FindServerPacket("CMSG_MOVE_FALL_LAND");
		packet:FireServer(active);
	end
end
---------------------------------------------------------
character.Humanoid.FreeFalling:connect(PlayerMoveFreefall);

-- Build packet and invoke it
function PlayerMoveJump(active)
	if client.loggedIn == nil then return end;
	if active then
		local packet=Opcodes.FindServerPacket("CMSG_MOVE_JUMP");
		packet:FireServer(active);
	end
end
---------------------------------------------------------
character.Humanoid.Jumping:connect(PlayerMoveJump);

-----------------------------------------------------------

function MyCastFailed2(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_CAST_FAILED"],...);
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_CAST_FAILED").OnClientEvent:connect(MyCastFailed2);


----------------------------------------------------------------------------


local CombatText = require(workspace.CombatText);

function ParseServerPacket(p,...)
	if p then
		if server_opcodes[p.Name] then
			server_opcodes[p.Name](...);
		end
	end
end

function MyCastFailed1(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_SEND_COMBAT_TEXT"],...);
end

function PlayerJoinWorld(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_JOIN_WORLD"],...);
end

function UpdateTarget(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_UPDATE_TARGET"],...);
end

function UpdateStat(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_UPDATE_STAT"], ...)
end

function CancelCast(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_CAST_CANCELED"], ...);
end

function InitDuel(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_INIT_DUEL"], ...);
end

function GetCharList(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_CHAR_LIST"], ...);
end

function HandleState(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_UPDATE_STATE"], ...);
end

function SelectElectives(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_SELECT_ELECTIVES"], ...);
end

function DuelAccepted(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_DUEL_ACCEPTED"], ...);
end

function SpellCooldown(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_SPELL_COOLDOWN"], ...);
end

function ResetCooldown(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_SPELL_RESET_COOLDOWN"], ...);
end


function UpdateCharges(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_UPDATE_CHARGES"], ...);
end

function LockSchool(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_LOCK_SCHOOL"], ...);
end

function LoadClass(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_LOAD_CLASS"], ...);
end

function LoadBook(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_LOAD_SPELLBOOK"],...);
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_UPDATE_STAT").OnClientEvent:connect(UpdateStat)
game:service("ReplicatedStorage"):WaitForChild("SMSG_SEND_COMBAT_TEXT").OnClientEvent:connect(MyCastFailed1)
game:service("ReplicatedStorage"):WaitForChild("SMSG_UPDATE_TARGET").OnClientEvent:connect(UpdateTarget)
game:service("ReplicatedStorage"):WaitForChild("SMSG_INIT_DUEL").OnClientEvent:connect(InitDuel)
game:service("ReplicatedStorage"):WaitForChild("SMSG_CHAR_LIST").OnClientEvent:connect(GetCharList)
game:service("ReplicatedStorage"):WaitForChild("SMSG_UPDATE_STATE").OnClientEvent:connect(HandleState)
game:service("ReplicatedStorage"):WaitForChild("SMSG_JOIN_WORLD").OnClientEvent:connect(PlayerJoinWorld)
game:service("ReplicatedStorage"):WaitForChild("SMSG_CAST_CANCELED").OnClientEvent:connect(CancelCast)
game:service("ReplicatedStorage"):WaitForChild("SMSG_SELECT_ELECTIVES").OnClientEvent:connect(SelectElectives)
game:service("ReplicatedStorage"):WaitForChild("SMSG_DUEL_ACCEPTED").OnClientEvent:connect(DuelAccepted);
game:service("ReplicatedStorage"):WaitForChild("SMSG_SPELL_COOLDOWN").OnClientEvent:connect(SpellCooldown);
game:service("ReplicatedStorage"):WaitForChild("SMSG_SPELL_RESET_COOLDOWN").OnClientEvent:connect(ResetCooldown);
game:service("ReplicatedStorage"):WaitForChild("SMSG_UPDATE_CHARGES").OnClientEvent:connect(UpdateCharges);
game:service("ReplicatedStorage"):WaitForChild("SMSG_LOCK_SCHOOL").OnClientEvent:connect(LockSchool);
game:service("ReplicatedStorage"):WaitForChild("SMSG_LOAD_CLASS").OnClientEvent:connect(LoadClass);
game:service("ReplicatedStorage"):WaitForChild("SMSG_LOAD_SPELLBOOK").OnClientEvent:connect(LoadBook);

--------------------------------------------------------------------------
function HandleCastRequest(...)
	ParseServerPacket(game:service'ReplicatedStorage'["SMSG_SEND_CAST_REQUEST"],...);
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_SEND_CAST_REQUEST").OnClientEvent:connect(HandleCastRequest);

------------------------------------------------------------------------------------------------------
--SMSG_SPELL_GO
local next=next
local pcall=pcall
local player=game.Players.LocalPlayer
local character=player.Character
local rs=game:service'ReplicatedStorage';
local SVH = require(workspace.SpellVisualHandler);
local anim = require(player.Backpack.Scripts.AnimationHandler)

function cast(data)
	local CastFlags = data.CastFlags;
	local Target = data.Target;
	local CastTime = data.CastTime;
	local Extra = data.Extra;
	local Spell = data.Spell;
	local SpellTime = data.SpellTime;
	local ManaCost = data.ManaCost;
	local IsSpellQueueSpell = data.IsSpellQueueSpell;
	local AnimationEnabled = data.AnimationEnabled;
	local Caster = data.Caster;
	local Position = data.AoEPosition
	local VisualOnCast = data.VOC;
	
	if Caster == player then
		client:StopCasting(nil);
		if not m_playerGUI:IsOnCooldown(Spell) and not Spell.SpellFlags:findFirstChild("SPELL_FLAG_OVERRIDE") and Spell.CooldownValue.Value > 0 then
			m_playerGUI:SetOnCooldown(Spell)
		end
	end	
	
	if VisualOnCast == false then
		local newAnimation = require(script.SpellAnimationHandler).new(Caster, Target, Spell, Position, m_playerGUI)
		newAnimation:Cast()
		table.insert(client.m_vfxList, newAnimation);
	end
	
	if AnimationEnabled == true then
		anim.Finish(Caster, Spell);
	end
	SVH.EndSpellVisual(Caster);
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_SPELL_GO").OnClientEvent:connect(cast);

---------------------------------------------------------------------------------------------
-- SMSG_SPELL_START
local player=game.Players.LocalPlayer
local character=player.Character
local rs=game:service'ReplicatedStorage';
local anim = require(player.Backpack.Scripts.AnimationHandler)

function CastSpell(data)
	local CastFlags = data.CastFlags;
	local Target = data.Target;
	local Player = data.Player;
	local CastTime = data.CastTime;
	local Extra = data.Extra;
	local m_spellInfo = data.Spell;
	local ManaCost = data.ManaCost;
	local GlobalCooldown = data.GCD;
	local IsSpellQueueSpell = data.IsSpellQueueSpell;
	local Caster = data.Caster;
	local Position = data.AoEPosition;
	local AnimationEnabled = data.AnimationEnabled;
	local VisualOnCast = data.VOC;
	local Moving = data.Moving;
	
	local new_spell = {spell = m_spellInfo, canceled = false};
	table.insert(client.m_spellList, new_spell)
	
	if AnimationEnabled == true then
		if new_spell.canceled == false then
			anim.CastSpell(Caster, m_spellInfo, CastTime);
		end
	end
	
	-- Check for visual on cast (does the spell visual when we first start casting)
	if VisualOnCast == true then
		local newAnimation = require(script.SpellAnimationHandler).new(Caster, Target, m_spellInfo, Position, m_playerGUI)
		newAnimation:Cast()
		table.insert(client.m_vfxList, newAnimation);
		
		-- Handles if spell is canceled
		-- Fixes a bug in spellcasting where player canceled the spell the moment it was cast,
		-- causing this opcode to be sent but the SMSG_CANCEL_CAST opcode at the same time,
		-- resulting in non-canceled visuals on client-side
		if new_spell.canceled == true then
			newAnimation.script.Interrupted.Value = true;
			Animation.ClearAnimation(Caster)
		end
	end
	
	SVH.CastSpellVisual(Caster, m_spellInfo);
	if Caster == player then

		-- Check for Mouse-Targeted AoE Spell
		if m_spellInfo.SpellFlags:findFirstChild'SPELL_FLAG_MOUSE_TARGET' then
			m_playerGUI:CastPlacementSpell(m_spellInfo);
			return;
		end
		if CastTime > 0 then
			client:SetCasting(CastTime);
			m_playerGUI:SetCasting(CastTime)
			m_playerGUI:UpdateSpell(m_spellInfo)
			if (client:GetTarget() == player) then
				m_playerGUI:CastTargetSpell(m_spellInfo);
			end
		end
		if not m_spellInfo.SpellFlags:findFirstChild'SPELL_FLAG_IGNORES_GCD' and not m_spellInfo.SpellFlags:findFirstChild'SPELL_FLAG_CUSTOM_GCD' then
			if GlobalCooldown > 0 then
				m_playerGUI:SetOnGCD(GlobalCooldown)
				client:SetOnGCD(GlobalCooldown);
			else
				m_playerGUI:SetOnGCD(1.5);
				client:SetOnGCD(1.5);
			end
		elseif m_spellInfo.SpellFlags:findFirstChild'SPELL_FLAG_CUSTOM_GCD' then
			m_playerGUI:SetCustomGCD(m_spellInfo);
		end
	end
	if Caster == m_playerGUI:GetTarget() then
		if CastTime > 0 then
			m_playerGUI:SetTargetCastingCastTime()
			m_playerGUI:UpdateTargetSpell(m_spellInfo)
		end
	end
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_SPELL_START").OnClientEvent:connect(CastSpell);

--Update Aura
function UpdateAura(data)
	local caster = data.Caster
	local target = data.Target
	local aura = data.Aura
	local Key = data.Key
	local Duration = data.Duration;
	local Stacks = data.Stacks;
	--print(Key);
	if target == m_playerGUI:GetTarget() then -- Update target frame if local player is targetting the data.target
		m_playerGUI:UpdateAura(caster, target, aura, Key, "target", Duration, Stacks);
	end
	
	if target == player then -- Update local player aura list if target is local player
		m_playerGUI:UpdateAura(caster, target, aura, Key, "player", Duration, Stacks)
	end
	
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_AURA_UPDATE").OnClientEvent:connect(UpdateAura);

--Apply Aura
function ApplyAura(data)
	local caster = data.Caster
	local target = data.Target
	local aura = data.Aura
	local Key = data.Key
	local Duration = data.Duration;

	--print(Key);
	if target == m_playerGUI:GetTarget() then -- Update target frame if local player is targetting the data.target
		m_playerGUI:UpdateAura(caster, target, aura, Key, "target", Duration);
	end

	if target == player then -- Update local player aura list if target is local player
		m_playerGUI:UpdateAura(caster, target, aura, Key, "player", Duration)
	end

	local newAnimation = require(script.AuraAnimationHandler).new(caster, target, aura, Duration, m_playerGUI)
	table.insert(client.m_animationList, newAnimation);
	newAnimation:Cast()

	--if caster == player then
	--m_playerGUI:UpdateAura(caster, target, auraInfo, Key, "player", Duration)
	--end
end

game:service("ReplicatedStorage"):WaitForChild("SMSG_APPLY_AURA").OnClientEvent:connect(ApplyAura);

--UPDATE TARGET
local next=next
local pcall=pcall
local player = game.Players.LocalPlayer
local mouse = player:GetMouse();
local MainGui = player.PlayerGui.MainGui;
local ContextActionService = game:GetService("ContextActionService")
local FREEZE_ACTION = "freezeMovement"
-------------------------
local function createHighlight(targetParent)
	local highlight = game:service('ReplicatedStorage').UnitObjects.TargetHighlight:Clone()
	highlight.Parent = targetParent
	highlight.OutlineTransparency = 0
	highlight.Adornee = targetParent
	return highlight
end

local function removeOldHighlight(link)
	if link ~= nil then
		if link:IsA("Player") then
			link = link.Character
		end
		if link:FindFirstChild("TargetHighlight") then
			link.TargetHighlight:Destroy()
		end
	end
end

local function updateTarget(targetParent, playerOrNPC)
	local tarGui = player.PlayerGui.MainGui.Frame.Target
	local packet = Opcodes.FindServerPacket("CMSG_UPDATE_TARGET")
	packet:FireServer(playerOrNPC)
	tarGui.Visible = true
	createHighlight(targetParent)
end

mouse.Button1Down:Connect(function()
	if client.loggedIn == true then
		local target = mouse.Target
		if target and target.Parent.ClassName == "Model" then
			local playerOrNPC

			for _, v in ipairs(target.Parent:GetChildren()) do
				if v.Name == "NPC Value" then
					playerOrNPC = target.Parent
					break
				end
			end

			if not playerOrNPC then
				playerOrNPC = game.Players:GetPlayerFromCharacter(target.Parent)
			end

			if playerOrNPC then
				removeOldHighlight(client:GetTarget())
				updateTarget(target.Parent, playerOrNPC)
			end
		end
	end
end)


