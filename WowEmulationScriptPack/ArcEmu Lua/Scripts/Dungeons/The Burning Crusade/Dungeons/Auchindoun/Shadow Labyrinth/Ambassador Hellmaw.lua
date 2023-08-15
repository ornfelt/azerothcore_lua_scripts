local mod = getfenv(1)
if(type(mod) ~= "table") then 
	error("Missing Shadow Labyrinth module!") 
end
--module(mod._NAME..".AMBASSADOR_HELLMAW",package.seeall)
local self = getfenv(1)

function OnSpawn(unit)
	local cage = unit:GetGameObjectNearestCoords(-63.400253,42.193386,0.195916,182943)
	if(cage) then
		cage:Open()
	end
	local o = unit:GetO()
	unit:CreateCustomWaypoint(1,unit:GetX()+math.cos(o)*10,unit:GetY()+math.sin(o)*10,unit:GetZ(),unit:GetO(),0,0x100)
	unit:MoveToWaypoint(1)
	self[tostring(unit)] = { }
	unit:PlaySoundToSet(10473)
	unit:MonsterYell("Infidels have invaded the sanctuary! Sniveling pests... You have yet to learn the true meaning of agony!")
end

function OnReachWp(unit,_,wp,foward)
	if(wp == 1) then
		local vars = self[tostring(unit)]
		vars.ritualists = {}
		local rad = unit:GetO()-(math.pi/2)
		-- spawn ritualists, one to the left, right and center all 7 yards away from hellmaw.
		for i = 1,3 do
			table.insert(vars.ritualists,unit:SpawnCreature(18794,unit:GetX()+math.cos(rad)*10,unit:GetY()+math.sin(rad)*10,unit:GetZ(),unit:GetO(),0,0))
			rad = rad+(math.pi/2)
		end
		for _,v in pairs(vars.ritualists) do
			v:SetCreator(unit)
			v:ChannelSpell(38469,unit)
		end
		vars.banished = true
		unit:FullCastSpell(32567)
		unit:SetUnattackable()
		unit:DisableCombat(true)
		unit:RegisterAIUpdateEvent(1000)
	elseif(wp == 10) then
		unit:DeleteWaypoints()
		unit:CreateCustomWaypoint(2,-153.943848,40.034931,6.970896,0.823673,0,0x0)
		unit:CreateCustomWaypoint(3,-138.720352,58.846767,4.951912,0.890432,0,0x0)
		unit:CreateCustomWaypoint(4,-111.456299,62.348598,3.447638,0.065764,0,0x0)
		unit:CreateCustomWaypoint(5,-87.320633,60.646305,2.967573,6.176163,0,0x0)
		unit:CreateCustomWaypoint(6,-69.841942,47.791355,0.964065,5.626387,0,0x0)
		unit:SetMovementType(5)
	end
end

function OnCombat(unit)
	local say = math.random(1,3)
	if(say == 1) then
		unit:PlaySoundToSet(10475)
		unit:MonsterYell("Pathetic mortals! You will pay dearly!")
	elseif(say == 2) then
		unit:PlaySoundToSet(10476)
		unit:MonsterYell("I will break you!")
	else
		unit:MonsterYell("Finally, something to relieve the tedium.")
		unit:PlaySoundToSet(10477)
	end
	local ref = self[tostring(unit)]
	ref.fear = 25
	ref.acid = math.random(2,10)
	ref.enrage = 180 -- 3 min enrage
	unit:RegisterAIUpdateEvent(1000)
end

function OnWipe(unit)
	self[tostring(unit)] = nil
	unit:RemoveAIUpdateEvent()
	if(unit:IsAlive() ) then
		unit:Despawn(1000,1)
	end
	unit:DeleteWaypoints()
end

function OnKill(unit)
	local say = math.random(0,1)
	if(say) then
		unit:MonsterYell("Do you fear death?")
		unit:PlaySoundToSet(10478)
	else
		unit:MonsterYell("This is the part I enjoy most...")
		unit:PlaySoundToSet(10479)
	end
end

function OnDeath(unit)
	unit:PlaySoundToSet(10480)
	unit:MonsterYell("Do not...grow...overconfident, mortal.")
end

