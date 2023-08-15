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
]]
--.worldport 309 -12211.674805 -1960.163208 132.326385
math.randomseed(os.time())

function VileBranch_SpeakerOnDeath(Unit,event)
	local BLord = Unit:GetCreatureNearestCoords(-12167.799805,-1927.250000,153.830002,11382)
	BLord:SetCombatTargetingCapable(1)
	BLord:SetCombatCapable(1)
	BLord:ModifyRunSpeed(12)
	BLord:CreateCustomWaypointMap()
	BLord:CreateWaypoint(Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO(),0,256,0)
	BLord:MoveToWaypoint(1)
end

RegisterUnitEvent(11391, 4, "VileBranch_SpeakerOnDeath")

--[[
	HOOKED EVENTS BEGIN
	]]

function BloodLord_OnReachWp(Unit,event,pMisc)
	Unit:SetCombatTargetingCapable(0)
	Unit:SetCombatCapable(0)
	Unit:DestroyCustomWaypointMap()
end
function BloodLord_OnCombat(Unit,event)
	setvars(Unit,{plr = nil,deadplayers = {},chainedspirits={}})
	local args = getvars(Unit)
	Unit:SpawnCreature(15117,-12187.145508,-1962.733521,130.386520,0,35,0)
	Unit:SpawnCreature(15117,-12183.099609,-1968.462646,131.284744,0,35,0)
	Unit:SpawnCreature(15117,-12187.258789,-1974.669434,132.690292,0,35,0)
	Unit:SpawnCreature(15117,-12225.333008,-1975.840942,132.770447,0,35,0)
	Unit:SpawnCreature(15117,-12234.751953,-1938.407837,130.343292,0,35,0)
	Unit:SpawnCreature(15117,-12238.809570,-1929.147339,130.378067,0,35,0)
	Unit:SpawnCreature(15117,-12218.891602,-1930.268677,131.753494,0,35,0)
	Unit:SpawnCreature(14988,Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO(),Unit:GetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE),0)
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if v:GetEntry() == 15117 then
			table.insert(args.chainedspirits,v)
			print(v)
		end
	end
	Unit:RegisterEvent("BloodLord_Whirlwind",10000, 1)
	Unit:RegisterEvent("BloodLord_Fear", 5000, 1)
	Unit:RegisterEvent("BloodLord_Cleave", 10000, 1)
	Unit:RegisterEvent("BloodLord_Charge", 20000, 1)
	Unit:RegisterEvent("BloodLord_Watch", 30000, 1)
end
function BloodLord_OnWipe(Unit,event)
	Unit:RemoveEvents()
	Unit:ReturnToSpawnPoint()
	local args = getvars(Unit)
	for k,v in pairs(args.chainedspirits) do
		v:RemoveFromWorld() -- Despawn spirits after a wipe
	end
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if v:GetEntry() ==15117 then
			v:RemoveFromWorld() -- Just incase  during a wipe there are spirits that have been removed from table coz they are going to rez.
		end
	end
		
end
function BloordLord_OnKilledTarget(Unit,event,pMisc)
	local args = getvars(Unit)
	table.insert(args.deadplayers,pMisc)
	Unit:RegisterEvent("BloodLord_Ding",500, 1)
end
function BloodLord_OnDeath(Unit,event)
	Unit:RemoveEvents()
	local args = getvars(Unit)
	for k,v in pairs (args.chainedspirits) do
		v:RemoveFromWorld()
	end
end
--[[
	HOOKED EVENTS END
	]]
	
function BloodLord_Ding(Unit,event)
	local args = getvars(Unit)
	if table.getn(args.deadplayers) == 3 then
		Unit:FullCastSpell(24312)
		for k,v in pairs(args.deadplayers) do
			table.remove(args.deadplayers,k)
		end
	end
end
function BloodLord_MTCheck(Unit,event)
	local tank = Unit:GetMainTank()
	if Unit:GetDistance(tank) >= 100 then
		tank:Teleport(Unit:GetMapId(),Unit:GetX()-10,Unit:GetY()-1,Unit:GetZ())
	end
end

function BloodLord_Whirlwind(Unit,event)
	print "whirlwind"
	local plr = Unit:GetMainTank()
	if Unit:GetDistance(plr) <= 50 then
		Unit:FullCastSpell(13736)
		Unit:RegisterEvent("BloodLord_Whirlwindtwo",2000, 1)
	end
end
function BloodLord_Whirlwindtwo(Unit,event)
	print "whirlwind 2"
	Unit:FullCastSpell(15589)
	Unit:RegisterEvent("BloodLord_Whirlwind", 10000,1)
end
function BloodLord_Fear(Unit,event)
	print "Fear"
	local closemelees =  {}
	local tbl = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do
		if Unit:GetDistance(v) <= 50 then
			table.insert(closemelees,v)
		end
		if table.getn(closemelees) >= 1 then
			Unit:FullCastSpell(38946)
		end
	end
end
function BloodLord_Cleave(Unit,event)
	local plr = Unit:GetMainTank()
	if Unit:GetDistance(plr) <= 50 then
		Unit:FullCastSpellOnTarget(16856,plr)
		Unit:RegisterEvent("BloodLord_Cleave",15000, 1)
	else
		Unit:RegisterEvent("BloodLord_Cleave",1000, 1)
	end
