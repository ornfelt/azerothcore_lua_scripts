local mod = getfenv(1)
if(type(mod) ~= "table") then 
	error("Missing Shadow Labyrinth module!") 
end
--module(mod._NAME..".GRAND_MASTER_VORPIL",package.seeall)
local self = getfenv(1)

function OnSpawn(unit)
	unit:PlaySoundToSet(10522)
	unit:MonsterYell("Keep your minds focused for the days of reckoning are close at hand. Soon, the destroyer of worlds will return to make good on his promise. Soon the destruction of all that is will begin!")
	unit:RegisterEvent(RandomEmote,3500,0)
end

function OnCombat(unit,_,mAggro)
	unit:RemoveEvents()
	self[tostring(unit)] = {
		draw = math.random(20,30),
		volley = math.random(2,5),
		rain = nil,
		banish = math.random(15,30),
		rifts = {},
		enrage = false,
		isHeroic = (mAggro:IsPlayer() and mAggro:IsHeroic() )
	}
	local say = math.random(1,3)
	if(say == 1) then
		unit:PlaySoundToSet(10524)
		unit:MonsterYell("I'll make an offering of your blood.")
	elseif(say == 2) then
		unit:PlaySoundToSet(10525)
		unit:MonsterYell("You'll be a fine example for the others.")
	else
		unit:MonsterYell("Good! A worthy sacrifice!")
		unit:PlaySoundToSet(10526)
	end
	unit:RegisterAIUpdateEvent(1000)
	unit:RegisterEvent(SummonPortals,math.random(7,9)*1000,1)
	local allies = unit:GetInRangeFriends()
	for _,v in pairs(allies) do
		if(unit:GetDistanceYards(v) <= 100) then
			v:AttackReaction(mAggro,1,0)
		end
	end
end

function RandomEmote(unit)
	local emote_type = math.random(1,4)
	if(emote_type == 1) then
		unit:Emote(LCF.EMOTE_ONESHOT_ROAR,0)
	elseif(emote_type == 2) then
		unit:Emote(LCF.EMOTE_ONESHOT_TALK,0)
	elseif(emote_type == 3) then
		unit:Emote(LCF.EMOTE_ONESHOT_EXCLAMATION,0)
	else
		unit:Emote(LCF.EMOTE_ONESHOT_NO,0)
	end
end

function SummonPortals(unit)
	unit:PlaySoundToSet(10523)
	unit:MonsterYell("Come to my aid! Heed your master now!")
	local summon_spells = {33582,33583,33584,33585,33586}
	local portal_coords = {
		{-304.642212,-252.788239,12.683180},
		{-305.964783,-269.496185,12.682022},
		{-280.969879,-242.080200,12.682602},
		{-266.907715,-289.525787,12.682111},
		{-222.894775,-262.996704,17.086409}
	}
	local angle = 0
	for i = 1,5 do
		local x,y,z = portal_coords[i][1],portal_coords[i][2],portal_coords[i][3]
		unit:CastSpellAoF(x,y,z,33566)
		local portal = unit:GetCreatureNearestCoords(x,y,z,19224)
		if(portal) then
			portal:SetUInt32Value(LCF.UNIT_CHANNEL_SPELL,summon_spells[i])
			portal:CastSpell(33569)
		end
	end
end

