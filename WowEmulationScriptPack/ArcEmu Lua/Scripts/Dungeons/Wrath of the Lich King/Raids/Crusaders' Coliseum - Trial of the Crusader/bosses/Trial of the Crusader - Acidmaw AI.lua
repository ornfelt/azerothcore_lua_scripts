local UNIT_FLAG_NOT_ATTACKABLE_1 = 320
local UNIT_FLAG_IS_ATTACKABLE_1 = 0

--------------
--   INTRO  --
--------------

function Acid_OnSpawn(pUnit, event)
	pUnit:Root()
end

RegisterUnitEvent(35144, 18, "Acid_OnSpawn")
RegisterUnitEvent(55144, 18, "Acid_OnSpawn")

function Acid_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Acid_AcidSpit", 1500, 0)
	pUnit:RegisterEvent("Acid_ParalyticSpray", 30000, 0)
	pUnit:RegisterEvent("Acid_Sweep", 28000, 0)
	pUnit:RegisterEvent("Acid_SwitchToMobile", 70000, 1)
end

RegisterUnitEvent(35144, 1, "Acid_OnCombat")
RegisterUnitEvent(55144, 1, "Acid_OnCombat")




--------------------------------------------
--  Switch between mobile and stationary  --
--------------------------------------------

function Acid_SwitchToMobile(pUnit, event)
	pUnit:Root()
	pUnit:RemoveEvents()
	pUnit:SetModel(29816)
	pUnit:Root()
	pUnit:RegisterEvent("Acid_AcidicSpew", 22000, 0)
	pUnit:RegisterEvent("Acid_ParalyticBite", 30000, 0)
	pUnit:RegisterEvent("Acid_PoisonCloud", 10000, 0)
	pUnit:RegisterEvent("Acid_SwitchBackToStationary", 70000, 1)
end

function Acid_SwitchBackToStationary(pUnit, event)
	pUnit:Unroot()
	pUnit:RemoveEvents()
	pUnit:SetModel(29815)
	pUnit:Unroot()
	pUnit:RegisterEvent("Acid_AcidSpit", 1500, 0)
	pUnit:RegisterEvent("Acid_ParalyticSpray", 30000, 0)
	pUnit:RegisterEvent("Acid_Sweep", 28000, 0)
	pUnit:RegisterEvent("Acid_SwitchToMobile", 70000, 1)
end




--------------
--  spells  --
--------------

function Acid_AcidicSpew(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:FullCastSpell(66819, maintank)
	end
end

function Acid_ParalyticBite(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:CastSpellOnTarget(66824, randomplr_0)
	end
end

function Acid_AcidSpit(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:FullCastSpellOnTarget(66880, maintank)
	end
end

function Acid_ParalyticSpray(pUnit, event)
	local randomplr_0 = pUnit:GetRandomPlayer(0)
	if randomplr_0 ~= nil then
		pUnit:FullCastSpellOnTarget(66901, randomplr_0)
	end
end

function Acid_Sweep(pUnit, event)
	local maintank = pUnit:GetMainTank()
	if maintank ~= nil then
		pUnit:FullCastSpellOnTarget(66794, maintank)
	end
end




---------------------
--  Poison Clouds  --
---------------------

function Acid_PoisonCloud(pUnit, event)
    local x, y, z, o=pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), pUnit:GetO();
	pUnit:SpawnCreature(34802, x, y, z, o, 16, 30000)
end




-----------------------
-- Other Unit Events --
-----------------------
function Acid_OnAllianceDeath(pUnit, event, Dread)
    local Dread = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 34799);
		if Dread:IsAlive() == false then
			Dread:Despawn(1, 0)
			pUnit:SpawnCreature(360953, 563, 78, 419, 4.4070, 35, 0)
			pUnit:SpawnCreature(34797, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

function Acid_OnAllianceLeaveCombat(pUnit, event, Dread)
	local X,Y,Z = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ()
	local Dread = pUnit:GetCreatureNearestCoords(X,Y,Z,34799)
		if Dread:IsAlive() == false then
			Dread:Despawn(1, 0)
			pUnit:SpawnCreature(34816, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

function Acid_OnHordeDeath(pUnit, event, Dread)
    local Dread = pUnit:GetCreatureNearestCoords(pUnit:GetX(), pUnit:GetY(), pUnit:GetZ(), 54799);
		if Dread:IsAlive() == false then
			Dread:Despawn(1, 0)
			pUnit:SpawnCreature(360953, 563, 78, 419, 4.4070, 35, 0)
			pUnit:SpawnCreature(34797, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

function Acid_OnHordeLeaveCombat(pUnit, event, Dread)
	local X,Y,Z = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ()
	local Dread = pUnit:GetCreatureNearestCoords(X,Y,Z,54799)
		if Dread:IsAlive() == false then
			Dread:Despawn(1, 0)
			pUnit:SpawnCreature(34816, 563, 173, 394.339, 4.740840, 16, 0)
			pUnit:Despawn(1, 0)
		end
	pUnit:RemoveEvents()
end

RegisterUnitEvent(55144, 2, "Acid_OnHordeLeaveCombat")
RegisterUnitEvent(35144, 2, "Acid_OnAllianceLeaveCombat")

RegisterUnitEvent(55144, 4, "Acid_OnHordeDeath")
RegisterUnitEvent(35144, 4, "Acid_OnAllianceDeath")