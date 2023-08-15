local UNIT_FLAG_NOT_ATTACKABLE_1 = 320
local UNIT_FLAG_IS_ATTACKABLE_1 = 0




-----------
-- Intro --
-----------

function Icehowl_OnSpawn(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:RegisterEvent("Icehowl_Attack", 5000, 1)
end

RegisterUnitEvent(34797, 18, "Icehowl_OnSpawn")
RegisterUnitEvent(54797, 18, "Icehowl_OnSpawn")

function Icehowl_Attack(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IS_ATTACKABLE_1)
	pUnit:SetCombatCapable(0)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:SetCombatRangedCapable(0)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	local plr=pUnit:GetClosestPlayer()
	if plr ~= nil then
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO()) --move to closest player
	end
end

function Icehowl_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Icehowl_FerociousButt", 31000, 0)
	pUnit:RegisterEvent("Icehowl_ArcticBreath", 40000, 0)
	pUnit:RegisterEvent("Icehowl_Whirl", 15000, 0)
	pUnit:RegisterEvent("Icehowl_MassiveCrashPrep", 60000, 0)
end

RegisterUnitEvent(34797, 1, "Icehowl_OnCombat")
RegisterUnitEvent(54797, 1, "Icehowl_OnCombat")




---------------------
--  Massive Crash  --
---------------------

function Icehowl_MassiveCrashPrep(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:WipeTargetList()
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:MoveTo(563.728, 140.401, 393.846, 4.710839)
	pUnit:RegisterEvent("Icehowl_MassiveCrashRun", 6000, 1)
end

function Icehowl_MassiveCrashRun(pUnit, event)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	pUnit:Root()
	pUnit:RemoveEvents()
	pUnit:Root()
	local randomplr_0=pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:FullCastSpell(66683, pUnit:GetRandomPlayer(0))
		pUnit:RegisterEvent("Icehowl_Charge", 1200, 1)
	end
end

function Icehowl_Charge(pUnit, event)
	pUnit:Unroot()
	pUnit:RemoveEvents()
	pUnit:Unroot()
	local plr=pUnit:GetRandomPlayer(0)
	if plr ~= nil then
		pUnit:ModifyRunSpeed(20)
		pUnit:ModifyWalkSpeed(20)
		pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO())
		pUnit:RegisterEvent("Icehowl_ChargeEnd", 3500, 1)
	end
end

function Icehowl_ChargeEnd(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:CastSpell(66758)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IS_ATTACKABLE_1)
	pUnit:ModifyRunSpeed(10)
	pUnit:ModifyWalkSpeed(5)
	pUnit:RegisterEvent("Icehowl_StartAgain", 15000, 1)
end

function Icehowl_StartAgain(pUnit, event)
	if pUnit:HasAura(66758) then
		pUnit:RemoveAura(66758)
	end
	pUnit:SetCombatCapable(0)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:SetCombatRangedCapable(0)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	pUnit:RegisterEvent("Icehowl_FerociousButt", 31000, 0)
	pUnit:RegisterEvent("Icehowl_ArcticBreath", 40000, 0)
	pUnit:RegisterEvent("Icehowl_Whirl", 15000, 0)
	pUnit:RegisterEvent("Icehowl_MassiveCrashPrep", 60000, 0)
end




------------------
-- Other Spells --
------------------

function Icehowl_FerociousButt(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:CastSpellOnTarget(66770, maintank)
	end
end

function Icehowl_ArcticBreath(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:FullCastSpellOnTarget(66689, randomplr_0)
	end
end

function Icehowl_Whirl(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:FullCastSpell(67345, randomplr_0)
	end
end



----------------------------------
-- 	Other Unit Events	--
----------------------------------

function Icehowl_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SpawnCreature(34816, 554.412, 94.4594, 396.096, 5.49938, 35, 0)
	pUnit:SpawnCreature(360955, 563.636, 79.012, 418.215, 1.554401, 35, 0)
	pUnit:Despawn(1, 0)
end

function Icehowl_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SpawnCreature(35035, 554.412, 94.4594, 396.096, 5.49938, 35, 0)
	pUnit:SpawnCreature(360954, 563, 78, 419, 4.4070, 35, 0)
end

RegisterUnitEvent(34797, 4, "Icehowl_OnDeath")
RegisterUnitEvent(54797, 4, "Icehowl_OnDeath")

RegisterUnitEvent(34797, 2, "Icehowl_OnLeaveCombat")
RegisterUnitEvent(54797, 2, "Icehowl_OnLeaveCombat")