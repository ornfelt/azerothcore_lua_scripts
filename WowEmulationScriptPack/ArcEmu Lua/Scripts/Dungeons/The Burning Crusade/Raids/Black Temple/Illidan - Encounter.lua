--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]
--[[
This scripts was created/modified by BrantX of Blua.
This script and its containg SQL should not be released or re-released,
by anybody and/or modified by anybody. The only thing you
can do for this script is to place it in the scripts folder.
All credits for creating this script belong to BrantX.
This script was intended to use for Aspire.
--]]

function Illidan_OnSpawn(Unit,Event)
	Unit:CastSpell(39656)
	Unit:ApplyAura(39656)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
end

RegisterUnitEvent(229170, 18, "Illidan_OnSpawn")

function Illidan_OnEnterCombat(Unit,Event)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You are not prepared!")
	Unit:PlaySoundToSet(11466)
	Unit:RegisterEvent("Illidan_Phase1", 1000, 1)
	Unit:RegisterEvent("Illidan_EmoteDraw", 000, 1)
	Unit:RegisterEvent("Illidan_StartAttack", 3000, 1)
	Unit:RegisterEvent("Illidan_CallMinion", 1000, 0)
end

function Illidan_EmoteDraw(Unit,Event)
	Unit:Emote(406)
end

function Illidan_StartAttack(Unit,Event)
	Unit:SetCombatMeleeCapable(0)
	Unit:Emote(0)
	Unit:SetUInt64Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_UNKNOWN_1) -- Apparently lets him attackble?
	Unit:StopMovement(0)
end

