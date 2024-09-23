local Aura = {}
Aura.__index = Aura

local Opcodes = require(workspace.Opcodes);
-- Auras are objects inside of m_auraList for each unit
-- Each aura has similar functions to Spell where it has Effects that do stuff
-- Each aura has a caster and a target, the target being the player/unit the aura is currently on
-- A lot of auras will be the same caster and target which is fine (Shield casted on yourself for example)

function Aura.new(spell, target, key)
	local self = {}
	setmetatable(self, Aura)
	
	self.spell = spell
	self.caster = spell.caster
	self.link = spell.m_auraInfo
	self.target = target
	self.posneg = spell.m_posneg
	self.hasTimer = self.link.HasTimer.Value;
	self.m_duration = self.link.Duration.Value;
	self.m_isPeriodic = self.link.Periodic.Value;
	self.m_Type = self.link.Type.Value;
	self.m_maxDuration = self.link.Duration.Value;
	self.m_timeBetweenTicks = self:GetTimeBetweenTicks();
	self.m_needsClientUpdate = true;
	self.m_key = key
	self.m_effectHit = false;
	self.m_effects = self.link.AuraEffects.Value;
	self.m_stacks = 0;
	self.m_maxStacks = 0;
	self.m_stackable = false;
	
	if self.link:findFirstChild'MaxStacks' then
		self.m_stackable = true;
		self.m_maxStacks = self.link:findFirstChild'MaxStacks'.Value;
	end
	
	if self.link:findFirstChild'AuraState' ~= nil then
		self.m_auraState = self.link:findFirstChild'AuraState'.Value;
	end
	
	self.VU = true;
	
	-- DRHandler
	if self.m_Type == "Fear" then
		if self.target.DRHandler:CanFear() then
			self.m_duration = self.m_duration * self.target.DRHandler.fearDR
			self.target.DRHandler:ApplyFear()
		else
			self.m_duration = 0
		end
	elseif self.m_Type == "Stun" then
		if self.target.DRHandler:CanStun() then
			self.m_duration = self.m_duration * self.target.DRHandler.stunDR
			self.target.DRHandler:ApplyStun()
		else
			self.m_duration = 0
		end
	elseif self.m_Type == "Silence" then
		if self.target.DRHandler:CanSilence() then
			self.m_duration = self.m_duration * self.target.DRHandler.silenceDR
			self.target.DRHandler:ApplySilence()
		else
			self.m_duration = 0
		end
	elseif self.m_Type == "Root" then
		if self.target.DRHandler:CanRoot() then
			self.m_duration = self.m_duration * self.target.DRHandler.rootDR
			self.target.DRHandler:ApplyRoot()
		else
			self.m_duration = 0
		end
	elseif self.m_Type == "Disorient" then
		if self.target.DRHandler:CanDisorient() then
			self.m_duration = self.m_duration * self.target.DRHandler.disorientDR
			self.target.DRHandler:ApplyDisorient()
		else
			self.m_duration = 0
		end
	elseif self.m_Type == "Incap" then
		if self.target.DRHandler:CanIncap() then
			self.m_duration = self.m_duration * self.target.DRHandler.incapDR
			self.target.DRHandler:ApplyIncap()
		else
			self.m_duration = 0
		end
	end
	
	-- Find aurascript
	local aurascript = script.AuraScripts:findFirstChild(self.spell.spell.Name, true)
	if aurascript ~= nil then
		local as = require(aurascript);
		self.m_auraScript = as.new(self)
		self.m_auraScript:OnApply();
	end
	
	self.AuraEffectHandlers = {
		["AURA_EFFECT_SCHOOL_DAMAGE"] 		= Aura.EffectSchoolDMG, -- Regular damage-dealing spells
		["AURA_EFFECT_STUN"] 				= Aura.EffectStun, -- Stuns
		["AURA_EFFECT_FEAR"] 				= Aura.EffectFear, -- Fears
		["AURA_EFFECT_ROOT"]				= Aura.EffectRoot, -- Roots
		["AURA_EFFECT_DISORIENT"]			= Aura.EffectDisorient, -- Disorients
		["AURA_EFFECT_OVERRIDE"]			= Aura.EffectOverride, -- Overrides spells
		["AURA_EFFECT_SLOW"]				= Aura.EffectSlow, -- Slows
		["AURA_EFFECT_REGEN"]				= Aura.EffectRegen, -- Aura that regens your health
		["AURA_EFFECT_PACIFY"]				= Aura.EffectPacify, -- Pacify
		["AURA_EFFECT_IMMUNITY"]            = Aura.EffectImmunity, -- Gives immunity (Ice Block)
		["AURA_EFFECT_INVISIBILITY"]		= Aura.EffectInvis, -- Stealth and Invisibility mechanics
		["AURA_EFFECT_APPLY_ABSORB"]		= Aura.EffectAbsorb,
		["AURA_EFFECT_INCAP"]				= Aura.EffectIncap,
		["AURA_EFFECT_APPLY_STATE"]			= Aura.EffectState,
		["AURA_EFFECT_MOD_ATTACKSPEED"]     = Aura.EffectModAttackSpeed, -- Haste
		["AURA_EFFECT_DUMMY"]				= function() return end, -- Dummy effect handled in Spellscripts
	}
	
	local data, packet = {}, Opcodes.FindClientPacket("SMSG_APPLY_AURA")
	data.Caster = self.caster.link
	data.Target = self.target.link;
	data.Aura = self.link
	data.Key = self.m_key;
	data.Duration = self.m_duration;
	Opcodes.SendMessageToSet(self.caster.link, packet, data);
	
	return self
	
