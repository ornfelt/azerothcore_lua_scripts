local Opcodes = require(workspace.Opcodes);
local Database = require(workspace.DatabaseHandler);
local Player = require(workspace.Player)
local Spell = require(workspace.Spell)
local Aura = require(workspace.Spell.Aura)
local Duel = require(workspace.DuelHandler);
local CreatureHandler = require(script.CreatureHandler);
local Location = require(workspace.LocationHandler);
local Movement = require(workspace.MovementHandler);
local Bit = require(workspace.Bit);
local SD = require(workspace.SharedDefines);
local EventHandler = require(workspace.EventHandler);

local Unit = {
	TypeIds = {
		TYPEID_PLAYER = 1;
		TYPEID_UNIT = 2;
		TYPEID_CREATURE = 3;	
	}
};
Unit.__index = Unit

function Unit.new(link, typ, map, Name, entryId)
	local new_unit = {}
	setmetatable(new_unit, Unit)
	
	new_unit.Name = Name;
	new_unit.link = link
	new_unit.typ = typ
	new_unit.m_player = nil
	new_unit.m_silenced = false
	new_unit.map = map;
	new_unit.m_entryId = 0;
	new_unit.flags = {}
	
	new_unit.summoner = nil;
	
	new_unit.m_alive = true
	new_unit.m_casting = false
	new_unit.m_Health = 1000
	new_unit.m_maxHealth = 1000
	new_unit.m_Mana = 5000
	new_unit.m_maxMana = 5000
	new_unit.m_spellList = {}
	
	new_unit.eventList = {};
	
	new_unit.auraStates = {
		AURA_STATE_NONE = false,
		AURA_STATE_FROZEN = false
	};
	
	new_unit.m_Spell = nil
	new_unit.target = nil
	
	-- Absorb
	new_unit.m_absorbAmount = 0;
	
	-- buffs/debuffs
	new_unit.m_debuffs = {}
	new_unit.m_buffs = {}
	
	new_unit.m_isMoving = false
	
	new_unit.m_classId = 1;
	new_unit.m_specId = 2;
	
	new_unit.m_Mana = 100
	new_unit.m_MaxMana = 100
	
	new_unit.m_Head = nil -- Links to unit's in-game head
	
	new_unit.m_auraList = {}
	
	new_unit.m_creature = nil -- Links to creaturescript if unit is a creature
	
	new_unit.m_combatList = {} -- List of units the player is in combat with, if empty, player leaves combat after 3 seconds
	new_unit.m_combatTimer = 0;
	
	new_unit.m_duel = nil; -- Links to DuelHandler object
	
	new_unit.m_manaTickTimer = 1;
	new_unit.m_manaTickAmount = 3;
	new_unit.m_manaTickAmountCombat = 1;
	
	new_unit.m_mousePos = nil; -- Gets log of current mouse position
	
	new_unit.movement = Movement.new(new_unit); -- Allows for execution of movement-related functions
	
	new_unit.DRHandler = require(script.DRHandler).new() -- Handles all DR functions
	
	new_unit.m_unitStateList = {}
	
	new_unit.m_auraKeyCounter = 0; -- Keeps track of individual aura keys on target (deprecated)
	
	new_unit.m_petList = {};    -- List of pets linked to the unit
	
	new_unit.m_MaxGCDTime = 1.5; -- The highest the GCD could ever be
	new_unit.m_gcdTimeMod = 0;
	new_unit.m_gcdTime = 0;
	
	new_unit.m_queuedNum = 0;
	
	new_unit.Active = false; -- determines if unit is inside of the game world and can be acted upon
	
	new_unit.m_inStealth = 0
	new_unit.m_stealthVal = 100; -- Value from 0 to 100 that determines how hard it is to find you in stealth
	new_unit.m_detectionVal = 5; -- Value from 0 to 100 that determines how easy it is for you to find others in stealth
	new_unit.m_detectedEnemies = {};
	
	new_unit.m_schoolLockTimers = { -- Timers on how long each school is locked out for
		["Fire"] = 0,
		["Frost"] = 0,
		["Arcane"] = 0
	}
	new_unit.m_interruptSchools = { -- How long each school can be locked out for
		["Fire"] = 6,
		["Frost"] = 6,
		["Arcane"] = 6
	}
	
	
	new_unit.m_immunities ={ -- Which spellType's the player is immune to taking damage from
		["Fire"] = false,
		["Frost"] = false,
		["Arcane"] = false
	}
	
	-- Player-related functions
	if new_unit.link:IsA("Player") then
		new_unit.m_Head = new_unit.link.Character.Head
		new_unit.m_HRP = new_unit.link.Character.HumanoidRootPart
		new_unit.m_player = Player.new(link, link.Character, nil, new_unit)
		new_unit.movement.model = new_unit.link.Character
		new_unit.movement.human = new_unit.link.Character.Humanoid
		new_unit.character = new_unit.link.Character
	else
		new_unit.m_Head = new_unit.link.Head
		new_unit.m_HRP = new_unit.link.HumanoidRootPart
		new_unit.movement.model = new_unit.link
		new_unit.movement.human = new_unit.link.Humanoid
		new_unit.character = new_unit.link
	end
	
	new_unit.location = Location.new(new_unit, map); -- Handles location-based functions
	
	
	-- Make creaturescript
	if new_unit.typ == "Creature" then
		new_unit.m_creature = CreatureHandler.new(link, new_unit, entryId);
	end
	
	new_unit.stats = { -- Base stats
		["stamina"] = 1000,
		["strength"] = 10,
		["speed"] = 10,
		["intellect"] = 50,
		["agility"] = 10,
		["haste"] = 10,
	}
	
	return new_unit
end

function Unit:LoadFromDB()
	if self.link:IsA("Player") then
		return;
	end
	
	
end

function Unit:GetClass()
	if self.m_classId == 1 then
		return "Mage"
	end
end

function Unit:GetSpecialization()
	if self.m_specId == 1 then
		return "Fire";
	elseif self.m_specId == 2 then
		return "Frost";
	end
end

function Unit:AddAuraState(state)
	if state == "Frozen" then
		self.auraStates.AURA_STATE_FROZEN = true;
	end
end

function Unit:RemoveAuraState(state)
	if state == "Frozen" then
		self.auraStates.AURA_STATE_FROZEN = false;
	end
end

function Unit:ToMap()
	return self.map
end

function Unit:ToCreature()
	return self.m_creature;
end

function Unit:SetGCDMod(m_time)
	self.m_gcdTimeMod = m_time;
end