function Illidan_CallMinion(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local Akama = Unit:GetCreatureNearestCoords(X,Y,Z,22990)
 if Unit:GetHealthPct() == 95 then
	Unit:RegisterEvent("Illidan_AkamaFlee", 5000, 1)
	Unit:RegisterEvent("Illidan_AkamaTargetCheck", 1000, 1)
	Unit:PlaySoundToSet(11465)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Come, my minions. Deal with this traitor as he deserves!")
end
end

function Illidan_AkamaTargetCheck(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local Akama = Unit:GetCreatureNearestCoords(X,Y,Z,22990)
local plr = Unit:GetClosestPlayer()
	Unit:WipeTargetList()
	Unit:SetNextTarget(plr) -- This is a check to make sure Illidan doesn't keep his target at Akama(Akama runs and despawns not good if illidan is target)
end

function Illidan_AkamaFlee(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local Akama = Unit:GetCreatureNearestCoords(X,Y,Z,22990)
	Akama:SetCombatCapable(1)
	Akama:SetCombatMeleeCapable(1)
	Akama:SetCombatRangedCapable(1)
	Akama:SetCombatSpellCapable(1)
	Akama:SetCombatTargetingCapable(1)
	Akama:ClearThreatList()
	Akama:WipeThreatList()
	Akama:WipeTargetList()
	Akama:WipeCurrentTarget()
	Akama:SetFaction(35) -- So he doesn't re-target illidan ;D
	Akama:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I will deal with these mongrels! Strike now, friends! Strike at the Betrayer!")
	Akama:MoveTo(718.616, 305.473, 352.996, -0.860865)
	Unit:RegisterEvent("Illidan_AkamaFlee2", 6000, 1)
end

function Illidan_AkamaFlee2(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local Akama = Unit:GetCreatureNearestCoords(X,Y,Z,22990)
	Akama:MoveTo(673.927, 259.700, 352.996, -2.344210)
end

function Illidan_Phase1(Unit,Event)
	Unit:RegisterEvent("Illidan_Phase2", 1000, 0)
	Unit:RegisterEvent("Illidan_Shear", 15000, 0)
	Unit:RegisterEvent("Illidan_FlameCrash", 33000, 0)
	Unit:RegisterEvent("Illidan_ParasiticShadowfiend", 45000, 0)
	Unit:RegisterEvent("Illidan_DrawSoul", 37000, 0)
end

function Illidan_Shear(Unit,Event)
local tank = Unit:GetMainTank()
local plr = Unit:GetClosestPlayer()
	Unit:FullCastSpellOnTarget(41032,tank)
	if tank == nil then
	Unit:FullCastSpellOnTarget(41032,plr)
	else
	return
end
end

function Illidan_FlameCrash(Unit,Event)
local tank = Unit:GetMainTank()
local plr = Unit:GetClosestPlayer()
local x,y,z,o = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
	Unit:FullCastSpellOnTarget(40832,tank)
	if tank == nil then
	Unit:FullCastSpellOnTarget(41032,plr)
	else
	return
end
end

function Illidan_ParasiticShadowfiend(Unit,Event)
	Unit:FullCastSpellOnTarget(41917,Unit:GetRandomPlayer(0))
	Unit:FullCastSpellOnTarget(41917,Unit:GetMainTank())
end

function Illidan_DrawSoul(Unit,Event)
local tank = Unit:GetMainTank()
local plr = Unit:GetRandomPlayer(2)
	Unit:FullCastSpellOnTarget(40904,tank)
	if tank == nil then
	Unit:FullCastSpellOnTarget(40904,plr)
	else
	return
end
end

function Illidan_Phase2(Unit,Event)
 if Unit:GetHealthPct() <= 65 then
	Unit:RemoveEvents()
	local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I will not be touched by rabble such as you!")
	Unit:PlaySoundToSet(11479)
	Unit:EnableMoveFly(1)
	Unit:SetFlying()
	Unit:SetCombatMeleeCapable(1)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:CastSpell(57764)
	Unit:RegisterEvent("Illidan_Phase2FlyToFront", 7000, 1)
end
end

function Illidan_Phase2FlyToFront(Unit,Event)
	Unit:MoveTo(705.045, 305.233, 353.888, 3.129)
	Unit:RegisterEvent("Illidan_Phase2FaceMiddle", 1000, 1)
end

function Illidan_Phase2FaceMiddle(Unit,Event)
	Unit:SetFacing(0.674085)
	Unit:RegisterEvent("Illidan_Phase2Talk", 5000, 1)
end

function Illidan_Phase2Talk(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Behold the Flames of Azzinoth!")
	Unit:PlaySoundToSet(11480)
	Unit:CastSpellAoF(676.717346, 322.445251, 354.153320,39635) -- Glaives
	Unit:CastSpellAoF(677.368286, 285.374725, 354.242157,39849) -- Glaives
	Unit:RegisterEvent("Illidan_Phase2Patrol",1000, 1)
	Unit:RegisterEvent("Illidan_GlaiveSpawn", 1200, 1)
	
end

function Illidan_GlaiveSpawn(Unit,Event)
-- Glaives and Flame of Azzinoth
	Unit:SpawnCreature(229960, 676.717346, 322.445251, 354.153320, 5.732623,35,0)
	Unit:SpawnCreature(229960, 677.368286, 285.374725, 354.242157, 5.645614,35,0)
	Unit:SpawnCreature(229970, 672.039246, 326.748322, 354.206390, 0.207343,1825,0)
	Unit:SpawnCreature(229970, 673.008667, 283.813660, 354.267548, 6.203853,1825,0)
end

function Illidan_Phase2Patrol(Unit,Event)
	Unit:CastSpell(57764)
	Unit:RegisterEvent("Illidan_Phase2Patrol2",45000, 0)
	Unit:RegisterEvent("Illidan_Phase2Spells",1000, 1)
end

function Illidan_Phase2Patrol2(Unit,Event)
local x,y,z,o = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
-- This is close to blizz-like. He patrols 3 main points when flying.
local Choice=math.random(1, 3)
if Choice==1 then
	Unit:MoveTo(718.616, 305.474, 352.996, 3.140)
end
if Choice==2 then
	Unit:MoveTo(685.491, 344.018, 353.148, 4.512)
end
if Choice==3 then
	Unit:MoveTo(673.927, 259.700, 352.996, 1.484)
end
end

function Illidan_Phase2Spells(Unit,Event)
	Unit:RegisterEvent("Illidan_Fireball", 5500, 0)
	Unit:RegisterEvent("Illidan_DarkBarrage", 120000, 0)
	Unit:RegisterEvent("Illidan_EyeBeam", 74000, 0)
	Unit:RegisterEvent("Illidan_Phase3", 1000, 1)
end

function Illidan_Fireball(Unit,Event)
local plr = Unit:GetRandomPlayer(0)
 if plr == nil then
	return
	else
	Unit:CancelSpell()
	Unit:FullCastSpellOnTarget(40598,plr)
end
end

function Illidan_DarkBarrage(Unit,Event)
local plr = Unit:GetRandomPlayer(0)
 if plr == nil then
	return
	else
	Unit:CancelSpell()
	Unit:FullCastSpellOnTarget(40585,plr)
end
end

function Illidan_EyeBeam(Unit,Event)
-- // Thank you ArcScript/Sun++ for this <3 [X,Y,Z Positons] \\ --
-- //I have and Idea also i didn't even need to do it with tables. \\ --
local Trigger = Unit:SpawnCreature(230691,642.240601,297.297180,353.423401,6,35,0)
	Unit:CancelSpell()
	Unit:RemoveEvents()
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Stare into the eyes of the Betrayer!")
	Unit:PlaySoundToSet(11481)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Trigger:GetGUID())
	Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,39908)
	Unit:FullCastSpellOnTarget(39908,Trigger)
	Unit:RegisterEvent("Illidan_Phase2Spells", 30000, 1)
	Unit:RegisterEvent("Illidan_StopChannel", 26000, 1)
end

function Illidan_StopChannel(Unit,Event)
	Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,0)
end

function EyeBeam_OnSpawn(Unit,Event)
	local Choice=math.random(1, 3)
if Choice==1 then
	Unit:RegisterEvent("EyeBeam_EyeBeamMove2", 3000, 1)
end
if Choice==2 then
	Unit:RegisterEvent("EyeBeam_EyeBeamMove5", 3000, 1)
end
if Choice==3 then
	Unit:RegisterEvent("EyeBeam_EyeBeamMove7", 3000, 1)
end
end

function EyeBeam_EyeBeamMove2(Unit,Event)
	Unit:MoveTo(641.197449,314.330963,353.300262,6)
	Unit:RegisterEvent("EyeBeam_EyeBeamMove3", 3000, 1)
end

function EyeBeam_EyeBeamMove3(Unit,Event)
	Unit:MoveTo(657.239807,256.925568,352.996094,6)
	Unit:RegisterEvent("EyeBeam_EyeBeamMove4", 3000, 1)
end

function EyeBeam_EyeBeamMove4(Unit,Event)
	Unit:MoveTo(657.913330,353.562775,352.996185,6)
end

function EyeBeam_EyeBeamMove5(Unit,Event)
	Unit:MoveTo(707.019043,270.441772,352.996063,6)
	Unit:RegisterEvent("EyeBeam_EyeBeamMove6", 3000, 1)
end

function EyeBeam_EyeBeamMove6(Unit,Event)
	Unit:MoveTo(706.592407,343.425568,352.996124,6)
end

function EyeBeam_EyeBeamMove7(Unit,Event)
	Unit:MoveTo(706.593262,310.011475,353.693848,6)
	Unit:RegisterEvent("EyeBeam_Move8", 3000, 1)
end

function EyeBeam_Move8(Unit,Event)
	Unit:MoveTo(706.751343,298.312683,353.653809,6)
	Unit:RegisterEvent("EyeBeam_Move9", 3000, 1)
end

function EyeBeam_Move9(Unit,Event)
	Unit:MoveTo(642.240601,297.297180,353.423401,6)
	Unit:Despawn(4000,0)
end

RegisterUnitEvent(230691, 18, "EyeBeam_OnSpawn")

function Illidan_Phase3(Unit,Event)
local Elem1 = Unit:GetCreatureNearestCoords(703.582, 290.075, 352.996, 229970)
local Elem2 = Unit:GetCreatureNearestCoords(672.000, 327.000, 354.000, 229970)
if Elem1:IsAlive() == false and Elem2:IsAlive() == false then
	Unit:RemoveEvents()
	Unit:MoveTo(676.248, 262.114, 352.996, 6)
	Unit:RegisterEvent("Illidan_Phase3GlaiveTake", 3000, 1)
end
end

function Illidan_Phase3GlaiveTake(Unit,Event)
local Blade1 = Unit:GetCreatureNearestCoords(676.717346, 322.445251, 354.153320,229960)
local Blade2 = Unit:GetCreatureNearestCoords(677.368286, 285.374725, 354.242157,229960)
	Unit:MoveTo(676.248, 262.114, 352.996, 6)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Blade1:Despawn(1000,0)
	Blade2:Despawn(1000,0)
	Unit:CastSpell(39873)
	Unit:RegisterEvent("Illidan_Phase3Spells", 1000, 0)
end

function Illidan_Phase3Spells(Unit,Event)
-- Check --
local Elem1 = Unit:GetCreatureNearestCoords(703.582, 290.075, 352.996, 229970)
local Elem2 = Unit:GetCreatureNearestCoords(672.000, 327.000, 354.000, 229970)
if Elem1:IsAlive() == false and Elem2:IsAlive() == false then
	Unit:Land()
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:RegisterEvent("Illidan_StartCombat", 2000, 1)
	Unit:RegisterEvent("Illidan_Shear", 15000, 0)
	Unit:RegisterEvent("Illidan_FlameCrash", 30000, 0)
	Unit:RegisterEvent("Illidan_ParasiticShadowfiend", 000, 0)
	Unit:RegisterEvent("Illidan_DrawSoul", 33000, 0)
	Unit:RegisterEvent("Illidan_AgonizingFlames", 70000, 0)
	Unit:RegisterEvent("Illidan_Phase4", 30000, 1)
	Unit:RegisterEvent("Illidan_Phase5", 1000, 1)
	else
	Unit:RegisterEvent("Illidan_Phase3Spells", 1000, 1)
end
end

function Illidan_StartCombat(Unit,Event)
	Unit:StopMovement(0)
	Unit:SetCombatMeleeCapable(0)
end

function Illidan_Phase4(Unit,Event)
	Unit:RemoveEvents()
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:RegisterEvent("Illidan_Emotes", 000, 1)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Behold the power... of the demon within!")
	Unit:PlaySoundToSet(11475)
	Unit:RegisterEvent("Illidan_Deform", 60000, 1)
end

function Illidan_Emotes(Unit,Event)
	--Unit:Emote(403)
	Unit:RegisterEvent("Illidan_Emote2", 1200, 1)
end

function Illidan_Emote2(Unit,Event)
	--Unit:Emote(404)
	Unit:RegisterEvent("Illidan_Turn", 2000, 1)
end

function Illidan_Turn(Unit,Event)
	--Unit:Emote(405)
	Unit:CastSpell(40506)
end

function Illidan_Deform(Unit,Event)
	Unit:RemoveEvents()
	--Unit:Emote(403) 
	Unit:RegisterEvent("Illidan_DeformMid1", 2000, 1)
end

function Illidan_DeformMid1(Unit,Event)
	--Unit:Emote(404)
	Unit:RegisterEvent("Illidan_Phase3Spells", 4500, 1)
	Unit:RegisterEvent("Illidan_DeformCheck", 1200, 1)
end

function Illidan_DeformCheck(Unit,Event)
	Unit:RemoveAura(40506)
	Unit:SetModel(21135)
	Unit:StopMovement(0)
	Unit:SetCombatMeleeCapable(0)
	--Unit:Emote(405)
	--Unit:Emote(0)
end

function Illidan_Phase5(Unit,Event)
 if Unit:GetHealthPct() <= 30 then
	Unit:RemoveEvents()
	Unit:CastSpell(40647)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Is this it, mortals? Is this all the fury you can muster?")
	Unit:PlaySoundToSet(11476)
	--Unit:Emote(6)
	Unit:RegisterEvent("Illidan_SpawnMaiev", 8000, 1)
	Unit:RegisterEvent("Illidan_MaievTalk1", 15000, 1)
  if Unit:GetModel() == 21322 then
	Unit:SetModel(21135)
	Unit:StopMovement(0)
end
end
end

function Illidan_SpawnMaiev(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local O = Unit:GetO()
local Maiev = Unit:SpawnCreature(231970,X,Y,Z+.5,2.177125,35,0)
	--Unit:Emote(0)
	if Maiev:IsInWorld() == 1 then
	Unit:MoveTo(X,Y,Z,O-2.177)
	Unit:SetNextTarget(Maiev)
	else
	if Maiev:IsInWorld() == 1 then
	Unit:MoveTo(X,Y,Z,O-2.177)
	Unit:SetNextTarget(Maiev)
end
end
end

function Illidan_MaievTalk1(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Maiev... How is it even possible?")
	Unit:PlaySoundToSet(11477)
	Unit:RegisterEvent("Illidan_MaievAttack", 7000, 1)
end

function Illidan_MaievAttack(Unit,Event)
local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
local Maiev = Unit:GetCreatureNearestCoords(X,Y,Z,231970)
	Unit:RegisterEvent("Illidan_Speak2Maiev", 35000, 0)
	Unit:RegisterEvent("Illidan_OnCloseToDie", 35000, 0)
	Unit:SetNextTarget(Maiev)
 if Unit:GetNextTarget() == Maiev then
	Unit:StopMovement(0)
	Unit:SetCombatMeleeCapable(0)
 else
	Unit:SetNextTarget(Maiev)
	Unit:StopMovement(0)
	Unit:SetCombatMeleeCapable(0)
end
end

function Illidan_Speak2Maiev(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Feel the hatred of ten thousand years!")
	Unit:PlaySoundToSet(11470)
end

function Illidan_OnCloseToDie(Unit,Event)
 if Unit:GetHealthPct() == 1 then
	Unit:RemoveEvents()
	Unit:StopMovement(1)
	--Unit:Emote(EMOTE_ONESHOT_CUSTOMSPELL06)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE+UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:SetCombatMeleeCapable(1)
end
end


function Illidan_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function Illidan_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
	if Unit:IsFlying() == true then
	Unit:Land()
end
end

function Illidan_OnKill(Unit,Event)
	local Choice=math.random(1, 2)
if Choice==1 then
	Unit:PlaySoundToSet(11473)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Who shall be next to taste my blades?!")
end
if Choice==2 then
	Unit:PlaySoundToSet(11472)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"This is too easy!")
end
end

RegisterUnitEvent(229170, 1, "Illidan_OnEnterCombat")
RegisterUnitEvent(229170, 2, "Illidan_OnLeaveCombat")
RegisterUnitEvent(229170, 3, "Illidan_OnKill")
RegisterUnitEvent(229170, 4, "Illidan_OnDied")





--[[ Other Script Start Here ]] --
--[[ This is better, incase i change some stuff. :D ]] --
local MaievSpawnID = 231970
local FlameOfAzzinothSpawnID = 229970
local WarglaiveOfAzzinothSpawnID = 229960
local FlameCrashSpawnID = 233360
local DemonFlameSpawnID = 230690
local AkamaSpawnID = 229900
local UdaloSpawnID = 23410
local OlumSpawnID = 23411
local Akama2SpawnID = 229901
local Akama3SpawnID = 229902
local Akama4SpawnID = 229903
local Akama5SpawnID = 229904

-- [[ Maiev ]] --
-- [[ Status : Completed ]] --
function Maiev_OnSpawn(Unit,Event)
	Unit:RegisterEvent("Maiev_IfAttacked", 3000, 0)
	Unit:RegisterEvent("Maiev_IfIllidanIsDown", 3000, 0)
	Unit:StopMovement(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Their fury pales before mine, Illidan. We have some unsettled business between us.")
	Unit:PlaySoundToSet(11491)
	Unit:CastSpell(41221)
	Unit:RegisterEvent("Maiev_Illidan2", 13000, 1)
end

function Maiev_Illidan2(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Ah, my long hunt is finally over. Today, Justice will be done!")
	Unit:PlaySoundToSet(11492)
	Unit:RegisterEvent("Maiev_AttackIllidan", 8000, 1)
end

function Maiev_AttackIllidan(Unit,Event)
	Unit:StopMovement(0)
	Unit:SetCombatMeleeCapable(0)
end

function Maiev_IfAttacked(Unit,Event)
local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
local illidan = Unit:GetCreatureNearestCoords(X,Y,Z,O)
 if Unit:IsAttacking() == 1 then
	Unit:RegisterEvent("Maiev_RandomTalk", 8000, 0)
end
end

function Maiev_RandomTalk(Unit,Event)
	local Choice=math.random(1, 2)
if Choice==1 then
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"That, is for Naisha!")
	Unit:PlaySoundToSet(11493)
end
if Choice==2 then
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Bleed as I have bled!")
	Unit:PlaySoundToSet(11494)
end
end

function Maiev_IfIllidanIsDown(Unit,Event)
local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
local illidan = Unit:GetCreatureNearestCoords(X,Y,Z,229170)
 if illidan:GetHealthPct() == 1 then
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Ah, It is finished. You, are beaten.")
	Unit:PlaySoundToSet(11496)
	Unit:RegisterEvent("Maiev_IfIllidanIsDown2", 5000, 1)
end
end

function Maiev_IfIllidanIsDown2(Unit,Event)
local illidan = Unit:GetCreatureNearestCoords(X,Y,Z,229170)
	illidan:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You have won... Maiev. But the huntress... is nothing without the hunt. You... are nothing... without me.")
	illidan:PlaySoundToSet(11478)
	Unit:RegsiterEvent("Maiev_IllidanKilled", 13000, 1)
	Unit:RegsiterEvent("Maiev_KillIllidanAfterSpeech", 10000, 1)
end

function Maiev_KillIllidanAfterSpeech(Unit,Event)
local illidan = Unit:GetCreatureNearestCoords(X,Y,Z,229170)
illidan:SetHealthPct(0)
end

function Maiev_IllidanKilled(Unit,Event)
local illidan = Unit:GetCreatureNearestCoords(X,Y,Z,229170)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"He's right. I feel nothing. I am nothing.")
	Unit:PlaySoundToSet(11497)
	Unit:RegisterEvent("Maiev_DeSpawn", 3000, 1)
end

function Maiev_Despawn(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LandField.LANG_UNIVERSAL,"Farewell, champions.")
	Unit:PlaySoundToSet(11498)
	Unit:CastSpell(34673)
	Unit:SpawnCreature(Akama4, 739.545410, 323.023743, 352.996094, 4.578086,35,0)
end


RegisterUnitEvent(MaievSpawnID, 18, "Maiev_OnSpawn")


-- [[ Flame of Azzinoth ]] --
-- [[ Status : Completed ]] --

function FlameOfAzzinoth_OnSpawn(Unit,Event)
end

function FlameOfAzzinoth_OnEnterCombat(Unit,Event)
	Unit:CastSpell(40637)
	Unit:RegisterEvent("FlameOfAzzinoth_FlameBlast", 15000, 0)
end

function FlameOfAzzinoth_FlameBlast(Unit,Event)
	-- Needs to spawn a AreaFire Effect after casted i think.
local plr=Unit:GetRandomPlayer(0)
 if plr == nil then 
	return
	else
	Unit:FullCastSpellOnTarget(40631,plr)
end
end

function FlameOfAzzinoth_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function FlameOfAzzinoth_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(FlameOfAzzinothSpawnID, 1, "FlameOfAzzinoth_OnEnterCombat")
RegisterUnitEvent(FlameOfAzzinothSpawnID, 2, "FlameOfAzzinoth_OnLeaveCombat")
RegisterUnitEvent(FlameOfAzzinothSpawnID, 4, "FlameOfAzzinoth_OnDied")

-- [[ Warglaive of Azzinoth ]] --
-- [[ Status : Completed ]] --

function WarglaiveOfAzzinoth_OnSpawn(Unit,Event)
local Blade1 = Unit:GetX() == 677.368286
local Blade2 = Unit:GetX() == 676.717346
local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
local elem1 = Unit:GetCreatureNearestCoords(22997,X,Y,Z)
local elem2 = Unit:GetCreatureNearestCoords(22997,X,Y,Z)
if Blade1 then
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE+UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	--Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,elem1:GetGUID())
	--Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,39857)
	Unit:RegisterEvent("WarglaiveOfAzzinoth_Blade1Channel", 000, 0)
	Unit:CastSpellAoF(672.039246, 326.748322, 39857)
end
if Blade2 then
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE+UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	--Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,elem2:GetGUID())
	--Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,39857)
	Unit:CastSpellAoF(672.039246, 326.748322, 39857)
	Unit:RegisterEvent("WarglaiveOfAzzinoth_Blade2Channel", 000, 0)
