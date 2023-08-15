local mod = getfenv(1)
assert(mod)
--module(mod._NAME..".DARKWEAVER_SYTH",package.seeall)
local self = getfenv(1)

function OnCombat(unit,_,mTarget)
	self[tostring(unit)] = {
		shock = math.random(2,6),
		chain = math.random(10,15),
		summon_phase = 1,
		isHeroic = (mTarget:IsPlayer() and mTarget:IsHeroic() )
	}
	unit:RegisterAIUpdateEvent(1000)
	local say_text = math.random(1,3)
	if(say_text == 1) then
		unit:MonsterYell("Hrrmm.. Time to.. hrrm.. make my move.")
		unit:PlaySoundToSet(10503)
	elseif(say_text == 2) then
		unit:MonsterYell("Nice pets..hrm.. Yes!")
		unit:PlaySoundToSet(10504)
	else
		unit:MonsterYell("Nice pets have.. weapons. No so...nice.")
		unit:PlaySoundToSet(10505)
	end
end

function OnWipe(unit)
	unit:RemoveAIUpdateEvent()
	self[tostring(unit)] = nil
end

function OnTargetKill(unit)
	local say_text = math.random()
	if(say_text) then
		unit:MonsterYell("Death.. meeting life is..")
		unit:PlaySoundToSet(10506)
	else
		unit:MonsterYell("Uhn... Be free..")
		unit:PlaySoundToSet(10507)
	end
end

function OnDeath(unit)
	unit:MonsterYell("No more life... hrm. No more pain.")
	unit:PlaySoundToSet(10508)
end
function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		return
	end
	local vars = self[tostring(unit)]
	vars.shock = vars.shock -1
	vars.chain = vars.chain - 1
	
	if(vars.chain <= 0) then
		local target = unit:GetRandomEnemy()
		if(vars.isHeroic) then
			unit:FullCastSpellOnTarget(15659,target)
		else
			unit:FullCastSpellOnTarget(15305,target)
		end
		vars.chain = math.random(10,20)
	elseif(vars.shock <=0) then
		local target = unit:GetRandomEnemy()
		local spelltocast = math.random(4)
		if(spelltocast == 1) then
			if(vars.isHeroic) then
				unit:FullCastSpellOnTarget(38135,target)
			else
				unit:FullCastSpellOnTarget(33534,target)
			end
		elseif(spelltocast == 2) then
			if(vars.isHeroic) then
				unit:FullCastSpellOnTarget(15616,target)
			else
				unit:FullCastSpellOnTarget(15039,target)
			end
		elseif(spelltocast == 3) then
			if(vars.isHeroic) then
				unit:FullCastSpellOnTarget(21401,target)
			else
				unit:FullCastSpellOnTarget(12548,target)
			end
		else
			if(vars.isHeroic) then
				unit:FullCastSpellOnTarget(38136,target)
			else
				unit:FullCastSpellOnTarget(33620,target)
			end
		end
		vars.shock = math.random(5,15)
	else
		local hp = unit:GetHealthPct()
		if( (hp <= 90 and vars.summon_phase == 1) 
		or (hp <= 55 and vars.summon_phase == 2)
		or (hp <= 10 and vars.summon_phase == 3) ) then
			local summon_spells = {33538,33537,33539,33540}
			local angle = 0
			for i = 1,4 do
				local radius = math.random(5,10)
				local x = unit:GetX()+math.cos(math.rad(angle))*radius
				local y = unit:GetY()+math.sin(math.rad(angle))*radius
				unit:CastSpellAoF(x,y,unit:GetZ(),summon_spells[i])
				angle = angle+90
			end
			unit:MonsterYell("I have pets of my own!")
			unit:PlaySoundToSet(10502)
			vars.summon_phase = vars.summon_phase + 1
		end
	end
end

RegisterUnitEvent(18472, 1, OnCombat)
RegisterUnitEvent(18472, 2, OnWipe)
RegisterUnitEvent(18472, 3, OnTargetKill)
RegisterUnitEvent(18472, 4, OnDeath)
RegisterUnitEvent(18472, 21, AIUpdate)

function Elemental_Cast(unit,spell)
	unit:FullCastSpell(spell)
end

function Elemental_OnSpawn(unit)
	 local entry = unit:GetEntry()
	 if(entry == 19205) then
		unit:RegisterLuaEvent(Elemental_Cast,math.random(7,15)*1000,0,38138)
	elseif(entry == 19203) then
		unit:RegisterLuaEvent(Elemental_Cast,math.random(7,15)*1000,0,38141)
	elseif(entry == 19204) then
		unit:RegisterLuaEvent(Elemental_Cast,math.random(7,15)*1000,0,38142)
	else
		unit:RegisterLuaEvent(Elemental_Cast,math.random(7,15)*1000,0,38143)
	end
	local creator = unit:GetCreator()
	if(creator) then
		unit:AttackReaction(creator:GetNextTarget(),1,0)
	else
		unit:AttackReaction(unit:GetRandomEnemy(),1,0)
	end
end

function Elemental_OnWipe(unit)
	unit:RemoveLuaEvents()
	unit:Despawn(1000,0)
end

RegisterUnitEvent(19205, 18, Elemental_OnSpawn)
RegisterUnitEvent(19205, 2, Elemental_OnWipe)
RegisterUnitEvent(19203, 18, Elemental_OnSpawn)
RegisterUnitEvent(19203, 2, Elemental_OnWipe)
RegisterUnitEvent(19204, 18, Elemental_OnSpawn)
RegisterUnitEvent(19204, 2, Elemental_OnWipe)
RegisterUnitEvent(19206, 18, Elemental_OnSpawn)
RegisterUnitEvent(19206, 2, Elemental_OnWipe)
