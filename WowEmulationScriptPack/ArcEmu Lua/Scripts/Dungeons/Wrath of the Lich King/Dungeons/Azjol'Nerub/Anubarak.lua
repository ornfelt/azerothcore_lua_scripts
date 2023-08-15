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
   SCRIPT NAME
   Original Code by DARKI
   Version 1
========================================]]--

-- Defines
local OBJECT_END                                            =	0x006
local UNIT_FIELD_FLAGS                                       	= OBJECT_END + 0x028
local UNIT_FLAG_NOT_ATTACKABLE_9           = 0x00000100
local UNIT_FLAG_NOT_SELECTABLE = 0x02000000
local anubaraka = 29120
local assasian = 29214
local darter = 29213


-- Script
function Anubarak_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(14, 0,"Eternal agony awaits you!")
	pUnit:RegisterEvent("Anubarak_Swarm",8000, 0)
	pUnit:RegisterEvent("Anubarak_CarrionBeetlesSummon",6000, 0).
	pUnit:RegisterEvent("Anubarak_SuperSpell",6000, 0)
if pUnit:GetHealthPct() < 66 then
	pUnit:RegisterEvent("Anubarak_Phazo1",1,1)
if pUnit:GetHealthPct() < 33 then
	pUnit:RegisterEvent("Anubarak_Phazo2",1,1)
if pUnit:GetHealthPct() < 15 then
	pUnit:RegisterEvent("Anubarak_Phazo3",1,1)
end
end
end
end

function Anubarak_Swarm(pUnit, Event)
	pUnit:FullCastSpellOnTarget(53467,pUnit:GetRandomPlayer(0))
	local anubarakchoice=math.random(1, 2)
	if killchoice==1 then
		pUnit:SendChatMessage(14, 0,"Your armor is useless against my locusts!")
	elseif killchoice==2 then	
		pUnit:SendChatMessage(14, 0,"The pestilence upon you!")	
end
end

function Anubarak_CarrionBeetlesSummon(pUnit,Event)
	pUnit:FullCastSpell(53520)
end
function Anubarak_Swarm(pUnit, Event)
	Unit:FullCastSpell(53454)
end

function Anubarak_Phazo1(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:SetScale(0)
	local plr = pUnit:GetRandomPlayer(0)
	if type(plr) == "userdata" then
	pUnit:SpawnCreature(assasian , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0)
	pUnit:SpawnCreature(assasian , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SpawnCreature(darter , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SpawnCreature(darter , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 	
	pUnit:SendChatMessage(14, 0,"Come forth, my brethren. Feast on their flesh")
	pUnit:RegisterEvent("Anubarak_RemovePhazo1",15000, 1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE+UNIT_FLAG_NOT_ATTACKABLE_9)
	pUnit:FullCastSpell(53472)
end
end
function Anubarak_RemovePhazo1(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Anubarak_Swarm",8000, 0)
	pUnit:RegisterEvent("Anubarak_CarrionBeetlesSummon",6000, 0)
end

function Anubarak_Phazo2(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:SetScale(0)
	local plr = pUnit:GetRandomPlayer(0)
	if type(plr) == "userdata" then
	pUnit:SpawnCreature(assasian , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0)
	pUnit:SpawnCreature(assasian , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SpawnCreature(darter , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SpawnCreature(darter , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SendChatMessage(14, 0,"Come forth, my brethren. Feast on their flesh")
	pUnit:RegisterEvent("Anubarak_RemovePhazo2",15000, 1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE+UNIT_FLAG_NOT_ATTACKABLE_9)
	pUnit:FullCastSpell(53472)
end
end
function Anubarak_RemovePhazo2(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Anubarak_Swarm",8000, 0)
	pUnit:RegisterEvent("Anubarak_CarrionBeetlesSummon",6000, 0)
end

function Anubarak_Phazo3(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:Root()
	pUnit:SetScale(0)
	local plr = pUnit:GetRandomPlayer(0)
	if type(plr) == "userdata" then
	pUnit:SpawnCreature(assasian , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0)
	pUnit:SpawnCreature(assasian , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SpawnCreature(darter , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 
	pUnit:SpawnCreature(darter , plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 14, 0) 	
	pUnit:SendChatMessage(14, 0,"Come forth, my brethren. Feast on their flesh")
	pUnit:RegisterEvent("Anubarak_RemovePhazo3",15000, 1)
	pUnit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FLAG_NOT_SELECTABLE+UNIT_FLAG_NOT_ATTACKABLE_9)
	pUnit:FullCastSpell(53472) 
end
end
function Anubarak_RemovePhazo3(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Anubarak_Swarm",8000, 0)
	pUnit:RegisterEvent("Anubarak_CarrionBeetlesSummon",6000, 0)
end

function Anubarak_OnKilledTarget (pUnit, Event)
	local anubarakchoice=math.random(1, 3)
	if Krikthichoice==1 then
		pUnit:SendChatMessage(14, 0,"You shall experience my torment, first-hand!")
	elseif Krikthichoice==2 then	
		pUnit:SendChatMessage(14, 0,"You have made your choice.")	
	elseif Krikthichoice==3 then	
		pUnit:SendChatMessage(14, 0,"Soon, the Master's voice will call to you.")
end		
end

function Anubarak_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end
function Anubarak_OnDied(pUnit, event, player)
	pUnit:SendChatMessage(14, 0,"I never thought... I would be rid of him.")
	pUnit:RemoveEvents()
end

-- Registers
RegisterUnitEvent(anubaraka, 1, "Anubarak_OnEnterCombat")
RegisterUnitEvent(anubaraka, 2, "Anubarak_OnLeaveCombat")
RegisterUnitEvent(anubaraka, 4, "Anubarak_OnDied")
RegisterUnitEvent(anubaraka, 3, "Anubarak_OnKilledTarget")

--[[
	ADD ASSASIAN
	]]
function Assasian_OnEnterCombat(pUnit,Event) 
	pUnit:RegisterEvent("Anubarak_Backstab",6500, 0)
end	
function Assasian_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
	pUnit:RemoveFromWorld()
end

function Assasian_Backstab(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52540,pUnit:GetClosestPlayer())
end


RegisterUnitEvent(assasian, 1, "Assasian_OnEnterCombat")
RegisterUnitEvent(assasian, 2, "Assasian_OnLeaveCombat")

--[[
	ADD DARTER 
	]]
function Darter_OnEnterCombat(pUnit,Event) 
	pUnit:RegisterEvent("Darter_Dart",1000, 1)
end	
function Darter_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
	pUnit:RemoveFromWorld()
end

function Darter_Dart(pUnit,Event)
	pUnit:FullCastSpellOnTarget(52540,pUnit:GetRandomPlayer(0))
end

RegisterUnitEvent(darter, 1, "Darter_OnEnterCombat")
RegisterUnitEvent(darter, 2, "Darter_OnLeaveCombat")
