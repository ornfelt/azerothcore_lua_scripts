local Spell = {	};
Spell.__index = Spell

local Spells = game.Lighting:WaitForChild'Spells':GetChildren()
local Opcodes = require(workspace.Opcodes);
local Database = require(workspace.DatabaseHandler);
local SD = require(workspace.SharedDefines);
local Bit = require(workspace.Bit);
--local AT = require(workspace.AreaTriggerHandler);


--SPELL:
-- Each spell object is created when client sends CMSG_CAST_SPELL
-- Spell is prepared to be cast, sends SMSG_SPELL_START to client
-- Client then begins cast, once cast is finished, SMSG_SPELL_GO is sent
-- as server is also keeping track of cast time(so no cast-time cheat)
-- Client then casts spell and delay is begun for spell to hit target(1 second for regular casted spells, 0 seconds for dots and auras)
-- Server executes the spell once the timer has run out which does damage / healing / adds aura

-----------------------------------
--[[Variables]]--
local m_executedCurrently;
local SpellFlags = {
	SPELL_FLAG_EMPTY = 1;	
}
local SpellQueue = require(workspace.SpellQueue);
-----------------------------------

Spell.new = function(caster, spell, target, pos, customPCT, checkCastable)
	local self = {}
	setmetatable(self, Spell)
	
	self.caster = caster
	self.spell = spell
	self.spellId = tonumber(spell.Name)
	self.pos = pos
	self.target = target
	self.m_spellState = "SPELL_STATE_NONE"
	self.m_spellFlags = {}
	self.typ = nil
	self.m_targetList = {}
	self.m_cooldownLeft = 0
	self.m_effects = spell.SpellEffect.Value;
	self.m_castTime = spell.CastTime.Value
	
	-- Handle cast-time change due to haste
	local haste = caster:GetStat("haste");
	self.m_castTime /= (haste / 100) + 1
	
	self.m_checkCastable = checkCastable;
	self.m_cooldownValue = spell.CooldownValue.Value
	self.m_posneg = spell.PositiveNegative.Value
	self.m_auraInfo = game.Lighting.Auras:findFirstChild(self.spellId);
	self.m_atInfo = game.Lighting.AreaTriggers:findFirstChild(self.spellId);
	self.m_passive = false;
	self.m_deathPersistent = false;
	self.m_damageClass = spell.DamageClass.Value
	self.m_school = spell.SpellSchoolMask.Value
	self.m_amount = spell.BasePoints.Value;
	self.m_animEnabled = true;
	self.m_damage = 0;
	self.m_immediateHandled = false;
	self.m_aura = nil
	self.m_currentSpell = caster:GetSpell(self.spellId);
	self.m_gcdTimeMod = 1.5;
	
	self.m_gcdTimeMod /= (haste / 100) + 1;
	
	-- GCD cannot be below 0.75
	self.m_gcdTimeMod = math.max(self.m_gcdTimeMod, 0.75);
	
	self.m_isQueued = false;
	self.m_elapsedTime = 0;
	self.minDistanceToTarget = 3;
	self.m_spellTime = 0;
	self.m_customPCT = customPCT;
	self.m_speed = spell.Speed.Value;
	self.m_triggerFlags = 0;
	self.m_critChance = 25
	
	if spell:findFirstChild'MiscValue' ~= nil then
		self.MiscValue = spell.MiscValue.Value
	end
	
	if spell:findFirstChild'MiscValueB' ~= nil then
		self.MiscValueB = spell.MiscValueB.Value
	end
	
	if spell:findFirstChild'EffectType' ~= nil then
		self.EffectType = spell.EffectType.Value
	end
	
	-- TriggerFlags
	if self:HasAttribute(SD.SpellAttr.SPELL_ATTR_ALLOW_CAST_WHILE_CASTING) then
		self.m_triggerFlags = Bit.OR(self.m_triggerFlags, SD.TriggerFlags.TRIGGERED_IGNORE_CAST_IN_PROGRESS)
	end
	
	if self:HasAttribute(SD.SpellAttr.SPELL_ATTR_IGNORE_GCD) then
		self.m_triggerFlags = Bit.OR(self.m_triggerFlags, SD.TriggerFlags.TRIGGERED_IGNORE_GCD);
	end
	
	if self.spell.SpellFlags:findFirstChild("SPELL_FLAG_NEEDS_TARGET") then
		if spell.SpellTime.Value == true then
			if self.target ~= nil then
				local distance = self.caster.location:GetDistanceFrom(self.target);
				local travelTime = distance / self.m_speed;
				
				self.m_spellTime = travelTime;
				self.m_initialSpellTime = travelTime;
			end
		end
	end
	
	-- Check for charges
	if self:HasCharges() then
		self.m_charges = self.m_currentSpell.Charges;
		self.m_maxCharges = spell.Charges.Value;
	end
	
	self.SpellEffectHandlers = {
		["SPELL_EFFECT_SCHOOL_DAMAGE"] 		= Spell.EffectSchoolDMG, -- Regular damage-dealing spells
		["SPELL_EFFECT_CREATE_AREATRIGGER"] = Spell.EffectCreateAreaTrigger, -- AoE spells that create AreaTriggers
		["SPELL_EFFECT_APPLY_AURA"] 		= Spell.EffectApplyAura, -- Spells that apply auras to the target
		["SPELL_EFFECT_DISPEL"]				= Spell.EffectDispel,	 -- Dispels dots (dispel all harmful magical effects for now)
		["SPELL_EFFECT_TELEPORT"]			= Spell.EffectTeleport,	 -- Teleport to a position
		["SPELL_EFFECT_SELECT_ELECTIVES"]	= Spell.EffectElectives, -- Select Electives
		["SPELL_EFFECT_LEAP_FORWARD"]		= Spell.EffectLeapForward, -- Leap Forward (Blink/etc)
		["SPELL_EFFECT_INTERRUPT_CAST"]		= Spell.EffectInterruptCast, -- Interrupt Spell Cast
		["SPELL_EFFECT_REMOVE_AURA"]		= Spell.EffectRemoveAura, -- Remove spell aura (SPELL_FLAG_REMOVE_AURA value)
		["SPELL_EFFECT_SUMMON"]				= Spell.EffectSummonType,
		["SPELL_EFFECT_DUMMY"]				= function() return end, -- Dummy effect handled in Spellscripts
	}
	
	-- Find spellscript
	local spellScript = script.SpellScripts:findFirstChild(spell.Name, true)
	if spellScript ~= nil then
		local ss = require(spellScript);
		self.m_spellScript = ss.new(self)
	end
	
	-- Load in spell flags
	for _,v in next,spell.SpellFlags:GetChildren() do
		table.insert(self.m_spellFlags, v.Name)
	end
	
	return self
