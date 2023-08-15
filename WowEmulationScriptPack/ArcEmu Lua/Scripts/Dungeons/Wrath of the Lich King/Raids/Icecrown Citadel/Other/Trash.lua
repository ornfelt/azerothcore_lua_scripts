INSTANCEID = {}

function TheDamned_OnCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RegisterEvent("BoneFlurry", 30000, 0)
end

function BoneFlurry(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:CastSpell(70960)
end

function TheDamned_OnDead(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RemoveEvents()
	pUnit:FullCastSpell(70961)
end

function TheDamned_OnLeaveCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37011, 1, "TheDamned_OnCombat")
RegisterUnitEvent(37011, 2, "TheDamned_OnLeaveCombat")
RegisterUnitEvent(37011, 4, "TheDamned_OnDead")

function SkeletalSoldier_OnCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RegisterEvent("ShieldBash", 21000, 0)
end

function ShieldBash(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	local tank = pUnit:GetMainTank()
	pUnit:FullCastSpellOnTarget(70964, tank)
end

function SkeletalSoldier_OnLeaveCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RemoveEvents()
end

function SkeletalSoldier_OnDead(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37012, 1, "SkeletalSoldier_OnCombat")
RegisterUnitEvent(37012, 2, "SkeletalSoldier_OnLeaveCombat")
RegisterUnitEvent(37012, 4, "SkeletalSoldier_OnDead")

function Servant_OnCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RegisterEvent("GlacialBlast", 15000, 0)
end

function GlacialBlast(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	local tank = pUnit:GetMainTank()
	pUnit:FullcastSpellOnTarget(71029, tank)
end

function Servant_OnLeaveCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RemoveEvents()
end

function Servant_OnDead(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RemoveEvents()
end

RegisterUnitEvent(36724, 1, "Servant_OnCombat")
RegisterUnitEvent(36724, 2, "Servant_OnLeaveCombat")
RegisterUnitEvent(36724, 4, "Servant_OnDead")

WARDEN = {
	A = {},
	B = {},
	C = {},
	D = {}
}

function Deathbound_Declare(pUnit, event)
	local SpawnId = pUnit:GetSpawnId()
	
	if SpawnId == 134153 then
		WARDEN[A] = GetLocalCreature(37007):GetSpawnId(134153)
	elseif SpawnId == 134154 then
		WARDEN[B] = GetLocalCreature(37007):GetSpawnId(134154)
	elseif SpawnId == 134155 then
		WARDEN[C] = GetLocalCreature(37007):GetSpawnId(134155)
	elseif SpawnId == 134156 then
		WARDEN[D] = GetLocalCreature(37007):GetSpawnId(134156)
	end
end

function Deathbound_OnCombat(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:RegisterEvent("DisruptingShout", 21000, 0)
	pUnit:RegisterEvent("SaberLash", 19000, 0)
end

function DisruptingShout(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:FullCastSpell(71022)
end

function SaberLash(pUnit, event)
	INSTANCEID[tostring(pUnit)] = pUnit
	pUnit:FullCastSpellOnTarget(71021, pUnit:GetMainTank())
end

function Deathbound_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function Deathbound_OnDead(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(37007, 18, "Deathbound_Declare")
RegisterUnitEvent(37007, 1, "Deathbound_OnCombat")
RegisterUnitEvent(37007, 2, "Deathbound_OnLeaveCombat")
RegisterUnitEvent(37007, 4, "Deathbound_OnDead")
	
TRAP = {
	A = {},
	B = {}, 
	C = {}
}

function Traps_Declare(pMisc, event)
	pMisc:SetUInt32Value(0x0006+0x0003,0x1)
	local spawnid = pMisc:GetSpawnId()
	if SpawnId == 53349 then
		TRAP[A] = GetLocalGameObject(201814):GetSpawnId(80968)
	elseif SpawnId == 53350 then
		TRAP[B] = GetLocalGameObject(201814):GetSpawnId(80969)
	elseif SpawnId == 53351 then
		TRAP[C] = GetLocalGameObject(201814):GetSpawnId(58613)
	RegisterTimedEvent("Traps_CheckDistance", 1000, 0)
	end
end

function Traps_CheckDistance(...)
	for _,v in pairs(GetPlayersInMap(631)) do
		if v:GetDistance(TRAP[A]) <= 3 then
			WARDEN[A]:MoveToUnit(v)
			TRAP[A]:Activate()
			TRAP[A]:Despawn(0, 12000)
		elseif v:GetDistance(TRAP[B]) <= 3 then
			WARDEN[B]:MoveToUnit(v)
			TRAP[B]:Activate()
			TRAP[B]:Despawn(0, 12000)
		elseif v:GetDistance(TRAP[C]) <= 3 then
			WARDEN[C]:MoveToUnit(v)
			WARDEN[D]:MoveToUnit(v)
			TRAP[C]:Activate()
			TRAP[C]:Despawn(0, 12000)
			break;
		end
	end
end

RegisterGameObjectEvent(201814, 2, "Traps_Declare")