end
end

function WarglaiveOfAzzinoth_Blade1Channel(Unit,Event)
local plr = Unit:GetClosestPlayer() -- Nil check(might error if he is deleted)
 if plr == nil then
	return
	else
	Unit:CastSpellAoF(672.039246, 326.748322, 39857)
end
end

function WarglaiveOfAzzinoth_Blade2Channel(Unit,Event)
local plr = Unit:GetClosestPlayer() -- Nil check(might error if he is deleted)
 if plr == nil then
	return
	else
	Unit:CastSpellAoF(673.008667, 283.813660, 39857)
end
end

RegisterUnitEvent(WarglaiveOfAzzinothSpawnID, 18, "WarglaiveOfAzzinoth_OnSpawn")

-- [[ Flame Crash ]] --
-- [[ Status : Completed ]] --
function FlameCrash_OnSpawn(Unit,Event)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_2)
	Unit:StopMovement(1)
	Unit:CastSpell(40836)
end

RegisterUnitEvent(FlameCrashSpawnID, 18, "FlameCrash_OnSpawn")

-- [[ Eye Beam - Demon Flame ]] --
-- [[ Status : Completed ]] --

function DemonFlame_OnSpawn(Unit,Event)
	Unit:CastSpell(39908)
end

RegisterUnitEvent(DemonFlameSpawnID, 18, "DemonFlame_OnSpawn")