end

function Aura:Update(m_time)
	if self.m_isPeriodic == false then
		if not self.m_effectHit then
			self:HandleEffects()
			self.m_effectHit = true;
		end
	else
		if self.m_timeBetweenTicks > 0 then
			self.m_timeBetweenTicks = self.m_timeBetweenTicks - m_time;
		else
			self.m_timeBetweenTicks = self:GetTimeBetweenTicks();
			self:HandleEffects();
		end
	end
	if self.hasTimer then
		if self.m_duration > 0 then
			self.m_duration = self.m_duration - m_time;
		else
			self.m_duration = 0;
			self.hasTimer = false;
			--self.m_needsClientUpdate = true;
			self:Finish();
		end
	end
	
	-- Update client at the end so info is up to date
	if self.m_needsClientUpdate then
		self:UpdateClient();
	end
	
end

function Aura:AddStack()
	if self.m_maxStacks > self.m_stacks then
		self.m_stacks += 1;
	end
	
	self:RefreshDuration();
	self:UpdateClient();
end

function Aura:DropStack()
	self.m_stacks -= 1;
	
	if self.m_stacks < 1 then
		self:Finish();
		self.m_duration = 0;
	end
	self:UpdateClient();
end

function Aura:GetMaxDuration()
	return self.link.Duration.Value
end

function Aura:GetType()
	return self.m_Type;
end

function Aura:IsPeriodic()
	return self.m_isPeriodic;
end

function Aura:SetNeedClientUpdate()
	self.m_needsClientUpdate = true;
end

function Aura:GetAmount()
	return self.link.BasePoints.Value;
end

function Aura:GetTimeBetweenTicks()
	local var = 0
	var = var + self.link.TickSlot.Value
	return var
end

function Aura:UpdateClient()
	local packet = Opcodes.FindClientPacket("SMSG_AURA_UPDATE")
	local data = self:BuildUpdatePacket()
	Opcodes.SendMessageToSet(self.caster.link, packet, data);
	self.m_needsClientUpdate = false;
end

function Aura:BuildUpdatePacket()
	local data = {}
	data.Caster = self.caster.link
	data.Target = self.target.link;
	data.Aura = self.link
	data.Key = self.m_key;
	data.Duration = self.m_duration;
	data.Stacks = self.m_stacks;
	return data
end

function Aura:IsStackable()
	return self.m_stackable;
end

function Aura:Finish()
	if self.m_stacks == 0 then
		self:CancelEffects();
		
		-- Run AuraScripts
		if self.m_auraScript ~= nil then
			self.m_auraScript:AfterRemove();
		end
		
		for i, aura in ipairs(self.target.m_auraList) do
			if aura == self then
				table.remove(self.target.m_auraList, i)
				break
			end
		end
	end
end

function Aura:IncreaseDuration(val)
	self.m_duration = math.min(self.m_duration + 1, self.m_maxDuration);
	self.m_needsClientUpdate = true;
end

function Aura:SetLoadedState(maxDuration, duration, amount)
	--TODO: Add charges, stack amount, masks
	self.m_duration = duration
	self.m_maxDuration = maxDuration;
	
	local effect = self:GetAuraEffect()
	if effect then
		effect:SetAmount(amount)
		effect:CalculatePeriodic(self.caster)
	end
	
end

function Aura:GetSpellInfo()
	return self.spell
end

function Aura:ApplyDR(drType)
	local DRHandler = self.target.DRHandler
	local canApply, durationMultiplier, applyFunc = false, 1, nil

	if drType == "Fear" then
		canApply, durationMultiplier, applyFunc = DRHandler:CanFear(), DRHandler.fearDR, DRHandler.ApplyFear
	elseif drType == "Stun" then
		canApply, durationMultiplier, applyFunc = DRHandler:CanStun(), DRHandler.stunDR, DRHandler.ApplyStun
	elseif drType == "Silence" then
		canApply, durationMultiplier, applyFunc = DRHandler:CanSilence(), DRHandler.silenceDR, DRHandler.ApplySilence
	end

	if canApply then
		self.m_duration = math.ceil(self.m_maxDuration * durationMultiplier)
		applyFunc(DRHandler)
	else
		self.m_duration = 0
	end

	self:SetNeedClientUpdate()
end

