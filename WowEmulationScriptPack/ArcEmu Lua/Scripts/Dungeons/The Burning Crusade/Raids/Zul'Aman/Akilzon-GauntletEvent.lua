--[[ Akilzon- Gauntlet Event
This script was written and is protected
by the GPL v2. This script was released
by Paroxysm of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Paroxysm, October 23, 2008. 
~~End of License Agreement]]

local amani_warrior = 24225
local amani_eagle = 24159
local amani_windwalker = 24179
local amani_lookout = 24175
local amani_protector = 24180
local amani_tempest = 24549
local soaring_eagle = 24858
local allowtempest = false
local amani_adds = {}
amani_adds["warriors"] = {}
amani_adds["eagles"] = {}
--.worldport 568 189.579239 1506.930331 25.916828
--[[
	AMANI LOOKOUT AI
	]]

function AmaniLookOut_OnCombat(Unit,event,pmisc)
	Unit:DestroyCustomWaypointMap()
	Unit:CreateCustomWaypointMap()
	Unit:CreateWaypoint(1,229.025361,1465.758911,25.916751,Unit:GetO(),0,256,0)
	Unit:CreateWaypoint(2,228.005325,1435.453491,26.726126,Unit:GetO(),0,256,0)
	Unit:CreateWaypoint(3,228.352188,1374.711426,46.888203,Unit:GetO(),0,256,0)
	Unit:SetCombatCapable(1)
	Unit:RegisterEvent("AmaniLookOut_Waypoints",200,1)
end
function AmaniLookOut_Waypoints(Unit)
	Unit:SetAllowedToEnterCombat(0)
	Unit:StopMovement(0)
	Unit:SetAIState(AI_State.STATE_SCRIPTMOVE)
	Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	allowtempest = true
	Unit:RegisterEvent("AmaniTempest_Initialize",10000, 1)
end
function AmaniLookOut_OnWipe(Unit)
	Unit:DestroyCustomWaypointMap()
	allowtempest = false;
end
function AmaniLookOut_OnDeath(Unit)
	Unit:DestroyCustomWaypointMap()
	allowtempest = false;
end
function AmaniLookOut_OnReachWp(Unit,null,null,wp)
	print("Current waypoint is : "..tonumber(wp))
	if wp == 1 then
		Unit:MoveToWaypoint(2)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
	elseif wp == 2 then
		Unit:MoveToWaypoint(3)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
	elseif wp == 3 then
		Unit:RemoveFromWorld()
	end
end
function AmaniTempest_Initialize(Unit)
	local tempest = Unit:GetCreatureNearestCoords(301.122009,1385.599976, 57.853100,amani_tempest)
	if type(tempest) == "userdata" then
		if tempest:IsAlive() == true and tempest:IsInCombat() == false then
			tempest:RemoveFromWorld()-- Need to use onspawn hook and set the tempest as event controller
			Unit:SpawnCreature(amani_tempest, 301.122009,1385.599976,57.853100,3.263770,1890,0)
		end
	else
		Unit:SpawnCreature(amani_tempest, 301.122009,1385.599976,57.853100,3.263770,1890,0)
	end
end

RegisterUnitEvent(amani_lookout, 1, "AmaniLookOut_OnCombat")
RegisterUnitEvent(amani_lookout, 19, "AmaniLookOut_OnReachWp")
RegisterUnitEvent(amani_lookout, 2, "AmaniLookOut_OnWipe")
RegisterUnitEvent(amani_lookout, 4,"AmaniLookOut_OnDeath")

--[[
	AMANI TEMPEST AI
		]]

function AmaniTempest_OnSpawn(Unit)
	Unit:DestroyCustomWaypointMap()
	if allowtempest == true then
		Unit:RegisterEvent("AmaniTempest_AddSpawn", 100, 1)
	end
	Unit:RegisterAIUpdateEvent(2000)
end
function AmaniTempest_AIUpdate(Unit)
	local warcount,eaglecount = table.getn(amani_adds["warriors"]),table.getn(amani_adds["eagles"])
	if warcount > 6 or eaglecount > 15 then -- This is a safety check to prevent from spawning too many mobs and lagg the server.
		allowtempest = false
	elseif warcount <= 6 and eaglecount <= 15 then
		allowtempest = true
	end