-- [[ Akama - Event ]] --
-- [[ Status : Completed ]] --
function Akama_OnSpawn(Unit,Event)
	Unit:SetNPCFlags(1)
end

RegisterUnitEvent(AkamaSpawnID, 18, "Akama_OnSpawn")

function Akama_OnGossipTalk(Unit, event, player, Misc)
	Unit:GossipCreateMenu(50, player, 0)
	Unit:GossipMenuAddItem(0, "I'm ready, Akama", 1, 0)
	Unit:GossipSendMenu(player)
end

function Akama_OnGossipSelect(Unit, event, player, id, intid, code, Misc)
if (intid == 1) then
local X = Unit:GetX()
local Y = Unit:GetY()
local Z = Unit:GetZ()
local O = Unit:GetO()
	Unit:SpawnCreature(229901,Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO(),1858,0)--This is Akama2, Insted of 1 being all fucking buggy, Just make him spawn and do the work. Then when he reaches the part where he says "The betrayer meditates..." Make him despawn spawn Akama3 and then when they choose to fight, Despawn and Spawn Akama4.
	Unit:Despawn(1,0)
end
end

RegisterUnitGossipEvent(229900, 1, "Akama_OnGossipTalk")
RegisterUnitGossipEvent(229900, 2, "Akama_OnGossipSelect")