end

function Spell:GetMaxDuration()
	return self.m_maxDuration;
end

function Spell:GetTargets()
	return self.m_targetList;
end

function Spell:IsCastable()
	return self.spell.Castable.Value;
end

function Spell:SetCastTime(m_time)
	self.m_castTime = m_time;
end

function Spell:GetCharLink()
	return self.charLink;
end

function Spell:GetAuraInfo()
	if self.m_auraInfo ~= nil then
		return self.m_auraInfo;
	end
end

function Spell:GetCharges()
	local currentSpell = self.caster:GetSpell(self.spellId);
	if currentSpell then
		return currentSpell.Charges;
	end
end

function Spell:GetMaxCharges()
	return self.m_maxCharges;
end

function Spell:HasSpellAura()
	return self.m_hasSpellAura;
end

function Spell:GetEffect()
	return self.m_auraType;
end

function Spell:GetTimeBetweenTicks()
	return self.m_timeBetweenTicks
end

function Spell:SetCritChance(perc)
	self.m_critChance = perc;
end

function Spell:GetCritChance()
	return self.m_critChance;
end

function Spell:DisablePlayerAnimation()
	self.m_animEnabled = false;
end

function Spell:EnablePlayerAnimation()
	self.m_animEnabled = true;
end

function Spell:GetAmount()
	return self.m_amount;
