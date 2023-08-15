--[[ Boss -- Salramm the Fleshcrafter.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, September 23, 2008. ]]

function Salramm_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Ah, the entertainment has arrived!")
	pUnit:RegisterEvent("Salramm_StealFlesh", 11000, 0)
	pUnit:RegisterEvent("Salramm_ShadowBolt", 3000, 0)
	pUnit:RegisterEvent("Salramm_ExplodeGhouls", 21000, 0)
	pUnit:RegisterEvent("Salramm_SummonGhouls", 7000, 0)
end

function Salramm_OnSpawn(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "You are too late, champion of Lordaeron. The dead shall have their day.")
end

function Salramm_OnKill(pUnit,Event)
	local Choice=math.random(1, 3)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "The fun is just beginning!")
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Aah, quality materials!")
		elseif Choice==3 then
			pUnit:SendChatMessage(14, 0, "Don't worry, I'll make good use of you.")
end
end

function Salramm_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "You only advance... the master's plan... ")
end

function Salramm_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Salramm_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15232,pUnit:GetClosestPlayer())
end

function Salramm_StealFlesh(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52708,pUnit:GetClosestPlayer())
	local Choice=math.random(1, 3)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "I want a sample...")
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Such strength... it must be mine!")
		elseif Choice==3 then
			pUnit:SendChatMessage(14, 0, "Your flesh betrays you.")
end
end

function Salramm_ExplodeGhouls(pUnit,Event)
	pUnit:CastSpell(52480)
	local Choice=math.random(1, 2)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "BOOM! Hahahahah...")
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Blood... destruction... EXHILARATING!")
end
end

function Salramm_SummonGhouls(pUnit,Event)
	pUnit:CastSpell(52451)
	local Choice=math.random(1, 2)
		if Choice==1 then
			pUnit:SendChatMessage(14, 0, "Say hello to some friends of mine.")
		elseif Choice==2 then
			pUnit:SendChatMessage(14, 0, "Come, citizen of Stratholme! Meet your saviors.")
end
end

RegisterUnitEvent(26530, 1, "Salramm_OnEnterCombat")
RegisterUnitEvent(26530, 6, "Salramm_OnSpawn")
RegisterUnitEvent(26530, 3, "Salramm_OnKill")
RegisterUnitEvent(26530, 4, "Salramm_OnDied")
RegisterUnitEvent(26530, 2, "Salramm_OnLeaveCombat")