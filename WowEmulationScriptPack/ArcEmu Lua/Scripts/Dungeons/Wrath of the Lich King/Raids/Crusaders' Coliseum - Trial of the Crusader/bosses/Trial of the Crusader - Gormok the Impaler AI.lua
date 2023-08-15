local UNIT_FLAG_NOT_ATTACKABLE_1 = 320
local UNIT_FLAG_IS_ATTACKABLE_1 = 0
local UNIT_FLAG_NOT_SELECTABLE = 33554432

-----------
-- Intro --
-----------

function Gormok_OnSpawn(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:RegisterEvent("Gormok_Attack", 5000, 1)
end

RegisterUnitEvent(34796, 18, "Gormok_OnSpawn")
RegisterUnitEvent(54796, 18, "Gormok_OnSpawn")

function Gormok_Attack(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IS_ATTACKABLE_1)
	pUnit:SetCombatCapable(0)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:SetCombatRangedCapable(0)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	pUnit:ModifyWalkSpeed(8)
		local plr=pUnit:GetClosestPlayer()
		if plr ~= nil then
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO()) --move to closest player
		end
end

function Gormok_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Gormok_RatFirst", 20000, 1)
	pUnit:RegisterEvent("Gormok_Fire", 20000, 0)
	pUnit:RegisterEvent("Gormok_Stomp", 20100, 0)
	pUnit:RegisterEvent("Gormok_Impale", 10000, 0)
end

RegisterUnitEvent(34796, 1, "Gormok_OnCombat")
RegisterUnitEvent(54796, 1, "Gormok_OnCombat")



----------
-- Rats --
----------

function Gormok_RatFirst(pUnit, event)
	local randomplr=pUnit:GetRandomPlayer(0)
	if randomplr ~= nil then
		pUnit:SpawnCreature(34800, randomplr:GetX(), randomplr:GetY(), randomplr:GetZ(), randomplr:GetO(), 16, 0) --spawn snobold
	    pUnit:RegisterEvent("Gormok_RatSecond", 30000, 1)
	end
end

function Gormok_RatSecond(pUnit, event)
	local randomplr=pUnit:GetRandomPlayer(0)
	if randomplr ~= nil then
		pUnit:SpawnCreature(34800, randomplr:GetX(), randomplr:GetY(), randomplr:GetZ(), randomplr:GetO(), 16, 0) --spawn snobold
	    pUnit:RegisterEvent("Gormok_RatThird", 30000, 1)
	end
end

function Gormok_RatThird(pUnit, event)
	local randomplr=pUnit:GetRandomPlayer(0)
	if randomplr ~= nil then
		pUnit:SpawnCreature(34800, randomplr:GetX(), randomplr:GetY(), randomplr:GetZ(), randomplr:GetO(), 16, 0) --spawn snobold
	    pUnit:RegisterEvent("Gormok_RatFourth", 30000, 1)
	end
end

function Gormok_RatFourth(pUnit, event)
	local randomplr=pUnit:GetRandomPlayer(0)
	if randomplr ~= nil then
		pUnit:SpawnCreature(34800, randomplr:GetX(), randomplr:GetY(), randomplr:GetZ(), randomplr:GetO(), 16, 0) --spawn snobold
	    pUnit:RegisterEvent("Gormok_RatFifth", 30000, 1)
	end
end

function Gormok_RatFifth(pUnit, event)
	local randomplr=pUnit:GetRandomPlayer(0)
	if randomplr ~= nil then
		pUnit:SpawnCreature(34800, randomplr:GetX(), randomplr:GetY(), randomplr:GetZ(), randomplr:GetO(), 16, 0) --spawn snobold
	end
end



-------------
--  Fires  --
-------------

function Gormok_Fire(pUnit, event)
	local randomplr=pUnit:GetRandomPlayer(0)
	if randomplr ~= nil then
		pUnit:SpawnCreature(34801, randomplr:GetX(), randomplr:GetY(), randomplr:GetZ(), randomplr:GetO(), 16, 60000) --spawn fire visual trigger
	end
end

function FireVisual_OnSpawn(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE+UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:RegisterEvent("FireVisual_FireNova", 1000, 0)
	local x = pUnit:GetX();
	local y = pUnit:GetY();
	local z = pUnit:GetZ();
	local o = pUnit:GetO();
	pUnit:SpawnGameObject(34801, x, y, z, o, 60000) --spawn fire GO at visual's position
	pUnit:Root()
end

function FireVisual_FireNova(pUnit, event)
	pUnit:CastSpell(37371, pUnit:GetRandomPlayer(0))
end

RegisterUnitEvent(34801, 18, "FireVisual_OnSpawn")



------------------
-- Other Spells --
------------------

function Gormok_Stomp(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:FullCastSpell(66330, randomplr_0)
	end
end

function Gormok_Impale(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:CastSpellOnTarget(66331, maintank)
	end
end



----------------------------------
-- 	Other Unit Events	--
----------------------------------

function Gormok_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SpawnCreature(34816, 554.412, 94.4594, 396.096, 5.49938, 35, 0)
	pUnit:Despawn(1, 0)
end

function Gormok_OnAllianceDeath(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SpawnCreature(34799, 563.657, 167.491, 394.332, 4.703654, 16, 0)
	pUnit:SpawnCreature(360952, 563, 78, 419, 4.4070, 35, 0)
	pUnit:Despawn(1, 0)
end

function Gormok_OnHordeDeath(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:SpawnCreature(54799, 563.657, 167.491, 394.332, 4.703654, 16, 0)
	pUnit:SpawnCreature(360952, 563, 78, 419, 4.4070, 35, 0)
	pUnit:Despawn(1, 0)
end

RegisterUnitEvent(34796, 4, "Gormok_OnAllianceDeath")
RegisterUnitEvent(54796, 4, "Gormok_OnHordeDeath")

RegisterUnitEvent(34796, 2, "Gormok_OnLeaveCombat")
RegisterUnitEvent(54796, 2, "Gormok_OnLeaveCombat")