function AIUpdate(unit)
	local vars = self[tostring(unit)]
	if(vars.banished) then
		if(#vars.ritualists == 0) then
			unit:RemoveAllAuras()
			unit:SetAttackable()
			unit:DisableCombat(false)
			local o = unit:GetO()
			unit:CreateCustomWaypoint(2,unit:GetX()+math.cos(o)*15,unit:GetY()+math.sin(o)*15,unit:GetZ(),unit:GetO(),0,0x100)
			unit:CreateCustomWaypoint(3,-139.871170,-20.563589,8.072030,4.633859,0,0x100)
			unit:CreateCustomWaypoint(4,-154.723740,-37.530266,8.072030,4.914246,0,0x100)
			unit:CreateCustomWaypoint(5,-143.254257,-65.023735,8.072030,4.207390,0,0x100)
			unit:CreateCustomWaypoint(6,-155.118866,-87.083763,8.072562,4.662920,0,0x100)
			unit:CreateCustomWaypoint(7,-171.746841,-58.118092,8.072562,2.082886,0,0x100)
			unit:CreateCustomWaypoint(8,-173.280182,-23.954927,8.072562,1.595939,0,0x100)
			unit:CreateCustomWaypoint(9,-156.422501,-3.315071,8.072562,1.493837,0,0x100)
			unit:CreateCustomWaypoint(10,-156.080643,20.882515,8.072562,1.556669,0,0x100)
			unit:SetMovementType(11)
			vars.banished = false
			unit:RemoveAIUpdateEvent()
			unit:DisableCombat(false)
		end
		return
	end
	vars.fear = vars.fear - 1
	vars.acid = vars.acid - 1
	if(vars.enrage ~= nil) then
		vars.enrage = vars.enrage - 1
	end
	if(vars.fear <= 0) then
		unit:FullCastSpell(33547)
		vars.fear = 25
	elseif(vars.acid <= 0) then
		unit:FullCastSpell(33551)
		vars.acid = math.random(10,20)
	elseif(vars.enrage ~= nil and vars.enrage <=0) then
		unit:FullCastSpell(46587)
		vars.enrage = nil
	end
end

RegisterUnitEvent(18731, 18, OnSpawn)
RegisterUnitEvent(18731, 1, OnCombat)
RegisterUnitEvent(18731, 2, OnWipe)
RegisterUnitEvent(18731, 3, OnKill)
RegisterUnitEvent(18731, 4, OnDeath)
RegisterUnitEvent(18731, 21, AIUpdate)
RegisterUnitEvent(18731, 19, OnReachWp)

function RitualistOnCombat(unit,_,mAggro)
	self[tostring(unit)] = {
		addle = math.random(15,30),
		missile = math.random(2,10),
		blast = math.random(5,15),
		buffet = math.random(15,30),
		nova = math.random(15,30),
		bolt = math.random(5,15),
		dispel_cd = 0,
		isHeroic = (mAggro:IsPlayer() and mAggro:IsHeroic() )
	}
	unit:RegisterAIUpdateEvent(1000)
	unit:StopChannel()
end

function RitualistOnWipe(unit)
	self[tostring(unit)] = nil
	unit:RemoveAIUpdateEvent()
end

function RitualistOnDeath(unit)
	local hellmaw = unit:GetCreator()
	if(hellmaw) then
		local ritualists = self[tostring(hellmaw)].ritualists
		for k,v in pairs(ritualists) do
			if(tostring(unit) == tostring(v) ) then
				print("Found self in table")
				table.remove(ritualists,k)
				break
			end
		end
	end
end

function RitualistAIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then 
		unit:WipeThreatList()
		return
	end
	local vars = self[tostring(unit)]
	vars.addle = vars.addle - 1
	vars.missile = vars.missile - 1
	vars.blast = vars.blast - 1
	vars.buffet = vars.buffet - 1
	vars.nova = vars.nova - 1
	vars.bolt = vars.bolt - 1
	if(vars.dispel_cd > 0 ) then
		vars.dispel_cd = vars.dispel_cd - 1
	end
	local target = unit:GetRandomEnemy()
	if(vars.addle <= 0) then
		if(unit:GetDistanceYards(target) > 20) then
			target = unit:GetClosestEnemy()
		end
		unit:FullCastSpellOnTarget(33487,target)
		vars.addle = math.random(20,30)
	elseif(vars.missile <= 0) then
		if(vars.isHeroic) then
			unit:FullCastSpellOnTarget(38364,target)
		else
			unit:FullCastSpellOnTarget(33833,target)
		end
		vars.missle = math.random(10,15)
	elseif(vars.blast <= 0) then
		if(vars.isHeroic) then
			unit:FullCastSpellOnTarget(20795,target)
		else
			unit:FullCastSpellOnTarget(14145,target)
		end
		vars.blast = math.random(10,15)
	elseif(vars.buffet <= 0) then
		unit:FullCastSpellOnTarget(9574,target)
		vars.buffet = math.random(15,30)
	elseif(vars.nova <= 0) then
		if(vars.isHeroic) then
			unit:FullCastSpell(15532)
		else
			unit:FullCastSpell(15063)
		end
		vars.nova = math.random(15,30)
	elseif(vars.bolt <= 0) then
		if(vars.isHeroic) then
			unit:FullCastSpellOnTarget(15497,target)
		else
			unit:FullCastSpellOnTarget(12675,target)
		end
		vars.bolt = math.random(5,10)
	elseif(vars.dispel_cd <= 0 and unit:HasNegativeAura() ) then
		unit:FullCastSpell(17201)
		vars.dispel_cd = math.random(10,20)
	end
end

RegisterUnitEvent(18794, 1, RitualistOnCombat)
RegisterUnitEvent(18794, 2, RitualistOnWipe)
RegisterUnitEvent(18794, 21, RitualistAIUpdate)
RegisterUnitEvent(18794, 4, RitualistOnDeath)