end
function AmaniTempest_AddSpawn(Unit)
	if allowtempest == true then
		for i = 1, math.random(5,6) do
			Unit:CastSpellAoF(296.047699,1384.848022,56.057110,43487)
		end
		Unit:CastSpellAoF(228.884476,1489.821777,25.937740,43486)
		Unit:CastSpellAoF(223.590759, 1490.079712,25.916952,43486)
		Unit:RegisterEvent("AmaniTempest_AddSpawndeux", 15000, 1)
	else
		Unit:RegisterEvent("AmaniTempest_AddSpawndeux", 3000, 1)
	end
end
function AmaniTempest_AddSpawndeux(Unit)
	if allowtempest == true then
		for i = 1, math.random(5,6) do
			Unit:CastSpellAoF(296.047699,1384.848022,56.057110,43487)
		end
		Unit:RegisterEvent("AmaniTempest_AddSpawn", 30000, 1)
	else
		Unit:RegisterEvent("AmaniTempest_AddSpawn", 3000, 1)
	end
end
function AmaniTempest_OnCombat(Unit)
	Unit:RemoveEvents()
	Unit:RegisterEvent("AmaniTempest_AOE",10000,0)
end
function AmaniTempest_AOE(Unit)
	if Unit:GetRandomPlayer(0)~= nil then
		Unit:FullCastSpell(44033) -- the aoe nature attack.
	end
end
function AmaniTempest_OnLeaveCombat(Unit)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
end
function AmaniTempest_OnDeath(Unit)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
	Unit:DisableRespawn()
end

RegisterUnitEvent(amani_tempest, 18, "AmaniTempest_OnSpawn")
RegisterUnitEvent(amani_tempest, 1, "AmaniTempest_OnCombat")
RegisterUnitEvent(amani_tempest, 2, "AmaniTempest_OnLeaveCombat")
RegisterUnitEvent(amani_tempest, 4, "AmaniTempest_OnDeath")
RegisterUnitEvent(amani_tempest, 21, "AmaniTempest_AIUpdate")

--[[
	AMANI TEMPEST ADDS AI
		]]

--[[
	AMANI Warriors
		]]
local kick_timer = nil
local charge_timer = nil
function AmaniWarrior_OnSpawn(Unit)
	local args = getvars(Unit)
	if args == nil or args.NALORAKK ==  nil then
		table.insert(amani_adds["warriors"],Unit)
		Unit:ModifySpeed(12)
		if allowtempest == true then
			Unit:DestroyCustomWaypointMap()
			Unit:CreateWaypoint(1,229.025361+(math.random(3)*math.cos(math.random(20,60))),1465.758911+(math.random(3)*math.sin(math.random(20,60))),25.916751,Unit:GetO(),500,256,0)
			Unit:CreateWaypoint(2,228.005325+(math.random(3)*math.cos(math.random(20,60))),1435.453491+(math.random(3)*math.sin(math.random(20,60))),26.726126,Unit:GetO(),500,256,0)
			Unit:CreateWaypoint(3,228.352188+(math.random(3)*math.cos(math.random(20,60))),1374.711426+(math.random(3)*math.sin(math.random(20,60))),46.888203,Unit:GetO(),500,256,0)
			Unit:CreateWaypoint(4,284.307404+(math.random(3)*math.cos(math.random(20,60))),1379.991211+(math.random(3)*math.sin(math.random(20,60))),49.321771,Unit:GetO(),500,256,0)
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
			--Unit:MoveToWaypoint(1)
			Unit:DisableRespawn(1)
		end
	end
end
function AmaniWarrior_OnReachWp(Unit,null,null,wp)
	local args = getvars(Unit)
	if args == nil or args.NALORAKK == nil then
		if wp == 1 then
			--Unit:MoveToWaypoint(2)
		elseif wp == 2 then
			--Unit:MoveToWaypoint(3)
		elseif wp == 3 then
			--Unit:MoveToWaypoint(4)
		elseif wp == 4 then -- gone to fourth wp and still not aggroed?
			Unit:RemoveFromWorld()
		end
	end
