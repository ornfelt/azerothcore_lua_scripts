--[[ Sapphiron.lua
********************************
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
-- LUA++ staff, April 06, 2008. ]]
--OPTIMIZATIONS: Complete.
--CLEANING: Complete.
--SCRIPT STATUS: Complete.

function Sapphiron_OnCombat(Unit, event)
	setvars(Unit,{
	Waterfall = nil,
	players = {},
	Sapphiron = {pUnit = Unit,GUID = Sapphiron:GetGUID()},
	IceBlock = nil,
	WingBuffet = nil,
	x = 0,
	y = 0,
	z = 0,
	radius = 0,
	radians = 0,
	summoncount = 0,
	clockwise = nil,
	FrostTrigger = nil})
	Unit:CastSpell(7940)
	Unit:SpawnGameObject(181225,3536.852783, -5159.951172, 143.636139,Unit:GetO(),0)
	Unit:RegisterEvent("Sapphiron_LifeDrain", 24000, 0)
	Unit:RegisterEvent("Chill", 15000, 0)
	Unit:RegisterEvent("Sapphiron_Cleave", 10000, 0)
	Unit:RegisterEvent("Sapphiron_Enrage", 900000, 0)
	Unit:RegisterEvent("Fly", 2000, 1)
	Unit:RegisterEvent("Sapphiron_FrostAura", 2000, 0)
	--TESTING AI TICK Unit:RegisterEvent("Sapphiron_CloseToDeath", 500, 0)
end

function Close(Unit)
	print "working xd"
	local args = getvars(Unit)
	args.Waterfall = Unit
	setvars(Unit,args)
	Unit:SetUInt32Value(GAMEOBJECT_STATE,1)
end

function Sapphiron_CloseToDeath(Unit, event)
	print "works"
	if Unit:GetHealthPct() <= 10 then
		Unit:RemoveEvents()
		Unit:RegisterEvent("Sapphiron_FrostAura", 2000, 0)
		Unit:RegisterEvent("Sapphiron_LifeDrain", 24000, 0)
		Unit:RegisterEvent("Sapphiron_Blizzard", 15000, 0)
		Unit:RegisterEvent("Sapphiron_Cleave", 10000, 0)
		Unit:RegisterEvent("Sapphiron_Enrage", 900000, 0)
	end
	if(Unit:IsFlying() == true) then
		Sapphiron_LandAlt(Sapphiron,event)
	end
end
function Sapphiron_LandAlt(Unit, event)
	Unit:Land()
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()-10,Unit:GetO())
	Unit:RegisterEvent("Sapphiron_Normal", 8000, 1)
end

function Chill(Unit,event)
	local args = getvars(Unit)
	if math.random(0,1) < 0.5 then
		args.clockwise = true
	else
		args.clockwise = false
	end
	local plr = Unit:GetRandomPlayer(0)
	local newx,newy,newz,o = plr:GetX(),plr:GetY(),plr:GetZ(),Unit:GetO()
	local newradius = Unit:CalcDistance(x,y,z)
	--[[ This will overwrite the Units globals destroying all previous entries.
		 You must define these first in the 'args' class before setting them.
		 The only exception to this is when you first define your starting variables
		 in your Unit's onCombat or onSpawn events, or if you want to destroy all previous entries?
	setvars(Unit,{x = newx,y = newy, z = newz,radius = newradius}) ]]
	-- Define new variables
	args.newx = x;
	args.newy = y;
	args.newz = z;
	args.newradius = radius;
	-- Then save them
	setvars(Unit, args);
	
	Unit:SpawnCreature(16082,args.x,args.y,args.z,o,Unit:GetFaction(),15000)
	if args.summoncount <= 20 then
		Unit:RegisterEvent("Circle",2000, 0)
	else
		--[[ same with here;		
		setvars(Unit,{summoncount= 0,x = 0,y = 0, z = 0, radians = 0,radius = 0}) ]]
		args.summoncount = 0;
		args.x = 0;
		args.y = 0;
		args.z = 0;
		args.radians = 0;
		args.radius = 0;
		-- save them.
		setvars(Unit, args);
	end