function Akama2_OnSpawn(Unit,Event)
	Unit:ModifyWalkSpeed(10)
	Unit:SetNPCFlags(0)
	Unit:MoveTo(652.814, 336.373, 271.688, 6.166974)
	Unit:RegisterEvent("Akama_Move", 1000, 1)
end

RegisterUnitEvent(229901, 18, "Akama2_OnSpawn")

function Akama_Move(Unit,Event)
	Unit:SetNPCFlags(0)
	Unit:MoveTo(693.392, 377.725, 271.688, 0.794850)
	Unit:RegisterEvent("Akama_Move2", 4000, 1)
end

function Akama_Move2(Unit,Event)
	Unit:MoveTo(699.038, 379.786, 271.958, 0.794850)
	Unit:RegisterEvent("Akama_Move3", 4000, 1)
end

function Akama_Move3(Unit,Event)
	Unit:MoveTo(716.572, 374.940, 278.597, 0.794850)
	Unit:RegisterEvent("Akama_Move4", 4000, 1)
end

function Akama_Move4(Unit,Event)
	Unit:MoveTo(731.365, 364.045, 289.286, 0.794850)
	Unit:RegisterEvent("Akama_Move5", 4000, 1)
end

function Akama_Move5(Unit,Event)
	Unit:MoveTo(743.287, 344.301, 302.016, 5.255643)
	Unit:RegisterEvent("Akama_Move6", 4000, 1)
