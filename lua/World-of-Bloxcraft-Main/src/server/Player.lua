local Player = {}
Player.__index = Player

local next=next
local pcall=pcall
local Opcodes = require(workspace.Opcodes);
local SpellQueue = require(workspace.SpellQueue);
local Spell = require(workspace.Spell)
local Duel = require(workspace.DuelHandler)

function Player.new(link, char, target, unitLink)
	local new_player = {}
	setmetatable(new_player, Player)
	
	new_player.link = link
	new_player.char = char
	new_player.target = target
	new_player.bp = link.Backpack
	new_player.UnitLink = unitLink
	new_player.m_ffa = false
	new_player.m_modDamage = 1;
	new_player.m_duelObject = nil;
	
	return new_player
	
end

function Player:GetModDamageDonePercent(school)
	return self.m_modDamage; --TODO: Change this to implement school
end

function Player:Update(m_time)
	-- Duel
	if self.m_duelObject ~= nil then
		self.m_duelObject:Update(m_time);
	end
end

function Player:GetDuelTarget()
	return self.m_duelObject.target;
end

function Player:HasDuel()
	return self.m_duelObject ~= nil
end

function Player:AcceptDuel()
	local duel = self.m_duelObject;
	duel:Accept();
	local data, packet = {}, Opcodes.FindClientPacket("SMSG_DUEL_ACCEPTED");
	data.Initiator = duel.initiator.link
	data.Target = duel.target.link;
	Opcodes.SendMessageToSet(self.link, packet, data);
end

function Player:DeclineDuel()
	local target = self.m_duelObject.target;
	self.m_duelObject = nil
	target.m_duelObject = nil;
end

function Player:CancelDuel()
	self.m_duelObject = nil;
end

function Player:IsInDuel(target)
	if self:GetDuel() then
		if self.m_duelObject.target.link == target.link or self.m_duelObject.initiator.link == target.link then
			if self.m_duelObject.m_started == true then
				return true
			end
		end
	end
	return false;
end

function Player:GetDuel()
	return self.m_duelObject;
end

function Player:InitiateDuel(target)
	if target:ToPlayer() ~= nil then
		local duel = Duel.new(self, target:ToPlayer());
		self.m_duelObject = duel;
		target:ToPlayer().m_duelObject = duel;
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_INIT_DUEL");
		data.Initiator = self.link
		data.Target = target.link;
		Opcodes.SendMessageToSet(self.link, packet, data);
	end
end

function Player:ToUnit()
	return self.UnitLink;
end

function Player:ToSpell()
	return self.UnitLink:ToSpell()
end

function Player:ToObject()
	return self.playerObject
end

function Player:ToChar()
	return self.char
end

function Player:GetTarget()
	return self.target
end

function Player:UpdateTarget(new_target)
	self.target:UpdateTargetData(new_target) -- Updates all data from the new target
end

function Player:IsMoving()
	return self.bp:findFirstChild'IsMoving'.Value;
end

function Player:FindNearestEnemy()
	
end

function Player:IsCasting()
	if self.bp:findFirstChild'IsCasting'.Value == true then
		return true
	end
	return false
end

function Player:RemoveGCD()
	if self.playerObject then
		if self.bp then
			local gcd = self.bp:findFirstchild'onGlobalCooldown';
			if gcd.Value > 0 then
				gcd.Value = 0
			end
		end
	end
end

function Player:SetGCDActive()
	if self.playerObject then
		if self.bp then
			local gcd = self.bp:findFirstChild'onGlobalCooldown';
			if gcd.Value == 0 then
				gcd.Value = 1.5
			end
		end
	end
end

Player.FindNearestEnemyPlayer = function(player)
	if player and player.Character then
		local lowest=math.huge
		local nearestenemy=nil
		for _,v in next,game.Players:GetPlayers() do wait()
			if v and Player.IsAttackable(v) then
				if v.Character then
					local distance=v:DistanceFromCharacter(player.Character.Torso.Position)
					if distance<lowest then
						lowest=distance
						v=nearestenemy;
					end
				end
			end
		end
		return nearestenemy;
	end
end

Player.FindNearestEnemyPlayers = function(player)
	local enemiesList={};
	if player and player.Character then
		local nearestenemy=nil
		for _,v in next,game.Players:GetPlayers() do wait()
			if v and Player.IsAttackable(v) then
				if v.Character then
					local char=v.Character
					local distance=v:DistanceFromCharacter(char.Head.Position);
					if distance<20 then
						table.insert(enemiesList,v);
					end
				end
			end
		end
		return enemiesList
	end
end

function Player:SetFFA(bool)
	self.m_ffa = bool
end

Player.SetFFAEnabled = function(player, bool)
	if player and player:findFirstChild'Backpack' and player.Backpack:findFirstChild'FFAEnabled' then
		player.Backpack.FFAEnabled.Value = bool;
	end
end

function Player:GetSpellList()
	return self.SpellList
end

function Player:CastSpell(spellId, target)
	local packet = Opcodes.FindClientPacket("SMSG_SEND_CAST_REQUEST")
	packet:FireClient(self.link, spellId, target)
end

return Player