function Unit:SendCooldownOpcode(spellId)
	local spell = game.Lighting.Spells:findFirstChild(tostring(spellId));
	if spell then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_SPELL_COOLDOWN");
		data.Spell = spell
		packet:FireClient(self.link, data)
	end
end

function Unit:SendResetCooldownOpcode(spellId)
	local spell = game.Lighting.Spells:findFirstChild(tostring(spellId));
	if spell then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_SPELL_RESET_COOLDOWN");
		data.Spell = spell
		packet:FireClient(self.link, data)
	end
end

function Unit:LoadClass(class)
	local Class = require(workspace.ClassHandler);
	self.mage = Class.new("Mage", self);
	self.mage:Load();
end

function Unit:FaceSameDirection(target)
	local unitChar;
	local targetChar
	local unit = self
	if unit.link:IsA("Player") then
		unitChar = unit.link.Character;
	else
		unitChar = unit.link
	end
	
	if target.link:IsA("Player") then
		targetChar = target.link.Character
	else
		targetChar = target.link
	end
	
	local targetHumanoid = targetChar:findFirstChild'Humanoid'
	local playerHumanoid = unitChar:findFirstChild'Humanoid';
	-- Get the root parts of target and player
	local targetRootPart = targetHumanoid.Parent:FindFirstChild("HumanoidRootPart")
	local playerRootPart = playerHumanoid.Parent:FindFirstChild("HumanoidRootPart")

	if not targetRootPart or not playerRootPart then
		-- If either root part is missing, we can't do anything
		return
	end

	-- Use LookVector to align the target's orientation with the player's
	local direction = playerRootPart.CFrame.LookVector
	targetRootPart.CFrame = CFrame.new(targetRootPart.Position, targetRootPart.Position + direction)
end
function Unit:FaceTarget()
	local char;
	if self.link:IsA("Player") then
		char = self.link.Character
	else
		char = self.link
	end
	
	local charHRP = char.HumanoidRootPart
	
	local target = self:GetTarget();
	local tarChar;
	if target.link:IsA("Player") then
		tarChar = target.link.Character
	else
		tarChar = target.link
	end
	
	local tarHRP = tarChar.HumanoidRootPart
	
	charHRP.CFrame = CFrame.lookAt(charHRP.Position, tarHRP.Position);
end

function Unit:SendChargesUpdate(spellId, charges)
	local spell = game.Lighting.Spells:findFirstChild(tostring(spellId));
	if spell then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_UPDATE_CHARGES");
		data.Spell = spell
		data.Charges = charges;
		packet:FireClient(self.link, data);
	end
end

function Unit:GetSpell(spellId)
	if self:GetSpellList()[tostring(spellId)] then
		return self:GetSpellList()[tostring(spellId)];
	end
end

function Unit:NearTeleportTo(pos)
	self.location:NearTeleportTo(pos);
end

function Unit:IsFacing(unit)
	local tarChar = unit.character
	local char = self.character
	
	local facing = char.HumanoidRootPart.CFrame.lookVector;
	local vector = (tarChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).unit
	local angle = math.acos(facing:Dot(vector))

	if math.deg(angle) < 90 then
		return true
	else
		return false;
	end
end

function Unit:ApplyAllSpellImmunities()
	for immunity, _ in next, self.m_immunities do
		self.m_immunities[immunity] = true;
	end
end

function Unit:RemoveAllSpellImmunities()
	for immunity, _ in next, self.m_immunities do
		self.m_immunities[immunity] = false;
	end
end

function Unit:SetMousePosition(pos)
	self.m_mousePos = pos;
end

function Unit:ResetMouse()
	self.m_mousePos = nil;
end

function Unit:GetMapId()
	return self.location:GetMapId();
end

function Unit:GetDR(typ)
	return self.m_drList[typ];
end

function Unit:ResetDR(typ)
	self.m_drList[typ] = 1;
end

function Unit:GetAbsorbAmount()
	return self.m_absorbAmount;
end

function Unit:SetAbsorbAmount(amt)
	self.m_absorbAmount = amt;
end

function Unit:HalfDR(typ)
	self.m_drList[typ] = self.m_drList[typ] / 2;
end
function Unit:IsInCombat()
	return self.m_combatTimer > 0;
end

function Unit:GetStealthVal()
	return self.m_stealthVal
end

function Unit:GetDetectionVal()
	return self.m_detectionVal
end

function Unit:Stealth()
	self.m_inStealth = 1;
end

function Unit:BreakStealth()
	self.m_inStealth = 0;
end

function Unit:IsInStealth()
	return self.m_inStealth == 1;
end

function Unit:HalfStealth()
	self.m_inStealth = 0.5;
end

function Unit:IsHalfStealthed()
	return self.m_inStealth == 0.5;
end

function Unit:MoveTo(position)
	if self.link then
		if self.link:IsA("Model") then
			if self.link:findFirstChild'Humanoid' then
				self.link.Humanoid:MoveTo(position);
			end
		end
	end
end

function Unit:MovePositionToFirstCollision(unit, distance)
	local function checkObstacleInPath(startPos, direction, distance)
		local ray = Ray.new(startPos, direction * distance)
		local hit, hitPosition = workspace:FindPartOnRay(ray)

		-- Check if hit part is a significant obstacle (for instance, a wall or a steep slope)
		if hit and math.abs(hitPosition.Y - startPos.Y) > self.link.Humanoid.HipHeight then
			return true
		end

		return false
	end
	
	local rootPart = unit.m_HRP

	-- Calculate direction relative to root part's current position
	local direction = rootPart.CFrame.LookVector
	local delta = direction * distance

	-- Check for obstacles in the path
	if checkObstacleInPath(rootPart.Position, direction, distance) then
		print("Obstacle detected, stopping movement.")
		return
	end

	-- Move the humanoid
	self.link.Humanoid:Move(delta)
end




