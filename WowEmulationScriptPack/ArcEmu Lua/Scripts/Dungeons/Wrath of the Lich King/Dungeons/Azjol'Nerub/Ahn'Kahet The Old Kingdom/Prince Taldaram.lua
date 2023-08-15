--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   Boss -- Prince Taldaram.lua
   Original Code by DARKI
   Version 1
========================================]]--

function PrinceTaldaram_OnEnterCombat(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "I will feast on your remains.")
	pUnit:RegisterEvent("PrinceTaldaram_Bloodthirst",17000, 0)
	pUnit:RegisterEvent("PrinceTaldaram_Vasnih",24000, 0)
	pUnit:RegisterEvent("PrinceTaldaram_Conjure",35000, 0)
	pUnit:RegisterEvent("PrinceTaldaram_Vampyr",40000, 0)
end

function PrinceTaldaram_Bloodthirst(pUnit,Event)
	pUnit:FullCastSpell(55968)
end

function PrinceTaldaram_Vasnih(pUnit,Event)
	pUnit:FullCastSpell(55964)
	local vchoice=math.random(1, 2)
	if vchoice==1 then
		pUnit:SendChatMessage(14, 0,"Your heartbeat is music to my ears.")
	elseif vchoice==2 then
		pUnit:SendChatMessage(14, 0,"I am nowhere. I am everywhere. I am the watcher, unseen.")
	end
end

-- Core Script required it might crash server as well...worked on mine i will post patch
function PrinceTaldaram_Conjure(pUnit,Event)
	pUnit:FullCastSpellOnTarget(55931,pUnit:GetClosestPlayer(0))
end

function PrinceTaldaram_Vampyr(pUnit,Event)
	pUnit:FullCastSpellOnTarget(55959,pUnit:GetClosestPlayer(0))
	local vamchoice=math.random(1, 2)
	if vamchoice==1 then
		pUnit:SendChatMessage(14, 0,"So appetizing.")
	elseif vamchoice==2 then
		pUnit:SendChatMessage(14, 0,"Fresh, warm blood. It has been too long. ")
	end
end

function PrinceTaldaram_OnKilledTarget (pUnit, Event)
	local Choice=math.random(1, 2)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0,"I will drink no blood before it's time.")
	elseif Choice==2 then	
		pUnit:SendChatMessage(14, 0,"One final embrace.")
end		
end

function PrinceTaldaram_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function PrinceTaldaram_OnDied(pUnit, event, player)
	pUnit:SendChatMessage(14, 0, "Still I hunger, still I thirst.")	
	pUnit:RemoveEvents()
end

RegisterUnitEvent(29308, 1, "PrinceTaldaram_OnEnterCombat")
RegisterUnitEvent(29308, 2, "PrinceTaldaram_OnLeaveCombat")
RegisterUnitEvent(29308, 4, "PrinceTaldaram_OnDied")
RegisterUnitEvent(29308, 3, "PrinceTaldaram_OnKilledTarget")