end

function Spell:SetAmount(val)
	self.m_amount = val;
end

function Spell:MultiplyDamage(val)
	self.m_amount *= val;
end

function Spell:GetDamageClass()
	return self.m_damageClass;
end

function Spell:SetState(state)
	self.m_spellState = state
end

function Spell:GetState()
	return self.m_spellState
end

function Spell:ToClientSpell()
	return self.m_clientSpell;
end

function Spell:IsPassive()
	local passive = SD.SpellAttr.SPELL_ATTR_PASSIVE;
	return self:HasAttribute(SD.SpellAttr.SPELL_ATTR_PASSIVE);
end

function Spell:GetSchool()
	return self.m_school;
end

function Spell:IsDeathPersistent()
	return self.m_deathPersistent
end

--[[
	Handle Spellscripts
	-- If an individual spell has a spellscript, it will do these individual functions
	-- If an individual spell has any modifications, this is where those changes are made
	-- For example: If you need to add a flag, add it here
]]

function Spell:OnCast()
	if self.m_spellScript ~= nil then
		self.m_spellScript:OnCast();
	end
end

function Spell:OnHit()
	if self.m_spellScript ~= nil then
		self.m_spellScript:OnHit();
	end
end

function Spell:Modify()
	if self.m_spellScript ~= nil then
		self.m_spellScript:Modify();
	end
end

function Spell:HasHitDelay()
	return self.m_spellTime > 0
end

function Spell:Cast()
	if not self.caster then return end
	if not self.spell then return end
	if self.spell:IsA("ObjectValue") then
		self.spell = self.spell.Value
	end
	self:SelectSpellTargets()
	-- Everything prepared, determine if spell is immediate or delayed (hit time)
	if self:HasHitDelay() then
		self.m_spellState = "SPELL_STATE_DELAYED";
	else
		self.m_spellState = "SPELL_STATE_FINISHED";
	end
	self:Execute();
	self:OnCast();
end

function Spell:SetGCDMod(m_time)
	self.m_gcdTimeMod = m_time;
end

function Spell:Start()
	local data,packet = {},Opcodes.FindClientPacket("SMSG_SPELL_START");
	data.CastFlags = self:GetFlags()
	data.Caster = self.caster.link;
	data.Target = self.target.link;
	data.CastTime = self.m_castTime;
	data.GCD = self.m_gcdTimeMod;
	data.Spell = self.spell;
	data.AnimationEnabled = self.m_animEnabled;
	data.IsSpellQueueSpell = self.isSpellQueue;
	data.AoEPosition = self.pos;
	data.VOC = false;
	-- Use case for Ring of Frost
	if self.spellId == 48 then
		data.VOC = true;
	end
	
	Opcodes.SendMessageToSet(self.caster.link, packet, data);
end
function Spell:Go()
	local data,packet = {},Opcodes.FindClientPacket("SMSG_SPELL_GO");
	data.CastFlags = 0;
	data.Caster = self.caster.link;
	data.Target = self.target.link;
	data.CastTime = self.m_castTime;
	data.Spell = self.spell;
	data.SpellTime = self.m_spellTime;
	data.AnimationEnabled = self.m_animEnabled;
	data.AoEPosition = self.pos;
	data.ManaCost = self.spell:findFirstChild'ManaCost'.Value;
	data.VOC = false;
	-- Use case for Ring of Frost
	if self.spellId == 48 then
		data.VOC = true;
	end
	Opcodes.SendMessageToSet(self.caster.link, packet, data);
