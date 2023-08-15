-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------

local rend_blackhand = 10429
local gyth = 10339
local rend_mounts = 16167
local summon_rend = 16328
local nefarius = 10162
local door = 175185
local trigger = 16082 -- random trigger I found, since Lua doesn't support serverhooks(YET), this will have to do.
local whelp = 10442
local dragonspawn = 10447
local blackhand_veteran =  10681
---------------------------------------------------------------------

function Trigger_OnSpawn(Unit,event)
	local gythe = Unit:GetCreatureNearestCoords(177.466003, -419.792999, 110.472000, gyth)
	if (gythe ~= nil) then
		gythe:RemoveFromWorld() -- noticed in NCDB, gyth is already spawned.
	end
	Unit:SetCombatCapable(1)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2)
	Unit:Root()
	Unit:RegisterAIUpdateEvent(5000)
end

function Trigger_AIUpdate(Unit,event)
	if (Unit:HasInRangePlayers() ~= false) then
		local tbl = Unit:GetInRangePlayers()
		local o = Unit:GetO()
		for k,v in pairs(tbl) do
			if (o >= v:GetO()) then -- the current O for trigger is set to be the highest in that level. If a player is lower, it means he has landed on the platform
				local rend = Unit:SpawnCreature(rend_blackhand, 156.610214, -444.813477, 121.976494, Unit:GetO(), 14, 0)
				if (rend ~= nil) then
					rend:SetCombatCapable(1)
					rend:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2)
					rend:Root()
				end
				local nef = Unit:GetCreatureNearestCoords(163.167999, -444.165009, 122.058998, nefarius)
				if (nef ~= nil) then
					nef:SetCombatCapable(1)
					nef:Root()
					nef:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2)
					nef:AttackReaction(v, 1, 0); -- we pass the event holder to nefarius.
				end
			break
			end
		end
		Unit:RemoveAIUpdateEvent()
		Unit:RemoveFromWorld()
	else
	end
end

RegisterUnitEvent(trigger, 18, "Trigger_OnSpawn")
RegisterUnitEvent(trigger, 21, "Trigger_AIUpdate")

--=========================================================================================

function Rend_Blackhand_EventStart(Unit,event)
	Unit:SendChatMessage(14, 0, "Let not even a drop of their blood remain upon the arena floor, my children. Feast on their souls!")
	Unit:RegisterAIUpdateEvent(1000)
	--We begin the waves. 7 total.
	setvars(Unit, {wavecount = 0, spawns = {}})
end

function args_spawns(Unit,event)
	local args = getvars(Unit)
	local no = table.getn(args.spawns)
	if (no ~= nil and no == 0 and args.wavecount <= 7) then
		if (args.wavecount == 1) then
			Unit:SendChatMessage(14, 0, "Foolsss... Kill the one in the dress!")
		elseif (args.wavecount == 2) then
			local rend = Unit:GetCreatureNearestCoords(156.610214, -444.813477, 121.976494,rend_blackhand)
			if (rend ~= nil) then
				rend:SendChatMessage(14, 0, "Sire, let me join the fray! I shall tear their spines out with my bare hands!")
			end
		elseif (args.wavecount == 3) then
			Unit:SendChatMessage(14, 0, "Inconceivable!")
		elseif (args.wavecount == 4) then
			Unit:SendChatMessage(14, 0, "Do not force my hand, children! I shall use your hides to line my boots.")
		elseif (args.wavecount == 5) then
			Unit:SendChatMessage(14, 0, "Defilers!")
		elseif (args.wavecount == 6) then
			Unit:SendChatMessage(14, 0, "Your efforts will prove fruitless. None shall stand in our way!")
		end
		setvars(Unit,{wavecount = wavecount+1})
		table.insert(args.spawns,Unit:SpawnCreature(whelp, 200.619995, -416.778015, 110.973999, Unit:GetO(), 14, 0))
		table.insert(args.spawns,Unit:SpawnCreature(whelp, 203.302994, -423.966003, 110.986000, Unit:GetO(), 14, 0))
		table.insert(args.spawns,Unit:SpawnCreature(whelp, 206.553177, -427.854492, 110.905647, Unit:GetO(), 14, 0))
		table.insert(args.spawns,Unit:SpawnCreature(dragonspawn, 203.022995, -421.907990, 110.986000, Unit:GetO(), 14, 0))
		table.insert(args.spawns,Unit:SpawnCreature(dragonspawn, 202.893417, -416.808899, 110.902893, Unit:GetO(), 14, 0))
		table.insert(args.spawns,Unit:SpawnCreature(blackhand_veteran,196.845749, -423.030029, 110.891159, Unit:GetO(), 14, 0))
		local gate = Unit:GetGameObjectNearestCoords(193.743774, -416.726807, 110.892677, door)
		if (gate ~= nil) then
			gate:SetUInt32Value(GAMEOBJECT_STATE, 0)
		end
		RegisterUnitEvent("Rend_GateShut", 3000, 1)-- shut door after few secs
	else
		Unit:SendChatMessage(14, 0, "THIS CANNOT BE!!! Rend, deal with these insects.")
		Unit:SpawnCreature(gyth, 214.0556244, -396.057404, 111.105141, Unit:GetO(), 14, 0)
		if (gate ~= nil) then
			gate:SetUInt32Value(GAMEOBJECT_STATE, 0)
		end
		local rend = Unit:GetCreatureNearestCoords(156.610214, -444.813477, 121.976494, rend_blackhand)
		rend:SendChatMessage(14, 0, "With pleasure...")
		if (rend ~= nil) then
			rend:RemoveFromWorld()
		end
		RegisterUnitEvent("Rend_GateShut", 5000, 1)-- shut door after few secs
	end