function Aura:RefreshDuration()
	local duration = self.m_maxDuration

	if self.m_Type == "Fear" or self.m_Type == "Stun" or self.m_Type == "Silence" then
		self:ApplyDR(self.m_Type)
	else
		self.m_duration = duration
		self.m_needsClientUpdate = true;
	end

	--TODO: Add Spell Attributes to check for SPELL_ATTR8_HASTE_AFFECTS_DURATION
	--self.m_timeBetweenTicks = self.spell:GetTimeBetweenTicks();
	--TODO: Add charge function to reset here
end

function Aura:IsUsingStacks()
	if self.m_stacks > 0 then
		return true;
	end
	return false;
end

function Aura:HasMoreThanOneEffectForType(auraType)
	--TODO: Create auratypes and auraeffects
end

function Aura:IsArea()
	--TODO: Create area-of-effect auras
end

function Aura:IsPassive()
	return self:GetSpellInfo():IsPassive();
end

function Aura:IsDeathPersistent()
	return self:GetSpellInfo():IsDeathPersistent()
end

function Aura:GetEffects()
	local effects = {}
	for effect in self.m_effects:gmatch("([%a_]+)") do
		table.insert(effects, effect)
	end
	return effects
end

function Aura:HandleEffects()
	local effects = self:GetEffects()
	for _,v in next,effects do
		self.AuraEffectHandlers[v](self);
	end
end

function Aura:HasEffect(effect)
	local effects = self:GetEffects()
	for _,v in next, effects do
		if v == effect then
			return true;
		end
	end
	return false
end

function Aura:CancelEffects()
	local effects = self:GetEffects()
	for _,v in next,effects do
		if v == "AURA_EFFECT_STUN" then
			self.target:RemoveState("UNIT_STATE_STUNNED")
		elseif v == "AURA_EFFECT_SILENCE" then
			self.target:RemoveState("UNIT_STATE_SILENCED")
		elseif v == "AURA_EFFECT_FEAR" then
			self.target:RemoveState("UNIT_STATE_FEARED")
		elseif v == "AURA_EFFECT_ROOT" then
			self.target:RemoveState("UNIT_STATE_ROOTED")
		elseif v == "AURA_EFFECT_DISORIENT" then
			self.target:RemoveState("UNIT_STATE_DISORIENTED")
		elseif v == "AURA_EFFECT_SLOW" then
			self.target:RemoveState("UNIT_STATE_SLOWED");
		elseif v == "AURA_EFFECT_IMMUNITY" then
			self.target:RemoveAllSpellImmunities();
		elseif v == "AURA_EFFECT_INVISIBILITY" then
			self.target:BreakStealth();
		elseif v == "AURA_EFFECT_APPLY_ABSORB" then
			self.target:Absorb(0);
		elseif v == "AURA_EFFECT_APPLY_STATE" then
			self.target:RemoveAuraState(self.m_auraState);
		elseif v == "AURA_EFFECT_MOD_ATTACKSPEED" then
			self.target:ApplyAttackTimePercentMod(-self:GetAmount());
		end
	end
end

--[[

	-SpellEffects-
	Template:
 	["EffectName"] = function()
 	This way we can just run the function straight from the SpellEffect name, and get the variables from values inside the DBC
]]

function Aura:EffectSchoolDMG()
	local target = self.target
	if target then
		self.caster:DealDamage(self.spell, target);
	end
end

function Aura:EffectStun()
	local caster = self.caster
	local target = self.target
	if target then
		caster:Stun(target, self.m_duration, self.spell.spell);
	end
end

function Aura:EffectIncap()
	local caster = self.caster
	local target = self.taget
	if target then
		caster:Incap(target, self.m_duration, self.spell.spell);
	end
end

function Aura:EffectFear()
	local caster = self.caster
	local target = self.target
	if target then
		caster:Fear(target, self.m_duration, self.spell.spell);
	end
end

function Aura:EffectRoot()
	local caster = self.caster
	local target = self.target
	if target then
		caster:Root(target, self.m_duration, self.spell.spell);
	end
end

function Aura:EffectDisorient()
	local caster = self.caster
	local target = self.target
	if target then
		caster:Disorient(target, self.m_duration, self.spell.spell);
	end
end

function Aura:EffectOverride()
	local caster = self.caster
	if caster then
		caster:OverrideSpell(self.spell);
	end
end

function Aura:EffectSlow()
	local caster = self.caster
	local target = self.target
	if caster and target then
		caster:Slow(target, self.m_duration, self.spell.spell);
	end
end

function Aura:EffectRegen()
	local caster = self.caster
	if caster then
		
	end
end

function Aura:EffectImmunity()
	local target = self.target
	if target then
		target:ApplyAllSpellImmunities();
	end
end

function Aura:EffectInvis()
	local caster = self.caster
	if caster then
		caster:Stealth()
	end
end

function Aura:EffectAbsorb()
	local caster = self.caster
	if caster then
		local amt = self.spell:GetAmount();
		caster:Absorb(amt);
	end
end

function Aura:EffectState()
	local target = self.target
	if target then
		target:AddAuraState(self.m_auraState)
	end
end

function Aura:EffectModAttackSpeed()
	local caster = self.caster;
	if caster then
		caster:ApplyAttackTimePercentMod(self:GetAmount())
	end
end

return Aura