end
function Spell:Execute()
	if self.caster then
		if self.spell then
			if self:NeedsTarget() then
				if self.target == nil then
					self:HandleFailed("target");
					self:SetState("SPELL_STATE_FAILED");
					--self.caster:StopCasting();
					self.caster:CancelCast(self.spell);
					return false;
				end
				
				if self.caster:IsWithinLOS(self.target) == false then
					self:HandleFailed("target");
					self:SetState("SPELL_STATE_FAILED");
					--self.caster:StopCasting();
					self.caster:CancelCast(self.spell);
					return false;
				end
			end
			if self.caster:IsAlive() == false then
				self:HandleFailed("dead_target");
				self:SetState("SPELL_STATE_FAILED");
				--self.caster:StopCasting();
				self.caster:CancelCast(self.spell);
				return false;
			end
			
			if self.target:IsAlive() == false then
				self:HandleFailed("dead_target");
				self:SetState("SPELL_STATE_FAILED")
				--self.caster:StopCasting();
				self.caster:CancelCast(self.spell);
				return false;
			end
			
			self:Go();
			
			--Handle Mana
			self:HandleMana()
			
			-- Handle Combat
			if self.spell.PositiveNegative.Value == false then
				self.caster:SetInCombatWith(self.target);
			end
			
			-- Consume a charge if you have charges and set on cooldown that way so we can handle it already being on cooldown
			if self:HasCharges() then
				self:DropCharge(); -- Drop 1 charge;
			else
				if self:HasCooldown() then
					-- Overridden spells need to go on cooldown manually
					if not self:HasFlag("SPELL_FLAG_OVERRIDE") then
						self:SetOnCooldown();
					end
				end
			end
			return true;
		else
			error("Something went wrong while finding spell...")
		end
	end
end

function Spell:HasCharges()
	local currentSpell = self.caster:GetSpell(self.spellId);
	if currentSpell then
		if currentSpell.Charges ~= nil then
			return true;
		end
	end
	return false;
end

function Spell:DropCharge()
	local currentSpell = self.caster:GetSpell(self.spellId);
	if currentSpell then
		currentSpell.Charges = currentSpell.Charges - 1
		if self:IsOnCooldown() == false then
			self:SetOnCooldown()
		end
		
		self.caster:SendChargesUpdate(self.spellId, currentSpell.Charges)
	end
end

function Spell:AddCharge()
	local currentSpell = self.caster:GetSpell(self.spellId);
	if currentSpell then
		currentSpell.Charges = currentSpell.Charges + 1
		if self:GetCharges() < self:GetMaxCharges() then
			self:SetOnCooldown();
		end
	end
end

function Spell:Update(m_time)
	local caster = self.caster
	if not caster then return nil end

	local spellState = self:GetState()

	if spellState == "SPELL_STATE_QUEUED" then
		if not caster:IsCasting() and caster:GetGCDTime() == 0 then
			self:Prepare()
		end
	elseif spellState == "SPELL_STATE_PREPARING" then
		local shouldCancel = (
			not caster:IsAlive() or
				(caster:IsMoving() and not self:HasFlag("SPELL_FLAG_CAST_WHILE_MOVING")) or
				caster:HasState("UNIT_STATE_SILENCED") or
				caster:HasState("UNIT_STATE_STUNNED") or
				caster:HasState("UNIT_STATE_FEARED")
		)

		if shouldCancel then
			self:Cancel()
		else
			if self.m_castTime > 0 then
				self.m_castTime = math.max(0, self.m_castTime - m_time)
			end

			if self.m_castTime == 0 then
				self:Cast()
			end
		end
	elseif spellState == "SPELL_STATE_DELAYED" then
		local target = self.target
		if target then
			if self.initialSpellTime == 0 then
				self.initialSpellTime = self.m_spellTime
				self.m_elapsedTime = 0
			end

			self.m_elapsedTime = self.m_elapsedTime + m_time
			local distanceTraveled = self.m_speed * self.m_elapsedTime
			local totalDistance = caster.location:GetDistanceFrom(target)
			local remainingDistance = totalDistance - distanceTraveled

			if remainingDistance <= self.minDistanceToTarget then
				self.m_spellTime = 0
				self:OnHit()
				self:HandleEffects()
				self:SetState("SPELL_STATE_NULL")
				self.m_isPreparing = false
				return true
			end

			local travelTime = remainingDistance / self.m_speed --TODO: Add a speed variable
			self.m_spellTime = travelTime
		end

		self.m_spellTime = self.m_spellTime - m_time
	elseif spellState == "SPELL_STATE_FINISHED" then
		self.m_spellTime = 0
		self:OnHit()
		self:HandleEffects()
		self:SetState("SPELL_STATE_NULL")
		self.m_isPreparing = false
		return true
	elseif spellState == "SPELL_STATE_NULL" then
		for i, v in next, caster.m_spellList do
			if v == self then
				table.remove(caster.m_spellList, i)
			end
		end
		return -- Cast complete, nothing left to do
	end
