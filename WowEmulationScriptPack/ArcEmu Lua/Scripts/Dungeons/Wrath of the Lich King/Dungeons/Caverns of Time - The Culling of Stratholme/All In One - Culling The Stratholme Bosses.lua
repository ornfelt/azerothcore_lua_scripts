--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function ChronoLordEpoch_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "We'll see about that, young prince.")
	pUnit:RegisterEvent("ChronoLordEpoch_TimeWarp", 18000, 0)
	pUnit:RegisterEvent("ChronoLordEpoch_CurseOfExertion", 16000, 0)
	pUnit:RegisterEvent("ChronoLordEpoch_WoundingStrike", 8000, 0)
end

function ChronoLordEpoch_OnSpawn(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Prince Arthas Menethil, on this day, a powerful darkness has taken hold of your soul. The death you are destined to visit upon others will this day be your own.")
end

function ChronoLordEpoch_TimeWarp(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52766,pUnit:GetClosestPlayer())
	local Choice=math.random(1, 3)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "Tick tock, tick tock...")
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "Not quick enough!")
	elseif Choice==3 then
		pUnit:SendChatMessage(14, 0, "Let's get this over with.")
	end
end

function ChronoLordEpoch_CurseOfExertion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52772,pUnit:GetClosestPlayer())
end

function ChronoLordEpoch_WoundingStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52771,pUnit:GetClosestPlayer())
end

function ChronoLordEpoch_OnKill(pUnit,Event)
	local Choice=math.random(1, 3)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "There is no future for you.")
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "This is the hour of our greatest triumph!")
	elseif Choice==3 then
		pUnit:SendChatMessage(14, 0, "You would destined to fail.")
	end
end

function ChronoLordEpoch_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function ChronoLordEpoch_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(26532, 1, "ChronoLordEpoch_OnEnterCombat")
RegisterUnitEvent(26532, 6, "ChronoLordEpoch_OnSpawn")
RegisterUnitEvent(26532, 3, "ChronoLordEpoch_OnKill")
RegisterUnitEvent(26532, 4, "ChronoLordEpoch_OnDied")
RegisterUnitEvent(26532, 2, "ChronoLordEpoch_OnLeaveCombat")

function Meathook_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "New toys!")
	pUnit:RegisterEvent("Meathook_ConstrictingChains", 11000, 0)
	pUnit:RegisterEvent("Meathook_DiseaseExplusion", 6000, 0)
end

function Meathook_OnSpawn(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Play time!")
end

function Meathook_OnKill(pUnit,Event)
	local Choice=math.random(1, 3)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "Boring...")
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "Why you stop moving?")
	elseif Choice==3 then
		pUnit:SendChatMessage(14, 0, "Get up! Me not done!")
	end
end

function Meathook_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "This not fun...")
end

function Meathook_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Meathook_ConstrictingChains(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52696,pUnit:GetClosestPlayer())
end

function Meathook_DiseaseExplusion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52666,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(26529, 1, "Meathook_OnEnterCombat")
RegisterUnitEvent(26529, 6, "Meathook_OnSpawn")
RegisterUnitEvent(26529, 3, "Meathook_OnKill")
RegisterUnitEvent(26529, 4, "Meathook_OnDied")
RegisterUnitEvent(26529, 2, "Meathook_OnLeaveCombat")

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

--Mal'Ganis http://wotlk.wowhead.com/?npc=26533 last Boss of "Culling The Stratholme" CoT Wotlk Event Timers are not 100% Blizzlike but they are fine :)
-- He should banish at End of Fight i dont know how do you get Loot :) i Just good my Wotlk Retail Acc i hope i will find out soon
function MG_EnterCombat(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "This will be a fine test, Prince Arthas.") -- I will add Sound ID's laterz :)
	pUnit:RegisterEvent("MG_Swarm", 16000, 0)
	pUnit:RegisterEvent("MG_Blast", 12000, 0)
	pUnit:RegisterEvent("MG_Sleep", 21000, 0)
	pUnit:RegisterEvent("MG_Vampiric", 8000, 0)
end


function MG_Swarm(pUnit, Event)
	pUnit:CastSpell(52720) -- http://wotlk.wowhead.com/?spell=52720
end

function MG_Blast(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52722,pUnit:GetRandomPlayer(0)) -- http://wotlk.wowhead.com/?spell=52722
end

function MG_Sleep(pUnit,Event)
pUnit:FullCastSpellOnTarget(52721,pUnit:GetRandomPlayer(0))
	local Choice=math.random(1, 2)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "Time out.")
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "You seem tired.")
	end
end

function MG_Blast(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52723,pUnit:GetRandomPlayer(0)) -- http://wotlk.wowhead.com/?spell=52723 100% not Supported by Any Core!
end


function MG_OnKill(pUnit,Event)
	pUnit:RemoveEvents()
	local Choice=math.random(1, 3)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "All too easy.")
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "The dark lord is displeased with your interference.")
	elseif Choice==3 then
		pUnit:SendChatMessage(14, 0, "It is Prince Arthas I want, not you.")
	end
end

function MG_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end


function MG_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(26533, 1, "MG_EnterCombat")
RegisterUnitEvent(26533, 2, "MG_OnLeaveCombat")
RegisterUnitEvent(26533, 3, "MG_OnKill")
RegisterUnitEvent(26533, 4, "MG_OnDied")