function Unit:CheckStealthDetection()
	local enemies = self.location:GetNearestEnemyUnitList(10)

	for _, enemy in ipairs(enemies) do
		if enemy.Active == false then return nil end;
		if enemy.link == self.link then break end;
		local Target = enemy.link:IsA("Player") and enemy.link.Character or enemy.link
		local Character = self.link:IsA("Player") and self.link.Character or self.link
		local vectorToTarget = Target:WaitForChild("HumanoidRootPart").Position - Character:WaitForChild("HumanoidRootPart").Position
		local distance = vectorToTarget.Magnitude
		local directionToTarget = vectorToTarget.Unit
		local characterFacing = Character.PrimaryPart.CFrame.LookVector
		local dotProduct = characterFacing:Dot(directionToTarget)

		-- calculate the chance of detection based on the Character's detection value and the Target's stealth value
		local detectionChance = self.m_detectionVal / (enemy.m_stealthVal + 1)

		-- adjust the chance based on relative position and distance
		if dotProduct > 0 then  -- Target is in front of Character
			detectionChance = detectionChance * (1 + (0.7 * dotProduct * (1 - distance / 10) ^ 2))
		else  -- Target is to the side or behind Character
			detectionChance = detectionChance * (1 - (0.7 * dotProduct * (1 - distance / 10) ^ 2))
		end

		-- If the enemy is in stealth and within detection range, move them to half-stealth
		if enemy:IsInStealth() and math.random() < detectionChance then
			enemy:HalfStealth()
			self.m_detectedEnemies[enemy] = true;
		end
	end
	
	for enemy,_ in next,self.m_detectedEnemies do
		local Target = enemy.link:IsA("Player") and enemy.link.Character or enemy.link
		local Character = self.link:IsA("Player") and self.link.Character or self.link
		local vectorToTarget = Target:WaitForChild("HumanoidRootPart").Position - Character:WaitForChild("HumanoidRootPart").Position
		local distance = vectorToTarget.Magnitude
		
		-- If the enemy is out of default detection range, move them back to full stealth
		if distance > 10 and enemy:IsHalfStealthed() then
			enemy:Stealth()
			self.m_detectedEnemies[enemy] = nil;
		end
	end
end

function Unit:Absorb(amt)
	self.m_absorbAmount = amt;
end

function Unit:LockSpellSchool(school, duration)
	self.m_schoolLockTimers[school] = duration;
	
	if self.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_LOCK_SCHOOL");
		data.School = school;
		data.Duration = duration;
		packet:FireClient(self.link, data);
	end
end

function Unit:getClientSpell(keyCode)
	for k,v in next, self:GetSpellList() do
		if v.m_keyBinding == keyCode then
			return v;
		end
	end
end

function Unit:GetInterruptSchoolTime(spellInfo)
	return 6
end

function Unit:OverrideSpell(spell)
	if spell then
		local flagVal = spell:GetFlagValue("SPELL_FLAG_OVERRIDE");
		local currentSpell = self:GetSpell(spell.spellId);
		local otherSpell = self:GetSpell(tonumber(flagVal));
		if currentSpell and otherSpell then
			otherSpell.m_keyBinding = currentSpell.m_keyBinding;
			currentSpell.m_keyBinding = nil;
		end
	end
end

function Unit:CancelOverride(spell)
	local spell = game.Lighting.Spells:findFirstChild(tostring(spell));
	if spell then
		local flagVal = spell.SpellFlags:findFirstChild("SPELL_FLAG_OVERRIDE").Value;
		local currentSpell = self:GetSpell(tonumber(spell.Name));
		local otherSpell = self:GetSpell(tonumber(flagVal));
		if currentSpell and otherSpell then
			otherSpell.m_keyBinding = nil;
			currentSpell.m_keyBinding = currentSpell.m_keyBinding
		end
	end
end

function Unit:IsHostile(target)
	if self.link == target.link or self == target then
		return false;
	end
	-- Players in Duel
	if self:ToPlayer() ~= nil and target:ToPlayer() ~= nil then
		if self:ToPlayer():IsInDuel(target:ToPlayer()) then
			return true;
		end
	end
	
	if self:GetFactionId() ~= target:GetFactionId() then
		return true
	end
	
	-- Handle for minions
	if self.summoner ~= nil then
		if self.summoner:ToPlayer() ~= nil and target:ToPlayer() ~= nil then
			-- Check for duel
			if self.summoner:ToPlayer():IsInDuel(target:ToPlayer()) then
				return true;
			end
		end
	end
	return false;
end

function Unit:GetFactionId()
	if self:ToPlayer() ~= nil then
		local tab, fact = Database.Access("characters", "character", self.link.Name, self.Name);
		local fac = fact[1].factionID;
		return fac.Value;
	else
		local tab, fact = Database.Access("world", "creature_template", tostring(self.m_entryId), "factionID");
		local fac = fact[1];
		return fac.Value;
	end
end

function Unit:SetFactionId(val)
	if self:ToPlayer() ~= nil then
		
	else
		local tab, fact = Database.Access("world", "creature_template", self.Name, "factionID");
		local fac = fact[1]
		fac.Value = val
	end
end

function Unit:AddDelayedEvent(t, func)
	local event = EventHandler.new(t, func);
	table.insert(self.eventList, event);
end

function Unit:UpdateBinds(binds)
	self.mage:UpdateBinds(binds);
end

function Unit:UpdateBind(spellId, bind)
	self.mage:UpdateBind(spellId, bind);
end

function Unit:GetClassId()
	return self.m_classId;
end

function Unit:SetInCombat()
	self.m_combatTimer = 6;
	
	local creature = self:ToCreature();

	if creature then
		local scr = creature.m_script;
		if scr then
			if scr.EnterCombat then
				scr:EnterCombat();
			end
		end
	end
end

function Unit:DropCombat()
	self.m_combatTimer = 0;
end

function Unit:GetGCDTime()
	return self.m_gcdTime;
end

local var = 0