end

function Akama_Move6(Unit,Event)
	Unit:MoveTo(749.310, 317.022, 312.098, 4.929704)
	Unit:RegisterEvent("Akama_Move7", 4000, 1)
end

function Akama_Move7(Unit,Event)
	Unit:MoveTo(752.253, 304.279, 312.072, 0.005250)
	Unit:RegisterEvent("Akama_Move8", 6000, 1)
end

function Akama_Move8(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local Door = Unit:GetGameObjectNearestCoords(774.7, 304.6, 314.85,3000003)
	Unit:SetFacing(6.5)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"The door is all that stands between us and the Betrayer. Stand aside, friends.")
	--Unit:Emote(EMOTE_ONESHOT_TALK)
	Unit:SpawnCreature(229170, 695.806, 306.433, 354.26, 6.26215, 1825, 0) -- Just Incase.
	Unit:RegisterEvent("Akama_OpenDoorEvent", 4000, 1)
end

function Akama_OpenDoorEvent(Unit,Event)
--local Door = Unit:GetCreatureNearestCoords(771.5, 304.7, 319, 3.10568,30001)
--local Door = Unit:SpawnCreature(30001, 771.5, 304.7, 319, 3.10568, 35, 0)
--local DoorTrig = Door:GetGUID()
	--Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,DoorTrig)
	--Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,41271)
	Unit:CastSpellAoF(771.5, 304.7, 319,41271)
	Unit:RegisterEvent("Akama_FailToOpen", 8000, 1)
