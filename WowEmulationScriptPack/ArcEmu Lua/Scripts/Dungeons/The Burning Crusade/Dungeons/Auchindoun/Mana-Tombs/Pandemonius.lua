local mod = getfenv(1)
--module(mod._NAME..".PANDEMONIUS",package.seeall)
local self = getfenv(1)
--Delete ai agent conflicts
WorldDBQuery("DELETE FROM ai_agents WHERE `entry` = \"18341\";")

function OnCombat(unit,_,mAggro)
	self[tostring(unit)] = {
		void_blast = math.random(5,10),
		dark_shell = math.random(20,25),
		isHeroic = (mAggro:IsPlayer() and mAggro:IsHeroic() )
	}
	local allies = unit:GetInRangeFriends()
	for _,v in pairs(allies) do
		if(v:GetDistanceYards(unit) < 50 and string.find(v:GetName(),"Ethereal") ~= nil) then
			v:AttackReaction(mAggro,1,0)
		end
	end
	local say_text = math.random(3)
	if(say_text == 1) then
		unit:PlaySoundToSet(10561)
		unit:MonsterYell("I will feed on your soul.")
	elseif(say_text == 2) then
		unit:PlaySoundToSet(10562)
		unit:MonsterYell("So... full of life!")
	else
		unit:PlaySoundToSet(10563)
		unit:MonsterYell("Do not... resist.")
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
		unit:MonsterYell("Yes! I am... empowered!")
		unit:PlaySoundToSet(10564)
	else
		unit:MonsterYell("More... I must have more!")
		unit:PlaySoundToSet(10565)
	end
end

function OnDeath(unit)
	unit:MonsterYell("To the void... once... more..")
	unit:PlaySoundToSet(10566)
end

function AIUpdate(unit)
	if(unit:IsCasting() ) then return end
	if(unit:GetNextTarget() == nil) then
		unit:WipeThreatList()
	end
	local ref = self[tostring(unit)]
	ref.void_blast = ref.void_blast -1
	ref.dark_shell = ref.dark_shell - 1
	if(ref.dark_shell <= 0) then
		unit:BossRaidEmote(unit:GetName().." casts dark shell!")
		if(ref.isHeroic) then
			unit:FullCastSpell(38759)
		else
			unit:FullCastSpell(32358)
		end
		ref.dark_shell = math.random(20,30)+11 -- the +11 is for the cast time and the aura duration.
	elseif(ref.void_blast <= 0) then
		for i = 1,5 do
			unit:RegisterLuaEvent(VoidBlast_Protocol,i*1000,1)
		end
		ref.void_blast = math.random(10,20)
		ref.dark_shell = ref.dark_shell+5 -- delay dark shell event hax!
	end
end

function VoidBlast_Protocol(unit)
	local target = unit:GetRandomEnemy()
	if(self[tostring(unit)].isHeroic) then
		unit:FullCastSpellOnTarget(38760,target)
	else
		unit:FullCastSpellOnTarget(32325,target)
	end
end

RegisterUnitEvent(18341, 1, OnCombat)
RegisterUnitEvent(18341, 2, OnWipe)
RegisterUnitEvent(18341, 3, OnTargetKill)
RegisterUnitEvent(18341, 4, OnDeath)
RegisterUnitEvent(18341, 21, AIUpdate)