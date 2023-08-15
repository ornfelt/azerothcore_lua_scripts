--[[ Boss -- Prince Keleseth.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, October 26, 2008. ]]
-- I think that i should link skeletons after the whole link die new link respawns, that will save both server's memory and script's functionality 
	
function Keleseth_OnEnterCombat(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Your blood is mine!")
	Unit:RegisterEvent("Keleseth_ShadowBolt",3000, 0) 
	Unit:RegisterEvent("Keleseth_Summon",15000, 0) -- this is incorrect, i will handle this after i get some time
	Unit:RegisterEvent("Keleseth_FrostTomb",20000, 0)
end

function Keleseth_ShadowBolt(Unit,Event)
	Unit:FullCastSpellOnTarget(43667,Unit:GetRandomPlayer(0))
end

function Keleseth_FrostTomb(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Not so fast.")
	local plr =	Unit:GetRandomPlayer(0)
	if(type(plr) == "userdata") then
		Unit:FullCastSpellOnTarget(48400,Unit:GetRandomPlayer(0))
	end
end
-- if someone can help me here, i think this spell can be scripted via lua, the player with this debuff should not move, like dummy applied on player witch haves HP ofc.

function Keleseth_Summon(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Aranal, lidel! Their fate shall be yours!")
	local x,y,z,o =	Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO()
	Unit:SpawnCreature(23970 , x, y, z, o, 14, 60000)
	Unit:SpawnCreature(23970 , x, y, z, o, 14, 60000)
	Unit:SpawnCreature(23970 , x, y, z, o, 14, 60000)
	Unit:SpawnCreature(23970 , x, y, z, o, 14, 60000)
	Unit:SpawnCreature(23970 , x, y, z, o, 14, 60000)
end 

-- should be rise emote

function Keleseth_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()	
end

function Keleseth_OnDied(Unit, event, player)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I join... the night.")
	Unit:RemoveEvents()
end

RegisterUnitEvent(23953, 1, "Keleseth_OnEnterCombat")
RegisterUnitEvent(23953, 2, "Keleseth_OnLeaveCombat")
RegisterUnitEvent(23953, 4, "Keleseth_OnDied")