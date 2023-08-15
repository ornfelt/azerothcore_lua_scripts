local mod = getfenv(1)
assert(mod)
--module(mod._NAME..".EXARCH_MALADAAR",package.seeall)
local self = getfenv(1)

function OnCombat(unit)
	self[tostring(unit)] = {
		ribbon = math.random(2,5),
		scream = math.random(5,10),
		avatar = true,
		ssteal = 1
	}
	local say_text = math.random(3)
	if(say_text == 1) then
		unit:MonsterYell("You will pay with your life!")
		unit:PlaySoundToSet(10513)
	elseif(say_text == 2) then
		unit:MonsterYell("There's no turning back now!")
		unit:PlaySoundToSet(10514)
	else
		unit:MonsterYell("Serve your penitence!")
		unit:PlaySoundToSet(10515)
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
		unit:MonsterYell("These walls will be your doom.")
		unit:PlaySoundToSet(10516)
	else
		unit:MonsterYell("Now you will stay for eternity")
		unit:PlaySoundToSet(10517)
	end
end

function OnDeath(unit)
	unit:MonsterYell("This is... where I belong.")
	unit:PlaySoundToSet(10518)
	unit:RegisterLuaEvent(SpawnDore,10000,1)
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
	end
	local vars = self[tostring(unit)]
	vars.ribbon = vars.ribbon -1
	vars.scream = vars.scream - 1
	vars.ssteal = vars.ssteal - 1
	if(vars.ribbon <= 0) then
		local target = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(32422,target)
		vars.ribbon = math.random(10,20)
	elseif(vars.scream <= 0) then
		unit:FullCastSpell(32421)
		vars.scream = math.random(20,30)
		local second_hated = unit:GetSecondHated()
		if(second_hated) then
			unit:SetNextTarget(unit:GetSecondHated())
		end
	elseif(vars.ssteal <= 0) then
		local say_text = math.random(3)
		if(say_text == 1) then
			unit:MonsterYell("Rise, my fallen brothers. Take form and fight!")
			unit:PlaySoundToSet(10512)
		elseif(say_text == 2) then
			unit:MonsterYell("Stare into the darkness of your soul.")
			unit:PlaySoundToSet(10511)
		else
			unit:MonsterYell("Let your mind be clouded.")
			unit:PlaySoundToSet(10510)
		end
		local target = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(32346,target)
		local soul = unit:SpawnLocalCreature(18441,unit:GetFaction(),0)
		soul:SetCreator(target)
		vars.ssteal = math.random(20,30)
	end
	
	if(vars.avatar and unit:GetHealthPct() <= 25) then
		unit:FullCastSpell(32424)
		vars.avatar = false
	end
end

function SpawnDore(unit)
	local dore = unit:SpawnCreature(19412,27.188200,-388.435730,26.584007,6.282297,0,0)
	dore:FullCastSpell(7765)
end

RegisterUnitEvent(18373, 1, OnCombat)
RegisterUnitEvent(18373, 2, OnWipe)
RegisterUnitEvent(18373, 3, OnTargetKill)
RegisterUnitEvent(18373, 4, OnDeath)
RegisterUnitEvent(18373, 21, AIUpdate)

function StolenSoulOnCombat(unit)
	unit:FullCastSpell(32395)
	local creator = unit:GetCreator()
	local class = creator:GetPlayerClass()
	if(class == "Warrior") then
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(15,20)*1000,0,37335,0x2)
	elseif(class == "Paladin") then
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(25,30)*1000,0,37369,0x2)
	elseif(class == "Hunter") then
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(15,20)*1000,0,37368,0x1)
	elseif(class == "Druid") then
		unit:RegisterLuaEvent(StolenSoul_Cast,1000,0,37368,0x3)
		unit:RegisterLuaEvent(StolenSoulAI_Runner,5000,0)
	elseif(class == "Warlock") then
		unit:RegisterLuaEvent(StolenSoul_Cast,5000,0,37334,0x3)
	elseif(class == "Mage") then
		unit:RegisterLuaEvent(StolenSoul_Cast,3500,0,37329,0x3)
	elseif(class == "Rogue") then
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(3,5)*1000,0,37331,0x2)
	elseif(class == "Shaman") then
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(5,8)*1000,0,37322,0x3)
	elseif(class == "Priest") then
		unit:RegisterLuaEvent(StolenSoul_Cast,3500,0,37330,0x3)
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(20,30)*1000,0,22884,0x1)
	elseif(class == "Death Knight") then
		unit:RegisterLuaEvent(StolenSoul_Cast,math.random(10,15)*1000,0,58839,0x2)
	end
end

function StolenSoulOnWipe(unit)
	unit:StopMovement(1000)
	unit:RemoveLuaEvents()
	unit:FullCastSpell(33326)
	unit:Despawn(1000,0)
end

function StolenSoul_Cast(unit,spell,cast_flags)
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		return
	end
	if(cast_flags == 0x1) then
		unit:FullCastSpell(spell)
	elseif(cast_flags == 0x2) then
		unit:FullCastSpellOnTarget(spell,unit:GetMainTank())
	elseif(cast_flags == 0x3) then
		unit:FullCastSpellOnTarget(spell,unit:GetRandomEnemy())
	end
end

-- runner just for druids xD
function StolenSoulAI_Runner(unit)
	local plr = unit:GetRandomEnemy()
	if(math.random() ) then
		local x,y = plr:GetX()+math.cos(math.pi)*5,plr:GetY()+math.sin(math.pi)*5
		unit:MoveTo(x,y,unit:GetZ(),unit:GetO())
	else
		-- random move around
		local angle = math.random(0,360)
		local x,y = unit:GetX()+math.cos(angle)*10,unit:GetY()+math.sin(angle)*10
		unit:MoveTo(x,y,unit:GetZ(),unit:GetO())
	end
end

RegisterUnitEvent(18441, 1, StolenSoulOnCombat)
RegisterUnitEvent(18441, 2, StolenSoulOnWipe)

function AvatarOnSpawn(unit)
	local creator = unit:GetLocalCreature(18373)
	if(creator ~= nil) then
		unit:AttackReaciton(creator:GetNextTarget(),1,0)
	else
		unit:AttackReaction(unit:GetClosestEnemy(),1,0)
	end
	unit:RegisterLuaEvent(StolenSoul_Cast,math.random(15,20)*1000,0,16856,0x2)
	unit:RegisterLuaEvent(StolenSoul_Cast,math.random(10,15)*1000,0,16145,0x2)
end
function AvatarOnWipe(unit)
	unit:RemoveLuaEvents()
end

RegisterUnitEvent(18478, 18, AvatarOnSpawn)
RegisterUnitEvent(18478, 2, AvatarOnWipe)