end

function BloodLord_Charge(Unit,event)
	local plr = Unit:GetRandomPlayer(0)
	if Unit:GetDistance(plr) <= 100 then
		local tank = Unit:GetMainTank()
		if plr ~= nil and tank ~= nil and plr ~= tank then
			if Unit:GetDistance(plr) <= 100 then
				Unit:ModThreat(tank, 1)
				Unit:FullCastSpellOnTarget(24408,plr)
				Unit:SetNextTarget(plr)
				Unit:RegisterEvent("BloodLord_Charge", 20000, 1)
			end
		end
	else
		plr:Teleport(Unit:GetMapId(),Unit:GetX(),Unit:GetZ())
	end
end
function BloodLord_Watch(Unit,event)
	local args = getvars(Unit)
	Unit:RemoveEvents()
	local pr = Unit:GetRandomPlayer(0)
	args.plr = pr
	setvars(Unit, args)
	Unit:FullCastSpellOnTarget(24314,pr)
	Unit:SendChatMessage(16,0,Unit:GetName().." is watching "..pr:GetName().." very closely.")
	Unit:RegisterEvent("BloodLord_Watch2",8000, 1)
end
function BloodLord_Watch2(Unit,event)
	local args = getvars(Unit)
	if args.plr:IsPlayerAttacking() == true or args.plr:IsPlayerMoving() == true or args.plr:GetCurrentSpellId() ~= nil then
		Unit:FullCastSpellOnTarget(25821,args.plr)
		Unit:SetNextTarget(args.plr)
		setvars(Unit,{plr = nil})
	end
	Unit:RegisterEvent("BloodLord_Whirlwind",10000, 1)
	Unit:RegisterEvent("BloodLord_Fear", 5000, 1)
	Unit:RegisterEvent("BloodLord_Cleave", 7000, 1)
	Unit:RegisterEvent("BloodLord_Charge", 20000, 1)
	Unit:RegisterEvent("BloodLord_Watch", 30000, 1)
end

RegisterUnitEvent(11382,1,"BloodLord_OnCombat")
RegisterUnitEvent(11382,2,"BloodLord_OnWipe")
RegisterUnitEvent(11382,4,"BloodLord_OnDeath")
RegisterUnitEvent(11382,19,"BloodLord_OnReachWp")

--[[
	Ohgans AI
	]]

function Ohgan_OnCombat(Unit)
	Unit:RegisterEvent("Ohgan_Spells",10000, 0)
end
function Ohgan_Spells(Unit)
	local rand = math.random(1,2)
	local tank = Unit:GetMainTank()
	if rand == 1 and tank ~= nil then
		Unit:FullCastSpellOnTarget(24317,tank)
	elseif rand == 2  then 
		Unit:FullCastSpell(3391)
	end
end
function Ohgan_OnDied(Unit)
	local tbl = Unit:GetInRangeFriends()
	for k, v in pairs(tbl) do
		if v:GetEntry() == 11382 then
			v:FullCastSpell(24318)
		end
		break
	end
end

RegisterUnitEvent(14988,1,"Ohgan_OnCombat")
RegisterUnitEvent(14988, 4,"Ohgan_OnDied")

--[[
	Spirits AI
	]]

function ChainedSpirit_OnSpawn(Unit,event)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_2)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetCombatMeleeCapable(1)
	Unit:Root()
	Unit:RegisterEvent("ChainedSpirit_PlrCheck",5000, 0)
end
function ChainedSpirit_PlrCheck(Unit,event)
	local args = getvars(Unit)
	for k,v in pairs(args.deadplayers) do
		print(k,v)
	end
	if table.getn(args.deadplayers) ~= 0 then
		local chosenspirit = args.chainedspirits[math.random(1,table.getn(args.chainedspirits))]
		local chosenplr = args.deadplayers[math.random(1,table.getn(args.deadplayers))]
		if chosenspirit ~= nil and chosenplr ~= nil then
			chosenspirit:Unroot()
			chosenspirit:CreateCustomWaypointMap()
			chosenspirit:CreateCustomWaypoint(chosenplr:GetX(),chosenplr:GetY(),chosenplr:GetZ(),chosenplr:GetO(),0,0)
			chosenspirit:MoveToWaypoint(0)
			chosenspirit:SetNextTarget(chosenplr)
			table.remove(args.chainedspirits,chosenspirit)
			table.remove(args.deadplayers,chosenplr)
		end
	end
end

function ChainedSpirits_OnReachWp(Unit,event,pMisc,waypoint)
		Unit:DestroyCustomWaypointMap()
		local plr = Unit:GetNextTarget()
		Unit:PlaySpellVisual(plr,10880)
		plr:RessurectPlayer()
		table.insert(args.chainedspirits,Unit)
		Unit:ReturnToSpawnPoint()
end

RegisterUnitEvent(15117,19,"ChainedSpirits_OnReachWp")
RegisterUnitEvent(15117,18,"ChainedSpirit_OnSpawn")