end
function AmaniWarrior_OnCombat(Unit,event,pMisc)
	kick_timer = 0
	charge_timer = 0
	Unit:DestroyCustomWaypointMap()
	Unit:StopMovement(100)
	Unit:RegisterAIUpdateEvent(2000)
end
function AmaniWarrior_Abilities(Unit)
	local args = getvars(Unit)
	if args == nil or args.NALORAKK == nil then return end
	if type(args.NALORAKK) == "table" and args.NALORAKK.gauntlet == true then
		return
	end
	if Unit:IsInCombat() == true then
		local tank = Unit:GetMainTank()
		kick_timer = kick_timer+2
		charge_timer = charge_timer+2
		if kick_timer >= 10 and type(tank) == "userdata" and tank:IsAlive() == true then
			local casters = {}
			local tbl = Unit:GetInRangePlayers()
			for k,v in pairs(tbl) do
				if type(v) == "userdata" and Unit:GetDistance(v) <= 10 and v:IsAlive() == true and v:GetCurrentSpellId() ~= nil then
					table.insert(casters,v)
				end
			end
			if table.getn(casters) ~= 0 then
				local randcaster = casters[math.random(1,table.getn(casters))]
				if type(randcaster) == "userdata" and randcaster:IsAlive() == true then -- Kick it!
					Unit:FullCastSpellOnTarget(43518,randcaster)
					kick_timer = 0
				end
			else
				Unit:FullCastSpellOnTarget(43518,tank)
				kick_timer = 0
			end
		elseif kick_timer >= 10 and type(tank) ~= "userdata" then
			kick_timer = kick_timer-2
		end
		if charge_timer >= 20 and type(tank) == "userdata" and tank:IsAlive() == true then
			local casters = {}
			local tbl = Unit:GetInRangePlayers()
			for k,v in pairs(tbl) do
				if type(v) == "userdata" and v:GetCurrentSpellId() ~= nil then
					table.insert(casters,v)
				end
			end
			if table.getn(casters) ~= 0 then
				local randcaster = casters[math.random(1,table.getn(casters))]
				if type(randcaster) == "userdata" and randcaster:IsAlive() == true then -- Lets charge his mofo ^ ^
					Unit:FullCastSpellOnTarget(43519,randcaster)
					charge_timer = 0
				end
			else
				Unit:FullCastSpellOnTarget(43519,tank)
				charge_timer = 0
			end
		elseif charge_timer >= 20 and type(tank) ~= "userdata" then
			charge_timer = charge_timer - 2
		end
	end
end	
function AmaniWarrior_OnWipe(Unit)
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveAIUpdateEvent()
end
function AmaniWarrior_OnDeath(Unit)
	local args = getvars(Unit)
	if type(args.NALORAKK) == "table" and args.NALORAKK.gauntlet == true then
		for k,v in pairs(args.NALORAKK.guardssent) do
			if v == Unit then
				table.remove(args.NALORAKK.guardssent,k)
			end
		end
	elseif not type(args.NALORAKK) == "table" or args.NALORAKK.gauntlet ~= true then
		Unit:DestroyCustomWaypointMap()
		Unit:RemoveAIUpdateEvent()
		for k,v in pairs(amani_adds["warriors"]) do
			if v == Unit then
				table.remove(amani_adds["warriors"],k)
			end
		end
	end
end
--[[
	AMANI EAGLES 
		]]
function AmaniEagle_OnSpawn(Unit)
	table.insert(amani_adds["eagles"],Unit)
	if allowtempest == true then
		Unit:ModifySpeed(20)
		Unit:CreateWaypoint(1,284.307404+(math.random(3)*math.cos(math.random(20,60))),1379.991211+(math.random(3)*math.sin(math.random(20,60))),49.321771,Unit:GetO(),500,256,0)
		Unit:CreateWaypoint(2,228.352188+(math.random(3)*math.cos(math.random(20,60))),1374.711426+(math.random(3)*math.sin(math.random(20,60))),46.888203,Unit:GetO(),500,256,0)
		Unit:CreateWaypoint(3,228.005325+(math.random(3)*math.cos(math.random(20,60))),1435.453491+(math.random(3)*math.sin(math.random(20,60))),26.726126,Unit:GetO(),500,256,0)
		Unit:CreateWaypoint(4,229.025361+(math.random(3)*math.cos(math.random(20,60))),1465.758911+(math.random(3)*math.sin(math.random(20,60))),25.916751,Unit:GetO(),500,256,0)
		Unit:MoveToWaypoint(1)
		Unit:DisableRespawn(1)
	end