end


function Spell:GetFlagValue(flag)
	if self:HasFlag(flag) then
		return self.spell.SpellFlags:findFirstChild(flag).Value;
	end
end

function Spell:SelectSpellTargets()
	local needsTarget = self:NeedsTarget()
	local posNeg = self:PosNeg()

	if needsTarget and self.target:IsAlive() then
		table.insert(self.m_targetList, self.target)
	end
	if posNeg == true then
		table.insert(self.m_targetList, self.caster)
	end

	local hasAoE = self:HasFlag("SPELL_FLAG_AOE")
	local hasMouse = self:HasFlag("SPELL_FLAG_MOUSE")
	local hasCone = self:HasFlag("SPELL_FLAG_CONE")
	local range

	if hasAoE then
		range = tonumber(self:GetFlagValue("SPELL_FLAG_AOE"))
		if hasMouse then
			self.m_targetList = self.caster.location:GetNearestEnemiesFromPosition(self.pos, range)
		elseif needsTarget then
			self.m_targetList = self.caster.location:GetNearestEnemyUnitsFromUnit(self.target, range)
		else
			self.m_targetList = self.caster.location:GetNearestEnemyUnitList(range)
		end
	elseif hasCone then
		range = tonumber(self:GetFlagValue("SPELL_FLAG_CONE"))
		self.m_targetList = self.caster.location:GetEnemiesInCone(30, range)
	end

	return self.m_targetList
end

function Spell:AddData(data)
	-- Add Data to spell such as new spell flags
end

function Spell:HasTriggerFlag(flag)
	return Bit.AND(self.m_triggerFlags, flag) ~= 0;
end

function Spell:HasInterruptFlag(flag)
	local currentSpell = self.m_currentSpell;
	local interruptFlags = currentSpell.m_interruptFlags;
	if Bit.AND(interruptFlags, flag) ~= 0 then
		return true;
	end
end

function Spell:GetSpellAttributes()
	for _,v in next, self.caster:GetSpellList() do
		
	end
end

function Spell:HasAttribute(attr)
	local spellAttributes = self.m_currentSpell.m_spellAttributes;
	if Bit.AND(spellAttributes, attr) ~= 0 then
		return true;
	end
end