function Unit:Update(m_time)
	-- Update death
	if self:GetHealth() <= 0 then
		self:SetHealth(0);
		self.m_alive = false;
		self:StopCasting();
		self:WipeAuras();
		if self.m_duel ~= nil then
			self.m_duel:End();
		end
		--TODO: Remove auras on death;
		if self.m_creature ~= nil then
			self.m_creature:Died();
		end
	end
	
	-- Events
	for k,v in next, self.eventList do
		if v.activated == true then
			self.eventList[k] = nil;
			continue;
		end
		v:Update(m_time);
	end
	
	-- Update player
	if self:ToPlayer() ~= nil then
		self:ToPlayer():Update(m_time)
	end
	
	-- Update DRs
	self.DRHandler:Update(m_time);
	
	-- Stealth
	self:CheckStealthDetection();
	local char = self.link:IsA("Player") and self.link.Character or self.link
	for _,v in next,char:GetDescendants() do
		if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = self.m_inStealth;
		end
	end
	-- Target Update
	if self:HasTarget() then
		if self:GetTarget():IsInStealth() then
			self:DropTarget();
		end
	end
	
	-- Update Schools
	for _,v in next, self.m_schoolLockTimers do
		if v > 0 then
			v = v - m_time
		else
			v = 0;
		end
	end
	
	-- Update MovementHandler
	self.movement:Update(m_time);
	
	-- Update Global Cooldown Timer
	if self.m_gcdTime > 0 then
		self.m_gcdTime = self.m_gcdTime - m_time
	else
		self.m_gcdTime = 0
	end
	
	-- Casting function
	local preparing = false;
	for _,v in next, self.m_spellList do
		if v:GetState() == "SPELL_STATE_PREPARING" then
			preparing = true
			self.m_casting = true;
		end
	end
	
	if preparing == false then
		self:StopCasting();
		self.m_casting = false;
	end
	
	-- Update Creature
	if self:ToCreature() ~= nil then
		self:ToCreature():Update(m_time);
	end
	
	-- Update spells inside of spelllist
	for _,v in next,self.m_spellList do --TODO: Add key for spell to be removed from m_spellList once completed
		if v ~= nil then
			v:Update(m_time)
		end
	end
	
	-- Update Client Spells
	if self.link:IsA("Player") then
		for _,v in next, self:GetSpellList() do
			-- First check for custom GCDs
			if v.CustomGCD ~= nil then
				if v.CustomGCD > 0 then
					v.CustomGCD = v.CustomGCD - m_time;
				else
					v.CustomGCD = 0;
				end
			end
			
			-- now check for cooldowns
			if v.m_cooldownTime > 0 then
				v.m_cooldownTime = v.m_cooldownTime - m_time;
			else
				v.m_cooldownTime = 0;
				
				-- Check for charges
				local spell = v.spellInfo;
				if v.Charges ~= nil then
					if v.Charges < spell.Charges.Value then
						v.Charges = v.Charges + 1;
						
						if v.Charges < spell.Charges.Value then
							v.m_cooldownTime = spell.CooldownValue.Value;
							self:SendCooldownOpcode(v.m_spellId);
						end
						self:SendChargesUpdate(v.m_spellId, v.Charges);
					end
				end
			end
		end
	end
	
	-- Update Auras
	for _,v in next,self.m_auraList do
		v:Update(m_time)
	end
	
	-- Location Update
	self.location:Update(self.m_HRP);
	
	-- Mana Regen
	if self:GetMana() < self:GetMaxMana() then
		if self.m_manaTickTimer > 0 then
			self.m_manaTickTimer = self.m_manaTickTimer - m_time
		else
			if self:IsInCombat() then
				if (self:GetMana() + self.m_manaTickAmountCombat) < self:GetMaxMana() then -- Check if mana amount tick is more less than their max mana(don't want to go over max)
					self:SetMana(self:GetMana() + self.m_manaTickAmountCombat);
				else
					self:SetMana(self:GetMaxMana())
				end
			else
				if (self:GetMana() + self.m_manaTickAmount) < self:GetMaxMana() then -- Same thing as above just for tick amount outside of combat
					self:SetMana(self:GetMana() + self.m_manaTickAmount);
				else
					self:SetMana(self:GetMaxMana())
				end
			end
			self.m_manaTickTimer = 1;
		end
	end
	
	--Handle Combat
	if self:IsInCombat() then
		if #self.m_combatList > 0 then
			for i,v in next,self.m_combatList do
				if v:IsAlive() == false then
					table.remove(self.m_combatList, i);
				end
			end
			if #self.m_combatList == 0 then
				self:DropCombat();
			end
		end
		self.m_combatTimer = self.m_combatTimer - m_time;
		if self.m_combatTimer <= 0 then
			self:DropCombat();
			print("Out of combat!");
		end
	end
end

function Unit:GetSpellList()
	if self.mage ~= nil then
		return self.mage:GetSpellList();
	end
end

function Unit:SetInCombatWith(unit)
	self:SetInCombat()
	unit:SetInCombat()
	table.insert(self.m_combatList, unit)
	table.insert(unit.m_combatList, self);
end

function Unit:SpellCooldown(spellId)
	local spell = game.Lighting.Spells:findFirstChild(tostring(spellId));
	local currentSpell = self:GetSpell(spellId)
	if currentSpell ~= nil then
		currentSpell.m_cooldownTime = spell.CooldownValue.Value
		
		self:SendCooldownOpcode(spellId);
	else
		error("Couldn't find spell when setting cooldown!")
	end
end

function Unit:ResetCooldown(spellId)
	local spel = game.Lighting.Spells:findFirstChild(tostring(spellId));
	local currentSpell = self:GetSpell(spellId)
	if currentSpell ~= nil then
		currentSpell.m_cooldownTime = 0;
		self:SendResetCooldownOpcode(spellId);
	else
		error("Couldn't find spell when setting cooldown!");
	end
end

function Unit:UpdateTargetData(new_target)
	self.link = new_target
	if new_target:IsA("Player") then
		self.typ = "Player"
	else
		self.typ = "Creature"
	end
end

function Unit:Revive()
	self.m_alive = true;
	self:SetHealth(self:GetMaxHealth());
	local packet2 = Opcodes.FindClientPacket("SMSG_UPDATE_STAT")
	local data = {}
	data.Stat = "Health"
	data.Health = self:GetHealth()
	data.MaxHealth = self:GetMaxHealth();
	data.Target = self.link;

	Opcodes.SendMessageToSet(self.link, packet2, data);
end

function Unit:HandleMessage(msg)
	if msg == ".revive" then
		if self.target ~= nil then
			self.target:Revive();
		end
	elseif msg == ".duel" then
		local m_player = self:ToPlayer();
		if m_player then
			m_player:InitiateDuel(self:GetTarget());
		end
	elseif msg == ".absorb" then
		local target = self.target
		if target then
			target:Absorb(60);
		end
	end
end

function Unit:IsOnGCD(spell) -- We need to link to whatever spell we're casting so we can check if it has a custom GCD
	-- First check if the spell we're trying to cast has a custom GCD;
	if spell:HasFlag("SPELL_FLAG_CUSTOM_GCD") then
		-- Now we check the spell and see if we're on GCD with that spell
		local currentSpell = self:GetSpell(spell.spellId);
		if currentSpell then
			if currentSpell.CustomGCD > 0 then
				return true; -- We're on GCD with that individual spell
			else
				return false; -- We're not on GCD with that individual spell so we know it can be cast regardless
			end
		end
	end
	return self.m_gcdTime > 0
end

function Unit:GetGCD()
	return self.m_gcdTime
end

function Unit:BuildSpell(spell, target, pos, customPCT, checkCastable)
	local new_spell = Spell.new(self, spell, target, pos, customPCT, checkCastable)
	table.insert(self.m_spellList, new_spell)
	return new_spell
end

function Unit:GetSpellHistory()
	return self.m_spellList;
end

function Unit:ToSpell()
	return self.m_Spell
end

function Unit:Fear(target, duration)
	if target.DRHandler:CanFear() then
		target:SetState("UNIT_STATE_FEARED");
	else
		return "immune"
	end
	
	-- Send fear opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data,packet = {},Opcodes.FindClientPacket("SMSG_UPDATE_STATE")
		data.State = "UNIT_STATE_FEARED"
		data.Bool = true
		data.Duration = duration
		packet:FireClient(target.link, data);
	else
		target:ToCreature():Fear(duration);
	end
end

function Unit:Stun(target, duration, spellInfo)
	if target.DRHandler:CanStun() then
		target:SetState("UNIT_STATE_STUNNED");
	else
		return "Immune"
	end
	
	-- Send stun opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data,packet = {},Opcodes.FindClientPacket("SMSG_UPDATE_STATE")
		data.State = "UNIT_STATE_STUNNED"
		data.Bool = true
		data.Duration = duration
		data.Spell = spellInfo
		packet:FireClient(target.link, data);
	else
		--target:ToCreature():Stun(duration);
		return true;
	end
end

function Unit:Silence(target, duration, spellInfo)
	if target.DRHandler:CanSilence() then
		target:SetState("UNIT_STATE_SILENCE");
	else
		return "immune"
	end
	
	-- Send silence opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data,packet = {},Opcodes.FindClientPacket("SMSG_UPDATE_STATE")
		data.State = "UNIT_STATE_SILENCED"
		data.Bool = true
		data.Duration = duration
		data.Spell = spellInfo
		packet:FireClient(target.link, data);
		
	else
		target:ToCreature():Silence(duration);
	end
end

function Unit:Root(target, duration, spellInfo)
	if target.DRHandler:CanRoot() then
		target:SetState("UNIT_STATE_ROOT")
	else
		return "immune"
	end
	
	-- Send root opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_UPDATE_STATE");
		data.State = "UNIT_STATE_ROOTED"
		data.Bool = true
		data.Duration = duration
		data.Spell = spellInfo
		packet:FireClient(target.link, data);
	end
end

function Unit:Disorient(target, duration, spellInfo)
	if target.DRHandler:CanDisorient() then
		target:SetState("UNIT_STATE_DISORIENTED")
	else
		return "immune"
	end

	-- Send disorient opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_UPDATE_STATE");
		data.State = "UNIT_STATE_DISORIENTED"
		data.Bool = true
		data.Duration = duration
		data.Spell = spellInfo
		packet:FireClient(target.link, data);
	end
end

function Unit:Slow(target, duration, spellInfo)
	target:SetState("UNIT_STATE_SLOWED")

	-- Send root opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_UPDATE_STATE");
		data.State = "UNIT_STATE_SLOWED"
		data.Bool = true
		data.Duration = duration
		data.Spell = spellInfo
		packet:FireClient(target.link, data);
	end
end

function Unit:Incap(target, duration, spellInfo)
	target:SetState("UNIT_STATE_INCAPACITATED")

	-- Send root opcode if target is player, else handle server-side
	if target.link:IsA("Player") then
		local data, packet = {}, Opcodes.FindClientPacket("SMSG_UPDATE_STATE");
		data.State = "UNIT_STATE_INCAPACITATED"
		data.Bool = true
		data.Duration = duration
		data.Spell = spellInfo
		packet:FireClient(target.link, data);
	end
end

function Unit:IsStunned()
	return self:HasState("UNIT_STATE_STUNNED")
end

function Unit:IsFeared()
	return self:HasState("UNIT_STATE_FEARED")
end

function Unit:IsSilenced()
	return self:HasState("UNIT_STATE_SILENCED")
end

function Unit:IsRooted()
	return self:HasState("UNIT_STATED_ROOTED");
end

function Unit:IsDisoriented()
	return self:HasState("UNIT_STATE_DISORIENTED");
end

function Unit:IsIncapped()
	return self:HasState("UNIT_STATE_INCAPACITATED");
end

function Unit:AddAura(target, spell)
	if not spell then error("No spell found!") return nil end;
	-- First check if aura already exists, if it does then refresh the duration
	for _,v in next,target.m_auraList do
		if v.spell.spell == spell.spell then
			if v:IsStackable() then
				v:AddStack()
			else
				v:RefreshDuration();
			end
			return;
		end
	end
	local key = self.map.m_auraKeyCounter + 1
	self.map.m_auraKeyCounter = self.map.m_auraKeyCounter + 1;
	self.m_auraKeyCounter = key
	local aura = Aura.new(spell, target, key);
	table.insert(target.m_auraList, aura);
end

function Unit:WipeAuras()
	for _,v in next, self.m_auraList do
		self:RemoveAura(v.spell.spellId);
	end
end

function Unit:CastSpell(spell, target, customPCT, checkCastable)
	if not spell then return false end; -- Should never happen
	if typeof(spell) == "number" then
		spell = game.Lighting.Spells:findFirstChild(tostring(spell));
	end
	local newSpell = self:BuildSpell(spell, target, nil, customPCT, checkCastable)
	newSpell:Prepare();
end

function Unit:AddSelfAura(spellId)
	local spell;
	for _,v in next,game.Lighting.Spells:GetChildren() do
		if v.Name == tostring(spellId) then
			spell = v;
			break
		end
	end
	
	if not spell then
		error("Spell not found!")
		return;
	end
	
	local spellInfo = Spell.new(self, spell, self, false)
	local aura = Aura.new(spellInfo)
	table.insert(self.m_auraList, aura);
	
end

function Unit:ToPlayer(unit)
	if self.link:IsA("Player") then
		return self.m_player
	else
		return nil
	end
end

function Unit:IsMoving()
	return self.m_isMoving;
end

Unit.IsCastingAnimation = function(unit)
	if unit then
		if unit:IsA("Player") then
			unit = unit.Character;
		end
		if unit:findFirstChild'Humanoid' then
			local tracks = unit.Humanoid:GetPlayingAnimationTracks();
			for _,v in next,tracks do
				if v.Name == "SpellAnimation: 1" or v.Name == "SpellAnimation: 2" or v.Name == "SpellAnimation: 3" or v.Name == "SpellAnimation: 4" then
					return true
				end
			end
		end
		return false;
	end
	return false;
end

Unit.GetCastingAnimation = function(unit)
	if unit then
		if unit:IsA("Player") then
			unit = unit.Character;
		end
		if unit:findFirstChild'Humanoid' then
			local tracks = unit.Humanoid:GetPlayingAnimationTracks();
			for _,v in next,tracks do
				if v.Name == "SpellAnimation: 1" or v.Name == "SpellAnimation: 2" or v.Name == "SpellAnimation: 3" or v.Name == "SpellAnimation: 4" then
					return v;
				end
			end
		end
	end
	return nil;
end

function Unit:SetCustomGCD(spell)
	if spell then
		local customGCDTime = tonumber(spell.SpellFlags["SPELL_FLAG_CUSTOM_GCD"].Value);
		if customGCDTime > 0 then
			-- This means this individual spell has it's own custom GCD separate from other spells
			-- So we set on GCD this spell only
			local currentSpell = self:GetSpell(tonumber(spell.Name));
			if currentSpell then
				currentSpell.CustomGCD = customGCDTime
			end
		end
	end
end

function Unit:SetOnGCD()
	local haste = self:GetStat("haste");
	if self.m_gcdTime == 0 then
		if self.m_gcdTimeMod > 0 then
			self.m_gcdTime = self.m_gcdTimeMod
			self.m_gcdTimeMod = 0;
		else
			self.m_gcdTime = math.max((self.m_MaxGCDTime / ((haste / 100) + 1)), 0.75);
		end
	end
end

function Unit:ApplyAttackTimePercentMod(perc)
	self:IncreaseStat("haste", perc);
end

function Unit:SetCasting()
	self.m_casting = true
end

function Unit:IsCasting()
	return self.m_casting
end

function Unit:InterruptSpell(spell)
	for _,v in next, self:GetSpellHistory() do
		if v == spell then
			v:Cancel();
		end
	end
end

function Unit:GetCastedSpell()
	local spellList = self:GetSpellHistory();
	for _,v in next, spellList do
		if v:GetState() == "SPELL_STATE_PREPARING" or v.m_castTime > 0 then
			return v;
		end
	end
end

function Unit:GetCastedSpellTimeLeft()
	local spellList = self:GetSpellHistory();
	for _,v in next,spellList do
		if v:GetState() == "SPELL_STATE_PREPARING" then
			return v.m_castTime;
		end
	end
	return 0;
end

Unit.GetStats = function(unit)
	if unit then
		if unit:findFirstChild'Backpack' then
			return unit.Backpack:findFirstChild'Stats';
		end
	end
end

function Unit:HasTarget()
	return self:GetTarget() ~= nil
end

function Unit:HasFlag(flag)
	for _,v in next,self.flags do
		if v.Name == flag then
			return true
		end
	end
	return false
end

function Unit:IsEnemy(unit)
	if unit then
		if unit:GetFactionId() ~= self:GetFactionId() then
			return true
		end
	end
end

function Unit:IsAlive()
	if self.m_alive == false then
		return false
	else
		return true
	end
end

function Unit:GetFlags()
	return self.flags
end

function Unit:StopCasting()
	self.m_casting = false
end

function Unit:CancelCast(spell)
	local data,packet = {}, Opcodes.FindClientPacket("SMSG_CAST_CANCELED")
	data.caster = self.link
	data.spell = spell;
	Opcodes.SendMessageToSet(self.link, packet, data)
end

function Unit:GetTarget()
	return self.target
end

function Unit:IsWithinLOS(target)
	local caster = self.link
	if caster:IsA("Player") then
		caster = caster.Character;
	end
	local target = target.link
	if target:IsA("Player") then
		target = target.Character;
	end
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {caster, target}
	params.FilterType = Enum.RaycastFilterType.Blacklist
	local casterHead = caster.HumanoidRootPart
	local targetHead = target.HumanoidRootPart
	local rayOrigin = casterHead.Position
	local rayDirection = targetHead.Position
	local result = workspace:Raycast(rayOrigin, (rayDirection - rayOrigin), params)
	if result == nil then
		return true;
	end
	return false;
end

function Unit:IsWithinLOSOfPosition(pos)
	local caster = self.link
	if caster:IsA("Player") then
		caster = caster.Character;
	end
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {caster}
	params.FilterType = Enum.RaycastFilterType.Blacklist
	local casterHead = caster.HumanoidRootPart
	local rayOrigin = casterHead.Position
	local rayDirection = pos
	local result = workspace:Raycast(rayOrigin, (rayDirection - rayOrigin), params)
	if result == nil then
		return true;
	end
	return false;
end

function Unit:SelectNearbyTarget(exclude, dist)
	local list = self.map:GetNearestUnitsFromUnit(self, dist)
	
	if #list == 0 then
		return nil
	end
	
	-- remove current target
	for i,v in next,list do
		if v == self.target then
			table.remove(list, i)
		end
		
		if v == exclude then
			table.remove(list, i)
		end
		
		--TODO: Remove LoS targets
	end
	
	local rand = math.random(1, #list)
	return list[rand];
	
end

function Unit:IsPlayer()
	return Unit:ToPlayer() ~= nil
end

function Unit:HasAura(auraId)
	for _,v in next,self.m_auraList do
		if v.spell.spellId == auraId then
			return true
		end
	end
	return false
end

function Unit:GetAura(auraId)
	for _,v in next,self.m_auraList do
		if v.spell.spellId == auraId then
			return v
		end
	end
	return nil
end

function Unit:RemoveAura(auraId)
	for i,v in next,self.m_auraList do
		if v.spell.spellId == auraId then
			if v.m_stacks == 0 then
				v.m_duration = 0
				v:Finish();
				v:UpdateClient();
				table.remove(self.m_auraList, i)
			else
				v:DropStack();
			end
		end
	end
end

function Unit:GetNegativeAuraList()
	local list = {}
	for _,v in next,self.m_auraList do
		if v.typ == "debuff" then
			table.insert(list, v)
		end
	end
	return list
end

function Unit:SetHealth(val)
	self.m_Health = val
	
	local packet2 = Opcodes.FindClientPacket("SMSG_UPDATE_STAT")
	local data = {}
	data.Stat = "Health"
	data.Health = self:GetHealth()
	data.MaxHealth = self:GetMaxHealth();
	data.Target = self.link;

	Opcodes.SendMessageToSet(self.link, packet2, data);
end

function Unit:SetMana(val)
	self.m_Mana = val
	local data,packet = {},Opcodes.FindClientPacket("SMSG_UPDATE_STAT")
	data.Target = self.link
	data.Health = self:GetMana(); -- Naming health cause it's easier
	data.MaxHealth = self:GetMaxMana();
	data.Stat = "Mana"
	Opcodes.SendMessageToSet(self.link, packet, data)
end

function Unit:RemoveAbsorbAuras()
	for _,v in next, self:GetAuraList() do
		if v:HasEffect("AURA_EFFECT_APPLY_ABSORB") then
			self:RemoveAura(v.spell.spellId)
		end
	end
end

function Unit:IsFrozen()
	return self.auraStates.AURA_STATE_FROZEN;
end

function Unit:GetMana()
	return self.m_Mana
end

function Unit:GetMaxMana()
	return self.m_MaxMana
end

function Unit:GetStats()
	return self.stats
end

function Unit:GetHealth()
	return self.m_Health
end

function Unit:GetStat(stat)
	return self:GetStats()[stat];
end

function Unit:IncreaseStat(stat, val)
	self:GetStats()[stat] += val;
end

function Unit:LoadHealthPool()
	if self.link and self.link.Character then
		local healthpool = game:service'ServerStorage'.HealthPool:Clone()
		healthpool.Parent = self.link.Character.Head;
		healthpool.Adornee = self.link.Character.Head;
		healthpool.Bar.CharName.Text = self.Name;
	end
end

function Unit:RemoveAurasWithInterruptFlags(flag, spell)
	for spellId, spellData in pairs(self:GetSpellList()) do
		if Bit.AND(spellData.m_interruptFlags, flag) ~= 0 then
			spellId = tonumber(spellId)
			if self:HasAura(spellId) then

				-- Random calculation with a 25% chance
				if math.random() < 0.25 then
					self:RemoveAura(spellId);
				end
			end
		end
	end
end


function Unit:SpellDamageBonusDone(victim, spell, m_spellInfo)
	--TODO: Add damage type and spell attribute SPELL_ATTR3_INGORE_CASTER_MODIFIERS
	
	local DoneTotal = 0;
	local DoneTotalMod = self:SpellDamagePctDone(spell) --TODO: Add this
	-- Get fixed damage bonus auras
	--local DoneAdvertisedBenefit = self:SpellBaseDamageBonusDone() --TODO: Add this
	
	--TODO: Add SPELL_AURA_MOD_DAMAGE_TAKEN aura
	
	-- BasePoints 0 so no damage done
	if spell:GetAmount() == 0 then
		return 0, false;
	end
	
	-- Check for immunities
	if victim.m_immunities[spell.m_school] == true then
		return 0, false;
	end
	
	-- Default Calculation
	DoneTotal = DoneTotal + math.random(spell:GetAmount(), spell:GetAmount() * 1.5);
	-- Modifiers
	local damageClass = spell:GetDamageClass()
	if damageClass == "Intellect" then
		local int = self:GetStat("intellect")
		--local damage = math.floor(math.random(damageEstimation + (int/4), damageEstimation + (int/3.5)));
		DoneTotal = math.floor(math.random(DoneTotal + (int/8), DoneTotal + (int/7)))
	elseif damageClass == "Strength" then
		local str = self:GetStat("strength")
		
		DoneTotal = math.floor(math.random(DoneTotal + (str/10), DoneTotal + (str/9)))
	end
	
	-- Check for damage increasing auras
	for _,v in next, self:GetAuraList() do
		if v.spell.spellId == 46 then -- Rune of Power
			DoneTotal = math.floor(DoneTotal * 1.4);
		end
	end
	
	local crit = false;
	
	-- Crit Handler
	local critPercentage = spell:GetCritChance();
	if spell:HasFlag("SPELL_FLAG_ALWAYS_CRIT") 
		or self:HasAura(24) -- Hard check for combustion, add in unit flags later
		or (victim:IsFrozen() and self:GetClass() == "Mage" and self:GetSpecialization() == "Frost") then
		DoneTotal = DoneTotal * 2;
		
		crit = true;
	else
		if math.random(100) <= critPercentage then
			DoneTotal = DoneTotal * 2;
			crit = true;
		end
	end
	
	local isDoT = false;
	-- We don't want dots to be able to give us heating up procs
	local auraInfo = spell:GetAuraInfo()
	if auraInfo then
		if auraInfo.Periodic.Value == true then
			isDoT = true;
		end
	end
	
	-- Custom Spells
	local SPELL_MAGE_HEATING_UP = 21
	local SPELL_MAGE_HOT_STREAK = 22
	
	-- Handle Crit Procs
	if crit == true then
		
		-- Setup crit proc system
		--if self:HasProc("UNIT_PROC_ON_CRIT") then
			--TODO: Add in correct ProcScripts
		--spell.procScript:Proc();
		-- Check if we have the Heating Up, if so, remove it and add Hot Streak
		-- As per retail: Hot Streak can overlap and just refresh CD
		if self:GetClass() == "Mage" and self:GetSpecialization() == "Fire" then
			if not isDoT and spell:GetSchool() == "Fire" then
				if self:HasAura(SPELL_MAGE_HEATING_UP) then
					self:RemoveAura(SPELL_MAGE_HEATING_UP);	
					if self:HasAura(SPELL_MAGE_HOT_STREAK) then
						self:RemoveAura(SPELL_MAGE_HOT_STREAK);
					end
					self:CastSpell(SPELL_MAGE_HOT_STREAK, self); -- Cast Hot Streak
				else
					self:CastSpell(SPELL_MAGE_HEATING_UP, self); -- Cast Heating Up!
				end
			end
		end
	else 
		-- We want to remove Heating Up if we don't crit our next spell as we need to crit twice in a row
		if not isDoT then -- We still don't want dots to be managed at all in this system
			if self:HasAura(SPELL_MAGE_HEATING_UP) then
				self:RemoveAura(SPELL_MAGE_HEATING_UP);
			end
		end
	end
	
	local tmpDamage = DoneTotal * DoneTotalMod;
	if spell.m_customPCT ~= nil then
		return spell.m_customPCT;
	end
	return tmpDamage, crit;
end

function Unit:SpellDamagePctDone(spell)
	--TODO: Check direct damage type, return 1;
	--TODO: Check SPELL_ATTR3_IGNORE_CASTER_MODIFIERS, return 1;
	--TODO: Check SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS, return 1;
	
	local DoneTotalMod = 1;
	
	--TODO: Add pet damage
	
	--TODO: Add particular stat modifier
	
	local maxModDamagePercentSchool = 1;
	if self:ToPlayer() ~= nil then
		local player = self:ToPlayer()
		maxModDamagePercentSchool = player:GetModDamageDonePercent(spell:GetSchool())
	end
	
	DoneTotalMod = DoneTotalMod * maxModDamagePercentSchool
	
	return DoneTotalMod;
end

function Unit:DealSpellDamage(spell)
	if spell then
		local targetList = spell:GetTargetList()
		if #targetList > 0 then
			for _,v in next, targetList do
				self:DealDamage(spell, v, 0);
			end
		end
	end
end

function Unit:ToSummoner()
	return self.summoner;
end

function Unit:SetSpeed(speed)
	local char = self.link:IsA("Player") and self.link.Character or self.link;
	
	if char then
		if char.Humanoid then
			char.Humanoid.WalkSpeed = speed;
		end
	end
end

function Unit:GetSpeed()
	local char = self.link:IsA("Player") and self.link.Character or self.link;

	if char then
		if char.Humanoid then
			return char.Humanoid.WalkSpeed
		end
	end
end

function Unit:DealDamage(spell, target, damageType)
	if not spell or not target then return end

	local m_spellInfo = spell.spell
	if not m_spellInfo then return end

	local spellClass = m_spellInfo.SpellSchoolMask.Value

	local stats = target:GetStats()
	local spellType = m_spellInfo.DamageClass.Value

	if spellType ~= "Intellect" and spellType ~= "Strength" then return end

	local damage, crit = self:SpellDamageBonusDone(target, spell, m_spellInfo)
	local absorb = false

	--target:RemoveAurasWithInterruptFlags(SD.SpellAuraInterruptFlags.Damage, spell);

	local abamt = target:GetAbsorbAmount()
	if abamt > 0 then
		if abamt >= damage then
			abamt = abamt - damage
			damage = 0
			absorb = true
		else
			damage = damage - abamt
			abamt = 0
		end
		target:SetAbsorbAmount(abamt)
	end

	local packet = Opcodes.FindClientPacket("SMSG_SEND_COMBAT_TEXT")

	if spell.m_posneg == false and damage > 0 then
		local newHealth = math.max(target:GetHealth() - damage, 0)
		target:SetHealth(newHealth)
	elseif spell.m_posneg == true then
		local newHealth = math.min(target:GetHealth() + damage, target:GetMaxHealth())
		target:SetHealth(newHealth)
	end

	-- Handle stealth removal
	if target:IsInStealth() then
		target:BreakStealth()
	end

	if self.link:IsA("Player") then
		packet:FireClient(self.link, damage, target.m_Head, crit, spell.m_posneg, absorb)
	elseif self:ToSummoner() then
		packet:FireClient(self:ToSummoner().link, damage, target.m_Head, crit, spell.m_posneg, absorb)
	end
end



Unit.GetNearestEnemies=function(player, pos)
	local enemiesList={}
	for _,v in next,workspace:GetChildren() do
		if v:IsA("Model") then
			if (v:findFirstChild'NPC Value' or game.Players:GetPlayerFromCharacter(v)) and Unit.IsAttackable(player, v) then
				local distance = (pos - v:WaitForChild'Head'.Position).magnitude;
				if distance < 20 then
					table.insert(enemiesList, v);
				end
			end
		end
	end
	return enemiesList;
end

function Unit:SetMaxHealth(value)
	self.m_maxHealth = value
end

function Unit:SetStat(stat, val)
	self.stats[stat] = val
end

function Unit:IsAwaitingSpellClick()
	return self.m_isAwaitingClick;
end

function Unit:DropTarget()
	self:UpdateTarget(nil);
end

function Unit:UpdateTarget(target)
	if target then
		if typeof(target) ~= "table" then
			local targetObj = self.map:GetUnit(target);
			if targetObj then
				target = targetObj
			end
		end
		local data = {}
		if target ~= nil then
			if target:IsInStealth() then
				return;
			end
			self.target = target
			data.link = target.link
			data.Name = target.Name
			data.m_silenced = target.m_silenced
			data.flags = target.flags
			data.m_alive = target.m_alive
			data.m_casting = target.m_casting
			data.m_Health = target.m_Health
			data.m_maxHealth = target.m_maxHealth
			data.m_unitState = target.m_unitState
			data.m_Mana = target.m_Mana
			data.m_maxMana = target.m_MaxMana
		else
			self.target = nil
			data = nil;
		end
		if self:ToPlayer() then
			local opcode = Opcodes.FindClientPacket("SMSG_UPDATE_TARGET")
			opcode:FireClient(self.link, data)
			for _,v in next,target:GetAuraList() do
				v:UpdateClient();
			end
		end
	end
end

function Unit:GetAuraList()
	return self.m_auraList;
end

function Unit:HasState(state)
	for _,v in next,self.m_unitStateList do
		if v == state then
			return true
		end
	end
	return false;
end

function Unit:SetState(state)
	table.insert(self.m_unitStateList, state);
end

function Unit:RemoveState(state)
	for i,v in next,self.m_unitStateList do
		if v == state then
			table.remove(self.m_unitStateList, i);
		end
	end
	
	-- Opcode update for UNIT_STATE so player can move again
	if self.link:IsA("Player") then
		local data,packet = {},Opcodes.FindClientPacket("SMSG_UPDATE_STATE")
		data.State = state
		data.Bool = false
		packet:FireClient(self.link, data);
	end
end

function Unit:GetMaxHealth()
	return self.m_maxHealth
end

function Unit:InRange(target, range)
	local char;
	if self:ToPlayer() then
		char = self.link.Character
	else
		char = self.link
	end
	
	local tarchar;
	if target:ToPlayer() then
		tarchar = target.link.Character
	else
		tarchar = target.link
	end
	local head1 = char.HumanoidRootPart;
	local head2 = tarchar.HumanoidRootPart;
	if head1 and head2 then
		local distance = math.abs((head1.Position  - head2.Position).magnitude);
		if distance < range then
			return true
		else
			return false;
		end
	end
end

function Unit:IsWithinRange(position, range)
	local loc = self.m_HRP.Position
	local distance = (position - loc).magnitude
	if distance < range then
		return true;
	end
	return false;
end

Unit.RunAnimation = function(unit, anim)
	if unit then
		if unit:IsA("Player") then
			unit = unit.Character;
			local hum = unit.Humanoid;
			local animID = anim.AnimationId;
			if animID and hum then
				local animation = Instance.new("Animation",unit)
				animation.Name = anim.Name;
				animation.AnimationId = animID;
				local newAnimation = hum:LoadAnimation(animation);
				newAnimation:Play();
				return true;
			end
		end
		if anim then
			local animID = anim.AnimationId;
			local controller = Instance.new("AnimationController",unit);
			if animID and controller then
				local animation = Instance.new("Animation",unit)
				animation.Name = anim.Name;
				animation.AnimationId = animID;
				local newAnimation = controller:LoadAnimation(animation);
				newAnimation:Play();
			end
		end
	end
end

function Unit.ReturnTypeIDList()
	return Unit.TypeIds;
end
return Unit
