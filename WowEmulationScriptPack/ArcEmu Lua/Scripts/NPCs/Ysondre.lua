--[[********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, April 15, 2008. ]]
math.randomseed(os.time())
RegisterUnitEvent(14887,1,"Ysondre_OnCombat")
RegisterUnitEvent(14887,2,"Ysondre_OnWipe")
RegisterUnitEvent(14887,3,"Ysondre_OnKill")
RegisterUnitEvent(14887,4,"Ysondre_OnDeath")
-----------------------------------------------------------------------------------------------------
----------------------------- HOOKED EVENTS--------------------------------------------------
-----------------------------------------------------------------------------------------------------
function Ysondre_OnCombat(Unit,event)
	setvars(Unit,{deadplrs = {}})
	Unit:SendChatMessage(14,0,"The strands of LIFE have been severed! The Dreamers must be avenged!")
	Unit:RegisterEvent("Ysondre_DruidSpawn",5000, 0)
	Unit:RegisterEvent("Ysondre_Breath", math.random(9000,10000), 1)
	Unit:RegisterEvent("Ysondre_TailSweep", math.random(2000,2500),1)-- Dono about timers but tail sweep seems about every 2 secs.
	Unit:RegisterEvent("Ysondre_LightningWave", math.random(15000, 18000), 1)
end
function Ysondre_DruidSpawn(Unit, event)
	local hp = Unit:GetHealthPct()
	if hp <= 75 and phase == nil then
		Unit:SendChatMessage(14, 0, "Come forth, ye Dreamers - and claim your vengeance!")
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
	phase=1;
	return;
	end
	
	if hp <= 50 and phase == 1 then
		Unit:SendChatMessage(14, 0, "Come forth, ye Dreamers - and claim your vengeance!")
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
	phase=2;
	return;
	end
	
	if hp <= 25 and phase == 2 then
		Unit:SendChatMessage(14, 0, "Come forth, ye Dreamers - and claim your vengeance!")
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
		local player=Unit:GetRandomPlayer(0);
		Unit:SpawnCreature(15260, player:GetX(), player:GetY(), player:GetZ(), player:GetO(), 14, 0)
	phase=3;
	return;
	end
end
function Ysondre_LightningWave(Unit, event)
    Unit:FullCastSpellOnTarget(24819, Unit:GetRandomPlayer(0))
	Unit:RegisterEvent("Ysondre_LightningWave", math.random(15000, 18000), 1)
end
function Ysondre_OnWipe(Unit,event)
	Unit:RemoveEvents()
	--[[local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if v:GetEntry() == 15224 then
			v:Despawn(100, 0)
		end
	end]]
end
--[[function Emeriss_Fog(Unit,event)
	Unit:AddAssistTarget(Unit:SpawnCreature(15224, Unit:GetX(), Unit:GetY(), Unit:GetZ(), Unit:GetO(),14, 120000))
	Unit:RegisterEvent("Emeriss_Fog",120000, 1)
end]]
function Ysondre_OnKill(Unit,event, pMisc)
	local args = getvars(Unit)
	if pMisc:IsPlayer() == true then
		Unit:FullCastSpellOnTarget(25040,pMisc)
		table.insert(args.deadplrs,pMisc)
	end
end
function Ysondre_OnDeath(Unit,event)
	Unit:RemoveEvents()
end
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function Ysondre_Breath(Unit, event)
	Unit:StopMovement(3000)
	Unit:SetAttackTimer(3000,0)
	Unit:FullCastSpell(24818) -- noxious breath
	Unit:RegisterEvent("Ysondre_Breath", math.random(9000,10000), 1)
end
function Ysondre_TailSweep(Unit,event)
	local tbl = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do
		if Unit:GetDistance(v) <= 50 then
			if v:IsInBack(Unit) == true then
				Unit:SetAttackTimer(3000,0)
				Unit:FullCastSpell(15847) -- tail sweep if any players are found behind emeriss
			end
			break
		end
	end
	Unit:RegisterEvent("Ysondre_TailSweep",math.random(2000,3000), 1)
