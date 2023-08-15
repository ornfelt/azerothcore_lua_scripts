--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, March 17, 2009. ]]

function Nova_OnSpawn(Unit,Event)
local EmoteRandom = math.random(1,3)
local RegText = math.random(1,4)
local SayRandom = math.random(1,3)
	Unit:RegisterEvent("Nova_SummonCat", 48000, 0)
 if RegText == 1 then
	Unit:RegisterEvent("Nova_Text", 21000, 0)
 if RegText == 2 then
	Unit:RegisterEvent("Nova_Text", 24000, 0)
 if RegText == 3 then
	Unit:RegisterEvent("Nova_Text", 35000, 0)
 if RegText == 4 then
	Unit:RegisterEvent("Nova_Text", 48000, 0)
end
end
end
end
end

function Nova_Text(Unit,Event)
Unit:RegisterEvent("Nova_Talk", 2000, 1)
 if EmoteRandom == 1 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_EMOTE,LangField.LANG_UNIVERSAL,"Nova shakes the dirt loose from the shell.")
 elseif EmoteRandom == 2 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_EMOTE,LangField.LANG_UNIVERSAL,"Nova holds a sea shell up to her ear.")
 elseif EmoteRandom == 3 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_EMOTE,LangField.LANG_UNIVERSAL,"Nova picks up a sea shell.")
end
end


function Nova_Talk(Unit,Event)
	Unit:RemoveEvents()
	Unit:RegisterEvent("Nova_OnSpawn", 000, 0)
 if SayRandom == 1 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_THELASSIAN,"I think I can see the Sunwell from here!")
 elseif SayRandom == 2 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_THELASSIAN,"Oooh! Look, a shiny one!")
 elseif SayRandom == 3 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_THELASSIAN,"Can you really hear the ocean from one of these shells?")
end
end

function Nova_SummonCat(Unit,Event)
	Unit:CastSpell(35052)
end

function Nova_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

function Nova_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(20244, 18, "Nova_OnSpawn")
RegisterUnitEvent(20244, 2, "Nova_OnLeaveCombat")
RegisterUnitEvent(20244, 3, "Nova_OnDied")