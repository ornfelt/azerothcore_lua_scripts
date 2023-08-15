local UNIT_FLAG_NOT_ATTACKABLE_1 = 320
local UNIT_FLAG_IS_ATTACKABLE_1 = 0
local UNIT_FLAG_NOT_SELECTABLE = 33554432




--------------
--   INTRO  --
--------------

function Dread_OnSpawn(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_1)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatSpellCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:RegisterEvent("Dread_Attack", 5000, 1)
end

RegisterUnitEvent(34799, 18, "Dread_OnSpawn")
RegisterUnitEvent(54799, 18, "Dread_OnSpawn")

function Dread_Attack(pUnit, event)
	pUnit:SetFaction(16)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_IS_ATTACKABLE_1)
	pUnit:SetCombatCapable(0)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:SetCombatRangedCapable(0)
	pUnit:SetCombatSpellCapable(0)
	pUnit:SetCombatTargetingCapable(0)
	pUnit:SpawnCreature(35144, 546.329, 167.369, 394.667, 5.046088, 16, 0)
	pUnit:ModifyWalkSpeed(8)
		local plr=pUnit:GetClosestPlayer()
		if plr ~= nil then
			pUnit:MoveTo(plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO())
		end
end

function Dread_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Dread_PoisonCloud", 10000, 0)
	pUnit:RegisterEvent("Dread_MoltenSpew", 22000, 0)
	pUnit:RegisterEvent("Dread_BurningBite", 30000, 0)
	pUnit:RegisterEvent("Dread_SwitchToStationary", 70000, 1)
end

RegisterUnitEvent(34799, 1, "Dread_OnCombat")
RegisterUnitEvent(54799, 1, "Dread_OnCombat")




--------------------------------------------
--  Switch between mobile and stationary  --
--------------------------------------------

function Dread_SwitchToStationary(pUnit, event)
	pUnit:Root()
	pUnit:RemoveEvents()
	pUnit:SetModel(26935)
	pUnit:Root()
	pUnit:RegisterEvent("Dread_FireSpit", 1500, 0)
	pUnit:RegisterEvent("Dread_BurningSpray", 30000, 0)
	pUnit:RegisterEvent("Dread_Sweep", 28000, 0)
	pUnit:RegisterEvent("Dread_SwitchBackToMobile", 70000, 1)
end

function Dread_SwitchBackToMobile(pUnit, event)
	pUnit:Unroot()
	pUnit:RemoveEvents()
	pUnit:SetModel(24564)
	pUnit:Unroot()
	pUnit:RegisterEvent("Dread_PoisonCloud", 10000, 0)
	pUnit:RegisterEvent("Dread_MoltenSpew", 22000, 0)
	pUnit:RegisterEvent("Dread_BurningBite", 30000, 0)
	pUnit:RegisterEvent("Dread_SwitchToStationary", 70000, 1)
end




--------------
--  spells  --
--------------

function Dread_MoltenSpew(pUnit, event)
	local maintank=pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:FullCastSpellOnTarget(66820, maintank)
	end
end

function Dread_BurningBite(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:CastSpellOnTarget(66879, randomplr_0)
	end
end

function Dread_FireSpit(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:FullCastSpellOnTarget(66796, maintank)
	end
end

function Dread_BurningSpray(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:FullCastSpellOnTarget(66902, randomplr_0)
	end
end

function Dread_Sweep(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:FullCastSpellOnTarget(66794, maintank)
	end
end



---------------------
--  Poison Clouds  --
---------------------

function Dread_PoisonCloud(pUnit, event)
    local x, y, z, o=pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO();
	pUnit:SpawnCreature(34802, x, y, z, o, 16, 30000)
end

function PoisonCloud_OnSpawn(pUnit, event)
	pUnit:SetCombatCapable(1)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:SetCombatRangedCapable(1)
	pUnit:SetCombatTargetingCapable(1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
	pUnit:RegisterEvent("PoisonCloud_PoisonNova", 1000, 0)
	pUnit:Root()
end

function PoisonCloud_PoisonNova(pUnit, event)
	pUnit:CastSpell(59842, pUnit:GetRandomPlayer(0))
end

function PoisonCloud_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:Despawn(1, 0)
end

function PoisonCloud_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
	pUnit:Despawn(1, 0)
end

RegisterUnitEvent(34802, 18, "PoisonCloud_OnSpawn")
RegisterUnitEvent(34802, 2, "PoisonCloud_OnLeaveCombat")
RegisterUnitEvent(34802, 4, "PoisonCloud_OnDeath")



-----------------------
-- Other Unit Events --
-----------------------

function Dread_OnAllianceDeath(pUnit, event, Acid)
	local X,Y,Z = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ()
	local Acid = pUnit:GetCreatureNearestCoords(X,Y,Z,35144)
		if Acid ~= nil and Acid:IsAlive() == false then
			Acid:Despawn(1, 0)
			pUnit:SpawnCreature(360953, 563, 78, 419, 4.4070, 35, 0)
			pUnit:SpawnCreature(34797, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

function Dread_OnAllianceLeaveCombat(pUnit, event, Acid)
	local X,Y,Z = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ()
	local Acid = pUnit:GetCreatureNearestCoords(X,Y,Z,35144)
		if Acid ~= nil and Acid:IsAlive() == false then
			Acid:Despawn(1, 0)
			pUnit:SpawnCreature(34816, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

function Dread_OnHordeLeaveCombat(pUnit, event, Acid)
	local X,Y,Z = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ()
	local Acid = pUnit:GetCreatureNearestCoords(X,Y,Z,55144)
		if Acid ~= nil and Acid:IsAlive() == false then
			Acid:Despawn(1, 0)
			pUnit:SpawnCreature(34816, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

function Dread_OnHordeDeath(pUnit, event, Acid)
	local X,Y,Z = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ()
	local Acid = pUnit:GetCreatureNearestCoords(X,Y,Z,55144)
		if Acid ~= nil and Acid:IsAlive() == false then
			Acid:Despawn(1, 0)
			pUnit:SpawnCreature(360953, 563, 78, 419, 4.4070, 35, 0)
			pUnit:SpawnCreature(34797, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

RegisterUnitEvent(34799, 2, "Dread_OnAllianceLeaveCombat")
RegisterUnitEvent(34799, 4, "Dread_OnAllianceDeath")

RegisterUnitEvent(54799, 2, "Dread_OnHordeLeaveCombat")
RegisterUnitEvent(54799, 4, "Dread_OnHordeDeath")