function TeleportPlayers(unit) -- Draw shadows triggers an unknown spell :(
	local x,y,z,o = unit:GetSpawnLocation()
	local enemies = unit:GetInRangeEnemies()
	for _,v in pairs(enemies) do
		if(v:IsCreature() ) then
			v:TeleportCreature(x,y,z)
		else
			v:Teleport(unit:GetMapId(),x,y,z,o)
		end
	end
	unit:TeleportCreature(x,y,z)
end

function OnWipe(unit)
	self[tostring(unit)] = nil
	unit:RemoveAIUpdateEvent()
	local units = unit:GetInRangeUnits()
	for _,v in pairs(units) do
		if(v:GetEntry() == 19226) then
			v:Despawn(1,0)
		end
	end
	if(unit:IsAlive() ) then
		unit:MonsterYell("Fools!")
	end
end

function OnKill(unit)
	local say = math.random(0,1)
	if(say) then
		unit:MonsterYell("I serve with pride!")
		unit:PlaySoundToSet(10527)
	else
		unit:MonsterYell("Your death is for the greater cause!")
		unit:PlaySoundToSet(10528)
	end
	local gate = unit:GetGameObjectNearestCoords(-160.663055,-310.451263,17.086189,183295)
	if(gate) then
		gate:Open()
	end
end

function OnDeath(unit)
	unit:MonsterYell("I give my life... gladly...")
	unit:PlaySoundToSet(10529)
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		return
	end
	local vars = self[tostring(unit)]
	vars.draw = vars.draw - 1
	vars.volley = vars.volley - 1
	vars.banish = vars.banish - 1
	
	if(vars.isHeroic and vars.banish <= 0) then
		local enemy = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(38791,enemy)
		vars.banish = math.random(15,30)
	elseif(vars.draw <= 0) then
		unit:FullCastSpell(33563)
		unit:MonsterYell("The darkness in your souls draws you ever closer...")
		vars.draw = math.random(20,30)
		vars.rain = 0
		unit:RegisterEvent(TeleportPlayers,1000,1)
	elseif(vars.rain ~= nil and vars.rain <= 0) then
		if(vars.isHeroic) then
			unit:FullCastSpell(39363)
		else
			unit:FullCastSpell(33617)
		end
		vars.rain = nil
	elseif(vars.volley <= 0) then
		unit:FullCastSpell(33841)
		vars.volley = math.random(10,15)
	end
end

RegisterUnitEvent(18732, 18, OnSpawn)
RegisterUnitEvent(18732, 1, OnCombat)
RegisterUnitEvent(18732, 2, OnWipe)
RegisterUnitEvent(18732, 3, OnKill)
RegisterUnitEvent(18732, 4, OnDeath)
RegisterUnitEvent(18732, 21, AIUpdate)

function VoidRift_OnSpawn(unit)
	self[tostring(unit)] = {
		spawn_time = math.random(2,5),
		reduce_timer = 45,
		reduce_cnt = 0
	}
	unit:RegisterAIUpdateEvent(1000)
	unit:FullCastSpell(33569)
	unit:SetUnselectable()
	local vorpil = unit:GetCreatureNearestCoords(-255.083817,-264.261200,17.086420,18732)
	if(vorpil) then
		unit:SetCreator(vorpil)
	end
end

function VoidRift_Update(unit)
	-- first make sure vorpil can allow us to spawn more.
	local vorpil = unit:GetCreator()
	if(vorpil:IsDead() or vorpil:IsInCombat() == false) then
		unit:RemoveAIUpdateEvent()
		self[tostring(unit)] = nil
		unit:Despawn(1,0)
		return
	end
	local vars = self[tostring(unit)]
	vars.spawn_time = vars.spawn_time - 1
	vars.reduce_timer = vars.reduce_timer - 1
	if(vars.spawn_time <= 0) then
		unit:FullCastSpell(unit:GetUInt32Value(LCF.UNIT_CHANNEL_SPELL))
		if(vars.reduce_cnt < 2) then
			vars.spawn_time = 30
		elseif(vars.reduce_cnt < 4) then
			vars.spawn_time = 25
		elseif(vars.reduce_cnt  < 6) then
			vars.spawn_time = 20
		elseif(vars.reduce_cnt > 7) then
			vars.spawn_time = 15
		end
	elseif(vars.reduce_timer <= 0) then
		vars.reduce_timer = 45
		vars.reduce_cnt = vars.reduce_cnt +1
	end
end

RegisterUnitEvent(19224, 18, VoidRift_OnSpawn)
RegisterUnitEvent(19224, 21, VoidRift_Update)

function Traveller_OnSpawn(unit)
	unit:DisableTargeting(true)
	local portal = unit:GetLocalCreature(19224)
	local vorpil = portal:GetCreator()
	if(vorpil) then
		unit:SetCreator(vorpil)
		unit:ModifyRunSpeed(3)
		unit:SetUnitToFollow(vorpil,1,math.pi)
		unit:RegisterAIUpdateEvent(500)
	else
		unit:Despawn(1000,0)
	end
end

function Traveller_OnWipe(unit)
	unit:RemoveAIUpdateEvent()
end

function TravellerUpdate(unit)
	local vorpil = unit:GetCreator()
	if(vorpil:IsInCombat() == false or vorpil:IsDead() ) then
		unit:Kill(unit)
		unit:Despawn(0,0)
		return
	end
	local heroic = self[tostring(vorpil)].isHeroic
	if(unit:GetDistanceYards(vorpil) <= 5) then
		if(heroic) then
			vorpil:FullCastSpell(39364)
		else
			vorpil:FullCastSpell(33783)
		end
		unit:FullCastSpell(33846)
		unit:RemoveAIUpdateEvent()
		unit:Despawn(1000,0)
	end
end

RegisterUnitEvent(19226, 18, Traveller_OnSpawn)
RegisterUnitEvent(19226, 21, TravellerUpdate)
RegisterUnitEvent(19226, 2, Traveller_OnWipe)