end
function AmaniEagle_OnReachWp(Unit,null,null,wp)
	if wp == 1 then
		Unit:MoveToWaypoint(2)
	elseif wp == 2 then
		Unit:MoveToWaypoint(3)
	elseif wp == 3 then
		Unit:MoveToWaypoint(4)
	elseif wp == 4 then
		Unit:RemoveFromWorld()
	end
end
function AmaniEagle_OnCombat(Unit, event, pMisc)
	Unit:DestroyCustomWaypointMap()
	Unit:StopMovement(100)
	Unit:RegisterEvent("AmaniEagle_Abilities", 7000, 1)
end
function AmaniEagle_OnWipe(Unit)
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveEvents()
	Unit:RemoveFromWorld()
end
function AmaniEagle_OnDeath(Unit)
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveEvents()
	for k,v in pairs(amani_adds["eagles"]) do
		if v == Unit then
			table.remove(amani_adds["eagles"],k)
		end
	end
end
function AmaniEagle_Abilities(Unit)
	local tank = Unit:GetMainTank()
	if Unit:IsAlive() == true and type(tank) == "userdata" and tank:IsAlive() and Unit:GetDistance(tank) <= 10 then
		Unit:FullCastSpellOnTarget(43517,tank) -- talon
		Unit:RegisterEvent("AmaniEagle_Abilities", 7000, 1)
	elseif Unit:IsAlive() == true and type(tank) ~= "userdata" then
		Unit:RegisterEvent("AmaniEagle_Abilities", 2000, 1)
	end
end

RegisterUnitEvent(amani_warrior, 18, "AmaniWarrior_OnSpawn")
RegisterUnitEvent(amani_eagle, 18, "AmaniEagle_OnSpawn")
RegisterUnitEvent(amani_warrior, 1,"AmaniWarrior_OnCombat")
RegisterUnitEvent(amani_eagle, 1, "AmaniEagle_OnCombat")
RegisterUnitEvent(amani_warrior, 2,"AmaniWarrior_OnWipe")
RegisterUnitEvent(amani_warrior, 4, "AmaniWarrior_OnDeath")
RegisterUnitEvent(amani_eagle, 2, "AmaniEagle_OnWipe")
RegisterUnitEvent(amani_eagle, 4,"AmaniEagle_OnDeath")
RegisterUnitEvent(amani_warrior, 19, "AmaniWarrior_OnReachWp")
RegisterUnitEvent(amani_eagle, 19, "AmaniEagle_OnReachWp")
RegisterUnitEvent(amani_warrior,21,"AmaniWarrior_Abilities")

--[[
	Amani Protector
		]]

function AmaniProtector_OnCombat(Unit)
	Unit:RegisterEvent("AmaniProtector_Abilities", 10000, 0)
end
function AmaniProtector_OnWipe(Unit)
	Unit:RemoveEvents()
end
function AmaniProtector_OnDeath(Unit)
	Unit:RemoveEvents()
end
function AmaniProtector_Abilities(Unit)
	local tank = Unit:GetMainTank()
	if math.random(3) == 1 and type(tank) == "userdata" and tank:IsAlive() == true then
		if Unit:IsAlive() == true then
			Unit:FullCastSpellOnTarget(15496,tank)
		end
	elseif math.random(3) == 2 and type(tank) == "userdata" and tank:IsAlive() == true then
		if Unit:IsAlive() == true then
			Unit:FullCastSpellOnTarget(43529, tank)
		end
	elseif math.random(3) == 3 then
		if Unit:IsAlive() == true and tank:IsAlive() == true then
			local tbl = Unit:GetInRangePlayers()
			local movplayers = {}
			for k,v in pairs(tbl) do
				if v:IsAlive() and v:IsMoving() == true and v:GetDistance(v) <= 10 then
					table.insert(movplayers,v)
				end
			end
			if table.getn(movplayers) ~= 0 then
				Unit:FullCastSpell(43530)
			else
				AmaniProtector_Abilities(Unit)
			end
		end
	end