end
function Circle(Unit,event)
	local args = getvars(Unit)
	if (args.clockwise == true) then
		newradians = args.radians+0.314159
	elseif (args.clockwise == false) then
		newradians = args.radians-0.314159
	end
	local newsummoncount = args.summoncount + 1
	local newx = math.cos(radians)+args.radius
	local newy = math.sin(radians)+args.radius
	--setvars(Unit,{x = newx,y = newy, summoncount = newsummoncount, radians = newradians})
	args.x = newx;
	args.y = newy;
	args.summoncount = newsummoncount;
	args.radians = newradians;
	-- save them
	setvars(Unit, args);
	Unit:SpawnCreature(16082,args.x,args.y,args.z,args,Unit:GetO(),15000)
end

function ChillTrigger(Trigger,event)
	print "Yes OnSpawn for Creature works xD"
	local args = getvars(Unit)
	Trigger:SetNameById(args.Sapphiron.pUnit:GetEntry())
	Trigger:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE)
	Trigger:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_ATTACKABLE_2)
	Trigger:SetCombatMeleeCapable(1)
	Trigger:Root()
	Trigger:CastSpell(28547)
end

function Icebolt(Unit, event)
	local plr = Unit:GetRandomPlayer(0)
	if (plr~= nil) then
		Unit:FullCastSpellOnTarget(28522,plr)
		Unit:RegisterEvent("ImmunityCheck", 100,1 )
	end
end

function Sapphiron_FrostAura(Unit)
	Unit:CastSpell(28531)
end

function Sapphiron_LifeDrain(Unit, event)
	local tank = Unit:GetMainTank()
	if tank~= nil then
		Unit:FullCastSpellOnTarget(28542,tank)
	end
end

function Sapphiron_Cleave(Unit, event)
	if (Unit:GetMainTank() ~= nil) then
		Unit:CastSpellOnTarget(31345, Unit:GetMainTank())
	else
	end
end

function Sapphiron_Enrage(Unit)
	Unit:CastSpell(26662)
end

function Fly(Unit, event)
	print "Fly intitiated"
	Unit:RemoveEvents()
	Unit:SetCombatMeleeCapable(1)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:MoveTo(Unit:GetSpawnX(),Unit:GetSpawnY(),Unit:GetSpawnZ(),Unit:GetSpawnO())
	Unit:RegisterEvent("Fly2", 500, 1)
end

function Fly2(Unit,event)
	print "Fly2 intitiated"
	if Unit:IsCreatureMoving() == false then
		Unit:SetFlying()
		Unit:RegisterEvent("Fly3", 2000, 1)
	else
		Unit:RegisterEvent("Fly2", 500, 1)
	end
end

function Fly3(Unit, event)
	print "Fly3 intitiated"
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()+10,Unit:GetO())
	Unit:RegisterEvent("Fly4", 1000, 1)
end
	
function Fly4(Unit,event)
	print "Fly4 intitiated"
	if Unit:IsCreatureMoving() == false then
		Unit:SpawnCreature(17025,Unit:GetSpawnX(),Unit:GetSpawnY(),Unit:GetSpawnZ(),Unit:GetSpawnO(),Unit:GetFaction(),0)
		Unit:RegisterEvent("Icebolt", 2000, 5)
		Unit:RegisterEvent("Sapphiron_CastFrostBreath", 10000, 1)
	else
		Unit:RegisterEvent("Fly4",1000, 1)
	end
end

function WingBuffet(Unit,event)
	print "WingBuffet initiated"
	local args = getvars(Unit)
	args.WingBuffet = Unit
	setvars(Unit,args)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_ATTACKABLE_2)
	Unit:CastSpell(29328)
end

function ImmunityCheck(Unit,event)
	local args = getvars(Unit)
	local tbl = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do
		if v:HasAura(28522) == true then
			args.Sapphiron.pUnit:FullCastSpellOnTarget(7940,v)
			args.IceBlock = Unit:SpawnGameObject(181247,v:GetX(),v:GetY(),v:GetZ(),v:GetO(),25000)
			setvars(Unit,args)
		end
	end
	--setvars(Unit,args); should be in the for loop to avoid unnecessary work
end

function LoS(Unit,event)
	print "OnSpawn works"
	local args = getvars(Unit)
	for k,v in pairs(args) do print (k,v)
	end
	-- or -- table.foreach(args, print) - works the same as above just neater.
	local tbl = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do  
		print (k,v)
		if Unit:IsInFront(v) then
			local say = " is behind iceblock."
			Unit:SendChatMessage(12,0,v:GetName()..say)
			Unit:CastSpell(7940,v)
		end
	end