function Spell:Prepare()
	if self.m_isPreparing then
		return;
	end
	if (self.caster and self.spell) then
		self.m_isPreparing = true;
		
		-- Load spellscript mods
		if self.m_spellScript ~= nil then
			self.m_spellScript:Modify();
		end
		
		--Check for healing spell cast on enemy
		if self:NeedsTarget() then
			if self.target ~= nil then
				if self.caster:IsHostile(self.target) then
					if self.spell.PositiveNegative.Value == true then
						self.target = self.caster;
					end
				end
			else
				-- We have no target, check if spell is positive, cast on self
				if self.spell.PositiveNegative.Value == true then
					self.target = self.caster
				end
			end
			-- We have a target but we don't need one, check if it's a positive spell, if so, set target to player
		elseif self.spell.PositiveNegative.Value == true then
			self.target = self.caster;
		end
		
		if self.target and self.target.link:IsA("Model") and game.Players:GetPlayerFromCharacter(self.target.link) then
			self.target.link = game.Players:GetPlayerFromCharacter(self.target);
		end
		
		-- We have no target and we don't need a target, must be a positive spell, set target to caster
		if self.target == nil and self:NeedsTarget() == false then
			self.target = self.caster
		end
		
		--Check if we can cast the spell
		local checkcast = self:CheckCast();
		if typeof(checkcast) == "string" then 
			local spellQueueTime = 0.4
			--Specific check for Spell Queue
			if checkcast == "global cooldown" then
				-- we must first overlap any other queued spell we have
				for _,v in next, self.caster.m_spellList do
					if v:GetState() == "SPELL_STATE_QUEUED" then
						v:SetState("SPELL_STATE_NONE")
					end
				end
				-- Check if the time left on our gcd is less than our spell queue time
				if self.caster:GetGCDTime() <= spellQueueTime then
					self:SetState("SPELL_STATE_QUEUED")
					self.m_isPreparing = false;
					self.m_isQueued = true;
					self:HandleFailed(checkcast);
					return;
				end
			elseif checkcast == "casting" then
				-- we must first overlap any other queued spell we have
				for _,v in next, self.caster.m_spellList do
					if v:GetState() == "SPELL_STATE_QUEUED" then
						v:SetState("SPELL_STATE_NONE")
					end
				end
				-- Check if the time left on our gcd is less than our spell queue time
				if self.caster:GetCastedSpellTimeLeft() < spellQueueTime then
					self:SetState("SPELL_STATE_QUEUED")
					self.m_isPreparing = false;
					self.m_isQueued = true;
					self:HandleFailed(checkcast);
					return;
				end
			end
			
			self:HandleFailed(checkcast);
			return false
		end
		self.caster:SetCasting()
		self:SetState("SPELL_STATE_PREPARING")
		
		-- stealth must be removed at cast starting
		-- skip triggered spell (not explicit character casts)
		--if self:HasAttribute("SPELL_ATTR2_NOT_AN_ACTION") == false then
		self.caster:RemoveAurasWithInterruptFlags(SD.SpellAuraInterruptFlags.Action, self);
		--end
		
		self:Start()
		if self:HasFlag("SPELL_FLAG_IGNORES_GCD") == false and self:HasFlag("SPELL_FLAG_CUSTOM_GCD") == false then 
			self.caster:SetOnGCD();
		elseif self:HasFlag("SPELL_FLAG_CUSTOM_GCD") then
			self.caster:SetCustomGCD(self.spell);
		end
		if self:IsInstant() then
			self:Cast()
		end
	else
		error("Spell or Caster not found!"); -- Should never happen
	end
end

function Spell:HandleMana()
	if self.caster then
		local manaDrop = self.spell.ManaCost.Value;
		if manaDrop > 0 then
			if self.caster:GetMana() - manaDrop > 0 then
				self.caster:SetMana(self.caster:GetMana() - manaDrop)
			else
				self.caster:SetMana(0);
			end
		end
	end
end

function Spell:HasFlag(flag)
	if self.spell then
		for _,v in next, self.spell.SpellFlags:GetChildren() do
			if v.Name == flag then
				return true
			end
		end
	end
	return false
end

function Spell:IsPeriodic()
	local flags = self:GetFlags()
	for _,v in next,flags do
		if v.Name == 'SPELL_FLAG_AURA_PERIODIC' then
			return true
		end
	end
	return false
end

function Spell:IsMelee()
	for _,v in next,self:GetFlags() do
		if v.Name == "SPELL_FLAG_MELEE_RANGE" then
			return true
		end
	end
	return false
end

function Spell:IsRanged()
	for _,v in next,self:GetFlags() do
		if v.Name == "SPELL_FLAG_RANGED" then
			return true
		end
	end
	return false
end

function Spell:IsAoe()
	for _,v in next,self:GetFlags() do
		if v.Name == "SPELL_FLAG_AOE" then
			return true
		end
	end
	return false
end

function Spell:Cancel()
	local caster = self.caster
	if caster then
		self:SetState("SPELL_STATE_NULL")
		--caster:StopCasting()
		--caster:SetOnGCD(false)
		caster:CancelCast(self.spell);
	end
	self.m_isPreparing = false;
end

function Spell:GetTarget()
	return self.target
end

function Spell:NeedsTarget()
	for _,v in next,self:GetFlags() do
		if v == "SPELL_FLAG_NEEDS_TARGET" then
			return true
		end
	end
	return false