end

function Akama_FailToOpen(Unit,Event)
	--Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,0)
	--Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,0)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"I cannot do this alone...")
	--Unit:Emote(EMOTE_ONESHOT_NO)
	Unit:RegisterEvent("Akama_Spawn2Helpers", 4000, 1)
end

function Akama_Spawn2Helpers(Unit,Event)
local Udalo = Unit:SpawnCreature(23410, 751.884705, 311.270050, 312.121185, 0.047113,35,0)
local Olum = Unit:SpawnCreature(23411, 751.687744, 297.408600, 312.124817, 0.054958,35, 0)
	Udalo:IsInWorld()
	Olum:IsInWorld()
	Unit:RegisterEvent("Akama_All3Door", 000, 1)
end

function Akama_All3Door(Unit,Event)
local Udalo = Unit:SpawnCreature(23410, 751.884705, 311.270050, 312.121185, 0.047113,35,0)
local Olum = Unit:SpawnCreature(23411, 751.687744, 297.408600, 312.124817, 0.054958,35, 0)
	Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Udalo:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Olum:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,41268)
	Udalo:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,41269)
	Olum:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,41269)
	Unit:RegisterEvent("Akama_DoorBreak", 7000, 1)
end

function Akama_DoorBreak(Unit,Event)
local Udalo = Unit:GetCreatureNearestCoords(23410,X,Y,Z)
local Olum = Unit:GetCreatureNearestCoords(23411,X,Y,Z)
local Door = Unit:GetCreatureNearestCoords(771.5, 304.7, 319, 3.10568,30001)
	Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Udalo:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Olum:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,10390)
	Udalo:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,0)
	Olum:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,0)
	RegisterEvent("Akama_STOP", 000, 1)
	RegisterEvent("Akama_Say2Friends", 3000, 1)
end

function Akama_STOP(Unit,Event)
	Unit:SetUInt64Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Door:GetGUID())
	Unit:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,0)
end

function Akama_Say2Friends(Unit,Event)
	--Unit:Emote(EMOTE_ONESHOT_SALUTE)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"I thank you for your aid, my brothers. Our people will be redeemed!!")
	Unit:RegisterEvent("Akama_MoveToIllidanAfterEvent", 3000, 1)
end

function Akama_MoveToIllidanAfterEvent(Unit,Event)
	Unit:MoveTo(771.809753, 303.744873, 313.563507, 6.265894)
	Unit:RegisterEvent("Akama_Move9", 2000, 1)
end

function Akama_Move9(Unit,Event)
	Unit:MoveTo(778.550232, 304.515198, 318.818542, 0.002354)
	Unit:RegisterEvent("Akama_Move10", 2000, 1)
end

function Akama_Move10(Unit,Event)
	Unit:MoveTo(789.564697, 304.493652, 319.759583, 6.248631)
	Unit:RegisterEvent("Akama_Move11", 1000, 1)
end

function Akama_Move11(Unit,Event)
	Unit:MoveTo(799.598389, 295.776642, 319.760040, 4.687257)
	Unit:RegisterEvent("Akama_Move12", 2000, 1)
end

function Akama_Move12(Unit,Event)
	Unit:MoveTo(799.054016, 288.826660, 320.030334, 4.563174)
	Unit:RegisterEvent("Akama_Move13", 4000, 1)
end

function Akama_Move13(Unit,Event)
	Unit:MoveTo(794.595459, 262.302856, 341.463715, 4.500343)
	Unit:RegisterEvent("Akama_Move14", 4000, 1)
end

function Akama_Move14(Unit,Event)
	Unit:MoveTo(794.396973, 256.420471, 341.463715, 4.557680)
	Unit:RegisterEvent("Akama_Move15", 4000, 1)
end

function Akama_Move15(Unit,Event)
	Unit:MoveTo(783.355957, 250.460892, 341.463776, 3.746361)
	Unit:RegisterEvent("Akama_Move16", 4000, 1)
end

function Akama_Move16(Unit,Event)
	Unit:MoveTo(764.988098, 238.561462, 353.646484, 3.324606)
	Unit:RegisterEvent("Akama_Move17", 4000, 1)
end

function Akama_Move17(Unit,Event)
	Unit:MoveTo(749.337463, 236.288681, 352.997223, 1.633631)
	Unit:RegisterEvent("Akama_RespawnGossip", 3000, 1)
end

function Akama_RespawnGossip(Unit,Event)
local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
	Unit:Despawn(0,1)
	Unit:SpawnCreature(229902,X,Y,Z,35,0)
