--[[ Boss -- Mal'Ganis.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, September 13, 2008. ]]

--Mal'Ganis http://wotlk.wowhead.com/?npc=26533 last Boss of "Culling The Stratholme" CoT Wotlk Event Timers are not 100% Blizzlike but they are fine :)
-- He should banish at End of Fight i dont know how do you get Loot :) i Just good my Wotlk Retail Acc i hope i will find out soon
function MG_EnterCombat(Unit, Event)
   	Unit:Root()
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:SendChatMessage(14, 0, "Yes, this is the beginning. I've been waiting for you, young prince. I am Mal'Ganis.")
	Unit:RegisterEvent("MG_Speach1", 7000, 0)
end

function MG_Speach1(Unit, Event)
	Unit:SendChatMessage(14, 0, "Yes, this is the beginning. I've been waiting for you, young prince. I am Mal'Ganis.")
	Unit:RegisterEvent("MG_Battle", 9000, 0)
end	
function MG_Battle(Unit, Event)
   	Unit:RemoveEvents()
	Unit:SendChatMessage(14, 0, "This will be a fine test, Prince Arthas.") -- I will add Sound ID's laterz :)
	Unit:RegisterEvent("MG_Swarm", 16000, 0)
	Unit:RegisterEvent("MG_Blast", 12000, 0)
	Unit:RegisterEvent("MG_Sleep", 21000, 0)
	Unit:RegisterEvent("MG_Vampiric", 8000, 0)
	Unit:RegisterEvent("MG_Vanish", 1000, 0)
end	

function MG_Swarm(Unit, Event)
	Unit:CastSpell(52720) -- http://wotlk.wowhead.com/?spell=52720
end

function MG_Blast(Unit,Event)
	Unit:FullCastSpellOnTarget(52722,Unit:GetRandomPlayer(0)) -- http://wotlk.wowhead.com/?spell=52722
end

function MG_Sleep(Unit,Event)
Unit:FullCastSpellOnTarget(52721,Unit:GetRandomPlayer(0))
	local Choice=math.random(1, 2)
		if Choice==1 then
			Unit:SendChatMessage(14, 0, "Time out.")
		elseif Choice==2 then
			Unit:SendChatMessage(14, 0, "You seem tired.")
end
end

function MG_Blast(Unit,Event)
	Unit:FullCastSpellOnTarget(52723,Unit:GetRandomPlayer(0)) -- http://wotlk.wowhead.com/?spell=52723 100% not Supported by Any Core!
end


function MG_OnKill(Unit,Event)
	Unit:RemoveEvents()
	local Choice=math.random(1, 3)
		if Choice==1 then
			Unit:SendChatMessage(14, 0, "All too easy.")
		elseif Choice==2 then
			Unit:SendChatMessage(14, 0, "The dark lord is displeased with your interference.")
		elseif Choice==3 then
			Unit:SendChatMessage(14, 0, "It is Prince Arthas I want, not you.")
end
end

function MG_Vanish(Unit,Event)
	if	Unit:GetHealthPct() < 2 then	
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:Emote(1)
	Unit:SendChatMessage(12, 0, "Your journey has just begun, young prince...Gather your forces, and meet me in the arctic land of Northrend...It is there we shall settle the score between us...It is there that your true destiny will unfold...")
	Unit:RemoveFromWorld()
	local x,y,z,o =	Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
	Unit:SpawnGameObject(190663, x , y , z ,0) 
	end
end

function MG_OnDied(Unit, pGameObject, Event)
	Unit:SpawnObject(190663, Unit:GetX(), Unit:GetY(),  Unit:GetZ(), Unit:GetO())
	Unit:RemoveEvents()
end


function MG_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(26533, 1, "MG_EnterCombat")
RegisterUnitEvent(26533, 2, "MG_OnLeaveCombat")
RegisterUnitEvent(26533, 4, "MG_OnKill")
RegisterUnitEvent(26533, 3, "MG_OnDied")