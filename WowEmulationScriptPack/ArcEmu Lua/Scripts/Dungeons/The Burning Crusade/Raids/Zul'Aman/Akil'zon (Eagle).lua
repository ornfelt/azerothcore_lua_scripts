--[[ Boss - args.AKILZON.lua

This script was written and is protected
by the GPL v2. This script was released
by Paroxysm of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Paroxysm, August 27, 2008. ]]

 -- 1 table to handle it all muahahah!
function INSTANCE_ZULAMAN.AKILZON.AkilzonOnSpawn(Unit)
	local args = getvars(Unit)
	if args == nil or args.AKILZON == nil then
		setvars(Unit,{ AKILZON = {
		gust_timer = 0,
		calllight_timer = 0,
		static_timer = 0,
		storm_timer = 0,
		cancast = false,
		soaring_table = {},
		akilzonptr = nil,
		}} )
	end
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonOnCombat(Unit)
	local args = getvars(Unit)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL, "I be da predator! You da prey!")
	Unit:PlaySoundToSet(12013)
	Unit:RegisterAIUpdateEvent(1000)
	args.AKILZON.cancast = true
	args.AKILZON.akilzonptr = Unit
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonCanCast(Unit)
	local args = getvars(Unit)
	args.AKILZON.cancast = true
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonOnKilledTarget(Unit,event,target)
	if target:IsPlayer() == true then
		if math.random(2) == 1 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Stop ya crying'!")
			Unit:PlaySoundToSet(12018)
		else
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Ya got nuthin'!")
			Unit:PlaySoundToSet(12017)
		end
	end
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonOnWipe(Unit)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonOnDeath(Unit)
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if type(v) == "userdata" and v:GetEntry() == 24858 then
			v:Die()
		end
	end
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL, "You can't... kill... me spirit!")
	Unit:PlaySoundToSet(12019)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonAIUpdate(Unit)
	local args = getvars(Unit)
	args.AKILZON.gust_timer = args.AKILZON.gust_timer + 1
	args.AKILZON.static_timer = args.AKILZON.static_timer + 1
	args.AKILZON.storm_timer = args.AKILZON.storm_timer+ 1
	args.AKILZON.calllight_timer = args.AKILZON.calllight_timer +1
	local plr = Unit:GetRandomPlayer(0)
	local tank = Unit:GetMainTank()
	local rand1 = math.random(10,20)
	local rand2 = math.random(20,30)
	if args.AKILZON.calllight_timer >= 15 and type(tank) == "userdata"  and tank:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.cancast = false
		args.AKILZON.calllight_timer = 0
		Unit:FullCastSpellOnTarget(43661,tank)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonCanCast",1000,1)
	elseif args.AKILZON.calllight_timer >=15 and type(tank) == "userdata"  and tank:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.calllight_timer = args.AKILZON.calllight_timer -1
	end
	if args.AKILZON.static_timer >= rand1 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.cancast = false
		args.AKILZON.static_timer = 0
		Unit:FullCastSpellOnTarget(44008,plr)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonCanCast",1000,1)
	elseif args.AKILZON.static_timer >= rand1 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.static_timer = args.AKILZON.static_timer - 1
	end
	if args.AKILZON.gust_timer  >= rand2 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.gust_timer = 0
		args.AKILZON.cancast = false
		Unit:FullCastSpellOnTarget(43621,plr)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonCanCast",1000,1)
	elseif args.AKILZON.gust_timer >= rand2 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.gust_timer = args.AKILZON.gust_timer - 1
	end
	if args.AKILZON.storm_timer >= 60 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.storm_timer = 0
		args.AKILZON.cancast = false
		Unit:FullCastSpellOnTarget(43648,plr)
		INSTANCE_ZULAMAN.AKILZON.AkilzonElectricalStorm(Unit,plr)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonCanCast",9000,1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonSummonEagles",15000,1)
	elseif args.AKILZON.storm_timer >= 60 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.storm_timer  = args.AKILZON.storm_timer - 1
	end
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonSummonEagles(Unit)
	local args = getvars(Unit)
	if table.getn(args.AKILZON.soaring_table) <= 20 then
		for i = 1,math.random(6,7) do
			Unit:SpawnCreature(24858,Unit:GetX(),Unit:GetY(),Unit:GetZ()+20,Unit:GetO(),Unit:GetUInt32Value(UnitField.UNIT_FIELD_FACTIONTEMPLATE),0)
		end
		local choice = math.random(2)
		if choice == 2 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Feed me bruddahs!")
			Unit:PlaySoundToSet(12014)
		elseif choice == 1 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Come and join me bruddah!")
			Unit:PlaySoundToSet(12015)
		end
	else
		Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.Akilzon_SummonEagles",1000,1)
	end
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonElectricalStorm(Unit,plr)
	plr:EnableFlight()
	plr:MonsterMove(plr:GetX(),plr:GetY(),plr:GetZ()+15.0,2000,768)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonElectricalStorm02",6000,1)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonElectricalStorm03",8000,1)
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonElectricalStorm02(Unit)
	local plr = Unit:GetNextTarget()
	plr:SetPosition(plr:GetX(),plr:GetY(),plr:GetZ()+15.0)
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonElectricalStorm03(Unit)
	local plr = Unit:GetNextTarget()
	plr:DisableFlight()