end

RegisterUnitEvent(amani_protector, 1, "AmaniProtector_OnCombat")
RegisterUnitEvent(amani_protector, 2, "AmaniProtector_OnWipe")
RegisterUnitEvent(amani_protector, 4, "AmaniProtector_OnDeath")

--[[
	AMANI WIND WALKER 
		]]

function AmaniWindWalker_OnCombat(Unit)
	Unit:RegisterEvent("AmaniWindWalker_Abilities", 5000, 1)
	Unit:RegisterAIUpdateEvent(2000)
end
function AmaniWindWalker_OnWipe(Unit)
	Unit:RemoveEvents()
end
function AmaniWindWalker_OnDeath(Unit)
	Unit:RemoveEvents()
end
function AmaniWindWalker_HealAI(Unit)
	local allies = Unit:GetInRangeFriends()
	local healtable = {}
	table.insert(allies,Unit)
	for k,v in pairs(allies) do
		if type(v) == "userdata" and v:GetHealthPct() <= 50 then
			table.insert(healtable,v)
			if Unit:GetHealthPct() <= 50 then
				table.insert(healtable,Unit)
			end
		end
	end
	if table.getn(healtable) >= 1 then -- more than 1 target needs health!
		local healtar = healtable[math.random(1,table.getn(healtable))]
		if type(healtar) == "userdata" and healtar:IsAlive() == true then --Lets cast chain heal
			if healtar == Unit then
				Unit:FullCastSpell(43527)
			else
				Unit:FullCastSpellOnTarget(43527,healtar)				
			end
		end
	end
end
function AmaniWindWalker_Abilities(Unit)
	local tank = Unit:GetMainTank()
	if math.random(2) == 1 and type(tank) == "userdata" and tank:IsAlive() then
		local plrs = Unit:GetInRangePlayers()
		local movplrs = {}
		for k,v in pairs(plrs) do
			if type(v) == "userdata" and v:IsAlive() == true and v:IsMoving() == true then
				table.insert(movplrs,v)
			end
		end
		if table.getn(movplrs) ~= 0 then
			local freezetar = movplrs[math.random(1,table.getn(movplrs))]
			if type(freezetar) == "userdata" and freezetar:IsAlive() == true then
				Unit:FullCastSpellOnTarget(43524, freezetar)-- frost shock
				Unit:RegisterEvent("AmaniWindWalker_Abilities", 5000, 1)
			end
		else
			Unit:FullCastSpellOnTarget(43524,tank)
			Unit:RegisterEvent("AmaniWindWalker_Abilities", 2000, 1)
		end
	elseif math.random(2) == 2 and type(tank) == "userdata" and tank:IsAlive() == true then
		local plrs = Unit:GetInRangePlayers()
		local besttar = {}
		for k,v in pairs(plrs) do
			if type(v) == "userdata" and v:IsAlive() and v:GetHealthPct() <= 50 then -- store this target and try to spike him later
				table.insert(besttar,v)
			end
		end
		if table.getn(besttar) ~= 0 then
			local besttarget = besttar[math.random(1,table.getn(besttar))]
			if type(besttarget) == "userdata" and besttarget:IsAlive() and besttarget ~= tank then -- we attempt to finish off target
				Unit:FullCastSpellOnTarget(43526, besttarget)
				Unit:RegisterEvent("AmaniWindWalker_Abilities", 10000, 1)
			end
		else
			Unit:FullCastSpellOnTarget(43526, tank)
			Unit:RegisterEvent("AmaniWindWalker_Abilities", 10000, 1)
		end
	end
end

RegisterUnitEvent(amani_windwalker, 1, "AmaniWindWalker_OnCombat")
RegisterUnitEvent(amani_windwalker, 2, "AmaniWindWalker_OnWipe")
RegisterUnitEvent(amani_windwalker, 4, "AmaniWindWalker_OnDeath")
RegisterUnitEvent(amani_windwalker, 21, "AmaniWindWalker_HealAI")