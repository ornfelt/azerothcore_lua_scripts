local mod = getfenv(1)
if(type(mod) ~= "table") then 
	error("Missing Shadow Labyrinth module!") 
end
--module(mod._NAME..".BLACKHEART_THE_INCITER",package.seeall)
local self = getfenv(1)

function OnSpawn(unit)
	local say  = math.random(1,3)
	if(say == 1) then
		unit:PlaySoundToSet(10482)
		unit:MonsterYell("All flesh must burn!")
	elseif(say == 2) then
		unit:MonsterYell("All creation must be unmade!")
		unit:PlaySoundToSet(10483)
	elseif(say == 3) then
		unit:PlaySoundToSet(10484)
		unit:MonsterYell("Power will be yours!")
	elseif(say == 4) then
		unit:PlaySoundToSet(10492)
		unit:MonsterYell("Be ready for Dark One's return.")
	elseif(say == 5) then
		unit:MonsterYell("So we have place new universe!")
		unit:PlaySoundToSet(10493)
	else
		unit:MonsterYell("Dark One... promise...")
		unit:PlaySoundToSet(10494)
	end
end

function OnCombat(unit)
	self[tostring(unit)] = {
		stomp = math.random(15,30),
		charge = math.random(15,30),
		incite = 20
	}
	local say = math.random(1,6)
	if(say == 1) then
		unit:PlaySoundToSet(10486)
		unit:MonsterYell("You'll be sorry!")
	elseif(say == 2) then
		unit:PlaySoundToSet(10487)
		unit:MonsterYell("Time for fun!")
	elseif(say == 3) then
		unit:PlaySoundToSet(10488)
		unit:MonsterYell("I see dead people!")
	elseif(say == 4) then
		unit:PlaySoundToSet(10497)
		unit:MonsterYell("Time to kill!")
	else
		unit:PlaySoundToSet(10498)
		unit:MonsterYell("YOU be dead people.")
	end
	unit:RegisterAIUpdateEvent(1000)
	local allies = unit:GetInRangeFriends()
	for _,v in pairs(allies) do
		if(unit:GetDistanceYards(v) <= 100) then
			local target = v:GetRandomEnemy()
			v:AttackReaction(target,1,0)
		end
	end
end

function OnWipe(unit)
	self[tostring(unit)] = nil
	unit:RemoveAIUpdateEvent(1000)
	unit:RemoveEvents()
end

function OnKill(unit)
	local say = math.random(1,4)
	if(say == 1) then
		unit:PlaySoundToSet(10489)
		unit:MonsterYell("NO coming back for you!")
	elseif(say == 2) then
		unit:PlaySoundToSet(10490)
		unit:MonsterYell("Nice try!")
	elseif(say == 3) then
		unit:PlaySoundToSet(10499)
		unit:MonsterYell("Now you gone for good!")
	else
		unit:PlaySoundToSet(10500)
		unit:MonsterYell("You fail!")
	end
end

function OnDeath(unit)
	local say = math.random(0,1)
	if(say) then
		unit:PlaySoundToSet(10491)
		unit:MonsterYell("This no... good..")
	else
		unit:PlaySoundToSet(10501)
		unit:MonsterYell("<screaming>")
	end
	local gate = unit:GetGameObjectNearestCoords(-375.146210,-39.748650,12.688822,183296)
	if(gate) then
		gate:Open()
	end
end

function InciteEvent(unit,phase)
	if(phase == 1) then
		unit:FullCastSpell(33676)
		unit:RegisterLuaEvent(InciteEvent,3000,0,2)
	elseif(phase == 2) then
		local target = unit:GetRandomEnemy()
		unit:SetNextTarget(target)
		unit:Emote(LCF.EMOTE_ONESHOT_LAUGH,0)
	else
		unit:RemoveEvents()
		unit:DisableMelee(false)
		local enemy = unit:GetRandomEnemy()
		unit:AttackReaction(enemy,1,0)
		unit:RegisterAIUpdateEvent(1000)
	end
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		return
	end
	local vars = self[tostring(unit)]
	vars.stomp = vars.stomp - 1
	vars.charge = vars.charge - 1
	vars.incite = vars.incite - 1
	if(vars.incite <= 0) then
		vars.incite = 40
		unit:RemoveAIUpdateEvent()
		unit:DisableMelee(true)
		unit:PlaySoundToSet(10487)
		unit:MonsterYell("Time for fun!")
		unit:RegisterLuaEvent(InciteEvent,3000,1,1)
		unit:RegisterLuaEvent(InciteEvent,15000,1,3)
	elseif(vars.stomp <= 0) then
		unit:FullCastSpell(33707)
		vars.stomp = math.random(20,30)
		vars.charge = 1
	elseif(vars.charge <= 0) then
		local target = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(33709,target)
		vars.charge = math.random(20,30)
	end
end

RegisterUnitEvent(18667, 18, OnSpawn)
RegisterUnitEvent(18667, 1, OnCombat)
RegisterUnitEvent(18667, 2, OnWipe)
RegisterUnitEvent(18667, 3, OnKill)
RegisterUnitEvent(18667, 4, OnDeath)
RegisterUnitEvent(18667, 21, AIUpdate)

function InciteChaosEffect(_,spell)
	local caster = spell:GetCaster()
	local enemies = caster:GetInRangeEnemies()
	for _,v in pairs(enemies) do
		caster:FullCastSpellOnTarget(33684,v)
		if(v:IsPlayer() ) then
			v:UseAI(true)
		end
		v:FlagFFA(true)
		v:RegisterLuaEvent(InciteChaosEnd,15000,1)
	end
end

function InciteChaosEnd(victim)
	if(victim:IsPlayer() ) then
		victim:UseAI(false)
	end
	victim:FlagFFA(false)
end

RegisterDummySpell(33676, InciteChaosEffect)
--todo script player behavior under mc.	