end
		

function Sapphiron_CastFrostBreath(Unit, event)
	Unit:SendChatMessage(16, 0, "Sapphiron takes a deep breath...")
	Unit:RemoveEvents()
	Unit:SpawnCreature(15624,Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO(),Unit:GetFaction(),0)
	Unit:RegisterEvent("Sapphiron_Land", 8000, 1)
end

---------------FROST BREATH DUMMY TRIGGER----------------
function Trigger(Unit,event)
	local args = getvars(Unit)
	args.FrostTrigger = Unit
	setvars(Unit,args)
	Unit:EnableMoveFly(1)
	Unit:SetUInt32Value(UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UNIT_FLAG_NOT_ATTACKABLE_2)
	Unit:SetMoveRunFlag(0)
	Unit:MoveTo(args.Sapphiron.pUnit:GetSpawnX(),args.Sapphiron.pUnit:GetSpawnY(),args.Sapphiron.pUnit:GetSpawnZ(),args.Sapphiron.pUnit:GetSpawnO())
	Unit:RegisterEvent("TriggerStopped", 1000, 1)
end

function TriggerStopped(Unit,event)
	print "TriggerStopped initiated"
	if(Unit:IsCreatureMoving() == false) then
		Unit:FullCastSpell(29318)
		Unit:RemoveFromWorld()
	else
		Unit:RegisterEvent("TriggerStopped",500,1)
	end
end

RegisterUnitEvent(15624,5,"Trigger")
----------------------------------------------------------------------------

function Sapphiron_Land(Unit, event)
	local tbl = Unit:GetInRangeObjects()
	local tbl2 = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do
		if v:GetEntry() == 181247 then
			v:RemoveFromWorld()
		end
	end
	for k,v in pairs(tbl2) do
		if v:HasAura(7940) == true then
			v:RemoveAura(7940)
		end
		if v:HasAura(28522) == true then
			v:Remove(28522)
		end
	end
	Unit:Land()
	Unit:SetCombatMeleeCapable(1)
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()-10,Unit:GetO())
	Unit:RegisterEvent("Sapphiron_Normal", 3000, 1)
end

function Sapphiron_Normal(Unit, event)
	Unit:SetCombatMeleeCapable(0)
	Unit:GetMainTank()
	Unit:RegisterEvent("Sapphiron_Fly", 67000, 0)
	Unit:RegisterEvent("Sapphiron_FrostImmune", 0, 0)
	Unit:RegisterEvent("Sapphiron_FrostAura", 2000, 0)
	Unit:RegisterEvent("Sapphiron_LifeDrain", 24000, 0)
	--Unit:RegisterEvent("Sapphiron_Blizzard", 15000, 0)
	Unit:RegisterEvent("Sapphiron_Cleave", 10000, 0)
	Unit:RegisterEvent("Sapphiron_Enrage", 900000, 0)
end

function Sapphiron_OnLeaveCombat(Unit)
	local args = getvars(Unit)
	if args.Waterfall ~= nil then
		args.Waterfall:SetUInt32Value(GAMEOBJECT_STATE,0)
	end
	setvars(Unit,true)
	--collectgarbage(); No longer needed as setvars will take care of garbage collection now.
	Unit:RemoveEvents()
end

function Sapphiron_OnDied(Unit)
	Unit:CastSpell(29357)
	local args = getvars(Unit)
	if args.Waterfall ~= nil then
		args.Waterfall:SetUInt32Value(GAMEOBJECT_STATE,0)
	end
	--setvars(Unit,true) this will be taken care of in the OnLeaveCombat so no need to do it twice.
end

RegisterUnitEvent(17025,5,"WingBuffet")
RegisterGameObjectEvent(181225, 2, "Close")
RegisterUnitEvent(15989,7,"Sapphiron_CloseToDeath")
RegisterUnitEvent(16082,5,"ChillTrigger")
RegisterGameObjectEvent(181247,2,"LoS")
RegisterUnitEvent(15989, 1, "Sapphiron_OnCombat")
RegisterUnitEvent(15989, 2, "Sapphiron_OnLeaveCombat")
RegisterUnitEvent(15989, 4, "Sapphiron_OnDied")