end
-- Once again we need this...I hate GossipEvent...
function Akama2_OnGossipTalk(Unit, event, player, Misc)
	Unit:GossipCreateMenu(50, player, 0)
	Unit:GossipMenuAddItem(0, "We're ready to face Illidan.", 1, 0)
	Unit:ModifyWalkSpeed(10)
	Unit:GossipSendMenu(player)
end

function Akama2_OnGossipSelect(Unit, event, player, id, intid, code, Misc)
if (intid == 1) then
local X,Y,Z,O = Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
	Unit:SpawnCreature(229903,X,Y,Z,O,35,0)
	Unit:Despawn(0,0)
end
end

RegisterUnitGossipEvent(229902, 1, "Akama2_OnGossipTalk")
RegisterUnitGossipEvent(229902, 2, "Akama2_OnGossipSelect")

function Akama_RespawnAgain2(Unit,Event)
	Unit:MoveTo(751.941528, 304.626221, 352.996124, 3.128243)
	Unit:RegisterEvent("Akama_Begin", 4000, 1)
end

RegisterUnitEvent(229903, 18, "Akama_RespawnAgain2")

function Akama_Begin(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local illidan = Unit:GetCreatureNearestCoords(229170,695.806, 306.433, 354.26)
	Unit:SpawnGameobject(200000,745.07, 241.802, 354.292, 0.79225,0)
	Unit:SpawnGameobject(200001,744.829, 369.276, 354.324, 2.35855,0)
 if illidan:IsAlive() == True then
	Unit:SetFacing(3.126680)
	illidan:RemoveAura(39656)
	illidan:Emote(EMOTE_ONESHOT_QUESTION)
	illidan:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"Akama... your duplicity is hardly surprising. I should have slaughtered you and your malformed brethren long ago.")
	illidan:PlaySoundToSet(1146)
	Unit:RegisterEvent("Akama_TalkBack1", 10000, 1)
	else
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"Not this time my friends.")
	Unit:Despawn(0,0)
end
end

function Akama_TalkBack1(Unit,Event)
	--Unit:Emote(EMOTE_ONESHOT_POINT)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"We've come to end your reign, Illidan. My people and all of Outland shall be free!")
	Unit:RegisterEvent("Akama_IllidanTalkBack1", 8000, 1)
	Unit:RegisterEvent("Akama_Emote2", 3000, 1)
	Unit:RegisterEvent("Akama_Emote3", 6000, 1)
end

function Akama_Emote2(Unit,Event)
	--Unit:Emote(EMOTE_ONESHOT_TALK)
end

function Akama_Emote3(Unit,Event)
	Emote(EMOTE_ONESHOT_SALUTE)
end

function Akama_IllidanTalkBack1(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local illidan = Unit:GetCreatureNearestCoords(229170,X,Y,Z)
	illidan:Emote(EMOTE_ONESHOT_QUESTION)
	illidan:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"Boldly said. But I remain unconvinced.")
	illidan:PlaySoudnToSet(11464)
	Unit:RegisterEvent("Akama_TalkBack2", 3000, 1)
end

function Akama_TalkBack2(Unit,Event)
local X,Y,Z = Unit:GetX(),Unit:GetY(),Unit:GetZ()
local illidan = Unit:GetCreatureNearestCoords(229170,X,Y,Z)
local illiX,illiY,illiZ = illidan:GetX(),illidan:GetY(),illidan:GetZ()
	Unit:MoveTo(illiX,illiY,illiZ)
	Unit:SetNextTarget(illdian)
	Emote(EMOTE_ONESHOT_SHOUT)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"The time has come! The moment is at hand!")
	Unit:PlaySoundToSet(11380)
	Unit:SetUInt32Value(UnitField.UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_READY1H)
end

-- [[ Udalo and Olum ]] --
-- [[ Status : Completed ]] --
function Udalo_OnSpawn(Unit,Event)
	Unit:StopMovement(1)
	Unit:RegisterEvent("Udalo_Say", 3000, 1)
end

function Udalo_Say(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"You are not alone, Akama.")
	Unit:RegisterEvent("Udalo_Despawn", 15000, 1)
	Unit:RegisterEvent("Udalo_Salute", 13000, 1)
end

function Udalo_Salute(Unit,Event)
	--Unit:Emote(EMOTE_ONESHOT_SALUTE)
end

function Udalo_Despawn(Unit,Event)
	Unit:Despawn(11000,0)
end

function Olum_OnSpawn(Unit,Event)
	Unit:StopMovement(1)
	Unit:RegisterEvent("Olum_Say", 5500, 1)
end

function Olum_Say(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"Your people will always be with you.")
	Unit:RegisterEvent("Olum_Despawn", 15000, 1)
	Unit:RegisterEvent("Olum_Salute", 13000, 1)
end

function Olum_Salute(Unit,Event)
	--Unit:Emote(EMOTE_ONESHOT_SALUTE)
end

function Olum_Despawn(Unit,Event)
	Unit:Despawn(11000,0)
end

RegisterUnitEvent(UdaloSpawnID, 18, "Udalo_OnSpawn")
RegisterUnitEvent(OlumSpawnID, 18, "Olum_OnSpawn")