end
	
function INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnSpawn(Unit)
	local args = getvars(Unit)
	table.insert(args.AKILZON.soaring_table,Unit)
	local angle = 45
	local wp = 1
	for i = 1,8 do
		Unit:CreateWaypoint(wp,args.AKILZON.akilzonptr:GetSpawnX()+math.cos((angle/math.pi))*20,args.AKILZON.akilzonptr:GetSpawnY()+math.sin((angle/math.pi))*20,Unit:GetZ(),Unit:GetO(),0,768,0)
		wp = wp+1
		angle = angle*2
	end
	Unit:SetAIState(11)
	Unit:SetCombatMeleeCapable(1)
	Unit:MoveToWaypoint(1)
	INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleSwoop(Unit)
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleSwoop(Unit)
	local plr = Unit:GetRandomPlayer(0)
	if type(plr) == "userdata" and plr:IsAlive() == true then
		Unit:FullCastSpellOnTarget(44732,plr)
		--Unit:MoveToWaypoint(math.random(8))
	end
	Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleSwoop",math.random(3000,10000),1)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleReturn",1000,1)
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleReturn(Unit)
	Unit:MoveToWaypoint(math.random(8))
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnReachWp(Unit,null,null,wp)
	if wp == 1 then
		Unit:MoveToWaypoint(2)
	elseif wp == 2 then
		Unit:MoveToWaypoint(3)
	elseif wp == 3 then
		Unit:MoveToWaypoint(4)
	elseif wp == 4 then
		Unit:MoveToWaypoint(5)
	elseif wp == 5 then
		Unit:MoveToWaypoint(6)
	elseif wp == 6 then
		Unit:MoveToWaypoint(7)
	elseif wp == 7 then
		Unit:MoveToWaypoint(8)
	elseif wp == 8 then
		Unit:MoveToWaypoint(1)
	end
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnWipe(Unit)
	local args = getvars(Unit)
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveEvents()
	for k,v in pairs(args.AKILZON.soaring_table) do
		if v == Unit then
			table.remove(args.AKILZON.soaring_table,k)
		end
	end
end
function INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnDeath(Unit)
	local args = getvars(Unit)
	for k,v in pairs(args.AKILZON.soaring_table) do
		if v == Unit then
			table.remove(args.AKILZON.soaring_table,k)
		end
	end
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveEvents()
end
RegisterUnitEvent(23574,1,"INSTANCE_ZULAMAN.AKILZON.AkilzonOnCombat")
RegisterUnitEvent(23574,18,"INSTANCE_ZULAMAN.AKILZON.AkilzonOnSpawn")
RegisterUnitEvent(23574,4,"INSTANCE_ZULAMAN.AKILZON.AkilzonOnDeath")
RegisterUnitEvent(23574,21,"INSTANCE_ZULAMAN.AKILZON.AkilzonAIUpdate")
RegisterUnitEvent(23574,2,"INSTANCE_ZULAMAN.AKILZON.AkilzonOnWipe")
RegisterUnitEvent(23574,3,"INSTANCE_ZULAMAN.AKILZON.AkilzonOnKilledTarget")

RegisterUnitEvent(24858,1,"INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnSpawn")
RegisterUnitEvent(24858,2,"INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnWipe")
RegisterUnitEvent(24858,4,"INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnDeath")
RegisterUnitEvent(24858,18,"INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnSpawn")
RegisterUnitEvent(24858,19,"INSTANCE_ZULAMAN.AKILZON.AkilzonSoaringEagleOnReachWp")
	