end

function Rend_GateShut(Unit,event)
	local gate = Unit:GetGameObjectNearestCoords(193.743774, -416.726807, 110.892677, door)
	if (gate ~= nil) then
		gate:SetUInt32Value(GAMEOBJECT_STATE, 1)
	end
end

RegisterUnitEvent(nefarius, 1, "Rend_Blackhand_EventStart")
RegisterUnitEvent(nefarius, 21, "args_spawns")

--==================================================================

function TrashWaveWp(Unit,event)
	if (Unit:GetEntry() == dragonspawn or blackhand_veteran) then
		Unit:CreateWaypoint(188.250244, -421.017517, 110.880814, 0, 256,0)
	else
		Unit:CreateWaypoint(188.250244,-421.017517, 110.880814, 0, 768,0)
	end
	Unit:MoveToWaypoint(1)
end

function Rend_TrashDied(Unit,event)
	local args = getvars(Unit)
	for k,v in pairs(args.spawns) do -- This should remove the particular unit that died.
		if (v == Unit) then
			table.remove(args.spawns, k)
		end
	end
end

RegisterUnitEvent(whelp, 4, "Rend_TrashDied")
RegisterUnitEvent(whelp, 18, "TrashWaveWp")
RegisterUnitEvent(dragonspawn, 4, "Rend_TrashDied")
RegisterUnitEvent(dragonspawn, 18, "TrashWaveWp")
RegisterUnitEvent(blackhand_veteran, 4, "Rend_TrashDied")
RegisterUnitEvent(blackhand_veteran, 18, "TrashWaveWp")

--===================================================================

function Gyth_Engaged(Unit,event)
	local nef = Unit:GetCreatureNearestCoords(163.167999, -444.165009, 122.058998, nefarius)
	if (nef ~= nil) then
		nef:SendChatMessage(14, 0, "The Warchief shall make quick work of you, mortals. Prepare yourselves!")
	end
	Unit:CastSpell(16167)-- To transform itself to look like hes mounted.
	Unit:CreateWaypoint(203.378326, -417.762177, 110.907867, 0, 768, 0)
	Unit:ModifyFlySpeed(12)
end

function Gyth_OnReachWp(Unit,event)
	Unit:DestroyCustomWaypointMap()
	Unit:MoveTo(177.466003, -419.792999, 110.472000, Unit:GetO())
end

function Gyth_OnCombat(Unit,event)
	Unit:RegisterAIUpdateEvent(1000)
	Unit:RegisterEvent()
end

function Gyth_AIUpdate(Unit,event)
	if (Unit:GetHealthPct() <= 20) then
		Unit:RemoveAura(16167)--Remove mounted aura
		Unit:FullCastSpell(16328)-- Summon Rend
	end
end

RegisterUnitEvent(gyth, 18, "Gyth_Engaged")
RegisterUnitEvent(gyth, 19, "Gyth_OnReachWp")
RegisterUnitEvent(gyth, 1, "Gyth_OnCombat")
RegisterUnitEvent(gyth, 21, "Gyth_AIUpdate")

--===============================================================================]]	