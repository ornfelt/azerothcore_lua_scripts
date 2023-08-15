--[[ Boss -- King Ymiron.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, October 26, 2008. ]]
-- Not finished

-- Defines
local KY = 26861
local DarkSlash = 48292
local Bane = 48294
local FetidRot = 48291
local ScreamDead = 51750
local SpiritBurst = 48529
local SpiritStrike = 48423
local CHAT_MSG_MONSTER_YELL = 14 
local LANG_UNIVERSAL = 0

-- Script
function KY_EnterCombat(pUnit, Event)
	pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "You invade my home and then dare to challenge me? I will tear the hearts from your chests and offer them as gifts to the death god! Rualg nja gaborr! ")
	pUnit:RegisterEvent("DarkSlash",5000, 0) 
	pUnit:RegisterEvent("Bane",25000, 2) 
	pUnit:RegisterEvent("FetidRot",9000, 0) 
	pUnit:RegisterEvent("ScreamDead",40000, 2) 
	pUnit:RegisterEvent("SpiritBurst", 6000, 0)
	pUnit:RegisterEvent("SpiritStrike", 2000, 0)
end

function DarkSlash(pUnit,Event)
	pUnit:FullCastSpellOnTarget(DarkSlash,pUnit:GetClosestPlayer())
end

function FetidRot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(FetidRot,pUnit:GetRandomPlayer(0))
end

function ScreamDead(pUnit,Event)
	pUnit:FullCastSpell(ScreamDead)
end

function Bane(pUnit,Event)
	pUnit:FullCastSpell(Bane)
end

function SpiritStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(SpiritStrike,pUnit:GetRandomPlayer(0))
end
	
function SpiritBurst(pUnit,Event)  -- Its AOE? --
	pUnit:FullCastSpell(SpiritBurst)
end



function KY_OnKill(pUnit,Event)
	local Choice=math.random(1, 4)
		if Choice==1 then
			pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "Your death is only the beginning! ")
		elseif Choice==2 then
			pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "You have failed your people! ")
		elseif Choice==3 then
			pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "There is a reason I am king! ")
		elseif Choice==4 then
			pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "Bleed no more! ")
end
end

function KY_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function KY_OnDied(pUnit, event, player)
	pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "What... awaits me... now?")
	pUnit:RemoveEvents()
end

-- Registers
RegisterUnitEvent(KY, 1, "KY_EnterCombat")
RegisterUnitEvent(KY, 2, "KY_OnLeaveCombat")
RegisterUnitEvent(KY, 4, "KY_OnDied")
RegisterUnitEvent(KY, 3, "KY_OnKill")