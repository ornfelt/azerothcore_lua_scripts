--[[ Boss -- Grand Magus Telestra.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 23, 2009. ]]
-- Will add sound later.

function GrandMagusTelestra_OnEnterCombat(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You know what they say about curiosity.")
	Unit:RegisterEvent("GrandMagusTelestra_IceNova", 14000, 0)
	Unit:RegisterEvent("GrandMagusTelestra_GravityWell", 22000, 0)
	Unit:RegisterEvent("GrandMagusTelestra_Phase2Move", 1000, 1)
end

function GrandMagusTelestra_Phase2Move(Unit,Event)
if	Unit:GetHealthPct() <= 50 then
	Unit:RemoveEvents()
local X,Y,Z =	Unit:GetX(),Unit:GetY(),Unit:GetZ()
	Unit:MoveTo(504.922577, 89.081749, -16.124632,-6)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatSpellCapable(1)
	Unit:RegisterEvent("GrandMagusTelestra_Phase2Start", 3000, 1)
end
end

function GrandMagusTelestra_Phase2Start(Unit,Event)
 if	Unit:GetHealthPct() <= 49 then
	Unit:RemoveEvents()
	Unit:CancelSpell()
local Choice = math.random(1,2)
if Choice == 1 then
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"There's plenty of me to go around.")
end
if Choice == 2 then
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I'll give you more than you can handle.")
end
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatSpellCapable(1)
	Unit:CastSpell(10032) -- Hacky way to...Disappear.
	Unit:SpawnCreature(26928,X,Y,Z,6,16,0) -- Flame, Left
	Unit:SpawnCreature(26929,X,Y,Z,6,16,0) -- Arcane, Middle
	Unit:SpawnCreature(26930,X,Y,Z,6,16,0) -- Frost, Right
	Unit:RegisterEvent("GrandMagusTelestra_Merge", 1000, 1)
end
end

function GrandMagusTelestra_Merge(Unit,Event)
		local X,Y,Z =	Unit:GetX(),Unit:GetY(),Unit:GetZ()
		local Flame =	Unit:GetCreatureNearestCoords(X,Y,Z,26928)
		local Arcane =	Unit:GetCreatureNearestCoords(X,Y,Z,26929)
		local Frost =	Unit:GetCreatureNearestCoords(X,Y,Z,26930)
 if Flame:IsDead() == 1 and Arcane:IsDead() == 1 and Frost:IsDead() == 1 then 
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Now to finish the job!")
	Unit:SetCombatMeleeCapable(0)
	Unit:SetCombatSpellCapable(0)
	else
	Unit:RegisterEvent("GrandMagusTelestra_Merge", 1000, 0)
end
end

function GrandMagusTelestra_IceNova(Unit,Event)
local Z =	Unit:GetZ()
local O =	Unit:GetO()
	Unit:FullCastSpell(47772)
	Unit:MoveTo(495.507, 89.091263,Z,O)
	Unit:RegisterEvent("GrandMagusTelestra_Firebomb", 3000, 0)
end

function GrandMagusTelestra_Firebomb(Unit,Event)
local tank =	Unit:GetMainTank()
local plr =	Unit:GetClosestPlayer()
Unit:FullCastSpellOnTarget(47773,tank)
 if tank == nil then
	Unit:FullCastSpellOnTarget(47773,plr)
 if plr == nil then
	return
end
end
end

function GrandMagusTelestra_GravityWell(Unit,Event)
local tank =	Unit:GetMainTank()
local plr =	Unit:GetClosestPlayer()
if plr == nil and tank == nil then
	return
	else
	Unit:RemoveEvents()
	Unit:SetCombatMeleeCapable(1)
	Unit:CastSpell(47756)
	Unit:RegisterEvent("GrandMagusTelestra_ReCast", 6000, 1)
	Unit:RegisterEvent("GrandMagusTelestra_KnockRepeat", 000, 0)
 end
end

function GrandMagusTelestra_KnockRepeat(Unit,Event)
	Unit:Knockback()
end

function GrandMagusTelestra_ReCast(Unit,Event)
	Unit:SetCombatMeleeCapable(0)
	Unit:RegisterEvent("GrandMagusTelestra_IceNova", 14000, 0)
	Unit:RegisterEvent("GrandMagusTelestra_GravityWell", 22000, 0)
	Unit:RegisterEvent("GrandMagusTelestra_Phase2Move", 1000, 1)
end

function GrandMagusTelestra_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function GrandMagusTelestra_OnKill(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Death becomes you!")
	Unit:RemoveEvents()
end

function GrandMagusTelestra_OnDied(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Damn the... luck. ")
	Unit:RemoveEvents()
end

-- Flame
function GrandMagusTelestraFLAME_OnSpawn(Unit,Event)
	Unit:CastSpell(47705) -- Visual
end
-- Arcane
function GrandMagusTelestraARCANE_OnSpawn(Unit,Event)
	Unit:CastSpell(47704) -- Visual
end
-- Frost
function GrandMagusTelestraFROST_OnSpawn(Unit,Event)
	Unit:CastSpell(47706) -- Visual
end

RegisterUnitEvent(26731, 1, "GrandMagusTelestra_OnEnterCombat")
RegisterUnitEvent(26731, 2, "GrandMagusTelestra_OnLeaveCombat")
RegisterUnitEvent(26731, 3, "GrandMagusTelestra_OnKill")
RegisterUnitEvent(26731, 4, "GrandMagusTelestra_OnDied")
RegisterUnitEvent(26928, 18, "GrandMagusTelestraFLAME_OnSpawn")
RegisterUnitEvent(26929, 18, "GrandMagusTelestraARCANE_OnSpawn")
RegisterUnitEvent(26930, 18, "GrandMagusTelestraFROST_OnSpawn")