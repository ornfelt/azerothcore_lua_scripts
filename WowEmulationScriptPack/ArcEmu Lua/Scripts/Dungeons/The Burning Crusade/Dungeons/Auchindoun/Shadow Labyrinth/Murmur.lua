local mod = getfenv(1)
if(type(mod) ~= "table") then 
	error("Missing Shadow Labyrinth module!") 
end
--module(mod._NAME..".MURMUR",package.seeall)
local self = getfenv(1)

function OnSpawn(unit)
	unit:SetHealthPct(40)
	unit:RegisterEvent(Murmur_Wrath,5000,1)
end

function OnCombat(unit,_,mAggro)
	self[tostring(unit)] = {
		boom = math.random(30,40),
		touch = math.random(20,30),
		shockwave = math.random(15,30),
		sonic = math.random(2,5),
		resonance = 5,
		touched_plr = nil,
		storm = math.random(15,20),
		isHeroic = (mAggro:IsPlayer() and mAggro:IsHeroic() )
	}
	unit:RegisterAIUpdateEvent(1000)
	unit:Root()
	if(mAggro:IsHeroic() ) then
		print("Is heroic")
	else
		print("Not heroic")
	end
end

function OnWipe(unit)
	self[tostring(unit)] = nil
	unit:RemoveAIUpdateEvent()
	if(unit:IsAlive() ) then
		unit:Despawn(100,10000)
	end
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		return
	end
	local vars = self[tostring(unit)]
	vars.boom = vars.boom - 1
	vars.touch = vars.touch - 1
	vars.shockwave = vars.shockwave - 1
	vars.sonic = vars.sonic - 1
	vars.resonance = vars.resonance - 1
	--vars.storm = vars.storm - 1
	if(vars.boom <= 0) then
		unit:FullCastSpell(33923)
		unit:BossRaidEmote(unit:GetName().." draws energy from the air!")
		vars.boom = math.random(30,40)
	elseif(vars.shockwave <= 0) then
		if(vars.isHeroic and vars.touched_plr ~= nil) then
			local x,y,z,o = vars.touched_plr:GetLocation()
			local dummy = unit:SpawnCreature(18654,x,y,z,o,unit:GetFaction(),0)
			dummy:SetUnselectable()
			local enemies = unit:GetInRangeEnemies()
			for _,v in pairs(enemies) do
				dummy:FullCastSpellOnTarget(33689,v)
			end
			dummy:Despawn(1,0)
		elseif(vars.isHeroic == false) then
			local target = unit:GetRandomEnemy()
			unit:FullCastSpellOnTarget(33689,target)
			unit:FullCastSpell(33686)
		end
		vars.shockwave = math.random(15,30)
	elseif(vars.isHeroic and vars.sonic <= 0) then
		local target = unit:GetRandomEnemy()
		unit:FullCastSpellOnTarget(38797,target)
		vars.sonic = math.random(10,15)
	--elseif(vars.isHeroic and vars.storm <= 0) then
	elseif(vars.touch <= 0) then
		local target = unit:GetRandomEnemy()
		if(vars.isHeroic) then
			unit:FullCastSpellOnTarget(38794,target)
			target:RegisterLuaEvent(Murmur_Touch,7000,1)
		else
			unit:FullCastSpellOnTarget(33711,target)
			target:RegisterLuaEvent(Murmur_Touch,14000,1)
		end
		vars.touched_plr = target
		vars.touch = math.random(15,30)
	end
	local tank = unit:GetMainTank()
	if(unit:GetDistanceYards(tank) > 25 and vars.resonance <= 0) then
		unit:FullCastSpell(33657)
		vars.resonance = 5
	end
end

function Murmur_Touch(victim)
	victim:FullCastSpell(46402)
end

function Murmur_Wrath(unit)
	local units = unit:GetInRangeUnits()
	for _,v in pairs(units) do
		if(unit:GetDistanceYards(v) <= 100 and v:IsAlive() ) then
			unit:FullCastSpellOnTarget(33331,v)
			unit:Kill(v)
		end
	end
end

function SonicBoom_Dummy(_,spell)
	local caster = spell:GetCaster()
	local enemies = caster:GetInRangeEnemies()
	for _,v in pairs(enemies) do
		if(caster:GetDistanceYards(v) <= 34) then
			local pct = math.random(90,95)
			local hp = v:GetHealth() * pct / 100
			caster:DealDamage(v,hp,33666)
		end
	end
	caster:FullCastSpell(33666)
end

RegisterUnitEvent(18708, 18, OnSpawn)
RegisterUnitEvent(18708, 1, OnCombat)
RegisterUnitEvent(18708, 2, OnWipe)
RegisterUnitEvent(18708, 21, AIUpdate)
RegisterDummySpell(33923, SonicBoom_Dummy)