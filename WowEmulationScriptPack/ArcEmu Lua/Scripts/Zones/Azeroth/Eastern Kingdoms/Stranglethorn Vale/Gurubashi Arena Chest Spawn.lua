--[[ Gurubashi Arena Chest Spawn.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 21, 2009. ]]
-- Thank you Bapes for orignally creating this<3
-- I just updated this.

function GurubashiArena_OnSpawn(Unit,Event)
	Unit:RegisterEvent("GurubashiArenaChest_SpawnChest", 10800000, 0) -- 3 Hours = Spawn Chest.
end

function GurubashiArenaChest_SpawnChest(Unit,Event)
	Unit:SpawnGameObject(179697, -13203.203125, 277.170868, 21.857513, 4.189312, 10800000)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"Arrr, Me Hearties! I be havin' some extra Treasure that i be givin' away at the Gurubashi Arena! All ye need to do is collect it is open the chest I leave on the arena floor!")
end

RegisterUnitEvent(14508, 18, "GurubashiArena_OnSpawn")