local mod = getfenv(1)
assert(mod)
--module(mod._NAME..".SHIRRAK_THE_DEAD_WATCHER",package.seeall)
local self = getfenv(1)
WorldDBQuery("DELETE FROM ai_agents WHERE entry = 18371;")

function OnCombat(unit,_,mAggro)
	self[tostring(unit)] = {
		bite = math.random(8,12),
		inhibit = math.random(2,5),
		attract = math.random(20,30),
		f_fire = 2,
		isHeroic = (mAggro:IsPlayer() and mAggro:IsHeroic() )
	}
	unit:RegisterAIUpdateEvent(1000)
end

function OnWipe(unit)
	unit:RemoveAIUpdateEvent()
	unit:RemoveEvents()
	self[tostring(unit)] = nil
	unit:DisableCombat(false)
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
		return
	end
	local vars = self[tostring(unit)]
	vars.bite = vars.bite - 1
	vars.inhibit = vars.inhibit - 1
	vars.attract = vars.attract - 1
	vars.f_fire = vars.f_fire - 1
	if(vars.f_fire <= 0) then
		FocusFire(unit,1)
		vars.f_fire = math.random(20,25) +3
	elseif(vars.inhibit <= 0) then
		print("Inhibit")
		unit:FullCastSpell(32264)
		vars.inhibit = math.random(2,5)
	elseif(vars.bite <= 0) then
		print("Bite")
		if(vars.isHeroic) then
			unit:FullCastSpell(39382)
		else
			unit:FullCastSpell(36383)
		end
		vars.bite = math.random(8,12)
	elseif(vars.attract <= 0) then
		print("Attract")
		unit:FullCastSpell(32265)
		vars.bite = 0 -- have him bite asap.
		vars.attract = math.random(20,30)
	end
end

function FocusFire(unit,spell_phase)
	-- HACKS!
	if(spell_phase == 1) then
		local target = unit:GetRandomEnemy()
		unit:BossRaidEmote(unit:GetName().." focuses his energy on "..target:GetName() )
		unit:DisableCombat(true)
		unit:ChannelSpell(43515,target)
		unit:SetChannelTarget(target)
		unit:RegisterLuaEvent(FocusFire,4000,1,2)
	elseif(spell_phase == 2) then
		local target = unit:GetChannelTarget()
		unit:SetChannelTarget(nil)
		local focus = target:SpawnLocalCreature(18374,unit:GetFaction(),0)
		focus:SetUnselectable()
		focus:SetUnattackable()
		focus:DisableCombat(true)
		focus:SetModel(17200)
		unit:FullCastSpellOnTarget(32300,focus)
		unit:DisableCombat(false)
		unit:SetCreator(focus)
		unit:RegisterLuaEvent(FocusFire,1500,1,3)
	elseif(spell_phase == 3) then
		local focus = unit:GetCreator()
		unit:SetCreator(nil)
		if(self[tostring(unit)].isHeroic) then
			for i = 1,math.random(3,6) do
				focus:EventCastSpell(focus,20203,i*500,1)
			end
		else
			for i = 1,math.random(3,6) do
				focus:EventCastSpell(focus,23462,i*500,1)
			end
		end
		focus:Despawn(3500,0)
	end
end

function FocusFire_Explode(unit,spell)
	unit:FullCastSpell(spell)
end

RegisterUnitEvent(18371, 1, OnCombat)
RegisterUnitEvent(18371, 2, OnWipe)
RegisterUnitEvent(18371, 21, AIUpdate)