end

function Spell:IsOnCooldown()
	return self.caster:GetSpell(self.spellId).m_cooldownTime > 0
end

function Spell:IgnoresGCD()
	return self:HasTriggerFlag(SD.TriggerFlags.TRIGGERED_IGNORE_GCD)
end

function Spell:GetSpellType()
	return self.typ
end

function Spell:GetFlags()
	return self.m_spellFlags
end

function Spell:HandleFailed(reason)
	local opcode = Opcodes.FindClientPacket("SMSG_CAST_FAILED");
	local caster = self.caster
	if caster then
		if caster:ToPlayer() ~= nil then
			opcode:FireClient(caster:ToPlayer().link, self.spell, reason)
		end
	end
	self.m_isPreparing = false;
end

function Spell:HasCooldown()
	return self.m_cooldownValue > 0
end

function Spell:SetOnCooldown()
	local currentSpell = self.caster:GetSpell(self.spellId)
	if currentSpell ~= nil then
		currentSpell.m_cooldownTime = self.spell.CooldownValue.Value
	end
end


function Spell:PosNeg()
	return self.m_posneg
end

function Spell:CheckCast()
	local caster = self.caster
	local target = self.target

	if caster:GetMana() < self.spell.ManaCost.Value then
		return "mana"
	end

	if self:NeedsTarget() then
		if target == nil then
			return "needs_target"
		end

		if not caster:InRange(target, self.spell.MaxRange.Value) or
			not caster:IsWithinLOS(target) or
			target:IsAlive() == false or
			(caster:IsFacing(target) == false and self.target ~= self.caster and not self:IsInstant()) or
			(caster:IsHostile(target) == false and self:PosNeg() == false) or
			(self:PosNeg() == false and self.target == self.caster) then
			return "invalid_target"
		end
	else -- No target, check for AoE ability
		if self.pos ~= nil and 
			(not caster.location:IsWithinRange(self.pos, self.spell.MaxRange.Value) or
				not caster:IsWithinLOSOfPosition(self.pos)) then
			return "distance";
		end
	end

	if caster:IsOnGCD(self) and self:IgnoresGCD() ~= true then
		return "global cooldown"
	end

	if caster:IsAlive() == false then
		return "dead"
	end

	if not self:HasFlag("SPELL_FLAG_UWC") and (caster:IsStunned() or caster:IsFeared()) then
		return "feared"
	end

	--TODO: Add melee spell function
	if (self:HasCharges() == false and self:IsOnCooldown()) or
		(self:HasCharges() == true and self:GetCharges() < 1) then
		return "cooldown";
	end

	if self:IsDisabled() then
		return "disabled"
	end

	if caster:IsCasting() and self:HasTriggerFlag(SD.TriggerFlags.TRIGGERED_IGNORE_CAST_IN_PROGRESS) == false then
		return "casting"
	end

	if caster:IsMoving() and not self:IsInstant() and not self:HasFlag("SPELL_FLAG_CAST_WHILE_MOVING") then
		return "moving"
	end
	--TODO: Custom check for dispel
end

function Spell:IsInstant()
	return self.m_castTime == 0;
end

function Spell:IsDisabled()
	return self.spell.Disabled.Value
end

function Spell:GetEffects()
	local effects = {}
	for effect in self.m_effects:gmatch("([%a_]+)") do
		table.insert(effects, effect)
	end
	return effects
end

function Spell:HandleEffects()
	local effects = self:GetEffects()
	for _,v in next,effects do
		self.SpellEffectHandlers[v](self);
	end
end

function Spell:CanBeInterrupted()
	--TODO: Adjust for aura mastery spells
	if not self:HasFlag("SPELL_FLAG_INTERRUPT_IMMUNE") then
		return true;
	end
end
--[[

	-SpellEffects-
	Template:
 	["EffectName"] = function()
 	This way we can just run the function straight from the SpellEffect name, and get the variables from values inside the DBC
]]


