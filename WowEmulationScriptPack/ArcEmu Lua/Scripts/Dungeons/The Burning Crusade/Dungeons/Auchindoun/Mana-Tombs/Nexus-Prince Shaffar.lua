local mod = getfenv(1)
assert(type(mod) == "table")
--module(mod._NAME..".SHAFFAR",package.seeall)
local self = getfenv(1)
WorldDBQuery("DELETE FROM ai_agents WHERE entry = 18344;")

function OnSpawn(unit)
	for i = 1,3 do
		unit:FullCastSpell(32371)
	end
end

function OnCombat(unit,_,mAggro)
	self[tostring(unit)] = {
		fireball = math.random(2,5),
		frostbolt = math.random(2,5),
		blink = math.random(20,30),
		beacon_spawn = 10,
		isHeroic = (mAggro:IsPlayer() and mAggro:IsHeroic() )
	}
	local allies = unit:GetInRangeFriends()
	for _,v in pairs(allies) do
		if(v:GetEntry() == 18431) then
			v:AttackReaction(mAggro,1,0)
		end
	end
	local say_text = math.random(3)
	if(say_text == 1) then
		unit:MonsterYell("We have not yet been properly introduced.")
		unit:PlaySoundToSet(10541)
	elseif(say_text == 2) then
		unit:MonsterYell("An epic battle. How exciting!")
		unit:PlaySoundToSet(10542)
	else
		unit:MonsterYell("I have longed for a good adventure!")
		unit:PlaySoundToSet(10543)
	end
	unit:RegisterAIUpdateEvent(1000)
end

function OnWipe(unit)
	unit:RemoveAIUpdateEvent()
	self[tostring(unit)] = nil
end

function OnTargetKill(unit)
	local say_text = math.random()
	if(say_text) then
		unit:MonsterYell("It has been... entertaining.")
		unit:PlaySoundToSet(10544)
	else
		unit:MonsterYell("And now we part company.")
		unit:PlaySoundToSet(10545)
	end
end

function OnDeath(unit)
	unit:MonsterYell("I must bid you... farewell.")
	unit:PlaySoundToSet(10546)
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
	end
	local args = self[tostring(unit)]
	args.fireball = args.fireball -1
	args.frostbolt = args.frostbolt -1
	args.blink = args.blink -1
	args.beacon_spawn = args.beacon_spawn - 1
	if(args.beacon_spawn <= 0) then
		unit:FullCastSpell(32371)
		local say_chance = math.random()
		if(say_chance) then
			unit:MonsterYell("I have such fascinating things to show you.")
			unit:PlaySoundToSet(10540)
		end
		if(args.isHeroic) then
			args.beacon_spawn = math.random(5,8)
		else
			args.beacon_spawn = 10
		end
	elseif(args.blink <=0) then
		unit:FullCastSpell(32365)
		unit:FullCastSpell(33546)
		args.blink = math.random(25,35)
	elseif(args.frostbolt <= 0) then
		local target = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(32370,target)
		args.frostbolt = math.random(7,15)
	elseif(args.fireball <= 0) then
		local target = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(20420,target)
		args.fireball = math.random(7,15)
	end
end

RegisterUnitEvent(18344, 1, OnCombat)
RegisterUnitEvent(18344, 2, OnWipe)
RegisterUnitEvent(18344, 3, OnTargetKill)
RegisterUnitEvent(18344, 4, OnDeath)
RegisterUnitEvent(18344, 21, AIUpdate)

--[[ BEACON AI ]]--
function BeaconOnSpawn(unit)
	local creator = unit:GetLocalCreature(18344)
	unit:SetCreator(creator)
	if(creator:IsInCombat() == false) then return end
	local target = unit:GetRandomEnemy()
	unit:AttackReaction(target,1,0)
end

function BeaconOnCombat(unit)
	local creator = unit:GetCreator()
	unit:RegisterEvent(ArcaneBolt,2500,0)
	if(self[tostring(creator)].isHeroic) then
		unit:RegisterEvent(SummonApprentice,10000,1)
	else
		unit:RegisterEvent(SummonApprentice,20000,1)
	end
end

function BeaconOnWipe(unit)
	unit:RemoveEvents()
end

function ArcaneBolt(unit)
	local target = unit:GetRandomEnemy()
	unit:FullCastSpellOnTarget(15254,target)
end

function SummonApprentice(unit)
	local prince = unit:GetCreator()
	prince:FullCastSpell(32372)
	unit:WipeThreatList()
	unit:Despawn(0,0)
end

RegisterUnitEvent(18431, 18, BeaconOnSpawn)
RegisterUnitEvent(18431, 1, BeaconOnCombat)
RegisterUnitEvent(18431, 2, BeaconOnWipe)

function ApprenticeOnSpawn(unit)
	local creator = unit:GetLocalCreature(18344)
	local target = creator:GetNextTarget()
	unit:AttackReaction(target,1,0)
end

function ApprenticeOnCombat(unit)
	unit:RegisterEvent(ApprenticeSpells,5000,0)
end

function ApprenticeOnWipe(unit)
	unit:RemoveEvents()
end

function ApprenticeSpells(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		local creator = unit:GetCreator()
		if(creator) then
			unit:SetUnitToFollow(creator,5,(45/180)*math.pi)
		end
	end
	local spelltocast = math.random()
	local target = unit:GetRandomEnemy()
	if(spelltocast) then
		unit:FullCastSpellOnTarget(32369,target)
	else
		unit:FullCastSpellOnTarget(32370,target)
	end
end

RegisterUnitEvent(18430, 18, ApprenticeOnSpawn)
RegisterUnitEvent(18430, 1, ApprenticeOnCombat)
RegisterUnitEvent(18430, 2, ApprenticeOnWipe)
		
	