end
--[[function Emeriss_Immune(Unit,event)
	if Unit:HasAura(24871) == true then
		Unit:RemoveAura(24871)
	end
end
function Emeriss_MTRange(Unit,event)
	local tank = Unit:GetMainTank()
	if Unit:GetDistance(tank) >= 100 then -- if current Mt is trying to run away, GET OVER HERE!
		tank:Teleport(0, Unit:GetX(), Unit:GetY(), Unit:GetZ())
		Unit:PlaySpellVisual(tank,24776)-- "Summon Player" visual.
	end
	Unit:RegisterEvent("Emeriss_MTRange", 1000, 1)
end]]
-------------------------------------------------------------------------------------------

--[[RegisterUnitEvent(15224, 18, "DreamFog_OnSpawn")
RegisterUnitEvent(15224, 19, "DreamFog_OnReachWp") -- Once we have created the waypoint and it has moved to the waypoint
function DreamFog_OnSpawn(Unit,event)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_ATTACKABLE_2)
	Unit:SetModel(18075)
	Unit:CastSpell(24777) -- Dream fog spell, a periodic aoe sleep of nearby players.
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatTargetingCapable(1)
	Unit:WipeTargetList()
	Unit:ModifyWalkSpeed(9) -- The fog movement is fairly fast
	Unit:RegisterEvent("DreamFog_Patrol",100, 1)-- Immediately it spawns, it starts is routine of going after random plrs.
end
function DreamFog_Patrol(Unit,event)
	local tbl = Unit:GetInRangePlayers() -- get an overall table of plrs fighting emeriss
	local no = math.random(1,table.getn(tbl))
	Unit:CreateCustomWaypointMap()
	Unit:CreateWaypoint(tbl[no]:GetX(),tbl[no]:GetY(),tbl[no]:GetZ(),Unit:GetO(),0,0,0) -- create a waypoint to our random target
	Unit:MoveToWaypoint(1) -- move to the waypoint
	Unit:RegisterEvent("DreamFog_MarkCheck", 1000, 1) -- we start registering our periodic mark check
end
function DreamFog_MarkCheck(Unit,event)
	local plr = Unit:GetClosestPlayer() -- Our closest plr while moving
	if plr ~= nil and Unit:GetDistance(plr) <= 20 then -- Make sure we are in aura range of the player before checking him
		if plr:HasAura(25040) == true then -- If the player has a Mark of Nature aura
			if plr:HasAura(25043) == false then
				Unit:FullCastSpellOnTarget(25043, plr) -- Instead of 4 sec sleep, its a a 1.5min stun.
				plr:RemoveAura(24778)
			else
				Unit:RemoveEvents()
			end
		else
			Unit:RemoveEvents()
		end
	else
		Unit:RemoveEvents()
	end
	Unit:RegisterEvent("DreamFog_MarkCheck", 1000, 1)-- loops this event very 1 sec
end
function DreamFog_OnReachWp(Unit,event,pMisc, wp)
	Unit:RemoveEvents()
	if wp == 1 then -- if the waypoint id is 1 proceed
		Unit:DestroyCustomWaypointMap() -- we delete our waypoint to create another
		Unit:RegisterEvent("DreamFog_Patrol", 100, 1) -- We restart the patrol event to get a new target to move to.
	end
end]]


--Demented Druid Spirit AI
function Druid_Moonfire(pUnit, event)
     pUnit:FullCastSpellOnTarget(24957, pUnit:GetRandomPlayer(0))
	 pUnit:RegisterEvent("Druid_Moonfire", math.random(6000, 9000), 1)
end

function Druid_Silence(pUnit, event)
     pUnit:FullCastSpellOnTarget(6726, pUnit:GetRandomPlayer(0))
	 pUnit:RegisterEvent("Druid_Silence", math.random(8000, 12000), 1)
end

function Druid_OnEnterCombat(pUnit, event)
	 pUnit:RegisterEvent("Druid_Moonfire", math.random(6000, 9000), 1)
	 pUnit:RegisterEvent("Druid_Silence", math.random(8000, 12000), 1)
end

RegisterUnitEvent(15260, 1, "Druid_OnEnterCombat")

function Druid_OnWipe(pUnit, event)
     pUnit:RemoveEvents()
	 pUnit:Despawn(100, 0)
end

RegisterUnitEvent(15260, 2, "Druid_OnWipe")