function Spell:EffectSchoolDMG()
	for _,v in next,self:GetTargets() do
		self.caster:DealDamage(self, v, 0);
	end
end

function Spell:EffectCreateAreaTrigger()
	local AT = require(workspace.AreaTriggerHandler)
	local at = AT.new(self.caster, self, self.m_atInfo.Distance.Value, self.m_atInfo.Duration.Value);
	
	--TODO: Add in separate function for this
	if self.spellId == 45 then -- Rune of Power
		at.position = self.caster.m_HRP.Position + Vector3.new(0, -2.85, 0);
	end
	
	at:AddToWorld()
	return at;
end

function Spell:EffectApplyAura()
	local targetlist = self.m_targetList;
	if targetlist then
		for _,v in next, targetlist do
			self.caster:AddAura(v, self);
		end
	end
end

function Spell:EffectDispel()
	local target = self.target
	if target then
		for _,v in next, target:GetAuraList() do
			if v.posneg == false then
				target:RemoveAura(v.spell.spellId);
			end
		end
	end
end

function Spell:EffectTeleport()
	local pos = self.pos
	if pos ~= nil then
		local char;
		if self.caster.link:IsA("Player") then
			char = self.caster.link.Character
		else
			char = self.caster.link
		end
		
		char:MoveTo(pos);
	end
end

function Spell:EffectLeapForward()
	local range = self.spell.MaxRange.Value;
	local char;
	if self.caster.link:IsA("Player") then
		char = self.caster.link.Character
	else
		char = self.caster.link
	end
	
	local position = self.caster.location:LeapForward(char, range);
	
	
	if position then
		char:MoveTo(position);
	else
		error("FAILED");
	end
end

function Spell:EffectElectives()
	local player = self.caster
	if player then
		player:SelectElectives(player.m_electiveSlot1, player.m_electiveSlot2);
	end
end

function Spell:EffectRemoveAura()
	local caster = self.caster
	if caster then
		local aura = self:GetFlagValue("SPELL_FLAG_REMOVE_AURA");
		caster:RemoveAura(aura);
	end
end

function Spell:EffectInterruptCast()
	local caster = self.caster
	local target = self.target
	if caster and target and target:IsCasting() then
		local spell = target:GetCastedSpell();
		local spellInfo = game.Lighting.Spells:findFirstChild(tostring(spell.spellId));
		if (spell:GetState() == "SPELL_STATE_PREPARING" and spell.m_castTime > 0) and spell:CanBeInterrupted() then
			local duration = target:GetInterruptSchoolTime(spellInfo);
			target:LockSpellSchool(spellInfo.SpellSchoolMask.Value, duration);
			target:InterruptSpell(spell);
			target:AddAura(self);
		end
	end
end

function Spell:EffectSummonType()
	local entry = self.MiscValue; -- NPC ID to summon
	if not entry then return end;
	
	local owner = self.caster
	
	local summonNum = self.MiscValueB; -- How many to summon
	local summonType = self.EffectType;
	
	self:SummonGuardian(summonType, entry, summonNum, owner);
end

function Spell:SummonGuardian(typ, entryId, numSum, owner)
	local unitCaster = owner
	if not unitCaster then return end;
	
	--[[if unitCaster:IsTotem() then
		unitCaster = unitCaster:ToTotem():GetOwner();
	end]]
	local duration;
	
	if self.spellId == 43 then -- Mirror Images
		duration = 30;
	elseif self.spellId == 57 then -- Frozen Orb
		duration = 10;
	end
	
	local location = unitCaster.location;
	local map = unitCaster:ToMap();
	for i = 1, numSum do
		local pos = location:GetPetSummonPosition(typ, i);

		local summon = map:SummonCreature(entryId, pos, duration, unitCaster, self.spellId);
		if not summon then return end;
		
		summon:LoadClass();
		--[[if summon:HasUnitTypeMask(2^0) then -- TODO: Add UNIT_MASK_MINION in SharedDefines
			summon:SetFollowAngle(unitCaster:GetAbsoluteAngle(summon));
		end]]
	end
end

return Spell