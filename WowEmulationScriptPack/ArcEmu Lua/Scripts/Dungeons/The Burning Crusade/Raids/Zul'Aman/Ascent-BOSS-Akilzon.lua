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
function AKILZON_OnSpawn(Unit)
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
function AKILZON_OnCombat(Unit)
	local args = getvars(Unit)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL, "I be da predator! You da prey!")
	Unit:PlaySoundToSet(12013)
	Unit:RegisterAIUpdateEvent(1000)
	args.AKILZON.cancast = true
	args.AKILZON.static_timer = 8 -- To start him off w/ a static disruption
	args.AKILZON.akilzonptr = Unit
	args.AKILZON.storm_timer = 58
end
function AKILZON_CanCast(Unit)
	local args = getvars(Unit)
	args.AKILZON.cancast = true
end
function AKILZON_OnKilledTarget(Unit,event,target)
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
function AKILZON_OnWipe(Unit)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
end
function AKILZON_OnDeath(Unit)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL, "You can't... kill... me spirit!")
	Unit:PlaySoundToSet(12019)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
end
function AKILZON_AIUpdate(Unit)
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
		Unit:RegisterEvent("AKILZON_CanCast",1000,1)
	elseif args.AKILZON.calllight_timer >=15 and type(tank) == "userdata"  and tank:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.calllight_timer = args.AKILZON.calllight_timer -1
	end
	if args.AKILZON.static_timer >= rand1 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.cancast = false
		args.AKILZON.static_timer = 0
		Unit:FullCastSpellOnTarget(44008,plr)
		Unit:RegisterEvent("AKILZON_CanCast",1000,1)
	elseif args.AKILZON.static_timer >= rand1 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.static_timer = args.AKILZON.static_timer - 1
	end
	if args.AKILZON.gust_timer  >= rand2 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.gust_timer = 0
		args.AKILZON.cancast = false
		Unit:FullCastSpellOnTarget(43621,plr)
		Unit:RegisterEvent("AKILZON_CanCast",1000,1)
	elseif args.AKILZON.gust_timer >= rand2 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.gust_timer = args.AKILZON.gust_timer - 1
	end
	if args.AKILZON.storm_timer >= 60 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == true then
		args.AKILZON.storm_timer = 0
		args.AKILZON.cancast = false
		Unit:FullCastSpellOnTarget(43648,plr)
		AKILZON_ElectricalStorm(Unit,plr)
		Unit:RegisterEvent("AKILZON_CanCast",9000,1)
		Unit:RegisterEvent("AKILZON_SummonEagles",15000,1)
	elseif args.AKILZON.storm_timer >= 60 and type(plr) == "userdata" and plr:IsAlive() == true and args.AKILZON.cancast == false then
		args.AKILZON.storm_timer  = args.AKILZON.storm_timer - 1
	end
end
function AKILZON_SummonEagles(Unit)
	if table.getn(args.AKILZON.soaring_table) <= 20 then
		for i = 1,math.random(6,7) do
			Unit:SpawnCreature(24858,Unit:GetX(),Unit:GetY(),Unit:GetZ()+20,Unit:GetO(),Unit:GetUInt32Value(UnitField.UNIT_FIELD_FACTIONTEMPLATE),0)
		end
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Feed me bruddahs!")
		Unit:PlaySoundToSet(12019)
	else
		Unit:RegisterEvent("AKILZON_SummonEagles",1000,1)
	end
end
function AKILZON_ElectricalStorm(Unit,plr)
	plr:MonsterMove(plr:GetX(),plr:GetY(),plr:GetZ()+15.0,3000,768)
	Unit:RegisterEvent("AKILZON_ElectricalStorm02",6000,1)
	Unit:RegisterEvent("AKILZON_ElectricalStorm03",8000,1)
end
function AKILZON_ElectricalStorm02(Unit)
	local plr = Unit:GetNextTarget()
	plr:SetPosition(plr:GetX(),plr:GetY(),plr:GetZ()+15.0)
	plr:Root()
end
function AKILZON_ElectricalStorm03(Unit)
	local plr = Unit:GetNextTarget()
	plr:Unroot()
end
	
function AKILZON_SoaringEagleOnSpawn(Unit)
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
	AKILZON_SoaringEagleSwoop(Unit)
end
function AKILZON_SoaringEagleSwoop(Unit)
	local plr = Unit:GetRandomPlayer(0)
	if type(plr) == "userdata" and plr:IsAlive() == true then
		Unit:FullCastSpellOnTarget(44732,plr)
		--Unit:MoveToWaypoint(math.random(8))
	end
	Unit:RegisterEvent("AKILZON_SoaringEagleSwoop",math.random(3000,10000),1)
	Unit:RegisterEvent("AKILZON_SoaringEagleReturn",1000,1)
end
function AKILZON_SoaringEagleReturn(Unit)
	Unit:MoveToWaypoint(math.random(8))
end
function AKILZON_SoaringEagleOnReachWp(Unit,null,null,wp)
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
function AKILZON_SoaringEagleOnWipe(Unit)
	local args = getvars(Unit)
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveEvents()
	for k,v in pairs(args.AKILZON.soaring_table) do
		if v == Unit then
			table.remove(args.AKILZON.soaring_table,k)
		end
	end
end
function AKILZON_SoaringEagleOnDeath(Unit)
	local args = getvars(Unit)
	for k,v in pairs(args.AKILZON.soaring_table) do
		if v == Unit then
			table.remove(args.AKILZON.soaring_table,k)
		end
	end
	Unit:DestroyCustomWaypointMap()
	Unit:RemoveEvents()
end
RegisterUnitEvent(23574,1,"AKILZON_OnCombat")
RegisterUnitEvent(23574,4,"AKILZON_OnDeath")
RegisterUnitEvent(23574,21,"AKILZON_AIUpdate")
RegisterUnitEvent(23574,2,"AKILZON_OnWipe")
RegisterUnitEvent(23574,3,"AKILZON_OnKilledTarget")

RegisterUnitEvent(24858,1,"AKILZON_SoaringEagleOnSpawn")
RegisterUnitEvent(24858,2,"AKILZON_SoaringEagleOnWipe")
RegisterUnitEvent(24858,4,"AKILZON_SoaringEagleOnDeath")
RegisterUnitEvent(24858,18,"AKILZON_SoaringEagleOnSpawn")
RegisterUnitEvent(24858,19,"AKILZON_SoaringEagleOnReachWp")
	